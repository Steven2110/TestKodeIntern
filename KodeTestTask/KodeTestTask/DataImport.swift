//
//  DataImport.swift
//  KodeTestTask
//
//  Created by Steven Wijaya on 12.11.2021.
//

import SwiftUI

var filters = [
    FilterItem(title: "By name", checked: true),
    FilterItem(title: "By birthday", checked: false)
]

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

struct home : View{
    var body: some View{
        VStack{
            Text("HEY")
        }
    }
}

struct topBar : View{
    @Binding var isShowing : Bool
    @State var name : String = ""
    @State var tabName : String = "Все"
    var body: some View{
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search", text: $name)
            Spacer()
            Button {
                isShowing.toggle()
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
            }

        }.padding().overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.5))
        ScrollView(.horizontal, showsIndicators: true){
            HStack{
                ForEach(departments, id:\.self){ department in
                    Button {
                        tabName = department
                    } label: {
                        VStack{
                            Text(department).padding([.horizontal, .top])
                            if(department == tabName){
                                Capsule().frame(width: 75, height: 2)
                            }
                        }
                    }
                }
            }
        }
    }
}

//Radio button
struct cardView : View{
    @State var selected : String = "By name"
    @Environment(\.colorScheme) var colorScheme
    var body : some View{
        ForEach(filters, id:\.self){ filter in
            Button {
                self.selected = filter.title
                let i : Int = filter.title=="By name" ? 0 : 1
                let j : Int = filter.title=="By name" ? 1 : 0
                filters[i].checked = !filters[i].checked
                filters[j].checked = !filters[j].checked
            } label: {
                HStack(alignment: .center, spacing: 12){
                    Circle()
                        .stroke(Color.init(red: 102/255, green: 52/255, blue: 255/255), lineWidth: self.selected==filter.title ? 12 : 4)
                        .frame(width: 25, height: 25)
                    Text(filter.title).foregroundColor((colorScheme == .dark) ? Color.white : Color.black)
                    Spacer()
                }
                .padding(.horizontal, 40)
            }
        }
    }
}

func formatDate2(dayOfBirth:String)->String{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let showdate = formatter.date(from: dayOfBirth)
    
    formatter.dateFormat = "dd-MM-yy"
    let result = formatter.string(from: showdate!)
    
    return result
}

struct DataImport : View{
    @StateObject var dataModel = DataModel()
    @State var isShowing = false
    @State private var curHeight: CGFloat = 300
    let minHeight: CGFloat = 300
    let maxHeight: CGFloat = 500
    let startOpacity: Double = 0.4
    let endOpacity: Double = 0.8
    var dragPercentage: Double {
        let res = Double(curHeight - minHeight)/(maxHeight - minHeight)
        return max(0, min(1,res))
    }
    var body: some View{
        NavigationView{
            VStack{
                topBar(isShowing: $isShowing)
                ZStack(alignment: .bottom) {
                    let usersNameSorted = self.dataModel.users.sorted{(lhs,rhs)->Bool in
                        return (lhs.firstName <  rhs.firstName)
                    }
                    let usersBirthdaySorted = self.dataModel.users.sorted{(lhs,rhs)->Bool in
                        return (lhs.birthday <  rhs.birthday)
                    }
                    List(filters[0].checked ? usersNameSorted : usersBirthdaySorted) { user in
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
                    .refreshable{
                        do{
                            dataModel.fetch()
                        } catch {
                            dataModel.users = []
                            CriticalError()

                        }
                    }
                    .onAppear{
                        dataModel.fetch()
                    }
                    if isShowing{
                        Color
                            .black
                            .opacity(startOpacity + (endOpacity - startOpacity) * dragPercentage)
                            .ignoresSafeArea()
                            .onTapGesture { isShowing = false }
                        PopUpView()
                        .transition(.move(edge: .bottom))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
            }
            .navigationBarTitle(Text("Home"))
            .navigationBarHidden(true)
        }
    }
    
}

//struct View1: View {
//    var body: some View {
//        Text("View 1")
//    }
//}
//
//struct View2: View {
//    var body: some View {
//        Text("View 2")
//    }
//}
//
//struct TabItem: View {
//    var body: some View {
//        TabView {
//            ForEach(departments, id:\.self){ department in
//                View1().tabItem{ Label{Text(department)} icon: {
//                    Image(systemName: "list")
//                }}
//            }
//        }
//    }
//}



struct DataImportView_Previews: PreviewProvider{
    static var previews: some View{
        DataImport()
    }
}
