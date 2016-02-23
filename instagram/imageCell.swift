//
//  imageCell.swift
//  instagram
//
//  Created by Archit Rathi on 2/22/16.
//  Copyright © 2016 Archit Rathi. All rights reserved.
//

import UIKit

class imageCell: UITableViewCell {

   
    @IBOutlet weak var im: UIImageView!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var userName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
