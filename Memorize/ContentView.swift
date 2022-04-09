//
//  ContentView.swift
//  Memorize
//
//  Created by LittleJian on 4/2/22.
//

import SwiftUI

func sayHi(name: String) -> String {
    return "Hi, \(name)"
}

struct ContentView: View {
    let emojis = ["😺", "🥷", "🦊", "🧤", "👨🏻‍🦯"]
    @State var emojiCount = 3
    
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self, content: { emoji in
                        CarView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    })
                }
            }
            Spacer()
            HStack {
                removeButtom
                Spacer()
                addButtom
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
    }
    
    var removeButtom: some View {
        Button(action: {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        }, label: {
            Image(systemName: "minus.circle.fill")
        })
    }
    
    var addButtom: some View {
        Button(action: {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        }, label: {
            Image(systemName: "plus.circle.fill")
        })
    }
}

struct CarView: View {
    @State var isFaceUp: Bool = true
    
    var content: String
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 25)
        
        ZStack {
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                
                shape.strokeBorder(lineWidth: 3).foregroundColor(.cyan)
                
                Text(content).font(.largeTitle)
            } else {
                shape.fill().foregroundColor(.cyan)
            }
        }
        .padding()
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
