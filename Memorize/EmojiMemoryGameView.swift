//
//  EmojiMemoryGameView.swift
//  CS193P-Memorize
//
//  Created by LittleJian on 4/2/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame

    var body: some View {
        VStack {
            switch game.state {
            case .start: GameStartView(viewModel: game)
            case .running: GameRunningView(viewModel: game)
            case .over: GameOverView(viewModel: game)
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
    let card: EmojiMemoryGame.Card
    let color: Color

    var body: some View {
        GeometryReader { geometry in
            let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)

            ZStack {
                if card.isMatched {
                    shape.opacity(0)
                } else if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: Constants.lineWidth).foregroundColor(color)
                    Text(card.content).font(adjust(to: geometry.size))
                } else {
                    shape.fill().foregroundColor(color)
                }
            }
        }
    }

    private func adjust(to size: CGSize) -> Font {
        .system(size: Constants.fontScale * min(size.width, size.height))
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 25
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.65
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .previewInterfaceOrientation(.portrait)
    }
}
