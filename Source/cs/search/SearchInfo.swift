//
//  SearchInfo.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/21.
//
//

import Foundation

/**
 *
 * @author xuzhuoxi
 *
 */
public struct SearchInfo {
    /**
     * 输入信息，保证已经去掉前后空格并把大写字母转为小写<br>
     *
     * @return 输入信息，保证已经去掉前后空格并把大写字母转为小写<br>
     */
    public let inputStr: String
    /**
     * 需要执行的检索配置<br>
     *
     * @return 需要执行的检索配置<br>
     */
    public let searchConfig: SearchConfig
    /**
     * 最大返回量
     *
     * @return 最大返回量
     */
    public let maxResultCount: Int
    /**
     * 输入中是否带中文字
     *
     * @return 输入中是否带中文字
     */
    public let isChineseInput: Bool
    /**
     * 当chineseInput为true时有效<br>
     * 一个针对中文字生成的正则表达式{@link ChineseUtils#toChineseWordsRegexp(String)}<br>
     *
     * @return 输入的中文正则表达式
     */
    public let chineseWordsRegexp: String?
    
    /**
     *
     * @param inputStr
     *            输入信息，掉前后空格并把大写字母转为小写后存于inputStr{@link #inputStr}<br>
     * @param searchType
     *            需要执行的检索类别<br>
     * @param maxResultCount
     *            最大返回量<br>
     */
    public init(_ inputStr:String, _ searchConfig:SearchConfig, _ maxResultCount:Int) {
        self.inputStr = inputStr.trim().lowercased()
        self.searchConfig = searchConfig
        self.maxResultCount = maxResultCount
        self.isChineseInput = ChineseUtils.hasChinese(self.inputStr)
        self.chineseWordsRegexp = isChineseInput ? ChineseUtils.toChineseWordsRegexp(self.inputStr) : nil
    }
}
