//
//  ContentView.swift
//  CS193P-Memorize
//
//  Created by LittleJian on 4/2/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            switch viewModel.state {
            case .start: GameStartView(viewModel: viewModel)
            case .running: GameRunningView(viewModel: viewModel)
            case .over: GameOverView(viewModel: viewModel)
            }
        }
    }
}

struct GameStartView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            Spacer()
            Button {
                viewModel.newGame()
            } label: {
                HStack {
                    Text("Start")
                    Image(systemName: "arrowtriangle.right.circle.fill")
                }.font(.largeTitle)
            }
            Spacer()
        }
    }
}

struct GameRunningView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        Text(viewModel.title).font(.largeTitle)
            .onTapGesture {
                viewModel.newGame()
            }
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(viewModel.card) { card in
                    CardView(card: card, color: viewModel.color)
                        .aspectRatio(2 / 3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }.padding()
        }
    }
}

struct GameOverView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            Spacer()
            Text("Game Over").font(.largeTitle)
            Text("You used \(viewModel.tapCount) taps to finish the game.")
            Text("And you got \(viewModel.score) points.")
            Spacer()
            Button("Restart") {
                viewModel.newGame()
            }
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    let color: Color

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 25)

        ZStack {
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3).foregroundColor(color)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill().foregroundColor(color)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(viewModel: game)
            .previewInterfaceOrientation(.portrait)
    }
}
