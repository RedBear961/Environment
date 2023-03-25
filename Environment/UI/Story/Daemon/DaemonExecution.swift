//
//  DaemonExecution.swift
//  Environment
//
//  Created by Georgiy Cheremnykh on 25.03.2023.
//

import CoreData

@objc public enum Execution: Int16 {

	case executableFile
	case shellCommand
}

@objc(DaemonExecution)
open class DaemonExecution: NSManagedObject {

	@NSManaged public var type: Execution
	@NSManaged public var path: String
	@NSManaged public var arguments: String
	@NSManaged public var command: String
	@NSManaged public var runAsAdmin: Bool
}

@objc(DaemonLaunch)
public final class DaemonLaunch: DaemonExecution {

	@NSManaged public var executeOnStart: Bool
	@NSManaged public var daemon: Daemon
}

@objc(DaemonStop)
public final class DaemonStop: DaemonExecution {

	@NSManaged public var daemon: Daemon
}
