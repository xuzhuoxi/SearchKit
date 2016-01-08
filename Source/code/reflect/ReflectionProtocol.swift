//
//  ReflectionProtocol.swift
//  SearchKit
//
//  Created by 许灼溪 on 16/1/1.
//
//

import Foundation

/**
 * 通用无参数反射接口
 *
 * @author xuzhuoxi
 *
 */
public protocol ReflectionProtocol {
    /**
     * 创建新实例
     *
     * @return 新实例
     */
    static func newInstance() ->ReflectionProtocol
}