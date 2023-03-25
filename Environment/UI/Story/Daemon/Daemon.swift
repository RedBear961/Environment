//
//  Daemon.swift
//  Environment
//
//  Created by  User on 08.03.2023.
//

import SwiftUI

@objc public enum ExecutionType: Int {

	case executableFile
	case shellCommand
}

public enum DaemonStatus: Int {

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
		case .active:
			return .green
		case .loading, .reloading, .disabling:
			return .yellow
		case .disable:
			return .red
		}
	}
}

@objc(Service)
public final class Daemon: NSManagedObject {

    @NSManaged public var name: String
    @NSManaged public var image: Data?
	@NSManaged public var detail: String
	@NSManaged public var port: Int
	@NSManaged public var process: String
	@NSManaged public var launch: ExecutionDetails
	@NSManaged public var stop: ExecutionDetails
    
    public var status: DaemonStatus = .disable
}

@objc(ExecutionDetails)
public final class ExecutionDetails: NSManagedObject {

	@NSManaged public var type: ExecutionType
	@NSManaged public var path: String
	@NSManaged public var arguments: String
	@NSManaged public var command: String
	@NSManaged public var executeOnStart: Bool
	@NSManaged public var runAsAdmin: Bool
}
