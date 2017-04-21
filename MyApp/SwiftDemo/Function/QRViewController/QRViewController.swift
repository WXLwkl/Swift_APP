//
//  ViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2016/10/25.
//  Copyright © 2016年 yjpal. All rights reserved.
//

import UIKit

class QRViewController: UIViewController {

    @IBOutlet weak var textF: UITextField!
    
    @IBOutlet weak var imgV: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.backgroundColor = #colorLiteral(red: 0.4488613621, green: 1, blue: 0.5756808982, alpha: 1)
        
        
//        let v = BannerCycleView(frame: CGRect(x: 5, y: 350, width: UIScreen.main.bounds.width - 10, height: 138))
//        v.cycleModels = cycleModels
//        view.addSubview(v)
        
    }
    //二维码生成
    @IBAction func createBtnClick(_ sender: UIButton) {
        textF.resignFirstResponder()
        self.imgV.image = Tools.createQRForString(self.textF.text, qrImageNage: "")
        
    }
    //二维码扫描
    @IBAction func scanBtnClick(_ sender: UIButton) {
        let vc = QrcodeVC()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

