//
//  SideDishUseCase.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/23.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct SideDishUseCase {
    static func loadDishes(with manager: NetworkManager, completed: @escaping([SideDishInfo], Int) -> ()) {
        manager.getMainDish {
            guard let data = $0.data else {return}
            do {
                let model = try JSONDecoder().decode(SideDish.self, from: data)
                completed(model.sideDishes, 0)
            } catch {
                NotificationCenter.default.post(name: .InvalidJson, object: nil)
            }
        }
        
        manager.getSideDish {
            guard let data = $0.data else {return}
            do {
                let model = try JSONDecoder().decode(SideDish.self, from: data)
                completed(model.sideDishes, 1)
            } catch {
                NotificationCenter.default.post(name: .InvalidJson, object: nil)
            }
        }
        
        manager.getSoupDish {
            guard let data = $0.data else {return}
            do {
                let model = try JSONDecoder().decode(SideDish.self, from: data)
                completed(model.sideDishes, 2)
            } catch {
                NotificationCenter.default.post(name: .InvalidJson, object: nil)
            }
        }
    }
}

extension Notification.Name {
    static let InvalidJson = Notification.Name("InvalidJson")
}
