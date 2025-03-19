//
//  ScoreKeeper.swift
//  Sample
//
//  Created by 一瀬喜弘 on 2025/03/18.
//

import SwiftUI

struct ScoreKeeper: View {
  @State private var scoreboard = Scoreboard()
  @State private var startingPoints = 0

  var body: some View {
    VStack(alignment: .leading) {
      Text("Score Keeper")
        .font(.title)
        .bold()
        .padding(.bottom)

      SettingView(startingPoints: $startingPoints)

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

struct SettingView: View {
  @Binding var startingPoints: Int

  var body: some View {
    VStack(alignment: .leading) {
      Text("Game Rules")
        .font(.headline)
      Divider()
      Picker("Starting points", selection: $startingPoints) {
        Text("0 starting points")
          .tag(0)
        Text("10 starting points")
          .tag(10)
        Text("20 starting points")
          .tag(20)
      }
    }
    .padding()
    .background(.thinMaterial, in: .rect(cornerRadius: 10.0))
  }
}

#Preview {
  ScoreKeeper()
}

#Preview {
  @Previewable @State var startingPoints = 10
  SettingView(startingPoints: $startingPoints)
}
