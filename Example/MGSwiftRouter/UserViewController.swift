//
//  UserViewController.swift
//  MGSwiftRouter_Example
//
//  Created by msz on 2021/2/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import MGSwiftRouter

class UserViewController: UIViewController {
    var retClosure: MGServiceEntry.RetClosure?
    
    @objc var userId: String?
    @objc var username: String?
    @objc var password: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        let v = UIView(frame: UIScreen.main.bounds)
        v.backgroundColor = UIColor.green

        if let userId = self.userId {
            let userIdLabel = UILabel(frame: CGRect(x: 80, y: 100, width: 200, height: 20))
            userIdLabel.text = "UserID: \(userId)"
            v.addSubview(userIdLabel)
        }

        if let username = self.username {
            let usernameLabel = UILabel(frame: CGRect(x: 80, y: 120, width: 200, height: 20))
            usernameLabel.text = "Username: \(username)"
            v.addSubview(usernameLabel)
        }

        if let password = self.password {
            let passwordLabel = UILabel(frame: CGRect(x: 80, y: 140, width: 200, height: 20))
            passwordLabel.text = "Password: \(password)"
            v.addSubview(passwordLabel)
        }

        self.view.addSubview(v)
        
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: 200, width: 100, height: 32)
        button.setTitle("Page closed", for: .normal)
        button.addTarget(self, action: #selector(closeBtnClicked(sender:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func closeBtnClicked(sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        if let closure = self.retClosure {
            closure("The data returned from user page")
        }
    }
    
}

class UserServiceEntry: MGServiceEntry {
    static func shooting(scheme: String, path: String, params: [String : Any], retClosure: RetClosure?) {
        let vc = UserViewController()
        vc.userId = params["userId"] as? String
        vc.username = params["username"] as? String
        vc.password = params["password"] as? String
        vc.retClosure = retClosure
        guard let parentVc = CommonTools.topViewController() else {
            return
        }
        
        parentVc.navigationController?.pushViewController(vc, animated: true)
    }
    
    public static func scheme() -> String {
        return "test"
    }
    
    static func host() -> String {
        return "user"
    }
    
    static func path() -> [PathType] {
        let path: PathType = ("", ["userId": "user Id", "username": "user name", "password": "user password"], "returns a string")
        return [path]
    }
    
}
