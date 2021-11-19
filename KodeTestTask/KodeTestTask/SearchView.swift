//
//  SearchView.swift
//  KodeTestTask
//
//  Created by Steven Wijaya on 19.11.2021.
//

import SwiftUI

struct SearchView: View {
    var user: value
    var body: some View {
        NavigationLink(destination: ProfileView(fName: user.firstName, lName: user.lastName, url_pp: user.avatarUrl, role: user.position, birthday: user.birthday, phone: user.phone, tag: user.userTag)) {
            HStack{
                AsyncImage(url: URL(string: user.avatarUrl), scale: 1)
                    .frame(width: 85, height: 85)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white))
                VStack (alignment: .leading, spacing: 8){
                    HStack{
                        Text(user.firstName).bold()
                        Text(user.lastName)
                        Text(user.userTag)
                            .font(.caption2)
                            .foregroundColor(Color.gray)
                    }
                    Text(user.position)
                }
                Spacer()
                if(filters[1].checked){
                    Text(formatDate2(dayOfBirth: user.birthday))
                }
            }
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
