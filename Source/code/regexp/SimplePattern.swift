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
            let rawValue = NSRegularExpression.Options.anchorsMatchLines.rawValue | NSRegularExpression.Options.dotMatchesLineSeparators.rawValue
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: rawValue))
        }catch{
            regex = nil
        }
    }
    
    public func isMatch(_ input: String) -> Bool {
        return match(input).count > 0
    }
    
    public func getMatchCount(_ input: String) ->Int {
        return match(input).count
    }
    
    public func match(_ input: String) ->[NSTextCheckingResult] {
        if nil == regex {
            return []
        }else{
            let range = NSMakeRange(0, input.characters.count)
            let rs: [NSTextCheckingResult] = regex!.matches(in: input, options: .reportProgress, range: range)
            return rs
        }
    }
}
