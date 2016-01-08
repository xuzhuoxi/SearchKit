//
//  ExSearchType.swift
//  SearchKit
//
//  Created by 许灼溪 on 16/1/3.
//
//

import Foundation
@testable import SearchKit

extension SearchType {
    /**
     * 拼音，词库
     */
    public static let PINYIN_WORDS = SearchType(3, nil)
    /**
     * 五笔，词库
     */
    public static let WUBI_WORDS = SearchType(4, nil)
}