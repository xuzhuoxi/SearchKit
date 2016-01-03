//
//  FixedDimensionMapImpl.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/7.
//
//

/**
* 指定了有效的字符集合<br>
* 使用超出有效字符集合的键dimensionKey进行操作时会报错。<br>
*
* @author xuzhuoxi
*/
class FixedDimensionMapImpl: DimensionMapBase, DimensionMapProtocol {
    private final let _dimension : Int;
    private final let charList : Array<Character>;
    
    init?(charList : Array<Character> , dimension : Int) {
        self.charList = charList
        self._dimension = dimension
        super.init()
        if charList.isEmpty {
            return nil
        }
        initData()
    }
    
    private func initData() {
        var dimensionKeylist : Array<String>?
        for index in 0 ..< _dimension {
            dimensionKeylist = addDimmension(dimensionKeylist)
            valueList.append(Dictionary<String,Set<String>>(minimumCapacity: 8192))
            for dk in dimensionKeylist! {
                valueList[index][dk] = []
            }
        }
    }
    
    var dimension: Int {
        return _dimension
    }
    
    var dimensionInfo: (Int, Int, Int) {
        return computeDimensionInfo()
    }
    
    final func add(dimensionKey: String, dimensionValue: String) {
        if dimensionKey.isEmpty || dimensionKey.length > valueList.count {
            return
        }
        valueList[dimensionKey.length-1][dimensionKey]?.insert(dimensionValue)
    }
    
    final func get(dimensionKey: String) -> Set<String>? {
        return getKeyList(dimensionKey)
    }
    
    private func addDimmension(dimesionKeylist : Array<String>?) -> Array<String> {
        let dl: Array<String> = nil == dimesionKeylist ? Array<String>() : dimesionKeylist!
        var rs : Array<String> = []
        for c in charList {
            if dl.isEmpty {
                rs.append(String(c))
            }else{
                for str in dl {
                    rs.append(str + String(c))
                }
            }
        }
        return rs
    }
}