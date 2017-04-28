//
//  NextViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2017/4/13.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit
import WebKit

class NextViewController: RootViewController,WKNavigationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.main.bounds.size
        let frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height);
        let webView = WKWebView(frame: frame)
        let res = Bundle.main.path(forResource: "message", ofType: "html")
        let url = URL(fileURLWithPath: res!)
        webView .load(URLRequest(url: url))
        webView.navigationDelegate = self
        self.view.addSubview(webView)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.navigationItem.title = webView.title
        
        //        [webView stringByReplacingOccurrencesOfString:"{app_version}" withString:CLIENTVERSION];
        //        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"getMessageFromApp('%@')", @"加载结束调用方法"]];
        //
        //        let subBodyHtml = NSString.stringByReplacingOccurrencesOfString("{app_version}", withString: "3.1.0")
        
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
