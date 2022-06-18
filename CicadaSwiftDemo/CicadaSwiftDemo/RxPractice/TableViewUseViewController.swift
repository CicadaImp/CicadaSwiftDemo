//
//  TableViewUseViewController.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/6/18.
//

import UIKit
import RxSwift

class TableViewUseViewController: BaseViewController {

    var myTableView: UITableView!
    let disposeBag = DisposeBag()
    let reuseIdentifier = "myTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView = UITableView(frame: view.bounds, style: .plain)
        myTableView.register(MyTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(myTableView)
                
        myTableView.isEditing = true
        
        let items = Observable.just(MyInfoViewModel().arr)
        
        items.bind(to: myTableView.rx.items){
            tableView, row, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier) as? MyTableViewCell
            cell?.titleLabel?.text = model.titleStr
            cell?.nameLabel?.text = model.nameStr
            return cell!
        }.disposed(by: disposeBag)
            
        myTableView.rx.itemSelected.subscribe(onNext: {print("选中了第\($0.row)行")}).disposed(by: disposeBag)
        
        myTableView.rx.modelSelected(DataModel.self).subscribe(onNext: {
            model in
            print("点击了：\(model.titleStr),\(model.nameStr)")
        }).disposed(by: disposeBag)

        myTableView.rx.itemDeleted.subscribe(onNext: {
            print("删除了第\($0.row)行")
        }).disposed(by: disposeBag)

        myTableView.rx.itemInserted.subscribe(onNext: {
            print("从第\($0.row)行插入")
        }).disposed(by: disposeBag)
        
        myTableView.rx.itemMoved.subscribe(onNext: {
            (sourceIndex, destIndex) in
            print("从\(sourceIndex)移动到\(destIndex)")
        }).disposed(by: disposeBag)
        
    }
}

struct DataModel {
    let titleStr: String
    let nameStr: String
}

struct MyInfoViewModel {
    var arr = Array<DataModel>()
    init() {
        arr.append(DataModel(titleStr: "111", nameStr: "Cicada"))
        arr.append(DataModel(titleStr: "222", nameStr: "husky"))
        arr.append(DataModel(titleStr: "333", nameStr: "cookie"))
        arr.append(DataModel(titleStr: "444", nameStr: "elf"))
    }
}

class MyTableViewCell: UITableViewCell {
    var titleLabel: UILabel?
    var nameLabel: UILabel?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        titleLabel = UILabel(frame: CGRect(x: 20, y: 5, width: 100, height: 15))
        contentView.addSubview(titleLabel!)
        nameLabel = UILabel(frame: CGRect(x: 20, y: 25, width: 100, height: 15))
        contentView.addSubview(nameLabel!)
    }
    
    func handleData(titleStr: String, nameStr: String) {
        titleLabel?.text = titleStr
        nameLabel?.text = nameStr
    }
}
