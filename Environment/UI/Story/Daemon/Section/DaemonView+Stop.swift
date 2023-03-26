//
//  DaemonView+Stop.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 25.03.2023.
//

import SwiftUI

extension DaemonView {

	@ViewBuilder public func stopSection(stop: Binding<DaemonStop>) -> some View {
		RoundedSection {
			ExecutionPicker(
				title: "Остановка",
				execution: stop.type
			)

			Divider()

			executionDetails(for: stop)
		}

		RoundedSection {
			ToggleSettingRow(
				title: "Выполнять от имени администратора",
				isOn: stop.runAsAdmin
			)

			Divider()

			ToggleSettingRow(
				title: "Оповещать при незапланированной остановке",
				isOn: .constant(false)
			)
		}

		StepperList(count: .constant(0)) {
		}
	}
}
