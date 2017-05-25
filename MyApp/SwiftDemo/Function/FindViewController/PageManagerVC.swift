//
//  PageManagerVC.swift
//  SwiftDemo
//
//  Created by xingl on 2017/5/23.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

protocol PageManagerVCDelegate: NSObjectProtocol {
    func pageManagerDidFinishSelectedVC(indexOfVC: NSInteger)
}

class PageManagerVC: UIViewController {

    
    //代理
    weak var delegate: PageManagerVCDelegate?
    
    //控制器数组
    fileprivate var childControllerS: [UIViewController] = [UIViewController]()
    
    //父控制器
    fileprivate var superController: UIViewController!
    //分页控制器
    fileprivate var pageVC: UIPageViewController!
    
    //初始化
    init(superController: UIViewController, childControllerS: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.superController = superController
        self.childControllerS = childControllerS
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PageManagerVC {
    fileprivate func setupUI() {
        if childControllerS.count == 0 {
            return
        }
        let temp_pageVC = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        temp_pageVC.delegate = self
        temp_pageVC.dataSource = self
        temp_pageVC.setViewControllers([childControllerS.first!], direction: .forward, animated: false, completion: nil)
        temp_pageVC.view.frame = self.view.frame
        pageVC = temp_pageVC
        self.view.addSubview(temp_pageVC.view)
    }
}
extension PageManagerVC {
    func setCurrentVCWithIndex(_ index: NSInteger) {
        if index < 0 || index > childControllerS.count - 1 {
            return
        }
        pageVC.setViewControllers([childControllerS[index]], direction: .forward, animated: false, completion: nil)
    }
}

extension PageManagerVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    //设置上一个控制器
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = childControllerS.index(of: viewController) else { return nil}
        if index == 0 || index == NSNotFound {
            return nil
        }
        return childControllerS[index - 1]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = childControllerS.index(of: viewController) else { return nil}
        if index == NSNotFound || index == childControllerS.count - 1 {
            return nil
        }
        return childControllerS[index + 1]
    }
    //设置控制器数量
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return childControllerS.count
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let temp_vc = pageViewController.viewControllers?[0] else { return }
        let index = childControllerS.index(of: temp_vc)!
        self.delegate?.pageManagerDidFinishSelectedVC(indexOfVC: index)
    }
}
