//
//  Friend.swift
//  Sample
//
//  Created by 一瀬喜弘 on 2025/03/20.
//
import Foundation
import SwiftData

@Model
class Friend {
  var name: String
  var birthday: Date

  init(name: String, birthday: Date) {
    self.name = name
    self.birthday = birthday
  }

  var isBirthdayToday: Bool {
    Calendar.current.isDateInToday(birthday)
  }

  @MainActor static let sampleData = [
    Friend(name: "Elena", birthday: Date.now),
    Friend(name: "Graham", birthday: Date.now),
    Friend(name: "Mayuri", birthday: Date.now),
    Friend(name: "Rich", birthday: Date.now),
    Friend(name: "Rody", birthday: Date.now),
  ]
}
