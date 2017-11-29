//
//  ViewController.swift
//  FileViewerSample
//
//  Created by Proteinman on 2017/11/28.
//  Copyright © 2017年 Proteinman. All rights reserved.
//

import UIKit
import FileBrowser

class ViewController: UIViewController {
    
    @IBAction func tapDocumentDirectoryButton(_ sender: Any) {
        guard let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let vc = FileListViewController(url: documentDirectoryURL)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapDocumentFileBrowserButton(_ sender: Any) {
        let fileBrowser = FileBrowser()
        present(fileBrowser, animated: true, completion: nil)
    }
}

