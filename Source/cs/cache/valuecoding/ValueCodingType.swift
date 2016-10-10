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
    case pinyin_WORD, pinyin_WORDS, wubi_WORD, wubi_WORDS
}

extension ValueCodingType {
    public static func values() ->[ValueCodingType] {
        return [pinyin_WORD, pinyin_WORDS, wubi_WORD, wubi_WORDS]
    }
    
    public var associatedClassName : String {
        switch self {
        case .pinyin_WORD:
            return "SearchKit.PinyinWordStrategyImpl"
        case .pinyin_WORDS:
            return "SearchKit.PinyinWordsStrategyImpl"
        case .wubi_WORD:
            return "SearchKit.WubiWordStrategyImpl"
        case .wubi_WORDS:
            return "SearchKit.WubiWordsStrategyImpl"
        }
    }
}
