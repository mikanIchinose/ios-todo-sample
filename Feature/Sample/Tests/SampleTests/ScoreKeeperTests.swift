//
//  ScoreKeeperTests.swift
//  Sample
//
//  Created by 一瀬喜弘 on 2025/03/19.
//
import Testing

@testable import Sample

struct ScoreKeeperTests {
  @Test("Reset player scores", arguments: [0, 10, 20])
  func resetScores(to newValue: Int) async throws {
    var scoreboard = Scoreboard(players: [
      Player(name: "Elisha", score: 0),
      Player(name: "Andre", score: 5),
    ])
    scoreboard.resetScores(to: newValue)

    for player in scoreboard.players {
      #expect(player.score == newValue)
    }
  }
}
