//
//  KeyValues.swift
//  ChineseSearch
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
public class KeyValues {
    /**
     * 汉字(词)
     */
    private let key : String;
    /**
     * 编码
     */
    private var values : Set<String>;
    
    public init(_ key : String) {
        self.key = key
        self.values = []
    }
    
    public final func getKey() ->String {
        return key;
    }
    
    /**
     * 验证编码是否重复，否则存起来
     *
     * @param value
     *            编码
     * @return 缓存成功true，否则返回false
     */
    public final func addValue(value : String) ->Bool{
        if values.contains(value) {
            return false
        } else {
            values.insert(value)
            return true
        }
    }
    
    /**
     * 取得全部编码信息
     *
     * @return 全部编码组成的数组
     */
    public final func getValues() ->Set<String> {
        let rs = values
        return rs
    }
}
