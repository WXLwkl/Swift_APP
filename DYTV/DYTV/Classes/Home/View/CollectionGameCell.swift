//
//  CollectionGameCell.swift
//  DYTV
//
//  Created by xingl on 2018/10/9.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var baseGame: BaseGameModel? {
        didSet { // 监听模型
            titleLabel.text = baseGame?.tag_name
            
            if let iconUrl = URL(string: baseGame?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconUrl, placeholder: UIImage(named: "icon_more"))
            } else {
                iconImageView.image = UIImage(named: "icon_more")
            }
            
            
            
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
