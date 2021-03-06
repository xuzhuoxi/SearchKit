//
//  ResourcePaths.swift
//  SearchKit
//
//  Created by 许灼溪 on 16/1/3.
//
//

import Foundation

public struct ResourcePaths {
    fileprivate init(){}
    
    /**
     * 拼音字库资源 URL
     */
    public static let URL_PINYIN_WORD = ResourcePaths.getProperitesURL(Resource.self, name: "word_pinyin")!
    
    /**
     * 拼音字库资源 路径
     */
    public static let PATH_PINYIN_WORD = ResourcePaths.URL_PINYIN_WORD.path
    
    /**
     * 五笔字库资源 URL
     */
    public static let URL_WUBI_WORD = ResourcePaths.getProperitesURL(Resource.self, name: "word_wubi")!
    
    /**
     * 五笔字库资源 路径
     */
    public static let PATH_WUBI_WORD = ResourcePaths.URL_WUBI_WORD.path
    
    public static func getProperitesURL(_ anyClass: AnyClass, name: String) ->URL?{
        return Bundle(for: anyClass).url(forResource: name, withExtension: "properites")
    }
}
