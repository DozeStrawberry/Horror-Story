//
//  OverViewTableViewCell.swift
//  HorrorStory
//
//  Created by liu ya yun on 2022/12/5.
//

import UIKit

class OverViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var channelImage: UIImageView!
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var sortLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


