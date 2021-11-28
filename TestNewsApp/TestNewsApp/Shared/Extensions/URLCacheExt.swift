//
//  URLCacheExt.swift
//  TestNewsApp
//
//  Created by Viktor Goltvyanytsya on 16.11.2021.
//

import Foundation
import SwiftUI

extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}
