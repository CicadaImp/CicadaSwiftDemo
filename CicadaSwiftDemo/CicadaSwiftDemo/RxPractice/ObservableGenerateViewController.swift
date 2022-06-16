//
//  ObservableGenerateViewController.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/6/16.
//

import UIKit
import RxSwift

class ObservableGenerateViewController: BaseViewController {

    //  DisposeBag的作用是：Rx在视图控制器或者其持有者将要销毁的时候，自动释放掉绑在它上面的资源，类似于NotificationCenter的removeObserver
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        //Observable序列的产生
        /**
         创建序列最直接的方式：Observable.create，然后在构建函数里描述元素的产生过程
         obser.onNext("Cicada")：代表产生了一个元素，它的值为Cicada
         obser.onCompleted()：表示元素已经全部产生
         Disposables.create()：采用可选闭包，将取消的代码放在这个闭包里；如果数据绑定被清除（订阅被取消），就取消对应的操作
         */
        let myObserver: Observable<Any> = Observable.create { (obser) -> Disposable in
            obser.onNext("Cicada")
            obser.onNext(666)
            obser.onNext("Husky")
            obser.onCompleted()
            return Disposables.create()
        }
        
        myObserver.subscribe { event in
            print("CicadaEvent:\(event)")
        } onError: { error in
            print(error)
        } onCompleted: {
            print("Completed")
        } onDisposed: {
            print("Disposed")
        }.disposed(by: disposeBag)

        //just：创建Observable，发出唯一的一个元素
        Observable.just(222).subscribe { event in
            print("just:\(event)")
        }.disposed(by: disposeBag)

        //of：接受可变数量的参数，必须是同类型的
        Observable.of("2","5","7").subscribe { event in
            print("of:\(event)")
        }.disposed(by: disposeBag)
        
        //from：需要传入一个数组参数，数组里面的元素不需要是同类型的
        Observable.from([2,4,6,1,"3"]).subscribe { event in
            print("from:\(event)")
        }.disposed(by: disposeBag)

        //never：创建一个不会产生任何事件的Observable序列
        Observable<Any>.never().subscribe { event in
            print("never:\(event)")
        }.disposed(by: disposeBag)

        //empty：创建一个空内容的Observable序列，会打印completed
        Observable<Any>.empty().subscribe { event in
            print("empty:\(event)")
        }.disposed(by: disposeBag)

        //error：创建只有一个error事件的Observable序列
        let error = MyError.A
        Observable<Any>.error(error).subscribe { event in
            print("error:\(event)")
        }.disposed(by: disposeBag)
        
        //range：通过指定start和count，创建以这个区间内所有值为初始值的序列
        Observable.range(start: 7, count: 5).subscribe { event in
            print("range:\(event)")
        }.disposed(by: disposeBag)

        //repeatElement：创建一个可以无限发出给定元素的序列
        Observable.repeatElement(666).subscribe { event in
            print("repeatElement:\(event)")
        }.disposed(by: disposeBag)

        //generate：所有的条件都为true的时候，才会给出动作的序列
        //initialState：初始值； condition：条件； iterate：迭代
        Observable.generate(initialState: 1, condition: {$0<10}, iterate: {$0+2}).subscribe { event in
            print("generate:\(event)")
        }.disposed(by: disposeBag)
        
        //deferred：该方法相当于创建一个Observable工厂，通过传入一个block延迟Observable的创建；直到订阅，才创建
        var flag = true
        let factory = Observable<Int>.deferred { () -> Observable<Int> in
            flag = !flag
            if flag {
                return Observable.of(2,4,6,8,10)
            } else {
                return Observable.of(1,3,5,7,9)
            }
        }
        factory.subscribe { event in
            print("deferrer:\(flag),\(event)")
        }.disposed(by: disposeBag)
        
        factory.subscribe { event in
            print("deferrer:\(flag),\(event)")
        }.disposed(by: disposeBag)
        
        //interval：每隔一段时间，发出一个索引数的元素
        Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).subscribe { event in
            print("interval:\(event)")
        }.disposed(by: disposeBag)

        //timer：经过一段时间之后产生唯一的一个元素
        Observable<Int>.timer(.seconds(1), scheduler: MainScheduler.instance).subscribe { event in
            print("timer:\(event)")
        }.disposed(by: disposeBag)
        
        //经过设定的一段时间后，每隔一段时间产生一个元素
        Observable<Int>.timer(.seconds(5), period: .seconds(1), scheduler: MainScheduler.instance).subscribe { event in
            print("timer:\(event)")
        }.disposed(by: disposeBag)
    }
    
    enum MyError: Error {
        case A
        case B
        var errorType: String {
            switch self {
            case .A:
                return "error A"
            case .B:
                return "error B"
            }
        }
    }
    
}
