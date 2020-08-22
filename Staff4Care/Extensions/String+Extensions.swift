//
//  String+Extensions.swift
//  Staff4Care
//
//  Created by Ahsan Mughal on 17/06/2020.
//  Copyright © 2020 14Digital. All rights reserved.
//

import UIKit

public protocol ChangableFont: AnyObject {
    var rangedAttributes: [RangedAttributes] { get }
    func getText() -> String?
    func set(text: String?)
    func getAttributedText() -> NSAttributedString?
    func set(attributedText: NSAttributedString?)
    func getFont() -> UIFont?
    func changeFont(ofText text: String, with font: UIFont)
    func changeFont(inRange range: NSRange, with font: UIFont)
    func changeTextColor(ofText text: String, with color: UIColor)
    func changeTextColor(inRange range: NSRange, with color: UIColor)
    func resetFontChanges()
}

public struct RangedAttributes {

    public let attributes: [NSAttributedString.Key: Any]
    public let range: NSRange

    public init(_ attributes: [NSAttributedString.Key: Any], inRange range: NSRange) {
        self.attributes = attributes
        self.range = range
    }
}
extension UILabel: ChangableFont {

    public func getText() -> String? {
        return text
    }

    public func set(text: String?) {
        self.text = text
    }

    public func getAttributedText() -> NSAttributedString? {
        return attributedText
    }

    public func set(attributedText: NSAttributedString?) {
        self.attributedText = attributedText
    }

    public func getFont() -> UIFont? {
        return font
    }
}

extension UITextField: ChangableFont {

    public func getText() -> String? {
        return text
    }

    public func set(text: String?) {
        self.text = text
    }

    public func getAttributedText() -> NSAttributedString? {
        return attributedText
    }

    public func set(attributedText: NSAttributedString?) {
        self.attributedText = attributedText
    }

    public func getFont() -> UIFont? {
        return font
    }
}

extension UITextView: ChangableFont {

    public func getText() -> String? {
        return text
    }

    public func set(text: String?) {
        self.text = text
    }

    public func getAttributedText() -> NSAttributedString? {
        return attributedText
    }

    public func set(attributedText: NSAttributedString?) {
        self.attributedText = attributedText
    }

    public func getFont() -> UIFont? {
        return font
    }
}
public extension ChangableFont {

    var rangedAttributes: [RangedAttributes] {
        guard let attributedText = getAttributedText() else {
            return []
        }
        var rangedAttributes: [RangedAttributes] = []
        let fullRange = NSRange(
            location: 0,
            length: attributedText.string.count
        )
        attributedText.enumerateAttributes(
            in: fullRange,
            options: []
        ) { (attributes, range, stop) in
            guard range != fullRange, !attributes.isEmpty else { return }
            rangedAttributes.append(RangedAttributes(attributes, inRange: range))
        }
        return rangedAttributes
    }

    func changeFont(ofText text: String, with font: UIFont) {
        guard let range = (self.getAttributedText()?.string ?? self.getText())?.range(ofText: text) else { return }
        changeFont(inRange: range, with: font)
    }

    func changeFont(inRange range: NSRange, with font: UIFont) {
        add(attributes: [.font: font], inRange: range)
    }

    func changeTextColor(ofText text: String, with color: UIColor) {
        guard let range = (self.getAttributedText()?.string ?? self.getText())?.range(ofText: text) else { return }
        changeTextColor(inRange: range, with: color)
    }

    func changeTextColor(inRange range: NSRange, with color: UIColor) {
        add(attributes: [.foregroundColor: color], inRange: range)
    }

    private func add(attributes: [NSAttributedString.Key: Any], inRange range: NSRange) {
        guard !attributes.isEmpty else { return }

        var rangedAttributes: [RangedAttributes] = self.rangedAttributes

        var attributedString: NSMutableAttributedString

        if let attributedText = getAttributedText() {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        } else if let text = getText() {
            attributedString = NSMutableAttributedString(string: text)
        } else {
            return
        }

        rangedAttributes.append(RangedAttributes(attributes, inRange: range))

        rangedAttributes.forEach { (rangedAttributes) in
            attributedString.addAttributes(
                rangedAttributes.attributes,
                range: rangedAttributes.range
            )
        }

        set(attributedText: attributedString)
    }

    func resetFontChanges() {
        guard let text = getText() else { return }
        set(attributedText: NSMutableAttributedString(string: text))
    }
}
public extension String {

    func range(ofText text: String) -> NSRange {
        let fullText = self
        let range = (fullText as NSString).range(of: text)
        return range
    }
}
