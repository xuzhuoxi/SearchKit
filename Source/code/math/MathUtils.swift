//
//  MathUtils.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/17.
//
//

/**
* 一些常用的数学方法
*
* @author xuzhuoxi
*
*/
public struct MathUtils {
    private init(){}
    /**
     * 计算从个数为m的有序数组中取得n个元素所构成的组合的个数<br>
     * 组合行为基于数组顺序
     *
     * @param m
     *            数据数量
     * @param n
     *            选择个数
     * @return 组合个数
     */
    public static func getCombinationCount(m:Int, _ n:Int) ->Int{
        var getLen: Int = 0
        var fenzi: Int = m
        var fenmu: Int = 1
        for i in 1..<n {
            let temp = m
            fenzi = fenzi * (temp - i)
            let demp = 1
            fenmu = fenmu * (demp + i)
        }
        getLen = fenzi / fenmu
        return getLen
    }
    
    /**
     * 十进制转换不确定进制
     *
     * @param value
     *            十进制数值
     * @param system
     *            不确定进制数组
     * @return 由十进制数据组成的数组
     */
    public static func tenToCustomSystem(value:Int, _ system:[Int]) ->[Int] {
        var rs = Array<Int>(count : system.count, repeatedValue : 0)
        var temp = value
        for i in 0..<system.count {
            rs[i] = temp%system[i]
            temp = temp/system[i]
        }
        return rs
    }
    
    /**
     * 从sourceLen个源数据中最多选择dimension个元素进行组合，组合过程基于源数据的顺序<br>
     *
     * @param sourceLen
     *            源数据个数
     * @param dimension
     *            最多可选择个数
     * @return 全部组合的索引情况
     */
    public static func getDimensionCombinationIndex(sourceLen:Int, dimension:Int) ->[[[Int]]]? {
        let newDimension = sourceLen<dimension ? sourceLen : dimension
        if newDimension<1 {
            return nil
        }
        if 1==newDimension {
            var result = [[[Int]]](count: 1, repeatedValue: [[Int]]())
            for i in 0..<sourceLen {
                result[0].append([i])
            }
            return result
        }
        var rs = [[[Int]]](count: newDimension, repeatedValue: [[Int]]())
        for i in 0..<sourceLen {
            for (var j = newDimension-2; j>=0; j--){
                if rs[j].count > 0 {
                    for indexs in rs[j] {
                        var add = indexs
                        add.append(i)
                        rs[j+1].append(add)
                    }
                }
                if 0==j {
                    rs[0].append([i])
                }
            }
        }
        for i in 0..<rs.count {
            rs[i].sortInPlace(intArrayComparable)
        }
        return rs;
    }
    
    private static func intArrayComparable(o1:[Int], o2:[Int]) ->Bool {
        if o1.count != o2.count {
            return o1.count < o2.count
        }else{
            for i in 0..<o1.count {
                if o1[i] != o2[i] {
                    return o1[i] < o2[i]
                }
            }
            return false
        }
    }
}