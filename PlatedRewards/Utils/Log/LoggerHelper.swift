//
//  LoggerHelper.swift
//  PlatedRewards
//
//  Created by Rachit Prajapati on 9/12/24.
//

import Foundation
import OSLog

// Application level logging service for convenient logging support
struct LoggerHelper {
    private static let subsystem = Bundle.main.bundleIdentifier! 
    static let apiLogger = Logger(subsystem: subsystem, category: "API")
    static let networkLogger = Logger(subsystem: subsystem, category: "Network")
    static let generalLogger = Logger(subsystem: subsystem, category: "General")
}
