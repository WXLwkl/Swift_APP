//
//  TestViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2017/5/23.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 10.0, *) {
            view.backgroundColor = UIColor(displayP3Red: CGFloat(arc4random_uniform(255))/255, green: CGFloat(arc4random_uniform(255))/255, blue: CGFloat(arc4random_uniform(255))/255, alpha: 1)
        } else {
            // Fallback on earlier versions
        }
        let rect = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        let tableView = UITableView(frame: rect, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        if #available(iOS 10.0, *) {
            tableView.backgroundColor = UIColor(displayP3Red: CGFloat(arc4random_uniform(255))/255, green: CGFloat(arc4random_uniform(255))/255, blue: CGFloat(arc4random_uniform(255))/255, alpha: 1)
        } else {
            // Fallback on earlier versions
        }
        view.addSubview(tableView)
        
        printLog("aaaa")
        
        
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

extension TestViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cellID"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        
        if #available(iOS 10.0, *) {
            cell?.backgroundColor = UIColor(displayP3Red: CGFloat(arc4random_uniform(255))/255, green: CGFloat(arc4random_uniform(255))/255, blue: CGFloat(arc4random_uniform(255))/255, alpha: 1)
        } else {
            // Fallback on earlier versions
        }
        cell?.textLabel?.text = "这里是第\(indexPath.row)行"
        
        return cell!
    }
    
}







