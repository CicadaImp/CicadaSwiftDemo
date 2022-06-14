//
//  MineViewController.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/4/18.
//

import UIKit
import SnapKit

class MineViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CommonCell.commonCell(tableView: tableView)
        cell.title = "2333"
        cell.icon = R.image.icon_mine()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Todo
        let dealVC = DealListViewController()
        dealVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(dealVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    func setupViews() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = headerView
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    lazy var headerView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 150))
        headerView.backgroundColor = .blue
        
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = R.image.icon_logo()
        headerView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
        }
        
        return headerView
    }()
    

    

}
