//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Mike Camara on 12/1/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI
import Foundation

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            UIApplication.shared.endEditing()
        }
        
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.showsCancelButton = true
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
}

struct LandmarkList: View {
    private func endEditing() {
           UIApplication.shared.endEditing()
    }
    @ObservedObject var observed = Observer()
    @State private var searchTerm: String = ""
    @State private var showingAlert = false
    @State private var showingActionSheet = false
    @State var isPresented: Bool = false

    
    var body: some View {
        VStack{
            NavigationView {
                VStack {
                    SearchBar(text: $searchTerm)
                    List(self.observed.countriesDataObserver.filter {
                        self.searchTerm.isEmpty ? true : $0.country.localizedCaseInsensitiveContains(self.searchTerm) }, id: \.country) {  session in
                                NavigationLink(destination:CountryDetail(country: session)) {
                                    CountryRow(country: session)
                                }
                            }
                            .navigationBarTitle(Text("Countries"))
                            .navigationBarItems(trailing:
                                HStack {
                                    Button(
                                        action: {
                                            self.showingActionSheet = true
                                            UIApplication.shared.endEditing()
                                        }
                                    ) {
                                                    Image(systemName: "line.horizontal.3.decrease.circle.fill")
                                                        .resizable()
                                                    .frame(width: 30.0, height: 30.0)
                                        }.actionSheet(isPresented: $showingActionSheet) {
                                            ActionSheet(title: Text("Order By"), buttons: [
                                                    .default(Text("Cases"), action: {
                                                        self.observed.loadData()
                                                    }),
                                                    .default(Text("Death"), action: {
                                                         self.observed.loadDeath()
                                                     }),
                                                    .default(Text("Active"), action: {
                                                        self.observed.loadActive()
                                                    }),
                                                    .default(Text("Recovered"), action: {
                                                        self.observed.loadRecovered()
                                                    }),
                                                    .default(Text("Critical"), action: {
                                                        self.observed.loadCritical()
                                                    }),
                                                    .default(Text("Today's Cases"), action: {
                                                        self.observed.loadTodaysCases()
                                                    }),
                                                    .default(Text("Today's Deaths"), action: {
                                                        self.observed.loadToadaysDeaths()
                                                    }),
                                                    .default(Text("More Info")) {
                                                        self.isPresented = true
                                                    },
                                                    .cancel()
                                                ])
                                            }
                                    .navigationBarTitle(Text("Home"))
                                    .sheet(isPresented: $isPresented, content: {
                                        CoronaDetail()
                                    })
                                    }
                            )
                    }
                }
        }
    }
    private func actionSheet() -> ActionSheet {
        let button = ActionSheet.Button.default(Text("Show modal")) {
            self.showingActionSheet = false
        }
        let actionSheet = ActionSheet(title: Text("Action Sheet"),
                                      message: nil,
                                      buttons: [button])
        return actionSheet
    }
    
    func checkInternet() {
        var text = ""
        if Reachability.isConnectedToNetwork(){
//            print("Internet Connection Available!")
//             Text("Internet Connection not Available")
            
        }else{
            print("Internet Connection not Available!")
            text = "Internet Connection not Available"
        }
    }
}
//        var arrayOfCasesPerDay: [Double] = []
//        var arrayOfCases:  [[String: Int?]] = [[:]]
//        var readyArray: [Date: Int?] = [:]
//        var firstDate = ""
//        var lastDate = ""
//        var symbol = ""
//         var dates = ""

   
//        if (arrayOfCases.count > 1){
//            let casesSorted = arrayOfCases.reduce([String : Int]()) { acc, d in
//              var dx = acc
//              for entry in d {
//                let key = entry.key
//                guard dx[key] == nil else {
//                    dx[key]! += entry.value ?? 0
//                  continue
//                }
//                dx[entry.key] = entry.value
//              }
//              return dx
//            }
//
//            var convertedArray: [Date: Int] = [:]
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MM/dd/yy"// yyyy-MM-dd"
//            for dat in casesSorted {
//                let date = dateFormatter.date(from: dat.key)
//                if let date = date {
//                    convertedArray[date] = dat.value
//                }
//            }
//            let ready = convertedArray.sorted(by: { $0.key.compare($1.key) == .orderedAscending })
//            for caseSorted in ready {
//                arrayOfCasesPerDay.append(Double(caseSorted.value))
//            }
//
//            let formatter = DateFormatter()
//            formatter.dateFormat = "MM/dd/yy"
//
//            let myfirstDate = formatter.string(from: ready[0].key) // string purpose I add here
//            let yourDate = formatter.date(from: myfirstDate)
//            formatter.dateFormat = "dd MMM yyyy"
//            let myStringafd = formatter.string(from: yourDate!)
//            firstDate = myStringafd
//
//            var totalCount = ready.count - 1
//            let myLastDate = formatter.string(from: ready[totalCount].key) // string purpose I add here
//            let yourDatemyLastDate = formatter.date(from: myLastDate)
//            formatter.dateFormat = "dd MMM yyyy"
//            let mymyLastDatefd = formatter.string(from: yourDatemyLastDate!)
//            lastDate = mymyLastDatefd
//
//            var lastItem = arrayOfCasesPerDay.count - 1
//                 var secondLastItem = arrayOfCasesPerDay.count - 2
//                 var percentage = (arrayOfCasesPerDay[lastItem] * 100) / arrayOfCasesPerDay[secondLastItem]
//                 percentage = percentage - 100
//                 if (percentage > 0 ){
//                     symbol = "🔼" + " " + "\(String(format: "%.1f", percentage))%"
//                 } else if (percentage < 0 ) {
//                      symbol = "🔽" + " " + "\(String(format: "%.1f", percentage))%"
//                 } else {
//                     symbol = " - 0 new cases since yesterday"
//                 }
//
//
//
//                 dates = firstDate + " to " + lastDate
//
//        }
//
//
//        return LineView(data: arrayOfCasesPerDay, title: "\(self.country.todayCases)", legend:"Cases Today " + symbol + "\n" + dates)
//    }
//}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct Background<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        Color.white
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .overlay(content)
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)

        }
    }
}
