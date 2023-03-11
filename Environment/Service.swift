//
//  Service.swift
//  Environment
//
//  Created by  User on 08.03.2023.
//

import SwiftUI

@objc(Service)
public final class Service: NSManagedObject {
    
    @objc public enum Status: Int16 {
        
        case active
        case loading
        case reloading
        case disabling
        case disable
        
        var localized: String {
            switch self {
            case .active:       return "Активно"
            case .loading:      return "Запуск"
            case .reloading:    return "Перезапуск"
            case .disabling:    return "Выключение"
            case .disable:      return "Выключено"
            }
        }
        
        var color: Color {
            switch self {
            case .active:   return .green
            case .loading, .reloading, .disabling:
                return .yellow
            case .disable:  return .red
            }
        }
        
        var isInProgress: Bool {
            return self == .loading || self == .disabling || self == .reloading
        }
    }
    
    @NSManaged public var name: String
    @NSManaged public var image: String
    @NSManaged public var startupURL: URL
    @NSManaged public var startupArgs: [String]
    @NSManaged public var shutdown: URL
    @NSManaged public var shutdownArgs: [String]
    
    public var status: Status = .disable
}

extension Service {
    
    
}

public struct LaunchData {
    
    public let executableURL: URL
    public let arguments: String
}
