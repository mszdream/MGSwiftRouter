//
//  LogModule.swift
//  MGSwiftRouter_Example
//
//  Created by msz on 2021/2/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import MGSwiftRouter

class LogModule {
    func log(string: String?) {
        if let string = string {
            print(string)
        }
    }
}

class LogServiceEntry: MGServiceEntry {
    
    static func shooting(scheme: String, path: String, params: [String : Any], retClosure: RetClosure?) {
        if path == "log" || path == "/log" {
            if let string = params["string"] as? String {
                let logObj = LogModule()
                logObj.log(string: string)
                
                if let closure = retClosure {
                    closure("The log method was successfully called")
                }
            }
        }
    }
    
    static func scheme() -> String {
        return "test"
    }
    
    static func host() -> String {
        return "log"
    }
    
    static func path() -> [PathType] {
        let log: PathType = ("", ["string": "String to print"], "Returns a string")
        return [log]
    }
    
}
