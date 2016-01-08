//
//  ChineseCacheProtocol.swift
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
public protocol ChineseCacheProtocol : CacheProtocol {
    
    /**
     * 获取键对应全部值
     *
     * @param key
     *            中文字(词)
     * @return 编码数组
     */
    func getValues(key:String) ->[String]
    
    /**
     * 通过简化编码取得一部分key列表
     *
     * @param valuePrex
     *            简化编码
     * @return 中文字(词)列表
     */
    func getKeys(valuePrex:String) ->[String]
}

