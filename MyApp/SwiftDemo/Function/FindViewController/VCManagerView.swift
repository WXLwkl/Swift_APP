//
//  VCManagerView.swift
//  SwiftDemo
//
//  Created by xingl on 2017/5/23.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

enum slideWidthEnum: NSInteger {
    case ButtonWidth = 1
    case ButtonTitleWidth = 2
}

//代理方法
protocol VCManagerViewDelegate: NSObjectProtocol {
    func VCManagerViewDidSelected(_ vcManagerView: VCManagerView, index: NSInteger, title: String)
}

class VCManagerView: UIView {
    //点击时颜色
    var selectedColor = UIColor(red: 0.96, green: 0.39, blue: 0.26, alpha: 1.0) {
        didSet{
            reloadBT_Colors()
        }
    }
    //非点击时颜色
    var normalColor = UIColor(red: 0.38, green: 0.39, blue: 0.40, alpha: 1.0){
        didSet{
            reloadBT_Colors()
        }
    }

//    按钮数组
    var BT_array: [UIButton] = [UIButton]()
    //当前按钮
    var selected_BT: UIButton!
    //按钮字体
    var title_font: UIFont?
    //滑块的宽度1.跟按钮宽度一样2.跟按钮title宽度一样，默认2
    var slideWidthType: slideWidthEnum = .ButtonTitleWidth
    //点击按钮的代理回调
    weak var delegate: VCManagerViewDelegate?
    //按钮title数组
    var title_array: [String] = []{
        didSet {
            setBTs()
        }
    }
    //按钮宽度
    fileprivate var kBT_W: CGFloat? {
        get {
            if self.title_array.count >= 5 {
                return kScreenW / 5
            } else {
                return kScreenW / CGFloat(self.title_array.count)
            }
        }
    }
    //滑动视图
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: self.kBT_W! * CGFloat(self.title_array.count), height: self.height)
        scrollView.delegate = self
        self.addSubview(scrollView)
        return scrollView
    }()
    //滑块视图
    fileprivate lazy var sliderView: UIView = {
        let slider = UIView.init()
        self.addSubview(slider)
        self.bringSubview(toFront: slider)
        slider.layer.cornerRadius = 1
        slider.layer.masksToBounds = true
        return slider
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.yellow
    }
   
}

extension VCManagerView {
    fileprivate func setBTs() {
        for index in 0..<title_array.count {
            let title = title_array[index]
            let bt = UIButton(type: .custom)
            bt.setTitle(title, for: .normal)
            bt.setTitleColor(normalColor, for: .normal)
            bt.setTitleColor(selectedColor, for: .selected)
            bt.setTitleColor(selectedColor, for: .highlighted)
            bt.frame = CGRect(x: CGFloat(index) * self.kBT_W!, y: 0, width: self.kBT_W!, height: self.height)
            if title_font != nil {
                bt.titleLabel?.font = title_font!
            } else {
                bt.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            }
            bt.adjustsImageWhenDisabled = false
            bt.adjustsImageWhenHighlighted = false
            bt.addTarget(self, action: #selector(subBT_Click(_ :)), for: .touchUpInside)
            self.BT_array.append(bt)
            self.scrollView.addSubview(bt)
        }
        guard let firstBt = BT_array.first else { return }
        
        sliderView.backgroundColor = self.selectedColor
        sliderView.y = firstBt.height - 2
        selectorBT_beFirst(firstBt, true)
    }
    //按钮的点击事件代理部分
    @objc fileprivate func subBT_Click(_ bt: UIButton) {
        if bt == selected_BT {
            return
        }
        delegate?.VCManagerViewDidSelected(self, index: BT_array.index(of: bt)!, title: (bt.titleLabel?.text)!)
        selectorBT_beFirst(bt, false)
    }
    //按钮点击事件UI部分
    fileprivate func selectorBT_beFirst(_ bt: UIButton, _ beFirst: Bool) {
        self.selected_BT = bt
        bt.isSelected = true
        otherBTset(bt)
        
        var offset = bt.centerX - self.width * 0.5
        let max = scrollView.contentSize.width - self.width
        
        if offset < 0 {
            offset = 0
        }
        if offset > max {
            offset = max
        }
        if scrollView.contentSize.width < scrollView.width {
            offset = 0
        }
        let rect = selected_BT.convert(self.frame, to: nil)
        var width: CGFloat?
        if slideWidthType == .ButtonTitleWidth {
            width = (bt.titleLabel?.text)!.getTextSize(font: (bt.titleLabel?.font)!, size: bt.size).width
        } else {
            width = bt.width
        }
        if beFirst {
            
            self.sliderView.frame = CGRect.init(x: rect.origin.x + (self.kBT_W! - width!)/2, y: self.sliderView.y, width: width!, height: 2)
        }else{
            
            UIView.animate(withDuration: 0.2, animations: {() -> Void in
                
                self.sliderView.frame = CGRect.init(x: rect.origin.x + (self.kBT_W! - width!)/2, y: self.sliderView.y, width: width!, height: 2)
                self.scrollView.contentOffset = CGPoint.init(x: offset, y: 0)
                
            }){finishit -> Void in
                
            }
        }
    }
    //选择指定按钮
    func reloadSelectedBT(at index: NSInteger) {
        if index < 0 || index > BT_array.count - 1 {
            return
        }
        let bt = BT_array[index]
        selectorBT_beFirst(bt, false)
    }
    //将未选择的按钮刷新着色
    fileprivate func otherBTset(_ bt: UIButton) {
        for temp_bt in BT_array {
            if temp_bt == bt {
                continue
            }
            temp_bt.isSelected = false
        }
    }
    //刷新颜色
    fileprivate func reloadBT_Colors() {
        for item in BT_array {
            item.setTitleColor(normalColor, for: .normal)
            item.setTitleColor(selectedColor, for: .selected)
            item.setTitleColor(selectedColor, for: .highlighted)
        }
        guard let firstBt = BT_array.first else { return }
        firstBt.isSelected = true
        sliderView.backgroundColor = self.selectedColor
    }
}

extension VCManagerView: UIScrollViewDelegate {
    
    //滑动视图代理
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let rect = selected_BT.convert(self.frame, to: nil)
        var width:CGFloat?
        
        if slideWidthType == .ButtonTitleWidth {
            
            width = (self.selected_BT.titleLabel?.text)!.getTextSize(font: (self.selected_BT.titleLabel?.font)!, size: self.selected_BT.size).width
            
        }else
        {
            width = self.selected_BT.width
        }
        
        UIView.animate(withDuration: 0.2, animations: {() -> Void in
            
            self.sliderView.frame = CGRect.init(x: rect.origin.x + (self.kBT_W! - width!)/2, y: self.sliderView.y, width: width!, height: 2)
            
        }){finished -> Void in
            
            
        }
    }

}
