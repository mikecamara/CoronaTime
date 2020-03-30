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
                    Divider()
                    VStack(alignment: .center) {
                        Text("Symptoms")
                            .foregroundColor(Color.secondary)
                   .font(.largeTitle)
                    }
                    VStack(alignment: .leading) {
                        Divider()
                        Text("😷 Cough")
                        .font(.title)
                        Divider()
                        Text("🤒 Fever")
                        .font(.title)
                        Divider()
                        Text("😰 Tiredness")
                        .font(.title)
                        Divider()
                        Text("😨 Difficulty breathing")
                        .font(.title)
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
        var worlddata: World? = nil
        for item in observed.worldDataObserver {
            print(item)
            var worlddata: World = World(cases: item.cases, deaths: item.deaths, recovered: item.recovered, updated: item.updated, active:item.active)
        }
        return WorldRow(world: worlddata ?? World(cases: 0, deaths: 0, recovered: 0, updated: 0, active:0))
    }
}
