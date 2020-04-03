//
//  RegisterViewController.swift
//  FirebaseChatApp
//
//  Created by Felipe Amorim Bastos on 18/03/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit
import Firebase
import RKDropdownAlert

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
        
        guard let imageProfile = self.imgAvatar.image else {
            Util.showMessage(text: "You need to select a photo", type: .warning)
            return
        }
        
        if name != "" {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error ) in
                
                if error != nil {
                    print(error ?? "")
                    Util.showMessage(text: "\(error?.localizedDescription ?? "")", type: .warning)
                    return
                }
                
                guard let uid = user?.user.uid else {return}
                
                // successfully authenticated
                
                let imageName = NSUUID().uuidString
                
                self.showSpinner(onView: self.view)
                
                let storageRef = Storage.storage().reference().child("Profile_images").child("\(imageName).png")
                
                let imageData = imageProfile.jpegData(compressionQuality: 0.5)
                
                storageRef.putData(imageData!, metadata: nil) { (metadata, error) in
                    
                    if error != nil {
                        print(error)
                        return
                    }
                    
                    storageRef.downloadURL { (url, error) in
                        
                        if let error = error {
                            print(error)
                        }else{
                            if let profileImageUrl = url?.absoluteString {
                                let values = ["name": name,
                                              "email": email,
                                              "profileImageUrl": profileImageUrl]
                                
                                self.registerUserIntoDatabaseWithUID(uid: uid, values: values)
                                self.removeSpinner()
                            }
                        }
                    }
                }
            }
        }else{
            Util.showMessage(text: "You need to put a name", type: .warning)
        }
    }
    
    func registerUserIntoDatabaseWithUID(uid: String, values: [String: String]) {
        let ref = Database.database().reference(fromURL: "https://fir-chat-5c19c.firebaseio.com/")
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let usersReference = ref.child("users").child(userID)
        
        usersReference.updateChildValues(values) { (err, ref) in
            
            if err != nil {
                print(err ?? "")
                return
            }
            
            self.dismiss(animated: true, completion: nil)
            Util.showMessage(text: "Registered Successfully", type: .success)
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

var vSpinner: UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor(red:0.01, green:0.00, blue:0.01, alpha:0.70)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}

