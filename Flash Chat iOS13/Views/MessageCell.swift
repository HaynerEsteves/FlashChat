//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Hayner Esteves on 29/08/23.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

//this was created with cocoa touch file, marking the .xib tag. what you create here is going to be the cell repited (reusable) on the tableView.
class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBuble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    //this code will be execured everytime the cell is called
    override func awakeFromNib() {
        //code that is executed every time thare is a new cell call on the table view
        super.awakeFromNib()
        messageBuble.layer.cornerRadius = messageBuble.frame.height/5 //making the edges round / must be 5 for it to be round
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
