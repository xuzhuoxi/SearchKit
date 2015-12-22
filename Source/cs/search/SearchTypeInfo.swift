//
//  SearchTypeInfo.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/21.
//
//

import Foundation

/**
 * 检索类别信息
 *
 * @author xuzhuoxi
 *
 */
public class SearchTypeInfo {
    /**
     * 检索类型
     */
    private var searchType:SearchTypes
    /**
     * 检索使用的Cache名称
     */
    private var cacheName:String
    /**
     * 输入处理类型
     */
    private var valueType:ValueCodingTypes
    
    public init (_ searchType:SearchTypes, _ cacheName:String, _ valueType:ValueCodingTypes){
        self.searchType=searchType;
        self.cacheName=cacheName;
        self.valueType=valueType;
    }
    
    /**
     * @return 检索类型
     */
    public final func getSearchType() ->SearchTypes {
        return searchType
    }
    
    /**
     * @return 检索使用的Cache名称
     */
    public final func getCacheName() ->String {
        return cacheName
    }
    
    /**
     * @return 输入处理类型
     */
    public final func getValueType() ->ValueCodingTypes {
        return valueType
    }
}
