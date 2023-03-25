//
//  View+Utils.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 13.03.2023.
//

import SwiftUI

extension View {

	func hidden(_ isHidden: Bool) -> some View {
		self.opacity(isHidden ? 0 : 1)
	}
}

extension View where Self: InsettableShape {

	public func border<S: ShapeStyle>(_ content: S, width: CGFloat = 1) -> some View {
		 clipShape(self)
			  .overlay(self.strokeBorder(content, lineWidth: width))
	 }
 }
