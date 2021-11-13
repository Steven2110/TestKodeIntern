//
//  DataImport.swift
//  KodeTestTask
//
//  Created by Steven Wijaya on 12.11.2021.
//

import SwiftUI

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
            VStack{
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
                    ForEach(dataModel.users, id:\.self){ user in
                        HStack(spacing: 50){
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
            }
            .onAppear {
                dataModel.fetch()
            }
        }
}

struct DataImportView_Previews: PreviewProvider{
    static var previews: some View{
        DataImport()
    }
}
