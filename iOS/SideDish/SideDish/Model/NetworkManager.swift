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
        static let serverURL = "http://15.165.138.17:8080/develop/baminchan/"
        static let main = "main"
        static let soup = "soup"
        static let side = "side"
    }
    
    func getResource(from: String, method: HTTPMethod, headers: HTTPHeaders?, handler: @escaping (AFDataResponse<Data>) -> ()) {
        AF.request(from, method: .get, parameters: nil, headers: headers, interceptor: nil, requestModifier: nil).responseData {
            handler($0)
        }
    }
    
    func getMainDish(handler: @escaping (AFDataResponse<Data>) -> ()) {
        getResource(from: EndPoints.serverURL + EndPoints.main, method: .get, headers: nil) {
            handler($0)
        }
    }
    
    func getSoupDish(handler: @escaping (AFDataResponse<Data>) -> ()) {
        getResource(from: EndPoints.serverURL + EndPoints.soup, method: .get, headers: nil) {
            handler($0)
        }
    }
    
    func getSideDish(handler: @escaping (AFDataResponse<Data>) -> ()) {
        getResource(from: EndPoints.serverURL + EndPoints.side, method: .get, headers: nil) {
            handler($0)
        }
    }
}
