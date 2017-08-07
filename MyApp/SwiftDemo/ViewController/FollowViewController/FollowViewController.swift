//
//  FollowViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2017/6/23.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

import LocalAuthentication

class FollowViewController: RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "关注"
        
        let context = LAContext()
        var error: NSError? = nil
        let canEvaluatePolicy = context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) as Bool
        if error != nil {
            printLog(error!.localizedDescription as String)
        }
       
        if canEvaluatePolicy {
            print("有指纹验证功能")
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "放上您的狗爪", reply: { (success: Bool, error: Error?) in
                if success {
                    print("验证成功")
                } else {
                    print("验证失败: \(String(describing: error?.localizedDescription))")
                }
            })
        } else {
            print("还没开启指纹验证呢")
        }
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
