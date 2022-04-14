//
//  ContentView.swift
//  Memorize
//
//  Created by LittleJian on 4/2/22.
//

import SwiftUI

struct ContentView: View {
    let emojiThemes = [
        ["😀", "😝", "😤", "😕", "😭", "😎", "🫥", "😱"],
        ["🦧", "🦇", "🐊", "🐌", "🦂", "🐅", "🦬", "🦥", "🐫", "🐍"],
        ["🏀", "🏓", "🧗‍♂️", "🏈", "🥋", "🥌"]
    ]
    
    @State var emojis: [String] = []
    
    var body: some View {
        VStack {
            Text("Momorize!").font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(emojis, id: \.self, content: { emoji in
                        CarView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    })
                }
            }
            Spacer()
            HStack {
                faceThemeButtom
                Spacer()
                animalThemeButtom
                Spacer()
                sportThemeButtom
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
    }
    
    var faceThemeButtom: some View {
        Button(action: {
            emojis = emojiThemes[0].shuffled()
        }, label: {
            VStack {
                Text("Face").font(.body)
                Image(systemName: "face.smiling")
            }
        })
    }
    
    var animalThemeButtom: some View {
        Button(action: {
            emojis = emojiThemes[1].shuffled()
        }, label: {
            VStack{
                Text("Animal").font(.body)
                Image(systemName: "pawprint")
            }
        })
    }
    
    var sportThemeButtom: some View {
        Button(action: {
            emojis = emojiThemes[2].shuffled()
        }, label: {
            VStack {
                Text("Sport").font(.body)
                Image(systemName: "sportscourt")
            }
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
