//
//  TestViewController.swift
//  MGSwiftRouter_Example
//
//  Created by hello on 2021/11/18.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import MGSwiftRouter

class TestViewController: UIViewController {
    var retClosure: MGServiceEntry.RetClosure?
    
    @objc var userId: String?
    @objc var username: String?
    @objc var password: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        let v = UIView(frame: UIScreen.main.bounds)
        v.backgroundColor = UIColor.green

        if let userId = self.mg_router_parameters?["userId"] as? String {
            let userIdLabel = UILabel(frame: CGRect(x: 80, y: 100, width: 200, height: 20))
            userIdLabel.text = "UserID: \(userId)"
            v.addSubview(userIdLabel)
        }

        if let username = self.mg_router_parameters?["username"] as? String {
            let usernameLabel = UILabel(frame: CGRect(x: 80, y: 120, width: 200, height: 20))
            usernameLabel.text = "Username: \(username)"
            v.addSubview(usernameLabel)
        }

        if let password = self.mg_router_parameters?["password"] as? String {
            let passwordLabel = UILabel(frame: CGRect(x: 80, y: 140, width: 200, height: 20))
            passwordLabel.text = "Password: \(password)"
            v.addSubview(passwordLabel)
        }
        
        print(mg_router_parameters ?? [:])

        self.view.addSubview(v)
        
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: 200, width: 100, height: 32)
        button.setTitle("Page closed", for: .normal)
        button.addTarget(self, action: #selector(closeBtnClicked(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func closeBtnClicked(sender: AnyObject) {
        close_with_parameters(parameters: "closed successful")
    }
    
    deinit {
        if let closure = self.retClosure {
            closure("The data returned from user page")
        }
    }
    
}

