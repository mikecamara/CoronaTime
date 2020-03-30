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
