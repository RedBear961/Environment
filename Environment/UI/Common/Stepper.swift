//
//  Stepper.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 25.03.2023.
//

import SwiftUI

public struct Stepper: View {

	@Binding public var value: Int
	public var onIncrement: () -> Void
	public var onDecrement: () -> Void

	public var body: some View {
		HStack {
			Button(action: { value += 1; onIncrement() }) {
				Image(systemName: "plus")
			}

			Rectangle()
				.frame(width: 1, height: 16)
				.foregroundColor(Color(from: "4C4342"))

			Button(action: { value -= 1; onDecrement() }) {
				Image(systemName: "minus")
			}
			.disabled(value == 0)
		}
		.buttonStyle(.plain)
		.padding(.vertical, 4)
		.padding(.horizontal, 8)
	}
}

struct RoundedStepper_Previews: PreviewProvider {
	
    static var previews: some View {
		Stepper(value: .constant(0), onIncrement: {}, onDecrement: {})
    }
}
