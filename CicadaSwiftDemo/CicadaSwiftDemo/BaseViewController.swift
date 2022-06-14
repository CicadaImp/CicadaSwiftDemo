//
//  BaseViewController.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/4/17.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(0xf2f4f7)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(0x333333)]
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
