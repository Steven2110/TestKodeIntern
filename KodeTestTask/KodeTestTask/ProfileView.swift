//
//  DetailView.swift
//  KodeTestTask
//
//  Created by Steven Wijaya on 14.11.2021.
//

import SwiftUI

extension Date {
    var age: Int { Calendar.current.dateComponents([.year], from: self, to: Date()).year! }
}

func countAge(dayOfBirth:String)->Int{
    let birthDay = dayOfBirth.components(separatedBy: "-")

    let year    = Int(birthDay[0])
    let month = Int(birthDay[1])
    let date = Int(birthDay[2])

    

    let dob = DateComponents(calendar: .current, year: year, month: month, day: date).date!
    return dob.age
}

func formatDate(dayOfBirth:String)->String{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let showdate = formatter.date(from: dayOfBirth)
    
    formatter.dateFormat = "dd MMMM yyyy"
    let result = formatter.string(from: showdate!)
    
    return result
}

struct ProfileView: View {
    var fName:String
    var lName:String
    var url_pp:String
    var role:String
    var birthday:String
    var phone:String
    var tag:String
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    AsyncImage(url: URL(string: url_pp), scale: 1)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white))
                    HStack(alignment: .lastTextBaseline){
                        Text(fName)
                            .font(.title)
                        .fontWeight(.bold)
                        Text(lName)
                            .font(.title)
                        .fontWeight(.bold)
                        Text(tag)
                            .font(.caption2)
                    }
                    Text(role)
                        .font(.caption)
                        .fontWeight(.regular)
                }
                Divider()
                VStack{
                    HStack(alignment: .lastTextBaseline, spacing: 15){
                        Image(systemName: "star")
                            .frame(width: 20.03, height: 19.13, alignment: .trailing)
                            .padding([.leading, .bottom, .trailing])
                        let date = String(formatDate(dayOfBirth: birthday))
                        Text(date)
                            .fontWeight(.semibold)
                            .padding([.bottom, .trailing])
                        Spacer()
                        let age = String(countAge(dayOfBirth: birthday))
                        Text(age)
                            .fontWeight(.light)
                            .padding()
                            .font(.body)
                            .foregroundColor(Color.gray)
                    }
                    Divider()
                    HStack(alignment: .lastTextBaseline, spacing: 15){
                        Image(systemName: "phone")
                            .frame(width: 20.03, height: 19.13, alignment: .trailing)
                            .padding([.leading, .bottom, .trailing])
//                        Text("PHONE NUMBER")
//                            .fontWeight(.semibold)
//                            .padding([.bottom, .trailing])
                        Link(phone, destination: URL(string: phone)!)
                        Spacer()
                    }
                    Divider()
                }
                Spacer()
            }
            .navigationTitle(Text(""))
            .navigationBarHidden(true)
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
////        ProfileView(name, role, birthday, phone)
//    }
//}
