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
    func isKey(char: Character) -> Bool
    func isKey(uScalar: UnicodeScalar) -> Bool
    
    func getValues(char: Character) ->[String]?
    func getValues(uScalar: UnicodeScalar) ->[String]?
}