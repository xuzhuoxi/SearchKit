//
//  SimplePattern.swift
//  SearchKit
//
//  Created by 许灼溪 on 15/12/23.
//
//

import Foundation

/**
 * 简单的正则表达式工具类
 *
 * @author xuzhuoxi
 *
 */
public struct SimplePattern {
    let regex: NSRegularExpression?
    
    public init(_ pattern : String) {
        do{
            let rawValue = NSRegularExpressionOptions.AnchorsMatchLines.rawValue | NSRegularExpressionOptions.DotMatchesLineSeparators.rawValue
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions(rawValue: rawValue))
        }catch{
            regex = nil
        }
    }
    
    public func isMatch(input: String) -> Bool {
        return match(input).count > 0
    }
    
    public func getMatchCount(input: String) ->Int {
        return match(input).count
    }
    
    public func match(input: String) ->[NSTextCheckingResult] {
        if nil == regex {
            return []
        }else{
            let range = NSMakeRange(0, input.characters.count)
            let rs: [NSTextCheckingResult] = regex!.matchesInString(input, options: .ReportProgress, range: range)
            return rs
        }
    }
}