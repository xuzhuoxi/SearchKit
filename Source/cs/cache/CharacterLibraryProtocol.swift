//
//  CharacterLibraryProtocol.swift
//  SearchKit
//
//  Created by 许灼溪 on 16/1/6.
//
//

import Foundation

/**
 *
 * @author xuzhuoxi
 *
 */
public protocol CharacterLibraryProtocol: CacheProtocol {
    /**
     * 是否为字库中包含的字符<br>
     * @param char 字符实例
     * @return 是true否false
     */
    func isKey(char: Character) -> Bool
    /**
     * 是否为字库中包含的字符<br>
     * @param uScalar Unicode值
     * @return 是true否false
     */
    func isKey(uScalar: UnicodeScalar) -> Bool
    
    /**
     * 取字符在字库中的编码<br>
     * @param char 字符实例
     * @return 
     *  没包含:nil
     *  包含:编码数组
     */
    func getValues(char: Character) ->[String]?
    /**
     * 取字符在字库中的编码<br>
     * @param uScalar Unicode值
     * @return
     *  没包含:nil
     *  包含:编码数组
     */
    func getValues(uScalar: UnicodeScalar) ->[String]?
}