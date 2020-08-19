//
//  DetailDish.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/28.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct DetailDish: Codable {
    
    let hashId: String
    let dishInfo: DishInfo
    
    enum CodingKeys: String, CodingKey {
        case hashId = "hash"
        case dishInfo = "data"
    }
}

struct DishInfo: Codable {
  
    let thumbImages: [String]
    let productDescription: String
    let point: String
    let deliveryInfo: String
    let deliveryFee: String
    let prices: [String]
    let detailSection: [String]
    
    enum CodingKeys: String, CodingKey {
        case thumbImages = "thumb_images"
        case productDescription = "product_description"
        case point
        case deliveryInfo = "delivery_info"
        case deliveryFee = "delivery_fee"
        case prices = "prices"
        case detailSection = "detail_section"
    }
}
