//
//  WaterWaveView.swift
//  SwiftDemo
//
//  Created by xingl on 2017/11/20.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

class WaterWaveView: UIView {

    lazy private var firstShapeLayer = CAShapeLayer()
    lazy private var secondShapeLayer = CAShapeLayer()
    lazy private var waveDisplayLink = CADisplayLink()
    
    ///  波动速度
    var waveSpeed: CGFloat = 0
    
    /// 水波振幅
    var waveAmplitude: CGFloat = 0
    
    /// 水波的高度
    var waveHeight: CGFloat = 0
    
    /// 水波颜色
    var waveColor: UIColor? {
        didSet {
            firstShapeLayer.fillColor = waveColor?.cgColor
            secondShapeLayer.fillColor = waveColor?.cgColor
        }
    }
    private var waveWidth: CGFloat = 0
    private var offsetX: CGFloat = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        self.waveSpeed = 0.1
        self.waveAmplitude = 8; 
        self.waveWidth = 2.5 * CGFloat(Double.pi) / self.bounds.width
        self.waveHeight = self.frame.height / 2
        
        firstShapeLayer.fillColor = UIColor.init(colorLiteralRed: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.5).cgColor
        secondShapeLayer.fillColor = UIColor.init(colorLiteralRed: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 0.5).cgColor
        layer.addSublayer(firstShapeLayer)
        layer.addSublayer(secondShapeLayer)
        
        waveDisplayLink = CADisplayLink(target: self, selector: #selector(getCurrentWave))
        waveDisplayLink.add(to: RunLoop.current, forMode: .commonModes)
    }
    
    @objc private func getCurrentWave()  {
        
        offsetX += waveSpeed
        
        /// 第一条波浪
        let firstPath = CGMutablePath()
        var firstY = bounds.size.width / 2
        firstPath.move(to: CGPoint(x: 0, y: firstY))
        for i in 0...Int(bounds.size.width) {
            firstY = waveAmplitude * sin(waveWidth * CGFloat(i) + offsetX) + waveHeight
            firstPath.addLine(to: CGPoint(x: CGFloat(i), y: firstY))
        }
        firstPath.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
        firstPath.addLine(to: CGPoint(x: 0, y: bounds.size.height))
        firstPath.closeSubpath()
        firstShapeLayer.path = firstPath
        
        let secondPath = CGMutablePath()
        var secondY = bounds.size.width / 2
        secondPath.move(to: CGPoint(x: 0, y: secondY))
        
        for i in 0...Int(bounds.size.width) {
            secondY = waveAmplitude * sin(waveWidth * CGFloat(i) + offsetX - bounds.size.width / 2 ) + waveHeight
            secondPath.addLine(to: CGPoint(x: CGFloat(i), y: secondY))
        }
        secondPath.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
        secondPath.addLine(to: CGPoint(x: 0, y: bounds.size.height))
        secondPath.closeSubpath()
        secondShapeLayer.path = secondPath
    }
    public func distroyView() {
        waveDisplayLink.invalidate()
    }
    deinit {
        print("WaterWaveView...deinit")
    }
    
}
