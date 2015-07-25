//
//  playlistTableViewCell.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/14.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import UIKit

class playlistTableViewCell: UITableViewCell {

    @IBOutlet var ChildLikeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tagLabel: UILabel!
    
}
