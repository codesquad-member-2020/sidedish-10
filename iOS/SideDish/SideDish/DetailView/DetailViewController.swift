//
//  DetailViewController.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/23.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit
import Toaster
class DetailViewController: UIViewController {
    
    var id: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}
