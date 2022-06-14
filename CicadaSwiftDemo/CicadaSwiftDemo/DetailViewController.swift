//
//  DetailViewController.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/4/20.
//

import UIKit
import Kingfisher

class DetailViewController: BaseViewController {

    var product: Product!
    var avatarImageView: UIImageView!
    var nameLabel: UILabel!
    var descLabel: UILabel!
    var teacherLabel: UILabel!
    var courseCountLabel: UILabel!
    var studentCountLabel: UILabel!
    var tab: Tab!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "详情"
        createTop()
        createMiddle()
        createBottom()

    }
    
    func createTop() {
        let topView = UIView(frame: .zero)
        topView.backgroundColor = .gray
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.kf.setImage(with: URL(string: product.imageUrl), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: 10))], completionHandler: nil)
        topView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.left.top.equalTo(20)
            make.width.equalTo(82)
            make.height.equalTo(108)
        }
        
        nameLabel = UILabel(frame: .zero)
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        nameLabel.text = product.name
        topView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.top.equalTo(avatarImageView)
            make.right.equalTo(topView).offset(-15)
        }
        
        descLabel = UILabel(frame: .zero)
        descLabel.textColor = .white
        descLabel.font = UIFont.systemFont(ofSize: 14)
        descLabel.numberOfLines = 2
        descLabel.text = product.desc
        topView.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.left.right.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        
        teacherLabel = UILabel(frame: .zero)
        teacherLabel.textColor = .white
        teacherLabel.font = UIFont.systemFont(ofSize: 14)
        teacherLabel.text = "讲师：\(product.teacher)"
        topView.addSubview(teacherLabel)
        teacherLabel.snp.makeConstraints { make in
            make.left.right.equalTo(nameLabel)
            make.bottom.equalTo(avatarImageView)
        }
        
        let bookAttachment = NSTextAttachment()
        bookAttachment.image = R.image.icon_mine()
        bookAttachment.bounds = CGRect(x: -2, y: -3, width: bookAttachment.image?.size.width ?? 0, height: bookAttachment.image?.size.height ?? 0)
        let bookAttachmentString = NSMutableAttributedString(attachment: bookAttachment)
        let courseCountString = NSMutableAttributedString(string: "")
        courseCountString.append(bookAttachmentString)
        let courseCountStringAfterIcon = NSMutableAttributedString(string: " 共\(product.total) 讲 更新至 \(product.update) 讲")
        courseCountString.append(courseCountStringAfterIcon)
        
        courseCountLabel = UILabel(frame: .zero)
        courseCountLabel.textColor = .white
        courseCountLabel.font = UIFont.systemFont(ofSize: 14)
        courseCountLabel.attributedText = courseCountString
        topView.addSubview(courseCountLabel)
        courseCountLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView)
            make.bottom.equalTo(topView)
        }
        
        let studentAttachment = NSTextAttachment()
        studentAttachment.image = R.image.icon_home()
        studentAttachment.bounds = CGRect(x: -2, y: -3, width: studentAttachment.image?.size.width ?? 0, height: studentAttachment.image?.size.height ?? 0)
        let studentAttachmentString = NSMutableAttributedString(attachment: studentAttachment)
        let studentCountString = NSMutableAttributedString(string: "")
        studentCountString.append(studentAttachmentString)
        let studentCountStringAfterIcon = NSMutableAttributedString(string: "共 \(product.student) 人学习")
        studentCountString.append(studentCountStringAfterIcon)
        
        studentCountLabel = UILabel(frame: .zero)
        studentCountLabel.textColor = .white
        studentCountLabel.font = UIFont.systemFont(ofSize: 14)
        studentCountLabel.attributedText = studentCountString
        topView.addSubview(studentCountLabel)
        studentCountLabel.snp.makeConstraints { make in
            make.right.equalTo(topView).offset(-20)
            make.bottom.equalTo(topView)
        }
        
    }
    
    func createMiddle() {
        tab = Tab(items: ["课程介绍", "课程目录"])
        view.addSubview(tab)
        tab.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(200)
            make.height.equalTo(45)
        }
    }
    
    func createBottom() {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("购买 ¥\(product.price)", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setBackgroundImage(UIColor.hexColor(0xf8892e).toImage(), for: .normal)
        button.addTarget(self, action: #selector(didClickBuyButton), for: .touchUpInside)
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    @objc func didClickBuyButton() {
        
    }
    
}
