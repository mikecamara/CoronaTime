//
//  CountryRow.swift
//  Landmarks
//
//  Created by Mike Camara on 27/3/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct CountryRow: View {
    var country: Country
    var body: some View {
        HStack {
            Text(flag(country:country.countryInfo.iso2 ?? ""))
            Text(country.country)
            Spacer()
            Text("\(country.cases)")
        }
    }
}

struct WorldRow: View {
    var world: World
    var body: some View {
        HStack {
            Text("🌍")
            Text("Worldwide")
            Spacer()
            Text("\(world.cases)")
        }
    }
}

struct CasesRow: View {
    var country: Country
    var body: some View {
        VStack{
            HStack {
               Text("Cases")
                   .font(.title)
               Spacer()

               Text("\(country.cases)")
                   .font(.title)
               
           }
            Divider()
        }
       
    }
}

struct TodaysDeathRow: View {
    var country: Country
    var body: some View {
        VStack{
        HStack {

            Text("Today's Deaths")
                .font(.headline)
            Spacer()

            Text("\(country.todayDeaths)")
                .font(.headline)
            }.frame(height:30)
            Divider()
        
        }
    }
}

struct ActiveRow: View {
    var country: Country
    var body: some View {
        VStack{
        HStack {

            Text("Active")
                .font(.headline)
            Spacer()

            Text("\(country.active)")
                .font(.headline)
            Divider()
            Text("\(((country.active * 100) / country.cases))%")
                .font(.subheadline)
            }.frame(height:30)
            Divider()
        }
    }
}

struct RecoveredRow: View {
    var country: Country
    var body: some View {
        VStack{
        HStack {

            Text("Recovered")
                .font(.headline)
            Spacer()

            Text("\(country.recovered)")
                .font(.headline)
            Divider()
            Text("\(((country.recovered * 100) / country.cases))%")
                .font(.subheadline)
            }.frame(height:30)
            Divider()
        }
    }
}

struct DeathsRow: View {
    var country: Country
    var body: some View {
        VStack{
        HStack {

            Text("Deaths")
                .font(.headline)
            Spacer()

            Text("\(country.deaths)")
                .font(.headline)
            Divider()
            Text("\(((country.deaths * 100) / country.cases))%")
                .font(.subheadline)
        }.frame(height:30)
            Divider()
        }
    }
}

struct CriticalRow: View {
    var country: Country
    var body: some View {
        VStack{
        HStack {
            Text("Critical")
                .font(.headline)
            Spacer()

            Text("\(country.critical)")
                .font(.headline)
            Divider()

            Text("\(((country.critical * 100) / country.cases))%")
                .font(.subheadline)
            }.frame(height:30)
            Divider()
        }
    }
}

struct TodaysCasesRow: View {
    var country: Country
    var body: some View {
        VStack{
        HStack {

            Text("Today's Cases")
                .font(.headline)
            Spacer()

            Text("\(country.todayCases)")
                .font(.headline)
            }.frame(height:30)
            Divider()
            
        }
    }
}

func flag(country:String) -> String {
    let base : UInt32 = 127397
    var s = ""
    for v in country.uppercased().unicodeScalars {
        s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
    }
    return s
}

struct CountryRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CountryRow(country: countriesData[0])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
