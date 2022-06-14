//
//  BannerView.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/4/18.
//

import Foundation
import UIKit

//如果协议只允许类来遵循，要加AnyObject
protocol BannerViewDataSource: AnyObject {
    func numberOfBanners(_ bannerView: BannerView) -> Int
    func viewForBanner(_ bannerView: BannerView, index: Int, convertView: UIView?) -> UIView
}

protocol BannerViewDelegate: AnyObject {
    func didSelectBanner(_ bannerView: BannerView, index: Int)
}

class BannerView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView
    var flowLayout: UICollectionViewFlowLayout
    var pageControl: UIPageControl
    //使用weak修饰的必须是引用类型，而swift的协议是允许枚举和结构体来遵循的，使用weak修饰一个变量，而这个变量又是通过协议类型来指引的时候是会报错的，解决方法有两种：第一种：添加@objc修饰符；第二种：如果一个协议只允许类类型来遵循它，我们需要给协议加上:AnyObject
    weak var dataSource: BannerViewDataSource! {
        didSet {
            pageControl.numberOfPages = self.dataSource.numberOfBanners(self)
            collectionView.reloadData()
            if isInfinite {
                DispatchQueue.main.async {
                    self.collectionView.setContentOffset(CGPoint(x: self.collectionView.frame.width, y: 0), animated: false)
                }
            }
        }
    }
    weak var delegate: BannerViewDelegate?
    
    var autoScrollInterval: Float = 0 {
        didSet {
            if self.autoScrollInterval > 0 {
                self.startAutoScroll()
            } else {
                self.stopAutoScroll()
            }
        }
    }
    //是否无限轮播
    var isInfinite: Bool = true
    //定时器，可能不需要
    var timer: Timer?
    
    static var cellId = "bannerViewCellId"
    static var convertViewTag = 7777777
    
    override init(frame: CGRect) {
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal

        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), collectionViewLayout: flowLayout)
        pageControl = UIPageControl()
        super.init(frame: frame)
        //创建完成本身的属性，然后调用了父类的初始化方法之后，我们才可以调用本身这个类的一些方法
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: BannerView.cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.addSubview(collectionView)
        self.addSubview(pageControl)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let pageNumber = dataSource.numberOfBanners(self)
        if isInfinite {
            if pageNumber == 1 {
                return 1
            } else {
                return pageNumber + 2
            }
        } else {
            return pageNumber
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerView.cellId, for: indexPath)
        var index = indexPath.row
        if isInfinite {
            let pageNumber = dataSource.numberOfBanners(self)
            if pageNumber > 1 {
                if indexPath.row == 0 {
                    index = pageNumber - 1
                } else if indexPath.row == pageNumber + 1 {
                    index = 0
                } else {
                    index = indexPath.row - 1
                }
            }
        }
        
        if let view = cell.contentView.viewWithTag(BannerView.convertViewTag) {
            let _ = dataSource.viewForBanner(self, index: index, convertView: view)
        } else {
            let newView = dataSource.viewForBanner(self, index: index, convertView: nil)
            newView.tag = BannerView.convertViewTag
            cell.contentView.addSubview(newView)
            newView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        return cell
    }
    
    func startAutoScroll() {
        guard autoScrollInterval > 0 && timer == nil else {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(autoScrollInterval), target: self, selector: #selector(flipNext), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func stopAutoScroll() {
        if let t = timer {
            t.invalidate()
            timer = nil
        }
    }
    
    @objc func flipNext() {
        guard let _ = superview, let _ = window else {
            return
        }
        
        let totalPageNumber = dataSource.numberOfBanners(self)
        guard totalPageNumber > 1 else {
            return
        }
        
        let currentPageNumber = Int(round(collectionView.contentOffset.x / collectionView.frame.width))
        
        if isInfinite {
            let nextPageNumber = currentPageNumber + 1
            collectionView.setContentOffset(CGPoint(x: collectionView.frame.width * CGFloat(nextPageNumber), y: 0), animated: true)
            if nextPageNumber >= totalPageNumber + 1 {
                pageControl.currentPage = 0
            } else {
                pageControl.currentPage = nextPageNumber - 1
            }
        } else {
            var nextPageNumber = currentPageNumber + 1
            if nextPageNumber > totalPageNumber {
                nextPageNumber = 0
            }
            collectionView.setContentOffset(CGPoint(x: collectionView.frame.width * CGFloat(nextPageNumber), y: 0), animated: true)
            pageControl.currentPage = nextPageNumber
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let total = dataSource.numberOfBanners(self)
        let current = Int(round(collectionView.contentOffset.x / collectionView.frame.width))
        if current >= total + 1 {
            collectionView.setContentOffset(CGPoint(x: collectionView.frame.width, y: 0), animated: false)
        }
    }
    
}
