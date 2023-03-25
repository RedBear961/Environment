//
//  DaemonView.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 11.03.2023.
//

import SwiftUI
import AppKit

public struct DaemonView: View {

	@ObservedObject var editor: DaemonEditor

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

			ScrollView {
				VStack(spacing: 16) {
					mainSection

					RoundedListSection {
						VStack(spacing: 12) {
							HStack {
								Text("Запуск")

								Spacer()

								Picker("", selection: $editor.daemon.launch) {
									Text("Исполняемый файл")
										.tag(ExecutionType.executableFile)

									Text("Shell-команда")
										.tag(ExecutionType.shellCommand)
								}
								.pickerStyle(.menu)
								.frame(maxWidth: 200)
								.labelsHidden()
								.clipped()
								.scaledToFit()
							}

							Divider()

							switch editor.daemon.launch.type {
							case .executableFile:
								SettingRow(
									title: "Путь",
									placeholder: "Обязательно",
									text: $editor.daemon.launch.path
								)

								Divider()

								SettingRow(
									title: "Аргументы",
									placeholder: "Необязательно",
									text: $editor.daemon.launch.arguments
								)
							case .shellCommand:
								SettingRow(
									title: "Команда",
									placeholder: "Обязательно",
									text: $editor.daemon.launch.command
								)
							}

							Divider()

							ToggleSettingsRow(
								title: "Запускать при входе в систему",
								isOn: $editor.daemon.launch.executeOnStart
							)

							Divider()

							ToggleSettingsRow(
								title: "Выполнять от имени администратора",
								isOn: $editor.daemon.launch.runAsAdmin
							)
						}
					}
				}
				.padding()
			}
		}
		.toolbar {
			Text("Новый сервис")
				.font(.system(size: 15, weight: .semibold))
		}
    }

	@ViewBuilder var mainSection: some View {
		RoundedListSection {
			SettingRow(
				title: "Отображаемое имя",
				placeholder: "Обязательно",
				text: $editor.daemon.name
			)

			Divider()

			SettingRow(
				title: "Описание",
				placeholder: "Необязательно",
				isHaveSpacer: false,
				text: $editor.daemon.detail
			)
		}
	}
}

struct SettingRow: View {

	public var title: String
	public var placeholder: String
	public var isHaveSpacer: Bool = true

	@Binding public var text: String

	var body: some View {
		HStack {
			Text(title)

			if isHaveSpacer {
				Spacer()
			}

			TextField(placeholder, text: $text)
				.textFieldStyle(.plain)
				.multilineTextAlignment(.trailing)
		}
	}
}

struct ToggleSettingsRow: View {

	public var title: String
	@Binding public var isOn: Bool

	var body: some View {
		HStack {
			Text(title)

			Spacer()

			Toggle("", isOn: $isOn)
				.toggleStyle(.switch)
		}
	}
}

struct DaemonView_Previews: PreviewProvider {

    static var previews: some View {
		DaemonView(editor: DaemonEditor(daemon: Daemon()))
			.frame(width: 650, height: 500)
    }
}

// Иконка
// Имя
// Описание

// 2.1 Запуск по команде
// Команда

// 2.2 Запуск по исполняемому файлу
// Путь
// Аргументы

// 2
// Запускать от имени администратора
// Запускать при входе в систему
// Запускать после старта N/через X времени после старта N

// 3.1 Остановка по команде
// 3.2 Остановка по исполняемому файлу

// 3
// Останавливать от имени администратора
// Оповещать при незапланированной остановке
// Останавливать, если был остановлен N

// Перезапуск
// Активен
// По команде/исполняемому файл/использовать данные запуска
// Перезапуск каждые N часов/дней/...
// Перезапуск каждый(-ую) X в Y часов

// 5
// Порт
// Имя процесса/группа процессов
