//
//  DimensionMapBase.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/7.
//
//

/**
* 接口IDimensionMap对应的抽象类，存放共用或相似的行为方法<br>
* 每个IDimensionMap的实现类建议继承这个类<br>
*
* @author xuzhuoxi
*
*/
public class DimensionMapBase {
    init(){}
    /**
    * 列表，内部存放的是Map的实例<br>
    * 规律：<br>
    * 1.每个Map实例中，全部Key的字符长度相同。<br>
    * 2.List中第一个Map实例中Key的长度为1，第二个Map实例中Key的长度为2，如此类推<br>
    */
    var valueList:Array<Dictionary<String,Set<String>>> = []
    
    /**
    * 通过键dimensionKey取得对应的值列表<br>
    * 对dimenstionKey进行验证，如果没有缓存过，则返回null。
    *
    * @param dimensionKey
    *            如果长度大于valueList的size，取前部分允许长度的字符串作为键值进行获取<br>
    * @return 值列表
    */
    final func getKeyList(dimensionKey:String) -> Set<String>?{
        let dKeyLen = dimensionKey.characters.count
        if dKeyLen > valueList.count {
            return nil
        }
        return valueList[dKeyLen-1][dimensionKey]
    }
    
    public static func createDimensionMap(charSet : [Character], dimension : Int) -> DimensionMapProtocol? {
        return FixedDimensionMapImpl(charList : charSet, dimension: dimension)
    }
    
    public static func createDimensionMap() -> DimensionMapProtocol {
        return UnfixedDimensionMapImpl()
    }
}