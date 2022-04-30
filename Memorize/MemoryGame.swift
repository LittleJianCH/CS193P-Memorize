//
//  MemoryGame.swift
//  Memorize
//
//  Created by LittleJian on 4/22/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheFaceUpCard: Int?
    
    init(numberOfPairsOfCards: Int, creatCardContent: (Int) -> CardContent) {
        cards = (0..<numberOfPairsOfCards).flatMap { i in
            [ Card(content: creatCardContent(i), id: i * 2)
            , Card(content: creatCardContent(i), id: i * 2 + 1)]
        }.shuffled()
    }

    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            var isMatched = false
            if let theOtherChosenIndex = indexOfTheFaceUpCard {
                if cards[chosenIndex].content == cards[theOtherChosenIndex].content {
                    [chosenIndex, theOtherChosenIndex].forEach { cards[$0].isMatched = true }
                    isMatched = true
                } else {
                    cards[theOtherChosenIndex].isFaceUp.toggle()
                }
            } else {
                for i in cards.indices {
                    cards[i].isFaceUp = false
                }
            }
            cards[chosenIndex].isFaceUp.toggle()
            indexOfTheFaceUpCard = isMatched ? nil : chosenIndex
        }
    }

    struct Card : Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
