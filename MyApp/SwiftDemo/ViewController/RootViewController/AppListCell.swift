//
//  AppListCell.swift
//  SwiftDemo
//
//  Created by xingl on 2017/4/19.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

class AppListCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var applistModel: ApplistModel? {
        didSet {
            iconImage.image = UIImage(named: applistModel?.image ?? "")
            titleLabel.text = applistModel?.title
        }
    }
    
}
