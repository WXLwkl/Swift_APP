//
//  CustomTabBar.swift
//  CustomTabbar
//
//  Created by xingl on 2017/6/23.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit


protocol CustomBarButtonDelegate: NSObjectProtocol {
    func barButtonAction(_ sender: UIButton)
}



class CustomTabBar: UITabBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    weak var delegateTabbar: CustomBarButtonDelegate?
    
    let addButton: UIButton = UIButton()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        let topView = UIView(frame: CGRect(x: 0, y: -1, width: self.bounds.width, height: 1))
        topView.backgroundColor = UIColor.lightGray
        self.addSubview(topView)

        self.addSubview(addButton)
        addButton.setBackgroundImage(#imageLiteral(resourceName: "post_normal"), for: .normal)
        addButton.adjustsImageWhenHighlighted = false
        addButton.addTarget(self, action: #selector(centerButtonClick(_:)), for: .touchUpInside)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.addSubview(addButton)
        addButton.addTarget(self, action: #selector(centerButtonClick(_:)), for: .touchUpInside)
    }
    
    func centerButtonClick(_ sender: UIButton)
    {
        print("-调用协议方法-------->")
        self.delegateTabbar?.barButtonAction(sender)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var itemX: CGFloat = 0.0
        let add: CGFloat   = CGFloat(self.items!.count)
        let itemW: CGFloat = self.bounds.size.width / (add + 1)
        
        var itemCurrent: CGFloat = 0
        
        for item in self.subviews {
            
            if NSStringFromClass(item.classForCoder) == "UITabBarButton" {
                if itemCurrent == 2 {
                    itemCurrent = 3
                }
                itemX = itemCurrent * itemW
                item.x = itemX
                item.width = itemW;
                itemCurrent += 1
            } 
        }
        // 算出加号的位置
//        self.addButton.bounds.size = CGSize(width: itemW, height: itemH + 30)  //(itemW, itemH + 30)
        self.addButton.sizeToFit()
        self.addButton.center = CGPoint(x: self.bounds.width/2, y: 5)
        
    }
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden == false {
            let newPoint: CGPoint
//            if #available(iOS 8.0, *) {
                newPoint = self.convert(point, to: self.addButton)
//            } else {
//                // Fallback on earlier versions
//            }
            //判断点击的店是否在中间按钮的范围里面，如果在 说明响应的范围就是中间按钮的范围
            if self.addButton.point(inside: newPoint, with: event) {
                return self.addButton
            } else {
                return super.hitTest(point, with: event)
            }
            
        } else {
            return super.hitTest(point, with: event)
        }
    }

}
