//
//  FileListViewController.swift
//  FileViewerSample
//
//  Created by Proteinman on 2017/11/29.
//  Copyright © 2017年 Proteinman. All rights reserved.
//

import UIKit

class FileListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private let url: URL
    private let fileFetcher: FileFetcher
    private var files: [File]?
    init(url: URL) {
        self.url = url
        self.fileFetcher = FileFetcher(url: url)
        super.init(nibName: "FileListViewController", bundle: .main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "FileListTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "FileListTableViewCell")
        
        files = fileFetcher.fetch()
    }
}

extension FileListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let files = files, indexPath.item + 1 <= files.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FileListTableViewCell",
                                                     for: indexPath) as! FileListTableViewCell
            cell.setup(file: files[indexPath.item])
            return cell
        }
        
        return UITableViewCell()
    }
}

extension FileListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let files = files, indexPath.item + 1 <= files.count {
            let file = files[indexPath.item]
            if file.isDirectory {
                let vc = FileListViewController(url: file.url)
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

