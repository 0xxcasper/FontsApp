//
//  UserDefault.swift
//  FontsApp
//
//  Created by admin on 17/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation

enum UserDefaultKey: String {
    case currentFont = "currentFont"
    
}

class UserDefault {
    static let shared = UserDefault()
    private let userDefaultManager = UserDefaults.standard
    
    var currentFont: Int? {
        get {
            let value = get(key: .currentFont) as? Int
            return value
        }
        set(newFont) {
            save(value: newFont, key: .currentFont)
        }
    }
}

extension UserDefault {
    
    private func save(value: Any?, key: UserDefaultKey) {
        userDefaultManager.set(value, forKey: key.rawValue)
        userDefaultManager.synchronize()
    }
    
    private func get(key: UserDefaultKey) -> Any? {
        return userDefaultManager.object(forKey: key.rawValue)
    }
}
