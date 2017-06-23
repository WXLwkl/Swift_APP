//
//  Common.swift
//  SwiftDemo
//
//  Created by xingl on 2017/3/21.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit


// MARK:- 颜色方法
func normalRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r, green: g, blue: b, alpha: a)
}



// MARK:- 自定义打印方法
func printLog<T>(_ message: T,
              file: String = #file,
              method: String = #function,
              line: Int = #line)
{
    #if DEBUG
        print("[\((file as NSString).lastPathComponent) \(method)] [line:\(line)]: \(message)")
    #endif
}


// MARK:- 通知常量
// 通讯录好友发生变化
let kNoteContactUpdateFriends  = "noteContactUpdateFriends"
// 添加消息
let kNoteChatMsgInsertMsg    = "noteChatMsgInsertMsg"
// 更新消息状态
let kNoteChatMsgUpdateMsg = "noteChatMsgUpdateMsg"
// 重发消息状态
let kNoteChatMsgResendMsg = "noteChatMsgResendMsg"
// 点击消息中的图片
let kNoteChatMsgTapImg = "noteChatMsgTapImg"
// 音频播放完毕
let kNoteChatMsgAudioPlayEnd = "noteChatMsgAudioPlayEnd"
// 视频开始播放
let kNoteChatMsgVideoPlayStart = "noteChatMsgVideoPlayStart"
/* ============================== 录音按钮长按事件 ============================== */
let kNoteChatBarRecordBtnLongTapBegan = "noteChatBarRecordBtnLongTapBegan"
let kNoteChatBarRecordBtnLongTapChanged = "noteChatBarRecordBtnLongTapChanged"
let kNoteChatBarRecordBtnLongTapEnded = "noteChatBarRecordBtnLongTapEnded"
/* ============================== 与网络交互后返回 ============================== */
let kNoteWeChatGoBack = "noteWeChatGoBack"

// MARK:- SDK
let kAppKey = "8c05fc8cf099c153dcb5f2daec46821d"
