//
//  CustomCell1TableViewCell.swift
//  SimpleChatApp
//
//  Created by Lainel John Dela Cruz on 28/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit

class CustomCell1TableViewCell: UITableViewCell {

    @IBOutlet weak var UISenderTF: UILabel!
    @IBOutlet weak var UIMessageContent: UILabel!
    @IBOutlet weak var UIChatImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.UISenderTF.text="";
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func FlipChat(){
        self.UIChatImage.image=UIImage(named: "cbFilterN")
    }
    
}
