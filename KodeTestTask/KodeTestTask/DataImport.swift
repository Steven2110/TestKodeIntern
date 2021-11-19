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

var departmentUser = [
    "Android" : "android",
    "iOS" : "ios",
    "Design" : "design",
    "Management" : "management",
    "QA" : "qa",
    "Back Office" : "back_office",
    "Frontend" : "frontend",
    "HR" : "hr",
    "PR" : "pr",
    "Backend" : "backend",
    "Support" : "support",
    "Analyst" : "analytics",
    "Все" : ""
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
    @Binding var tabName : String
    @Binding var name : String
    @State  var defVal = "Все"
    @Environment(\.colorScheme) var colorScheme
    var body: some View{
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search", text: $name)
            Spacer()
            Button {
                isShowing.toggle()
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .foregroundColor(Color.init(red: 102/255, green: 52/255, blue: 255/255))
            }

        }.padding().overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.5))
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(departments, id:\.self){ department in
                    Button {
                        tabName = departmentUser[department]!
                        defVal = department
                    } label: {
                        VStack{
                            Text(department).padding([.horizontal, .top])
                                .foregroundColor((colorScheme == .dark) ? Color.white : Color.black)
                            if(department == defVal){
                                Capsule().frame(width: 75, height: 2)
                                    .foregroundColor(Color.init(red: 102/255, green: 52/255, blue: 255/255))
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
    @State var tabBar : String = ""
    @State var name : String = ""
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
                topBar(isShowing: $isShowing, tabName: $tabBar, name: $name)
                ZStack(alignment: .bottom) {
                    let usersNameSorted = self.dataModel.users.sorted{(lhs,rhs)->Bool in
                        return (lhs.firstName <  rhs.firstName)
                    }
                    let usersBirthdaySorted = self.dataModel.users.sorted{(lhs,rhs)->Bool in
                        return (lhs.birthday <  rhs.birthday)
                    }
                    List(filters[0].checked ? usersNameSorted : usersBirthdaySorted) { user in
                        if (tabBar == user.department){
                            if(name == ""){
                                SearchView(user: user)
                            }
                            else if (user.firstName.contains(name)){
                                SearchView(user: user)
                            }
                            else if (!user.firstName.contains(name)){
                                ZStack(alignment: .center){
                                    Rectangle().frame(width: 360, height: 600).foregroundColor(Color.white)
                                    NotFoundView()
                                }
                            }
                        }
                        else if (tabBar == ""){
                            if(name == ""){
                                SearchView(user: user)
                            }
                            else if (user.firstName.contains(name)){
                                SearchView(user: user)
                            }
                            else if (!user.firstName.contains(name)){
                                ZStack(alignment: .center){
                                    Rectangle().frame(width: 360, height: 600).foregroundColor(Color.white)
                                    NotFoundView()
                                }
                            }
                        }
                    }
                    .listStyle(.grouped)
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
//                    if notFound{
//                        NotFoundView()
//                    }
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

struct DataImportView_Previews: PreviewProvider{
    static var previews: some View{
        DataImport()
    }
}
