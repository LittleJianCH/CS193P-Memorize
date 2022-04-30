//
//  MemorizeApp.swift
//  Memorize
//
//  Created by LittleJian on 4/2/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
