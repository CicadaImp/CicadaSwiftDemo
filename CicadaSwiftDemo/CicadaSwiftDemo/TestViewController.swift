//
//  TestViewController.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/5/31.
//
import UIKit
import RxSwift
import RxCocoa

class TestViewController: BaseViewController {

    lazy var tableView = UITableView()
    let reuserId = "cellId"
    let infoViewModel = InfoViewModel()
    //  DisposeBag的作用是：Rx在视图控制器或者其持有者将要销毁的时候，自动释放掉绑在它上面的资源，类似于NotificationCenter的removeObserver
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        setupUI()
        //rx.items(cellIdentifier:)：Rx基于cellForRow的封装，传统的还需要有numberOfRowsInSection，使用Rx后就不需要了，Rx帮我们完成了相关的工作
        infoViewModel.infoArray.bind(to: tableView.rx.items(cellIdentifier: reuserId)){
            row, model, cell in
            cell.textLabel?.text = "\(model.name) age = \(model.age), row =\(row)"
        }.disposed(by: disposeBag)

        //rx.modelSelected：Rx基于didSelectRow的封装
        tableView.rx.modelSelected(InfoModel.self).subscribe { model in
            print("点击了\(model.name),\(model.age)")
        } onError: { error in
            print("error:\(error)")
        } onCompleted: {
            print("")
        } onDisposed: {
            print("onDisposed")
        }.disposed(by: disposeBag)
    }
    
}

extension TestViewController {
    func setupUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuserId)
    }
}

struct InfoModel {
    let name: String
    let age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
}

extension InfoModel: CustomStringConvertible {
    var description: String {
        return "name:\(name), age:\(age)"
    }
}

struct InfoViewModel {
    //MARK: 模拟假数据
    let infoArray = Observable.just([
        InfoModel(name: "Cicada", age: 7),
        InfoModel(name: "Cookie", age: 24),
        InfoModel(name: "elf", age: 27),
        InfoModel(name: "husky", age: 23)])
}
