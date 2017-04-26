//
//  ViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2016/10/25.
//  Copyright © 2016年 yjpal. All rights reserved.
//

import UIKit

class QRViewController: UIViewController {

    var text: String!
    
    @IBOutlet weak var textF: UITextField!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var imgV: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "扫描", style: UIBarButtonItemStyle.plain, target: self, action: #selector(QRViewController.scanQR(_:)))

        view.backgroundColor = #colorLiteral(red: 0.4488613621, green: 1, blue: 0.5756808982, alpha: 1)
  
        textF.text = text
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
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func recognizeQRCode(_ sender: UIButton) {
        printLog(message: imgV.image)
        
        
        let str = self.imgV.image?.recognizeQRCode()
        
        print(str!)
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

