//
//  SubjectsViewController.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/6/17.
//

import UIKit
import RxSwift
import RxRelay

class SubjectsViewController: BaseViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        testPublishSubject()
//        testBehaviorSubject()
//        testReplaySubject()
//        testBehaviorRelay()

    }
    
    /**
     Subjects和Observable的区别：
     Observable：
     创建的时候就要把值准备好，当订阅后再通过event把值发送出去。
     Subjects：
     Subjects既是订阅者，又是Observable
     订阅者：Subjects能够动态的接收新值
     Observable：有了新值后，就会通过event发送给它所有的订阅者
     */
    
    //PublishSubject：不需要初始值就能创建
    //从订阅者订阅的时间起，订阅者能收到订阅之后Subjects发出的事件，不能收到Subjects之前发出的事件。
    func testPublishSubject() {
        let subject = PublishSubject<String>()
        subject.onNext("aaa")
        subject.subscribe{print("第1次订阅：\($0)")}.disposed(by: disposeBag)
        subject.onNext("bbb")
        subject.subscribe{print("第2次订阅：\($0)")}.disposed(by: disposeBag)
        subject.onNext("ccc")
        subject.onCompleted()
        subject.subscribe{print("第3次订阅：\($0)")}.disposed(by: disposeBag)
        subject.onNext("ddd")
    }
    
    //BehaviorSubject：需要通过一个默认的初始值来创建
    //当订阅者订阅之后，会立即收到subject发出的上一个event事件，之后就和正常情况一样
    func testBehaviorSubject() {
        let subject = BehaviorSubject(value: "111")
        subject.subscribe{print("第1次订阅：\($0)")}.disposed(by: disposeBag)
        subject.onNext("222")
        subject.onNext("333")
        subject.subscribe{print("第2次订阅：\($0)")}.disposed(by: disposeBag)
        subject.onNext("444")
        subject.onCompleted()
        subject.subscribe{print("第3次订阅：\($0)")}.disposed(by: disposeBag)
        subject.onNext("555")
    }
    
    //ReplaySubject：bufferSize：缓冲个数 如果发出3个event，就会把后2个event缓存起来
    //当缓冲个数为2的时候，订阅者一旦订阅，立刻就能收到前面缓存的2个event
    //如果订阅者订阅了一个已结束的ReplaySubject，除了会收到缓存的event，还会收到终结的.error或者.complete的event
    func testReplaySubject() {
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        subject.onNext("111")
        subject.onNext("222")
        subject.subscribe{print("第1次订阅：\($0)")}.disposed(by: disposeBag)
        subject.onNext("333")
        subject.subscribe{print("第2次订阅：\($0)")}.disposed(by: disposeBag)
        subject.onNext("444")
        subject.onCompleted()
        subject.subscribe{print("第3次订阅：\($0)")}.disposed(by: disposeBag)
        subject.onNext("555")
    }
    
    //BehaviorRelay：是对BehaviorSubject的封装
    //accept()：对值进行修改
    //value：获取新值
    func testBehaviorRelay() {
        let subject = BehaviorRelay(value: [111])
        subject.accept(subject.value + [222])
        subject.subscribe{print("第1次订阅：\($0)")}.disposed(by: disposeBag)
        subject.accept(subject.value + [333])
        subject.accept(subject.value + [444])
        subject.subscribe{print("第2次订阅：\($0)")}.disposed(by: disposeBag)
        subject.accept(subject.value + [555])
    }
}
