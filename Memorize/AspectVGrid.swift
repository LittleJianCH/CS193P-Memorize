//
//  AspectVGrid.swift
//  CS193P-Memorize
//
//  Created by LittleJian on 7/29/22.
//

import SwiftUI

struct AspectVGrid<Item, ItemView> : View where ItemView : View, Item : Identifiable {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView

    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width = fitWidth(itemCount: items.count, size: geometry.size, aspectRatio: aspectRatio)

            VStack {
                LazyVGrid(columns: [adaptiveGridItem(to: width)], spacing: 0) {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    private func adaptiveGridItem(to width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func fitWidth(itemCount: Int, size: CGSize, aspectRatio: CGFloat) -> CGFloat {
        var colCount: Int = 1
        var rowCount: Int = itemCount

        repeat {
            let width = size.width / CGFloat(colCount)
            let height = width / aspectRatio

            if height * CGFloat(rowCount) < size.height {
                return width
            }

            colCount += 1
            rowCount = (itemCount + colCount - 1) / colCount
        } while rowCount > 1

        return size.height * aspectRatio
    }
}
