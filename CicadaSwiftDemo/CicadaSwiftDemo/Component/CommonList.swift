//
//  CommonList.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/4/20.
//

//import Foundation
//import UIKit
//class CommonListCell: UITableViewCell {
//    <#code#>
//}
//class CommonList<ItemType, CommonListCell>: UIView, UITableViewDataSource, UITableViewDelegate {
//    var tableView: UITableView
//    var items: [Product]! = [] {
//        didSet {
//            tableView.reloadData()
//        }
//    }
//    
//    weak var delegate: ProductListDelegate?
//    
//    static var cellId = "productListCellIdentifier"
//
//    
//    override init(frame: CGRect) {
//        tableView = UITableView.init(frame: .zero, style: .plain)
//        super.init(frame: frame)
//        setupViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setupViews() {
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.tableFooterView = UIView()
//        self.addSubview(tableView)
//        
//        tableView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//    }
//    
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: ProductList.cellId) as? ProductCell
//        if cell == nil {
//            cell = ProductCell(style: .subtitle, reuseIdentifier: ProductList.cellId)
//        }
//        cell?.item = items[indexPath.row]
//        return cell!
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        delegate?.didSelectProduct(items[indexPath.row])
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//    
//}
