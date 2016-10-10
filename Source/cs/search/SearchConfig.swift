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
    fileprivate(set) public var searchTypeInfos: [SearchTypeInfo]
    
    public init() {
        self.searchTypeInfos = []
    }
    
    public init(_ searchTypeInfos: [SearchTypeInfo]) {
        self.searchTypeInfos = searchTypeInfos
    }
    
    mutating public func addSearchType(_ searchTypeInfo: SearchTypeInfo){
        guard let _ = getIndex(searchTypeInfo) else {
            searchTypeInfos.append(searchTypeInfo)
            return
        }
    }
    
    mutating public func removeSearchType(_ searchType: SearchType){
        if let index = getIndex(searchType) {
            searchTypeInfos.remove(at: index)
        }
    }
    
    mutating public func removeSearchType(_ searchTypeInfo: SearchTypeInfo){
        if let index = getIndex(searchTypeInfo) {
            searchTypeInfos.remove(at: index)
        }
    }
    
    mutating public func removeAll() {
        searchTypeInfos.removeAll()
    }
    
    fileprivate func getIndex(_ searchTypeInfo: SearchTypeInfo) ->Int? {
        return searchTypeInfos.index(of: searchTypeInfo)
    }
    
    fileprivate func getIndex(_ searchType: SearchType) ->Int? {
        for (index, ele) in searchTypeInfos.enumerated() {
            if ele.searchType == searchType {
                return index
            }
        }
        return nil
    }
}
