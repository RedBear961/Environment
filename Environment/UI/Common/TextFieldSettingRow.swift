//
//  TextFieldSettingRow.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 25.03.2023.
//

import SwiftUI

struct TextFieldSettingRow: View {

	public var title: String
	public var placeholder: String
	public var isHaveSpacer: Bool = true

	@Binding public var text: String

	public var body: some View {
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

struct TextFieldSettingRow_Previews: PreviewProvider {

    static var previews: some View {
		TextFieldSettingRow(
			title: "Имя",
			placeholder: "Обязательно",
			text: .constant("")
		)
    }
}
