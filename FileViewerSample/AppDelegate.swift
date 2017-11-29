//
//  AppDelegate.swift
//  FileViewerSample
//
//  Created by Proteinman on 2017/11/28.
//  Copyright © 2017年 Proteinman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        saveDummyData()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    private func saveDummyData() {
        let fileManager = FileManager.default
        let resourceURL = Bundle.main.resourceURL
        guard let documentDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        // 画像ダミーデータを保存
        let imageDirectoryURL = documentDirectoryURL.appendingPathComponent("images")
        if !fileManager.fileExists(atPath: imageDirectoryURL.path) {
            do {
                try fileManager.createDirectory(atPath: imageDirectoryURL.path,
                                                withIntermediateDirectories: false,
                                                attributes: nil)
                for i in 1..<11 {
                    let imageName = "dummy_image\(i).jpg"
                    if let dummyImageURL = resourceURL?.appendingPathComponent(imageName) {
                        do {
                            try fileManager.copyItem(atPath: dummyImageURL.path,
                                                     toPath: imageDirectoryURL.appendingPathComponent(imageName).path)
                        } catch {}
                        do {
                            try fileManager.copyItem(atPath: dummyImageURL.path,
                                                     toPath: documentDirectoryURL.appendingPathComponent(imageName).path)
                        } catch {}
                    }
                }
            } catch {}
        }
        
        // 動画ダミーデータを保存
        let videoDirectoryURL = documentDirectoryURL.appendingPathComponent("video")
        if !fileManager.fileExists(atPath: videoDirectoryURL.path) {
            do {
                try fileManager.createDirectory(atPath: videoDirectoryURL.path,
                                                withIntermediateDirectories: false,
                                                attributes: nil)
                let videoName = "dummy_video1.mp4"
                if let dummyVideoURL = resourceURL?.appendingPathComponent(videoName) {
                    do {
                        try fileManager.copyItem(atPath: dummyVideoURL.path,
                                                 toPath: videoDirectoryURL.appendingPathComponent(videoName).path)
                    } catch {
                       print(error)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}
