//
//  File.swift
//  FileViewerSample
//
//  Created by Proteinman on 2017/11/28.
//  Copyright © 2017年 Proteinman. All rights reserved.
//

import Foundation

struct File {
    let name: String
    let isDirectory: Bool
    let size: Double
    
    var sizeString: String {
        return "\(floor(size / 1024 * 100) / 100)KB"
    }
}
