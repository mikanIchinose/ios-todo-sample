//
//  DiceView.swift
//  Sample
//
//  Created by 一瀬喜弘 on 2025/03/18.
//

import SwiftUI

struct DiceContentView: View {
  @State private var numberOfDice: Int = 1

  var body: some View {
    VStack {
      Text("Dice Roller")
        .font(.largeTitle.lowercaseSmallCaps())
        .foregroundStyle(.white)

      HStack {
        ForEach(1...numberOfDice, id: \.description) { _ in
          DiceView()
        }
      }

      HStack {
        Button("Remove", systemImage: "minus.circle.fill") {
          withAnimation {
            numberOfDice -= 1
          }
        }
        .disabled(numberOfDice == 1)

        Button("Add", systemImage: "plus.circle.fill") {
          withAnimation {
            numberOfDice += 1
          }
        }
        .disabled(numberOfDice == 5)
      }
      .padding()
      .labelStyle(.iconOnly)
      .font(.title)
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color("AppBackground", bundle: .module))
    .tint(.white)
  }
}

struct DiceView: View {
  @State private var numberOfPips: Int = 1
  var body: some View {
    VStack {
      Image(systemName: "die.face.\(numberOfPips).fill")
        .resizable()
        .frame(maxWidth: 100, maxHeight: 100)
        .aspectRatio(1, contentMode: .fit)
        .foregroundStyle(.black, .white)

      Button("Roll") {
        withAnimation {
          numberOfPips = Int.random(in: 1...6)
        }
      }
      .buttonStyle(.bordered)
    }
  }
}

#Preview("DiceContentView") {
  DiceContentView()
}

#Preview("DiceView") {
  DiceView()
}
