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

      SettingView(
        doesHighestScoreWin: $scoreboard.doesHighestScoreWin,
        startingPoints: $startingPoints
      )
      .disabled(scoreboard.state != .setup)

      Grid {
        GridRow {
          Text("Player")
            .gridColumnAlignment(.leading)
          Text("Score")
            .opacity(scoreboard.state == .setup ? 0 : 1)
        }
        .font(.headline)

        ForEach($scoreboard.players) { $player in
          GridRow {
            HStack {
              if scoreboard.winners.contains(player) {
                Image(systemName: "crown.fill")
                  .foregroundStyle(.yellow)
              }
              TextField("Name", text: $player.name)
                .disabled(scoreboard.state != .setup)
            }
            Text("\(player.score)")
              .opacity(scoreboard.state == .setup ? 0 : 1)
            Stepper("\(player.score)", value: $player.score)
              .labelsHidden()
              .opacity(scoreboard.state == .setup ? 0 : 1)
          }
        }
      }
      .padding(.vertical)

      Button("Add Player", systemImage: "plus") {
        scoreboard.players.append(Player(name: "", score: 0))
      }
      .opacity(scoreboard.state == .setup ? 1 : 0)

      Spacer()

      HStack {
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
        Spacer()
      }
      .buttonStyle(.bordered)
      .buttonBorderShape(.capsule)
      .controlSize(.large)
      .tint(.blue)
    }
    .padding()
  }
}

struct SettingView: View {
  @Binding var doesHighestScoreWin: Bool
  @Binding var startingPoints: Int

  var body: some View {
    VStack(alignment: .leading) {
      Text("Game Rules")
        .font(.headline)
      Divider()

      Picker("Win condition", selection: $doesHighestScoreWin) {
        Text("Highest Score Wins")
          .tag(true)
        Text("Lowest Score Wins")
          .tag(false)
      }

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
  @Previewable @State var doesHighestScoreWin: Bool = true
  @Previewable @State var startingPoints = 10
  SettingView(
    doesHighestScoreWin: $doesHighestScoreWin,
    startingPoints: $startingPoints)
}
