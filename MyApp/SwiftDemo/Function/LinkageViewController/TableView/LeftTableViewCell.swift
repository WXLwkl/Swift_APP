//
//  LeftTableViewCell.swift
//  SwiftDemo
//
//  Created by xingl on 2017/5/8.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

class LeftTableViewCell: UITableViewCell {
    
    lazy var nameLabel = UILabel()
    private lazy var yellowView = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        nameLabel.frame = CGRect(x: 10, y: 10, width: 60, height: 40)
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 15)

        nameLabel.textColor = UIColor.init(red: 130.0/255.0, green: 130.0/255.0, blue: 130.0/255.0, alpha: 1)

        nameLabel.highlightedTextColor = UIColor.init(red: 253.0/255.0, green: 212.0/255.0, blue: 49.0/255.0, alpha: 1)
        contentView.addSubview(nameLabel)
        
        yellowView.frame = CGRect(x: 0, y: 5, width: 5, height: 45)

        yellowView.backgroundColor = UIColor.init(red: 253.0/255.0, green: 212.0/255.0, blue: 49.0/255.0, alpha: 1)
        contentView.addSubview(yellowView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        contentView.backgroundColor = selected ? UIColor.white : UIColor(white: 0, alpha: 0.1)
        isHighlighted = selected
        nameLabel.isHighlighted = selected
        yellowView.isHidden = !selected
    }

}
