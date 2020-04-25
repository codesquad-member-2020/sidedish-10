//
//  SideDishUseCase.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/23.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct SideDishUseCase {
    
    static func loadMainDish(with manager: NetworkManager, failureHandler: @escaping (NetworkManager.NetworkError) -> () = {_ in}, completed: @escaping([SideDishInfo], Int) -> ()) {
        
        manager.getMainDish {
            switch $0 {
            case .failure(let error):
                failureHandler(error)
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(SideDish.self, from: data)
                    completed(model.sideDishes, 0)
                } catch {
                    NotificationCenter.default.post(name: .DecodeError, object: nil)
                }
            }
        }
    }
    
    static func loadSideDish(with manager: NetworkManager, failureHandler: @escaping (NetworkManager.NetworkError) -> () = {_ in}, completed: @escaping([SideDishInfo], Int) -> ()) {
        
        manager.getSideDish {
            switch $0 {
            case .failure(let error):
                failureHandler(error)
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(SideDish.self, from: data)
                    completed(model.sideDishes, 1)
                } catch {
                    NotificationCenter.default.post(name: .DecodeError, object: nil)
                }
            }
        }
    }
    
    static func loadSoupDish(with manager: NetworkManager, failureHandler: @escaping (NetworkManager.NetworkError) -> () = {_ in}, completed: @escaping([SideDishInfo], Int) -> ()) {
        
        manager.getSoupDish {
            switch $0 {
            case .failure(let error):
                failureHandler(error)
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(SideDish.self, from: data)
                    completed(model.sideDishes, 2)
                } catch {
                    NotificationCenter.default.post(name: .DecodeError, object: nil)
                }
            }
        }
    }
}

extension Notification.Name {
    static let DecodeError = Notification.Name("DecodeError")
}
