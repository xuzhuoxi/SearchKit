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
public class KeyWeight {
    /**
     * 汉字(词)
     */
    private let key : String;
    /**
     * 权重
     */
    private let weight : Double;
    
    public init(key:String, weight:Double){
        self.key = key
        self.weight = weight
    }
    
    public final func getKey() ->String {
        return key;
    }
    
    public final func getWeight() ->Double {
        return weight;
    }
}