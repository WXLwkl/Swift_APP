//
//  Constant.swift
//  SwiftDemo
//
//  Created by xingl on 2017/4/26.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import Foundation

import UIKit

/***************  常用宽度  ********************/
// 屏幕宽度
let kScreenH = UIScreen.main.bounds.height
// 屏幕高度
let kScreenW = UIScreen.main.bounds.width

let kMainWindow = UIApplication.shared.keyWindow

let kNavbarHeight:CGFloat   = 64
let TheUserDefaults         = UserDefaults.standard
let kDeviceVersion          = Float(UIDevice.current.systemVersion)
let kTabBarHeight:CGFloat   = 49

let kThemeColor     = UIColor(red: 63.0/255.0, green: 67.0/255.0, blue: 76.0/255.0, alpha: 1.0)
let kBackGroundColor     = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)


/***************  常用按钮颜色  ********************/
let kBtnWhite = RGBA(r: 0.97, g: 0.97, b: 0.97, a: 1.00)
let kBtnDisabledWhite = RGBA(r: 0.97, g: 0.97, b: 0.97, a: 0.30)
let kBtnGreen = RGBA(r: 0.15, g: 0.67, b: 0.16, a: 1.00)
let kBtnDisabledGreen = RGBA(r: 0.65, g: 0.87, b: 0.65, a: 1.00)
let kBtnRed = RGBA(r: 0.89, g: 0.27, b: 0.27, a: 1.00)
// 分割线颜色
let kSplitLineColor = RGBA(r: 0.78, g: 0.78, b: 0.80, a: 1.00)
// 常规背景颜色
let kCommonBgColor = RGBA(r: 0.92, g: 0.92, b: 0.92, a: 1.00)
let kSectionColor = RGBA(r: 0.94, g: 0.94, b: 0.96, a: 1.00)
// 导航栏背景颜色
let kNavBarBgColor = normalRGBA(r: 20, g: 20, b: 20, a: 0.9)

// 表情键盘颜色大全
let kChatBoxColor = normalRGBA(r: 244.0, g: 244.0, b: 246.0, a: 1.0)
let kLineGrayColor = normalRGBA(r: 188.0, g: 188.0, b: 188.0, a: 0.6)




