//
//  ScannerView.swift
//  BarcodeScannerGenerator
//
//  Created by Alia Ziada on 06/03/2022.
//

import SwiftUI
import CodeScanner


struct ScannerView: View {
    @Binding var showScanner: Bool
    @Binding var scanText: String
    
    var body: some View {
        
        VStack{
            CodeScannerView(codeTypes: [.qr, .code128], showViewfinder: true, simulatedData: "", completion: handleScan)
                .frame(height: 300)
                .padding(.top, 30)
                .foregroundColor(Color.green)
            
            Spacer()
            Button("Cancel") {
                showScanner = false
            }
            .padding(.vertical, 8)
            .frame(minWidth: 200)
            .foregroundColor(.gray)
            .background(Capsule().stroke().foregroundColor(.black))
        }
    }
    
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        switch result{
        case .success(let data):
            showScanner = false
            scanText = data.string
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}
