//
//  StepperList.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 25.03.2023.
//

import SwiftUI

private let kCornerRadius: CGFloat = 8

public struct StepperList<Content: View>: View {

	@Binding public var count: Int
	@ViewBuilder public var content: () -> Content

	public var body: some View {
		ZStack {
			VStack(spacing: 0) {
				VStack {
					if count == 0 {
						Text("Нет правил остановки сервиса")
							.foregroundColor(.secondary)
							.padding(8)
					} else {
						content()
					}
				}
				.frame(maxWidth: .infinity, alignment: .center)
				.background(Color(from: "362D2B"))

				Divider()
					.frame(maxWidth: .infinity)

				VStack(spacing: 12) {
					HStack {
						Stepper(value: $count, onIncrement: {}, onDecrement: {})
						Spacer()
					}
					.padding(4)
				}
				.background(Color(from: "2E2927"))
			}

			RoundedRectangle(cornerRadius: kCornerRadius, style: .continuous)
				.border(Color(from: "473F3D"))
				.foregroundColor(.clear)
		}
		.clipShape(
			RoundedRectangle(cornerRadius: kCornerRadius)
		)
	}
}

struct StepperList_Previews: PreviewProvider {

    static var previews: some View {
		StepperList(count: .constant(0)) {}
			.frame(width: 400, height: 100)
			.padding()
			.background(Color.black)
    }
}
