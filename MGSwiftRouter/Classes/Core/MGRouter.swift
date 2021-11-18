//
//  MGRouter.swift
//  MGSwiftRouter
//
//  Created by msz on 2021/2/25.
//

import Foundation

public let router = Router.shared
public final class Router {
    typealias RouterContainer = [String: [String: MGServiceEntry.Type]]
    typealias ParamsType = [String: String]
    
    internal static let defaultScheme = "mugua"
    private var dicRouter: RouterContainer = [:]
    
    private init() {}
}

extension Router {
    public static let shared = Router()
    
    /// Register the route and its service entry
    /// clsTarget: Type of service entry
    /// return: error-failed, nil-successful
    @discardableResult
    public func register<T: MGServiceEntry>(clsTarget: T.Type) -> MGRouterError? {
        var error: MGRouterError?
        for uri in clsTarget.uri() {
            error = register(uri: uri, clsTarget: clsTarget)
            if error != nil {
                return error
            }
        }
        
        return nil
    }
    
    /// Register the route and its service entry
    /// uri: The unique identity
    /// clsTarget: Type of service entry
    /// return: error-failed, nil-successful
    @discardableResult
    public func register<T: MGServiceEntry>(uri: String, clsTarget: T.Type) -> MGRouterError? {
        guard let uri = URLComponents(string: uri) else {
            return .uriNotSpecified
        }
        
        guard let host = uri.host else {
            return .hostNotSpecified
        }
        
        var scheme = Router.defaultScheme
        if let tmpScheme = uri.scheme, tmpScheme.count > 0 {
            scheme = uri.scheme!
        }
        
        let pattern = self.pattern(host: host, path: uri.path)
        return addRouter(scheme: scheme, pattern: pattern, clsTarget: clsTarget)
    }
    
    /// Calling service through the URI
    /// uri: The unique identity
    /// retClosure: return closure
    /// return: error-failed, nil-successful
    @discardableResult
    public func router(_ uri: String, retClosure: MGServiceEntry.RetClosure? = nil) -> MGRouterError? {
        guard let uri = URLComponents(string: uri) else {
            return .uriNotSpecified
        }
        
        var scheme = Router.defaultScheme
        if let schemeTemp = uri.scheme {
            scheme = schemeTemp
        }
        
        guard let host = uri.host else {
            return .hostNotRecognized
        }

        guard let subRouter = dicRouter[scheme] else {
            return .schemeNotRecognized
        }
        
        let pattern = self.pattern(host: host, path: uri.path)
        guard let clsTarget = subRouter[pattern] else {
            return .serviceEntryNotRecognized
        }
        
        var params: ParamsType = [:]
        if let query = uri.query {
            let items = query.split(separator: "&")
            for item in items {
                let array = item.split(separator: "=")
                if array.count == 2 {
                    let key = String(array[0])
                    let value = String(array[1])
                    params[key] = value
                }
            }
        }
        
        clsTarget.shooting(scheme: scheme, path: uri.path, params: params, retClosure: retClosure)
        return nil
    }
    
}

extension Router {
    /// add a router
    /// paramter scheme: The scheme in the URI
    /// paramter pattern: match string
    /// paramter clsTarget: Type of service entry
    /// return: error-failed, nil-successful
    private func addRouter<T: MGServiceEntry>(scheme: String, pattern: String, clsTarget: T.Type) -> MGRouterError? {
        if var subRouters = dicRouter[scheme] {
            if let _ = subRouters[pattern] {
                return .routerHasExist
            } else {
                subRouters[pattern] = clsTarget
                dicRouter[scheme] = subRouters
            }
        } else {
            let subRouters = [pattern: clsTarget]
            dicRouter[scheme] = subRouters
        }
        
        return nil
    }
    
    /// Gets the pattern
    /// host: The host in the URI
    /// path: The path in the URI
    /// return: The pattern
    private func pattern(host: String, path: String) -> String {
        var pattern = host
        if path.count > 0 {
            pattern += "/\(path)"
        }
        
        return pattern
    }
    
    /// Gets the host and path from uri
    /// uri: The unique identity
    /// return: host (The host in the URI) and path (The path in the URI)
    private func splitPattern(uri: String) -> (host: String, path: String) {
        var ret: (host: String, path: String) = ("", "")
        guard let uri = URLComponents(string: uri) else {
            return ("", "")
        }
        
        if let host = uri.host {
            ret.host = host
        }
        
        ret.path = uri.path
        
        return ret
    }

}
