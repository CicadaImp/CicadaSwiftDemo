//
//  LoginViewController.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/4/17.
//  我是01修改。。。

import UIKit

protocol ValidatePhoneNumber {
    func validatePhoneNumber(_ phoneNum: String) -> Bool
}

protocol ValidatePassword {
    func validatePassword(_ password: String) -> Bool
}

extension ValidatePhoneNumber {
    func validatePhoneNumber(_ phoneNum: String) -> Bool {
        if phoneNum.count != 11 {
            return false
        }
        return true
    }

}

extension ValidatePassword {
    func validatePassword(_ password: String) -> Bool {
        if password.count < 6 || password.count > 12 {
            return false
        }
        return true
    }
}

class LoginViewController: BaseViewController, ValidatePassword, ValidatePhoneNumber {

    var phoneTextField: UITextField!
    var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginView = UIImageView(image: R.image.icon_logo())
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        let phoneIconView = UIImageView(image: R.image.icon_phone())
        phoneTextField = UITextField()
        phoneTextField.leftView = phoneIconView
        phoneTextField.leftViewMode = .always
        phoneTextField.textColor = UIColor.hexColor(0x333333)
        phoneTextField.layer.borderColor = UIColor.hexColor(0x333333).cgColor
        phoneTextField.layer.borderWidth = 1
        phoneTextField.layer.cornerRadius = 5
        phoneTextField.layer.masksToBounds = true
        phoneTextField.placeholder = "请输入手机号"
        view.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(loginView.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        let pwdIconView = UIImageView(image: R.image.icon_pwd())
        passwordTextField = UITextField()
        passwordTextField.leftView = pwdIconView
        passwordTextField.leftViewMode = .always
        passwordTextField.textColor = UIColor.hexColor(0x333333)
        passwordTextField.layer.borderColor = UIColor.hexColor(0x333333).cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.layer.masksToBounds = true
        passwordTextField.placeholder = "请输入密码"
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(phoneTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        let loginButton = UIButton(type: .custom)
        loginButton.setTitle("登录", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        //高亮效果
        loginButton.setBackgroundImage(UIColor.hexColor(0xf8892e).toImage(), for: .normal)
        loginButton.layer.cornerRadius = 5
        loginButton.layer.masksToBounds = true
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        loginButton.addTarget(self, action: #selector(didClickLoginButton), for: .touchUpInside)
        
    }
    
    @objc func didClickLoginButton() {
        if validatePhoneNumber(phoneTextField.text ?? "") && validatePassword(passwordTextField.text ?? "") {
            
        } else {
            showToast()
        }
    }
    
    func showToast() {
        let alertVC = UIAlertController(title: "提示", message: "用户名或密码错误", preferredStyle: .alert)
        present(alertVC, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alertVC.dismiss(animated: true, completion: nil)
        }
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
