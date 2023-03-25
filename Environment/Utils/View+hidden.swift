//
//  View+hidden.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 25.03.2023.
//

import SwiftUI

extension View where Self: InsettableShape {

	public func border<S: ShapeStyle>(_ content: S, width: CGFloat = 1) -> some View {
		 clipShape(self)
			  .overlay(self.strokeBorder(content, lineWidth: width))
	 }
 }
