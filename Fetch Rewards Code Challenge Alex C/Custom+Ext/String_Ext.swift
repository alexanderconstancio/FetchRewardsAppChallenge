//
//  String_Ext.swift
//  Fetch Rewards Code Challenge Alex C
//
//  Created by Alex Constancio on 9/29/21.
//

import Foundation

extension String {
    var westernArabicNumeralsOnly: String {
        let pattern = UnicodeScalar("0")..."9"
        return String(unicodeScalars
            .compactMap { pattern ~= $0 ? Character($0) : nil })
    }
}
