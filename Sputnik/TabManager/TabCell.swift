//
//  TabCell.swift
//  ThallesBrowser
//
//  Created by Thalles Araújo on 06/12/20.
//

import UIKit

class TabCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var indexPath: IndexPath?
    
    var tab: Tab?
    
    var closeTabClosure: () -> Void = {}
    
    
    func configure(tab: Tab, indexPath: IndexPath){
        self.indexPath = indexPath
        var tabTitle = ""
        if let title = tab.webView.title, !title.isEmpty{
            tabTitle = title
        }else{
            //tabTitle = tab.url!.absoluteString
        }
        self.titleLabel.text = tabTitle
            
            
            
        
        
    }
    
    
    
    func defineAsCurrent(){
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
    func defineAsNonCurrent(){
        self.layer.borderWidth = 0
    }
    
    @IBAction func didTapCloseButton(_ sender: Any) {
        print("Closed!")
        self.closeTabClosure()
    }
    
}
