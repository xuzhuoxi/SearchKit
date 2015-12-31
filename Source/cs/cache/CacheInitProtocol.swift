//
//  CacheInitProtocol.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/16.
//
//

import Foundation

/**
 *
 * @author xuzhuoxi
 *
 */
public protocol CacheInitProtocol : class {
    /**
     * 初始化Cache信息
     *
     * @param cacheName
     *            Cache名称
     * @param valueCodingType
     *            资源的值处理类型{@link CacheInfo#getValueType()}
     * @param initialCapacity
     *            初始化容器{@link CacheInfo#getInitialCapacity()}
     */
    func initCache(cacheName:String, _ valueCodingType : ValueCodingType?, _ initialCapacity : UInt)
    
    /**
     * 缓存数据<br>
     *
     * @param resource
     *            数据资源，详细请看Resource类{@link Resource}
     */
    func supplyResource(resource:Resource)
    
    /**
     * 缓存数据<br>
     *
     * @param path
     *            文件路径
     */
    func supplyResource(path : String)
    
    /**
     * 缓存数据<br>
     *
     * @param data
     *            数据字符串，以换行符区分单个数据
     */
    func supplyData(data : String)
    
    /**
     * 缓存数据<br>
     *
     * @param key
     *            数据字符串-键
     * @param value
     *            数据字符串-键
     */
    func supplyData(key : String, value: String)
}