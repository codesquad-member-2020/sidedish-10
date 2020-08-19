//
// SideDish.swift
// SideDish
//
// Created by 신한섭 on 2020/04/22.
// Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct SideDish: Codable {
    
    let dishes: [SideDishInfo]
    
    enum CodingKeys: String, CodingKey {
        case dishes = "body"
    }
}

struct SideDishInfo: Codable {
    
    let id: String
    let imageUrl: String
    let deliveryType: [String]
    let title: String
    let subTitle: String
    let originalPrice: String?
    let specialPrice: String
    let badge: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id = "detail_hash"
        case imageUrl = "image"
        case deliveryType = "delivery_type"
        case title
        case subTitle = "description"
        case originalPrice = "n_price"
        case specialPrice = "s_price"
        case badge
    }
}
