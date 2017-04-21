//
//  Tools.swift
//  二维码生成与扫描
//
//  Created by xingl on 16/6/12.
//  Copyright © 2016年 yjpal. All rights reserved.
//

import UIKit

class Tools: NSObject {

    class func createQRForString(_ qrString: String?,qrImageNage: String?) -> UIImage? {
        
        if let sureQRString = qrString {
            let stringData = sureQRString.data(using: String.Encoding.utf8, allowLossyConversion: false)
            //创建一个二维码的滤镜
            let qrFilter = CIFilter(name: "CIQRCodeGenerator")
            qrFilter!.setValue(stringData, forKey: "inputMessage")
            qrFilter!.setValue("H", forKey: "inputCorrectionLevel")
            let qrCIImage = qrFilter!.outputImage
            //创建一个颜色滤镜，黑白色
            let colorFilter = CIFilter(name: "CIFalseColor")
            colorFilter!.setDefaults()
            colorFilter!.setValue(qrCIImage, forKey: "inputImage")
            
            colorFilter!.setValue(CIColor(red: 0,green: 0,blue: 0), forKey: "inputColor0")
            colorFilter!.setValue(CIColor(red: 1,green: 1,blue: 1), forKey: "inputColor1")
            //返回二维码image
            let codeImage = UIImage(ciImage: colorFilter!.outputImage!.applying(CGAffineTransform(scaleX: 5, y: 5)))
            
            //二维码中间的图标
            
            if let iconImage = UIImage(named: qrImageNage!) {
                
                let rect = CGRect(x: 0, y: 0, width: codeImage.size.width, height: codeImage.size.height)
                UIGraphicsBeginImageContext(rect.size)
                
                codeImage.draw(in: rect)
                
                let avaterSize = CGSize(width: rect.size.width*0.25, height: rect.size.height*0.25)
                let x = (rect.width - avaterSize.width)*0.5
                let y = (rect.height - avaterSize.height)*0.5
                
                iconImage.draw(in: CGRect(x: x, y: y, width: avaterSize.width, height: avaterSize.height))
                
                let resultImage = UIGraphicsGetImageFromCurrentImageContext()
                
                UIGraphicsEndImageContext()
                return resultImage
            }
            
            return codeImage
        }
        return nil
    }
}
