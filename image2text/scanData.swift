//
//  scanData.swift
//  image2text
//
//  Created by Gregor Szczypek on 24.01.24.
//

import Foundation

struct ScanData: Identifiable {
    var id = UUID()
    var content: String
    
    init(content: String) {
        self.content = content
    }
}
