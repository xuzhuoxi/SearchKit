//
//  ValueCodingType.swift
//  SearchKit
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
            return "SearchKit.PinyinWordStrategyImpl"
        case .PINYIN_WORDS:
            return "SearchKit.PinyinWordsStrategyImpl"
        case .WUBI_WORD:
            return "SearchKit.WubiWordStrategyImpl"
        case .WUBI_WORDS:
            return "SearchKit.WubiWordsStrategyImpl"
        }
    }
}