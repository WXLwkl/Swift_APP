//
//  CardViewController.swift
//  SwiftDemo
//
//  Created by xingl on 2017/12/6.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class CardViewController: RootViewController {

    private var collectionView:UICollectionView?
    private var layout:CustomLayout?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "卡片"
        setupUI()
    }

    func setupUI() {
        layout = CustomLayout()
        layout?.itemSize = CGSize(width: SCREEN_WIDTH - 80, height: SCREEN_HEIGHT - 64 - 120)
        let rect = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 64)
        collectionView = UICollectionView(frame: rect, collectionViewLayout: layout!)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
        collectionView?.register(CustomViewCell.self, forCellWithReuseIdentifier: "ID")
        collectionView?.backgroundColor = UIColor.red
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
extension CardViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ID", for: indexPath) as! CustomViewCell
        cell.backgroundColor = UIColor.orange
        cell.title = "\(indexPath.row)/10"
        return cell
    }
}
