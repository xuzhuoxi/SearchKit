//
//  UnfixedDimensionMapImpl.swift
//  SearchKit
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
class UnfixedDimensionMapImpl : DimensionMapBase, DimensionMapProtocol{
    var dimension: Int {
        return valueList.count
    }
    
    var dimensionInfo: (Int, Int, Int) {
        return computeDimensionInfo()
    }
    
    /**
     * 如果键dimensionKey的长度大于维度(valueList.size)，则填充空的Map至使维度(valueList.size)
     * 等于dimensionKey的长度<br>
     */
    final func add(dimensionKey: String, dimensionValue: String) {
        if dimensionKey.isEmpty{
            return
        }
        let dKeyLen = dimensionKey.characters.count
        let dValue = dKeyLen - valueList.count;
        if dValue > 0 {
            for _ in 0..<dValue {
                valueList.append(Dictionary<String,Set<String>>())
            }
        }
        if !valueList[dKeyLen-1].has(dimensionKey) {
            valueList[dKeyLen-1][dimensionKey] = []
        }
        valueList[dKeyLen-1][dimensionKey]!.insert(dimensionValue)
    }
    
    final func get(dimensionKey: String) -> Set<String>? {
        return getKeyList(dimensionKey)
    }
}