//
//  HigherOrderFunctionViewController.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/6/16.
//

import UIKit
import RxSwift

class HigherOrderFunctionViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        testFiler()
//        testDistinctUntilChanged()
//        testElement()
//        testIgnoreElements()
//        testTake()
//        testTakeLast()
//        testSkip()
//        testSample()
//        testDebounce()
//        testGroupBy()
//        testMap()
//        testFlatMap()
//        testContactMap()
//        testBuffer()
//        testWindow()

    }
    
    //filter：过滤掉不符合要求的事件
    func testFiler() {
        Observable.of(2,5,10,7,30,15)
            .filter{$0 > 10}
            .subscribe { event in
            print("filter:\(event)")}
            .disposed(by: disposeBag)
    }
    
    //distinctUntilChanged：过滤掉连续重复的事件
    func testDistinctUntilChanged() {
        Observable.of(1,2,3,2,2,2,4,5,5,7,8)
            .distinctUntilChanged()
            .subscribe {print($0)}
            .disposed(by: disposeBag)

    }
    
    //只发送你选定的那个元素
    func testElement() {
        Observable.of(1,3,4,5,6,0,3)
            .element(at: 3)
            .subscribe{print($0)}
            .disposed(by: disposeBag)
    }
    
    //忽略掉所有元素，只关心error,completed事件
    func testIgnoreElements() {
        Observable.of(2,34,5,7)
            .ignoreElements()
            .subscribe{print($0)}
            .disposed(by: disposeBag)
    }
    
    //实现仅发送序列中的前n个事件
    func testTake() {
        Observable.of(2,34,5,7,4,6,8,6,3,3,656,33)
            .take(5)
            .subscribe{print($0)}
            .disposed(by: disposeBag)
    }
    
    //实现仅发送序列中的后n个事件
    func testTakeLast() {
        Observable.of(2,34,5,7,4,6,8,6,3,3,656,33)
            .takeLast(5)
            .subscribe{print($0)}
            .disposed(by: disposeBag)
    }
    
    //跳过前n个事件
    func testSkip() {
        Observable.of(2,34,5,7,4,6,8,6,3,3,656,33)
            .skip(3)
            .subscribe{print($0)}
            .disposed(by: disposeBag)
    }
    
    //sample：secondSubject的事件会触发firstSubject的响应，如果两次secondSubject间没有firstSubject的值，则不发送值
    func testSample() {
        let firstSubject = PublishSubject<Int>()
        let secondSubject = PublishSubject<String>()
        firstSubject.sample(secondSubject)
            .subscribe{print($0)}
            .disposed(by: disposeBag)
        
        firstSubject.onNext(2)
        secondSubject.onNext("B")
        firstSubject.onNext(4)
        secondSubject.onNext("D")
        secondSubject.onNext("F")
        firstSubject.onNext(5)
        firstSubject.onNext(7)
        secondSubject.onNext("H")
        firstSubject.onNext(10)
        
    }
    
    //debounce：触发事件后函数不会立即执行，而是在n秒后执行，如果在n秒内又出发了时间，则会重新计算时间。例如电梯的自动关门
    func testDebounce() {
        //定义好每个事件里的值以及发送的时间
        let times = [["value": 1,"time": 0.1],//电梯按关闭按钮触发事件1，500毫秒内没事件，500毫秒后自动关门
                     ["value": 2,"time": 1.1],//电梯按关闭按钮触发事件2，500毫秒内有事件，该事件为事件3，从事件3重新计算500毫秒
                     ["value": 3,"time": 1.2],//电梯按关闭按钮触发事件3，500毫秒内有事件，该事件为事件4，从事件4重新计算500毫秒
                     ["value": 4,"time": 1.2],//电梯按关闭按钮触发事件4，500毫秒内有事件，该事件为事件5，从事件5重新计算500毫秒
                     ["value": 5,"time": 1.4],//电梯按关闭按钮触发事件5，500毫秒内没事件，500毫秒后自动关门
                     ["value": 6,"time": 2.1]]//电梯按关闭按钮触发事件6，500毫秒内没事件，500毫秒后自动关门
        Observable.from(times)
            .flatMap { item in
                return Observable.of(Int(item["value"]!)).delaySubscription(.milliseconds(Int(item["time"]! * 1000)), scheduler: MainScheduler.instance)
            }
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)//只发出与下一个间隔超过0.5秒的元素
            .subscribe{print($0)}
            .disposed(by: disposeBag)
    }
    
    //groupBy：将源Observable分解为多个子Observable，然后将子Observable发送出来，它会将这些元素通过某个键进行分组，然后将分组后的元素序列按照Observable发送出来
    func testGroupBy() {
        Observable.of(1,3,2,4,5,7,8,10,14,13).groupBy { element -> String in
            return element % 2 == 0 ? "偶数" : "奇数"
        }.subscribe { groupedObservable in
            groupedObservable.asObservable()
                .subscribe{print("event:\($0);key:\(groupedObservable.key)")}
                .disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)

    }
    
    //map：通过传入一个闭包，把原来的Observable序列转变为一个新的Observable序列
    func testMap() {
        let subject = PublishSubject<String>()
        subject.map { str -> String in
            return str + " hello world"}
        .subscribe{print($0)}
        .disposed(by: disposeBag)
        
        subject.onNext("cicada")
        subject.onNext("husky")
        subject.onNext("cookie")
        subject.onNext("elf")
    }
    
    //flatMap：将源Observable的每一个元素转化为Observables，然后将Observables的元素合并之后再发送出来
    func testFlatMap() {
        let first = BehaviorSubject(value: "A")
        let second = BehaviorSubject(value: "1")
        let subject = BehaviorSubject(value: first)
        subject.asObservable()
            .flatMap {$0}
            .subscribe{print($0)}
            .disposed(by: disposeBag)
        first.onNext("B")
        subject.onNext(second)
        second.onNext("2")
        first.onNext("C")
        
    }
    
    //concatMap：当前一个Observable的元素发送完毕之后，后一个Observable的元素才开始发送。或者说当前一个Observable的事件产生完成之后，后一个Observable才开始订阅
    func testContactMap() {
        let first = BehaviorSubject(value: "A")
        let second = BehaviorSubject(value: "1")
        let subject = BehaviorSubject(value: first)
        subject.asObservable()
            .concatMap {$0}
            .subscribe{print($0)}
            .disposed(by: disposeBag)
        first.onNext("B")
        subject.onNext(second)
        second.onNext("2")
        first.onNext("C")
        /**
         next(A)
         next(B)
         next(C)
         发现没有打印1，2，说明first还没有完成
         */
        
        first.onCompleted()
        /**
         next(A)
         next(B)
         next(C)
         next(2)
         没有打印1，因为在储存订阅的时候，发现1没有订阅，被2替换了储存⚠️
         */
    }
    
    //buffer：timeSpan：缓冲时间；count：缓冲个数；scheduler：线程
    //缓存Observable中发出的新元素，当到达了特定的事件，或者元素达到了特定的数量，就把这个元素集合发送出来
    func testBuffer() {
        let subject = PublishSubject<String>()
        subject.buffer(timeSpan: .seconds(2), count: 3, scheduler: MainScheduler.instance)
            .subscribe{print($0)}
            .disposed(by: disposeBag)
        subject.onNext("111")
        subject.onNext("222")
        subject.onNext("333")
        subject.onNext("444")
        subject.onNext("aaa")
        subject.onNext("bbb")
        subject.onNext("ccc")
        subject.onNext("ddd")
        //当所有事件完毕，不会有储存事件，就会打印[]
    }
    
    //window：和buffer十分相似，buffer是周期性的把元素集合发送出来，window是周期性的把元素集合以Observable的形式发送出来
    //buffer要等到元素收集完毕后才会发出元素序列，window可以实时的发出元素序列
    func testWindow() {
        let subject = PublishSubject<String>()
        subject.window(timeSpan: .seconds(2), count: 3, scheduler: MainScheduler.instance)
            .subscribe{print($0)}
            .disposed(by: disposeBag)

        subject.onNext("111")
        subject.onNext("222")
        subject.onNext("333")
        subject.onNext("444")
        subject.onNext("aaa")
        subject.onNext("bbb")
        subject.onNext("ccc")
        subject.onNext("ddd")
        
        /*
        let subject = PublishSubject<String>()
        subject.window(timeSpan: .seconds(2), count: 3, scheduler: MainScheduler.instance)
            .subscribe{ obser in
                obser.asObservable()
                    .subscribe{print($0)}
                    .disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)

        subject.onNext("111")
        subject.onNext("222")
        subject.onNext("333")
        subject.onNext("444")
        subject.onNext("aaa")
        subject.onNext("bbb")
        subject.onNext("ccc")
        subject.onNext("ddd")
        **/
        
        /*
        Observable.of("111","222","333","444","aaa","bbb","ccc","ddd").window(timeSpan: .seconds(2), count: 3, scheduler: MainScheduler.instance)
            .subscribe{ obser in
                obser.asObservable().subscribe{print($0)}.disposed(by: self.disposeBag)
            }
            .disposed(by: disposeBag)
         **/
    }

}
