//
//  ContentView.swift
//  BarcodeScannerGenerator
//
//  Created by Alia Ziada on 06/03/2022.
//

import SwiftUI

struct ContentView: View {
    @State var showScanner = false
    @State var barcodeText: String = ""
    @State var barcodeImage: UIImage? = nil
    
    var body: some View{
        VStack{
            Text(barcodeText)
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
                ScannerView(showScanner: $showScanner, barcodeText: $barcodeText,barcodeImage: $barcodeImage)
            }
            
            Spacer()
            if let image = barcodeImage{
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
