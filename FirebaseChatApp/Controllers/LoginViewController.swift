//
//  ViewController.swift
//  FirebaseChatApp
//
//  Created by Felipe Amorim Bastos on 18/03/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit

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
        
        self.hideKeyboardWhenTappedAround()
        
        Util.tintPlaceholder(field: txtEmail!, color: .white)
        Util.tintPlaceholder(field: txtPassword!, color: .white)
        
        txtEmail?.keyboardAppearance = .dark
        txtPassword?.keyboardAppearance = .dark
    }
    
    @IBAction func makeLogin() {
        
    }
    
    @IBAction func openRegister() {
        
        let registerVC = storyboard?.instantiateViewController(identifier: "RegisterView") as! RegisterViewController
        
        present(registerVC, animated: true, completion: nil)
    }
}



