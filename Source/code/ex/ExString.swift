//
//  ExString.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/21.
//
//

import Foundation

extension String {
    public func explode() -> [String] {
        var rs:[String] = []
        for str in self.characters {
            rs.append(String(str))
        }
        return rs
    }
}