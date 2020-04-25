//
//  SideDishUseCase.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/23.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct SideDishUseCase {
    
    enum JsonConvertError: Error {
        case InvalidJson
    }
    
    static func loadDishes(with manager: NetworkManager, failureHandler: @escaping (Error) -> () = {_ in}, completed: @escaping([SideDishInfo], Int) -> ()) {
        
        manager.getMainDish(failureHandler: failureHandler) {
            do {
                let model = try JSONDecoder().decode(SideDish.self, from: $0)
                completed(model.sideDishes, 0)
            } catch {
                failureHandler(JsonConvertError.InvalidJson)
            }
        }
        
        manager.getSideDish(failureHandler: failureHandler) {
            do {
                let model = try JSONDecoder().decode(SideDish.self, from: $0)
                completed(model.sideDishes, 1)
            } catch {
                failureHandler(JsonConvertError.InvalidJson)
            }
        }
        
        manager.getSoupDish(failureHandler: failureHandler) {
            do {
                let model = try JSONDecoder().decode(SideDish.self, from: $0)
                completed(model.sideDishes, 2)
            } catch {
                failureHandler(JsonConvertError.InvalidJson)
            }
        }
    }
}
