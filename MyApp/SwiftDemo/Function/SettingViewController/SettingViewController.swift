//
//  SettingViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2017/5/2.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

class SettingViewController: RootViewController, XLPopMenuDelegate {

    func xlPopMenu(_ popMenu: XLPopMenu, didSelectItemAt index: NSInteger) {
        printLog(index)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func aaa(_ sender: UIButton) {
        let titles = ["发起群聊", "添加朋友", "扫一扫", "收付款", "拍摄", "面对面传"]
        let icons = ["searchbutton_nor", "searchbutton_nor", "searchbutton_nor", "searchbutton_nor", "searchbutton_nor", "searchbutton_nor"]
        let pop = XLPopMenu(titles: titles as NSArray, icons: icons as NSArray, menuWidth: 150)
        pop.delegate = self
        
        pop.showMenu(on: sender)
        
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let titles = ["发起群聊", "添加朋友", "扫一扫", "收付款", "拍摄", "面对面传"]
        let icons = ["searchbutton_nor", "searchbutton_nor", "searchbutton_nor", "searchbutton_nor", "searchbutton_nor", "searchbutton_nor"]
        let pop = XLPopMenu(titles: titles as NSArray, icons: icons as NSArray, menuWidth: 150)
        pop.kCornerRadius = 7
        pop.type = .dark
//        pop.offset = 50
        let p = touches.first
        let pointInview = p?.location(in: self.navigationController?.view)
//        pop.isShowShadow = false
        pop.showMenu(at: pointInview!)
        
        
        
        pop.popMenuDidSelectedBlock = { (index, title) in
            
            printLog("----\(index)--\(title)")
        }
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
