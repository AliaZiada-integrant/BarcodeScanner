//
//  ContentView.swift
//  BarcodeScannerGenerator
//
//  Created by Alia Ziada on 06/03/2022.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State var showScanner = false
    @State var scanText = ""
    var body: some View{
        VStack{
            Text(scanText)
                .font(.title)
                .padding(.top)
            
            Spacer()
            
            Button {
                showScanner.toggle()
            } label: {
                Text("Scan")
            }
            .fullScreenCover(isPresented: $showScanner) {
                
            } content: {
                ScannerView(showScanner: $showScanner, scanText: $scanText)
            }
            
            Spacer()
            if let image = generateBarcode(from: scanText){
                Image(uiImage: image)
                    .resizable()
                    .frame(height: 200)
            }
        }
    }
    
    
    func generateBarcode(from string: String) -> UIImage? {
        let filter  = CIFilter.code128BarcodeGenerator()
        let context = CIContext()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        if let img = filter.outputImage?.transformed(by: transform){
            if let cgImg = context.createCGImage(img, from: img.extent){
                return UIImage(cgImage: cgImg)
            }
        }
        return nil
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
