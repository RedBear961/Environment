//
//  DaemonView.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 11.03.2023.
//

import SwiftUI
import AppKit

enum DaemonSelection {

	case main
	case launch

	var localized: String {
		switch self {
		case .main:
			return "Основное"
		case .launch:
			return "Запуск"
		}
	}
}

public struct DaemonView: View {

	@ObservedObject var editor: DaemonEditor
	@State var selection: DaemonSelection = .main

	public var body: some View {
		VStack(spacing: 0) {
			ZStack {
				Rectangle()
					.fill(
						Gradient(colors: [
							.clear,
							Color(from: "3C3432")
						])
					)

				Avatar(
					image: $editor.avatar,
					onSelect: editor.onAvatarSelect,
					onDelete: editor.onAvatarDelete
				)
				.frame(height: 100)
				.offset(y: -10)
			}
			.frame(height: 120)

			Divider()

			NavigationSplitView {
				List(selection: $selection) {
					link(to: .main)
					link(to: .launch)
				}
				.padding(.vertical, 8)
			} detail: {
				ScrollView {
					VStack(spacing: 16) {
						switch selection {
						case .main:
							mainSection
						case .launch:
							launchSection(launch: $editor.daemon.launch)
						}
					}
					.padding()
				}
			}
			.navigationSplitViewStyle(.balanced)
		}
		.toolbar {
			Text("Новый сервис")
				.font(.system(size: 15, weight: .semibold))
		}
    }

	var siderbar: some View {
		List {
			link(to: .main)
			link(to: .launch)
		}
		.padding(.vertical, 8)
	}

	func link(to selection: DaemonSelection) -> some View {
		NavigationLink(value: selection) {
			Text(selection.localized)
		}
	}

	@ViewBuilder func launchSection(launch: Binding<DaemonLaunch>) -> some View {
		RoundedSection {
			ExecutionPicker(
				title: "Запуск",
				executionType: launch.type
			)

			Divider()

			switch editor.daemon.launch.type {
			case .executableFile:
				TextFieldSettingRow(
					title: "Путь",
					placeholder: "Обязательно",
					text: launch.path
				)

				Divider()

				TextFieldSettingRow(
					title: "Аргументы",
					placeholder: "Необязательно",
					text: launch.arguments
				)
			case .shellCommand:
				TextFieldSettingRow(
					title: "Команда",
					placeholder: "Обязательно",
					text: launch.command
				)
			}
		}

		RoundedSection {
			ToggleSettingRow(
				title: "Запускать при входе в систему",
				isOn: $editor.daemon.launch.executeOnStart
			)

			Divider()

			ToggleSettingRow(
				title: "Выполнять от имени администратора",
				isOn: $editor.daemon.launch.runAsAdmin
			)
		}
	}

	@ViewBuilder var mainSection: some View {
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
	}
}

struct DaemonView_Previews: PreviewProvider {

    static var previews: some View {
		DaemonView(editor: DaemonEditor(daemon: Daemon()))
			.frame(width: 650, height: 500)
    }
}
