//
//  ValueCodingStrategyFactory.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/16.
//
//

import Foundation

public struct ValueCodingStrategyFactory {
    fileprivate init(){}
    
    fileprivate static var map = Dictionary<ValueCodingType, ValueCodingStrategyProtocol>()
    
    public static func getValueCodingStrategy(_ type:ValueCodingType) ->ValueCodingStrategyProtocol{
        if let _ = map.index(forKey: type) {
            return map[type]!
        }else{
            let rs = createValueCodingStrategy(type)
            map.updateValue(rs, forKey: type)
            return rs
        }
    }
    
    public static func createValueCodingStrategy(_ type:ValueCodingType) ->ValueCodingStrategyProtocol{
        switch type {
        case .pinyin_WORD:
            return PinyinWordStrategyImpl()
        case .pinyin_WORDS:
            return PinyinWordsStrategyImpl()
        case .wubi_WORD:
            return WubiWordStrategyImpl()
        case .wubi_WORDS:
            return WubiWordsStrategyImpl()
        }
    }
}
