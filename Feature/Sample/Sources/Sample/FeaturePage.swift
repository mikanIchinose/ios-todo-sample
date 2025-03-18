//
//  FeaturePage.swift
//  Sample
//
//  Created by 一瀬喜弘 on 2025/03/18.
//

import SwiftUI

struct FeaturePage: View {
  var body: some View {
    VStack(spacing: 30) {
      Text("Feature")
        .font(.title)
        .fontWeight(.semibold)
        .padding(.bottom)
        .padding(.top, 100)
      FeatureCard(
        iconName: "person.2.crop.square.stack.fill",
        description: "A multiline description about a feature paired with the image on the left.")
      FeatureCard(iconName: "quote.bubble.fill", description: "Short summary")
      Spacer()
    }
    .padding()
  }
}

#Preview {
  FeaturePage()
    .frame(maxHeight: .infinity)
    .background(Gradient(colors: gradientColors))
    .foregroundStyle(.white)
}
