//
//  BannerView.swift
//  SwiftDemo
//
//  Created by xingl on 2017/4/13.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

import Kingfisher

private let CellId = "BannerID"

protocol BannerViewDelegate: NSObjectProtocol {
    func bannerView(_ banner: BannerView, didSelectItemAt indexPath: IndexPath)
}

class BannerView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
//MARK: - 自定义属性
    
    var bannerModels : [BannerModel]? {
        didSet {
            
            pageControl.numberOfPages = bannerModels?.count ?? 0
            
            if bannerModels?.count ?? 0 <= 1 {
                collectionView.isScrollEnabled = false
                pageControl.isHidden = true
            }
            
            collectionView.reloadData()
        }
    }
    
    /// 是否开启自动滚动,默认是ture
    var autoScroll: Bool = true {
        didSet {
            self.timer?.invalidate() //先取消先前定时器
            if autoScroll && bannerModels?.count ?? 0 > 1 {
                self.setupTimer(nil)   //重新设置定时器
            }
        }
    }
    /// 开启自动滚动后，自动翻页的时间，默认为3秒
    var timeInterval: Double = 3.0 {
        didSet {
            if autoScroll && bannerModels?.count ?? 0 > 1 {
                self.setupTimer(nil)   //重新设置定时器
            }
        }
    }
    
    fileprivate var cycleTimer: Timer?
    weak var delegate: BannerViewDelegate?
    
    fileprivate var oldOffset: CGFloat = 0.0
    fileprivate var currentIndexPath: IndexPath?
    
    fileprivate var timer: Timer?
    func setupTimer(_ userInfo: AnyObject?) {
        self.timer?.invalidate() //先取消先前定时器
        let timer = Timer(timeInterval: timeInterval, target: self, selector: #selector(BannerView.changePicture), userInfo: userInfo, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        self.timer = timer
    }
    
    /**
     定时器回调方法，用于自动翻页
     */
    func changePicture() {
        nextImage()
    }

//MARK: - 懒加载
/*
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
    
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self!.bounds, collectionViewLayout: layout)
        
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: CellId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        return collectionView
    }()
     
    lazy var pageControl: UIPageControl = {[weak self] in
        
       
        let pageControl = UIPageControl()
        pageControl.numberOfPages = self?.bannerModels?.count ?? 0
        pageControl.pageIndicatorTintColor = .orange
        pageControl.currentPageIndicatorTintColor = .green
        
        return pageControl
    }()
    
*/
    override func layoutSubviews() {
        
        view.frame = bounds
        collectionView.frame = bounds
        
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: CellId)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        //从中间显示
        let indexPath = IndexPath(item: bannerModels?.count ?? 0, section: 0)
        currentIndexPath = indexPath
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: false)
    }
    
    
    weak var view: UIView!
    init(frame: CGRect, data: [BannerModel]) {

        bannerModels = data
        super.init(frame: frame)
        setupSubviews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    /// 下一个图片
    func nextImage() {
        if pageControl.currentPage == (bannerModels?.count)! - 1 {
            pageControl.currentPage = 0
        } else {
            pageControl.currentPage += 1
        }
        
        guard let currentIndexPath = currentIndexPath else {
            return
        }
        let newIndexPath = IndexPath(item: currentIndexPath.item + 1, section: 0)
        self.currentIndexPath = newIndexPath
        collectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    func preImage() {
        if pageControl.currentPage == 0 {
            pageControl.currentPage = (bannerModels?.count)! - 1
        } else {
            pageControl.currentPage -= 1
        }
        
        guard let currentIndexPath = currentIndexPath else {
            return
        }
        let newIndexPath = IndexPath(item: currentIndexPath.item - 1, section: 0)
        self.currentIndexPath = newIndexPath
        collectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    func reloadImage() {
        guard let currentIndexPath = currentIndexPath else {
            return
        }
        if currentIndexPath.item == (bannerModels?.count)! * 2 - 1 {  //如果是最后一个图片，回到第一部分的最后一张图片
            let newIndexPath = IndexPath(item: (bannerModels?.count)! - 1, section: 0)
            self.currentIndexPath = newIndexPath
            collectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: false)
        } else if currentIndexPath.item == 0 {  //如果是第一个图片，就回到第二部分的第一张图片
            let newIndexPath = IndexPath(item: (bannerModels?.count)!, section: 0)
            self.currentIndexPath = newIndexPath
            collectionView.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: false)
        }
    }
}

//MARK: - 设置UI界面
extension BannerView {
    
    
    // load view from xib
    fileprivate func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    fileprivate func setupSubviews() {
        view = loadViewFromNib()
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        
    }
}

//MARK: - UICollectionViewDataSource
extension BannerView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (bannerModels?.count ?? 0) * 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId, for: indexPath) as! BannerCell
        
        cell.cycleModel = bannerModels![indexPath.item % bannerModels!.count]
        return cell
    }
    
}
//MARK: - UICollectionViewDelegate
extension BannerView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //代理方法
        delegate?.bannerView(self, didSelectItemAt: IndexPath(item: indexPath.item % (self.bannerModels?.count ?? 0), section: indexPath.section))
    }
}
//MARK: - UIScrollViewDelegate
extension BannerView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (bannerModels?.count ?? 0)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        oldOffset = scrollView.contentOffset.x
        if self.autoScroll {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    /// 当停止滚动的时候重新设置三个ImageView的内容，然后悄悄滴显示中间那个imageView
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        reloadImage()
    }
    /// 停止拖拽，开始timer, 并且判断是显示上一个图片还是下一个图片
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.autoScroll {
            self.setupTimer(nil)
        }
        if scrollView.contentOffset.x < oldOffset {
            preImage()
        } else {
            nextImage()
        }
    }
    
}

//extension BannerView {
//    
//    @objc fileprivate func tapGes(tap: UITapGestureRecognizer) {
//        guard tap.view as? BannerView != nil else {
//            return
//        }
//        if delegate != nil {
//            delegate?.clickBannerView(self, selectedIndex: pageControl.currentPage)
//        }
//        print("点击了第（\(pageControl.currentPage)）页！！！")
//    }
//}


