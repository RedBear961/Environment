//
//  ToggleSettingRow.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 25.03.2023.
//

import SwiftUI

public struct ToggleSettingRow: View {

	public var title: String
	@Binding public var isOn: Bool

	public var body: some View {
		HStack {
			Text(title)

			Spacer()

			Toggle("", isOn: $isOn)
				.toggleStyle(.switch)
		}
	}
}

struct ToggleSettingRow_Previews: PreviewProvider {

    static var previews: some View {
		ToggleSettingRow(title: "Запускать при входе", isOn: .constant(false))
    }
}
