//
//  FakeData.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/4/17.
//

import Foundation

class FakeData {
    private static var bannerList = [String]()
    private static var products = [Product]()
    private static var deals = [Deal]()
    
    static func createBanners() -> [String]{
        if bannerList.count == 0 {
            bannerList =
            ["https://img0.baidu.com/it/u=2111913398,1581495844&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
             "https://img1.baidu.com/it/u=2678252040,3974596706&fm=253&fmt=auto&app=138&f=JPEG?w=281&h=500",
             "https://img2.baidu.com/it/u=9636314,553960434&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889"]
        }
        return bannerList
    }
    
    static func createProducts() -> [Product] {
        if products.count == 0 {
            let p1 = Product(imageUrl: "https://img2.baidu.com/it/u=2905305078,1333956695&fm=253&fmt=auto&app=138&f=JPEG?w=398&h=500", name: "Swift学习实战", price: 20, desc: "Swift学习实战学习这里只是用来测试一下", teacher: "路飞", total: 30, update: 2, student: 1234, detail: "Swift学习实战学习这里只是用来测试一下Swift学习实战学习这里只是用来测试一下Swift学习实战学习这里只是用来测试一下", courseList: "开篇词（1讲）")
            let p2 = Product(imageUrl: "https://img2.baidu.com/it/u=3446690952,3068751321&fm=253&fmt=auto&app=138&f=JPEG?w=1000&h=500", name: "Flutter学习", price: 20, desc: "Flutter学习这里只是用来测试一下", teacher: "山治", total: 20, update: 5, student: 342345, detail: "Flutter学习这里只是用来测试一下哈哈Flutter学习这里只是用来测试一下哈哈Flutter学习这里只是用来测试一下哈哈", courseList: "开篇词（1讲）")
            let p3 = Product(imageUrl: "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.yzcdn.cn%2Fupload_files%2F2017%2F03%2F03%2F14885317525464979.jpg%3FimageView2%2F2%2Fw%2F580%2Fh%2F580%2Fq%2F75%2Fformat%2Fjpg&refer=http%3A%2F%2Fimg.yzcdn.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1652977360&t=01ccebe20988d5ffe04ee3290dd0eeaf", name: "Objective-C学习", price: 20, desc: "Objective-C学习这里只是用来测试一下", teacher: "索隆", total: 50, update: 23, student: 345, detail: "Objective-C学习这里只是用来测试一下哈哈哈Objective-C学习这里只是用来测试一下哈哈Objective-C学习这里只是用来测试一下哈哈", courseList: "开篇词（1讲）")
            let p4 = Product(imageUrl: "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Ffile.elecfans.com%2Fweb1%2FM00%2F61%2F57%2FpIYBAFuDq8aACoA6AAZpTrtIpzY184.png&refer=http%3A%2F%2Ffile.elecfans.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1652787687&t=2136be089376ad63d3d9ffbfeb405832", name: "C++学习", price: 20, desc: "c++学习这里只是用来测试", teacher: "罗宾", total: 8, update: 5, student: 786, detail: "c++学习这里只是用来测试一下哈哈哈c++学习这里只是用来测试一下哈哈哈c++学习这里只是用来测试一下哈哈哈c++学习这里只是用来测试一下哈哈哈", courseList: "开篇词（1讲）")
            let p5 = Product(imageUrl: "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic4.zhimg.com%2Fv2-bdd8e2130bd510ded3d9e22a27934e0a_1200x500.jpg&refer=http%3A%2F%2Fpic4.zhimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1652976937&t=fe6d34925edc624902d583e9aff78246", name: "Java学习", price: 20, desc: "Java学习这里只是用来测试一下", teacher: "布鲁克", total: 50, update: 23, student: 345, detail: "Java学习这里只是用来测试一下哈哈哈Java学习这里只是用来测试一下哈哈Java学习这里只是用来测试一下哈哈", courseList: "开篇词（1讲）")
            let p6 = Product(imageUrl: "https://img2.baidu.com/it/u=854329176,2847093369&fm=253&fmt=auto&app=138&f=JPG?w=800&h=320", name: "Kotlin学习", price: 20, desc: "Kotlin学习这里只是用来测试一下", teacher: "娜美", total: 50, update: 23, student: 345, detail: "Kotlin学习这里只是用来测试一下哈哈哈Kotlin学习这里只是用来测试一下哈哈Kotlin学习这里只是用来测试一下哈哈", courseList: "开篇词（1讲）")
            
            products = [p1, p2, p3, p4, p5, p6]
        }
        return products
    }
    
    static func createDeals() -> [Deal] {
        if deals.count == 0 {
            deals = FakeData.createProducts().map {
                Deal(product: $0, progress: 1)
            }
        }
        return deals
    }
}
