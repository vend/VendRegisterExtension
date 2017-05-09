//
//  LineItemCell.swift
//  VendRegisterExtension
//
//  Created by Thomas Carey on 9/05/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class LineItemCell: UITableViewCell {
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
