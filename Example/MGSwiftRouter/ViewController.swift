//
//  ViewController.swift
//  MGSwiftRouter
//
//  Created by msz on 02/25/2021.
//  Copyright (c) 2021 hello. All rights reserved.
//

import UIKit
import MGSwiftRouter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let btnUser = UIButton(type: .system)
        btnUser.frame = CGRect(x: 10, y: 100, width: 150, height: 32)
        btnUser.setTitle("Open user page", for: .normal)
        btnUser.addTarget(self, action: #selector(userButtonClicked(sender:)), for: .touchUpInside)
        self.view.addSubview(btnUser)
        
        let btnLog = UIButton(type: .system)
        btnLog.frame = CGRect(x: 170, y: 100, width: 100, height: 32)
        btnLog.setTitle("Method call", for: .normal)
        btnLog.addTarget(self, action: #selector(methodButtonClicked(sender:)), for: .touchUpInside)
        self.view.addSubview(btnLog)
    }

    @objc func userButtonClicked(sender: AnyObject) {
        // Calling service through the URI
        router.router("test://user?userId=1&username=zhangsan&password=123456") { (params) in
            guard let params = params as? String else {
                return
            }
            
            print(params)
        }
    }

    @objc func methodButtonClicked(sender: AnyObject) {
        // Calling service through the URI
//        router.router("test://log/log?string=hellobaby")    // Do not receive return value
        router.router("test://log/log?string=hellobaby") { (params) in
            guard let params = params as? String else {
                return
            }
            
            print(params)
        }
    }
    
}

