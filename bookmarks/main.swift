//
//  main.swift
//  bookmarks
//
//  Created by Jonathan Dayley on 2/15/23.
//

import ArgumentParser
import Foundation

let kHomePath: String = ProcessInfo.processInfo.environment["HOME"] ?? "/"
let kConfigName = ".bookmarks"
let kConfig: URL = URL(fileURLWithPath: kHomePath)
	.appendingPathComponent(kConfigName)

