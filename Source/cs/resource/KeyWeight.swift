//
//  KeyWeight.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/15.
//
//

/**
* 汉字(词)与权重信息
*
* @author xuzhuoxi
*
*/
public struct KeyWeight {
    /**
     * 汉字(词)
     */
    public let key: String
    
    /**
     * 权重
     */
    public let weight: Double
    
    public init(key: String, weight: Double){
        self.key = key
        self.weight = weight
    }
}