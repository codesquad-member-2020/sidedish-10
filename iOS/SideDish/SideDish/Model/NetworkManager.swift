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
    func getResource(from: String, method: HTTPMethod, headers: HTTPHeaders?, handler : @escaping dataHandler)
}

typealias dataHandler = (Result<Data, NetworkManager.NetworkError>) -> Void
typealias downloadHandler = (Result<URL, NetworkManager.NetworkError>) -> Void

class NetworkManager: NetworkManageable {
    
    enum EndPoints {
        static let serverURL = "http://13.125.179.178:8080/develop/baminchan/"
        static let main = "main"
        static let soup = "soup"
        static let side = "side"
        static let detail = "detail"
    }
    
    enum NetworkError: Error {
        case DataEmpty
        case DecodeError
        case InvalidHTTPResonse
        case InvalidStatusCode(Int)
        case InvalidURL
        case requestError
        
        func message() -> String {
            switch self {
            case .DataEmpty:
                return "데이터가 비었어요."
            case .DecodeError:
                return "응답을 복호화 하는 도중 문제가 발생했어요."
            case .InvalidHTTPResonse:
                return "HTTP 응답이 유효하지 않아요."
            case .InvalidStatusCode(let code):
                return "HTTP 응답 \(code) 에러 발생했어요."
            case .InvalidURL:
                return "URL이 유효하지 않아요."
            case .requestError:
                return "요청을 보내는 중에 오류가 발생했어요."
            }
        }
    }
    
    func downloadResource(from: URL, handler: @escaping downloadHandler) {
        URLSession.shared.downloadTask(with: from) { (url, response, error) in
            guard error == nil else {
                handler(.failure(.requestError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                handler(.failure(.InvalidHTTPResonse))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                handler(.failure(.InvalidStatusCode(httpResponse.statusCode)))
                return
            }
            
            guard let url = url else {
                handler(.failure(.DataEmpty))
                return
            }
            
            handler(.success(url))
        }.resume()
    }
    
    func getResource(from: String, method: HTTPMethod, headers: HTTPHeaders?, handler: @escaping dataHandler) {
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
                handler(.failure(.InvalidHTTPResonse))
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
    
    func getMainDish(handler: @escaping dataHandler) {
        getResource(from: EndPoints.serverURL + EndPoints.main, method: .get, headers: nil, handler: handler)
    }
    
    func getSoupDish(handler: @escaping dataHandler) {
        getResource(from: EndPoints.serverURL + EndPoints.soup, method: .get, headers: nil, handler: handler)
    }
    
    func getSideDish(handler: @escaping dataHandler) {
        getResource(from: EndPoints.serverURL + EndPoints.side, method: .get, headers: nil, handler: handler)
    }
    
    func getDetailDish(id: Int, handler: @escaping dataHandler) {
        getResource(from: EndPoints.serverURL + EndPoints.detail + "/\(id)", method: .get, headers: nil, handler: handler)
    }
    
    func getImageURL(from: URL, handler: @escaping downloadHandler) {
        downloadResource(from: from, handler: handler)
    }
}
