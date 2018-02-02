//
//  GuideViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2017/12/15.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

class GuideViewController: RootViewController {

    var buttons: [UIButton] = [UIButton]()

    let string = "后来我转行干了段时间销售，赚的比之前多了点，好的时候一个月能拿两三万。我看我妈的手机又旧又破，接电话的时候还要扯着嗓子喊。于是给她买了当时最新款的水果手机，我把手机盒递给她的时候她又炸毛了，又嚷嚷着说太贵了要去退。这次我学聪明了，说发票已经掉了退不了，我妈彻底毛了，好几天不给我做饭。"

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "引导页"

        configUI()
        showGuides()
    }

    func configUI() {



        let btn1 = UIButton(type: UIButtonType.custom)
        btn1.backgroundColor = UIColor.red
        btn1.frame = CGRect(x: 20, y: 20, width: self.view.bounds.width - 40, height: self.view.bounds.height/2 - 20)
        view.addSubview(btn1)
        let btn2 = UIButton(type: UIButtonType.custom)
        btn2.backgroundColor = UIColor.blue
        btn2.frame = CGRect(x: 20, y: self.view.bounds.height/2 + 10, width: self.view.bounds.width - 160, height: self.view.bounds.height/2 - 120)
        view.addSubview(btn2)
        let btn3 = UIButton(type: UIButtonType.custom)
        btn3.backgroundColor = UIColor.gray
        btn3.frame = CGRect(x: self.view.bounds.width - 130, y: self.view.bounds.height/2 + 10, width: 120, height: self.view.bounds.height/5)
        view.addSubview(btn3)
        let btn4 = UIButton(type: UIButtonType.custom)
        btn4.backgroundColor = UIColor.red
        btn4.frame = CGRect(x: self.view.bounds.width - 130, y: btn3.frame.maxY + 10, width: 120, height: 80)
        view.addSubview(btn4)

        buttons.append(btn1)
        buttons.append(btn2)
        buttons.append(btn3)
        buttons.append(btn4)
    }

    func showGuides() {

        GuideDataManager.reset(for: "MainGuide")
        var items = [GuideItem]()
        for button in buttons {
//            let n = Int(arc4random()) % string.count
            let n = Int(arc4random_uniform(UInt32(string.count)))
            let index = string.index(string.startIndex, offsetBy: Int(n))
            let text = string.substring(to: index)
            let item = GuideItem(sourceView: button, text: text)
            items.append(item)
        }
        let vc = GuideController(items: items, key: "MainGuide")
        vc.setIndexChangeBlock { (index, item) in
            print("Index has change to \(index)")
        }
        vc.show(from: self) {
            print("end...")
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
