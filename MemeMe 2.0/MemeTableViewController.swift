//
//  memeTableViewController.swift
//  MemeMe 1.0
//
//  Created by Yıldıray Kabasakal on 4.04.2023.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes : [Meme] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(MemeCell.self, forCellReuseIdentifier: "MemeCell")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
        memes = appDelegate.memes
        refreshTableData()
    }
    
    func refreshTableData(){
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meme = memes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MemeCell
        cell.memelabel?.text = meme.topText
        //print(cell.memelabel)
        //cell.textLabel?.text = (memes[indexPath.row].topText ?? "") + (memes[indexPath.row].bottomText ?? "")
        //cell.imageView?.image = memes[indexPath.row].editedImage
        //print(cell.memeImage)
        cell.memeImage?.image = memes[indexPath.row].editedImage
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meme = memes[indexPath.row]
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        let editVC = storyboard.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        editVC.meme = meme
        navigationController?.pushViewController(editVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(140)
    }
    
    
    @IBAction func unwindToTabView(_ sender: UIStoryboardSegue){
        
    }
    
    func configureUI(){
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


