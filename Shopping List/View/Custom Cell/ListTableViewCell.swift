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
        if isMarked{
            self.checkMarkButton.setImage(UIImage(named: "marked"), for: .normal)
            
        }
        else{
            self.checkMarkButton.setImage(UIImage(named: "unmarked"), for: .normal)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Cell Configuration
    
    func configurateTheCell(_ tasks: Tasks) {
        titleLabel.text = tasks.title
        isMarked = tasks.taskDone
    }
}

struct Todo{
    var isMarked : Bool
}
