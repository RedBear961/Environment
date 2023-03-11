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
                ForEach(monitor.services, id: \.name) { service in
                    HStack {
                        StatusView(service: service)
                        
                        if service.status.isInProgress {
                            ProgressView()
                                .progressViewStyle(.linear)
                                .offset(y: -9)
                        }
                        
                        Spacer(minLength: 40)
                        
                        ActionView(
                            monitor: monitor,
                            service: service
                        )
                    }
                    .padding()
                }
                .listRowSeparator(.visible)
            }
            .toolbar {
                NavigationLink(destination: { AddServiceView() }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

extension MonitorView {
    
    struct StatusView: View {
        
        public let service: Service
        
        var body: some View {
            HStack {
                Image(service.image)
                    .resizable()
                    .frame(width: 48, height: 48)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(service.name)
                        .font(.title2)
                    
                    HStack {
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(service.status.color)
                        
                        Text(service.status.localized)
                    }
                }
            }
        }
    }
    
    struct ActionView: View {
        
        @ObservedObject public var monitor: Monitor
        public let service: Service
        
        var body: some View {
            ZStack {
                VStack {
                    switch service.status {
                    case .active, .disabling, .reloading:
                        Button(action: { monitor.restart(service) }) {
                            Text("Перезапуск")
                        }
                        
                        Button(action: { monitor.stop(service) }) {
                            Text("Остановить")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                    case .disable, .loading:
                        Button(action: { monitor.start(service) }) {
                            Text("Запустить")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.blue)
                    }
                }
                .disabled(service.status.isInProgress)
            }
        }
    }
}

struct MonitorView_Previews: PreviewProvider {
    
    static var previews: some View {
        MonitorView()
    }
}
