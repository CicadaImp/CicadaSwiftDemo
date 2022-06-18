//
//  RxNetUseViewController.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/6/18.
//

import UIKit
import RxSwift

class RxNetUseViewController: BaseViewController {

    let cicadaStr = "https://www.douban.com/j/app/radio/channels"
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        testResponse()
//        testData()
//        testJson()
    }
    
    func testResponse() {
        let url = URL(string: cicadaStr)
        URLSession.shared.rx.response(request: URLRequest(url: url!)).subscribe { (response: HTTPURLResponse, data: Data) in
            print("Cicada response:\(response)")
            if response.statusCode == 200 {
                let res = String(data: data, encoding: .utf8)
                print(res ?? "")
            } else {
                print("请求失败，状态码为：\(response.statusCode)")
            }
            
        } onError: { error in
            print("Cicada error:\(error)")
        }.disposed(by: disposeBag)

    }
    
    func testData() {
        let url = URL(string: cicadaStr)
        URLSession.shared.rx.data(request: URLRequest(url: url!)).subscribe { data in
            print("Cicada data:\(data)")
        } onError: { error in
            print("Cicada error:\(error)")
        }.disposed(by: disposeBag)
        
    }
    
    func testJson() {
        let url = URL(string: cicadaStr)
        URLSession.shared.rx.json(url: url!).subscribe { jsonData in
            print("Cicada json:\(jsonData)")
        } onError: { error in
            print("Cicada error:\(error)")
        }.disposed(by: disposeBag)

    }

    

}
