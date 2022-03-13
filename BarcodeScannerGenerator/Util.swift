//
//  Util.swift
//  BarcodeScannerGenerator
//
//  Created by Alia Ziada on 10/03/2022.
//

import Foundation
import Vision
import ZXingObjC

class Utility {
    
    private static var barcodeText = ""
    private static var formate: ZXBarcodeFormat? = nil
    
    private static let barcodeRequest = VNDetectBarcodesRequest { (request, error) in
        guard let results = request.results else { return }
        for result in results {
            if let barcode = result as? VNBarcodeObservation {
                if let text = barcode.payloadStringValue {
                    barcodeText = text
                    formate = barcode.symbology.zxBarcodeFormat()
                }
            }
        }
    }
    
    class func scanCodeFromImage(image: UIImage) -> (String?,ZXBarcodeFormat?) {
        if let cgImage = image.cgImage {
            let handler = VNImageRequestHandler.init(cgImage: cgImage, options: [:])
            do {
                try handler.perform([barcodeRequest])
            } catch let error {
                print("Error: Barcode image: ", error.localizedDescription)
            }
            if (!Utility.barcodeText.isEmpty){
                return (Utility.barcodeText,formate);
            }
        }
        return (nil, nil)
    }
}
