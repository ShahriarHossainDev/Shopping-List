//
//  ListTableViewCell.swift
//  Shopping List
//
//  Created by Shishir_Mac on 12/3/23.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkMarkButton: UIButton!
    
    var isMarked = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    struct Todo{
        var isMarked : Bool
    }

    
}
