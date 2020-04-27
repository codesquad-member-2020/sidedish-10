//
//  ImageUseCase.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/25.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct ImageUseCase {
    
    static func loadImage(with manager: NetworkManager, url: String, failureHandler: @escaping (NetworkManager.NetworkError) -> () = {_ in}, completed: @escaping(Data) -> ()) {
        manager.getResource(from: url, method: .get, headers: nil) {
            switch $0 {
            case .failure(let error):
                failureHandler(error)
            case .success(let data):
                completed(data)
            }
        }
    }
    
    static func loadImage(with manager: NetworkManager, from: String, failureHandler: @escaping (NetworkManager.NetworkError) -> (), completed: @escaping(URL) -> ()) {
        manager.downloadResource(from: from) {
            switch $0 {
            case .failure(let error):
                failureHandler(error)
            case .success(let url):
                completed(url)
            }
        }
    }
}
