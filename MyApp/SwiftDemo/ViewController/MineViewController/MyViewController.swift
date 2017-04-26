//
//  MyViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2017/3/21.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit


class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "个人中心"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(MyViewController.addBtnclick(_:)))
        
        
        let label = UILabel(frame: CGRect(x: 0, y: 2, width: view.bounds.width, height: 50))
        label.text = "AAA"
        label.backgroundColor = #colorLiteral(red: 0.4488613621, green: 1, blue: 0.5756808982, alpha: 1)
        label.textAlignment = .center
        view.addSubview(label)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func addBtnclick(_ item: UIBarButtonItem) {
        appInfo()
    }
    
// TODO: - 设备信息
    func appInfo() -> Void {
        
        print("It's a print")
        debugPrint("It's a debugPrint")
        CFShow("It's a CFShow" as CFTypeRef!)
        
        print("-----------------------------------")
        let mainBundle = Bundle.main
        let identifier = mainBundle.bundleIdentifier
        let info = mainBundle.infoDictionary
        let bundleId = mainBundle.object(forInfoDictionaryKey: "CFBundleName")
        let version = mainBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString")
        print("[identifier]:\(identifier)")
        print("[info]:\(info)")
        print("[bundleId]:\(bundleId!)")
        print("[version]:\(version!)")
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
