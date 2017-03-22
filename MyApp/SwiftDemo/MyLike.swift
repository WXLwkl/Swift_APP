//
//  MyLike.swift
//  SwiftDemo
//
//  Created by xingl on 2017/3/21.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import Foundation


func printLog<T>(message: T,
              file: String = #file,
              method: String = #function,
              line: Int = #line)
{
    #if DEBUG
        print("[\((file as NSString).lastPathComponent) \(method)] [line:\(line)]: \(message)")
    #endif
}








