//
//  CollectionNomalCell.swift
//  DYTV
//
//  Created by xingl on 2018/9/28.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

class CollectionNomalCell: CollectionBaseCell {

    override var anchor: AnchorModel? {
        didSet {
            super.anchor = anchor
            
            roomNameLabel.text = anchor?.room_name
        }
    }
    @IBOutlet weak var roomNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // 如果要用代码自定义就重写init方法
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }

}

