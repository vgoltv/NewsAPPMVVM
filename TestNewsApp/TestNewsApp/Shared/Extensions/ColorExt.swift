//
//  ColorExt.swift
//
//  Created by Viktor Goltvyanytsya on 10.11.2021.
//

import Foundation
import SwiftUI
#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#else
    #error("Unsupported platform")
#endif

#if os(iOS)
public extension Color {
    static let lightText = Color(UIColor.lightText)
    static let darkText = Color(UIColor.darkText)
    
    static let label = Color(UIColor.label)
    static let secondaryLabel = Color(UIColor.secondaryLabel)
    static let tertiaryLabel = Color(UIColor.tertiaryLabel)
    static let quaternaryLabel = Color(UIColor.quaternaryLabel)
    
    static let appPagerDotsColor = Color.white.opacity(0.2)
    static let appPagerDotsActiveColor = Color.white
    
    static let systemBackground = Color(UIColor.systemBackground)
    static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
    static let tertiarySystemBackground = Color(UIColor.tertiarySystemBackground)
    
    static let separatorColor = Color(UIColor.separator)
    
    static let linkColor = Color(UIColor.link)
    
    static let grayLight = Color(UIColor.systemGray2)
}
#elseif os(tvOS)
public extension Color {
    static let lightText = Color(UIColor.label)
    static let darkText = Color(UIColor.label)
    
    static let label = Color(UIColor.label)
    static let secondaryLabel = Color(UIColor.secondaryLabel)
    static let tertiaryLabel = Color(UIColor.tertiaryLabel)
    static let quaternaryLabel = Color(UIColor.quaternaryLabel)
    
    static let appPagerDotsColor = Color.white.opacity(0.2)
    static let appPagerDotsActiveColor = Color.white
    
    //static let systemBackground = Color.systemBackground
    //static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
    //static let tertiarySystemBackground = Color(UIColor.tertiarySystemBackground)
    
    static let separatorColor = Color(UIColor.separator)
    
    static let linkColor = Color(UIColor.link)
    
    //static let grayLight = Color(UIColor.systemGray2)
}
#elseif os(macOS)
public extension Color {
    static let lightText = Color(NSColor.selectedTextColor)
    static let darkText = Color(NSColor.textColor)

    static let label = Color(NSColor.labelColor)
    static let secondaryLabel = Color(NSColor.secondaryLabelColor)
    static let tertiaryLabel = Color(NSColor.tertiaryLabelColor)
    static let quaternaryLabel = Color(NSColor.quaternaryLabelColor)

    static let systemBackground = Color(NSColor.windowBackgroundColor)
    static let secondarySystemBackground = Color(NSColor.controlBackgroundColor)
    static let tertiarySystemBackground = Color(NSColor.textBackgroundColor)
    
    static let separatorColor = Color(NSColor.separatorColor)
    
    static var linkColor = Color(NSColor.linkColor)
    
    static let grayLight = Color(NSColor.systemGray)

}
#endif

public extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
