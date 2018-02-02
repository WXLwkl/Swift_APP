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

class HomeViewController: RootViewController,UIScrollViewDelegate,BannerViewDelegate {
    
    func xlPopMenu(_ popMenu: XLPopMenu, didSelectItemAt index: NSInteger) {
        print(index)
    }


    lazy var cycleModels : [BannerModel] = [BannerModel]()
    lazy var applistModels: [ApplistModel] = [ApplistModel]()
    
    var bannerView: BannerView? = nil
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var applistArray: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "首页"
        
        let goBackItem = UIButton.init(type: .contactAdd)
        goBackItem.sizeToFit()
        goBackItem.contentHorizontalAlignment = .right
        goBackItem.addTarget(self, action: #selector(HomeViewController.add(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: goBackItem)
        
        
        let bannerArr = [
            ["imageUrl":"pic1","title":"xingl","url":"https://www.baidu.com"],
            ["imageUrl":"http://c.hiphotos.baidu.com/image/pic/item/b58f8c5494eef01f50d40bbee5fe9925bd317d8c.jpg","title":"iOS开发","url":"https://www.baidu.com"],
            ["imageUrl":"pic2","title":"QQ：935858549","url":"https://www.baidu.com"],
            ["imageUrl":"pic3","title":"无限轮播","url":"https://www.baidu.com"],
            ["imageUrl":"pic4","title":"帅的人已经Star","url":"https://www.baidu.com"]
        ]
        
        for dict in bannerArr {
            cycleModels.append(BannerModel(dict: dict))
        }
        
        let path = Bundle.main.bundlePath
        let plistName:NSString = "Applist.plist"
        let finalPath = (path as NSString).appendingPathComponent(plistName as String)
        
        applistArray = NSArray(contentsOfFile:finalPath as String)!
        
        for dic in applistArray! {
            applistModels.append(ApplistModel(dict: dic as! [String : Any]))
        }
        printLog(applistArray)
        
        
    }

    func add(_ item: UIButton) {
        
        let titles = ["发起群聊", "添加朋友", "扫一扫", "收付款", "拍摄", "面对面传"]
        let icons = ["searchbutton_nor", "searchbutton_nor", "searchbutton_nor", "searchbutton_nor", "searchbutton_nor", "searchbutton_nor"]
        let pop = XLPopMenu(titles: titles as NSArray, icons: icons as NSArray, menuWidth: 150)
        pop.offset = 12
        pop.showMenu(on: item)
        
        pop.popMenuDidSelectedBlock = { (index) in
            
            printLog(index)

        }
    }
    
    func getBannerView(frame: CGRect) -> BannerView {
        
        bannerView = BannerView(frame: frame, data: cycleModels)
        bannerView?.bannerModels = self.cycleModels
        bannerView?.delegate = self
        bannerView?.autoScroll = true
        bannerView?.timeInterval = 3
        return bannerView!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: - bannerView的代理回调
    func bannerView(_ banner: BannerView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
//        let view = NextViewController()
//        view.hidesBottomBarWhenPushed = true
//        view.navigationItem.title = "\(indexPath.row)"
//        navigationController?.pushViewController(view, animated: true)
        let viewc = BaseWebViewController(url: "http://m.ybdu.com/xiaoshuo/19/19117/7192834.html")
        viewc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewc, animated: true)
    }
    
}

//MARK: - UICollectionViewDataSource
extension HomeViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return applistArray?.count ?? 0
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
            let dic: NSDictionary = applistArray?[indexPath.row] as! NSDictionary
            printLog(dic)
//            cell.iconImage.image = UIImage(named: dic["image"])
//            cell.titleLabel.text = dic["title"]
            cell.applistModel = applistModels[indexPath.row]
            return cell
        }
    }
}
//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let applistModel = applistModels[indexPath.row]
       
        guard applistModel.vc != "" else {
            return 
        }
        
        self.performSegue(withIdentifier: applistModel.vc, sender: nil)
        
//        switch indexPath.row {
//        case 0:
//            self.performSegue(withIdentifier: "QRSegue", sender: nil)
//        default:
//            break
//            
//        }
        
//        let model: ApplistModel = applistModels[indexPath.row]
//        printLog(message: model.vc)
//        
//
//        
//        navigationController?.pushViewController(VCSTRING_TO_VIEWCONTROLLER(model.vc)!, animated: true)
        
    }
    
//MARK: - storyboard传值
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "QRSegue" else {
            return
        }
        let vc = segue.destination as! QRViewController
        vc.text = "sss"
    }
}


func VCSTRING_TO_VIEWCONTROLLER(_ childControllerName: String) -> UIViewController?{
    
     // 1.获取命名空间
   // 通过字典的键来取值,如果键名不存在,那么取出来的值有可能就为没值.所以通过字典取出的的类型为AnyObject?
     guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
             print("命名空间不存在")
             return nil
    }
     // 2.通过命名空间和类名转换成类
     let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + childControllerName)

    // swift 中通过Class创建一个对象,必须告诉系统Class的类型
     guard let clsType = cls as? UIViewController.Type else {
             print("无法转换成UIViewController")
            return nil
        }
    // 3.通过Class创建对象
    let childController = clsType.init()

    return childController
}


//private func addChildViewController(childControllerName : String,title : String,normalImage : String) {
//    
//    // 1.获取命名空间
//    guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
//        printLog(message: "命名空间不存在")
//        return
//    }
//    // 2.通过命名空间和类名转换成类
//    let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + childControllerName)
//    
//    // swift 中通过Class创建一个对象,必须告诉系统Class的类型
//    guard let clsType = cls as? UITableViewController.Type else {
//        printLog(message: "无法转换成UITableViewController")
//        return
//    }
//    
//    // 3.通过Class创建对象
//    let childController = clsType.init()
//    
//    // 设置TabBar和Nav的标题
//    childController.title = title
//    childController.tabBarItem.image = UIImage(named: normalImage)
//    childController.tabBarItem.selectedImage = UIImage(named: normalImage + "_highlighted")
//    
//    // 包装导航控制器
//    let nav = UINavigationController(rootViewController: childController)
//    addChildViewController(nav)
//}





//MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
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
