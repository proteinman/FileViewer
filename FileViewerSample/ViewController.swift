//
//  ViewController.swift
//  FileViewerSample
//
//  Created by Proteinman on 2017/11/28.
//  Copyright © 2017年 Proteinman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveDummyData()
    }
    
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
                                                     toPath: documentDirectoryURL.appendingPathComponent(imageName).path)
                        } catch {}
                        do {
                            try fileManager.copyItem(atPath: dummyImageURL.path,
                                                     toPath: imageDirectoryURL.appendingPathComponent(imageName).path)
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
                                                 toPath: documentDirectoryURL.appendingPathComponent(videoName).path)
                    } catch {
                    }
                }
            } catch {}
        }
    }
}

