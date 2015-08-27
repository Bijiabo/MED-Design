//
//  DownloadListTableViewCell.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/8/28.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import UIKit

class DownloadListTableViewCell: UITableViewCell {

    @IBOutlet var titleTextLabel: UILabel!
    @IBOutlet var descriptionTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
