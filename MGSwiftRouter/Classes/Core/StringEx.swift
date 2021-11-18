//
//  StringEx.swift
//  MGSwiftRouter
//
//  Created by msz on 2021/2/26.
//

import Foundation

extension String {
    // 删除字符串两端空格
    public func trim() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    // 删除字符串两端指定字符串
    public func trim(_ characters: String) -> String {
        let characterSet = CharacterSet(charactersIn: characters)
        let str2 = self.trimmingCharacters(in: characterSet)
        return str2
    }
    
}
