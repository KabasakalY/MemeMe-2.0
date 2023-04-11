//
//  EditViewController.swift
//  MemeMe 1.0
//
//  Created by Yıldıray Kabasakal on 9.04.2023.
//

import UIKit

class EditViewController: UIViewController {

    var meme: Meme! = nil
    @IBOutlet weak var editMemeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editMemeImage.image = meme.editedImage
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
