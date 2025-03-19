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
  var doesHighestScoreWin = true

  var winners: [Player] {
    guard state == .gameOver else { return [] }

    var winningScore = 0
    if doesHighestScoreWin {
      winningScore = Int.min
      for player in players {
        winningScore = max(player.score, winningScore)
      }
    } else {
      winningScore = Int.max
      for player in players {
        winningScore = min(player.score, winningScore)
      }
    }

    return players.filter { $0.score == winningScore }
  }

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

extension Player: Equatable {
  static func == (lhs: Player, rhs: Player) -> Bool {
    lhs.name == rhs.name && lhs.score == rhs.score
  }
}

enum GameState {
  case setup
  case playing
  case gameOver
}
