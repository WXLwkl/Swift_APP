//
//  HomeViewController.swift
//  DYTV
//
//  Created by xingl on 2018/9/26.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 44

class HomeViewController: BaseViewController {

    private lazy var pageTitleView: PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStateBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView: PageContentView = { [weak self] in
        let contentH = kScreenH - kStateBarH - kNavigationBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStateBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        var childVCs = [UIViewController]()
        childVCs.append(RecommendViewController())
        childVCs.append(GameViewController())
        childVCs.append(AmuseViewController())
        childVCs.append(FunnyViewController())
        
        let contentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationItem.title = "首页"
        setupUI()
    }
    


}
// MARK: - 设置UI界面
extension HomeViewController {
    override func setupUI() {
        
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.red
    }
    
    private func setupNavigationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let size = CGSize(width: 30, height: 30)
        
        let historyItem = UIBarButtonItem(imageName: "icon_scan_normal", hightImageName: "icon_scan_highlighted", size: size)
        let searchItem = UIBarButtonItem(imageName: "icon_search_normal", hightImageName: "icon_search_highlighted", size: size)
        let scanItem = UIBarButtonItem(imageName: "icon_scan_normal", hightImageName: "icon_scan_highlighted", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, scanItem]
    }
    
    
}
// MARK: - delegate
extension HomeViewController: PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }
}
extension HomeViewController: PageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitle(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
