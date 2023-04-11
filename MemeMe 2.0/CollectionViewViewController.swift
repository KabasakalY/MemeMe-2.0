//
//  CollectionViewViewController.swift
//  MemeMe 1.0
//
//  Created by Yıldıray Kabasakal on 9.04.2023.
//

import UIKit

class CollectionViewViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var memes = [Meme]()
    
    
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        configureUI()
        configureCollectionViewCells()
        memes = appDelegate.memes
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
        memes = appDelegate.memes
        configureUI()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MemeCollectionViewCell
        collectionCell.collectionImageView.image = memes[indexPath.row].editedImage
        
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let editVc = appStoryboard.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        editVc.meme = memes[indexPath.row]
        navigationController?.pushViewController(editVc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let collectionViewSize = collectionView.frame.size.width - padding

        return CGSize(width: collectionViewSize/4, height: collectionViewSize/4)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 1, bottom: 10, right: 1)
    }
   
    func configureUI(){
        tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func configureCollectionViewCells(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = flowLayout
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
