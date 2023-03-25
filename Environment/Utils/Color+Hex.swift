//
//  Color+Utils.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 13.03.2023.
//

import SwiftUI

extension Color {

	/// Создает экземпляр `UIColor` из hex-строки.
	public init(from hex: String) {
		let hex = hex
			.replacingOccurrences(of: "#", with: "")
			.trimmingCharacters(in: .whitespacesAndNewlines)
			.uppercased()

		guard hex.count == 6 else {
			preconditionFailure("Невалидная HEX-строка \(hex)")
		}

		var rgbValue = UInt64()
		let scanner = Scanner(string: hex)
		scanner.scanHexInt64(&rgbValue)

		let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
		let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
		let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

		self.init(red: red, green: green, blue: blue)
	}
}
