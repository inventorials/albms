//
//  UIFont+Extensions.swift
//  albms
//
//  Created by Armand Raynor on 1/3/20.
//  Copyright © 2020 Armand Raynor. All rights reserved.
//
// https://medium.com/@joncardasis/dynamic-text-resizing-in-swift-3da55887beb3
// https://github.com/joncardasis/FontFit

import UIKit

public enum TextSizingOption: Equatable {
    case preferredLineCount(UInt)
    case fillContainer

    public static func == (lhs: TextSizingOption, rhs: TextSizingOption) -> Bool {
        switch (lhs, rhs) {
        case (let .preferredLineCount(lines1), let .preferredLineCount(lines2)):
            return lines1 == lines2
        case (.fillContainer,.fillContainer):
            return true
        default:
            return false
        }
    }
}

public extension UIFont {

    /**
     Provides the largest font which fits the text in the given bounds.
     */
    static func fontFittingText(_ text: String, in bounds: CGSize, fontDescriptor: UIFontDescriptor, option: TextSizingOption) -> UIFont? {
        let properBounds = CGRect(origin: .zero, size: bounds)
        let largestFontSize = Int(bounds.height)
        let constrainingBounds = CGSize(width: properBounds.width, height: CGFloat.infinity)

        let bestFittingFontSize: Int? = (1...largestFontSize).reversed().first(where: { fontSize in
            let font = UIFont(descriptor: fontDescriptor, size: CGFloat(fontSize))
            let currentFrame = text.boundingRect(with: constrainingBounds, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [.font: font], context: nil)

            if properBounds.contains(currentFrame) {
                let currentFrameLineCount = Int(ceil(currentFrame.height / font.lineHeight))
                if case .preferredLineCount(let lineCount) = option, currentFrameLineCount > max(lineCount, 1) {
                    return false
                }
                return true
            }

            return false
        })

        guard let fontSize = bestFittingFontSize else { return nil }
        return UIFont(descriptor: fontDescriptor, size: CGFloat(fontSize))
    }
}
