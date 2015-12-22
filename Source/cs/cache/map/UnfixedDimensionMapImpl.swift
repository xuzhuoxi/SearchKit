//
//  UnfixedDimensionMapImpl.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/7.
//
//

/**
 * 无字符集合限制<br>
 * 可使用任何键dimensionKey进行操作<br>
 *
 * @author xuzhuoxi
 */
public class UnfixedDimensionMapImpl : DimensionMapBase, DimensionMapProtocol{
    public func getDimension() -> Int {
        return valueList.count
    }

    /**
    * 如果键dimensionKey的长度大于维度(valueList.size)，则填充空的Map至使维度(valueList.size)
    * 等于dimensionKey的长度<br>
    */
    public func add(dimensionKey: String?, dimensionValue: String) {
        if nil == dimensionKey || dimensionKey!.isEmpty{
           return
        }
        let dKey = dimensionKey!
        let dKeyLen = dKey.characters.count
        let dValue = dKeyLen - valueList.count;
        if dValue>0 {
            for _ in 0..<dValue {
                valueList.append(Dictionary<String,Set<String>>())
            }
        }
        var map = valueList[dKeyLen-1]
        if nil == map[dKey]{
            map[dKey] = []
        }
        map[dKey]?.insert(dimensionValue)
    }

    public func get(dimensionKey: String) -> Set<String>? {
        return getKeyList(dimensionKey)
    }
}