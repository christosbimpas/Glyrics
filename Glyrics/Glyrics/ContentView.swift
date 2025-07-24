//
//  ContentView.swift
//  Glyrics
//
//  Created by Christos Bimpas on 25/07/2025.
//

import SwiftUI
import MusicKit

struct ContentView: View {
    @State private var song: Song?

    var body: some View {
        VStack(alignment: .leading) {
            if let song {
                LyricsView(song: song)
                    .frame(maxHeight: 200)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Phonetic line 1\nPhonetic line 2")
                    Text("Word-by-word translation line 1\nWord-by-word translation line 2")
                    Text("Actual translation line 1\nActual translation line 2")
                }
                .padding()
            } else {
                ProgressView()
            }
        }
        .task {
            let request = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: MusicItemID("APPLE_MUSIC_TRACK_ID"))
            if let response = try? await request.response() {
                song = response.items.first
            }
        }
    }
}

#Preview {
    ContentView()
}
