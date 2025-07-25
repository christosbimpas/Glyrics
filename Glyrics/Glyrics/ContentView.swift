//
//  ContentView.swift
//  Glyrics
//
//  Created by Christos Bimpas on 25/07/2025.
//

import SwiftUI
import MusicKit
import MusicKitUI

struct ContentView: View {
    @State private var song: Song?
    @State private var showAlternateLyrics = false

    var body: some View {
        VStack(alignment: .leading) {
            if let song {
                LyricsView(song: song)
                    .frame(maxHeight: 200)

                if showAlternateLyrics {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Phonetic line 1\nPhonetic line 2")
                        Text("Word-by-word translation line 1\nWord-by-word translation line 2")
                        Text("Actual translation line 1\nActual translation line 2")
                    }
                    .padding()
                }

                Button(showAlternateLyrics ? "Hide Alternate Lyrics" : "Show Alternate Lyrics") {
                    showAlternateLyrics.toggle()
                }
                .padding(.top)
            } else {
                ProgressView()
            }
        }
        .task {
            let request = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: MusicItemID("APPLE_MUSIC_TRACK_ID"))
            if let response = try? await request.response() {
                song = response.items.first
                if let song {
                    let player = ApplicationMusicPlayer.shared
                    player.queue = [song]
                    try? await player.play()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
