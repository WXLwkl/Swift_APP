//
//  FunnyViewController.swift
//  DYTV
//
//  Created by xingl on 2018/10/16.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

private let kTopMargin: CGFloat = 8

class FunnyViewController: BaseAnchorViewController {

    fileprivate lazy var funnyVM: FunnyViewModel = FunnyViewModel()
    
    
}

extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = .zero
        
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
        
        
    }
}

extension FunnyViewController {
    override func loadData() {
        baseVM = funnyVM
        
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
            
            
            //请求数据完成，停止加载动画
            self.loadDataFinished()
        }
    }
}
