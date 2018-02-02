//
//  GuideDataManager.swift
//  SwiftDemo
//
//  Created by xingl on 2017/12/15.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

class GuideDataManager: NSObject {
    static let userDefaults = UserDefaults.standard
    static let dataKey = "GuideDataKey"

    public static func reset(for key: String) {
        if var data = userDefaults.object(forKey: dataKey) as? [String: Bool] {
            data.removeValue(forKey: key)
            userDefaults.set(data, forKey: dataKey)
        }
    }

    public static func resetAll() {
        userDefaults.set(nil, forKey: dataKey)
    }

    static func shouldShowGuide(with key: String) -> Bool {
        if var data = userDefaults.object(forKey: dataKey) as? [String: Bool] {
            if let _ = data[key] {
                return false
            }
            data[key] = true
            userDefaults.set(data, forKey: dataKey)
            return true
        }
        let data = [key: true]
        userDefaults.set(data, forKey: dataKey)
        return true
    }
}
