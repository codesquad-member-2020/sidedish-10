//
//  DetailDish.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/28.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct DetailDish: Codable {
    var body: DishInfo
}

struct DishInfo: Codable {
    var id: Int
    var top_image: String
    var product_description: String
    var point: String
    var delivery_info: String
    var delivery_fee: String
    var s_price: String?
    var n_price: String?
    var detail_section: [String]
    var thumb_images: [String]
}
