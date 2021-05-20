//
//  MainViewControllerTableViewCell.swift
//  SimpleMemo
//
//  Created by 이문정 on 2021/05/19.
//

import UIKit

class MainViewControllerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableViewLabel: UILabel!
    @IBOutlet weak var tableViewDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
