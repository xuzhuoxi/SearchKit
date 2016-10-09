//
//  KeyValues.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/15.
//
//

/**
* 汉字(词)与编码的信息
*
* @author xuzhuoxi
*
*/
public struct KeyValues {
    /**
     * 汉字(词)
     */
    public let key : String
    /**
     * 全部编码信息
     */
    fileprivate(set) public var values : Set<String>
    
    public init(_ key : String) {
        self.key = key
        self.values = []
    }
    
    /**
     * 验证编码是否重复，否则存起来
     *
     * @param value
     *            编码
     * @return 缓存成功true，否则返回false
     */
    mutating public func addValue(_ value : String) ->Bool{
        if values.contains(value) {
            return false
        } else {
            values.insert(value)
            return true
        }
    }
}
