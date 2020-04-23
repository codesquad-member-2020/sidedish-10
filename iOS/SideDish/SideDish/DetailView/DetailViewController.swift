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
    
    var dish: SideDishInfo! {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toastDetailInfo()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func toastDetailInfo() {
        let text = "타이틀 메뉴 : \(dish.title)\n\(dish.specialPrice)"
        Toast(text: text).show()
    }
}
