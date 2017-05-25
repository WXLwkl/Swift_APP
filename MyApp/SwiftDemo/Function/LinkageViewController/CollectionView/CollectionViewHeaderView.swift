//
//  CollectionViewHeaderView.swift
//  SwiftDemo
//
//  Created by xingl on 2017/5/8.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

class CollectionViewHeaderView: UICollectionReusableView {
    
    private lazy var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.init(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        
        titleLabel.frame = CGRect(x: 0, y: 5, width: kScreenW - 80, height: 20)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
    }
    
    func setDatas(_ model : CollectionCategoryModel) {
        
        guard let name = model.name else { return }
        
        titleLabel.text = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
