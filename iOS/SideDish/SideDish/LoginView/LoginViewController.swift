//
//  ViewController.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/20.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBAction func loginButtonPushed(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension Notification.Name {
    static let LoginSuccess = Notification.Name("LoginSuccess")
}
