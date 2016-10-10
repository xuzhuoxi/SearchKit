//
//  ExResourcePaths.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/28.
//
//

import Foundation
@testable import SearchKit

private class RC {}

extension ResourcePaths {
    
    /**
     * 测试输入法 拼音词库 URL
     */
    public static let URL_PINYIN_WORDS = ResourcePaths.getProperitesURL(RC.self, name: "words_pinyin")!
    /**
     * 测试输入法 拼音词库 路径
     */
    public static let PATH_PINYIN_WORDS = ResourcePaths.URL_PINYIN_WORDS.path
    
    /**
     * 测试输入法 五笔词库 URL
     */
    public static let URL_WUBI_WORDS = ResourcePaths.getProperitesURL(RC.self, name: "words_wubi")!
    /**
     * 测试输入法 五笔词库 路径
     */
    public static let PATH_WUBI_WORDS = ResourcePaths.URL_WUBI_WORDS.path
    
    /**
     * 测试输入法 词库权值 URL
     */
    public static let URL_WEIGHT_WORDS = ResourcePaths.getProperitesURL(RC.self, name: "words_weight")!
    /**
     * 测试输入法 词库权值 路径
     */
    public static let PATH_WEIGHT_WORDS = ResourcePaths.URL_WEIGHT_WORDS.path
}
