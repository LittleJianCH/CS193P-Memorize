//
//  MemoryGame.swift
//  Memorize
//
//  Created by LittleJian on 4/22/22.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, creatCardContent: (Int) -> CardContent) {
        cards = (0..<numberOfPairsOfCards).flatMap { i in
            [ Card(content: creatCardContent(i))
            , Card(content: creatCardContent(i))]
        }
    }

    func choose(_ card: Card) {
        // to be implemented
    }

    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
