//
//  UILabel+Extensions.swift
//  albms
//
//  Created by Armand Raynor on 1/3/20.
//  Copyright © 2020 Armand Raynor. All rights reserved.
//
// https://medium.com/@joncardasis/dynamic-text-resizing-in-swift-3da55887beb3
// https://github.com/joncardasis/FontFit

import UIKit

public extension UILabel {

    /**
     Autosizes `font` to the largest value where the text fills the `maxLines` provided.

     Depending on the bounds of the view, the actual number of lines occupied by the text may
     be less than the preferred amount provided.
     */
    func fitText(maxLines: UInt) {
        guard let text = text else { return }
        numberOfLines = 0
        self.font = UIFont.fontFittingText(text, in: bounds.size, fontDescriptor: font.fontDescriptor, option: .preferredLineCount(maxLines))
    }

    /**
     Autosizes `font` to the largest value where the text can still be contained in the view's bounds.
     */
    func fitTextToBounds() {
        guard let text = text else { return }
        numberOfLines = 0
        self.font = UIFont.fontFittingText(text, in: bounds.size, fontDescriptor: font.fontDescriptor, option: .fillContainer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        fitTextToBounds()
    }
}
