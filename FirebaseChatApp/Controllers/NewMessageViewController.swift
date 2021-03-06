//
//  NewMessageViewController.swift
//  FirebaseChatApp
//
//  Created by Felipe Amorim Bastos on 26/03/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit
import Firebase

class NewMessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let cellId = "CellID"
    
    var homeVC: HomeViewController?
    
    var users = [User]()
    
    @IBOutlet var tbMessages: UITableView?
    
    //-----------------------------------------------------------------------
    //    MARK: UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        fetchUser()
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
    //    MARK: UITableView Delegate / Datasource
    //-----------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = users[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        cell.imgPhoto?.image = UIImage(named: "profile")
        cell.loadUI(item: user)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.dismiss(animated: true, completion: nil)
        
        let user = self.users[indexPath.row]
        
        self.homeVC?.openChatForUser(user: user)
    }
    
    
    //-----------------------------------------------------------------------
    //    MARK: Custom methods
    //-----------------------------------------------------------------------
    
    func configUI() {
        
    }
    
    func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String:AnyObject] {
                let user = User()
                
                user.id = snapshot.key
                user.name = dictionary["name"] as? String
                user.email = dictionary["email"] as? String
                user.profileImageUrl = dictionary["profileImageUrl"] as? String
                self.users.append(user)
                
                DispatchQueue.main.async {
                    self.tbMessages?.reloadData()
                }
            }
        }, withCancel: nil)
    }
    
    @IBAction func backHome() {
        self.dismiss(animated: true, completion: nil)
    }
}
