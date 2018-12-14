//
//  RecommendViewController.swift
//  DYTV
//
//  Created by xingl on 2018/9/27.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH: CGFloat = 90


class RecommendViewController: BaseAnchorViewController {

    private lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    
    private lazy var cycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    private lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
}
// MARK: - 设置UI界面
extension RecommendViewController {
    override func setupUI() {
        
        super.setupUI()
        
        collectionView.addSubview(cycleView)
        
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}
// MARK: - 请求数据
extension RecommendViewController {
    override func loadData() {
        
        baseVM = recommendVM
        
        // 推荐数据
        recommendVM.requestData {
            self.collectionView.reloadData()
            
            var groups = self.recommendVM.anchorGroups
            
            groups.removeFirst()
            groups.removeFirst()
            
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
            
            //请求数据完成，停止加载动画
            self.loadDataFinished()
        }
        // 轮播数据
        recommendVM.requestCycleData {

            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}


extension RecommendViewController: UICollectionViewDelegateFlowLayout {
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPerttyCellID, for: indexPath) as! CollectionPrettyCell
            cell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return cell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPerttyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}
