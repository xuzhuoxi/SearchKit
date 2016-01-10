//
//  ExCharacter.swift
//  SearchKit
//
//  Created by 许灼溪 on 16/1/9.
//
//

import Foundation

extension Character {
    public func isWhitespace() ->Bool {
        return self <= " "
    }
}