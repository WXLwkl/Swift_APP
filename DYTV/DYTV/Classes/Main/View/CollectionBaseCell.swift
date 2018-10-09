//
//  CollectionBaseCell.swift
//  DYTV
//
//  Created by xingl on 2018/9/29.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchor: AnchorModel? {
        didSet {
            guard let anchor = anchor else { return }
            
            var onlineStr: String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineLabel.text = onlineStr
            nickNameLabel.text = anchor.nickname
            
            guard let iconUrl = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconUrl)
        }
    }
}
