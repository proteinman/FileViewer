//
//  FileListTableViewCell.swift
//  FileViewerSample
//
//  Created by Proteinman on 2017/11/29.
//  Copyright © 2017年 Proteinman. All rights reserved.
//

import UIKit

class FileListTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        sizeLabel.text = nil
    }
    
    func setup(file: File) {
        nameLabel.text = file.name
        sizeLabel.text = file.sizeString
        iconImage.image = UIImage(named: file.name)
        accessoryType = file.isDirectory ? .disclosureIndicator : .none
    }
}
