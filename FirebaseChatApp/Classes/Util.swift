//
//  Util.swift
//  FirebaseChatApp
//
//  Created by Felipe Amorim Bastos on 18/03/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit
import RKDropdownAlert

class Util {
    
    static func tintPlaceholder(field: UITextField, color: UIColor) {
        if let placeholder = field.placeholder {
            field.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: color.withAlphaComponent(0.6)])
        }
    }
    
    static func showMessage(text: String, type: MessageType){
        
        var backgroundColor: UIColor!
        var textColor: UIColor!
        
        switch type {
            case .success:
                textColor = UIColor.white
                backgroundColor = UIColor(red:0.31, green:0.76, blue:0.07, alpha:1.0)
                break
            case .warning:
                textColor = UIColor.brown
                backgroundColor = UIColor(red:0.95, green:0.77, blue:0.06, alpha:1.0)
                break
            case .error:
                textColor = UIColor.white
                backgroundColor = UIColor.red
                break
            case .info:
                textColor = UIColor.white
                backgroundColor = UIColor.darkGray
                break
        }
        
        RKDropdownAlert.title(nil, message: text, backgroundColor: backgroundColor, textColor: textColor, time: 3)
        
    }

    enum MessageType {
        case success
        case warning
        case error
        case info
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

