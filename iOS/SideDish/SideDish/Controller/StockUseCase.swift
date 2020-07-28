//
//  StockUseCase.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/29.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct StockUseCase {
    
    static func isSoldOut(with manager: NetworkManager, id: Int, failureHandler: @escaping (NetworkManager.NetworkError) -> () = { _ in }, completed: @escaping (Bool) -> ()) {
        manager.getStock(id: id){
            switch $0 {
            case .failure(let error):
                failureHandler(error)
            case .success(let data):
                do {
                    guard let result:[String:Int] = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Int] else {
                        failureHandler(.DecodeError)
                        return
                    }
                    guard let stock = result["stock"] else {
                        failureHandler(.DecodeError)
                        return
                    }
                    completed(stock > 0)
                } catch {
                    failureHandler(.DecodeError)
                }
            }
        }
    }
}
