//
//  Regex.swift
//  ChineseSearch
//
//  Created by 许灼溪 on 15/12/20.
//  Copyright © 2015年 许灼溪. All rights reserved.
//

import Foundation

public class Regex {
    public static func match(source: String, _ regex: String) ->Bool {
        do {
            if let _ = try source.matches(regex) {
                return true
            }
        }catch{
            return false;
        }
        return false;
    }
}