//
//  MGRouterTarget.swift
//  MGSwiftRouter
//
//  Created by msz on 2021/2/25.
//

import Foundation

public protocol MGServiceEntry {
    // The Return Closure Type
    // param: The parameter that can be any value
    typealias RetClosure = (_ param: Any?) -> ()
    // The Path Type
    // path: The Path in the URI
    // paramsDesc: parameter description, Including parameter key and its description information
    typealias PathType = (path: String, paramsDesc: [String: String], returnClosureParamsDesc: Any)
    
    /// router entry
    /// scheme: The scheme in the URI
    /// path: The path in the URI
    /// params: The parameter in the URI
    static func shooting(scheme: String, path: String, params: [String: Any], retClosure: RetClosure?)
    
    /// print help information
    static func help()
    /// Gets The unique identification of the function accessed
    /// return: The unique identity
    static func uri() -> [String]
    /// Gets the scheme in the URI
    /// return: The scheme in the URI
    static func scheme() -> String
    /// Gets the host in the URI
    /// return: The host in the URI
    static func host() -> String
    /// Get the paths and parameters in the URI
    /// return: The path in the URI and its parameter description
    static func path() -> [PathType]
}

extension MGServiceEntry {
    public static var defaultScheme: String {
        return Router.defaultScheme
    }
    
    public static func help() {
        print("========= help description begin ============")
        for path in self.path() {
            print("▷ file: \(#file)")
            print("▷ line: \(#line)")
            print("▷ function: \(#function)")
            print("▷ scheme: \(scheme())")
            print("▷ path: \(path.path)")
            print("▷ params: \(path.paramsDesc)")
            print("> returnClosure's parameter: \(path.returnClosureParamsDesc)")
        }
        print("================= end ======================")
    }
    
    public static func uri() -> [String] {
        var uris: [String] = []
        
        var scheme = self.scheme()
        scheme = scheme.trim()
        scheme = scheme.trim("/")
        
        var host = self.host()
        host = host.trim()
        host = host.trim("/")
        if self.path().count <= 0 {
            let uri = "\(scheme)://\(host)"
            uris.append(uri)
        } else {
            for path in self.path() {
                var path = path.path
                path = path.trim()
                path = path.trim("/")
                path = path.trim("\\")
                
                var uri = "\(scheme)://\(host)"
                if path.count > 0 {
                    uri += "/\(path)"
                }
                
                uris.append(uri)
            }
        }
        
        return uris
    }
    
    public static func scheme() -> String {
        return self.defaultScheme
    }
    
    public static func path() -> [PathType] {
        let path: PathType = ("", [:], "")
        return [path]
    }
    
}
