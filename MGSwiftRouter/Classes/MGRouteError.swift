//
//  MGRouteError.swift
//  MGSwiftRouter
//
//  Created by msz on 2021/2/25.
//

import Foundation

public enum MGRouterError {
    case uriNotSpecified
    case hostNotSpecified
    case routerHasExist
    
    case schemeNotRecognized
    case hostNotRecognized
    case serviceEntryNotRecognized
    
    case unknown
}

extension MGRouterError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .uriNotSpecified:
            return "No uri specified"
        case .hostNotSpecified:
            return "No host specified"
        case .routerHasExist:
            return "Router already exists"
            
        case .schemeNotRecognized:
            return "There is no matching scheme"
        case .hostNotRecognized:
            return "There is no matching host"
        case .serviceEntryNotRecognized:
            return "There is no matching service entry"
            
        default:
            return "unknown"
        }
    }
    
    
}
