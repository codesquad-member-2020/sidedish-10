//
//  SideDishManager.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/22.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

class SideDishManager {
    
    init() {
        sideDish = [[SideDishInfo]]()
        for _ in 0..<sectionCount {
            sideDish.append([SideDishInfo]())
        }
    }
    
    var sideDish: [[SideDishInfo]]
    var sectionCount: Int {
        return MenuType.allCases.count
    }
    
    func insert(into section: Int, rows: [SideDishInfo]) {
        sideDish[section] = rows
        NotificationCenter.default.post(name: .ModelInserted,
                                        object: nil,
                                        userInfo: ["index": section])
    }
    
    func sideDish(indexPath: IndexPath) -> SideDishInfo {
        return sideDish[indexPath.section][indexPath.row]
    }
    
    func numOfRows(at section: Int) -> Int {
        return sideDish[section].count
    }
}

extension Notification.Name {
    static let ModelInserted = Notification.Name("ModelInserted")
}
