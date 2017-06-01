//
//  XLPopMenu.swift
//  SwiftDemo
//
//  Created by xingl on 2017/5/2.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

let PopMenuCellID = "PopMenuCellID"

public enum XLPopMenuType : Int {
    case white
    case dark
}

//代理方法
protocol XLPopMenuDelegate: NSObjectProtocol {
    func xlPopMenu(_ popMenu: XLPopMenu, didSelectItemAt index: NSInteger)
}

//MARK: - XLPopMenu
class XLPopMenu: UIView {

    var popMenuDidSelectedBlock: ((_ index: Int, _ title: String) -> ())?
    
    /// 圆角半径 Default is 5.0
    var kCornerRadius: CGFloat = 5.0 {
        didSet {
            mainView?.layer.mask = drawMaskLayer()
            if self.y < anchorPoint.y {
                mainView?.layer.mask?.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat.pi))
            }
        }
    }
    /// 是否显示阴影 Default is true
    var isShowShadow: Bool = true {
        didSet {
            if !isShowShadow {
                self.layer.shadowOpacity = 0.0
                self.layer.shadowOffset = CGSize(width: 0, height: 0)
                self.layer.shadowRadius = 0.0
            }
        }
    }
    /// 设置偏移量 Default is 0.0
    var offset: CGFloat = 0.0 {
        didSet {
            if offset < 0 {
                offset = 0
            }
            self.y += self.y >= anchorPoint.y ? offset : -offset
        }
    }
    /// 设置字体大小 Default is 15
    var fontSize: CGFloat = 15.0 {
        didSet {
            contentView?.reloadData()
        }
    }
    /// 设置字体颜色 Default is black
    var textColor: UIColor = UIColor.black  {
        didSet {
            contentView?.reloadData()
        }
    }
    /// 设置显示模式 Default is white
    var type: XLPopMenuType = .white {
        
        didSet {
            switch self.type {
            case .dark:
                
                textColor = UIColor.lightGray
                contentColor = UIColor(red: 0.25, green: 0.27, blue: 0.29, alpha: 1)
                separatorColor = UIColor.lightGray
                
            default:
                
                textColor = UIColor.black
                contentColor = UIColor.white
                separatorColor = UIColor.lightGray
                
            }
            mainView?.backgroundColor = contentColor
            contentView?.reloadData()
        }
    }
    
    /// 代理
    weak var delegate: XLPopMenuDelegate?

    
    
    fileprivate var mainView: UIView?
    fileprivate var contentView: UITableView?
    fileprivate var bgView: UIView?
    
    fileprivate var anchorPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    fileprivate var kArrowHeight: CGFloat = 10
    fileprivate var kArrowWidth: CGFloat = 15
    fileprivate var kArrowPosition: CGFloat?
    fileprivate var kButtonHeight: CGFloat = 44
    
    fileprivate var titles: NSArray?
    fileprivate var icons: NSArray?
    
    fileprivate var contentColor: UIColor = UIColor.white
    fileprivate var separatorColor: UIColor = UIColor.lightGray
    
    //MARK: - init
    init(titles: NSArray, icons: NSArray, menuWidth: CGFloat)  {
        
        super.init(frame: CGRect.zero)
        
        
        self.titles = titles
        self.icons  = icons

        self.width = menuWidth
        self.height = (titles.count > 5 ? 5 * kButtonHeight : CGFloat(titles.count) * kButtonHeight) + 2 * kArrowHeight
        kArrowPosition = 0.5 * self.width - 0.5 * kArrowWidth
        
    
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setupSubviews() {
        self.alpha = 0
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2.0
    
        //带箭头的view
        mainView = UIView(frame: self.bounds)
        mainView?.backgroundColor = contentColor
        mainView?.layer.cornerRadius = kCornerRadius
        mainView?.layer.masksToBounds = true
        
        contentView = UITableView(frame: (mainView?.bounds)!, style: .plain)
        contentView?.backgroundColor = UIColor.clear
        contentView?.delegate = self
        contentView?.dataSource = self
        contentView?.bounces = (titles?.count)! > 5 ? true : false
        contentView?.register(XLPopMenuCell.self, forCellReuseIdentifier: PopMenuCellID)
        contentView?.tableFooterView = UIView()
        contentView?.separatorStyle = .none
        contentView?.height -= 2 * kArrowHeight
        contentView?.centerY = (mainView?.centerY)!
        
        mainView?.addSubview(contentView!)
        self.addSubview(mainView!)
        
        bgView = UIView(frame: UIScreen.main.bounds)
        bgView?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        bgView?.alpha = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(XLPopMenu.dismiss))
        bgView?.addGestureRecognizer(tap)
    }
    @objc fileprivate func dismiss() {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.layer.setAffineTransform(CGAffineTransform(scaleX: 0.1, y: 0.1))
            self.alpha = 0
            self.bgView?.alpha = 0
        }) { (_) in
            self.delegate = nil
            self.removeFromSuperview()
            self.bgView?.removeFromSuperview()
        }
        
    }
    fileprivate func show() {
        kMainWindow?.addSubview(bgView!)
        kMainWindow?.addSubview(self)
        self.layer.setAffineTransform(CGAffineTransform(scaleX: 0.1, y: 0.1))
        UIView.animate(withDuration: 0.25) {
            self.layer.setAffineTransform(CGAffineTransform(scaleX: 1.0, y: 1.0))
            self.alpha = 1
            self.bgView?.alpha = 1
        }
    }
    deinit {
        print("XLPopMenu被销毁了")
    }
    //MARK: - show
    func showMenu(on view: UIView) {
        let absoluteRect: CGRect = view.convert(view.bounds, to: kMainWindow)
        let relyPoint = CGPoint(x: absoluteRect.origin.x+absoluteRect.width/2.0, y: absoluteRect.origin.y+absoluteRect.height)
        
        mainView?.layer.mask = self.getMaskLayer(with: relyPoint)
        if self.y < anchorPoint.y {
            self.y -= absoluteRect.height
        }
        show()
    }
    func showMenu(at point: CGPoint) {
        
        mainView?.layer.mask = self.getMaskLayer(with: point)
        show()
    }
    
//MARK: - layer
    fileprivate func getMaskLayer(with point: CGPoint) -> CAShapeLayer {
        self.setArrowPoint(at: point)
        var layer = self.drawMaskLayer()
        self.determineAnchorPoint()
        if self.frame.maxY > kScreenH {
            kArrowPosition = self.width - kArrowPosition! - kArrowWidth
            layer = self.drawMaskLayer()
            layer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat.pi))
            self.y = anchorPoint.y - self.height
        }
        self.y += self.y >= anchorPoint.y ? offset : -offset
        return layer
    }
    
    /// 该方法确定三角最左端的位置
    ///
    /// - Parameter point: 点击的位置
    fileprivate func setArrowPoint(at point: CGPoint) {
        anchorPoint = point
        self.x = anchorPoint.x - kArrowPosition! - 0.5*kArrowWidth
        self.y = anchorPoint.y
        
        var maxX = self.frame.maxX
        var minX = self.frame.minX
        
        if maxX > kScreenW-10 {
            self.x = kScreenW - 10 - self.width
        } else if minX < 10 {
            self.x = 10
        }
        
        maxX = self.frame.maxX
        minX = self.frame.minX
        
        if (anchorPoint.x >= minX + kCornerRadius + 0.5*kArrowWidth) && (anchorPoint.x <= maxX - kCornerRadius - 0.5*kArrowWidth) {
            
            kArrowPosition = anchorPoint.x - minX - 0.5*kArrowWidth
        } else if anchorPoint.x < minX + kCornerRadius + 0.5*kArrowWidth {
            
            kArrowPosition = kCornerRadius
        } else {
            
            kArrowPosition = self.width - kCornerRadius - kArrowWidth
        }
        
    }
    
    /// 确定锚点
    fileprivate func determineAnchorPoint() {
        var aPoint: CGPoint
        if self.frame.maxY > kScreenH {
            
            aPoint = CGPoint(x: fabs(kArrowPosition!)/self.width, y: 1)
        } else {
            aPoint = CGPoint(x: fabs(kArrowPosition!)/self.width, y: 0)
        }
        setAnimationAnchorPoint(at: aPoint)
    }
    
    /// 设置动画锚点
    ///
    /// - Parameter point: 锚点
    fileprivate func setAnimationAnchorPoint(at point: CGPoint) {
        let originRect = self.frame
        self.layer.anchorPoint = point
        self.frame = originRect
    }
    
    fileprivate func drawMaskLayer() -> CAShapeLayer {
        let maskLayer = CAShapeLayer()
        maskLayer.frame = (mainView?.bounds)!
        
        let topRightArcCenter = CGPoint(x: self.width-kCornerRadius, y: kArrowHeight+kCornerRadius)
        let topLeftArcCenter = CGPoint(x: kCornerRadius, y: kArrowHeight+kCornerRadius)
        let bottomRightArcCenter = CGPoint(x: self.width-kCornerRadius, y: self.height-kArrowHeight-kCornerRadius)
        let bottemLeftArcCenter = CGPoint(x: kCornerRadius, y: self.height-kArrowHeight-kCornerRadius)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: kArrowHeight+kCornerRadius))
        path.addLine(to: CGPoint(x: 0, y: bottemLeftArcCenter.y))
        path.addArc(withCenter: bottemLeftArcCenter, radius: kCornerRadius, startAngle: -CGFloat.pi, endAngle: -CGFloat.pi-CGFloat.pi/2.0, clockwise: false)
        path.addLine(to: CGPoint(x: self.width-kCornerRadius, y: self.height-kArrowHeight))
        path.addArc(withCenter: bottomRightArcCenter, radius: kCornerRadius, startAngle: -CGFloat.pi-CGFloat.pi/2.0, endAngle: -2*CGFloat.pi, clockwise: false)
        path.addLine(to: CGPoint(x: self.width, y: kArrowHeight+kCornerRadius))
        path.addArc(withCenter: topRightArcCenter, radius: kCornerRadius, startAngle: 0, endAngle: -CGFloat.pi/2.0, clockwise: false)
        
        path.addLine(to: CGPoint(x: kArrowPosition!+kArrowWidth, y: kArrowHeight))
        path.addLine(to: CGPoint(x: kArrowPosition!+0.5*kArrowWidth, y: 0))
        path.addLine(to: CGPoint(x: kArrowPosition!, y: kArrowHeight))
        path.addLine(to: CGPoint(x: kCornerRadius, y: kArrowHeight))
        path.addArc(withCenter: topLeftArcCenter, radius: kCornerRadius, startAngle: -CGFloat.pi/2.0, endAngle: -CGFloat.pi, clockwise: false)
        path.close()
        maskLayer.path = path.cgPath
        return maskLayer
    }
    
}
//MARK: - UITableViewDelegate && UITableViewDataSource
extension XLPopMenu: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PopMenuCellID) as! XLPopMenuCell
        
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = textColor
        cell.textLabel?.font = UIFont.systemFont(ofSize: fontSize)
        cell.textLabel?.text = titles?[indexPath.row] as? String
        cell.separatorColor = separatorColor
        if (icons?.count)! >= indexPath.row + 1 {
            
            cell.imageView?.image = UIImage(named: icons?[indexPath.row] as! String)
            
        } else {
            cell.imageView?.image = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss()
        
        delegate?.xlPopMenu(self, didSelectItemAt: indexPath.row)
        
        // 回调
        if popMenuDidSelectedBlock != nil {
            popMenuDidSelectedBlock!(indexPath.row, titles?[indexPath.row] as! String)
        }
    }
}

//MARK: - XLPopMenuCell
class XLPopMenuCell: UITableViewCell {
    
    var separatorColor: UIColor = UIColor.lightGray
    {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
            separatorColor = UIColor.lightGray
            self.setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        
        let bezierPath = UIBezierPath(rect: CGRect(x: 0, y: rect.height-0.5, width: rect.width, height: 0.5))
        separatorColor.setFill()
        bezierPath.fill(with: .normal, alpha: 1)
        bezierPath.close()
    }
}
