//
//  LinkageViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2017/5/8.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

class LinkageViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        printLog("\(indexPath.section)-\(indexPath.row)")
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            let table = TableViewLinkageVC()
            navigationController?.pushViewController(table, animated: true)
        } else {
            let collection = CollectionViewLinkageVC()
            navigationController?.pushViewController(collection, animated: true)
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
