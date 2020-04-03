//
//  MessageCell.swift
//  FirebaseChatApp
//
//  Created by Felipe Amorim Bastos on 03/04/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet var lblMessage: UILabel?
    
    func loadUI(item: Message) {
        lblMessage?.text = item.text
    }
}
