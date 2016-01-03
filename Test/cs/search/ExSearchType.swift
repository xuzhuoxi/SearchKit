//
//  ExSearchType.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 16/1/3.
//
//

import Foundation
@testable import ChineseSearch

extension SearchType {
    /**
     * 拼音，词库
     */
    public static let PINYIN_WORDS = SearchType(3)
    /**
     * 五笔，词库
     */
    public static let WUBI_WORDS = SearchType(4)
}