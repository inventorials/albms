//
//  UIImage+Extensions.swift
//  albms
//
//  Created by Armand Raynor on 10/11/19.
//  Copyright © 2019 Armand Raynor. All rights reserved.
//

import UIKit

extension UIImageView {

    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
    }

    func convertImageToGrayscale() {
        guard let currentCGImage = self.image?.cgImage else { return }
        let currentCIImage = CIImage(cgImage: currentCGImage)

        let filter = CIFilter(name: "CIColorMonochrome")
        filter?.setValue(currentCIImage, forKey: "inputImage")

        // set a gray value for the tint color
        filter?.setValue(CIColor(red: 0.7, green: 0.7, blue: 0.7), forKey: "inputColor")

        filter?.setValue(1.0, forKey: "inputIntensity")
        guard let outputImage = filter?.outputImage else { return }

        let context = CIContext()

        guard let cgimg = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        self.image = UIImage(cgImage: cgimg)
    }
}
