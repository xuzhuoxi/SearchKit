//
//  main.swift
//  TestProduct
//
//  Created by 许灼溪 on 15/12/2.
//
//

import Foundation

/**
* ^[1-9]d*.d*$ //大于等于1浮点数
*/
let REGEX_FLOAT_1MORE: String = "^+?([1-9]\\d*.\\d*|[1-9]\\d*)$"

let str: String = "1.23"
let str2: String = "adh"

print(Regex.match(str, REGEX_FLOAT_1MORE))
print(12321)