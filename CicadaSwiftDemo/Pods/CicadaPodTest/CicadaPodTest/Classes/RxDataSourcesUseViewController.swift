//
//  RxDataSourcesUseViewController.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/6/18.
//

import UIKit
import RxSwift
import RxDataSources

class RxDataSourcesUseViewController: UIViewController {

    var tableView: UITableView!
    let reuseIdentfier = "myTableViewCell"
    let disposeBag = DisposeBag()
    let datas = GithubData()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 500), style: .grouped)
        tableView.register(SectionTableViewCell.self, forCellReuseIdentifier: reuseIdentfier)
        tableView.sectionFooterHeight = 0
        view.addSubview(tableView)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, SectionDataModel>> { dataSource, tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentfier, for: indexPath) as? SectionTableViewCell
            cell?.imageView?.image = model.image
            cell?.textLabel?.text = model.name
            cell?.detailTextLabel?.text = model.gitHubID
            
            return cell!
        } titleForHeaderInSection: { dataSource, index in
            return dataSource.sectionModels[index].model
        }
        
        datas.githubData.asDriver(onErrorJustReturn: []).drive(tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        

        tableView.rx.itemSelected.subscribe(onNext: {
            [weak self] indexPath in
//            self?.navigationController?.pushViewController(HomeViewController(), animated: true)
        }).disposed(by: disposeBag)

        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    
    
    

}

class SectionTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct SectionDataModel {
    let name: String
    let gitHubID: String
    var image: UIImage?
    init(name: String, gitHubID: String) {
        self.name = name
        self.gitHubID = gitHubID
        image = UIImage(named: gitHubID)
    }
}


/**
 https://cocoapods.org/pods/RxDataSources
 RxDataSources 提供了两种特殊的数据源类型，它们自动处理绑定数据源中的动画更改：RxTableViewSectionedAnimatedDataSource和RxCollectionViewSectionedAnimatedDataSource.

 要使用两个动画数据源之一，您必须在采取一些额外步骤：

 SectionOfCustomData 需要符合AnimatableSectionModelType
 您的数据模型必须符合
 IdentifiableType：协议identity提供的IdentifiableType必须是表示模型实例的不可变标识符。例如，对于Car模型，您可能希望使用汽车plateNumber作为其身份。
 Equatable：符合Equatable有助于RxDataSources确定哪些单元格已更改，因此它只能为这些特定单元格设置动画。这意味着，更改模型的任何Car属性都会触发该单元格的动画重新加载。

 */
extension SectionDataModel: IdentifiableType {
    typealias Identity = String
    var identity: Identity {
        return gitHubID
    }
}

class GithubData {
    let githubData = Observable.just([
            SectionModel(model: "A", items: [
                SectionDataModel(name: "Alex V Bush", gitHubID: "alexvbush"),
                SectionDataModel(name: "Andrew Breckenridge", gitHubID: "AndrewSB"),
                SectionDataModel(name: "Anton Efimenko", gitHubID: "reloni"),
                SectionDataModel(name: "Ash Furrow", gitHubID: "ashfurrow"),
                ]),
            SectionModel(model: "B", items: [
                SectionDataModel(name: "Ben Emdon", gitHubID: "BenEmdon"),
                SectionDataModel(name: "Bob Spryn", gitHubID: "sprynmr"),
                ]),
            SectionModel(model: "C", items: [
                SectionDataModel(name: "Carlos García", gitHubID: "carlosypunto"),
                SectionDataModel(name: "Cezary Kopacz", gitHubID: "CezaryKopacz"),
                SectionDataModel(name: "Chris Jimenez", gitHubID: "PiXeL16"),
                SectionDataModel(name: "Christian Tietze", gitHubID: "DivineDominion"),
                ]),
            SectionModel(model: "D", items: [
                SectionDataModel(name: "だいちろ", gitHubID: "mokumoku"),
                SectionDataModel(name: "David Alejandro", gitHubID: "davidlondono"),
                SectionDataModel(name: "David Paschich", gitHubID: "dpassage"),
                ]),
            SectionModel(model: "E", items: [
                SectionDataModel(name: "Esteban Torres", gitHubID: "esttorhe"),
                SectionDataModel(name: "Evgeny Aleksandrov", gitHubID: "ealeksandrov"),
                ]),
            SectionModel(model: "F", items: [
                SectionDataModel(name: "Florent Pillet", gitHubID: "fpillet"),
                SectionDataModel(name: "Francis Chong", gitHubID: "siuying"),
                ]),
            SectionModel(model: "G", items: [
                SectionDataModel(name: "Giorgos Tsiapaliokas", gitHubID: "terietor"),
                SectionDataModel(name: "Guy Kahlon", gitHubID: "GuyKahlon"),
                SectionDataModel(name: "Gwendal Roué", gitHubID: "groue"),
                ]),
            SectionModel(model: "H", items: [
                SectionDataModel(name: "Hiroshi Kimura", gitHubID: "muukii"),
                ]),
            SectionModel(model: "I", items: [
                SectionDataModel(name: "Ivan Bruel", gitHubID: "ivanbruel"),
                ]),
            SectionModel(model: "J", items: [
                SectionDataModel(name: "Jeon Suyeol", gitHubID: "devxoul"),
                SectionDataModel(name: "Jérôme Alves", gitHubID: "jegnux"),
                SectionDataModel(name: "Jesse Farless", gitHubID: "solidcell"),
                SectionDataModel(name: "Junior B.", gitHubID: "bontoJR"),
                SectionDataModel(name: "Justin Swart", gitHubID: "justinswart"),
                ]),
            SectionModel(model: "K", items: [
                SectionDataModel(name: "Karlo", gitHubID: "floskel"),
                SectionDataModel(name: "Krunoslav Zaher", gitHubID: "kzaher"),
                ]),
            SectionModel(model: "L", items: [
                SectionDataModel(name: "Laurin Brandner", gitHubID: "lbrndnr"),
                SectionDataModel(name: "Lee Sun-Hyoup", gitHubID: "kciter"),
                SectionDataModel(name: "Leo Picado", gitHubID: "leopic"),
                SectionDataModel(name: "Libor Huspenina", gitHubID: "libec"),
                SectionDataModel(name: "Lukas Lipka", gitHubID: "lipka"),
                SectionDataModel(name: "Łukasz Mróz", gitHubID: "sunshinejr"),
                ]),
            SectionModel(model: "M", items: [
                SectionDataModel(name: "Marin Todorov", gitHubID: "icanzilb"),
                SectionDataModel(name: "Maurício Hanika", gitHubID: "mAu888"),
                SectionDataModel(name: "Maximilian Alexander", gitHubID: "mbalex99"),
                ]),
            SectionModel(model: "N", items: [
                SectionDataModel(name: "Nathan Kot", gitHubID: "nathankot"),
                ]),
            SectionModel(model: "O", items: [
                SectionDataModel(name: "Orakaro", gitHubID: "DTVD"),
                SectionDataModel(name: "Orta", gitHubID: "orta"),
                ]),
            SectionModel(model: "P", items: [
                SectionDataModel(name: "Paweł Urbanek", gitHubID: "pawurb"),
                SectionDataModel(name: "Pedro Piñera Buendía", gitHubID: "pepibumur"),
                SectionDataModel(name: "PG Herveou", gitHubID: "pgherveou"),
                ]),
            SectionModel(model: "R", items: [
                SectionDataModel(name: "Rui Costa", gitHubID: "ruipfcosta"),
                SectionDataModel(name: "Ryo Fukuda", gitHubID: "yuzushioh"),
                ]),
            SectionModel(model: "S", items: [
                SectionDataModel(name: "Scott Gardner", gitHubID: "scotteg"),
                SectionDataModel(name: "Scott Hoyt", gitHubID: "scottrhoyt"),
                SectionDataModel(name: "Sendy Halim", gitHubID: "sendyhalim"),
                SectionDataModel(name: "Serg Dort", gitHubID: "sergdort"),
                SectionDataModel(name: "Shai Mishali", gitHubID: "freak4pc"),
                SectionDataModel(name: "Shams Ahmed", gitHubID: "shams-ahmed"),
                SectionDataModel(name: "Shenghan Chen", gitHubID: "zzdjk6"),
                SectionDataModel(name: "Shunki Tan", gitHubID: "milkit"),
                SectionDataModel(name: "Spiros Gerokostas", gitHubID: "sger"),
                SectionDataModel(name: "Stefano Mondino", gitHubID: "stefanomondino"),
                ]),
            SectionModel(model: "T", items: [
                SectionDataModel(name: "Thane Gill", gitHubID: "thanegill"),
                SectionDataModel(name: "Thomas Duplomb", gitHubID: "tomahh"),
                SectionDataModel(name: "Tomasz Pikć", gitHubID: "pikciu"),
                SectionDataModel(name: "Tony Arnold", gitHubID: "tonyarnold"),
                SectionDataModel(name: "Torsten Curdt", gitHubID: "tcurdt"),
                ]),
            SectionModel(model: "V", items: [
                SectionDataModel(name: "Vladimir Burdukov", gitHubID: "chipp"),
                ]),
            SectionModel(model: "W", items: [
                SectionDataModel(name: "Wolfgang Lutz", gitHubID: "Lutzifer"),
                ]),
            SectionModel(model: "X", items: [
                SectionDataModel(name: "xixi197 Nova", gitHubID: "xixi197"),
                ]),
            SectionModel(model: "Y", items: [
                SectionDataModel(name: "Yongha Yoo", gitHubID: "inkyfox"),
                SectionDataModel(name: "Yosuke Ishikawa", gitHubID: "ishkawa"),
                SectionDataModel(name: "Yury Korolev", gitHubID: "yury"),
                ]),
            ])
    
}

extension RxDataSourcesUseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    //同时实现以下两个方法，footer设置才有效（仅设置 tableView.sectionFooterHeight = 0 也有效）
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0.001
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return nil
//    }
}
