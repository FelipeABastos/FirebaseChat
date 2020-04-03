//
//  Message.swift
//  FirebaseChatApp
//
//  Created by Felipe Amorim Bastos on 03/04/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit

class Message: NSObject {
    
    @objc var fromId: String?
    @objc var text: String?
    @objc var timestamp: NSNumber?
    @objc var toID: String?
}
