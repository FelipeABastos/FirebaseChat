//
//  NewMessageViewController.swift
//  FirebaseChatApp
//
//  Created by Felipe Amorim Bastos on 26/03/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit

class NewMessageViewController: UIViewController {
    
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
        
    }
    
    @IBAction func backHome() {
        self.dismiss(animated: true, completion: nil)
    }
}
