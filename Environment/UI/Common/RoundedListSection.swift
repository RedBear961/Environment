//
//  RoundedListSection.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 25.03.2023.
//

import SwiftUI

public struct RoundedListSection<Content: View>: View {

	public var content: () -> Content

	public var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 8, style: .continuous)
				.border(Color(from: "473F3D"))
				.foregroundColor(Color(from: "362D2B"))

			VStack(spacing: 12) {
				content()
			}
			.padding(12)
		}
	}

	public init(@ViewBuilder content: @escaping () -> Content) {
		self.content = content
	}
}
