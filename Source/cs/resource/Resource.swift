//
//  Resource.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/15.
//
//

import Foundation

/**
 *
 * @author xuzhuoxi
 *
 */
public class Resource {
    private let path : String
    private var keyList : Array<String>
    private var valueList : Array<String>
    
    private init(path:String){
        self.path = path;
        keyList=[]
        valueList=[]
    }
    
    /**
     * 判断是否为键
     *
     * @param key
     *            待判断的键
     * @return 是true否false
     */
    public final func isKey(key : String) ->Bool {
        return keyList.contains(key)
    }
    
    /**
     * 键值对数量
     *
     * @return 键值对数量
     */
    public final func size() ->Int {
        return keyList.count
    }
    
    /**
     * 取键
     *
     * @param index
     *            索引
     * @return 键
     */
    public final func getKey(index : Int) ->String {
        return keyList[index]
    }
    
    /**
     * 取全部键
     *
     * @return 键组成的数组
     */
    public final func getKeys() ->Array<String> {
        let rs = keyList
        return rs
    }
    
    /**
     * 取值
     *
     * @param index
     *            索引
     * @return 值
     */
    public final func getValue(index : Int) ->String {
        return valueList[index];
    }
    
    /**
     * 取全部值
     *
     * @return 值
     */
    public final func getValues() ->Array<String> {
        let rs = valueList
        return rs
    }
    
    /**
     * 通过字符串数据创建实例<br>
     *
     * @param data
     *            字符串数据
     * @return Resource实例
     */
    public static func getResourceByData(data:String) -> Resource? {
        if data.isEmpty {
            return nil
        }
        let rs = Resource(path : toFullPath(data))
        saveData(rs, dataString: data)
        return rs
    }
    
    /**
     * 通过资源的路径创建实例，默认资源编码格式为UTF-8。<br>
     *
     * @param filePath
     *            文件路径
     * @param succCall
     *            下载成功后回调，格式:function(rs:Resource):void;
     */
    public static func getResource(filePath:String) ->Resource? {
        return loadFile(filePath);
    }
    
    private static func loadFile(filePath:String) ->Resource? {
        let nPath = toFullPath(filePath)
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(nPath) {
            do {
                let content = try NSString(contentsOfFile: nPath, encoding: NSUTF8StringEncoding)
                let rs = Resource(path: nPath)
                saveData(rs, dataString: content as String)
                return rs
            } catch {
                return nil
            }
        }else{
            return nil
        }
//        let rs = Resource(path: nPath)
//        let tfr = TextFileReader(path: filePath)
//        while var line = tfr.nextLine() {
//            saveLine(rs, lineString: &line)
//        }
//        return rs
    }
    
    private static func saveData(rs:Resource, dataString:String) {
        let dataArray =  dataString.componentsSeparatedByString("\n")
        for var str in dataArray {
            saveLine(rs, lineString: &str)
        }
    }
    
    private static func saveLine(rs: Resource, inout lineString: String) {
        if lineString.isEmpty || lineString.trimmed().isEmpty {
            return
        }
        if let index = lineString.characters.indexOf("=") {
            let key = lineString.substringToIndex(index).trimmed()
            if  key.isEmpty {
                return
            }
            let value = lineString.substringFromIndex(index.advancedBy(1)).trimmed()
            if value.isEmpty {
                return
            }
            rs.keyList.append(key)
            rs.valueList.append(value)
        }

    }
    
    private static func toFullPath(path :String)->String {
        return path;
    }
}