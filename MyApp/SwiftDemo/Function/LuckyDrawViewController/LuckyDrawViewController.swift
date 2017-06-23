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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "刮刮乐"
        
        setupUI()
    }

    func setupUI() {
        
        
        let textLabel = UILabel()
        textLabel.text = "一等奖:1000万"
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(textLabel)
        textLabel.backgroundColor = #colorLiteral(red: 0.9999160171, green: 1, blue: 0.9998719096, alpha: 1)
        textLabel.bounds = CGRect(x: 0, y: 0, width: 300, height: 200)
        textLabel.center = self.view.center

        
        imageView = UIImageView(image: #imageLiteral(resourceName: "image.jpg"))
        imageView.isUserInteractionEnabled = true
        view.addSubview(imageView)
        imageView.bounds = CGRect(x: 0, y: 0, width: 300, height: 200)
        imageView.center = self.view.center
        
        
        let tip = UILabel()
        tip.text = "小赌怡情、大赌伤身！\n且行且珍惜"
        tip.textAlignment = .center
        tip.font = UIFont.boldSystemFont(ofSize: 30)
        view.addSubview(tip)
        tip.numberOfLines = 0
        tip.frame = CGRect(x: 0, y: textLabel.frame.minY - 100, width: kScreenW, height: 100)
        
        
    }
    
    //MARK: - 仿支付宝刮刮乐
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch:AnyObject in touches {
            
            UIGraphicsBeginImageContext(imageView.frame.size)
            imageView.image?.draw(in: imageView.bounds)
            let t:UITouch = touch as! UITouch
            let point = t.location(in: imageView)
            let rect = CGRect(x:point.x - 10 ,y:point.y - 10, width: 20, height: 20)
            UIGraphicsGetCurrentContext()!.clear(rect)
            imageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            
        }
        
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
