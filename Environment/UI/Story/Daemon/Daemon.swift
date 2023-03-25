//
//  Daemon.swift
//  Environment
//
//  Created by  User on 08.03.2023.
//

import SwiftUI

public enum DaemonStatus: Int {

	case active
	case loading
	case reloading
	case disabling
	case disable

	public var localized: String {
		switch self {
		case .active:       return "Активно"
		case .loading:      return "Запуск"
		case .reloading:    return "Перезапуск"
		case .disabling:    return "Выключение"
		case .disable:      return "Выключено"
		}
	}

	public var color: Color {
		switch self {
		case .active:
			return .green
		case .loading, .reloading, .disabling:
			return .yellow
		case .disable:
			return .red
		}
	}
}

@objc(Daemon)
public final class Daemon: NSManagedObject {

    @NSManaged public var name: String
    @NSManaged public var image: Data?
	@NSManaged public var detail: String
	@NSManaged public var port: Int
	@NSManaged public var process: String
	@NSManaged public var launch: DaemonLaunch
	@NSManaged public var stop: DaemonStop
    
    public var status: DaemonStatus = .disable
}
