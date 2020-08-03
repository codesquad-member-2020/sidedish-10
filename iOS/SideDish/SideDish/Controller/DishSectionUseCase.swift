//
//  DishSectionUseCase.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/29.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct DishSectionUseCase {
    
    static func loadSectionHeaders(with manager: NetworkManager, failureHandler: @escaping (NetworkManager.NetworkError) -> Void = { _ in }, completed: @escaping([Section]) -> Void) {
        manager.getSectionHeader {
            switch $0 {
            case .failure(let error):
                failureHandler(error)
                
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(DishSection.self, from: data)
                    completed(model.body)
                } catch {
                    failureHandler(.decodeError)
                }
            }
        }
    }
}
