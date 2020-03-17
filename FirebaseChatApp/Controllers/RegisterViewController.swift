//
//  RegisterViewController.swift
//  FirebaseChatApp
//
//  Created by Felipe Amorim Bastos on 18/03/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, ImagePickerDelegate {
    
    var imagePicker: ImagePicker!
    
    @IBOutlet var txtName: UITextField?
    @IBOutlet var txtEmail: UITextField?
    @IBOutlet var txtPassword: UITextField?
    @IBOutlet var btnRegister: UIButton?
    @IBOutlet var imgAvatar: UIImageView!
    
    @IBOutlet var vwName: UIView?
    @IBOutlet var vwEmail: UIView?
    @IBOutlet var vwPassword: UIView?
    
    //-----------------------------------------------------------------------
    //    MARK: UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
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
    
    func configUI() {
        
        Util.tintPlaceholder(field: txtName!, color: .white)
        Util.tintPlaceholder(field: txtEmail!, color: .white)
        Util.tintPlaceholder(field: txtPassword!, color: .white)
        
    }
    
    @IBAction func makeRegister() {
        
        guard let email = txtEmail?.text, let password = txtPassword?.text, let name = txtName?.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error ) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            // successfully authenticated
            
            let ref = Database.database().reference(fromURL: "https://fir-chat-5c19c.firebaseio.com/")
            
            guard let userID = Auth.auth().currentUser?.uid else { return }
            
            let usersReference = ref.child("users").child(userID)
            
            let values = ["name": name,
                          "email": email]
            
            usersReference.updateChildValues(values) { (err, ref) in
                
                if err != nil {
                    print(err ?? "")
                    return
                }
                
                print("Saved User Successfully into Firebase database")
            }
        }
    }
    
    @IBAction func backToLogin() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didSelect(image: UIImage?) {
        self.imgAvatar.image = image
    }
    
    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
}

