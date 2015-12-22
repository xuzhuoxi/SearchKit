//
//  SearchInfo.swift
//  ChineseSearch
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
public class SearchInfo {
    private var inputStr:String
    private var searchType:[SearchTypes]
    private var maxResultCount:Int
    private var chineseInput:Bool
    private var chineseWordsRegexp:String?
    
    /**
     *
     * @param inputStr
     *            输入信息，掉前后空格并把大写字母转为小写后存于inputStr{@link #inputStr}<br>
     * @param searchType
     *            需要执行的检索类别<br>
     * @param maxResultCount
     *            最大返回量<br>
     */
    public init(_ inputStr:String, _ searchType:[SearchTypes], _ maxResultCount:Int) {
        self.inputStr=inputStr.trimmed().lowercaseString
        self.searchType=searchType
        self.maxResultCount=maxResultCount
        self.chineseInput=ChineseUtils.hasChinese(self.inputStr)
        if self.chineseInput {
            self.chineseWordsRegexp = ChineseUtils.toChineseWordsRegexp(self.inputStr)
        }
    }
    
    /**
     * 输入信息，保证已经去掉前后空格并把大写字母转为小写<br>
     *
     * @return 输入信息，保证已经去掉前后空格并把大写字母转为小写<br>
     */
    public final func getInputStr() ->String {
        return inputStr
    }
    
    /**
     * 需要执行的检索类别<br>
     *
     * @return 需要执行的检索类别<br>
     */
    public final func getSearchType() ->[SearchTypes]{
        return searchType
    }
    
    /**
     * 最大返回量
     *
     * @return 最大返回量
     */
    public final func getMaxResultCount() ->Int {
        return maxResultCount
    }
    
    /**
     * 输入中是否带中文字
     *
     * @return 输入中是否带中文字
     */
    public final func isChineseInput() ->Bool {
        return chineseInput
    }
    
    /**
     * 当chineseInput为true时有效<br>
     * 一个针对中文字生成的正则表达式{@link ChineseUtils#toChineseWordsRegexp(String)}<br>
     *
     * @return 输入的中文正则表达式
     */
    public final func getChineseWordsRegexp() ->String? {
        return chineseWordsRegexp
    }
}