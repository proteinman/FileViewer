//
//  FileFetcher.swift
//  FileViewerSample
//
//  Created by Proteinman on 2017/11/28.
//  Copyright © 2017年 Proteinman. All rights reserved.
//

import Foundation

final class FileFetcher {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func fetch() -> [File]? {
        guard let contentURLs = contentsOfDirectory(at: url) else {
            return nil
        }
        
        var files = [File]()
        contentURLs.forEach {
            guard let resourceValues = resourceValues(url: $0),
                let name = resourceValues.name,
                let isDirectory = resourceValues.isDirectory else {
                    return
            }
            
            var itemSize: Double = 0.0
            if isDirectory {
                itemSize = directorySize(at: $0)
            } else {
                if let size = resourceValues.totalFileSize {
                    itemSize =  Double(size)
                }
            }
            
            let file = File(url: $0,
                            name: name,
                            isDirectory: isDirectory,
                            size: itemSize)
            files.append(file)
        }
        
        return files
    }
    
    private let properties: [URLResourceKey] = [
        .nameKey,
        .isDirectoryKey,
        .totalFileSizeKey
    ]
    
    private func contentsOfDirectory(at url: URL) -> [URL]? {
        let fileManager = FileManager.default
        let path = url.path
        guard fileManager.fileExists(atPath: path) else {
            return nil
        }
        
        do {
            let urls = try fileManager.contentsOfDirectory(
                at: url,
                includingPropertiesForKeys: properties,
                options: .skipsSubdirectoryDescendants
            )
            return urls
        } catch {
            return nil
        }
    }
    
    private func resourceValues(url: URL) -> URLResourceValues? {
        do {
            let resourceValues = try url.resourceValues(forKeys: Set(properties))
            return resourceValues
            
        } catch {
            return nil
        }
    }
    
    private func directorySize(at url: URL) -> Double {
        guard let contentURLs = contentsOfDirectory(at: url) else {
            return 0.0
        }
        
        var size = 0.0
        
        contentURLs.forEach {
            guard let resourceValues = resourceValues(url: $0),
                let isDirectory = resourceValues.isDirectory else {
                    return
            }
            
            if isDirectory {
                size += directorySize(at: $0)
            } else {
                if let itemSize = resourceValues.totalFileSize {
                    size += Double(itemSize)
                }
            }
        }
        
        return size
    }
}
