//
//  BaseViewController.swift
//  DYTV
//
//  Created by xingl on 2018/9/26.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var contentView: UIView?
    
    fileprivate lazy var animImageView: UIImageView = {
       let imageView = UIImageView(image: UIImage(named: "dy001"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "dy001")!,UIImage(named: "dy002")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension BaseViewController {
    @objc func setupUI() {
        
        contentView?.isHidden = true
        
        view.addSubview(animImageView)
        animImageView.startAnimating()
        
        self.view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished() {
        animImageView.stopAnimating()
        animImageView.isHidden = true
        
        contentView?.isHidden = false
    }
}
