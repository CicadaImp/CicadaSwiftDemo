//
//  CommonCell.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/4/20.
//

import Foundation
import UIKit

class CommonCell: UITableViewCell {
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var icon: UIImage? {
        didSet {
            iconImageView.image = icon
        }
    }
    
    var titleLabel: UILabel!
    var iconImageView: UIImageView!
    var bottomLine: UIView!
    var arrowImageView: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        iconImageView = UIImageView(frame: .zero)
        iconImageView.contentMode = .center
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
        }
        
        arrowImageView = UIImageView(frame: .zero)
        arrowImageView.contentMode = .center
        arrowImageView.image = R.image.icon_homeSelect()
        contentView.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
        }
        
        titleLabel = UILabel(frame: .zero)
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(5)
            make.right.equalTo(arrowImageView.snp.left).offset(-10)
            make.centerY.equalToSuperview()
            
        }
        
        bottomLine = UIView(frame: .zero)
        bottomLine.backgroundColor = .black
        contentView.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    class func commonCell(tableView: UITableView) -> CommonCell {
        let cellId = "commonCellIdentifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? CommonCell
        if cell == nil {
            cell = CommonCell.init(style: .default, reuseIdentifier: cellId)
        }
        return cell!
    }
    
    
}
