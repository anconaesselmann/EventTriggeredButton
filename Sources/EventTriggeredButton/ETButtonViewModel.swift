//  Created by Axel Ancona Esselmann on 11/13/23.
//

import Foundation
import Combine

@MainActor
final internal class ETButtonViewModel: ObservableObject {

    internal struct Registration {
        internal let eventId: UUID
        internal let manager: EventManager
    }

    internal private(set)
    var action: (() -> Void)?

    private var registration: Registration?
    private var bag: AnyCancellable?

    internal func register(
        _ registration: Registration?,
        action: @escaping () -> Void
    ) {
        let senderId = UUID()
        self.registration = registration
        self.action = {
            action()
            if let registration = registration {
                let event = Event(id: registration.eventId, sender: senderId)
                registration.manager.eventFired(event)
            }
        }
        bag = registration?.manager.events
            .filter {
                $0.sender != senderId &&
                $0.id == registration?.eventId
            }
            .sink { [weak self] eventId in
                self?.action?()
            }
    }
}
