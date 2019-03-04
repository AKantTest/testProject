//
//  Pathifier.swift
//  Mooskine
//
//  Created by kant on 03.03.2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import UIKit
import CoreText

internal struct Pathifier {
    
    static func makeBezierPath(for attributedString: NSAttributedString, withFont font: UIFont) -> UIBezierPath {
        
        let text = NSMutableAttributedString(string: attributedString.string)
        text.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, text.length))
        
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer()
        let textStorage = NSTextStorage(attributedString: text)
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
        
        let path = UIBezierPath()
        let font = CTFontCreateWithFontDescriptor(font.fontDescriptor, font.pointSize, nil)
        for glyphIndex in 0 ..< layoutManager.numberOfGlyphs {
            let glyph = layoutManager.cgGlyph(at: glyphIndex)
            let position = layoutManager.location(forGlyphAt: glyphIndex)
            if let glyphPath = CTFontCreatePathForGlyph(font, glyph, nil) {
                let glyphBezierPath = UIBezierPath(cgPath: glyphPath)
                glyphBezierPath.apply(CGAffineTransform(translationX: position.x, y: 0))
                path.append(glyphBezierPath)
            }
        }
        return path
    }
    
    static func makeImage(for attributedString: NSAttributedString, withFont font: UIFont, withPatternImage patternImage: UIImage) -> UIImage {
        let path = makeBezierPath(for: attributedString, withFont: font)
        let bounds = path.bounds
        let pad = CGSize(width: 4, height: 6)
        let size = CGSize(width: bounds.size.width + bounds.origin.x + pad.width, height: bounds.size.height + pad.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        context?.scaleBy(x: 1, y: -1)
        context?.translateBy(x: 0, y: -size.height)
        
        context?.translateBy(x: -pad.width / 2, y: pad.height / 2)
        
        context?.setFillColor(UIColor(patternImage: patternImage).cgColor)
        path.fill()
        context?.setStrokeColor(UIColor.black.cgColor)
        path.stroke()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    static func makeMutableAttributedString(for attributedString: NSAttributedString, withFont font: UIFont, withPatternImage patternImage: UIImage) -> NSMutableAttributedString {
        
        let image = makeImage(for: attributedString, withFont: font, withPatternImage: patternImage)
        
        let attachment = NSTextAttachment()
        attachment.image = image
        
        let attachmentAsText = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
        return attachmentAsText
    }    
}

