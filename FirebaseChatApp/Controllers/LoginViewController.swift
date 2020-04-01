//
//  ViewController.swift
//  FirebaseChatApp
//
//  Created by Felipe Amorim Bastos on 18/03/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit
import Firebase
import RKDropdownAlert

class LoginViewController: UIViewController {
    
    @IBOutlet var txtEmail: UITextField?
    @IBOutlet var txtPassword: UITextField?
    @IBOutlet var btnSignIn: UIButton?
    @IBOutlet var btnRegister: UIButton?
    @IBOutlet var vwContentView: UIView?
    
    
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
    
    func configUI() {
        
        if UserDefaults.standard.bool(forKey: "is_authenticated") {
            self.showHome()
        }
        
        self.hideKeyboardWhenTappedAround()
        
        guard let email = txtEmail, let password = txtPassword else {return}
        
        Util.tintPlaceholder(field: email, color: .white)
        Util.tintPlaceholder(field: password, color: .white)
        
        txtEmail?.keyboardAppearance = .dark
        txtPassword?.keyboardAppearance = .dark
        
    }
    
    @IBAction func makeLogin() {
        
        guard let email = txtEmail?.text, let password = txtPassword?.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                Util.showMessage(text: "\(error?.localizedDescription ?? "")", type: .warning)
                return
            }
            
            self.stayLogged()
            self.showHome()
        }
    }
    
    func stayLogged() {
        UserDefaults.standard.set(true, forKey: "is_authenticated")
        UserDefaults.standard.synchronize()
    }
    
    func showHome() {
        let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeView") as! HomeViewController
        self.present(homeVC, animated: true, completion: nil)
    }
    
    @IBAction func openRegister() {
        
        let registerVC = storyboard?.instantiateViewController(identifier: "RegisterView") as! RegisterViewController
        
        present(registerVC, animated: true, completion: nil)
    }
}



