//
//  DaemonEditor.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 25.03.2023.
//

import SwiftUI
import Combine
import Quartz

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
		guard let imagePicker = IKPictureTaker.pictureTaker() else {
			preconditionFailure()
		}

		let result = imagePicker.runModal()
		guard NSApplication.ModalResponse(result) == .OK,
			  let nsImage = imagePicker.outputImage() else {
			return
		}

		daemon.image = nsImage.tiffRepresentation
		avatar = Image(nsImage: nsImage)
	}

	func onAvatarDelete() {
		daemon.image = nil
		avatar = nil
	}
}
