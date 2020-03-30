//
//  File.swift
//  Landmarks
//
//  Created by Mike Camara on 27/3/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

class Observer : ObservableObject{
    @Published var countriesDataObserver = [Country]()
    @Published var historidcalDataObserver = [Historical]()
    @Published var worldDataObserver = [World]()
    
    init() {
       loadData()
       loadHistorical()
       loadWorld()
    }

    func loadData() {
        guard let url = URL(string: "https://corona.lmao.ninja/countries?sort=cases") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Countries.self, from: data) {
                    DispatchQueue.main.async {
                        var countries: [Country] = decodedResponse as [Country]
                        self.countriesDataObserver = countries
                        for c in countries {
                            print(c.country)
                        }
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    func loadDeath() {
               guard let url = URL(string: "https://corona.lmao.ninja/countries?sort=deaths") else {
                   print("Invalid URL")
                   return
               }
               let request = URLRequest(url: url)
               URLSession.shared.dataTask(with: request) { data, response, error in
                   if let data = data {
                       if let decodedResponse = try? JSONDecoder().decode(Countries.self, from: data) {
                           DispatchQueue.main.async {
                               var countries: [Country] = decodedResponse as [Country]
                               self.countriesDataObserver = countries
                               for c in countries {
                               }
                              print(decodedResponse as [Country])
                           }
                           return
                       }
                   }
                   print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
               }.resume()
           }
    
    func loadActive() {
        guard let url = URL(string: "https://corona.lmao.ninja/countries?sort=active") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Countries.self, from: data) {
                    DispatchQueue.main.async {
                        var countries: [Country] = decodedResponse as [Country]
                        self.countriesDataObserver = countries
                        for c in countries {
                        }
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    func loadCritical() {
        guard let url = URL(string: "https://corona.lmao.ninja/countries?sort=critical") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Countries.self, from: data) {
                    DispatchQueue.main.async {
                        var countries: [Country] = decodedResponse as [Country]
                        self.countriesDataObserver = countries
                        for c in countries {
                        }
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    func loadRecovered() {
        guard let url = URL(string: "https://corona.lmao.ninja/countries?sort=recovered") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Countries.self, from: data) {
                    DispatchQueue.main.async {
                        var countries: [Country] = decodedResponse as [Country]
                        self.countriesDataObserver = countries
                        for c in countries {
                        }
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    func loadTodaysCases() {
        guard let url = URL(string: "https://corona.lmao.ninja/countries?sort=todaysCases") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Countries.self, from: data) {
                    DispatchQueue.main.async {
                        var countries: [Country] = decodedResponse as [Country]
                        self.countriesDataObserver = countries
                        for c in countries {
                        }
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    func loadToadaysDeaths() {
        guard let url = URL(string: "https://corona.lmao.ninja/countries?sort=todaysDeaths") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Countries.self, from: data) {
                    DispatchQueue.main.async {
                        var countries: [Country] = decodedResponse as [Country]
                        self.countriesDataObserver = countries
                        for c in countries {
                        }
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    func loadHistorical() {
        guard let url = URL(string: "https://corona.lmao.ninja/v2/historical") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Historicals.self, from: data) {
                    DispatchQueue.main.async {
                        var historicals: [Historical] = decodedResponse as [Historical]
                        self.historidcalDataObserver = historicals
                        for h in historicals {
                            print(h.country)
//                            print(h.timeline?.cases)
                        }
                        print(decodedResponse as [Historical])
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    
     func loadWorld() {
            guard let url = URL(string: "https://corona.lmao.ninja/all") else {
                print("Invalid URL")
                return
            }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(WorldData.self, from: data) {
                        DispatchQueue.main.async {
                            var wolrddata:[World] = [decodedResponse] as [World]
                            self.worldDataObserver = wolrddata
                           
                            print([decodedResponse] as [World])
                        }
                        return
                    }
                }
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }.resume()
        }
        
    
        
}

