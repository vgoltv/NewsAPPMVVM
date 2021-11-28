//
//  ViewExt.swift
//  TestNewsApp
//
//  Created by Viktor Goltvyanytsya on 16.11.2021.
//

import Foundation
import SwiftUI





extension View {
     public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
         let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
         return clipShape(roundedRect)
              .overlay(roundedRect.strokeBorder(content, lineWidth: width))
     }
 }
