//
//  ValueCodingStrategyFactory.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/16.
//
//

import Foundation

public class ValueCodingStrategyFactory {
    private init(){}
    
    private static var map : Dictionary<ValueCodingType,ValueCodingStrategyProtocol> = Dictionary<ValueCodingType,ValueCodingStrategyProtocol>()
    
    public static func getValueCodingStrategy(type:ValueCodingType) ->ValueCodingStrategyProtocol{
        if let _ = map.indexForKey(type) {
            return map[type]!
        }else{
            let rs = createValueCodingStrategy(type)
            map.updateValue(rs, forKey: type)
            return rs
        }
    }
    
    public static func createValueCodingStrategy(type:ValueCodingType) ->ValueCodingStrategyProtocol{
        switch type {
        case .PINYIN_WORD:
            return PinyinWordStrategyImpl()
        case .PINYIN_WORDS:
            return PinyinWordsStrategyImpl()
        case .WUBI_WORD:
            return WubiWordStrategyImpl()
        case .WUBI_WORDS:
            return WubiWordsStrategyImpl();
        }
    }
}