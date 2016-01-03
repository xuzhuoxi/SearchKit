//
//  DimensionMapProtocol.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/7.
//
//

/**
* 键值表，用于反向查找汉字或词语<br>
* 通过针对汉字或词语对应的各种编码进行进一步的简化编码，得到的简化编码作为键<br>
* 记录简化编码与汉字或词语对应的影射关系<br>
*
* @author xuzhuoxi
*
*/
public protocol DimensionMapProtocol: class{
    /**
     * 获得当前维度，即存放中最长的Key的长度
     *
     * @return 当前维度
     */
    var dimension: Int {get}
    
    /**
     * 计算数量(dimension, dimensionKey数量, dimensionValue数量)
     *
     * @return (Int, Int, Int)。
     */
    var dimensionInfo: (Int, Int, Int) {get}
    
    /**
     * 存储一对键值对，如果键已存在，就尝试在对应值列表中追加值，已存在相同的值则忽略。<br>
     *
     * @param dimensionKey
     *            键
     * @param dimensionValue
     *            值
     */
    func add(dimensionKey : String, dimensionValue : String)
    
    /**
     * 通过键，取得值列表<br>
     *
     * @param dimensionKey
     *            键
     * @return 返回的是原始列表，若要修改请注意。
     */
    func get(dimensionKey : String) ->Set<String>?
}