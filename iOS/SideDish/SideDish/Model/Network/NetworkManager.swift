//
// NetworkManager.swift
// SideDish
//
// Created by 신한섭 on 2020/04/22.
// Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

class NetworkManager: NetworkManageable {
    
    func downloadResource(from: URL, handler: @escaping DownloadHandler) {
        URLSession.shared.downloadTask(with: from) { (url, response, error) in
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
    
    func getResource(url: URL?, method: HTTPMethod, headers: HTTPHeaders?, handler: @escaping DataHandler) {
        guard let urlRequest = makeURLRequest(url: url, method: method, headers: headers) else {
            handler(.failure(.invalidURL))
            return
        }
        
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
    
    private func makeURLRequest(url: URL?, method: HTTPMethod, headers: HTTPHeaders?) -> URLRequest? {
        guard let url = url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        headers?.list.forEach { field, value in
            urlRequest.addValue(value, forHTTPHeaderField: field)
        }
        
        return urlRequest
    }
}
