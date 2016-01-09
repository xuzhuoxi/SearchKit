//
//  ExString.swift
//  SearchKit
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
    
    /**
     * 去除空字符串
     * 空字符串: 小于“ ”的字符
     * @return 字符串
     */
    public func trim() ->String {
        let ws: Character = " "
        let chars = self.characters
        var len = chars.endIndex
        var st = chars.startIndex
        while st < len && chars[st] <= ws {
            st = st.advancedBy(1)
        }
        while st < len && chars[len.advancedBy(-1)] <= ws {
            len = len.advancedBy(-1)
        }
        return (st > chars.startIndex || len < chars.endIndex) ? self[st..<len] : self
    }
    
    public func trimLeft() ->String {
        let ws: Character = " "
        let chars = self.characters
        let len = chars.endIndex
        var st = chars.startIndex
        while st < len && chars[st] <= ws {
            st = st.advancedBy(1)
        }
        return (st > chars.startIndex || len < chars.endIndex) ? self[st..<len] : self
    }
    
    public func trimRight() ->String {
        let ws: Character = " "
        let chars = self.characters
        var len = chars.endIndex
        let st = chars.startIndex
        while st < len && chars[len.advancedBy(-1)] <= ws {
            len = len.advancedBy(-1)
        }
        return (st > chars.startIndex || len < chars.endIndex) ? self[st..<len] : self

    }
}