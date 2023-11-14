//  Created by Axel Ancona Esselmann on 11/13/23.
//

import Foundation
import Combine

public protocol EventManager {
    func eventFired(_ event: Event)
    var events: PassthroughSubject<Event, Never> { get }
}
