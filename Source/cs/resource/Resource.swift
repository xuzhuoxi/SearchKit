//
//  Resource.swift
//  SearchKit
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
    private let name : String
    private var keyList : [String]
    private var valueList : [String]
    
    /**
     * 键值对数量
     *
     * @return 键值对数量
     */
    public var size: Int {
        return keyList.count
    }
    
    private init(name: String) {
        self.name = name
        self.keyList = []
        self.valueList = []
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
     * 追加一个资源文件
     */
    public final func appendFile(absoluteFilePath: String) {
        let nPath = absoluteFilePath
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(nPath) {
            do {
                let content = try NSString(contentsOfFile: nPath, encoding: NSUTF8StringEncoding)
                self.appendDataString(content as String)
            } catch {
            }
        }
//        let tfr = TextFileReader(path: absoluteFilePath)
//        while let line = tfr.nextLine() {
//            self.appendLine(line)
//        }
    }
    
    /**
     * 追加字符串数据
     */
    public final func appendDataString(dataString: String) {
        let dataArray =  dataString.componentsSeparatedByString("\n")
        for str in dataArray {
            self.appendLine(str)
        }
    }
    
    /**
     * 追加一行数据
     */
    public final func appendLine(lineString: String) {
        if lineString.isEmpty{
            return
        }
        let trimLine = lineString.trim()
        if trimLine.isEmpty {
            return
        }
        if let index = trimLine.characters.indexOf("=") {
            let key = trimLine.substringToIndex(index).trimRight()
            if  key.isEmpty {
                return
            }
            let value = trimLine.substringFromIndex(index.advancedBy(1)).trimLeft()
            if value.isEmpty {
                return
            }
            self.keyList.append(key)
            self.valueList.append(value)
        }
    }
    
    /**
     * 追加一对数据
     */
    public final func appendData(key: String, value: String) {
        if key.isEmpty || value.isEmpty {
            return
        }
        self.keyList.append(key)
        self.valueList.append(value)
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
        let rs = Resource(name : "\(data.hashValue)")
        rs.appendDataString(data)
        return rs
    }
    
    /**
     * 通过资源的路径创建实例，默认资源编码格式为UTF-8。<br>
     *
     * @param absoluteFilePath
     *            文件路径
     * @return 
     *  路径有效且格式正确: Resource实例
     *  否则:nil
     */
    public static func getResource(absoluteFilePath: String) ->Resource? {
        let rs = Resource(name: "\(absoluteFilePath.hashValue)")
        rs.appendFile(absoluteFilePath)
        if rs.size <= 0 {
            return nil
        }
        return rs
    }
}