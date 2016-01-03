//
//  ValueCodingType.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/16.
//
//

import Foundation

/**
 *
 * 值处理类型
 * @author xuzhuoxi
 *
 */
public enum ValueCodingType {
    case PINYIN_WORD, PINYIN_WORDS, WUBI_WORD, WUBI_WORDS
}

extension ValueCodingType {
    public static func values() ->[ValueCodingType] {
        return [PINYIN_WORD, PINYIN_WORDS, WUBI_WORD, WUBI_WORDS]
    }
    
    public var associatedClassName : String {
        switch self {
        case .PINYIN_WORD:
            return "ChineseSearch.PinyinWordStrategyImpl"
        case .PINYIN_WORDS:
            return "ChineseSearch.PinyinWordsStrategyImpl"
        case .WUBI_WORD:
            return "ChineseSearch.WubiWordStrategyImpl"
        case .WUBI_WORDS:
            return "ChineseSearch.WubiWordsStrategyImpl"
        }
    }
}