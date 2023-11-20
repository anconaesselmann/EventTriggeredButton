//  Created by Axel Ancona Esselmann on 11/13/23.
//

import SwiftUI
import Combine

public struct ETButton<L>: View
    where L: View
{
    @ViewBuilder
    private var label: () -> L

    private var action: () -> Void
    private var registration: ETButtonViewModel.Registration? = nil

    @StateObject
    private var vm = ETButtonViewModel()

    public var body: some View {
        SwiftUI.Button(
            action: { vm.action?() },
            label: label
        )
        .onAppear {
            vm.register(registration, action: action)
        }
    }

    @MainActor
    public func register(eventId: UUID, manager: EventManager) -> Self {
        var new = self
        new.registration = .init(eventId: eventId, manager: manager)
        return new
    }
}

public extension ETButton where L == Label<Text, Image> {
    init(action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Label<Text, Image>) {
        self.label = label
        self.action = action
    }
}

public extension  ETButton where L == Text {
    init(_ titleKey: LocalizedStringKey, action: @escaping () -> Void) {
        self.label = {
            Text(titleKey)
        }
        self.action = action
    }
}

public extension  ETButton where L == SwiftUI.Label<Text, Image> {
    init(_ titleKey: LocalizedStringKey, systemImage: String, action: @escaping () -> Void) {
        self.label = {
            Label(titleKey, systemImage: systemImage)
        }
        self.action = action
    }

    init<S>(_ title: S, systemImage: String, action: @escaping () -> Void) where S : StringProtocol {
        self.label = {
            Label(title, systemImage: systemImage)
        }
        self.action = action
    }

    @available(iOS 17.0, *)
    @available(macOS 14.0, *)
    @available(tvOS 17.0, *)
    init(_ titleKey: LocalizedStringKey, image: ImageResource, action: @escaping () -> Void) {
        self.label = {
            Label(titleKey, image: image)
        }
        self.action = action
    }

    @available(iOS 17.0, *)
    @available(macOS 14.0, *)
    @available(tvOS 17.0, *)
    init<S>(_ title: S, image: ImageResource, action: @escaping () -> Void) where S : StringProtocol {
        self.label = {
            Label(title, image: image)
        }
        self.action = action
    }
}
