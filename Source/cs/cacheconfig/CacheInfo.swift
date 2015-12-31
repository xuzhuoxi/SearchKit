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
public class CacheInfo {
    /**
     * cache名称
     */
    public let cacheName : String
    
    /**
     * 缓存实例的Class对象
     */
    public let reflectClassName : String
    
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
    public let resourcePath : String?
    /**
     * 字符文件编码类型，如UTF-8等
     */
    public let charsetName : String?
    /**
     * 资源的值处理类型
     */
    public let valueCodingType : ValueCodingType?
    
    /**
     * @return 是否需要资源作为初始化，当resourcePath{@link #resourcePath}无效时返回false。
     */
    public let isNeedResource : Bool
    
    /**
     * 反射出来的类类型
     */
//    public lazy var reflectClass: CacheProtocol.Type? = {return NSClassFromString(self.reflectClassName) as? CacheProtocol.Type}()
    public let reflectClass: CacheProtocol.Type?
    
    public init(_ cacheName: String, _ reflectClassName: String, _ isSingleton: Bool, _ initialCapacity: UInt, _ resourcePath: String?, _ charsetName: String?, _ valueCodingType: ValueCodingType?) {
        self.cacheName = cacheName
        self.reflectClassName = reflectClassName
        self.isSingleton = isSingleton
        self.initialCapacity = initialCapacity
        self.resourcePath = resourcePath
        self.charsetName = charsetName
        self.valueCodingType = valueCodingType
        
        self.isNeedResource = nil != resourcePath && !resourcePath!.isEmpty
        self.reflectClass = NSClassFromString(reflectClassName) as? CacheProtocol.Type
    }

    convenience public init(cacheName: String, reflectClassName: String, isSingleton: Bool, initialCapacity: UInt, resourcePath: String?, valueCodingType: ValueCodingType?) {
        self.init(cacheName, reflectClassName, isSingleton, initialCapacity, resourcePath, "UTF-8", valueCodingType)
    }
}