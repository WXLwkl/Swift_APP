//
//  MainNavigationController.swift
//  DYTV
//
//  Created by xingl on 2018/10/16.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

// 添加全屏手势

        // 获取系统的pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        // 获取手势添加到的view中
        guard let gesView = systemGes.view else { return }
        // 获取target、action
        /*
        // 利用运行时机制查看所有的属性名称
        var count: UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
            
        }
 */
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        
        print(targetObjc)
        
        // 取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
        // 取出action
//        guard let action = targetObjc.value(forKey: "action") as? Selector else { return }
        let action = Selector(("handleNavigationTransition:"))
        
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }

    

}
