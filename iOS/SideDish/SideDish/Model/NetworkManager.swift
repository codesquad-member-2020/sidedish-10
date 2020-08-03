//
// NetworkManager.swift
// SideDish
//
// Created by 신한섭 on 2020/04/22.
// Copyright © 2020 신한섭. All rights reserved.
//

import Alamofire
import Foundation

protocol NetworkManageable {
    func getResource(from: String, method: HTTPMethod, headers: HTTPHeaders?, handler : @escaping DataHandler)
}

typealias DataHandler = (Result<Data, NetworkManager.NetworkError>) -> ()
typealias DownloadHandler = (Result<URL, NetworkManager.NetworkError>) -> ()

class NetworkManager: NetworkManageable {
    static var jwtToken: String?
    
    enum EndPoints {
        static let serverURL = "http://13.125.179.178:8080/develop/baminchan/"
        static let main = "main"
        static let soup = "soup"
        static let side = "side"
        static let detail = "detail"
        static let menuinfo = "menuinfo"
        static let order = "order"
    }
    
    enum NetworkError: Error {
        case dataEmpty
        case decodeError
        case invalidHTTPResonse
        case invalidStatusCode(Int)
        case invalidURL
        case requestError
        
        func message() -> String {
            switch self {
            case .dataEmpty:
                return "데이터가 비었어요."
            case .decodeError:
                return "응답을 복호화 하는 도중 문제가 발생했어요."
            case .invalidHTTPResonse:
                return "HTTP 응답이 유효하지 않아요."
            case .invalidStatusCode(let code):
                return "HTTP 응답 \(code) 에러 발생했어요."
            case .invalidURL:
                return "URL이 유효하지 않아요."
            case .requestError:
                return "요청을 보내는 중에 오류가 발생했어요."
            }
        }
    }
    
    func downloadResource(from: URL, handler: @escaping DownloadHandler) {
        var urlRequest = URLRequest(url: from)
        urlRequest.addValue("jwtToken=" + (NetworkManager.jwtToken ?? ""), forHTTPHeaderField: "Cookie")
        URLSession.shared.downloadTask(with: urlRequest) { (url, response, error) in
            guard error == nil else {
                handler(.failure(.requestError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                handler(.failure(.invalidHTTPResonse))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                handler(.failure(.invalidStatusCode(httpResponse.statusCode)))
                return
            }
            
            guard let url = url else {
                handler(.failure(.dataEmpty))
                return
            }
            
            handler(.success(url))
        }
        .resume()
    }
    
    func getResource(from: String, method: HTTPMethod, headers: HTTPHeaders?, handler: @escaping DataHandler) {
        guard let url = URL(string: from) else {
            handler(.failure(.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("jwtToken=" + (NetworkManager.jwtToken ?? ""), forHTTPHeaderField: "Cookie")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                handler(.failure(.requestError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                handler(.failure(.invalidHTTPResonse))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                handler(.failure(.invalidStatusCode(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                handler(.failure(.dataEmpty))
                return
            }
            
            handler(.success(data))
        }
        .resume()
    }
    
    func getStock(id: Int, handler: @escaping DataHandler) {
        getResource(from: EndPoints.serverURL + EndPoints.order + "/\(id)", method: .get, headers: nil, handler: handler)
    }
    
    func getSectionHeader(handler: @escaping DataHandler) {
        getResource(from: EndPoints.serverURL + EndPoints.menuinfo, method: .get, headers: nil, handler: handler)
    }
    
    func getMainDish(handler: @escaping DataHandler) {
        getResource(from: EndPoints.serverURL + EndPoints.main, method: .get, headers: nil, handler: handler)
    }
    
    func getSoupDish(handler: @escaping DataHandler) {
        getResource(from: EndPoints.serverURL + EndPoints.soup, method: .get, headers: nil, handler: handler)
    }
    
    func getSideDish(handler: @escaping DataHandler) {
        getResource(from: EndPoints.serverURL + EndPoints.side, method: .get, headers: nil, handler: handler)
    }
    
    func getDetailDish(id: Int, handler: @escaping DataHandler) {
        getResource(from: EndPoints.serverURL + EndPoints.detail + "/\(id)", method: .get, headers: nil, handler: handler)
    }
    
    func getImageURL(from: URL, handler: @escaping DownloadHandler) {
        downloadResource(from: from, handler: handler)
    }
}
