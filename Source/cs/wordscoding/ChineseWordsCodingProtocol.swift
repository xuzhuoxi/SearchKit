//
//  ChineseWordsCodingProtocol.swift
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
public protocol ChineseWordsCodingProtocol {
    /**
     * 对字符串进行编码<br>
     * 要求实现对象先验证有效性。<br>
     *
     * @param wordCache
     *            中文缓存实例{@link CharacterLibraryProtocol}
     * @param words
     *            词
     * @return 编码数组
     */
    func coding(wordCache: CharacterLibraryProtocol, words: String) ->[String]?
}