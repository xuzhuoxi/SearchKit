//
//  CacheInitProtocol.swift
//  SearchKit
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
     * @param valueCodingInstance
     *            资源的值处理接口
     * @param initialCapacity
     *            初始化容器{@link CacheInfo#getInitialCapacity()}
     */
    func initCache(_ cacheName:String, _ valueCodingInstance: ValueCodingStrategyProtocol?, _ initialCapacity: UInt)
    
    /**
     * 缓存数据<br>
     *
     * @param resource
     *            数据资源，详细请看Resource类{@link Resource}
     */
    func supplyResource(_ resource: Resource)
    
    /**
     * 缓存数据<br>
     *
     * @param path
     *            文件路径
     */
    func supplyResource(_ url: URL)
    
    /**
     * 缓存数据<br>
     *
     * @param data
     *            数据字符串，以换行符区分单个数据
     */
    func supplyData(_ data: String)
    
    /**
     * 缓存数据<br>
     *
     * @param key
     *            数据字符串-键
     * @param value
     *            数据字符串-键
     */
    func supplyData(_ key : String, value: String)
}
