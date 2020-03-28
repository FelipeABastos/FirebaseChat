//
//  HomeViewController.swift
//  FirebaseChatApp
//
//  Created by Felipe Amorim Bastos on 24/03/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet var lblUserName: UILabel?
    @IBOutlet var btnAllMessages: UIButton?
    
    //-----------------------------------------------------------------------
    //    MARK: UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    //-----------------------------------------------------------------------
    //    MARK: Custom methods
    //-----------------------------------------------------------------------
    
    @IBAction func newMessage() {
        let messageVC = storyboard?.instantiateViewController(identifier: "MessageView") as! NewMessageViewController
        present(messageVC, animated: true, completion: nil)
    }
    
    @IBAction func logoutButton() {
        do {
            try Auth.auth().signOut()
            Util.showMessage(text: "Successfully logged out", type: .success)
        }catch let logoutError {
            print(logoutError)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func configUI() {
        checkIfUserIsLoggedIn()
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            performSelector(inBackground: #selector(handleLogout), with: nil)
            handleLogout()
        }else{
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                if let dic = snapshot.value as? [String: Any] {
                    self.lblUserName?.text = dic["name"] as? String
                }
                
                
            }, withCancel: nil)
        }
    }
    
    @objc func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        }catch let logoutError {
            print(logoutError)
        }
        
        let loginVC = LoginViewController()
        present(loginVC, animated: true, completion: nil)
    }
}
