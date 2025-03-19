//
//  ScoreKeeper.swift
//  Sample
//
//  Created by 一瀬喜弘 on 2025/03/18.
//

import SwiftUI

struct ScoreKeeper: View {
  @State private var scoreboard = Scoreboard()
  private var startingPoints = 0

  var body: some View {
    VStack(alignment: .leading) {
      Text("Score Keeper")
        .font(.title)
        .bold()
        .padding(.bottom)

      Grid {
        GridRow {
          Text("Player")
            .gridColumnAlignment(.leading)
          Text("Score")
        }
        .font(.headline)

        ForEach($scoreboard.players) { $player in
          GridRow {
            TextField("Name", text: $player.name)
            Text("\(player.score)")
            Stepper("\(player.score)", value: $player.score)
              .labelsHidden()
          }
        }
      }
      .padding(.vertical)

      Button("Add Player", systemImage: "plus") {
        scoreboard.players.append(Player(name: "", score: 0))
      }

      Spacer()

      switch scoreboard.state {
      case .setup:
        Button("Start Game", systemImage: "play.fill") {
          scoreboard.state = .playing
          scoreboard.resetScores(to: startingPoints)
        }
      case .playing:
        Button("End Game", systemImage: "stop.fill") {
          scoreboard.state = .gameOver
        }
      case .gameOver:
        Button("Reset Game", systemImage: "arrow.counterclockwise") {
          scoreboard.state = .setup
        }
      }
    }
    .padding()
  }
}

#Preview {
  ScoreKeeper()
}
