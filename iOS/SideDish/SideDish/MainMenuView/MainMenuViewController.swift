//
//  MainMenuViewController.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/21.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var mainMenuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainMenuTableView.dataSource = self
    }
}

extension MainMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            "MainMenuCell", for: indexPath) as? MainMenuTableViewCell else {return UITableViewCell()}
        cell.configuration()
        return cell
    }
}
