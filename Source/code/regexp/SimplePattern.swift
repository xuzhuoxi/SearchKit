//
//  SimplePattern.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/23.
//
//

import Foundation

public struct SimplePattern {
    let regex: NSRegularExpression?
    
    public init(_ pattern : String) {
        do{
            regex = try NSRegularExpression(pattern: pattern, options: .AnchorsMatchLines)
        }catch{
            regex = nil
        }
    }
    
    func match(input: String) -> Bool {
        if nil == regex {
            return false
        }else{
            let range = NSMakeRange(0, input.length)
            print("a")
            regex!.firstMatchInString(input, options: .ReportCompletion, range: range)
            print("b")
            if let _ = regex!.firstMatchInString(input, options: .ReportCompletion, range: NSMakeRange(0, input.length)){
                return true
            }
            return false
//            return regex!.numberOfMatchesInString(input, options: .ReportCompletion, range: NSMakeRange(0, input.length)) > 0
        }
    }
}