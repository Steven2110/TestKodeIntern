//
//  CriticalError.swift
//  KodeTestTask
//
//  Created by Steven Wijaya on 13.11.2021.
//

import SwiftUI

struct CriticalError: View {
    func refreshAgain(){
        NavigationLink(destination: MainView(), label: {})
    }
    var body: some View {
        VStack{
            Image("flying-saucer")
            Text("Какой-то сверхразум все сломал")
                .font(.title3)
                .fontWeight(.bold)
            Text("Постараемся быстро починить")
            Button(action: {refreshAgain()}) {
                Text("Попробовать снова")
            }

        }
    }
}

struct CriticalError_Previews: PreviewProvider {
    static var previews: some View {
        CriticalError()
    }
}
