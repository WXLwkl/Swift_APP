//
//  CollectionPrettyCell.swift
//  DYTV
//
//  Created by xingl on 2018/9/28.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {

    override var anchor: AnchorModel? {
        didSet {
            super.anchor = anchor
            
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }

    @IBOutlet weak var cityBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
