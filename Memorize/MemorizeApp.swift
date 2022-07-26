//
//  MemorizeApp.swift
//  CS193P-Memorize
//
//  Created by LittleJian on 4/2/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
