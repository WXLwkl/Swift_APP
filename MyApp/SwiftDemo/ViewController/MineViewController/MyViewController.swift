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
    lazy var listModels: [ListModel] = [ListModel]()
    

    // tableView
    lazy var tableView: UITableView = { [unowned self] in
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 44.0
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsetsMake(0, 8, 0, 0)
        tableView.tableFooterView = UIView()
        // 注册cellID
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ID")
        return tableView
        }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "个人中心"
        
        
        navigationController?.navigationBar.isTranslucent = false
        
        // 搜索控制器
        let searchResultVC = RootViewController()
        searchResultVC.view.backgroundColor = UIColor.red
        let searchController = WeChatSearchController(searchResultsController: searchResultVC)
        self.searchController = searchController
        
        // 添加tableView
        tableView.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = true   //解决 TableView 向上偏移 64 像素（下面透明）的问题
        view.addSubview(self.tableView)
        
        
        tableView.addExRefresh {
            self.perform(#selector(self.afterMethod), with: nil, afterDelay: 2, inModes: [RunLoopMode.commonModes])
        }
        
        
        
        let path = Bundle.main.bundlePath
        let plistName:NSString = "PersonalItem.plist"
        let finalPath = (path as NSString).appendingPathComponent(plistName as String)
        
        let listArray = NSArray(contentsOfFile:finalPath as String)!
        
        for dic in listArray {
            listModels.append(ListModel(dict: dic as! [String : Any]))
        }
    }
    func afterMethod() {
        
        let dic = ["name":"AAA","icon":"searchbutton_nor"]
        
        let list = ListModel(dict: dic as [String : Any])
        
        listModels.append(list)
        tableView.header?.endRefresh()
        tableView.reloadData()
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
        
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        
        printLog("\(year)/\(month)/\(day)/\(hour)/\(minute)/\(second)")
        
        
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
        return listModels.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ID")
        
        cell?.imageView?.image = UIImage(named: listModels[indexPath.row].icon )
        cell?.textLabel?.text = listModels[indexPath.row].name
        
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            printLog("0")
            navigationController?.pushViewController(MyLocationViewController(), animated: true)
        case 1:
            printLog("1")
            navigationController?.pushViewController(LuckyDrawViewController(), animated: true)
        case 2:
            printLog("2")
        default:
            printLog("特殊情况")
        }
    }
}
