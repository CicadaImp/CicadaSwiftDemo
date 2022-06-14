//
//  HomeViewController.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/4/18.
//

import UIKit
import Kingfisher

class HomeViewController: BaseViewController, BannerViewDataSource, ProductListDelegate {
    func didSelectProduct(_ product: Product) {
        let detailVC = DetailViewController()
        detailVC.product = product
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidesBottomBarWhenPushed = false
    }
    
    func numberOfBanners(_ bannerView: BannerView) -> Int {
        return FakeData.createBanners().count
    }
    
    func viewForBanner(_ bannerView: BannerView, index: Int, convertView: UIView?) -> UIView {
        if let view = convertView as? UIImageView {
            view.kf.setImage(with: URL(string: FakeData.createBanners()[index]))
            return view
        } else {
            let imageView = UIImageView ()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.kf.setImage(with: URL(string: FakeData.createBanners()[index]))
            return imageView
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let bannerView = BannerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 176))
        bannerView.autoScrollInterval = 2
        bannerView.isInfinite = true
        bannerView.dataSource = self
        view.addSubview(bannerView)
        
        let productList = ProductList(frame: .zero)
        productList.delegate = self
        productList.items = FakeData.createProducts()
        view.addSubview(productList)
        productList.snp.makeConstraints { make in
            make.top.equalTo(bannerView.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
        
        
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
