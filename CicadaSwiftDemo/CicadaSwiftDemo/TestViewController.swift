//
//  TestViewController.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/5/31.
//
//我是02修改

import UIKit
import RxSwift
import RxCocoa

class TestViewController: BaseViewController {

    lazy var tableView = UITableView()
    let reuserId = "cellId"
    let infoViewModel = InfoViewModel()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        infoViewModel.infoArray.bind(to: tableView.rx.items(cellIdentifier: reuserId)){
            row, model, cell in
            cell.textLabel?.text = "\(model.name) age = \(model.age), row =\(row)"
        }.disposed(by: disposeBag)

        tableView.rx.modelSelected(InfoModel.self).subscribe { model in
            print("点击了\(model.name),\(model.age)")
        } onError: { error in
            print("error:\(error)")
        } onCompleted: {
            
        } onDisposed: {
            
        }

//        tableView.rx.modelSelected(InfoModel.self).subscribe { (model) in
//            print("点击了\(model.name),\(model.age)")
//        } .disposed(by: disposeBag)

//        infoViewModel.infoArray
//        infoViewModel.infoArray.
//        tableView.rx.
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
