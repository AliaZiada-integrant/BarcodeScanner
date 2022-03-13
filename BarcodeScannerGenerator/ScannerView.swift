//
//  ScannerView.swift
//  BarcodeScannerGenerator
//
//  Created by Alia Ziada on 06/03/2022.
//

import SwiftUI
import ZXingObjC


struct ScannerView: View {
    @Binding var showScanner: Bool
    @Binding var barcodeText: String
    @Binding var barcodeImage: UIImage?
    
    var body: some View {
        
        VStack{
            CodeScannerView(codeTypes: [.qr, .code128,.ean8, .ean13,.aztec,.code39,.code93,.pdf417,.upce,.dataMatrix, .interleaved2of5], showViewfinder: true, simulatedData: "", completion: handleScan)
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
            generateBarcode(from: data)
            showScanner = false
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    
    func generateBarcode(from result: ScanResult) {
        barcodeText = result.string
        if let formate = result.type.zxBarcodeFormat(), !barcodeText.isEmpty{
            let writer = ZXMultiFormatWriter()
            if let result = try? writer.encode(barcodeText, format: formate, width: 1000, height: 300){
                if let imageRef = ZXImage(matrix: result){
                    if let cgImg = imageRef.cgimage{
                        barcodeImage = UIImage(cgImage: cgImg)
                    }
                }
            }
        }
    }
}
