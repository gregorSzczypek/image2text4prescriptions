//
//  prescriptionInfoViewFactory.swift
//  image2text
//
//  Created by Gregor Szczypek on 26.01.24.
//

import Foundation
import SwiftUI

class PrescriptionInfoViewFactory {
    
    func extractAndDisplayScanInfo(header: [String], wholeString: ScanData, item: String, checkAgainst: String, numberOfShownItems: Int) -> some View {
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
    
    func makeListOfString(text: String) -> [String] {
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
        }
        else if header == ["Foto unklar"] {
            Text("Stelle unklar. Manuell eingeben oder neues Foto anfertigen")
        }
        else {
            EmptyView()
        }
    }
}
