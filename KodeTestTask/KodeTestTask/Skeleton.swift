//
//  ContentView.swift
//  KodeTestTask
//
//  Created by Steven Wijaya on 09.11.2021.
//

import SwiftUI

struct Skeleton: View {
    @State private var name:String = ""
    let departments = ["Все", "Designers", "Analyst", "iOS", "Android", "Management", "QA", "Back office", "Frontend", "Backend", "HR", "PR", "Support"]
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
                            Circle().fill(Color.gray).frame(width: 90, height: 90, alignment: .leading).padding(.leading)
                            VStack(spacing: 8){
                                Text("aaaaaaaaaaaaaaaaaaaa").redacted(reason: .placeholder)
                                Text("aaaaaaaaaaaaaaaaaaaa").redacted(reason: .placeholder)
                            }
                            Spacer()
                        }
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
