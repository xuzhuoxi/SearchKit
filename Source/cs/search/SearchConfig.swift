//
//  SearchConfig.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/21.
//
//

import Foundation

/**
 * 检索类别信息配置
 *
 * @author xuzhuoxi
 *
 */
public struct SearchConfig {
    private(set) public var searchTypeInfos: [SearchTypeInfo]
    
    public init() {
        self.searchTypeInfos = []
    }
    
    public init(_ searchTypeInfos: [SearchTypeInfo]) {
        self.searchTypeInfos = searchTypeInfos
    }
    
    mutating public func addSearchType(searchTypeInfo: SearchTypeInfo){
        guard let _ = getIndex(searchTypeInfo) else {
            searchTypeInfos.append(searchTypeInfo)
            return
        }
    }
    
    mutating public func removeSearchType(searchType: SearchType){
        if let index = getIndex(searchType) {
            searchTypeInfos.removeAtIndex(index)
        }
    }
    
    mutating public func removeSearchType(searchTypeInfo: SearchTypeInfo){
        if let index = getIndex(searchTypeInfo) {
            searchTypeInfos.removeAtIndex(index)
        }
    }
    
    mutating public func removeAll() {
        searchTypeInfos.removeAll()
    }
    
    private func getIndex(searchTypeInfo: SearchTypeInfo) ->Int? {
        return searchTypeInfos.indexOf(searchTypeInfo)
    }
    
    private func getIndex(searchType: SearchType) ->Int? {
        for (index, ele) in searchTypeInfos.enumerate() {
            if ele.searchType == searchType {
                return index
            }
        }
        return nil
    }
}
