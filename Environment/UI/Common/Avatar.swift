//
//  Avatar.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 11.03.2023.
//

import SwiftUI

public struct Avatar: View {

	@Binding public var image: Image?
	public var template = Image("template_icon")
	public var onSelect: () -> Void
	public var onDelete: () -> Void

	@State private var isHover = false
	private var resizedImage: some View {
		(image ?? template)
			.resizable()
			.aspectRatio(contentMode: .fit)
	}

	public var body: some View {
		Button(action: onSelect) {
			resizedImage
				.overlay(
					ZStack {
						Color.black
							.opacity(0.6)
							.mask { resizedImage }

						Image("cam_icon")

						VStack {
							HStack {
								Spacer()
								Button(action: onDelete) {
									Image("close_icon")
								}
								.buttonStyle(.plain)
							}
							Spacer()
						}
					}
					.hidden(!isHover)
				)
		}
		.buttonStyle(.plain)
		.onHover { isHover in
			withAnimation(.linear(duration: 0.1)) {
				self.isHover = isHover
			}
		}
	}
}

struct Avatar_Previews: PreviewProvider {

    static var previews: some View {
		Avatar(image: .constant(Image("jenkins_icon")), onSelect: {}, onDelete: {})
			.frame(height: 64)
    }
}
