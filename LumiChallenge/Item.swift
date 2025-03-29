//
//  Item.swift
//  LumiChallenge
//
//  Created by Daniel on 29/3/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
