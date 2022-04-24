//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by LittleJian on 4/22/22.
//

import SwiftUI

class EmojiMemoryGame {
    static let emojis = ["👻", "🎃", "🕷", "🦇", "🍎", "🍬", "🍭", "🍒", "🍇", "🍉", "🍓", "🍑", "🍈"]

    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = EmojiMemoryGame.emojis
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            emojis[pairIndex]
        }
    }

    private(set) var modal = createMemoryGame()

    var card: Array<MemoryGame<String>.Card> {
        return modal.cards
    }
}
