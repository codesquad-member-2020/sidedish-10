//
//  SideDishUseCase.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/23.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct SideDishUseCase {
    
    static func loadMainDish(with manager: NetworkManager, failureHandler: @escaping (NetworkManager.NetworkError) -> () = { _ in }, completed: @escaping([SideDishInfo], Int) -> ()) {
        manager.getMainDish {
            handleImage(result: $0, failureHandler: failureHandler, completed: completed)
        }
    }
    
    static func loadSideDish(with manager: NetworkManager, failureHandler: @escaping (NetworkManager.NetworkError) -> () = { _ in }, completed: @escaping([SideDishInfo], Int) -> ()) {
        manager.getSideDish {
            handleImage(result: $0, failureHandler: failureHandler, completed: completed)
        }
    }
    
    static func loadSoupDish(with manager: NetworkManager, failureHandler: @escaping (NetworkManager.NetworkError) -> () = { _ in }, completed: @escaping([SideDishInfo], Int) -> ()) {
        manager.getSoupDish {
            handleImage(result: $0, failureHandler: failureHandler, completed: completed)
        }
    }
    
    static func handleImage (result: Result<Data, NetworkManager.NetworkError>, failureHandler: @escaping (NetworkManager.NetworkError) -> () = { _ in }, completed: @escaping([SideDishInfo], Int) -> ()) {
        switch result{
        case .failure(let error):
            failureHandler(error)
        case .success(let data):
            do {
                let model = try JSONDecoder().decode(SideDish.self, from: data)
                completed(model.sideDishes, model.menuId - 1)
            } catch {
                failureHandler(.DecodeError)
            }
        }
    }
}
