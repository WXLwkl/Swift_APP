//
//  ViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2017/5/4.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

import CoreGraphics

class ViewController: UIViewController, CloseSlideMenuDelegate {

    fileprivate var homeTabBarController: TabBarController!
    fileprivate var slideMenu: LeftSlideMenuController!
    fileprivate var panGesture: UIPanGestureRecognizer!
    fileprivate var tapGesture: UITapGestureRecognizer!
    fileprivate var tapToShowSlideMenuGesture: UITapGestureRecognizer!
    fileprivate var navigationBarHeight: CGFloat!
    fileprivate var tabBarHeight: CGFloat!
    fileprivate var availableArea: CGMutablePath!
    
    let distancePercent: CGFloat = 0.8
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homeTabBarController = TabBarController()
        slideMenu = LeftSlideMenuController()

        let selectedView = self.homeTabBarController.childViewControllers.first as? NavigationController
        
        navigationBarHeight = selectedView?.visibleViewController?.navigationController?.navigationBar.bounds.height
        tabBarHeight = selectedView?.visibleViewController?.tabBarController?.tabBar.bounds.height

        view.addSubview(slideMenu.view)
        view.addSubview(homeTabBarController.view)
        
        createAvailableArea(UIScreen.main.bounds.size.width / 6)
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.pan(_:)))
        self.homeTabBarController.view.addGestureRecognizer(panGesture)
        
        slideMenu.delegate = selectedView?.visibleViewController as? SlideMenuDelegate
        slideMenu.closeDelegate = self
    }
    
    func createAvailableArea(_ x: CGFloat) {
        
        availableArea = CGMutablePath()
        
        availableArea.move(to: CGPoint(x:x - kScreenW/6, y: navigationBarHeight))
        availableArea.addLine(to: CGPoint(x: x + kScreenW/6, y: navigationBarHeight))
        availableArea.addLine(to: CGPoint(x: x + kScreenW/6, y: kScreenH - tabBarHeight))
        availableArea.addLine(to: CGPoint(x: x - kScreenW/6, y: kScreenH - tabBarHeight))
        availableArea.addLine(to: CGPoint(x: x - kScreenW/6, y:  navigationBarHeight))
        
        availableArea.closeSubpath()
    }
    
    func pan(_ recongnizer: UIPanGestureRecognizer) {
        let currentPressPoint = panGesture.location(in: self.view)
        
        if availableArea.contains(currentPressPoint) {
            let x = recongnizer.translation(in: self.homeTabBarController.view).x
            let velocityx = 0.2 * recongnizer.velocity(in: self.homeTabBarController.view).x
    
            let state = recongnizer.state
            
            switch state {
            case .began:
                printLog(message: "---- began")

            case .changed:
                printLog(message: "---- changed")
                if velocityx < -80 {
                    
                    dismissSlideMenu()
                    return
                } else if velocityx > 80 {
                    
                    presentSlideMenu()
                    return
                } else {
                    if recongnizer.view!.frame.origin.x == 0 && x < 0 {
                        return
                    }
                    if recongnizer.view!.frame.origin.x == distancePercent * kScreenW && x > 0 {
                        return
                    }
                    if recongnizer.view!.frame.origin.x <= distancePercent * kScreenW {
                        createAvailableArea(currentPressPoint.x)
                        recongnizer.view!.center.x += x
                        self.slideMenu.view.center.x += x * 3/8
                        recongnizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
                        
                        
                        //头像透明
                        let selectedView = self.homeTabBarController.selectedViewController as? NavigationController
                        let avaterBarButton = selectedView?.visibleViewController?.navigationItem.leftBarButtonItem
                        avaterBarButton?.customView?.layer.opacity -= 0.009
                        
                    }
                }
            case .ended:
                printLog(message: "---- ended")
                if recongnizer.view!.center.x < kScreenW * (5/6) {
                    dismissSlideMenu()
                } else {
                    presentSlideMenu()
                }
            default:
                printLog(message: "异常滑动")
            }
            
            
            
        }
        
    }
    
    func dismissSlideMenu(_ recongnizer: UITapGestureRecognizer) {
        let currentPressPoint = tapGesture.location(in: self.view)
        
        if availableArea.contains(currentPressPoint) {
            printLog(message: "SlideMenu该出现了")
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
                self.createAvailableArea(kScreenW/6)
                self.homeTabBarController.view.frame.origin.x = 0
                self.slideMenu.view.frame.origin.x = -kScreenW * 0.3
                
                // 头像恢复
                let selectedView = self.homeTabBarController.selectedViewController as? NavigationController
                let avatarBarButton = selectedView?.visibleViewController?.navigationItem.leftBarButtonItem
                
                avatarBarButton?.customView?.layer.opacity = 1
            }, completion: nil)
        }
        self.homeTabBarController.view.removeGestureRecognizer(recongnizer)
    }
    
//    展开左视图
    func presentSlideMenu() {
//        给 首页 加入点击自动关闭侧滑菜单
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissSlideMenu(_:)))
        self.homeTabBarController.view.addGestureRecognizer(tapGesture)
        
        printLog(message: "SlideMenu该出现了")
        
//        计算距离，执行菜单自动滑动动画
        let mainViewDistance = kScreenW * distancePercent
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.createAvailableArea(kScreenW * 0.96)
            self.homeTabBarController.view.frame.origin.x = mainViewDistance
            self.slideMenu.view.frame.origin.x = 0
            
            // 头像透明
            let selectedView = self.homeTabBarController.selectedViewController as? NavigationController
            let avatarBarButton = selectedView?.visibleViewController?.navigationItem.leftBarButtonItem
            
            avatarBarButton?.customView?.layer.opacity = 0
        }, completion: nil)
        
    }
    
//    关闭左视图
    func dismissSlideMenu() {
        printLog(message: "SlideMenu该消失了")
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            self.createAvailableArea(kScreenW/6)
            self.homeTabBarController.view.frame.origin.x = 0
            self.slideMenu.view.frame.origin.x = -kScreenW * 0.3
            
            //头像恢复
            let selectedView = self.homeTabBarController.selectedViewController as? NavigationController
            let avaterBarButton = selectedView?.visibleViewController?.navigationController?.navigationItem.leftBarButtonItem
            avaterBarButton?.customView?.layer.opacity = 1
            
        }, completion: nil)
        
    }
    
    func closeSlideMenu() {
        self.homeTabBarController.view.removeGestureRecognizer(tapGesture)
        self.homeTabBarController.view.removeGestureRecognizer(panGesture)
        dismissSlideMenu()
    }
    
    func backFromNavigation() {
        self.homeTabBarController.view.addGestureRecognizer(panGesture)
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
