//
//  MyViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2017/3/21.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit


class MyViewController: UIViewController, BannerViewDelegate {

    lazy var cycleModels : [BannerModel] = [BannerModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "个人中心"
        
        
        let label = UILabel(frame: CGRect(x: 0, y: 2, width: view.bounds.width, height: 50))
        label.text = "AAA"
        label.backgroundColor = #colorLiteral(red: 0.4488613621, green: 1, blue: 0.5756808982, alpha: 1)
        label.textAlignment = .center
        view.addSubview(label)
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
