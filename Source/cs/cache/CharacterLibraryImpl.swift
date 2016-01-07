//
//  CharacterLibraryImpl.swift
//  SearchKit
//
//  Created by 许灼溪 on 16/1/6.
//
//

import Foundation

class CharacterLibraryImpl: CharacterLibraryProtocol, CacheInitProtocol, ReflectionProtocol {
    
    private(set) var _cacheName: String!
    private var codeInfo: [[String]] = [[String]](count: ChineseUtils.chineseSize, repeatedValue: [])
    
    var cacheName: String {
        return _cacheName
    }
    
    var keysSize: Int {
        var size: Int = 0
        codeInfo.each { (arr: [String]) -> () in
            if !arr.isEmpty {
                ++size
            }
        }
        return size
    }
    
    final func isKey(key: String) -> Bool {
        if key.length == 1 {
            if let index = getIndex(key.characters.first!) {
                return !codeInfo[index].isEmpty
            }
        }
        return false
    }
    
    final func isKey(char: Character) -> Bool {
        if let index = getIndex(char) {
            return !codeInfo[index].isEmpty
        }
        return false
    }
    
    final func isKey(uScalar: UnicodeScalar) -> Bool {
        if let index = getIndex(uScalar) {
            return !codeInfo[index].isEmpty
        }
        return false
    }
    
    final func getValues(key: Character) -> [String]? {
        if let index = getIndex(key) {
            if codeInfo[index].isEmpty {
                return nil
            }else{
                return codeInfo[index]
            }
        }else{
            return nil
        }
    }
    
    final func getValues(uScalar: UnicodeScalar) -> [String]? {
        if let index = getIndex(uScalar) {
            if codeInfo[index].isEmpty {
                return nil
            }else{
                return codeInfo[index]
            }
        }else{
            return nil
        }
    }
    
    final func initCache(cacheName: String, _ valueCodingInstance: ValueCodingStrategyProtocol?, _ initialCapacity: UInt) {
        self._cacheName = cacheName
    }
    
    final func supplyResource(url: NSURL) {
        if let resource = Resource.getResource(url.path!) {
            supplyResource(resource)
        }
    }
    
    final func supplyResource(resource: Resource) {
        for i in 0 ..< resource.size {
            tryCacheKeyValue(resource.getKey(i), resource.getValue(i))
        }
    }
    
    final func supplyData(data: String) {
        if let resource = Resource.getResourceByData(data) {
            supplyResource(resource)
        }
    }
    
    final func supplyData(key: String, value: String) {
        tryCacheKeyValue(key, value)
    }
    
    private func getIndex(char: Character) ->Int? {
        if ChineseUtils.isChinese(char) {
            for u in String(char).unicodeScalars {
                return Int(u.value - ChineseUtils.chineseStartUnicode)
            }
        }
        return nil
    }
    
    private func getIndex(uScalar: UnicodeScalar) ->Int? {
        if ChineseUtils.inChineseUnicodeArea(uScalar.value) {
            return Int(uScalar.value - ChineseUtils.chineseStartUnicode)
        }else{
            return nil
        }
    }
    
    final func tryCacheKeyValue(resourceKey: String, _ resourceValue: String) -> Bool {
        if resourceKey.isEmpty || resourceValue.isEmpty {
            return false
        }
        let char = resourceKey.characters.first!
        if !ChineseUtils.isChinese(char) {
            return false
        }
        let values = resourceValue.componentsSeparatedByString("#")
        var codeArr: [String] = []
        for value in values {
            let tValue = value.trimmed()
            if !tValue.isEmpty {
                codeArr.append(tValue)
            }
        }
        if !codeArr.isEmpty {
            let index = getIndex(char)!
            codeInfo[index] = codeArr
        }
        return true
    }
    
    static func newInstance() -> ReflectionProtocol {
        return CharacterLibraryImpl()
    }
}