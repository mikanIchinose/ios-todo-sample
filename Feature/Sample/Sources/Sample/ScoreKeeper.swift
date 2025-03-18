//
//  ScoreKeeper.swift
//  Sample
//
//  Created by 一瀬喜弘 on 2025/03/18.
//

import SwiftUI

struct Player: Identifiable {
    let id = UUID()

    var name: String
    var score: Int
}

struct ScoreKeeper: View {
    @State private var players: [Player] = [
        Player(name: "Elisha", score: 0),
        Player(name: "Andre", score: 0),
        Player(name: "Jasmine", score: 0),
    ]

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

                ForEach($players) { $player in
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
                players.append(Player(name: "", score: 0))
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ScoreKeeper()
}
