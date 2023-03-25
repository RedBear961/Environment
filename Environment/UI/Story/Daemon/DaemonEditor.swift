//
//  DaemonEditor.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 25.03.2023.
//

import SwiftUI
import Combine

final class DaemonEditor: ObservableObject {

	@Published var daemon: Daemon
	@Published var avatar: Image?

	init(daemon: Daemon) {
		self.daemon = daemon
		if let imageData = daemon.image,
		   let nsImage = NSImage(data: imageData) {
			self.avatar = Image(nsImage: nsImage)
		}
	}

	func onAvatarSelect() {

	}

	func onAvatarDelete() {
		self.avatar = nil
	}
}
