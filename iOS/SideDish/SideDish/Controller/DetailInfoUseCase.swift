//
//  DetailInfoUseCase.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/28.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct DetailInfoUseCase {
    static func loadMainDish(with manager: NetworkManager, id: Int , failureHandler: @escaping (NetworkManager.NetworkError) -> () = {_ in}, completed: @escaping(DishInfo, Int) -> ()) {
        manager.getDetailDish(id: id) {
            switch $0 {
            case .failure(let error):
                failureHandler(error)
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(DetailDish.self, from: data)
                    completed(model.body, 0)
                } catch {
                    failureHandler(.DecodeError)
                }
            }
        }
    }
}
