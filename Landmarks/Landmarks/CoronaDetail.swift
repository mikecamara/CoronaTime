//
//  CoronaDetail.swift
//  Landmarks
//
//  Created by Mike Camara on 28/3/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct CoronaDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var observed = Observer()
    


    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment:.trailing){
                    HStack{
                        Text("Virus Disease").font(.largeTitle)
                        Spacer()
                        Button(action: {
                           print("Button action")
                           self.presentationMode.wrappedValue.dismiss()
                       }) {
                           HStack(){
                               
                            
                               Image(systemName: "xmark")
                               .resizable()
                               .frame(width: 20.0, height: 20.0)
                           }.padding()
                       }
                    }.padding()
                   
                }
                VStack(alignment: .center) {
                    Text("🦠")
                        .font(.system(size: 52))
                    getWorldCases()
                    getWorldCasesSubtitleAtive()
                    getWorldCasesSubtitleRecovered()
                    getWorldCasesSubtitleDeaths()
                    Divider()
                    VStack(alignment: .center) {
                        Text("Symptoms")
                            .foregroundColor(Color.secondary)
                   .font(.largeTitle)
                    }
                    VStack(alignment: .leading) {
                        Text("😷 Cough, 🤒 Fever, 😰 Tiredness, 😨 Difficulty breathing")
                            .font(.subheadline)
                        Divider()
                   }
                    Text("Prevention")
                        .font(.largeTitle)
                        .foregroundColor(Color.secondary)
                    
                    VStack(alignment: .center) {
                        Text("🧼")
                        .font(.largeTitle)
                        
                        Text("Wash your hands regularly for 20 seconds, with soap and water or alcohol-based hand rub")
                        .font(.subheadline)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                        .lineLimit(nil)
                        
                        Text("🤧")
                        .font(.largeTitle)
                        
                        Text("Cover your nose and mouth with a disposable tissue or flexed elbow when you cough or sneeze")
                        .font(.subheadline)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                        .lineLimit(nil)
                        
                        Text("🙅‍♂️")
                        .font(.largeTitle)
                        
                        Text("Avoid close contact (1 meter or 3 feet) with people who are unwell")
                        .font(.subheadline)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                        .lineLimit(nil)
                        
                        Text("🏡")
                        .font(.largeTitle)
                        
                        Text("Stay home and self-isolate from others in the household if you feel unwell")
                        .font(.subheadline)
                         .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                        .lineLimit(nil)
                        
                        Text("🤦‍♂️")
                        .font(.largeTitle)
                        
                        Text("Don't ouch your eyes, nose, or mouth if your hands are not clean")
                        .font(.subheadline)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                        .lineLimit(nil)
                    }
                }
                .padding()
                 Divider()
                Spacer()
                VStack(alignment: .center) {
                                   Text("Sources: World Health Organization, Worldometers")
                                    .font(.footnote)
                                    .foregroundColor(Color.secondary)
                }
                 .padding()
            }
        }
    }
    func getWorldCases() -> WorldRow {
        var worlddata: World? = observed.worldDataObserver
        return WorldRow(world: worlddata ?? World(updated: 0, cases: 0, todayCases: 0, deaths: 0, todayDeaths: 0, recovered: 0, active: 0, critical: 0, casesPerOneMillion: 0, deathsPerOneMillion: 0, tests: 0, testsPerOneMillion: 0.0, affectedCountries: 0 ))
    }
    
     func getWorldCasesSubtitleAtive() -> WorldRowSubtitleActive {
            var worlddata: World? = observed.worldDataObserver
            return WorldRowSubtitleActive(world: worlddata ?? World(updated: 0, cases: 0, todayCases: 0, deaths: 0, todayDeaths: 0, recovered: 0, active: 0, critical: 0, casesPerOneMillion: 0, deathsPerOneMillion: 0, tests: 0, testsPerOneMillion: 0.0, affectedCountries: 0 ) )
    }
    func getWorldCasesSubtitleRecovered() -> WorldRowSubtitleRecovered {
            var worlddata: World? = observed.worldDataObserver
        return WorldRowSubtitleRecovered(world: worlddata ?? World(updated: 0, cases: 0, todayCases: 0, deaths: 0, todayDeaths: 0, recovered: 0, active: 0, critical: 0, casesPerOneMillion: 0, deathsPerOneMillion: 0, tests: 0, testsPerOneMillion: 0.0, affectedCountries: 0 ))
    }
    func getWorldCasesSubtitleDeaths() -> WorldRowSubtitleDeath {
            var worlddata: World? = observed.worldDataObserver
            return WorldRowSubtitleDeath(world: worlddata ?? World(updated: 0, cases: 0, todayCases: 0, deaths: 0, todayDeaths: 0, recovered: 0, active: 0, critical: 0, casesPerOneMillion: 0, deathsPerOneMillion: 0, tests: 0, testsPerOneMillion: 0.0, affectedCountries: 0 ))
    }
}
