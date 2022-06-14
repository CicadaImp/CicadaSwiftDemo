//
//  ViewController.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/4/17.
//

import UIKit
import Alamofire
import SwiftyJSON
import SnapKit
import Kingfisher
import Rswift

class ViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = TestViewController()
        homeVC.tabBarItem.image = R.image.icon_home()
        homeVC.tabBarItem.selectedImage = R.image.icon_homeSelect()?.withRenderingMode(.alwaysOriginal)
        homeVC.tabBarItem.title = "测试"
        homeVC.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.hexColor(0xe84342)], for: .selected)
        let navigationHomeVC = UINavigationController(rootViewController: homeVC)
        self.addChild(navigationHomeVC)
        
//        let homeVC = HomeViewController()
//        homeVC.tabBarItem.image = R.image.icon_home()
//        homeVC.tabBarItem.selectedImage = R.image.icon_homeSelect()?.withRenderingMode(.alwaysOriginal)
//        homeVC.tabBarItem.title = "首页"
//        homeVC.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.hexColor(0xe84342)], for: .selected)
//        let navigationHomeVC = UINavigationController(rootViewController: homeVC)
//        self.addChild(navigationHomeVC)
        
        let mineVC = MineViewController()
        mineVC.tabBarItem.image = R.image.icon_mine()
        mineVC.tabBarItem.selectedImage = R.image.icon_mineSelect()?.withRenderingMode(.alwaysOriginal)
        mineVC.tabBarItem.title = "我的"
        mineVC.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.hexColor(0xe84342)], for: .selected)
        let navigationMineVC = UINavigationController(rootViewController: mineVC)
        self.addChild(navigationMineVC)
        
//        let button = UIButton(type: .custom)
//        button.setTitle("click", for: .normal)
//        button.backgroundColor = .green
//        view.addSubview(button)
//        button.addTarget(self, action: #selector(didClickButton), for: .touchUpInside)
//        button.snp.makeConstraints { make in
//            make.top.equalTo(100)
//            make.centerX.equalToSuperview()
//            make.width.equalTo(100)
//            make.height.equalTo(50)
//        }
    }
    
//    @objc func didClickButton() {
//        navigationController?.pushViewController(LoginViewController(), animated: true)
//    }
    
}

/*
class ViewController: UIViewController {

    let jsonString = """
{
    "userId": 1,
    "userName": "cicada",
    "followers": [
        {
            "userId": 2,
            "userName": "husky"
        },
        {
            "userId": 3,
            "userName": "elf"
        }
    ]
}
"""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        AF.request("https://www.geekbang.org/").response { response in
//            debugPrint(response)
//        }
        
        
        
//        subscriptTest()
//        loopTest()
//        noOptionalGetter()
//        codeJson()
        
        
//        snapTest1()
//        snapTest2()
        
//        imageTest1()
//        imageTest2()
        
        imageRTest()
    }
    
    //使用R.swift对资源文件进行管理
    func imageRTest() {
        let imageView = UIImageView(frame: view.bounds)
        view.addSubview(imageView)
        imageView.image = R.image.shanzhiImage()
    }
    
    func imageTest1() {
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .center
        view.addSubview(imageView)
        let url = URL(string: "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fgss0.baidu.com%2F7Po3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2Ff31fbe096b63f624acc472758544ebf81a4ca32f.jpg&refer=http%3A%2F%2Fgss0.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1652773025&t=bdcbd5a9c0faa8bde80fb88594d293a8")
        imageView.kf.setImage(with: url)
    
    }
    
    func imageTest2() {
        let imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .center
        view.addSubview(imageView)
        let url = URL(string: "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fgss0.baidu.com%2F7Po3dSag_xI4khGko9WTAnF6hhy%2Fzhidao%2Fpic%2Fitem%2Ff31fbe096b63f624acc472758544ebf81a4ca32f.jpg&refer=http%3A%2F%2Fgss0.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1652773025&t=bdcbd5a9c0faa8bde80fb88594d293a8")
        let processor = DownsamplingImageProcessor(size: view.bounds.size) |> RoundCornerImageProcessor(cornerRadius: 100)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [.processor(processor),
                      .scaleFactor(UIScreen.main.scale),
                      .transition(.fade(1)),
                      .cacheOriginalImage])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for:\(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed:\(error.localizedDescription)")
            }
        }
    }
    
    func snapTest1() {
        let box = UIView()
        box.backgroundColor = .green
        view.addSubview(box)
        box.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.center.equalTo(view)
        }
    }
    
    func snapTest2() {
        let box = UIView()
        view.addSubview(box)
        box.backgroundColor = .green
//        box.snp.makeConstraints { make in
//            make.top.equalTo(view).offset(20)
//            make.left.equalTo(view).offset(20)
//            make.bottom.equalTo(view).offset(-20)
//            make.right.equalTo(view).offset(-20)
//        }
        box.snp.makeConstraints { make in
            make.edges.equalTo(view).inset(UIEdgeInsets(top: 20, left: 20, bottom: -20, right: -20))
        }
        
        //make是在初始化约束的时候调用
//        box.snp.makeConstraints(<#T##closure: (ConstraintMaker) -> Void##(ConstraintMaker) -> Void##(_ make: ConstraintMaker) -> Void#>)
        //update在需要更新约束，而且这个约束和之前的约束没有冲突的时候调用
//        box.snp.updateConstraints(<#T##(ConstraintMaker) -> Void#>)
        //remake在需要更新约束，而且新的约束和之前的约束有冲突的时候调用
//        box.snp.remakeConstraints(<#T##closure: (ConstraintMaker) -> Void##(ConstraintMaker) -> Void##(_ make: ConstraintMaker) -> Void#>)
    }
    
    //解析json
    func decodeJson() -> JSON? {
        if let jsonData = jsonString.data(using: .utf8, allowLossyConversion: false) {
            let json = JSON(jsonData)
//            print(json)
            return json
        }
        return nil
    }
    
    //遍历json
    func loopTest() {
        if let json = decodeJson() {
            for (key, subJson):(String, JSON) in json {
                print("key is \(key), subJson is \(subJson)")
            }
        }
    }
    
    //非可选值getter
    func noOptionalGetter() {
        if let json = decodeJson() {
            let result = json["followers"][0]["userName"]
            print(result.stringValue)
            
            let result2 = json["followers"][10]["userName"]
            print(result2.stringValue)
            
            let result3 = json["followers"][1]["name"]
            print(result3.stringValue)
            
            print("end")
        }
    }
    
    //下标操作
    func subscriptTest() {
        if let json = decodeJson() {
            let result = json["followers"][0]["userName"]
            if let name = result.string {
                print(name)
            } else {
                print(result.error as Any)
            }
            
            let result2 = json["followers"][10]["userName"]
            if let name = result2.string {
                print(name)
            } else {
                print(result2.error as Any)
            }
            
            let result3 = json["followers"][1]["name"]
            if let name = result3.string {
                print(name)
            } else {
                print(result3.error as Any)
            }
        }
    }
    
    
    //反解析json
    func codeJson() {
        let dic = ["1":2, "2":"two", "3":nil] as [String: Any?]
        let json = JSON(dic)
        let represontation = json.rawString([.castNilToNSNull: true])
        print(represontation as Any)
    }


}
*/
