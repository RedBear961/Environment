//
//  DaemonStorage.swift
//  Environment
//
//  Created by  User on 08.03.2023.
//

import CoreData

public final class DaemonStorage {

	public static var shared: DaemonStorage = DaemonStorage()
    
    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Environment")
        container.loadPersistentStores { _, error in
            if let error {
                preconditionFailure(error.localizedDescription)
            }
        }
        return container
    }()
    
    public var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

	public func new() -> Daemon {
		let context = viewContext
		
		let daemon = Daemon(context: context)
		let launch = DaemonLaunch(context: context)
		let stop = DaemonStop(context: context)

		daemon.launch = launch
		daemon.stop = stop

		launch.daemon = daemon
		stop.daemon = daemon

		return daemon
	}
}
