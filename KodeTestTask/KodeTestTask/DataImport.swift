//
//  DataImport.swift
//  KodeTestTask
//
//  Created by Steven Wijaya on 12.11.2021.
//

import SwiftUI

//class DataModel: ObservableObject {
//    @Published var users:[value] = []
//    func fetch(){
//        let url = URL(string: "https://stoplight.io/mocks/kode-education/trainee-test/25143926/users")!
//        let task = URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//            let jsonString = String(data: data, encoding: .utf8)!
//            let jsonData = jsonString.data(using: .utf8)!
//            do {
//                let decoder = JSONDecoder()
//                let tableUsers = try decoder.decode([value].self, from: jsonData)
//                print(tableUsers)
//                DispatchQueue.main.async {
//                    self.users = tableUsers
//                }
//            } catch {
//                print(error)
//            }
//        }
//        task.resume()
//    }
//}
//
//class datas:ObservableObject{
//    @Published var jsonData :[value] = []
//    let url = URL(string: "https://stoplight.io/mocks/kode-education/trainee-test/25143926/users")!
//    init(){
//        let session = URLSession(configuration: .default)
//        session.dataTask(with: url) { data,_,error in
//            guard let data = data, error == nil else { return }
//            let jsonString = String(data: data, encoding: .utf8)!
//            let jsonDatas = jsonString.data(using: .utf8)!
//            do{
//                let fetch = try JSONDecoder().decode([value].self, from: jsonDatas)
//                print(fetch)
//                DispatchQueue.main.async {
//                    self.jsonData = fetch
//                }
//            }
//            catch{
//                print(error)
//            }
//        }.resume()
//    }
//}
//
//struct list : View{
//    var avatarURL:String
//    var firstName:String
//    var lastName:String
//    var position:String
//    var body: some View{
//        HStack{
//            AsyncImage(url: URL(string: avatarURL), scale: 1)
//                .frame(width: 85, height: 85)
//                .clipShape(Circle())
//                .overlay(Circle().stroke(Color.white))
//            VStack (alignment: .leading, spacing: 8){
//                HStack{
//                    Text(firstName).bold()
//                    Text(lastName)
//                }
//                Text(position)
//            }
//            Spacer()
//        }
//    }
//}
//
//
//struct DataImport : View{
//    @ObservedObject var dataModel = datas()
//    @StateObject var dataModels = DataModel()
//    @State var name:String = ""
//    var body: some View{
//        NavigationView{
//                VStack{
//                    HStack {
//                        Image(systemName: "magnifyingglass")
//                        TextField("Search", text: $name)
//                    }.padding().overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.5))
//                    ScrollView(.horizontal){
//                        HStack{
//                            ForEach(departments, id:\.self){ department in
//                                Text(department).padding(.all)
//                            }
//                        }
//                    }
//                    List(dataModels.users) { i in
//                        HStack{
//                            AsyncImage(url: URL(string: i.avatarUrl), scale: 1)
//                                .frame(width: 85, height: 85)
//                                .clipShape(Circle())
//                                .overlay(Circle().stroke(Color.white))
//                            VStack (alignment: .leading, spacing: 8){
//                                HStack{
//                                    Text(i.firstName).bold()
//                                    Text(i.lastName)
//                                }
//                                Text(i.position)
//                            }
//                            Spacer()
//                        }
////                        list(avatarURL: i.avatarUrl, firstName: i.firstName, lastName: i.lastName, position: i.position)
////                        NavigationLink(destination: ProfileView(name:name,role:role,birthday:birthday,phone:phone)) {
////
////                        }
//                    }
//                }.navigationBarTitle("")
//                .navigationBarHidden(true)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .refreshable{
//                    do{
//                        dataModels.fetch()
//                    } catch {
//                        dataModels.users = []
//                        CriticalError()
//
//                    }
//                }
//            }
////            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .onAppear {
//                dataModels.fetch()
//            }
//
//        }
//}
//
//struct DataImportView_Previews: PreviewProvider{
//    static var previews: some View{
//        DataImport()
//    }
//}


//import SwiftUI
//
var onboard = false


class datas:ObservableObject{
    @Published var jsonData :[value] = []
    let url = URL(string: "https://api.github.com/users/hadley/orgs")!
    func fetch(){
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data,_,error in
            guard let data = data, error == nil else { return }
            let jsonString = String(data: data, encoding: .utf8)!
            let jsonDatas = jsonString.data(using: .utf8)!
            do{
                let fetch = try JSONDecoder().decode([value].self, from: jsonDatas)
                print(fetch)
                DispatchQueue.main.async {
                    self.jsonData = fetch
                }
            }
            catch{
                print(error)
            }
        }.resume()
    }
}


class DataModel: ObservableObject {
    @Published var users: [value] = []
    func fetch(){
        let url = URL(string: "https://stoplight.io/mocks/kode-education/trainee-test/25143926/users")!
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            let jsonString = String(data: data, encoding: .utf8)!
            let jsonData = jsonString.data(using: .utf8)!
            do {
                let decoder = JSONDecoder()
                let tableUsers = try decoder.decode(Items.self, from: jsonData)
                print(tableUsers)
                DispatchQueue.main.async {
                    self.users = tableUsers.items
                }
            } catch {
                self.users=[]
                print(error)
            }
        }
        task.resume()
    }
}

struct DataImport : View{
    @StateObject var dataModel = DataModel()
    @State var name:String = ""
    var body: some View{
        NavigationView{
            VStack{
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $name)
                }.padding().overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.5))
                ScrollView(.horizontal){
                    HStack{
                        ForEach(departments, id:\.self){ department in
                            Text(department).padding(.all)
                        }
                    }
                }
                List(dataModel.users) { user in
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
                                }
                                Text(user.position)
                            }
                            Spacer()
                        }
                    }
                }
                .refreshable{
                    do{
                        dataModel.fetch()
                    } catch {
                        dataModel.users = []
                        CriticalError()

                    }
                }
            }
            .onAppear {
                dataModel.fetch()
            }
            .navigationBarTitle(Text("Home"))
            .navigationBarHidden(true)
        }
    }
}

struct DataImportView_Previews: PreviewProvider{
    static var previews: some View{
        DataImport()
    }
}
