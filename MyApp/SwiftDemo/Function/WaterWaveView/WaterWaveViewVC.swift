//
//  WaterWaveViewVC.swift
//  SwiftDemo
//
//  Created by xingl on 2017/11/20.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

class WaterWaveViewVC: RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let waterWaveView = WaterWaveView(frame: self.view.bounds)
        waterWaveView.waveHeight = 50;
        waterWaveView.waveSpeed = 0.1
        waterWaveView.waveColor = UIColor.blue.withAlphaComponent(0.3)
        self.view.addSubview(waterWaveView)
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
