//
//  PlaceholderImageView.swift
//  TestNewsApp
//
//  Created by Viktor Goltvyanytsya on 17.11.2021.
//

import Foundation
import SwiftUI



struct PlaceholderImageView: View {
    
    static let size: CGSize = CGSize(width: 70, height: 70)
    
    var body: some View {
        Image(systemName: "photo.fill")
            .background(Color.separatorColor)
            .frame(width: Self.size.width, height: Self.size.height)
            .addBorder( Color.separatorColor,
                        width: 1,
                        cornerRadius: 10)
    }
}
