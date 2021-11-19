//
//  NotFoundView.swift
//  KodeTestTask
//
//  Created by Steven Wijaya on 19.11.2021.
//

import SwiftUI

struct NotFoundView: View {
    var body: some View {
        VStack(spacing: 15){
            Image("magnifying_glass")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.top, 180)
            Text("Мы никого не нашли")
                .bold()
                .font(.title2)
            Text("Попробуй скорректировать запрос")
                .font(.callout)
                .foregroundColor(Color.gray)
            Spacer()
        }
    }
}

struct NotFoundView_Previews: PreviewProvider {
    static var previews: some View {
        NotFoundView()
    }
}
