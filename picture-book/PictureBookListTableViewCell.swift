//
//  PictureBookListTableViewCell.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/8/23.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import UIKit

class PictureBookListTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var introduction: UITextView!
    @IBOutlet var pictureBookImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
