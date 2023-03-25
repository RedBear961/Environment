//
//  Image+Data.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 25.03.2023.
//

import AppKit
import SwiftUI

extension Image {

	init(data: Data?, default name: String) {
		guard let data else {
			self = Image(name)
			return
		}

		guard let nsImage = NSImage(data: data) else {
			self = Image(name)
			return
		}

		self = Image(nsImage: nsImage)
	}
}
