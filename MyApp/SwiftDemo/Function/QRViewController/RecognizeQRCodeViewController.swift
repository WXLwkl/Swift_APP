//
//  RecognizeQRCodeViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2017/4/28.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

class RecognizeQRCodeViewController: RootViewController {

    var sourceImage : UIImage?
    var sourceImageView: UIImageView!
    var activityIndicatoryView: UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubViews()
        setupImage()
        
        setupGes()
    }
    
    private func initSubViews() {
        sourceImageView = UIImageView()
        sourceImageView.isUserInteractionEnabled = true
        sourceImageView.contentMode = .scaleAspectFit
        self.view.addSubview(sourceImageView)
        sourceImageView.frame = view.bounds
        
        activityIndicatoryView = UIActivityIndicatorView.init()
        activityIndicatoryView.color = UIColor.orange
        self.view.addSubview(activityIndicatoryView)
        activityIndicatoryView.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicatoryView.center = view.center
    }
    private func setupGes() {
        
        sourceImageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseImage)))
        
    }
    
    private func setupImage() {
        
        sourceImageView?.image = sourceImage
        recognizeQRCode()
        
    }
    
    
    
    @objc private func chooseImage() {
        
        Tool.shared.choosePicture(self, editor: false) { [weak self] (image) in
            self?.sourceImage = image
            self?.setupImage()
        }
        
    }
    private func recognizeQRCode() {
        
        activityIndicatoryView?.startAnimating()
        
        DispatchQueue.global().async {
            let recognizeResult = self.sourceImage?.recognizeQRCode()
            let result = recognizeResult?.characters.count > 0 ? recognizeResult : "无法识别"
            DispatchQueue.main.async {
                Tool.confirm(title: "扫描结果", message: result, controller: self)
                self.activityIndicatoryView?.stopAnimating()
            }
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
