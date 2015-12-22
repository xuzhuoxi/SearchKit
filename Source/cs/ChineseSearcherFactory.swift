//
//  ChineseSearcherFactory.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/21.
//
//

import Foundation

/**
 *
 * @author xuzhuoxi
 *
 */
public class ChineseSearcherFactory {
    private static let instance:ChineseSearcherProtocol = ChineseSearcherImpl()
    
    /**
    * 取得一个IChineseSearcher实例<br>
    *
    * @param newInstance
    *            是否创建新实例
    * @return 当newInstance为true时，创建新实例<br>
    *         当newInstance为false时，返回单例<br>
    */
    public static func getChineseSearcher(newInstance: Bool = false) ->ChineseSearcherProtocol {
        if newInstance {
            return ChineseSearcherImpl();
        }
        return instance
    }
    
    private init(){}
}
