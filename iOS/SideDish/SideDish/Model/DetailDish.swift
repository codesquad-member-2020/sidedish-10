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
    var topImage: String
    var productDescription: String
    var point: String
    var deliveryInfo: String
    var deliveryFee: String
    var specialPrice: String?
    var originalPrice: String?
    var detailSection: [String]
    var thumbImages: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case topImage = "top_image"
        case productDescription = "product_description"
        case point
        case deliveryInfo = "delivery_info"
        case deliveryFee = "delivery_fee"
        case specialPrice = "special_price"
        case originalPrice = "n_price"
        case detailSection = "detail_section"
        case thumbImages = "thumb_images"
    }
}
