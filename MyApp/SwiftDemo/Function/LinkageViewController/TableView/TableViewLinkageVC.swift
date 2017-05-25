//
//  TableViewLikageVC.swift
//  SwiftDemo
//
//  Created by xingl on 2017/5/8.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

let LeftTableViewCellID = "LeftTableViewCell"
let RightTableViewCellID = "RightTableViewCell"

class TableViewLinkageVC: RootViewController {

//MARK: - lazy load
    
    fileprivate lazy var leftTableView: UITableView = {
        let leftTableView = UITableView()
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.frame = CGRect(x: 0, y: 0, width: 80, height: kScreenH)
        leftTableView.rowHeight = 60
        leftTableView.showsVerticalScrollIndicator = false
        leftTableView.separatorColor = UIColor.clear
        leftTableView.register(LeftTableViewCell.self, forCellReuseIdentifier: LeftTableViewCellID)
        
        return leftTableView
    }()
    fileprivate lazy var rightTableView : UITableView = {
        let rightTableView = UITableView()
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.frame = CGRect(x: 80, y: 64, width: kScreenW - 80, height: kScreenH - 64)
        rightTableView.rowHeight = 80
        rightTableView.showsVerticalScrollIndicator = false
        rightTableView.register(RightTableViewCell.self, forCellReuseIdentifier: RightTableViewCellID)
        return rightTableView
    }()
//MARK: -
//    左model
    fileprivate lazy var categoryData = [CategoryModel]()
//    右model
    fileprivate lazy var foodData = [[FoodModel]]()
    
    fileprivate var selectIndex = 0
    fileprivate var isScrollDown = true
    fileprivate var lastOffsetY : CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "UITableView"
        view.backgroundColor = UIColor.white
        view.addSubview(leftTableView)
        view.addSubview(rightTableView)
        
        configureData()
        leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension TableViewLinkageVC {
    
    fileprivate func configureData() {
        guard let path = Bundle.main.path(forResource: "meituan", ofType: "json") else { return }
        guard let data = NSData(contentsOfFile: path) as Data? else { return }
        
        guard let anyObject = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else { return }
        guard let dict = anyObject as? [String: Any] else { return }
        guard let datas = dict["data"] as? [String: Any] else { return }
        guard let foods = datas["food_spu_tags"] as? [[String: Any]] else { return }
        
        for food in foods {
            let model = CategoryModel(dict: food)
            categoryData.append(model)
            
            guard let spus = model.spus else { continue }
            var datas = [FoodModel]()
            for fModel in spus {
                datas.append(fModel)
            }
            foodData.append(datas)
        }
    }
    
    
}

//MARK: - UITableViewDelegate && UITableViewDataSource
extension TableViewLinkageVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if leftTableView == tableView {
            return 1
        } else {
            return categoryData.count
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if leftTableView == tableView {
            return categoryData.count
        } else {
            return foodData[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if leftTableView == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: LeftTableViewCellID) as! LeftTableViewCell
            let model = categoryData[indexPath.row]
            
            cell.nameLabel.text = model.name
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: RightTableViewCellID, for: indexPath) as! RightTableViewCell
            let model = foodData[indexPath.section][indexPath.row]
            cell.setDatas(model)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if leftTableView == tableView {
            return 0
        } else {
            return 20
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if leftTableView == tableView {
            return nil
        }
        let headerView = TableViewHeaderView()
        let model = categoryData[section]
        headerView.nameLabel.text = model.name
        return headerView
    }
//    tableview 分区标题即将展示
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        // 当前的 tableView 是 RightTableView，RightTableView 滚动的方向向上，RightTableView 是用户拖拽而产生滚动的（（主要判断 RightTableView 用户拖拽而滚动的，还是点击 LeftTableView 而滚动的
        if (rightTableView == tableView) && !isScrollDown && rightTableView.isDragging {
            selectRow(index: section)
        }
    }
//   TableView分区标题展示结束
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        // 当前的 tableView 是 RightTableView，RightTableView 滚动的方向向下，RightTableView 是用户拖拽而产生滚动的（（主要判断 RightTableView 用户拖拽而滚动的，还是点击 LeftTableView 而滚动的）
        if (rightTableView == tableView) && isScrollDown && rightTableView.isDragging {
            selectRow(index: section + 1)
        }
    }
    // 当拖动右边 TableView 的时候，处理左边 TableView
    private func selectRow(index : Int) {
        leftTableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .top)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if leftTableView == tableView {
            selectIndex = indexPath.row
            rightTableView.scrollToRow(at: IndexPath(row: 0, section: selectIndex), at: .top, animated: true)
            leftTableView.scrollToRow(at: IndexPath(row: selectIndex, section: 0), at: .top, animated: true)
        } else {
    
            let model = foodData[indexPath.section][indexPath.row]
            
            printLog("rightTableView ====> \(String(describing: model.name))-->\(String(describing: model.minPrice))")
        }
    }

// 标记一下 RightTableView 的滚动方向，是向上还是向下
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView = scrollView as! UITableView
        if rightTableView == tableView {
            isScrollDown = lastOffsetY < scrollView.contentOffset.y
            lastOffsetY = scrollView.contentOffset.y
        }
    }

}
