//
//  ContentView.swift
//  image2text
//
//  Created by Gregor Szczypek on 24.01.24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showScannerSheet = false
    @State private var texts: [ScanData] = []
    @State private var textContent = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                if texts.count > 0 {
                    List {
                        ForEach(texts) { text in
                            NavigationLink(
                                destination: ScrollView {
                                    ForEach(makeListOfString(text: text.content), id: \.self) { item in
                                        
                                        if let index = item.range(of: "Krankenkasse bzw. Kostenträger")?.lowerBound {
                                            let substring = item.suffix(from: index)
                                            
                                            // Calculate the percentage of the specified string in the current item
                                            let percentage = Double(substring.count) / Double(item.count)
                                            
                                            // Check if the percentage is at least 80%
                                            if percentage >= 0.8 {
                                                // Extract the next item (assuming it's the name) and display it
                                                if let nextItemIndex = makeListOfString(text: text.content).firstIndex(of: item) {
                                                    let insuranceNameItem = makeListOfString(text: text.content)[nextItemIndex + 1]
                                                    Text("Krankenkasse bzw. Kostenträger: \(insuranceNameItem)")
                                                }
                                            }
                                        }
                                        
                                        if let index = item.range(of: "Name, Vorname des Versicherten")?.lowerBound {
                                            let substring = item.suffix(from: index)
                                            
                                            // Calculate the percentage of the specified string in the current item
                                            let percentage = Double(substring.count) / Double(item.count)
                                            
                                            // Check if the percentage is at least 80%
                                            if percentage >= 0.8 {
                                                // Extract the next item (assuming it's the name) and display it
                                                if let nextItemIndex = makeListOfString(text: text.content).firstIndex(of: item) {
                                                    let lastNameItem = makeListOfString(text: text.content)[nextItemIndex + 1]
                                                    let firstNameItem = makeListOfString(text: text.content)[nextItemIndex + 2]
                                                    let streetItem = makeListOfString(text: text.content)[nextItemIndex + 3]
                                                    let cityItem = makeListOfString(text: text.content)[nextItemIndex + 4]
                                                    Text("Vorname: \(firstNameItem)")
                                                    Text("Nachname: \(lastNameItem)")
                                                    Text("Straße: \(streetItem)")
                                                    Text("Stadt: \(cityItem)")
                                                }
                                            }
                                        }
                                        
                                        if let index = item.range(of: "geb. am")?.lowerBound {
                                            let substring = item.suffix(from: index)
                                            
                                            // Calculate the percentage of the specified string in the current item
                                            let percentage = Double(substring.count) / Double(item.count)
                                            
                                            // Check if the percentage is at least 80%
                                            if percentage >= 0.8 {
                                                // Extract the next item (assuming it's the name) and display it
                                                if let nextItemIndex = makeListOfString(text: text.content).firstIndex(of: item) {
                                                    let dateOfBirthNameItem = makeListOfString(text: text.content)[nextItemIndex + 1]
                                                    Text("Geburtsdatum: \(dateOfBirthNameItem)")
                                                }
                                            }
                                        }
                                        
                                        if let index = item.range(of: "Kassen-Nr.")?.lowerBound {
                                            let substring = item.suffix(from: index)
                                            
                                            // Calculate the percentage of the specified string in the current item
                                            let percentage = Double(substring.count) / Double(item.count)
                                            
                                            // Check if the percentage is at least 80%
                                            if percentage >= 0.8 {
                                                // Extract the next item (assuming it's the name) and display it
                                                if let nextItemIndex = makeListOfString(text: text.content).firstIndex(of: item) {
                                                    let insuranceNumberItem = makeListOfString(text: text.content)[nextItemIndex + 1]
                                                    Text("Kassennummer: \(insuranceNumberItem)")
                                                }
                                            }
                                        }
                                        
                                        if let index = item.range(of: "Versicherten-Nr.")?.lowerBound {
                                            let substring = item.suffix(from: index)
                                            
                                            // Calculate the percentage of the specified string in the current item
                                            let percentage = Double(substring.count) / Double(item.count)
                                            
                                            // Check if the percentage is at least 80%
                                            if percentage >= 0.8 {
                                                // Extract the next item (assuming it's the name) and display it
                                                if let nextItemIndex = makeListOfString(text: text.content).firstIndex(of: item) {
                                                    let patientNumberItem = makeListOfString(text: text.content)[nextItemIndex + 1]
                                                    Text("Versichertennummer: \(patientNumberItem)")
                                                }
                                            }
                                        }
                                        
                                        if let index = item.range(of: "Status")?.lowerBound {
                                            let substring = item.suffix(from: index)
                                            
                                            // Calculate the percentage of the specified string in the current item
                                            let percentage = Double(substring.count) / Double(item.count)
                                            
                                            // Check if the percentage is at least 80%
                                            if percentage >= 0.8 {
                                                // Extract the next item (assuming it's the name) and display it
                                                if let nextItemIndex = makeListOfString(text: text.content).firstIndex(of: item) {
                                                    let statusItem = makeListOfString(text: text.content)[nextItemIndex + 1]
                                                    Text("Status: \(statusItem)")
                                                }
                                            }
                                        }
                                        
                                        if let index = item.range(of: "Betriebsstätten-Nr.")?.lowerBound {
                                            let substring = item.suffix(from: index)
                                            
                                            // Calculate the percentage of the specified string in the current item
                                            let percentage = Double(substring.count) / Double(item.count)
                                            
                                            // Check if the percentage is at least 80%
                                            if percentage >= 0.8 {
                                                // Extract the next item (assuming it's the name) and display it
                                                if let nextItemIndex = makeListOfString(text: text.content).firstIndex(of: item) {
                                                    let betriebsItem = makeListOfString(text: text.content)[nextItemIndex + 1]
                                                    Text("Betriebsstättennummer: \(betriebsItem)")
                                                }
                                            }
                                        }
                                        
                                        if let index = item.range(of: "Arzt-Nr.")?.lowerBound {
                                            let substring = item.suffix(from: index)
                                            
                                            // Calculate the percentage of the specified string in the current item
                                            let percentage = Double(substring.count) / Double(item.count)
                                            
                                            // Check if the percentage is at least 80%
                                            if percentage >= 0.8 {
                                                // Extract the next item (assuming it's the name) and display it
                                                if let nextItemIndex = makeListOfString(text: text.content).firstIndex(of: item) {
                                                    let arztItem = makeListOfString(text: text.content)[nextItemIndex + 1]
                                                    Text("Arztnummer: \(arztItem)")
                                                }
                                            }
                                        }
                                        
                                        if let index = item.range(of: "Datum")?.lowerBound {
                                            let substring = item.suffix(from: index)
                                            
                                            // Calculate the percentage of the specified string in the current item
                                            let percentage = Double(substring.count) / Double(item.count)
                                            
                                            // Check if the percentage is at least 80%
                                            if percentage >= 0.8 {
                                                // Extract the next item (assuming it's the name) and display it
                                                if let nextItemIndex = makeListOfString(text: text.content).firstIndex(of: item) {
                                                    let dateItem = makeListOfString(text: text.content)[nextItemIndex + 1]
                                                    Text("Datum: \(dateItem)")
                                                }
                                            }
                                        }
                                    }
                                },
                                label: {
                                    Text("Gescsanntes Rezept")
                                }
                            )
                        }
                    }
                }
                else {
                    Text("Kein Rezept gescanned")
                        .font(.title)
                }
                
                Spacer()
                
                Button(action: {
                    showScannerSheet = true
                }, label: {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                })
                Spacer()
            }
            .sheet(isPresented: $showScannerSheet, content: {
                makeScannerView()
            })
            .navigationTitle("Rezept Scanner Prototyp")
        }
    }
    
    private func makeScannerView() -> ScannerView {
        ScannerView(completion: {
            textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) {
                let newScanData = ScanData(content: outputText)
                self.texts.append(newScanData)
            }
            print(texts)
            self.showScannerSheet = false
        })
    }
    
    private func makeListOfString(text: String) -> [String] {
        let stringList = text.components(separatedBy: "\n")

        // Print the resulting list
        for item in stringList {
            print(item)
        }
        
        return stringList
    }
}

#Preview {
    ContentView()
}
