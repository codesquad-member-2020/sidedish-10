//
//  SideDishManager.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/22.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

class SideDishManager {
    private var sideDish: [[SideDishInfo]]
    
    init() {
        sideDish = [[SideDishInfo]]()
        for _ in 0..<3 {
            sideDish.append([SideDishInfo]())
        }
    }
    
    func insert(into section: Int, rows: [SideDishInfo]) {
        sideDish[section] = rows
        NotificationCenter.default.post(name: .ModelInserted,
                                        object: nil,
                                        userInfo: ["index" : section])
    }
    
    func sideDish(section: Int, row: Int) -> SideDishInfo {
        return sideDish[section][row]
    }
    
    func numOfRows(at section: Int) -> Int {
        return sideDish[section].count
    }
}

extension Notification.Name {
    static let ModelInserted = Notification.Name("ModelInserted")
}
