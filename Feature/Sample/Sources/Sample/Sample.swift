// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

let gradientColors: [Color] = [
  Color("GradientTop", bundle: .module),
  Color("GradientBottom", bundle: .module),
]

public struct Sample: View {
  public init() {}
  public var body: some View {
    TabView {
      WelcomePage()
      FeaturePage()
    }
    .background(Gradient(colors: gradientColors))
    .tabViewStyle(.page)
    .foregroundStyle(.white)
  }
}

#Preview {
  Sample()
}
