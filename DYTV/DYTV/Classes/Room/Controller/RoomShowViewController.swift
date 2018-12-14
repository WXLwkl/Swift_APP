//
//  RoomShowViewController.swift
//  DYTV
//
//  Created by xingl on 2018/10/16.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

class RoomShowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .purple
        setupUI()
    }
}

extension RoomShowViewController {
    private func setupUI() {
        let button: UIButton = UIButton(type: .custom)
        button.frame = CGRect(x: 50, y: 100, width: 200, height: 100)
        button.setTitle("点击", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    
    @objc func closeVC() {
        self.dismiss(animated: true, completion: nil)
    }
}
