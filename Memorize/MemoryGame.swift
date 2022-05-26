//
//  MemoryGame.swift
//  CS193P-Memorize
//
//  Created by LittleJian on 4/22/22.
//

import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheFaceUpCard: Int?

    let title: String
    let color: Color
    var numberOfExistingCards: Int
    var tapCount: Int = 0
    var score: Int = 0

    init(number: Int, title: String, color: Color, creatCardContent: (Int) -> CardContent) {
        cards = (0..<number).flatMap { i in
            [ Card(content: creatCardContent(i), id: i * 2)
            , Card(content: creatCardContent(i), id: i * 2 + 1)]
        }.shuffled()
        self.title = title
        self.color = color
        numberOfExistingCards = number
    }

    mutating func choose(_ card: Card) -> Bool {
        // return true if the game is over
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            var isMatched = false
            if let theOtherChosenIndex = indexOfTheFaceUpCard {
                if cards[chosenIndex].content == cards[theOtherChosenIndex].content {
                    [chosenIndex, theOtherChosenIndex].forEach { cards[$0].isMatched = true }
                    isMatched = true
                    numberOfExistingCards -= 1
                    score += 2
                } else {
                    cards[theOtherChosenIndex].isFaceUp.toggle()
                }
            } else {
                for i in cards.indices {
                    cards[i].isFaceUp = false
                }
            }

            if (cards[chosenIndex].isFlipped) {
                score -= 1;
            }
            tapCount += 1

            cards[chosenIndex].isFlipped = true
            cards[chosenIndex].isFaceUp.toggle()
            indexOfTheFaceUpCard = isMatched ? nil : chosenIndex
        }
        return numberOfExistingCards == 0
    }

    struct Card : Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isFlipped: Bool = false
        var content: CardContent
        var id: Int
    }
}

struct Theme<Content> where Content: Equatable {
    let themeName: String
    private let contents: [Content]
    let color: Color

    func getContents(number: Int) -> [Content] {
        Array(contents.shuffled().prefix(number))
    }

    init(name: String, color: Color, contents: [Content]) {
        themeName = name
        self.contents = contents
        self.color = color
    }
}
