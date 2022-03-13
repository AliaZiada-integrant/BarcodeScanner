//
//  ContentView.swift
//  BarcodeScannerGenerator
//
//  Created by Alia Ziada on 06/03/2022.
//

import SwiftUI
import ZXingObjC
import CoreImage

struct ContentView: View {
    @State var showScanner = false
    @State var barcodeText: String = ""
    @State var barcodeImage: UIImage? = nil
    @State var showingImagePicker: Bool = false
    
    var body: some View{
        VStack{
            Text(barcodeText)
                .font(.title)
                .padding(.top)
            
            Spacer()
            Button {
                showingImagePicker.toggle()
            } label: {
                Text("Pick barcode")
            }
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
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker{ img in
                let Data = Utility.scanCodeFromImage(image: img)
                barcodeText = Data.0 ?? ""
                generateBarcode(for: Data.1)
                
            }
        }
    }
    
    
    func generateBarcode(for formate: ZXBarcodeFormat?) {
        guard let formate = formate else { return }
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

extension UIImage {
    func normalizedImage() -> UIImage? {
        if imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
