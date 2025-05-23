//
//  FriendView.swift
//  Sample
//
//  Created by 一瀬喜弘 on 2025/03/20.
//

import SwiftData
import SwiftUI

struct BirthdaysApp: App {
  var body: some Scene {
    WindowGroup {
      FriendView()
        .modelContainer(for: Friend.self)
    }
  }
}

struct FriendView: View {
  @Query(sort: \Friend.birthday) private var friends: [Friend]
  @Environment(\.modelContext) private var context

  @State private var newName = ""
  @State private var newDate = Date.now

  var body: some View {
    NavigationStack {
      List(friends) { friend in
        HStack {
          if friend.isBirthdayToday {
            Image(systemName: "birthday.cake")
          }
          Text(friend.name)
            .bold(friend.isBirthdayToday)
          Spacer()
          Text(friend.birthday, format: .dateTime.month(.wide).day().year())
        }
      }
      .navigationTitle("Birthdays")
      .safeAreaInset(edge: .bottom) {
        VStack(alignment: .center, spacing: 20) {
          Text("New Birthday")
            .font(.headline)
          DatePicker(
            selection: $newDate, in: Date.distantPast...Date.now, displayedComponents: .date
          ) {
            TextField("Name", text: $newName)
              .textFieldStyle(.roundedBorder)
          }
          Button("Save") {
            let newFriend = Friend(name: newName, birthday: newDate)
            context.insert(newFriend)

            newName = ""
            newDate = .now
          }
          .bold()
        }
        .padding()
        .background(.bar)
      }
    }
  }
}

#Preview {
  FriendView()
    .modelContainer(for: Friend.self, inMemory: true)
}
