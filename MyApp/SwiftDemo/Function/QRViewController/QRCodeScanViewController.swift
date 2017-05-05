//
//  QRCodeScanViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2017/4/27.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit
import AVFoundation

//扫描容器
var customContainerView: UIView!
//底部工具条
var customTabbar:UITabBar!
/// 结果文本
var customLabel: UILabel!
//冲击波视图
var scanLineImageView: UIImageView!
//框
var borderImageView: UIImageView!

class QRCodeScanViewController: RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "扫一扫"
        
        configUI()
        startAnimation()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configUI() {
        let rightItem: UIBarButtonItem = UIBarButtonItem(title: "相册", style: .plain, target: self, action: #selector(QRCodeScanViewController.choosePicFromPhotoLib(sender:)))
        navigationItem.rightBarButtonItem = rightItem
        
//        扫描容器
        customContainerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth-100, height: kScreenWidth-100))
        customContainerView.center = view.center
        customContainerView.clipsToBounds = true
        view.addSubview(customContainerView)
        
        customLabel = UILabel(frame: CGRect(x: 0, y: kNavbarHeight+20, width: kScreenWidth, height: 80))
        customLabel.textColor = UIColor.red
        customLabel.numberOfLines = 0
        customLabel.textAlignment = NSTextAlignment.center
        view.addSubview(customLabel)
        
        borderImageView = UIImageView(frame: customContainerView.frame)
        borderImageView.image = UIImage(named: "codeframe")
        borderImageView.clipsToBounds = true
        view.addSubview(borderImageView)
        
        scanLineImageView = UIImageView(frame: CGRect(x: 0, y: -customContainerView.frame.height, width: customContainerView.frame.width, height: customContainerView.frame.height))
        scanLineImageView.image = UIImage(named: "qrcode_scanline_qrcode")
        borderImageView.addSubview(scanLineImageView)
        
        customTabbar = UITabBar(frame: CGRect(x: 0, y: UIScreen.main.bounds.height-49, width: kScreenWidth, height: kTabBarHeight))
        customTabbar.delegate = self
        customTabbar.backgroundColor = .red
        customTabbar.barTintColor = UIColor.red
        view.addSubview(customTabbar)
        
        let leftBarItem: UITabBarItem = UITabBarItem(title: "", image: UIImage(named: "qrcode_tabbar_icon_qrcode"), selectedImage: UIImage(named: "qrcode_tabbar_icon_qrcode_highlighted"))
        let rightBarItem: UITabBarItem = UITabBarItem(title: "", image: UIImage(named: "qrcode_tabbar_icon_barcode"), selectedImage: UIImage(named: "qrcode_tabbar_icon_barcode_highlighted"));
        customTabbar.setItems([leftBarItem, rightBarItem], animated: true)
        customTabbar.selectedItem = customTabbar.items?.first
        scanQRCode()
    }
   
    
    func choosePicFromPhotoLib(sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePickerVC = UIImagePickerController.init()
            imagePickerVC.delegate = self
            imagePickerVC.allowsEditing = true
            present(imagePickerVC, animated: true) {
                printLog(message: "completion")
            }
        }
    }
    
    private func scanQRCode() {
        if !session.canAddInput(input) {
            return
        }
        if !session.canAddOutput(output) {
            return
        }
//        1、添加输入和输出到会话中
        session.addInput(input)
        session.addOutput(output)
//        2、设置输出能够解析的数据类型（设置数据类型一定要在输出对象添加到会话后才能设置）
        output.metadataObjectTypes = output.availableMetadataObjectTypes
//        3、设置监听、监听输出解析到的数据
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//        4、添加预览图层
        view.layer.insertSublayer(previewLayer, at: 0)
        previewLayer.frame = view.bounds
//        5、添加容器图层
        view.layer.addSublayer(containerLayer)
        containerLayer.frame = view.bounds
//        6、开始扫描
        session.startRunning()
    }
    func startAnimation() {
        UIView.animate(withDuration: 1.5) { () -> Void in
            UIView.setAnimationRepeatCount(MAXFLOAT)
            
            if (customTabbar.selectedItem == customTabbar.items?.first) {
                scanLineImageView.frame = CGRect(x: scanLineImageView.frame.origin.x, y: scanLineImageView.frame.origin.y+customContainerView.frame.size.height+100, width: scanLineImageView.frame.width, height: scanLineImageView.frame.height)
            } else {
                scanLineImageView.frame = CGRect(x:scanLineImageView.frame.origin.x, y:borderImageView.frame.origin.y+borderImageView.frame.size.height, width:borderImageView.frame.size.width, height:borderImageView.frame.size.height)
            }
        }
    }
    
//MARK: - 懒加载
//    设备输入
    private lazy var input: AVCaptureDeviceInput? = {
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        return try? AVCaptureDeviceInput(device: device)
    }()
//    创建会话
    lazy var session: AVCaptureSession = AVCaptureSession()
//    输出设备
    private lazy var output: AVCaptureMetadataOutput = {
        let out = AVCaptureMetadataOutput()
        let viewRect = self.view.frame
        let containerRect = customContainerView.frame
        let x = containerRect.origin.y / viewRect.height
        let y = containerRect.origin.x / viewRect.width
        let width = containerRect.height / viewRect.height
        let heigth = containerRect.width / viewRect.width
        
        out.rectOfInterest = CGRect(x: x, y: y, width: width, height: heigth)
        
        return out
    }()
    
    lazy var containerLayer: CALayer = CALayer()
//    预览图层
    lazy var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
}
//MARK: - 扩展实现UINavigationControllerDelegate, UIImagePickerControllerDelegate
extension QRCodeScanViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        1、读取选中的图片
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        guard let ciImage = CIImage(image: image) else { return }
//        2、冲选中的图片中读取二维码数据
//        2、1创建一个探测器
        if #available(iOS 8.0, *) {
            let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow])
//            2、2利用探测器探测数据
            let results = detector?.features(in: ciImage)
//            2、3取出探测到的数据
            for result in results! {
                printLog(message: (result as! CIQRCodeFeature).messageString)
                customLabel.text = (result as! CIQRCodeFeature).messageString
            }
        } else {
            
        }
        picker.dismiss(animated: true) { 
//            self.startAnimation()
        }
    }
}

//MARK: - UITabBarDelegate
extension QRCodeScanViewController: UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // 根据当前选中的按钮重新设置二维码容器高度
        if tabBar.selectedItem == customTabbar.items?.first {
            UIView.animate(withDuration: 0.5, animations: {  () -> Void in
                borderImageView.frame = customContainerView.frame
                borderImageView.center = self.view.center
                scanLineImageView.image = UIImage(named: "qrcode_scanline_qrcode")
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {  () -> Void in
                borderImageView.frame = CGRect(x: borderImageView.frame.origin.x, y: borderImageView.frame.origin.y, width: borderImageView.frame.width, height: borderImageView.frame.width/2)
                borderImageView.center = self.view.center
                scanLineImageView.image = UIImage(named: "qrcode_scanline_barcode")
            })
        }
    }
}

//MARK: - AVCaptureMetadataOutputObjectsDelegate
extension QRCodeScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        Tool.playAlertSound(sound: "noticeMusic.caf")
        scanLineImageView.layer.removeAllAnimations()
        session.stopRunning()
        
//        显示结果
        if metadataObjects.count > 0 {
            if let resultObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
                customLabel.text = resultObj.stringValue
            }
        }
        clearLayers()
//         2.拿到扫描到的数据
        guard let metadata = metadataObjects.last as? AVMetadataObject else{ return }
//         通过预览图层将corners值转换为我们能识别的类型
        let objc = previewLayer.transformedMetadataObject(for: metadata)
        // 3.对扫描到的二维码进行描边
        drawLines(objc: objc as! AVMetadataMachineReadableCodeObject)
    }
//    绘制描边
    private func drawLines(objc: AVMetadataMachineReadableCodeObject) {

        // result.corners:是数据坐标,必须使用预览图层将坐标转为位(上下文)的坐标
        guard let resultObj = previewLayer.transformedMetadataObject(for: objc) as? AVMetadataMachineReadableCodeObject else {return}
        
        
        ////        2、创建图层，用于保存绘制的矩形
        let layer = CAShapeLayer()
        layer.lineWidth = 2
        layer.strokeColor = UIColor.green.cgColor
        layer.fillColor = UIColor.clear.cgColor
        
        
        
        // 创建UIBezierPath，绘制矩形
        let path = UIBezierPath()
        var index = 0
        for corner in resultObj.corners {
            
            let dictCF = corner as! CFDictionary
            let point = CGPoint(dictionaryRepresentation: dictCF)!
            
            // 开始绘制
            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
            
            index = index + 1
        }
        
        

//        3、3关闭路径
        path.close()
        
        layer.path = path.cgPath
//        4、将用于保存矩形的图层添加到界面上
        containerLayer.addSublayer(layer)
    }
    
//    清空描边
    private func clearLayers() {
        guard let subLayers = containerLayer.sublayers else { return  }
        for layer in subLayers {
            layer.removeFromSuperlayer()
        }
    }
}
