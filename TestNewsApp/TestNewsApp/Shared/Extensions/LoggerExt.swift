//
//  LoggerExt.swift
//
//  Created by Viktor Goltvyanytsya on 09.01.2021.
//

import Foundation
import SwiftUI
import os.log



//Logger.vlog.logDebugInView(" group identifier: \(FileManager.groupIdentifier)")

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let vlog = Logger(subsystem: subsystem, category: "vlog")
    static let appLogger = Logger(subsystem: subsystem, category: "appLogger")
    
    public func logDebug(_ log: String) {
        Logger.appLogger.debug("log:\(log)")
    }
    
    public func logDebugInView(_ log: String) -> EmptyView {
        Logger.vlog.debug("log:\(log)")
        return EmptyView()
    }
    
    public func logDebugSimple(_ log: String) {
        Logger.vlog.debug("log:\(log)")
    }
}
