//
//  ExecutionPicker.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 25.03.2023.
//

import SwiftUI

public struct ExecutionPicker: View {

	public var title: String
	@Binding public var executionType: Execution

	public var body: some View {
		HStack {
			Text(title)

			Spacer()

			Picker("", selection: $executionType) {
				Text("Исполняемый файл")
					.tag(Execution.executableFile)

				Text("Shell-команда")
					.tag(Execution.shellCommand)
			}
			.pickerStyle(.menu)
			.frame(width: 180)
			.labelsHidden()
			.clipped()
			.scaledToFit()
		}
	}
}

struct ExecutionPicker_Previews: PreviewProvider {

    static var previews: some View {
		ExecutionPicker(
			title: "Запуск",
			executionType: .constant(.executableFile)
		)
    }
}
