//
//  MenuType.swift
//  SideDish
//
//  Created by 신한섭 on 2020/08/07.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

enum MenuType: String, CaseIterable, CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
    
    case main = "메인반찬/한그릇 뚝딱 메인 요리"
    case soup = "국.찌개/김이 모락모락 국.찌개"
    case side = "밑반찬/언제 먹어도 든든한 밑반찬"
    
    init(index: Int) {
        self = MenuType.allCases[index]
    }
}
