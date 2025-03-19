//
//  Scoreboard.swift
//  Sample
//
//  Created by 一瀬喜弘 on 2025/03/19.
//
import Foundation

struct Scoreboard {
  var players: [Player] = [
    Player(name: "Elisha", score: 0),
    Player(name: "Andre", score: 0),
    Player(name: "Jasmine", score: 0),
  ]

  var state = GameState.setup

  mutating func resetScores(to newValue: Int) {
    for index in 0..<players.count {
      players[index].score = newValue
    }
  }
}

struct Player: Identifiable {
  let id = UUID()

  var name: String
  var score: Int
}

enum GameState {
  case setup
  case playing
  case gameOver
}
