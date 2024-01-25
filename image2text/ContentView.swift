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
                                    
                                    VStack(alignment: .leading) {
                                        ForEach(makeListOfString(text: text.content), id: \.self) { item in
                                            
                                            extractAndDisplayScanInfo(header: ["Nachname","Vorname", "Strasse", "Ort"], wholeString: text, item: item, checkAgainst: "Name, Vorname des Versicherten", numberOfShownItems: 4)

                                            extractAndDisplayScanInfo(header: ["Krankenkasse bzw. Kostenträger"], wholeString: text, item: item, checkAgainst: "Krankenkasse bzw. Kostenträger", numberOfShownItems: 1)
                                        
                                            extractAndDisplayScanInfo(header: ["Geburtstdatum"], wholeString: text, item: item, checkAgainst: "geb. am", numberOfShownItems: 1)
                                        
                                            extractAndDisplayScanInfo(header: ["Kassennummer"], wholeString: text, item: item, checkAgainst: "Kassen-Nr.", numberOfShownItems: 1)
                                        
                                            extractAndDisplayScanInfo(header: ["Versichertennummer"], wholeString: text, item: item, checkAgainst: "Versicherten-Nr.", numberOfShownItems: 1)
                                        
                                            extractAndDisplayScanInfo(header: ["Status"], wholeString: text, item: item, checkAgainst: "Status", numberOfShownItems: 1)
                                        
                                            extractAndDisplayScanInfo(header: ["Betriebsstättennummer"], wholeString: text, item: item, checkAgainst: "Betriebsstätten-Nr.", numberOfShownItems: 1)
                                        
                                            extractAndDisplayScanInfo(header: ["Arztnummer"], wholeString: text, item: item, checkAgainst: "Arzt-Nr.", numberOfShownItems: 1)
                                        
                                            extractAndDisplayScanInfo(header: ["Datum"], wholeString: text, item: item, checkAgainst: "Datum", numberOfShownItems: 1)
                                        
                                            extractAndDisplayScanInfo(header: ["Verordnung"], wholeString: text, item: item, checkAgainst: "Rp. (Bitte Leerräume durchstreichen", numberOfShownItems: 4)
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
        for item in stringList {
            print(item)
        }
        
        return stringList
    }
    
    @ViewBuilder
    private func displayInformation(header: [String], showItems: [String]) -> some View {
        if !header.isEmpty && !showItems.isEmpty {
            VStack(alignment: .leading) {
                ForEach(0..<min(header.count, showItems.count), id: \.self) { index in
                    Text("\(header[index]): \(showItems[index])")
                }
            }
        } else {
            EmptyView()
        }
    }

    private func extractAndDisplayScanInfo(header: [String], wholeString: ScanData, item: String, checkAgainst: String, numberOfShownItems: Int) -> some View {
        if let index = item.range(of: checkAgainst)?.lowerBound {
            let substring = item.suffix(from: index)
            let percentage = Double(substring.count) / Double(item.count)
            var showDataItems: [String] = []
            
            if percentage >= 0.9 {
                if let nextItemIndex = makeListOfString(text: wholeString.content).firstIndex(of: item) {
                    for index in 1...numberOfShownItems {
                        showDataItems.append(makeListOfString(text: wholeString.content)[nextItemIndex + index])
                    }
                    return displayInformation(header: header, showItems: showDataItems)
                }
            }
            else {
                return displayInformation(header: ["Foto unklar"], showItems: [])
            }
        }
        return displayInformation(header: [], showItems: [])
    }
}

#Preview {
    ContentView()
}
