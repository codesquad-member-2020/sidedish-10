//
//  DetailInfoUseCase.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/28.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct DetailInfoUseCase {
    
    static func loadDetailDish(with manager: NetworkManager, id: String, failureHandler: @escaping (NetworkError) -> Void = { _ in }, completed: @escaping(DishInfo) -> Void) {
        manager.getResource(
            url: EndPoint(path: .detail(id)).url,
            method: .get,
            headers: nil,
            handler: {
                switch $0 {
                case .failure(let error):
                    failureHandler(error)
                    
                case .success(let data):
                    do {
                        let model = try JSONDecoder().decode(DetailDish.self, from: data)
                        completed(model.body)
                    } catch {
                        failureHandler(.decodeError)
                    }
                }
        })
    }
}
