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
	case stop

	var localized: String {
		switch self {
		case .main:
			return "Основное"
		case .launch:
			return "Запуск"
		case .stop:
			return "Остановка"
		}
	}
}

public struct DaemonView: View {

	@ObservedObject var editor: DaemonEditor
	@State var selection: DaemonSelection = .main

	public var body: some View {
		NavigationSplitView {
			List(selection: $selection) {
				NavigationLink(value: DaemonSelection.main) {
					HStack {
						Image("daemon_icon")
							.resizable()
							.frame(width: 32, height: 32)

						Text(DaemonSelection.main.localized)
					}
				}
				link(to: .launch)
				link(to: .stop)
			}
			.padding(.vertical, 8)
		} detail: {
			ScrollView {
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

					VStack(spacing: 16) {
						switch selection {
						case .main:
							mainSection
						case .launch:
							launchSection(launch: $editor.daemon.launch)
						case .stop:
							stopSection(stop: $editor.daemon.stop)
						}
					}
					.padding()
				}
			}
		}
		.toolbar {
			Text("Новый сервис")
				.font(.system(size: 15, weight: .semibold))

			Spacer()

			Button(action: {}) {
				Text("Сохранить")
			}
			.buttonStyle(.bordered)
			.tint(.blue)
		}
    }

	private func link(to selection: DaemonSelection) -> some View {
		NavigationLink(value: selection) {
			Text(selection.localized)
		}
	}
}

struct DaemonView_Previews: PreviewProvider {

    static var previews: some View {

		DaemonView(editor: DaemonEditor(daemon: Daemon()))
			.frame(width: 650, height: 500)
    }
}
