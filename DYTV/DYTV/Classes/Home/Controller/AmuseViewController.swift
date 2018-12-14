//
//  AmuseViewController.swift
//  DYTV
//
//  Created by xingl on 2018/10/9.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

private let kMenuViewH: CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    
    fileprivate lazy var amuseVM: AmuseViewModel = AmuseViewModel()
    
    fileprivate lazy var menuView: AmuseMenuView = {
       let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
}

extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

extension AmuseViewController {
    
    override func loadData() {

        baseVM = amuseVM
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
            
            var tempGroup = self.amuseVM.anchorGroups
            tempGroup.removeFirst()
            self.menuView.groups = tempGroup
            
            //请求数据完成，停止加载动画
            self.loadDataFinished()
        }
    }
}
