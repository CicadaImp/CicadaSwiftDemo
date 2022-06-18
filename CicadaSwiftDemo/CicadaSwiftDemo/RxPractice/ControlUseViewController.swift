//
//  ControlUseViewController.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/6/17.
//

import UIKit
import RxSwift
import RxCocoa

class ControlUseViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        testLabel()
//        testTextField()
//        testTextField2()
//        testCombineLatest()
        testSwitchSliderSegmentControlActivity()
    }
    /**
     需要导入RxCocoa
     */
    
    //UILabel：
    func testLabel() {
        let label = UILabel(frame: CGRect(x: 20, y: 40, width: 300, height: 40))
        label.backgroundColor = .lightGray
        view.addSubview(label)
        
        let timer = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        //将数据绑定到text属性上
//        timer.map {String(format: "%0.2d:%0.2d:%0.2d", arguments: [$0/3600, ($0 - ($0/3600) * 3600)/60, $0%60])}
//            .bind(to: label.rx.text)
//            .disposed(by: disposeBag)
        //将数据绑定到attributedText属性上
        timer.map{ self.formatTimeInterval(interval: $0)}
            .bind(to: label.rx.attributedText)
            .disposed(by: disposeBag)
    }
    
    func formatTimeInterval(interval: NSInteger) -> NSMutableAttributedString {
        
        let intervalStr = String(format: "%0.2d:%0.2d:%0.2d", arguments: [interval/3600, (interval - (interval/3600) * 3600)/60, interval%60])
        let attributedStr = NSMutableAttributedString(string: intervalStr)
        attributedStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 20), range: NSMakeRange(0, intervalStr.count - 3))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.green, range: NSMakeRange(0, intervalStr.count - 3))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.orange, range: NSMakeRange(intervalStr.count - 3, 3))
        return attributedStr
    }
    
    //UITextField：监听单个textField内容的变化
    //.orEmpty：可以将String?类型的ControlProperty转化为String，省得再去解包
    //.asObservable()和.changed效果是一样的
    func testTextField() {
        let tf = UITextField(frame: CGRect(x: 20, y: 40, width: 300, height: 150))
        tf.borderStyle = .roundedRect
        view.addSubview(tf)
        
        tf.rx.text.orEmpty.asObservable().subscribe(onNext: {print("您输入的是：" + $0)}) { error in
            print(error)
        } onCompleted: {
            print("Completed")
        }.disposed(by: disposeBag)
        
//        tf.rx.text.orEmpty.changed.subscribe(onNext: {print("您输入的是：" + $0)}) { error in
//            print(error)
//        } onCompleted: {
//            print("Completed")
//        }.disposed(by: disposeBag)
    }
    
    //UITextField：将内容绑定到其它控件上
    func testTextField2() {
        let inputTF = UITextField(frame: CGRect(x: 20, y: 40, width: 300, height: 80))
        inputTF.borderStyle = .roundedRect
        view.addSubview(inputTF)
        
        let outputTF = UITextField(frame: CGRect(x: 20, y: 160, width: 300, height: 80))
        outputTF.borderStyle = .roundedRect
        view.addSubview(outputTF)
        
        let label = UILabel(frame: CGRect(x: 20, y: 280, width: 300, height: 80))
        label.backgroundColor = .lightGray
        view.addSubview(label)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 20, y: 400, width: 300, height: 50)
//        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.setTitle("提交", for: .normal)
        button.setBackgroundImage(UIColor.lightGray.toImage(), for: .normal)
        view.addSubview(button)
        
        //当文本框内容改变
        //在主线程中操作，如果0.3秒内值多次改变，取最后一次
        let input = inputTF.rx.text.orEmpty.asDriver().throttle(.milliseconds(300))
        
        //内容绑定到另一个输入框中
        input.drive(outputTF.rx.text).disposed(by: disposeBag)
        
        //内容绑定到标签中
        input.map{"当前字数：\($0.count)"}.drive(label.rx.text).disposed(by: disposeBag)
        
        //根据字数决定按钮是否可用
        input.map {$0.count > 5}.drive(button.rx.isEnabled).disposed(by: disposeBag)

//        inputTF.rx.text.orEmpty.map {$0.count > 5}.bind { isEnabled in
//            button.setBackgroundImage(isEnabled ? UIColor.red.toImage() : UIColor.lightGray.toImage(), for: .normal)
//        }.disposed(by: disposeBag)

        button.rx.tap.subscribe(onNext: { [weak self] in
                self?.navigationController?.pushViewController(HomeViewController(), animated: true)
        }).disposed(by: disposeBag)
    }
    
    func testCombineLatest() {
        let accountTF = UITextField(frame: CGRect(x: 20, y: 40, width: 300, height: 80))
        accountTF.borderStyle = .roundedRect
        view.addSubview(accountTF)
        
        let passwordTF = UITextField(frame: CGRect(x: 20, y: 160, width: 300, height: 80))
        passwordTF.borderStyle = .roundedRect
        view.addSubview(passwordTF)
        
        let statusLabel = UILabel(frame: CGRect(x: 20, y: 280, width: 300, height: 80))
        statusLabel.backgroundColor = .lightGray
        view.addSubview(statusLabel)
        
        accountTF.rx.controlEvent(.editingDidEndOnExit).asObservable().subscribe(onNext: {
            print("开始输入账号")
        }).disposed(by: disposeBag)

        accountTF.rx.controlEvent(.editingDidEndOnExit).asObservable().subscribe(onNext: {
            passwordTF.becomeFirstResponder()
        }).disposed(by: disposeBag)

        passwordTF.rx.controlEvent(.editingDidEndOnExit).asObservable().subscribe(onNext: {
            passwordTF.resignFirstResponder()
        }).disposed(by: disposeBag)
        
        Observable.combineLatest(accountTF.rx.text.orEmpty, passwordTF.rx.text.orEmpty) { account, password in "account:\(account);password:\(password)"
        }.map{$0}.bind(to: statusLabel.rx.text).disposed(by: disposeBag)
        
//        Observable.combineLatest(accountTF.rx.text.orEmpty, passwordTF.rx.text.orEmpty) { $0 + $1
//        }.map{$0}.bind(to: statusLabel.rx.text).disposed(by: disposeBag)
    }
    
    func testSwitchSliderSegmentControlActivity() {
        let mySwitch = UISwitch(frame: CGRect(x: 20, y: 40, width: 300, height: 50))
        view.addSubview(mySwitch)
        
        let mySlider = UISlider(frame: CGRect(x: 20, y: 130, width: 300, height: 50))
        view.addSubview(mySlider)

        let mySegmentControl = UISegmentedControl(items: ["Cicdada","husly","cookie"])
        mySegmentControl.frame = CGRect(x: 20, y: 260, width: 300, height: 50)
        mySegmentControl.backgroundColor = .orange
        mySegmentControl.selectedSegmentIndex = 0
        view.addSubview(mySegmentControl)
        
        let myActivity = UIActivityIndicatorView(frame: CGRect(x: 20, y: 400, width: 80, height: 80))
        view.addSubview(myActivity)
        
        mySwitch.rx.isOn.asObservable().subscribe(onNext: {
            print("开关状态：\($0)")
        }).disposed(by: disposeBag)
        
        mySlider.rx.value.asObservable().subscribe(onNext: {
            print("当前进度：\($0)")
        }).disposed(by: disposeBag)
        
        mySegmentControl.rx.selectedSegmentIndex.asObservable().subscribe(onNext: {
            print("当前选中：\($0)")
        }).disposed(by: disposeBag)
        
        mySwitch.rx.value.asObservable().bind(to: myActivity.rx.isAnimating).disposed(by: disposeBag)
    }

}
