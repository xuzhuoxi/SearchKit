//
//  ExString.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/21.
//
//

import Foundation

extension String {
    /**
     * 分裂字符串
     *
     * @return 以全部字符对应字符串组成的数组
     */
    public func explode() -> [String] {
        var rs:[String] = []
        for str in self.characters {
            rs.append(String(str))
        }
        return rs
    }
}