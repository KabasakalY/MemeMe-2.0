//
//  ViewController.swift
//  MemeMe 1.0
//
//  Created by Yıldıray Kabasakal on 26.02.2023.
//

import UIKit

class MemeEditorViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate{

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topNavigationBar: UINavigationBar!
    @IBOutlet weak var bottomNavigationBar: UINavigationBar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    let picker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topTextField.delegate = self
        bottomTextField.delegate = self
        prepareTextField(topTextField,defaultText: "TOP")
        prepareTextField(bottomTextField,defaultText: "BOTTOM")
        configureUI()
     
        #if targetEnvironment(simulator)
        cameraButton.isEnabled = false
        #else
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        #endif
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    @IBAction func pickImageFromCamera(_ sender: UIButton) {
        
        
        
        pickImage(UIImagePickerController.SourceType.camera)
  
    }
    
    
    @IBAction func pickImageFromGallery(_ sender: UIButton) {
//
        pickImage(UIImagePickerController.SourceType.photoLibrary)
        
    }
    
    
    func pickImage(_ sourceType: UIImagePickerController.SourceType){
        picker.sourceType = sourceType
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        pickedImage.image = image
        dismiss(animated: true)
        shareButton.isEnabled = true
        cancelButton.isEnabled = true
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    // This makes textfields blank when user taps them.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    // This makes keyboard get lost when we press return.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    // I think there is a problem here. If user taps top and then bottom textfield, screen shifts up or vice versa. But i don't know how to solve this right now. Maybe adding a delay to keyboardWillHide can solve this.
    
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_: )), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    @objc func keyboardWillShow(_ notification:Notification){
        if bottomTextField.isFirstResponder{
            view.frame.origin.y = -getKeyBoardHeight(notification)
        }
        
    }
    
    func getKeyBoardHeight(_ notification: Notification) -> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        
        view.frame.origin.y = 0
    }
    
    
    @IBAction func cancelMeme(_ sender: UIBarButtonItem) {
        //go back to initial state.
        configureUI()
        
    }
    
    
    @IBAction func shareMeme(_ sender: UIBarButtonItem) {
        let meme = save()
        let ac = UIActivityViewController(activityItems: [meme.editedImage], applicationActivities: [])
        
        ac.completionWithItemsHandler = {(activity, completed, items, error) in
                 if (completed) {
                     print("saved!")
                     self.saveMemeToSharedModel(meme: meme)
                 }
        }
        present(ac, animated: true)
        
        
        //since i can't share the meme by using simulator, i can't controll if it works.
        
        
        
    }
    
    func save()->Meme{
        let memedImage = generateMemedImage()
        let meme = Meme(topText: topTextField.text, bottomText: bottomTextField.text, originalImage: pickedImage.image, editedImage: memedImage)
        return meme
        
    }
    func saveMemeToSharedModel(meme:Meme){
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        print("saved to AppDelegate")
    }
    
    func generateMemedImage() -> UIImage{
        // hide navigation bars before taking photo.
        topNavigationBar.isHidden = true
        bottomNavigationBar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // navigation bars are not hidden anymore!
        topNavigationBar.isHidden = false
        bottomNavigationBar.isHidden = false
        
        return memedImage
    }
    
    
    // textfield text attributes.
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name:"HelveticaNeue-CondensedBlack", size:40)!,
        NSAttributedString.Key.strokeWidth: NSNumber(-3.5)
        
    ]
    
    // this function configures uibuttons.
    func configureUI(){
        pickedImage.image = nil
        //cancelButton.isEnabled = false
        shareButton.isEnabled = false    }
    
    func prepareTextField(_ textField:UITextField, defaultText:String){
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.text = defaultText
        textField.textAlignment = .center
    }
    
}

