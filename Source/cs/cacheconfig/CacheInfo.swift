//
//  CacheInfo.swift
//  ChineseSearch
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
    private let cacheName : String
    
    /**
     * 缓存初始化时使用资源的路径 多个资源可使用""相隔
     */
    private let resourcePath : String?
    /**
     * 字符文件编码类型，如UTF-8等
     */
    private let charsetName : String?
    /**
     * 资源的值处理类型
     */
    private let valueType : ValueCodingTypes?
    /**
     * 是否为单例<br>
     * 是：实例化后加入到缓存池中。{@link CachePool}<br>
     * 否：实例化后不加入到缓存池中。<br>
     */
    private let singleton : Bool
    
    /**
     * 缓存实例的Class对象
     */
    private let cacheClass : AnyClass
    
    /**
     * 哈希表初始容量
     */
    private let initialCapacity : UInt
    
    public init(cacheName : String, myClass : AnyClass, resourcePath : String?, charsetName : String?, valueType : ValueCodingTypes?, singleton : Bool, initialCapacity : UInt) {
        self.init(cacheName: cacheName, myClass: myClass, resourcePath: resourcePath, charsetName: charsetName, valueType: valueType, singleton: singleton, initialCapacity: initialCapacity)
    }

    public init(cacheName : String, myClass : AnyClass, resourcePath : String?, valueType : ValueCodingTypes?, singleton : Bool) {
        self.init(cacheName: cacheName, myClass: myClass, resourcePath: resourcePath, charsetName: "UTF-8", valueType: valueType, singleton: singleton, initialCapacity: 16)
    }
    
    /**
     * @return cache名称
     */
    public func getCacheName() ->String{
        return cacheName
    }
    
    /**
     * @return 缓存初始化时使用资源的路径<br>
     *         多个资源可使用""相隔
     */
    public func getResourcePath() ->String? {
        return resourcePath
    }
    
    /**
     * @return 字符文件编码类型，如UTF-8等<br>
     *         默认为UTF-8<br>
     */
    public func getCharsetName() ->String? {
        return charsetName
    }
    
    /**
     * @return 资源的值处理类型
     */
    public func getValueType() ->ValueCodingTypes? {
        return valueType
    }
    
    /**
     * @return 是否为单例<br>
     *         是：实例化后加入到缓存池中。{@link CachePool}<br>
     *         否：实例化后不加入到缓存池中。<br>
     */
    public func isSingleton() ->Bool {
        return singleton
    }
    
    /**
     * @return 缓存实例的Class对象
     */
    public func getCacheClass() ->AnyClass {
        return cacheClass
    }
    
    /**
     * @return 哈希表初始容量
     */
    public func getInitialCapacity() ->UInt {
        return initialCapacity
    }
    
    /**
     * @return 是否需要资源作为初始化，当resourcePath{@link #resourcePath}无效时返回false。
     */
    public var isNeedResource : Bool {
        return nil != resourcePath && !resourcePath!.isEmpty
    }
}