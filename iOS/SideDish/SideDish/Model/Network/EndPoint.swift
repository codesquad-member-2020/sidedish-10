//
//  EndPoint.swift
//  SideDish
//
//  Created by 신한섭 on 2020/08/04.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct EndPoint {
    
    init(path: Path) {
        self.path = path
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path.description
        
        return components.url
    }
    
    private let scheme = "https"
    private let host = "h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/"
    private let path: Path
    
    enum Path {
        case main
        case soup
        case side
        case detail(String)
        
        var description: String {
            switch self {
            case .main:
                return "/main"
            case .soup:
                return "/soup"
            case .side:
                return "/side"
            case .detail(let hash):
                return "/detail/\(hash)"
            }
        }
    }
}
