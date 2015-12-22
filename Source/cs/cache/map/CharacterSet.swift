//
//  CharacterSet.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/7.
//
//

/**
 * 字符表定义，用于FixedDimensionMapImpl类
 *
 * @author xuzhuoxi
 *
 */
public class CharacterSet {
    private init(){}
    
    /**
    * 拼音用到的字符
    */
    public static let LETTER_CHARSET = [Character](arrayLiteral: "a", "b", "c", "d", "e", "f", "g", "h", "i", "j",
        "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" )
    /**
    * 五笔用到的字符
    */
    public static let WUBI_LETTER_CHARSET = [Character] (arrayLiteral: "a", "b", "c", "d", "e", "f", "g", "h", "i",
    "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y" )
    /**
    * 数字用到的字符
    */
    public static let NUMBER_CHARSET = [Character] (arrayLiteral: "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" )
}
