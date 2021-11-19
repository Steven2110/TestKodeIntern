//
//  PopUpView.swift
//  KodeTestTask
//
//  Created by Steven Wijaya on 18.11.2021.
//

import SwiftUI

struct PopUpView: View {
    @State private var isDragging = false
    @State private var curHeight: CGFloat = 300
    @State private var prevDragTranslation = CGSize.zero
    let minHeight: CGFloat = 300
    let maxHeight: CGFloat = 500
    var body: some View{
        VStack(spacing: 18){
            Capsule()
                .frame(width: 70, height: 4)
                .padding()
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.00001))
                .gesture(dragGesture)
            Text("Sort").font(.title)
                .fontWeight(.bold)
            VStack(spacing: 20){
                cardView()
                }
                .frame(maxHeight: .infinity)
            }
            .frame(height: curHeight)
            .frame(maxWidth: .infinity)
            .background(
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                    Rectangle()
                        .frame(height: curHeight/2)
                }
                    .foregroundColor(Color(UIColor.systemBackground))
            )
            .animation(isDragging ? nil : .easeInOut(duration: 0.45))
    }
    
    //gesture
    
    var dragGesture: some Gesture{
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged{
                val in
                if !isDragging {
                    isDragging = true
                }
                let dragAmount = val.translation.height - prevDragTranslation.height
                if curHeight > maxHeight || curHeight < minHeight {
                    curHeight -= dragAmount/6
                } else {
                    curHeight -= dragAmount
                }
                prevDragTranslation = val.translation
            }
            .onEnded{
                val in
                prevDragTranslation = .zero
                isDragging = false
                if curHeight > maxHeight {
                    curHeight = maxHeight
                } else if curHeight < minHeight {
                    curHeight = minHeight
                }
            }
    }
}

struct PopUpView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpView()
    }
}
