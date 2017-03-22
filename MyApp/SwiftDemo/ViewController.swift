//
//  ViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2016/10/25.
//  Copyright © 2016年 yjpal. All rights reserved.
//


import UIKit

import SDWebImage


class ViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var banner: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        imageView.sd_setImage(with: NSURL(string:"https://infosys.yjpal.com:10084/infointrfc/yjpalAppPic/app_WoYaoDaiKuan.png") as! URL, placeholderImage:UIImage(named: "POS_TY633"))
        
        let width = UIScreen.main.bounds.width
        let height = width/2
        
//        self.banner.contentSize = CGSizeMake(width * 6, height)
        self.banner.contentSize = CGSize(width: width*6, height: height)
        self.banner.contentOffset = CGPoint(x: width, y: 0)
        for i in 0...5 {
            
            let imgV = UIImageView(frame: CGRect(x: width*CGFloat(i), y: 0, width: width, height: height))
            var picName = "pic"
            switch i {
            case 0:
                picName += "4"
            case 5:
                picName += "1"
            default:
                picName += i.description
            }
            imgV.image = UIImage(named: picName)
            imgV.contentMode = UIViewContentMode.scaleAspectFill
            imgV.clipsToBounds = true
            imgV.isUserInteractionEnabled = true
            self.banner.addSubview(imgV)
            
        }
        
        
        
        
        printLog(message: "xx")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if banner == scrollView {
            let width = UIScreen.main.bounds.width
            let offsetX = scrollView.contentOffset.x
            
            if offsetX == 0 {
                scrollView.contentOffset = CGPoint(x: width*CGFloat(4), y: 0)
            }
            if offsetX == width*CGFloat(4+1) {
                scrollView.contentOffset = CGPoint(x: width, y: 0)
            }
            
            let currentPage = scrollView.contentOffset.x / width - 0.5
            
            self.pageControl.currentPage = Int(currentPage)
            
        
        }
        
        
    }

}

