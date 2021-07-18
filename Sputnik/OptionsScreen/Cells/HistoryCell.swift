//
//  HistoryCell.swift
//  ThallesBrowser
//
//  Created by Thalles Araújo on 25/10/20.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    @IBOutlet weak var siteIcon: UIImageView!
    @IBOutlet weak var siteName: UILabel!
    @IBOutlet weak var siteUrl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
