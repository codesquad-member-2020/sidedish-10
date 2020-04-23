//
//  MainMenuViewDataSource.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/22.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class MainMenuViewDataSource: NSObject, UITableViewDataSource {
    
    private var sideDishManager: SideDishManager
    
    override init() {
        sideDishManager = SideDishManager()
        super.init()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(injectModel(_:)),
                                               name: .InjectionModel,
                                               object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideDishManager.numOfRows(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            "MainMenuCell", for: indexPath) as? MainMenuTableViewCell else {return UITableViewCell()}
        cell.configuration()
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    @objc func injectModel(_ notification: Notification) {
        guard let model = notification.userInfo?["model"] as? [SideDishInfo] else {return}
        guard let index = notification.userInfo?["index"] as? Int else {return}
        sideDishManager.insert(into: index, rows: model)
    }
}
