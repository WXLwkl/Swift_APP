//
//  CollectionHeaderView.swift
//  DYTV
//
//  Created by xingl on 2018/9/28.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    
    var group: AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
        }
    }
    
//    private lazy var titleLabel: UILabel = {
//        let titleLabel = UILabel()
//        titleLabel.font = UIFont.systemFont(ofSize: 16)
//        titleLabel.textColor = UIColor.darkGray
//        return titleLabel
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
}

//extension CollectionHeaderView {
//    private func setupUI() {
//        setupLine()
//        addSubview(titleLabel)
//        titleLabel.frame = CGRect(x: 10, y: 15, width: 100, height: 20)
//    }
//    
//    private func setupLine() {
//        let line = UIView()
//        line.backgroundColor = UIColor(r: 234, g: 234, b: 234)
//        line.frame = CGRect(x: 0, y: 0, width: frame.width, height: 10)
//        addSubview(line)
//    }
//}
//// MARK: - 对外接口
//extension CollectionHeaderView {
//    
//    func setTitle(_ title: String) {
//        titleLabel.text = title
//    }
//    
//}

extension CollectionHeaderView {
    class func collectionHeaderView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
