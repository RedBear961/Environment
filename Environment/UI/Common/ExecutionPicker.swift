//
//  ExecutionPicker.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 25.03.2023.
//

import SwiftUI

public struct ExecutionPicker: View {

	public var title: String
	@Binding public var execution: Execution

	public var body: some View {
		HStack {
			Text(title)

			Spacer()

			Picker("", selection: $execution) {
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

extension DaemonView {

	@ViewBuilder public func executionDetails<Execution: DaemonExecution>(for execution: Binding<Execution>) -> some View {
		switch execution.type.wrappedValue {
		case .executableFile:
			TextFieldSettingRow(
				title: "Путь",
				placeholder: "Обязательно",
				text: execution.path
			)

			Divider()

			TextFieldSettingRow(
				title: "Аргументы",
				placeholder: "Необязательно",
				text: execution.arguments
			)
		case .shellCommand:
			TextFieldSettingRow(
				title: "Команда",
				placeholder: "Обязательно",
				text: execution.command
			)
		}
	}
}

struct ExecutionPicker_Previews: PreviewProvider {

    static var previews: some View {
		ExecutionPicker(
			title: "Запуск",
			execution: .constant(.executableFile)
		)
    }
}
