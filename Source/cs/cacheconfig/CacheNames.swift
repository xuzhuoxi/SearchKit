//
//  CacheNames.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/18.
//
//

import Foundation

/**
 * 各种Cache的定义
 *
 * @author xuzhuoxi
 *
 */
public struct CacheNames {
    fileprivate init(){}
    
    /**
     * 拼音 字库 内存占用:43.2M(ChineseCacheImpl) 14.4(CharacterLibraryImpl)
     */
    public static let PINYIN_WORD = "WORD:PINYIN"
    /**
     * 五笔 字库 内存占用:23M(ChineseCacheImpl) 9.4M(CharacterLibraryImpl)
     */
    public static let WUBI_WORD = "WORD:WUBI"
}
