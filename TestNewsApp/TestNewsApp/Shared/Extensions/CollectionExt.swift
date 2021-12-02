//
//  CollectionExt.swift
//  TestNewsApp
//
//  Created by Viktor Goltvyanytsya on 02.12.2021.
//

import Foundation
import SwiftUI




extension Collection {
    func choose(_ n: Int) -> ArraySlice<Element> { shuffled().prefix(n) }
}
