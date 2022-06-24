//
//  SocketUseViewController.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/6/20.
//

import UIKit
import CocoaAsyncSocket

class SocketUseViewController: BaseViewController {

    var tcpClientSocket: GCDAsyncSocket?
    var clientButton: UIButton!
    var clientTF: UITextField!
    var serverTF: UITextField!
    
    //lazy timer
    lazy var timer: DispatchSourceTimer = {
        let timer = DispatchSource.makeTimerSource(flags: [], queue: .global())
        timer.schedule(deadline: .now(), repeating: 5.0)
        timer.setEventHandler {
            [weak self] in
            self?.heartBeat()
        }
        return timer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        var person = CicadaData()
        person.name = "husky"
        person.age = 7
        person.gender = "1"
        print("person:\(person)")
        
        let binaryData = try! person.serializedData()
        let decodedInfo = try! CicadaData(serializedData: binaryData)
        
        let jsonData = try! person.jsonUTF8Data()
        let receivedFromJson = try! CicadaData(jsonUTF8Data: jsonData)
        
        print("binaryData:\(binaryData)")
        print("decodedInfo:\(decodedInfo)")
        print("jsonData:\(jsonData)")
        print("receivedFromJson:\(receivedFromJson)")
        
        
        let person2 = CicadaData.with {
            $0.name = "elf"
            $0.age = 8
            $0.gender = "0"
        }
        print("person2:\(person2)")
        */
        
        setupViews()
        setupSocket()
    }
    
    func setupViews() {
        
        let clientMessageLabel = UILabel(frame: CGRect(x: 20, y: 20, width: 300, height: 20))
        clientMessageLabel.text = "Client message:"
        clientMessageLabel.textColor = .orange
        clientMessageLabel.font = .systemFont(ofSize: 18)
        view.addSubview(clientMessageLabel)
        
        clientTF = UITextField(frame: CGRect(x: 20, y: 50, width: 300, height: 80))
        clientTF.borderStyle = .roundedRect
        clientTF.layer.borderColor = UIColor.orange.cgColor
        clientTF.layer.borderWidth = 0.5
        clientTF.placeholder = "Input message..."
        view.addSubview(clientTF)
        
        clientButton = UIButton(type: .custom)
        clientButton.frame = CGRect(x: 20, y: 170, width: 300, height: 50)
        clientButton.setTitle("Client Send", for: .normal)
        clientButton.backgroundColor = .orange
        view.addSubview(clientButton)
        clientButton.addTarget(self, action: #selector(clickClientEvent), for: .touchUpInside)
        
        let serverMessageLabel = UILabel(frame: CGRect(x: 20, y: 300, width: 300, height: 20))
        serverMessageLabel.text = "Server message:"
        serverMessageLabel.textColor = .orange
        serverMessageLabel.font = .systemFont(ofSize: 18)
        view.addSubview(serverMessageLabel)
        
        serverTF = UITextField(frame: CGRect(x: 20, y: 330, width: 300, height: 200))
        serverTF.borderStyle = .roundedRect
        serverTF.layer.borderColor = UIColor.orange.cgColor
        serverTF.layer.borderWidth = 0.5
        serverTF.placeholder = "Receive server message..."
        view.addSubview(serverTF)
            
    }
    
    //发送消息
    @objc func clickClientEvent() {
        print("Client Send...")
        view.endEditing(true)
        let content = clientTF!.text! + "\n"
        let data = content.data(using: .utf8)
        tcpClientSocket?.write(data, withTimeout: -1, tag: 0)
    }
    
    //创建socket，连接socket
    func setupSocket() {
        tcpClientSocket = GCDAsyncSocket(delegate: self, delegateQueue: .global())
        do {
            try tcpClientSocket?.connect(toHost: "39n6k76438.qicp.vip", onPort: 14201, withTimeout: -1)
        } catch {
            print("connectHost:\(error)")
        }
        
    }
    
    @objc func heartBeat() {
        let content = "heartBeat"
        let data = content.data(using: .utf8)
        tcpClientSocket?.write(data, withTimeout: -1, tag: 0)
        print("发送心跳：\(content)")
    }
   
    

}

extension SocketUseViewController: GCDAsyncSocketDelegate {
    
    //TCP连接成功建立，配置SSL
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        //配置TLS/SSL设置信息
//        var settings = [String : NSObject]()
//        //允许自签名证书手动验证
//        settings[GCDAsyncSocketManuallyEvaluateTrust] = 1 as NSObject
//        //设置服务器IP地址
//        settings[GCDAsyncSocketSSLPeerID] = String("") as NSObject
//        sock.startTLS(settings)
        
        //启动定时器，发送心跳
        self.timer.resume()
        sock.readData(withTimeout: -1, tag: 0)
        print("didConnectToHost")
    }
    
    //发送成功
    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
        print("didWriteData")
    }
    
    //收到数据
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        print("data:\(data)")
        let message = String(data: data, encoding: .utf8)
        DispatchQueue.main.async {
            [weak self] in
            self?.serverTF.text = message
        }
        print("didRead:\(message ?? "-*_*-")")
        tcpClientSocket?.readData(withTimeout: -1, tag: 0)
    }
    
    //断开连接
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        tcpClientSocket = nil
        tcpClientSocket?.delegate = nil
        DispatchQueue.main.async {
            print("socketDidDisconnect:\(String(describing: err))")
            //弹框等处理
        }
    }
    
}

//交互处理
extension SocketUseViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
