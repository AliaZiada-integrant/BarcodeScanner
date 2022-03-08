//
//  AVMetadataObject.ObjectType+Extension.swift
//  BarcodeScannerGenerator
//
//  Created by Alia Ziada on 06/03/2022.
//

import Foundation
import ZXingObjC
import AVFoundation
extension AVMetadataObject.ObjectType{
    
    func zxBarcodeFormat() -> ZXBarcodeFormat? { 
        switch self{
        case .ean8:
            return kBarcodeFormatEan8
        case .ean13:
            return kBarcodeFormatEan13
        case .aztec:
            return kBarcodeFormatAztec
        case .code93:
            return kBarcodeFormatCode93
        case .code39:
            return kBarcodeFormatCode39
        case .pdf417:
            return kBarcodeFormatPDF417
        case .qr:
            return kBarcodeFormatQRCode
        case .code128:
            return kBarcodeFormatCode128
        case .upce:
            return kBarcodeFormatUPCE
        case .dataMatrix:
            return kBarcodeFormatDataMatrix
        case .interleaved2of5:
            return kBarcodeFormatITF
        default:
            return nil
        }
    }
}
