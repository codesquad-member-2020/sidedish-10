//
//  DetailInfoUseCase.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/28.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct DetailInfoUseCase {
    
    func loadDetailDish(with manager: NetworkManageable, id: String, failureHandler: @escaping (NetworkError) -> Void = { _ in }, completed: @escaping(DetailDish) -> Void) {
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
                        completed(model)
                    } catch {
                        failureHandler(.decodeError)
                    }
                }
        })
    }
}
