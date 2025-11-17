//
//  RemoveBackground.swift
//  Outfitify
//
//  Created by Leo A.Molina on 17/11/25.
//

/*
 Code gotten from:
 https://www.createwithswift.com/removing-image-background-using-the-vision-framework/
 By: Matteo Altobello
 August 13, 2025
 */

import SwiftUI
import Vision
import CoreImage
import CoreImage.CIFilterBuiltins

func createMask(from inputImage: CIImage) -> CIImage? {
    
    let request = VNGenerateForegroundInstanceMaskRequest()
    let handler = VNImageRequestHandler(ciImage: inputImage)

    do {
        try handler.perform([request])
        
        if let result = request.results?.first {
            let mask = try result.generateScaledMaskForImage(forInstances: result.allInstances, from: handler)
            return CIImage(cvPixelBuffer: mask)
        }
    } catch {
        print(error)
    }
    
    return nil
}

func applyMask(mask: CIImage, to image: CIImage) -> CIImage {
    let filter = CIFilter.blendWithMask()
    
    filter.inputImage = image
    filter.maskImage = mask
    filter.backgroundImage = CIImage.empty()
    
    return filter.outputImage!
}

func convertToUIImage(ciImage: CIImage) -> UIImage {
    guard let cgImage = CIContext(options: nil).createCGImage(ciImage, from: ciImage.extent) else {
        fatalError("Failed to render CGImage")
    }
    
    return UIImage(cgImage: cgImage)
}

func removeBackground(from image: UIImage) async -> UIImage? {
    guard let inputImage = CIImage(image: image) else {
        print("Failed to create CIImage")
        return nil
    }

    guard let maskImage = createMask(from: inputImage) else {
        print("Failed to create mask")
        return nil
    }

    let outputImage = applyMask(mask: maskImage, to: inputImage)
    let finalImage = convertToUIImage(ciImage: outputImage)
    return finalImage
}
