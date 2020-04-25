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
    func getResource(from: String, method: HTTPMethod, headers: HTTPHeaders?, handler : @escaping Handler)
}

typealias Handler = (Result<Data, NetworkManager.NetworkError>) -> Void

class NetworkManager: NetworkManageable {
    
    enum EndPoints {
        static let serverURL = "http://15.165.138.17:8080/develop/baminchan/"
        static let main = "main"
        static let soup = "soup"
        static let side = "side"
    }
    
    enum NetworkError: Error {
        case InvalidURL
        case requestError
        case InvalidStatusCode(Int)
        case DataEmpty
    }
    
    func getResource(from: String, method: HTTPMethod, headers: HTTPHeaders?, handler : @escaping Handler) {
        
        guard let url = URL(string: from) else {
            handler(.failure(.InvalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                handler(.failure(.requestError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                handler(.failure(.InvalidStatusCode(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                handler(.failure(.DataEmpty))
                return
            }
            
            handler(.success(data))
        }.resume()
    }
    
    func getMainDish(handler: @escaping Handler) {
        getResource(from: EndPoints.serverURL + EndPoints.main, method: .get, headers: nil, handler: handler)
    }
    
    func getSoupDish(handler: @escaping Handler) {
        getResource(from: EndPoints.serverURL + EndPoints.soup, method: .get, headers: nil, handler: handler)
    }
    
    func getSideDish(handler: @escaping Handler) {
        getResource(from: EndPoints.serverURL + EndPoints.side, method: .get, headers: nil, handler: handler)
    }
}
