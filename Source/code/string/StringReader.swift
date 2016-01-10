//
//  StringReader.swift
//  SearchKit
//
//  Created by 许灼溪 on 16/1/9.
//
//

import Foundation

//性能不行
public struct StringReader {
    private let cb: String.CharacterView
    private var nextChar: String.CharacterView.Index!
    
    public init(data: String) {
        self.cb = data.characters
        self.nextChar = cb.startIndex
    }
    
    mutating public func reset() {
        self.nextChar = cb.startIndex
    }
    
    mutating public func read() ->Character? {
        let next = nextChar.advancedBy(1)
        if next < cb.endIndex {
            let rs = cb[next]
            nextChar = next
            return rs
        }else{
            return nil
        }
    }
    
    mutating public func read(off: Int, len: Int) ->String.CharacterView? {
        let st = nextChar.advancedBy(off)
        let et = st.advancedBy(len)
        if st < et && st >= cb.startIndex {
            let ei = et < cb.endIndex ? et : cb.endIndex
            nextChar = ei
            return cb[st..<ei]
        }else{
            return nil
        }
    }
    
    mutating public func readLine() ->String? {
        if nextChar == cb.endIndex {
            return nil
        }
        let lineEnd0: Character = "\n"
        let lineEnd1: Character = "\r"
        var index = nextChar
        for ; index < cb.endIndex; index = index.advancedBy(1) {
            let char = cb[index]
            if char == lineEnd0 || char == lineEnd1 {
                let rs = String(cb[nextChar..<index])
                nextChar = index.advancedBy(1)
                return rs
            }
        }
        return nil
    }
}