//
//  ChineseWordsCoding.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/22.
//
//

import Foundation

/**
 *
 * @author xuzhuoxi
 *
 */
class ChineseWordsCoding {
    init(){}
    
    static func generateCodingImpl(_ wordsCodingType: ChineseWordsCodingTypes) ->ChineseWordsCodingProtocol {
        switch (wordsCodingType) {
        case ChineseWordsCodingTypes.pinyin:
            return PinyinCodingImpl()
        case ChineseWordsCodingTypes.wubi:
            return WubiCodingImpl()
        }
    }
    
    /**
     * 检查输入是否可能进行编码，要求：<br>
     * 1.输入中字符必须为中文字符范围。<br>
     * 2.输入中字符必须在wordCache中有编码信息。<br>
     *
     * @param wordCache
     *            中文缓存实例{@link CharacterLibraryProtocol}
     * @param words
     *            词
     * @return 输入中有一个字符不符合则返回false
     */
    final func canCoding(_ wordCache: CharacterLibraryProtocol, _ words:String) ->Bool {
        for word in words.characters {
            if ChineseUtils.isChinese(word) && !wordCache.isKey(word) {
                return false
            }
        }
        return true
    }
}
