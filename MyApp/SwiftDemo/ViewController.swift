//
//  ViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2016/10/25.
//  Copyright © 2016年 yjpal. All rights reserved.
//


import UIKit

import SwiftyJSON

private let AppListCellID = "AppListCell"
private let BannerCellID = "BannerCell"

class ViewController: UIViewController,UIScrollViewDelegate,BannerViewDelegate {

    lazy var cycleModels : [BannerModel] = [BannerModel]()
    
    var bannerView: BannerView? = nil
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "首页"
        
        
        let bannerArr = [
            ["imageUrl":"pic1","title":"xingl","url":"https://www.baidu.com"],
            ["imageUrl":"http://c.hiphotos.baidu.com/image/pic/item/b58f8c5494eef01f50d40bbee5fe9925bd317d8c.jpg","title":"无限轮播","url":"https://www.baidu.com"],
            ["imageUrl":"pic2","title":"QQ：935858549","url":"https://www.baidu.com"],
            ["imageUrl":"pic3","title":"iOS开发","url":"https://www.baidu.com"],
            ["imageUrl":"pic4","title":"帅的人已经Star","url":"https://www.baidu.com"]
        ]
        
        for dict in bannerArr {
            cycleModels.append(BannerModel(dict: dict))
        }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 2、设置导航栏标题属性：设置标题颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.black]
        // 3、设置导航栏前景色：设置item指示色
        self.navigationController?.navigationBar.tintColor = UIColor.white
        // 4、设置导航栏半透明
//        self.navigationController?.navigationBar.isTranslucent = true
        // 5、设置导航栏背景图片
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        // 6、设置导航栏阴影图片
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func getBannerView(frame: CGRect) -> BannerView {
        
        bannerView = BannerView(frame: frame, data: cycleModels)
        bannerView?.bannerModels = self.cycleModels
        bannerView?.delegate = self
        bannerView?.autoScroll = true
        bannerView?.timeInterval = 5
        return bannerView!
    }
    
    func bannerView(_ banner: BannerView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        let view = NextViewController()
        view.hidesBottomBarWhenPushed = true
        view.navigationItem.title = "\(indexPath.row)"
        navigationController?.pushViewController(view, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return 20
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCellID, for: indexPath)
            
            if bannerView == nil {
                
                let cy = getBannerView(frame: cell.bounds)
                cell.addSubview(cy)
            }
            
            cell.contentView.backgroundColor = #colorLiteral(red: 0.4488613621, green: 1, blue: 0.5756808982, alpha: 1)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppListCellID, for: indexPath) as! AppListCell
            cell.iconImage.image = UIImage(named: "POS_TY633")
            cell.titleLabel.text = "ABCDEFG"
            return cell
        }
    }
}
//MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        printLog(message: indexPath.row)
        
    }
}
//MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //item的大小
        let width = self.view.bounds.width
        
        if indexPath.section == 0 {
            let height = width / 2
            return CGSize(width: width, height: height)
        } else {
            let cellWidth = (width-3) / 4.0
            return CGSize(width: cellWidth, height: cellWidth)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //集合视图的分区间距
//        return UIEdgeInsetsMake(10.0, 0.0, 0.0, 0.0);
        return UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //最小行间距
        return 1.0;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        //item之间的间距
        return 1.0;
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        
//    }
    
    
}
