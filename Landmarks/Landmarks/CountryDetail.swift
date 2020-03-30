//
//  CountryDetail.swift
//  Landmarks
//
//  Created by Mike Camara on 27/3/20.
//  Copyright © 2020 Apple. All rights reserved.
//
import CoreLocation
import SwiftUI
import SwiftUICharts
import Network


struct CountryDetail: View {
    var country: Country
    @State private var showShareSheet = false
    @State public var sharedItems : [Any] = []
    @ObservedObject var observed = Observer()

    var body: some View {
                ScrollView {
            VStack {
                MapView(coordinate: returnLocation2D(latitude: country.countryInfo.lat ?? 0.0, longitude: country.countryInfo.long ?? 0.0))
                .edgesIgnoringSafeArea(.top)
                              .frame(height: 170)
                
                Circle()
                .fill(Color.white)
                .frame(width: 145, height: 75)
                            .offset(x: 0, y: -50)
                                       .padding(.bottom, -30)
                
                Text(flag(country: country.countryInfo.iso2 ?? ""))
                .frame(width: 140, height: 70, alignment: .center)
                .padding()
                .overlay(
                    Circle()
                    .stroke(Color.primary, lineWidth: 3)
                    .padding(12)
                )
                .offset(x: 0, y: -130)
                .padding(.bottom, -100)
                .font(.system(size: 60))
                .shadow(radius: 10)
                
                VStack(alignment: .center) {
                    Text(country.country)
                    .font(.largeTitle)
                        CasesRow(country: country)
                        DeathsRow(country: country)
                        ActiveRow(country: country)
                        RecoveredRow(country: country)
                        CriticalRow(country: country)
                }.padding()
                .offset(x: 0, y: -20)
                VStack {
                    getArrayOfCases()


                }.padding([.horizontal], 30)
                Divider()
                VStack {
                    getArrayOfDeaths()

                }.padding([.horizontal], 30)
                
               
                
            }.frame(height: 1400)
//            .padding()
                    
        }// scrollview
        .navigationBarTitle(Text(country.country), displayMode: .inline)
        .navigationBarItems(trailing:
          HStack {
              Button(
                  action: {
                     print("TEst")
                    let text = flag(country: self.country.countryInfo.iso2 ?? "") + " " + self.country.country + " - Coronavirus Covid-19" +
                        "\n Cases: " + "\(self.country.cases)" + "\n" +
                        "Deaths: " + "\(self.country.deaths)" + "\n" +
                        "Active: " + "\(self.country.active)" + "\n" +
                        "Recovered: " + "\(self.country.recovered)" + "\n" +
                        "Critical: " + "\(self.country.critical)" + "\n" +
                        "Today's Cases: " + "\(self.country.todayCases)" + "\n" +
                        "Today's Deaths: " + "\(self.country.todayDeaths)" 
                    self.sharedItems = [text]
                    self.showShareSheet = true
                  }
              ) {
                          Image(systemName: "square.and.arrow.up").imageScale(.large)
              }.sheet(isPresented: $showShareSheet) {
                  ShareSheet(activityItems: self.sharedItems)
              }
            }
        )   
    }
    
    func getArrayOfCases() -> LineView {
        var arrayOfCasesPerDay: [Double] = []
        var arrayOfCases:  [[String: Int?]] = [[:]]
        var readyArray: [Date: Int?] = [:]
        var firstDate = ""
        var lastDate = ""
        var symbol = ""
         var dates = ""

        for item in observed.historidcalDataObserver {
            if (item.country?.lowercased() == country.country.lowercased()){
                if let casesExistent = item.timeline?.cases {
                    arrayOfCases.append(casesExistent)
                }
            }
        }
        if (arrayOfCases.count > 1){
            let casesSorted = arrayOfCases.reduce([String : Int]()) { acc, d in
              var dx = acc
              for entry in d {
                let key = entry.key
                guard dx[key] == nil else {
                    dx[key]! += entry.value ?? 0
                  continue
                }
                dx[entry.key] = entry.value
              }
              return dx
            }
    
            var convertedArray: [Date: Int] = [:]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy"// yyyy-MM-dd"
            for dat in casesSorted {
                let date = dateFormatter.date(from: dat.key)
                if let date = date {
                    convertedArray[date] = dat.value
                }
            }
            let ready = convertedArray.sorted(by: { $0.key.compare($1.key) == .orderedAscending })
            for caseSorted in ready {
                arrayOfCasesPerDay.append(Double(caseSorted.value))
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"

            let myfirstDate = formatter.string(from: ready[0].key) // string purpose I add here
            let yourDate = formatter.date(from: myfirstDate)
            formatter.dateFormat = "dd MMM yyyy"
            let myStringafd = formatter.string(from: yourDate!)
            firstDate = myStringafd
            
            var totalCount = ready.count - 1
            let myLastDate = formatter.string(from: ready[totalCount].key) // string purpose I add here
            let yourDatemyLastDate = formatter.date(from: myLastDate)
            formatter.dateFormat = "dd MMM yyyy"
            let mymyLastDatefd = formatter.string(from: yourDatemyLastDate!)
            lastDate = mymyLastDatefd
            
            var lastItem = arrayOfCasesPerDay.count - 1
                 var secondLastItem = arrayOfCasesPerDay.count - 2
                 var percentage = (arrayOfCasesPerDay[lastItem] * 100) / arrayOfCasesPerDay[secondLastItem]
                 percentage = percentage - 100
                 if (percentage > 0 ){
                     symbol = "🔼" + " " + "\(String(format: "%.1f", percentage))%"
                 } else if (percentage < 0 ) {
                      symbol = "🔽" + " " + "\(String(format: "%.1f", percentage))%"
                 } else {
                     symbol = " - 0 new cases since yesterday"
                 }
                 
                 
                
                 dates = firstDate + " to " + lastDate
            
        }
     
        
        return LineView(data: arrayOfCasesPerDay, title: "\(self.country.todayCases)", legend:"Cases Today " + symbol + "\n" + dates)
    }
    
    func getArrayOfDeaths() -> LineView {
        var arrayOfDeathsPerDay: [Double] = []
        var arrayOfDeaths:  [[String: Int?]] = [[:]]
        var firstDate = ""
        var lastDate = ""
        var dates = ""
        var symbol = ""

        for item in observed.historidcalDataObserver {

            if (item.country?.lowercased() == country.country.lowercased()){
                if let casesExistent = item.timeline?.deaths {
                    arrayOfDeaths.append(casesExistent)
                }
            }
        }
        if (arrayOfDeaths.count > 1){
            let casesSorted = arrayOfDeaths.reduce([String : Int]()) { acc, d in
                      var dx = acc
                      for entry in d {
                        let key = entry.key
                        guard dx[key] == nil else {
                            dx[key]! += entry.value ?? 0
                          continue
                        }
                        dx[entry.key] = entry.value
                      }
                      return dx
                    }
            
                    var convertedArray: [Date: Int] = [:]
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yy"// yyyy-MM-dd"
                    for dat in casesSorted {
                        let date = dateFormatter.date(from: dat.key)
                        if let date = date {
                            convertedArray[date] = dat.value
                        }
                    }
                    let ready = convertedArray.sorted(by: { $0.key.compare($1.key) == .orderedAscending })
                    for caseSorted in ready {
                        arrayOfDeathsPerDay.append(Double(caseSorted.value))
                    }
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"

            let myfirstDate = formatter.string(from: ready[0].key) // string purpose I add here
            let yourDate = formatter.date(from: myfirstDate)
            formatter.dateFormat = "dd MMM yyyy"
            let myStringafd = formatter.string(from: yourDate!)
            firstDate = myStringafd
            
            var totalCount = ready.count - 1
            let myLastDate = formatter.string(from: ready[totalCount].key) // string purpose I add here
            let yourDatemyLastDate = formatter.date(from: myLastDate)
            formatter.dateFormat = "dd MMM yyyy"
            let mymyLastDatefd = formatter.string(from: yourDatemyLastDate!)
            lastDate = mymyLastDatefd
            var lastItem = arrayOfDeathsPerDay.count - 1
            var secondLastItem = arrayOfDeathsPerDay.count - 2
            var percentage = (arrayOfDeathsPerDay[lastItem] * 100) / arrayOfDeathsPerDay[secondLastItem]
            percentage = percentage - 100
            if (percentage > 0 ){
                symbol = "🔼" + " " + "\(String(format: "%.1f", percentage))%"
            } else if (percentage < 0 ) {
                 symbol = "🔽" + " " + "\(String(format: "%.1f", percentage))%"
            } else {
                symbol = " - 0 new cases since yesterday"
            }
            dates = firstDate + " to " + lastDate
        }
        
        return LineView(data: arrayOfDeathsPerDay, title: "\(self.country.todayDeaths)", legend:"Deaths Today " + symbol + "\n" + dates)
       
    }
}

func returnLocation2D(latitude: Double, longitude: Double)->CLLocationCoordinate2D {
    var c2D : CLLocationCoordinate2D
    c2D = CLLocationCoordinate2DMake(latitude, longitude)
    return c2D
}

struct CountryDetail_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetail(country: countriesData[0])
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void

    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
}
