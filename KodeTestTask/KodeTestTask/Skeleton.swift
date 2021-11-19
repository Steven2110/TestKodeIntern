//
//  ContentView.swift
//  KodeTestTask
//
//  Created by Steven Wijaya on 09.11.2021.
//

import SwiftUI

let departments = ["Все", "Design", "Analyst", "iOS", "Android", "Management", "QA", "Back office", "Frontend", "Backend", "HR", "PR", "Support"]

struct Skeleton: View {
    @State private var name:String = ""
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $name)
            }.padding().overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.5))
            ScrollView(.horizontal){
                HStack(){
                    ForEach(departments, id:\.self){ department in
                        Text(department).padding(.all)
                    }
                }
            }
            ScrollView(.vertical){
                VStack{
                    ForEach(1..<9){_ in
                        HStack
                        {
                             
                            Image("Icon")
                                .resizable()
                                .frame(width: 85, height: 85)
                                .clipShape(Circle())
                                .padding()
                            VStack(spacing: 8){
                                Text("aaaaaaaaaaaaaaaaaaaa")
                                Text("aaaaaaaaaaaaaaaaaaaa")
                            }
                            Spacer()
                        }
                        .redacted(reason: .placeholder)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct SkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        Skeleton()
    }
}
