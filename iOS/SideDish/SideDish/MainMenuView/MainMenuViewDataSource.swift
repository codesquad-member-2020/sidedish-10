//
//  MainMenuViewDataSource.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/22.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class MainMenuViewDataSource: NSObject, UITableViewDataSource {
    
    private(set) var sideDishManager: SideDishManager
    
    override init() {
        sideDishManager = SideDishManager()
        super.init()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideDishManager.numOfRows(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            "MainMenuCell", for: indexPath) as? MainMenuTableViewCell else {return UITableViewCell()}
        let url = sideDishManager.sideDish(indexPath: indexPath).imageUrl
        ImageUseCase.loadImage(with: NetworkManager(), url: url) {
            cell.setImageFromData(data: $0)
        }
        cell.configuration(info: sideDishManager.sideDish(indexPath: indexPath))
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sideDishManager.sectionCount()
    }
}
