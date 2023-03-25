//
//  Monitor.swift
//  Environment
//
//  Created by  User on 08.03.2023.
//

import SwiftUI

public final class Monitor: ObservableObject {
    
    @Published public var services: [Daemon]
    
    public init() {
        services = []
    }
    
    public func start(_ service: Daemon) {
        let index = services.firstIndex { $0.name == service.name }
        service.status = .loading
        services[index!] = service
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            service.status = .active
            self.services[index!] = service
        }
    }
    
    public func stop(_ service: Daemon) {
        let index = services.firstIndex { $0.name == service.name }
        service.status = .disabling
        services[index!] = service
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            service.status = .disable
            self.services[index!] = service
        }
    }
    
    public func restart(_ service: Daemon) {
        let index = services.firstIndex { $0.name == service.name }
        service.status = .reloading
        services[index!] = service
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            service.status = .active
            self.services[index!] = service
        }
    }
}
