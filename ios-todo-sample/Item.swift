//
//  Item.swift
//  ios-todo-sample
//
//  Created by 一瀬喜弘 on 2025/03/18.
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
