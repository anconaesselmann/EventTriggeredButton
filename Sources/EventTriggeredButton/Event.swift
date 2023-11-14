//  Created by Axel Ancona Esselmann on 11/13/23.
//

import Foundation

public struct Event {
    public let id: UUID
    public let sender: UUID

    public init(id: UUID, sender: UUID) {
        self.id = id
        self.sender = sender
    }
}
