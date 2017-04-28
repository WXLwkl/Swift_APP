//
//  TabbarViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2017/3/21.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self as UITabBarControllerDelegate
        
        self.tabBar.isTranslucent = false  //避免受默认的半透明色影响，关闭
//        设置选中颜色
        self.tabBar.tintColor = UIColor(red: 0/255, green:186/255, blue:255/255, alpha:1)
        self.selectedIndex = 0;
        
        addChildViewControllers()
    }
    
    private func addChildViewControllers() {
        setChildrenController(title: "应用", image: UIImage(named: "item0_1")!, selectedImage: UIImage(named: "item0_1")!, storyboard: UIStoryboard(name: "Root", bundle: nil))
        setChildrenController(title: "商城", image: UIImage(named: "item1_1")!, selectedImage: UIImage(named: "item1_1")!, storyboard: UIStoryboard(name: "Mall", bundle: nil))
        setChildrenController(title: "我的", image: UIImage(named: "item2_1")!, selectedImage: UIImage(named: "item2_1")!, storyboard: UIStoryboard(name: "Mine", bundle: nil))
        
    }
    /// 添加一个子控制器
    private func setChildrenController(title:String, image:UIImage,selectedImage:UIImage, storyboard:UIStoryboard) {
        let controller = storyboard.instantiateInitialViewController()!
        controller.tabBarItem.title = title
        controller.tabBarItem.image = image
        controller.tabBarItem.selectedImage = selectedImage
//        let naviController = NavigationController.init(rootViewController: controller)
        addChildViewController(controller)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        
        if viewController.tabBarItem.title == "我的" {
            print("这里是个人中心页面")
        }
        
        return true
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
