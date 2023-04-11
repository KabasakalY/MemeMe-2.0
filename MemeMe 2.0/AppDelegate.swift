//
//  AppDelegate.swift
//  MemeMe 1.0
//
//  Created by Yıldıray Kabasakal on 26.02.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var memes = [Meme(topText: "I'M ON A SEAFOOD DIET", bottomText: "I SEE FOOD AND I EAT IT", originalImage: UIImage(), editedImage: UIImage(named: "meme1")!),
                 Meme(topText: "WHEN YOU THINK YOU BEEN WORKING FOR 4 HOURS", bottomText: "AND IT'S ONLY BEEN", originalImage: UIImage(), editedImage: UIImage(named: "meme2")!),
                 Meme(topText: "WHAT ARE MEMES", bottomText: "AND HOW TO USE THEM", originalImage: UIImage(), editedImage: UIImage(named: "meme3")!),
                 Meme(topText: "IT TOOK YOU 15 MINUTES TO GET HOME", bottomText: "GOOGLE MAPS SAID IT TAKES 12. WHO IS SHE?", originalImage: UIImage(), editedImage: UIImage(named: "meme4")!),
                 Meme(topText: "AND THEN I SAID", bottomText: "I COMPLETELY UNDERSTAND YOUR FRUSTRATION", originalImage: UIImage(), editedImage: UIImage(named: "meme5")!)
    ]
   
    //let meme1 = Meme(topText: "I'M ON A SEAFOOD DIET", bottomText: "I SEE FOOD AND I EAT IT", originalImage: UIImage(), editedImage: UIImage(named: "meme1")!)
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

