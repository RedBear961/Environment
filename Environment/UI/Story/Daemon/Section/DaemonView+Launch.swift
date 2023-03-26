//
//  DaemonView+Launch.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 25.03.2023.
//

import SwiftUI

extension DaemonView {

	@ViewBuilder public func launchSection(launch: Binding<DaemonLaunch>) -> some View {
		RoundedSection {
			ExecutionPicker(
				title: "Запуск",
				execution: launch.type
			)

			Divider()

			executionDetails(for: launch)
		}

		RoundedSection {
			ToggleSettingRow(
				title: "Запускать при входе в систему",
				isOn: launch.executeOnStart
			)

			Divider()

			ToggleSettingRow(
				title: "Выполнять от имени администратора",
				isOn: launch.runAsAdmin
			)
		}
	}
}
