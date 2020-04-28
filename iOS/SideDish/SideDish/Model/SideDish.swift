//
// SideDish.swift
// SideDish
//
// Created by 신한섭 on 2020/04/22.
// Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct SideDish: Codable {
    var sideDishes: [SideDishInfo]
    
    enum CodingKeys: String, CodingKey {
        case sideDishes = "body"
    }
}

struct SideDishInfo: Codable {
    var id: Int
    var imageUrl: String
    var title: String
    var description: String
    var originalPrice: String?
    var specialPrice: String
    var badges: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "image"
        case title
        case description
        case originalPrice = "n_price"
        case specialPrice = "s_price"
        case badges
    }
}



