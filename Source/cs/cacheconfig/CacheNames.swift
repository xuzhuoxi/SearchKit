//
//  CacheNames.swift
//  ChineseSearch
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
public class CacheNames {
    private init(){}
    
    /**
    * 拼音 字库
    */
    public static let PINYIN_WORD = "WORD:PINYIN";
    /**
    * 五笔 字库
    */
    public static let WUBI_WORD = "WORD:WUBI";
    
    /**
    * 拼音 词库
    */
    public static let PINYIN_WORDS = "WORDS:PINYIN";
    
    /**
    * 五笔 词库
    */
    public static let WUBI_WORDS = "WORDS:WUBI";
    
    /**
    * 权重(权值)
    */
    public static let WEIGHT = "WORDS:WEIGHT";
    
}
