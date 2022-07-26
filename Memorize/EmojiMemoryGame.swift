//
//  EmojiMemoryGame.swift
//  CS193P-Memorize
//
//  Created by LittleJian on 4/22/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let themes: [Theme<String>] = [
        Theme(name: "Animals", color: .green, contents: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵"]),
        Theme(name: "Cars", color: .cyan, contents: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛", "🚜"]),
        Theme(name: "Faces", color: .yellow, contents: ["😀", "😁", "😂", "😃", "😄", "😅", "😆", "😉", "😊", "😋", "😎", "😍", "😘", "😗", "😙", "😚", "😜", "😝", "😛", "🤑", "🤓", "😏", "😶", "😐", "😑"]),
        Theme(name: "Food", color: .red, contents: ["🍞", "🥖", "🥨", "🥞", "🧀", "🍗", "🍖", "🌭", "🍔", "🍟", "🍕", "🥪", "🥙", "🌮", "🌯", "🥗", "🥘", "🥫", "🍝", "🍜", "🍲", "🍛", "🍣", "🍱"]),
        Theme(name: "Sports", color: .brown, contents: ["⚽️", "🏀", "🏈", "⚾️", "🏐", "🥏", "🎳", "🪃", "🛹", "🏓"]),
        Theme(name: "Flags", color: .mint, contents: ["🇨🇳", "🇨🇦", "🇺🇸", "🇸🇪", "🇨🇱", "🇯🇵", "🇲🇬", "🇰🇷", "🇦🇽", "🏳️‍⚧️", "🏳️‍🌈", "🇲🇴", "🇧🇷", "🇬🇧"]),
    ]
    static let numberOfPairsOfCards: Int = 8

    var state: GameState = .start

    private static func createMemoryGame() -> MemoryGame<String> {
        let theme = themes.randomElement()!
        let emojis = theme.getContents(number: numberOfPairsOfCards)
        return MemoryGame<String>(number: numberOfPairsOfCards, title: theme.themeName, color: theme.color)
        { pairIndex in
            emojis[pairIndex]
        }
    }

    @Published private(set) var modal = createMemoryGame()

    func newGame() {
        state = .running
        modal = EmojiMemoryGame.createMemoryGame()
    }

    var score: Int { modal.score }

    var tapCount: Int { modal.tapCount }

    var card: Array<Card> { modal.cards }
    
    var title: String { modal.title }

    var color: Color { modal.color }

    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        if (modal.choose(card)) {
            state = .over
        }
    }

    enum GameState {
        case start, running, over
    }
}
