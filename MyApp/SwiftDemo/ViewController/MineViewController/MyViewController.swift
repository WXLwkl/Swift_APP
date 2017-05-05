//
//  MyViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2017/3/21.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit


class MyViewController: RootViewController {

    var searchController: UISearchController?
    
    // tableView
    lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 44.0
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0)
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 44, 0)
        tableView.separatorInset = UIEdgeInsetsMake(0, 8, 0, 0)
        tableView.tableFooterView = UIView()
        // 注册cellID
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ID")
        return tableView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "个人中心"
        
        
        
        automaticallyAdjustsScrollViewInsets = false
        
        // 搜索控制器
        let searchResultVC = RootViewController()
        searchResultVC.view.backgroundColor = UIColor.red
        let searchController = LXFSearchController(searchResultsController: searchResultVC)
        self.searchController = searchController
        
        // 添加tableView
        tableView.tableHeaderView = searchController.searchBar
        view.addSubview(self.tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func settingClick(_ sender: UIBarButtonItem) {
        appInfo()
        let vc = UIStoryboard(name: "Setting", bundle: nil)
            .instantiateInitialViewController() as! SettingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
// TODO: - 设备信息
    func appInfo() -> Void {
        
        print("It's a print")
        debugPrint("It's a debugPrint")
        CFShow("It's a CFShow" as CFTypeRef!)
        
        print("-----------------------------------")
        let mainBundle = Bundle.main
        let identifier = mainBundle.bundleIdentifier
        let info = mainBundle.infoDictionary
        let bundleId = mainBundle.object(forInfoDictionaryKey: "CFBundleName")
        let version = mainBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString")
//        print("[identifier]:\(identifier)")
        print("[identifier]:\(String(describing: identifier))")
//        print("[info]:\(info)")
        print("[info]:\(String(describing: info))")
        print("[bundleId]:\(bundleId!)")
        print("[version]:\(version!)")
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

// MARK:- UITableViewDataSource
extension MyViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID")
        
        cell?.textLabel?.text = "\(indexPath.row)"
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
