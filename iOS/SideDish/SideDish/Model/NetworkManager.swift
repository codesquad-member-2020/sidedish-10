//

// NetworkManager.swift

// SideDish

//

// Created by 신한섭 on 2020/04/22.

// Copyright © 2020 신한섭. All rights reserved.

//



import Foundation
import Alamofire

protocol NetworkManageable {
    func getResource(from: String, method: HTTPMethod, headers: HTTPHeaders?, handler: @escaping (AFDataResponse<Data>) -> ())
}

class NetworkManager: NetworkManageable {
    
    enum EndPoints {
        static let main = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/main"
        static let soup = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/soup"
        static let side = "https://h3rb9c0ugl.execute-api.ap-northeast-2.amazonaws.com/develop/baminchan/side"
    }
    
    func getResource(from: String, method: HTTPMethod, headers: HTTPHeaders?, handler: @escaping (AFDataResponse<Data>) -> ()) {
        AF.request(from, method: .get, parameters: nil, headers: headers, interceptor: nil, requestModifier: nil).responseData {
            handler($0)
        }
    }
}
