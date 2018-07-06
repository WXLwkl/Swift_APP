//
//  ViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2016/10/25.
//  Copyright © 2016年 yjpal. All rights reserved.
//

import UIKit

class QRViewController: RootViewController {

    var text: String!
    
    @IBOutlet weak var textF: UITextField!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var imgV: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightItem1 = UIBarButtonItem(title: "扫描", style: UIBarButtonItemStyle.plain, target: self, action: #selector(QRViewController.scanQR(_:)))
        let rightItem2 = UIBarButtonItem(title: "扫描2", style: UIBarButtonItemStyle.plain, target: self, action: #selector(QRViewController.scanQR2(_:)))
        navigationItem.rightBarButtonItems = [rightItem1, rightItem2]

        navigationItem.title = "二维码"
  
        textF.text = text
        
        logoImgView.backgroundColor = .purple
        logoImgView.clipRectCorner(direction: [.topLeft, .topRight], cornerRadius: 20)
    }
    //二维码生成
    @IBAction func createBtnClick(_ sender: UIButton) {
        textF.resignFirstResponder()
        
        guard let content = textF.text else {
            Tool.confirm(title: "温馨提示", message: "请输入内容", controller: self)
            return
        }
        
        if content.characters.count > 0 {
            DispatchQueue.global().async {
                let image = content.generateQRCodeWithLogo(logo: self.logoImgView.image)
//                let image = content.generateQRCode(size: 400, color: UIColor.red, bgColor: UIColor.white, logo: self.logoImgView.image)
                DispatchQueue.main.async(execute: {
                    self.imgV.image = image
                })
            }
        } else {
            
            Tool.confirm(title: "温馨提示", message: "请输入内容", controller: self)
        }
        
        
        
    }
    //二维码扫描
    func scanQR(_ sender: UIButton) {
        let vc = QRScanVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    func scanQR2(_ sender: UIButton) {
        let vc = QRCodeScanViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func recognizeQRCode(_ sender: UIButton) {

        DispatchQueue.global().async {
            let recognizeResult = self.imgV.image?.recognizeQRCode()
            let result = recognizeResult?.characters.count > 0 ? recognizeResult : "无法识别"
            DispatchQueue.main.async {
                Tool.confirm(title: "扫描结果", message: result, controller: self)
            }
        }
//        Tool.shared.choosePicture(self, editor: true) { [weak self] (image) in
//            let vc2:RecognizeQRCodeViewController = RecognizeQRCodeViewController()
//            vc2.sourceImage = image;
//            self?.navigationController?.pushViewController(vc2, animated: true)
//        }
    }
    
    @IBAction func chooseLogo(_ sender: UITapGestureRecognizer) {
        Tool.shared.choosePicture(self, editor: true) { [weak self](image) in
            self?.logoImgView.image = image
        }
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

