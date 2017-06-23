//
//  XLNavigationController.swift
//  SwiftDemo
//
//  Created by xingl on 2017/4/28.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController,UIGestureRecognizerDelegate,UINavigationControllerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //设置右划手势的代理为自己
        self.interactivePopGestureRecognizer?.delegate = self
//        self.navigationBar.barTintColor = UIColor(red:0.16, green:0.42, blue:0.84, alpha:1.00)
//        self.navigationBar.tintColor = UIColor.red
//        self.navigationBar.isTranslucent = false
        
        
        let navBar = UINavigationBar.appearance()
        //设置标题颜色
        navBar.tintColor = UIColor.white
        
        let textAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 18),NSForegroundColorAttributeName:UIColor.white]
        
        navBar.titleTextAttributes = textAttributes
        
//        navBar.barTintColor = UIColor(red:0.16, green:0.42, blue:0.84, alpha:1.00)
        navBar.setBackgroundImage(#imageLiteral(resourceName: "navBarImage.png"), for: .default)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        printLog(self.viewControllers.count)
        
        if viewControllers.count < 1 {
            viewController.navigationItem.rightBarButtonItem = setRightButton()
        } else {
            viewController.navigationItem.leftBarButtonItem = setBackBarButtonItem()
        }
    
        super.pushViewController(viewController, animated: true)
    }
//    左返回按钮
    func setBackBarButtonItem() -> UIBarButtonItem {
        
        let goBackItem = UIButton.init(type: .custom)
        goBackItem.setImage(UIImage(named: "goBack"), for: .normal)
        goBackItem.sizeToFit()
//        goBackItem.frame.size = CGSize(width: 30, height: 30)
//        goBackItem.contentHorizontalAlignment = .left
        goBackItem.addTarget(self, action: #selector(NavigationController.goBack(sender:)), for: .touchUpInside)
        return UIBarButtonItem.init(customView: goBackItem)

    }
    
    func goBack(sender: UIBarButtonItem) {
        self.popViewController(animated: true)
    }
    
    /// 设置导航栏右边按钮
    func setRightButton() -> UIBarButtonItem {
        
        let searchItem = UIButton.init(type: .custom)
        searchItem.setImage(UIImage(named: "searchbutton_nor"), for: .normal)
        searchItem.sizeToFit()
        searchItem.frame.size = CGSize(width: 30, height: 30)
        searchItem.contentHorizontalAlignment = .right
        searchItem.addTarget(self, action: #selector(NavigationController.searchClick), for: .touchUpInside)
        return UIBarButtonItem.init(customView: searchItem)
    }
    func searchClick() {
//        let searchvc = SearchVC()
//        self.pushViewController(searchvc, animated: true)
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
