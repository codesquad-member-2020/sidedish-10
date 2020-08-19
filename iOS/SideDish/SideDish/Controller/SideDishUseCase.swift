//
//  SideDishUseCase.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/23.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct SideDishUseCase {
        
    func loadDish(with manager: NetworkManageable, type: MenuType, failureHandler: @escaping (NetworkError) -> Void, successHandler: @escaping([SideDishInfo]) -> Void) {
        let url = getURL(from: type)
        
        manager.getResource(
            url: url,
            method: .get,
            headers: nil,
            handler: { result in
                switch result {
                case .failure(let error):
                    failureHandler(error)
                    
                case .success(let data):
                    do {
                        let model = try JSONDecoder().decode(SideDish.self, from: data)
                        successHandler(model.dishes)
                    } catch {
                        failureHandler(.decodeError)
                    }
                }
        })
    }
    
    private func getURL(from type: MenuType) -> URL? {
        switch type {
        case .main:
            return EndPoint(path: .main).url
            
        case .side:
            return EndPoint(path: .side).url
            
        case .soup:
            return  EndPoint(path: .soup).url
        }
    }
}
