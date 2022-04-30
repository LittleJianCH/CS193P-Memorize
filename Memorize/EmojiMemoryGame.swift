//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by LittleJian on 4/22/22.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    static let emojis = ["👻", "🎃", "🕷", "🦇", "🍎", "🍬", "🍭", "🍒", "🍇", "🍉", "🍓", "🍑", "🍈"]

    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = EmojiMemoryGame.emojis[0..<8]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            emojis[pairIndex]
        }
    }

    @Published private(set) var modal = createMemoryGame()

    var card: Array<MemoryGame<String>.Card> {
        return modal.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        modal.choose(card)
    }
}
