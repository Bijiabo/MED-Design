//
//  MiiRegex.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/8/30.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import Foundation

struct RegexHelper {
    let regex: NSRegularExpression?
    
    init(_ pattern: String) {
        
        do {
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
        } catch let error as NSError{
            regex = NSRegularExpression()
            print(error)
        }
        
    }
    
    func match(input: String) -> Bool {
        if let matches = regex?.matchesInString(input,
            options: [] ,
            range: NSMakeRange(0, input.utf16.count )) {
                return matches.count > 0
        } else {
            return false
        }
    }
}

infix operator =~ {
    associativity none
    precedence 130
}

func =~(lhs: String, rhs: String) -> Bool {
    return RegexHelper(rhs).match(lhs)
}