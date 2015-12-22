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
    
    private static var map : Dictionary<ValueCodingTypes,ValueCodingStrategyProtocol> = Dictionary<ValueCodingTypes,ValueCodingStrategyProtocol>()
    
    public static func getValueCodingStrategy(type:ValueCodingTypes) ->ValueCodingStrategyProtocol{
        if let _ = map.indexForKey(type) {
            return map[type]!
        }else{
            let rs = createValueCodingStrategy(type)
            map.updateValue(rs, forKey: type)
            return rs
        }
    }
    
    public static func createValueCodingStrategy(type:ValueCodingTypes) ->ValueCodingStrategyProtocol{
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