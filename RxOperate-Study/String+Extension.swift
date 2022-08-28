//
//  String+Extension.swift
//  RxOperate-Study
//
//  Created by ByungHoon Ann on 2022/08/28.
//

import Foundation

extension String {
    var isNumber: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[0-9]+$", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: .reportCompletion, range: NSMakeRange(0, count)) { return true }
        } catch { return false }
        return false
    }
}
