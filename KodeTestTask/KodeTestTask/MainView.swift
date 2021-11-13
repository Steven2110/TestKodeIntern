//
//  MainView.swift
//  KodeTestTask
//
//  Created by Steven Wijaya on 13.11.2021.
//

import SwiftUI

struct MainView: View {
    @State var isLoading:Bool = false
    var body: some View {
        ZStack{
            if isLoading
            {
                Skeleton()
            }
            else{
                DataImport()
            }
        }
        .onAppear {
            startDataImport()
        }
    }
    func startDataImport() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            isLoading = false
        }
    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
