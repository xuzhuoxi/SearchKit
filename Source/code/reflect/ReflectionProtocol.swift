//
//  ReflectionProtocol.swift
//  SearchKit
//
//  Created by 许灼溪 on 16/1/1.
//
//

import Foundation

public protocol ReflectionProtocol {
    /**
     * 创建新实例
     *
     * @return 新实例
     */
    static func newInstance() ->ReflectionProtocol
}