//
//  SearchClientTableViewCell.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 11/12/23.
//

import UIKit

class SearchClientTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDocument: UILabel!
    @IBOutlet weak var labelNameClient: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
