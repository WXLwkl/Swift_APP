//
//  BaseWebViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2017/5/19.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

import WebKit

class BaseWebViewController: RootViewController {

    var url: String?
    var progresslayer = CALayer()
    var webView: WKWebView?
    var button: UIButton?
    public convenience init(url: String) {
        self.init()
        self.url = url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.navigationItem.title = "加载中..."
        self.edgesForExtendedLayout = UIRectEdge()
        // Do any additional setup after loading the view.
    }

    func setupUI() {
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH))
//        if url == "" {
//            return
//        }
        
        guard (url != nil) else {
            return
        }
        
        let request = URLRequest(url: URL(string: url!)!)
        webView?.load(request)
        webView?.uiDelegate = self
        webView?.navigationDelegate = self
        view.addSubview(webView!)
        
        
        webView?.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        progresslayer.frame = CGRect(x: 0, y: 0, width: kScreenW * 0.05, height: 2)
        progresslayer.backgroundColor = UIColor.red.cgColor
        view.layer.addSublayer(progresslayer)
        
        configBackItem()
        configMenuItem()
    }
    
    func configBackItem() {
        
        let goBackItem = UIButton.init(type: .custom)
        goBackItem.setImage(UIImage(named: "Nav_goBack"), for: .normal)
        goBackItem.sizeToFit()
        goBackItem.frame.size = CGSize(width: 30, height: 30)
        goBackItem.contentHorizontalAlignment = .right
        goBackItem.addTarget(self, action: #selector(BaseWebViewController.goBack), for: .touchUpInside)
        let item = UIBarButtonItem.init(customView: goBackItem)
        navigationItem.leftBarButtonItem = item
    }
    func configMenuItem() {
        let menuBtn = UIButton.init(type: .custom)
        menuBtn.setTitle("...", for: .normal)
        menuBtn.sizeToFit()
        menuBtn.contentHorizontalAlignment = .right
        menuBtn.addTarget(self, action: #selector(BaseWebViewController.showMenu), for: .touchUpInside)
        let menuiitem = UIBarButtonItem.init(customView: menuBtn)
        navigationItem.rightBarButtonItem = menuiitem
    }
    func configCloseItem() {
        let closeBtn = UIButton(type: .custom)
        closeBtn.setTitle("关闭", for: .normal)
        closeBtn.sizeToFit()
        closeBtn.addTarget(self, action: #selector(BaseWebViewController.closeBtnClick), for: .touchUpInside)
        let closeItem = UIBarButtonItem(customView: closeBtn)
        let newArr = NSMutableArray(array: [navigationItem.leftBarButtonItem ?? "", closeItem])
        self.navigationItem.leftBarButtonItems = newArr as? [UIBarButtonItem]
    }
    
    func goBack() {
        if (self.webView?.canGoBack)! {
            self.webView?.goBack()
            if navigationItem.leftBarButtonItems?.count == 1 {
                configCloseItem()
            }
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    func showMenu() {
        
        let urlStr = self.webView?.url?.absoluteString
        
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (action:UIAlertAction!) -> Void in
            printLog(urlStr)
            print("点击的是取消")
        }
        let safariAction = UIAlertAction(title: "safari打开", style: UIAlertActionStyle.default) { (action:UIAlertAction!) -> Void in
            
            print("safari打开")
            UIApplication.shared.openURL(URL(string: urlStr!)!)
        }
        let copyAction = UIAlertAction(title: "复制链接", style: UIAlertActionStyle.default) { (action:UIAlertAction!) -> Void in
            
            print("复制链接")
            
        }
        let shareAction = UIAlertAction(title: "分享", style: UIAlertActionStyle.default) { (action:UIAlertAction!) -> Void in
            
            print("分享")
            
        }
        let refreshAction = UIAlertAction(title: "刷新", style: UIAlertActionStyle.default) { (action:UIAlertAction!) -> Void in
            self.webView?.reload()
            print("刷新")
            
        }
        sheet.addAction(cancelAction)
        sheet.addAction(safariAction)
        sheet.addAction(copyAction)
        sheet.addAction(shareAction)
        sheet.addAction(refreshAction)
        
        self.present(sheet, animated: true, completion: nil)
    }
    func closeBtnClick() {
        navigationController?.popViewController(animated: true)
    }
    deinit {
        webView?.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            progresslayer.opacity = 1
            let float = (change?[NSKeyValueChangeKey.newKey] as! NSNumber).floatValue
            progresslayer.frame = CGRect(x: 0, y: 0, width: kScreenW * CGFloat(float), height: 2)
            if float == 1 {
                weak var weakself = self
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: { 
                    weakself?.progresslayer.opacity = 0
                })
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8, execute: { 
                    weakself?.progresslayer.frame = CGRect(x: 0, y: 0, width: 0, height: 2)
                })
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
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
extension BaseWebViewController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.navigationItem.title = webView.title
    }
//    webView加载失败后提示
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        guard let btn = button else {
            button = UIButton(type: .system)
            button?.frame = CGRect(x: 0, y: 3, width: kScreenW, height: kScreenH - 60 - 3)
            button?.backgroundColor = UIColor.white
            button?.setTitle("重新加载", for: .normal)
            button?.setTitleColor(UIColor.darkText, for: .normal)
            button?.addTarget(self, action: #selector(BaseWebViewController.loadURL), for: .touchUpInside)
            view.addSubview(button!)
            return
        }
        btn.isHidden = false
    }
    
    func loadURL() {
        button?.isHidden = true
        if url == "" {
            return
        }
        
        let request = URLRequest(url: URL(string: url!)!)
        webView?.load(request)
    }
    
    
}
