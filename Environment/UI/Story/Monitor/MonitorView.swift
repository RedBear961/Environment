//
//  MonitorView.swift
//  Environment
//
//  Created by  User on 08.03.2023.
//

import SwiftUI

public struct MonitorView: View {
    
    @ObservedObject public var monitor = Monitor()
    
    public var body: some View {
        NavigationStack {
            List {
                ForEach(monitor.services, id: \.name) { daemon in
                    HStack {
                        statusView(daemon)
                        
                        Spacer(minLength: 40)
                        
                        actionView(daemon)
                    }
                    .padding()
                }
                .listRowSeparator(.visible)
            }
            .toolbar {
				toolbar
            }
        }
    }

	@ViewBuilder func statusView(_ daemon: Daemon) -> some View {
		HStack {
			Image(data: daemon.image, default: "template_icon")
				.resizable()
				.frame(width: 48, height: 48)

			VStack(alignment: .leading, spacing: 4) {
				Text(daemon.name)
					.font(.title2)

				HStack {
					Circle()
						.frame(width: 8, height: 8)
						.foregroundColor(daemon.status.color)

					Text(daemon.status.localized)
				}
			}
		}
	}

	@ViewBuilder func actionView(_ daemon: Daemon) -> some View {
		VStack {
			switch daemon.status {
			case .active, .disabling, .reloading:
				Button("Перезапуск", action: { monitor.restart(daemon) })

				Button("Остановить", action: { monitor.stop(daemon) })
					.buttonStyle(.borderedProminent)
					.tint(.red)
			case .disable, .loading:
				Button("Запустить", action: { monitor.start(daemon) })
				.buttonStyle(.borderedProminent)
				.tint(.blue)
			}
		}
		.disabled(daemon.status.color == .yellow)
	}

	@ViewBuilder var toolbar: some View {
		Text("Мониторинг")
			.font(.system(size: 15, weight: .semibold))

		NavigationLink(destination: monitor.newDaemon) {
			Image(systemName: "plus")
		}
	}
}

struct MonitorView_Previews: PreviewProvider {
    
    static var previews: some View {
        MonitorView()
    }
}
