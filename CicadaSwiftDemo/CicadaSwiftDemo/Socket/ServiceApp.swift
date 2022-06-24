//
//  ServiceApp.swift
//  CicadaSwiftDemo
//
//  Created by 知了 on 2022/6/20.
//

import Foundation
import CocoaAsyncSocket

class ServiceApp : NSObject {
    var serviceSocket: GCDAsyncSocket!
    
    override init() {
        super.init()
        serviceSocket = GCDAsyncSocket(delegate: self, delegateQueue: .global())
        
    }
    
    func openService() {
        do {
            try serviceSocket.accept(onPort: 14201)
        } catch {
            print("端口开启失败:\(error)")
        }
    }
}

extension ServiceApp : GCDAsyncSocketDelegate {
    func socket(_ sock: GCDAsyncSocket, didAcceptNewSocket newSocket: GCDAsyncSocket) {
        //客户端请求连接
        print("\(newSocket) IP:\(String(describing: newSocket.connectedHost)):\(newSocket.connectedPort) 客户端请求连接...")
        newSocket.readData(withTimeout: -1, tag: 0)
    }
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        print("did read" + (String(data: data, encoding: .utf8) ?? ""))
        sock.readData(withTimeout: -1, tag: 0)
    }
    
    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
        //数据发送成功
        print("数据发送成功")
    }
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) {
        print("did disconnect")
    }
}


