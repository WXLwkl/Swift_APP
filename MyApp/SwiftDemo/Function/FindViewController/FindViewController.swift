//
//  FindViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2017/5/23.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

class FindViewController: RootViewController {

    lazy var subviewTitles: [String] = {
        let array = ["QQ","微信","支付宝","英雄联盟","王者荣耀","爱奇艺","百度","推酷","腾讯手机管家"]
        return array
    }()
    
    lazy var VCManager: VCManagerView = {
        let manager = VCManagerView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 44))
        manager.delegate = self
        
        return manager
    }()
    
    lazy var pageManager: PageManagerVC = {
        let managerVC = PageManagerVC(superController: self, childControllerS: [TestViewController(),TestViewController(),TestViewController(),TestViewController(),TestViewController(),TestViewController(),TestViewController(),TestViewController(),TestViewController()])
        managerVC.delegate = self
        return managerVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.title = "发现"
        
        self.view.addSubview(VCManager)
        self.view.addSubview(pageManager.view)
        
        VCManager.title_font = UIFont.systemFont(ofSize: 15)
        VCManager.slideWidthType = .ButtonTitleWidth
        VCManager.title_array = subviewTitles
        
        
        setConstraint()  
    }

    fileprivate func setConstraint() {
        pageManager.view.snp.makeConstraints { (make) in
            make.top.equalTo(VCManager.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension FindViewController:VCManagerViewDelegate,PageManagerVCDelegate {
    
    func VCManagerViewDidSelected(_ VCManagerView: VCManagerView, index: NSInteger, title: String) {
        
        pageManager.setCurrentVCWithIndex(index)
    }
    func pageManagerDidFinishSelectedVC(indexOfVC: NSInteger) {
        
        VCManager.reloadSelectedBT(at: indexOfVC)
    }
}
