//
//  DaemonView+Main.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 25.03.2023.
//

import SwiftUI

extension DaemonView {

	@ViewBuilder public var mainSection: some View {
		RoundedSection {
			TextFieldSettingRow(
				title: "Отображаемое имя",
				placeholder: "Обязательно",
				text: $editor.daemon.name
			)

			Divider()

			TextFieldSettingRow(
				title: "Описание",
				placeholder: "Необязательно",
				isHaveSpacer: false,
				text: $editor.daemon.detail
			)
		}

		RoundedSection {
			TextFieldSettingRow(
				title: "Порт",
				placeholder: "Необязательно",
				text: $editor.daemon.port
			)

			Divider()

			TextFieldSettingRow(
				title: "Имя процесса",
				placeholder: "Необязательно",
				text: $editor.daemon.process
			)
		}
	}
}
