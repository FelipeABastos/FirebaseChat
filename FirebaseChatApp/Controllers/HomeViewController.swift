//
//  HomeViewController.swift
//  FirebaseChatApp
//
//  Created by Felipe Amorim Bastos on 24/03/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var lblUserName: UILabel?
    @IBOutlet var imgUserPhoto: UIImageView?
    @IBOutlet var tbMessages: UITableView?
    
    var messages = [Message]()
    
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
        checkIfUserIsLoggedIn()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    //-----------------------------------------------------------------------
    //    MARK: UITableView Delegate / Datasource
    //-----------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messagesList = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as! MessageCell
        cell.loadUI(item: messagesList)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //-----------------------------------------------------------------------
    //    MARK: Custom methods
    //-----------------------------------------------------------------------
    
    @IBAction func newMessage() {
        let messageVC = storyboard?.instantiateViewController(identifier: "MessageView") as! NewMessageViewController
        messageVC.homeVC = self
        present(messageVC, animated: true, completion: nil)
    }
    
    @IBAction func openChatForUser(user: User) {
        let chatVC = storyboard?.instantiateViewController(identifier: "ChatView") as! ChatViewController
        chatVC.user = user
        present(chatVC, animated: true, completion: nil)
    }
    
    @IBAction func logoutButton() {
        do {
            try Auth.auth().signOut()
            Util.showMessage(text: "Successfully logged out", type: .success)
            
            let loginVC = storyboard?.instantiateViewController(identifier: "LoginView") as! LoginViewController
            loginVC.modalPresentationStyle = .fullScreen
            
            present(loginVC, animated: true, completion: nil)
        }catch let logoutError {
            print(logoutError)
        }
    }
    
    func configUI() {
        
        observeMessages()
    }
    
    func observeMessages() {
        Database.database().reference().child("messages").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let message = Message()
                
                message.text = dictionary["text"] as? String
                message.fromId = dictionary["fromId"] as? String
                message.timestamp = dictionary["timestamp"] as? NSNumber
                message.toID = dictionary["toId"] as? String
                
                self.messages.append(message)
                
                DispatchQueue.main.async {
                    self.tbMessages?.reloadData()
                }
            }
        }, withCancel: nil)
    }
    
//    func observeMessages() {
//        let ref = Database.database().reference().child("messages")
//        ref.observeSingleEvent(of: .childAdded, with: { (snapshot) in
//
//            if let dictionary = snapshot.value as? [String: AnyObject] {
//                let message = Message()
//
//                message.text = dictionary["text"] as? String
//                message.fromId = dictionary["fromId"] as? String
//                message.timestamp = dictionary["timestamp"] as? NSNumber
//                message.toID = dictionary["toId"] as? String
//
//                self.messages.append(message)
//
//                DispatchQueue.main.async {
//                    self.tbMessages?.reloadData()
//                }
//            }
//        }, withCancel: nil)
//    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            performSelector(inBackground: #selector(handleLogout), with: nil)
            
            let loginVC = storyboard?.instantiateViewController(identifier: "LoginView") as! LoginViewController
            self.present(loginVC, animated: true, completion: nil)
        }else{
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                    
                if let dic = snapshot.value as? [String: Any] {
                    self.lblUserName?.text = dic["name"] as? String
                    self.imgUserPhoto?.kf.setImage(with: URL(string: dic["profileImageUrl"] as? String ?? ""))
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
    }
}
