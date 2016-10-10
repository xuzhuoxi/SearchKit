//
//  CacheInfo.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/18.
//
//

import Foundation

/**
 * 缓存信息
 *
 * @author xuzhuoxi
 *
 */
public struct CacheInfo {
    /**
     * cache名称
     */
    public let cacheName : String
    
    /**
     * 缓存实例的反射信息
     */
    public let cacheReflectionInfo: ReflectionInfo
    
    /**
     * 是否为单例<br>
     * 是：实例化后加入到缓存池中。{@link CachePool}<br>
     * 否：实例化后不加入到缓存池中。<br>
     */
    public let isSingleton : Bool
    
    /**
     * 哈希表初始容量
     */
    public let initialCapacity : UInt
    
    /**
     * 缓存初始化时使用资源的路径 多个资源可使用""相隔
     */
    public let resourceURLs : [URL]?
    /**
     * 字符文件编码类型，如UTF-8等
     */
    public let charsetName : String?
    /**
     * 资源的值实例的反射信息
     */
    public let valueCodingReflectionInfo: ReflectionInfo?
    
    /**
     * @return 是否需要资源作为初始化，当resourcePath{@link #resourcePath}无效时返回false。
     */
    public let isNeedResource : Bool
    
    public init(_ cacheName: String, _ cacheClassName: String, _ isSingleton: Bool, _ initialCapacity: UInt, _ resourceURLs: [URL]?, _ charsetName: String?,  valueCodingType: ValueCodingType?) {
        self.cacheName = cacheName
        self.cacheReflectionInfo = ReflectionInfo(className: cacheClassName)
        self.isSingleton = isSingleton
        self.initialCapacity = initialCapacity
        self.resourceURLs = resourceURLs
        self.charsetName = charsetName
        self.valueCodingReflectionInfo = nil == valueCodingType ? nil : ReflectionInfo(className: valueCodingType!.associatedClassName)
        
        self.isNeedResource = nil != resourceURLs && !resourceURLs!.isEmpty
    }
    
    public init(_ cacheName: String, _ cacheClassName: String, _ isSingleton: Bool, _ initialCapacity: UInt, _ resourceURLs: [URL]?, _ charsetName: String?,  valueCodingClassName: String?) {
        self.cacheName = cacheName
        self.cacheReflectionInfo = ReflectionInfo(className: cacheClassName)
        self.isSingleton = isSingleton
        self.initialCapacity = initialCapacity
        self.resourceURLs = resourceURLs
        self.charsetName = charsetName
        self.valueCodingReflectionInfo = nil == valueCodingClassName ? nil : ReflectionInfo(className: valueCodingClassName!)
        
        self.isNeedResource = nil != resourceURLs && !resourceURLs!.isEmpty
    }

    public init(cacheName: String, reflectClassName: String, isSingleton: Bool, initialCapacity: UInt, resourceURLs: [URL]?, valueCodingType: ValueCodingType?) {
        self.init(cacheName, reflectClassName, isSingleton, initialCapacity, resourceURLs, "UTF-8", valueCodingType: valueCodingType)
    }
    
    public init(cacheName: String, reflectClassName: String, isSingleton: Bool, initialCapacity: UInt, resourceURLs: [URL]?, valueCodingClassName: String?) {
        self.init(cacheName, reflectClassName, isSingleton, initialCapacity, resourceURLs, "UTF-8", valueCodingClassName: valueCodingClassName)
    }
}
