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
    func getResource(from: String, method: HTTPMethod, headers: HTTPHeaders?, failureHandler: @escaping (Error) -> (), handler: @escaping (Data) -> ())
}

class NetworkManager: NetworkManageable {
    
    enum EndPoints {
        static let serverURL = "http://15.165.138.17:8080/develop/baminchan/"
        static let main = "mainwww"
        static let soup = "soup"
        static let side = "side"
    }
    
    enum NetworkError: Error {
        case InvalidURL
        case HTTPSResponseCodeIsNot200
        case DataEmpty
    }
    
    func getResource(from: String, method: HTTPMethod, headers: HTTPHeaders?, failureHandler: @escaping (Error) -> () = {_ in}, handler: @escaping (Data) -> ()) {
        
        guard let url = URL(string: from) else {
            failureHandler(NetworkError.InvalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard error != nil else {
//                failureHandler(error!)
//                return
//            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                failureHandler(NetworkError.HTTPSResponseCodeIsNot200)
                return
            }
            
            guard let data = data else {
                failureHandler(NetworkError.DataEmpty)
                return
            }
            DispatchQueue.main.async {
                handler(data)
            }
            
        }.resume()
    }
    
    func getMainDish(failureHandler: @escaping (Error) -> () = {_ in}, handler: @escaping (Data) -> ()) {
        getResource(from: EndPoints.serverURL + EndPoints.main, method: .get, headers: nil, failureHandler: {failureHandler($0)}) {
            handler($0)
        }
    }
    
    func getSoupDish(failureHandler: @escaping (Error) -> () = {_ in}, handler: @escaping (Data) -> ()) {
        getResource(from: EndPoints.serverURL + EndPoints.soup, method: .get, headers: nil, failureHandler: {failureHandler($0)}) {
            handler($0)
        }
    }
    
    func getSideDish(failureHandler: @escaping (Error) -> () = {_ in}, handler: @escaping (Data) -> ()) {
        getResource(from: EndPoints.serverURL + EndPoints.side, method: .get, headers: nil, failureHandler: {failureHandler($0)}) {
            handler($0)
        }
    }
}
