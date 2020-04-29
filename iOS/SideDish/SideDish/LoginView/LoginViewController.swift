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
        guard let OAuthViewController = storyboard?.instantiateViewController(withIdentifier: "OAuthViewController") as? OAuthViewController else {return}
        present(OAuthViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(presentMainMenuViewController),
                                               name: .receiveCookie,
                                               object: nil)
    }
    
    @objc func presentMainMenuViewController() {
        guard let navigationController = storyboard?.instantiateViewController(withIdentifier: "NavigationController") as? UINavigationController else {return}
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}

extension Notification.Name {
    static let LoginSuccess = Notification.Name("LoginSuccess")
}
