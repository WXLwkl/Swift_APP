//
//  MainTabBarController.swift
//  DYTV
//
//  Created by xingl on 2018/9/26.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.tintColor = UIColor(red: 0/255, green:186/255, blue:255/255, alpha:1)
        addChildVCS()
    }
    
    private func addChildVCS() {
        addChildVC(title: "首页", image: UIImage(named: "item0_1")!, selectedImage: UIImage(named: "item0_1")!, storyboard: UIStoryboard(name: "Home", bundle: nil))
        
        addChildVC(title: "直播", image: UIImage(named: "item1_11")!, selectedImage: UIImage(named: "item1_1")!, storyboard: UIStoryboard(name: "Live", bundle: nil))
        
        addChildVC(title: "关注", image: UIImage(named: "item2_1")!, selectedImage: UIImage(named: "item2_1")!, storyboard: UIStoryboard(name: "Follow", bundle: nil))
        
        addChildVC(title: "我的", image: UIImage(named: "item3_1")!, selectedImage: UIImage(named: "item3_1")!, storyboard: UIStoryboard(name: "Profile", bundle: nil))
    }
    
    private func addChildVC(title: String, image: UIImage, selectedImage: UIImage, storyboard: UIStoryboard) {
        let controller = storyboard.instantiateInitialViewController()!
        controller.tabBarItem.title = title
        controller.tabBarItem.image = image
        controller.tabBarItem.selectedImage = selectedImage
        addChild(controller)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
