//
//  LuckyDrawViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2017/6/2.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

class LuckyDrawViewController: RootViewController {

    
    var imageView = UIImageView()
    var isTouch: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "刮刮乐"
        
        setupUI()
    }

    func setupUI() {
        let textLabel = UILabel()
        textLabel.text = "一等奖:1000万"
        textLabel.textAlignment = .center
        view.addSubview(textLabel)
        
        textLabel.bounds = CGRect(x: 0, y: 0, width: 200, height: 100)
        textLabel.center = self.view.center
        
/*
         pageManager.view.snp.makeConstraints { (make) in
         make.top.equalTo(VCManager.snp.bottom)
         make.left.right.equalTo(view)
         make.bottom.equalTo(view.snp.bottom)
         }
         
         */
        
//        textLabel.snp.makeConstraints { (make) in
//            make.center.equalTo(view)
//            make.width.equalTo(200)
//            make.height.equalTo(100)
//        }
        
        imageView = UIImageView(image: #imageLiteral(resourceName: "image.jpg"))
        imageView.isUserInteractionEnabled = true
        view.addSubview(imageView)
        imageView.bounds = CGRect(x: 0, y: 0, width: 200, height: 100)
        imageView.center = self.view.center
//        imageView.snp.makeConstraints { (make) in
//            make.center.equalTo(view)
//            make.width.equalTo(200)
//            make.height.equalTo(100)
//        }
        
    }
    
    //MARK: - 仿支付宝刮刮乐
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch:AnyObject in touches {
            let t:UITouch = touch as! UITouch
            if t.view == imageView {
                isTouch = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if isTouch {
            for touch:AnyObject in touches {
                UIGraphicsBeginImageContext(imageView.frame.size)
                imageView.image?.draw(in: imageView.bounds)
                let t:UITouch = touch as! UITouch
                let point = t.location(in: t.view)
                let rect = CGRect(x: point.x-10, y: point.y-10, width: 20, height: 20)
                UIGraphicsGetCurrentContext()!.clear(rect)
                imageView.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        isTouch = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
