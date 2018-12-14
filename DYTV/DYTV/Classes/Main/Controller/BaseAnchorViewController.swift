//
//  BaseAnchorViewController.swift
//  DYTV
//
//  Created by xingl on 2018/10/15.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
let kNormalItemW = (kScreenW - kItemMargin * 3) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let kPerttyItemH = kNormalItemW * 4 / 3
private let kHeaderViewH: CGFloat = 50


private let kNormalCellID = "kNormalCellID"
let kPerttyCellID = "kPerttyCellID"
private let kHeaderViewID = "kHeaderViewID"


class BaseAnchorViewController: BaseViewController {

    var baseVM: BaseViewModel!
    
    lazy var collectionView: UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionNomalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPerttyCellID)
        //        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        //        collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        setupUI()
        loadData()
    }
    
}

// MARK: - 设置UI界面
extension BaseAnchorViewController {
    override func setupUI() {
        contentView = collectionView
        view.addSubview(collectionView)
        
        super.setupUI()
    }
}

extension BaseAnchorViewController {
    @objc func loadData() {}
}
extension BaseAnchorViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNomalCell
        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.group = baseVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    // 点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        anchor.isVertical == 0 ? pushNormalRoomVC() : presentShowRoomVC()
    }
    
    private func presentShowRoomVC() {
        let showRoomVC = RoomShowViewController()
        
        present(showRoomVC, animated: true, completion: nil)
    }
    private func pushNormalRoomVC() {
        let  normalRoomVC = RoomNormalViewController()
        
        navigationController?.pushViewController(normalRoomVC, animated: true)
    }
    
}

