//
//  UserCell.swift
//  FirebaseChatApp
//
//  Created by Felipe Amorim Bastos on 31/03/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit
import Kingfisher

class UserCell: UITableViewCell {
    
    @IBOutlet var imgPhoto: UIImageView?
    @IBOutlet var lblName: UILabel?
    @IBOutlet var lblEmail: UILabel?
    
    func loadUI(item: User) {
        
        lblName?.text = item.name
        lblEmail?.text = item.email
        
        if let profileImageUrl = item.profileImageUrl {
            imgPhoto?.kf.setImage(with: URL(string: profileImageUrl))
        }
    }
}
