//
//  CustomViewCell.swift
//  CardDemo
//
//  Created by xingl on 2017/12/6.
//  Copyright © 2017年 xingl. All rights reserved.
//

import UIKit

class CustomViewCell: UICollectionViewCell {

    var title:String? {
        didSet {
            lable?.text = title
        }
    }
    var lable:UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        lable = UILabel(frame: CGRect(x: (SCREEN_WIDTH-80)/2-100/2, y:100 , width: 100, height: 100))
        lable?.backgroundColor = UIColor.purple
        lable?.text = title
        lable?.textAlignment = NSTextAlignment.center
        self.addSubview(lable!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
