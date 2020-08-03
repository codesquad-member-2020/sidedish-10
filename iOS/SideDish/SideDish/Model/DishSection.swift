//
//  DishSection.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/29.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct DishSection: Codable {
    var body: [Section]
}

struct Section: Codable {
    var id: Int
    var title: String
    var info: String
    
    enum CodingKeys: String, CodingKey {
        case id = "menu_id"
        case title
        case info
    }
}
