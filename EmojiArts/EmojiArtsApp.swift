//
//  EmojiArtsApp.swift
//  EmojiArts
//
//  Created by Guru Mahan on 23/12/22.
//

import SwiftUI

@main
struct EmojiArtsApp: App {
    let document = EmojiAtrsViewModel()
    var body: some Scene {
        WindowGroup {
            EmojiArtsView(document:document)
        }
    }
}
