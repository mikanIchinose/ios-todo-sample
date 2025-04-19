import SwiftData
//
//  FriendsFavoriteMovies.swift
//  Sample
//
//  Created by 一瀬喜弘 on 2025/03/20.
//
import SwiftUI

struct FriendsFavoriteMovies: View {
  var body: some View {
    TabView {
      Tab("Friends", systemImage: "person.and.person") {
        FriendList()
      }

      Tab("Movies", systemImage: "film.stack") {
        MovieList()
      }
    }
  }
}

struct FriendList: View {
  @Query(sort: \Friend.name) private var friends: [Friend]
  @Environment(\.modelContext) private var context

  var body: some View {
    NavigationSplitView {
      List {
        ForEach(friends) { friend in
          NavigationLink(friend.name) {
            Text(friend.name)
              .navigationTitle("Friend")
              .navigationBarTitleDisplayMode(.inline)
          }
        }
      }
      .navigationTitle("Friends")
    } detail: {
      Text("Select a friend")
        .navigationTitle("Friend")
        .navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct MovieList: View {
  @Query(sort: \Movie.title) private var movies: [Movie]
  @Environment(\.modelContext) private var context

  var body: some View {
    NavigationSplitView {
      List {
        ForEach(movies) { movie in
          NavigationLink(movie.title) {
            VStack(alignment: .leading, spacing: 8) {
              Text(movie.title)
                .font(.title2)
                .bold()
              Text(movie.releaseDate, style: .date)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .padding()
            .navigationTitle("Movie")
            .navigationBarTitleDisplayMode(.inline)
          }
        }
      }
      .navigationTitle("Movies")
    } detail: {
      Text("Select a movie")
        .navigationTitle("Movie")
        .navigationBarTitleDisplayMode(.inline)
    }
  }
}

@MainActor
class SampleData {
  static let shared = SampleData()
  let modelContainer: ModelContainer
  var context: ModelContext {
    modelContainer.mainContext
  }

  private init() {
    let schema = Schema([
      Friend.self,
      Movie.self,
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

    do {
      modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
      insertSampleData()
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }

  private func insertSampleData() {
    for friend in Friend.sampleData {
      context.insert(friend)
    }
    for movie in Movie.sampleData {
      context.insert(movie)
    }
  }
}

#Preview {
  FriendsFavoriteMovies()
    .modelContainer(SampleData.shared.modelContainer)
}

#Preview {
  FriendList()
    .modelContainer(for: Friend.self, inMemory: true)
}
