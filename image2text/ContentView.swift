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
    
    private var viewFactory = PrescriptionInfoViewFactory()
    
    var body: some View {
        NavigationStack {
            VStack {
                if texts.count > 0 {
                    List {
                        ForEach(texts) { text in
                            NavigationLink(
                                destination: ScrollView {
                                    
                                    VStack(alignment: .leading) {
                                        ForEach(viewFactory.makeListOfString(text: text.content), id: \.self) { item in
                                            
                                            viewFactory.extractAndDisplayScanInfo(header: ["Nachname","Vorname", "Strasse", "Ort"], wholeString: text, item: item, checkAgainst: "Name, Vorname des Versicherten", numberOfShownItems: 4)

                                            viewFactory.extractAndDisplayScanInfo(header: ["Krankenkasse bzw. Kostenträger"], wholeString: text, item: item, checkAgainst: "Krankenkasse bzw. Kostenträger", numberOfShownItems: 1)
                                        
                                            viewFactory.extractAndDisplayScanInfo(header: ["Geburtstdatum"], wholeString: text, item: item, checkAgainst: "geb. am", numberOfShownItems: 1)
                                        
                                            viewFactory.extractAndDisplayScanInfo(header: ["Kassennummer"], wholeString: text, item: item, checkAgainst: "Kassen-Nr.", numberOfShownItems: 1)
                                        
                                            viewFactory.extractAndDisplayScanInfo(header: ["Versichertennummer"], wholeString: text, item: item, checkAgainst: "Versicherten-Nr.", numberOfShownItems: 1)
                                        
                                            viewFactory.extractAndDisplayScanInfo(header: ["Status"], wholeString: text, item: item, checkAgainst: "Status", numberOfShownItems: 1)
                                        
                                            viewFactory.extractAndDisplayScanInfo(header: ["Betriebsstättennummer"], wholeString: text, item: item, checkAgainst: "Betriebsstätten-Nr.", numberOfShownItems: 1)
                                        
                                            viewFactory.extractAndDisplayScanInfo(header: ["Arztnummer"], wholeString: text, item: item, checkAgainst: "Arzt-Nr.", numberOfShownItems: 1)
                                        
                                            viewFactory.extractAndDisplayScanInfo(header: ["Datum"], wholeString: text, item: item, checkAgainst: "Datum", numberOfShownItems: 1)
                                        
                                            viewFactory.extractAndDisplayScanInfo(header: ["Verordnung"], wholeString: text, item: item, checkAgainst: "Rp. (Bitte Leerräume durchstreichen", numberOfShownItems: 4)
                                        }
                                    }
                                },
                                label: {
                                    Text("Gescanntes Rezept")
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
}

#Preview {
    ContentView()
}
