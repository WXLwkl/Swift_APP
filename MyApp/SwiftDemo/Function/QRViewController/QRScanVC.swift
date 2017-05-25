//
//  QrcodeVC.swift
//  二维码生成与扫描
//
//  Created by xingl on 16/6/12.
//  Copyright © 2016年 yjpal. All rights reserved.
//

import UIKit
import AVFoundation
private let scanAnimationDuration = 2.0//扫描时长

class QRScanVC: RootViewController {

    
    var scanPane: UIImageView!///扫描框
    var activityIndicatorView: UIActivityIndicatorView!
    var bottomView:UIView?
    var lightOn = false///开光灯
    
    
    lazy var scanLine: UIImageView = {
        let scanLine = UIImageView()
        scanLine.frame = CGRect(x: 0, y: 0, width: self.scanPane.bounds.width, height: 3)
        scanLine.image = UIImage(named: "QRCode_ScanLine")
        return scanLine
    }()
    
//    let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
//    let session = AVCaptureSession()
//    var layer: AVCaptureVideoPreviewLayer?
//    
//    let width = UIScreen.main.bounds.size.width
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubViews()
        setupScanSession()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startScan()
    }
    
//MARK: - SubViews
    private func initSubViews() {
        
        navigationItem.title = "扫一扫"
        
        scanPane = UIImageView.init(image: UIImage.init(named: "QRCode_ScanBox"))
        scanPane.frame = CGRect(x: 50, y: 120, width: kScreenW-100, height: kScreenW-100)

        self.view.addSubview(scanPane)

//        绘制模糊区域
        fuzzyArea(rect: scanPane.frame)
        
        let label: UILabel = UILabel.init()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.text = "将取景框对准二维/条形码，即可自动扫描"
        let y = scanPane.frame.maxY
        label.frame = CGRect(x: 0, y: y + 20, width: kScreenW, height: 30)
        self.view.addSubview(label)
        
        activityIndicatorView = UIActivityIndicatorView.init()
        activityIndicatorView.color = UIColor.orange
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.center = self.view.center
        initBottomView()
        view.layoutIfNeeded()
        scanPane.addSubview(scanLine)

    }
//MARK: - 绘制模糊区域
    private func fuzzyArea(rect: CGRect) {
        let minX = rect.minX
        let maxX = rect.maxX
        let minY = rect.minY
        let maxY = rect.maxY
        
        creacteFuzzyArea(rect: CGRect(x: 0, y: 0, width: kScreenW, height: minY))
        creacteFuzzyArea(rect: CGRect(x: 0, y: minY, width: minX, height: maxY-minY))
        creacteFuzzyArea(rect: CGRect(x: maxX, y: minY, width: kScreenW-maxX, height: maxY-minY))
        creacteFuzzyArea(rect: CGRect(x: 0, y: maxY, width: kScreenW, height: kScreenH-maxY))
        
    }
    private func creacteFuzzyArea(rect: CGRect) {

        let view = UIView(frame: rect)
        view.backgroundColor = .black
        view.alpha = 0.4
        self.view.addSubview(view)
    }
    
    
    private func initBottomView() {
        bottomView = {
            let tempbottomView = UIView.init(frame: CGRect(x: 0, y: kScreenH-kNavbarHeight-20, width: kScreenW, height: 20 + kNavbarHeight))
            tempbottomView.backgroundColor = kThemeColor
            self.view.addSubview(tempbottomView)
            return tempbottomView
        }()
        
        let imageViewWidth:CGFloat = kScreenW/3
        for index in 0...3 {

            let button: UIButton = UIButton(type: .custom)
            button.contentMode = .center
            button.frame = CGRect(x: imageViewWidth * CGFloat(index), y: 5, width: imageViewWidth, height: (bottomView?.frame.size.height)!-10)
            button.backgroundColor = UIColor.clear
            button.addTarget(self, action: #selector(bottomBtnClick(sender:)), for: .touchUpInside)
            button.tag = index
            bottomView?.addSubview(button)
            
            if index == 0 {
                button.setImage(UIImage(named: "qrcode_scan_btn_photo_nor"), for: UIControlState.normal)
            } else if index == 1 {
                button.setImage(UIImage(named: "qrcode_scan_btn_flash_nor"), for: UIControlState.normal)
                button.setImage(UIImage(named: "qrcode_scan_btn_scan_off"), for: UIControlState.selected)
            }else if index == 2 {
                button.setImage(UIImage(named: "qrcode_scan_btn_myqrcode_nor"), for: UIControlState.normal)
            }
            
        }
    }
    func bottomBtnClick(sender: UIButton) {
        
        switch sender.tag {
        case 0:
            photo()
        case 1:
            light(sender)
        case 2:
            
            printLog("我的二维码页面")
//            let vc2:MyQRCodeViewController = MyQRCodeViewController()
//            
//            self.navigationController?.pushViewController(vc2, animated: false)
            
        default:
            print("\(sender.tag)")
            
        }
    
    }

//MARK: - 闪光灯
    func light(_ sender: UIButton)
    {
        
        lightOn = !lightOn
        sender.isSelected = lightOn
        turnTorchOn()
        
    }
    ///闪光灯
    private func turnTorchOn()
    {
        
        guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) else
        {
            
            if lightOn
            {
                
                Tool.confirm(title: "温馨提示", message: "闪光灯不可用", controller: self)
                
            }
            
            return
        }
        
        if device.hasTorch
        {
            do
            {
                try device.lockForConfiguration()
                
                if lightOn && device.torchMode == .off
                {
                    device.torchMode = .on
                }
                
                if !lightOn && device.torchMode == .on
                {
                    device.torchMode = .off
                }
                
                device.unlockForConfiguration()
            }
            catch{ }
            
        }
        
    }

//MARK: - 相册
    func photo()
    {
        
        Tool.shared.choosePicture(self, editor: true, options: .photoLibrary) {[weak self] (image) in
            
            self!.activityIndicatorView.startAnimating()
            
            DispatchQueue.global().async {
                let recognizeResult = image.recognizeQRCode()
                let result = recognizeResult?.characters.count > 0 ? recognizeResult : "无法识别"
                DispatchQueue.main.async {
                    self!.activityIndicatorView.stopAnimating()
                    Tool.confirm(title: "扫描结果", message: result, controller: self!)
                }
            }
        }
        
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }

//MARK: - ScanSession
    var scanSession: AVCaptureSession?
    func setupScanSession() {
        do {
//            设置捕捉设备
            let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
//            设置设备输入输出
            let input = try AVCaptureDeviceInput(device: device)
            let output = AVCaptureMetadataOutput()
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//            设置会话
            let scanSession = AVCaptureSession()
            scanSession.canSetSessionPreset(AVCaptureSessionPresetHigh)
            
            if scanSession.canAddInput(input) {
                scanSession.addInput(input)
            }
            if scanSession.canAddOutput(output) {
                scanSession.addOutput(output)
            }
            
//            设置扫描类型
            output.metadataObjectTypes = [
            AVMetadataObjectTypeQRCode,
            AVMetadataObjectTypeCode39Code,
            AVMetadataObjectTypeCode93Code,
            AVMetadataObjectTypeCode128Code,
            AVMetadataObjectTypeCode39Mod43Code,
            AVMetadataObjectTypeEAN13Code,
            AVMetadataObjectTypeEAN8Code
            ]
            
//            预览图层
            let scanPreviewLayer = AVCaptureVideoPreviewLayer(session: scanSession)
            scanPreviewLayer!.videoGravity = AVLayerVideoGravityResizeAspectFill
            scanPreviewLayer!.frame = view.layer.bounds
            view.layer.insertSublayer(scanPreviewLayer!, at: 0)
            
//            设置扫描区域
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil, queue: nil, using: { (notify) in
                output.rectOfInterest = (scanPreviewLayer?.metadataOutputRectOfInterest(for: self.scanPane.frame))!
            })
//            保存会话
            self.scanSession = scanSession
        } catch {
            printLog(error)
            Tool.confirm(title: "温馨提示", message: "摄像头不可用", controller: self)
            return
        }
    }

  
    fileprivate func startScan() {
        scanLine.layer.add(scanAnimation(), forKey: "scan")
        
        guard let scanSession = scanSession else {
            return
        }
        
        
        if !scanSession.isRunning {
            scanSession.startRunning()
        }
    }
    
    
//    扫描动画
    private func scanAnimation() -> CABasicAnimation {
        let startPoint = CGPoint(x: scanLine.center.x, y: 1)
        let endPoint = CGPoint(x: scanLine.center.x, y: scanPane.bounds.height - 2)
        
        let translation = CABasicAnimation(keyPath: "position")
        translation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        translation.fromValue = NSValue(cgPoint: startPoint)
        translation.toValue = NSValue(cgPoint: endPoint)
        translation.duration = scanAnimationDuration
        translation.repeatCount = MAXFLOAT
        translation.autoreverses = true
        return translation
    }
    
    
    
    //MARK: Dealloc
    
    deinit
    {
        ///移除通知
        NotificationCenter.default.removeObserver(self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


extension QRScanVC: AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
//        停止扫描
        self.scanLine.layer.removeAllAnimations()
        self.scanSession!.stopRunning()
        
        Tool.playAlertSound(sound: "noticeMusic.caf")
        
//        扫描完成
        if metadataObjects.count > 0 {
            if let resultObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
                Tool.confirm(title: "扫描结果", message: resultObj.stringValue, controller: self, handler: { (_) in
                    //继续扫描
                    self.startScan()
                })
            }
        }
        
    }
}

