//
//  View+border.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 25.03.2023.
//

import SwiftUI

extension View {

	func hidden(_ isHidden: Bool) -> some View {
		self.opacity(isHidden ? 0 : 1)
	}
}
