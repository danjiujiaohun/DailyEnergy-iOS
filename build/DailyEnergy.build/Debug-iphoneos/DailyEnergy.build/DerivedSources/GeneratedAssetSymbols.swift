import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
extension ColorResource {

    /// The "color_000000" asset catalog color resource.
    static let color000000 = ColorResource(name: "color_000000", bundle: resourceBundle)

    /// The "color_24292B" asset catalog color resource.
    static let color24292B = ColorResource(name: "color_24292B", bundle: resourceBundle)

    /// The "color_9DA2A5" asset catalog color resource.
    static let color9DA2A5 = ColorResource(name: "color_9DA2A5", bundle: resourceBundle)

    /// The "color_FF453A" asset catalog color resource.
    static let colorFF453A = ColorResource(name: "color_FF453A", bundle: resourceBundle)

    /// The "color_FFFFFF" asset catalog color resource.
    static let colorFFFFFF = ColorResource(name: "color_FFFFFF", bundle: resourceBundle)

}

// MARK: - Image Symbols -

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
extension ImageResource {

    /// The "image_avatar_default" asset catalog image resource.
    static let imageAvatarDefault = ImageResource(name: "image_avatar_default", bundle: resourceBundle)

    /// The "image_back_icon" asset catalog image resource.
    static let imageBackIcon = ImageResource(name: "image_back_icon", bundle: resourceBundle)

    /// The "image_close_btn" asset catalog image resource.
    static let imageCloseBtn = ImageResource(name: "image_close_btn", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// The "color_000000" asset catalog color.
    static var color000000: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .color000000)
#else
        .init()
#endif
    }

    /// The "color_24292B" asset catalog color.
    static var color24292B: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .color24292B)
#else
        .init()
#endif
    }

    /// The "color_9DA2A5" asset catalog color.
    static var color9DA2A5: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .color9DA2A5)
#else
        .init()
#endif
    }

    /// The "color_FF453A" asset catalog color.
    static var colorFF453A: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .colorFF453A)
#else
        .init()
#endif
    }

    /// The "color_FFFFFF" asset catalog color.
    static var colorFFFFFF: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .colorFFFFFF)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// The "color_000000" asset catalog color.
    static var color000000: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .color000000)
#else
        .init()
#endif
    }

    /// The "color_24292B" asset catalog color.
    static var color24292B: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .color24292B)
#else
        .init()
#endif
    }

    /// The "color_9DA2A5" asset catalog color.
    static var color9DA2A5: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .color9DA2A5)
#else
        .init()
#endif
    }

    /// The "color_FF453A" asset catalog color.
    static var colorFF453A: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .colorFF453A)
#else
        .init()
#endif
    }

    /// The "color_FFFFFF" asset catalog color.
    static var colorFFFFFF: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .colorFFFFFF)
#else
        .init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// The "color_000000" asset catalog color.
    static var color000000: SwiftUI.Color { .init(.color000000) }

    /// The "color_24292B" asset catalog color.
    static var color24292B: SwiftUI.Color { .init(.color24292B) }

    /// The "color_9DA2A5" asset catalog color.
    static var color9DA2A5: SwiftUI.Color { .init(.color9DA2A5) }

    /// The "color_FF453A" asset catalog color.
    static var colorFF453A: SwiftUI.Color { .init(.colorFF453A) }

    /// The "color_FFFFFF" asset catalog color.
    static var colorFFFFFF: SwiftUI.Color { .init(.colorFFFFFF) }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    /// The "color_000000" asset catalog color.
    static var color000000: SwiftUI.Color { .init(.color000000) }

    /// The "color_24292B" asset catalog color.
    static var color24292B: SwiftUI.Color { .init(.color24292B) }

    /// The "color_9DA2A5" asset catalog color.
    static var color9DA2A5: SwiftUI.Color { .init(.color9DA2A5) }

    /// The "color_FF453A" asset catalog color.
    static var colorFF453A: SwiftUI.Color { .init(.colorFF453A) }

    /// The "color_FFFFFF" asset catalog color.
    static var colorFFFFFF: SwiftUI.Color { .init(.colorFFFFFF) }

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "image_avatar_default" asset catalog image.
    static var imageAvatarDefault: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .imageAvatarDefault)
#else
        .init()
#endif
    }

    /// The "image_back_icon" asset catalog image.
    static var imageBackIcon: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .imageBackIcon)
#else
        .init()
#endif
    }

    /// The "image_close_btn" asset catalog image.
    static var imageCloseBtn: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .imageCloseBtn)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "image_avatar_default" asset catalog image.
    static var imageAvatarDefault: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .imageAvatarDefault)
#else
        .init()
#endif
    }

    /// The "image_back_icon" asset catalog image.
    static var imageBackIcon: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .imageBackIcon)
#else
        .init()
#endif
    }

    /// The "image_close_btn" asset catalog image.
    static var imageCloseBtn: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .imageCloseBtn)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    private convenience init?(thinnableResource: ColorResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

// MARK: - Backwards Deployment Support -

/// A color resource.
struct ColorResource: Swift.Hashable, Swift.Sendable {

    /// An asset catalog color resource name.
    fileprivate let name: Swift.String

    /// An asset catalog color resource bundle.
    fileprivate let bundle: Foundation.Bundle

    /// Initialize a `ColorResource` with `name` and `bundle`.
    init(name: Swift.String, bundle: Foundation.Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

/// An image resource.
struct ImageResource: Swift.Hashable, Swift.Sendable {

    /// An asset catalog image resource name.
    fileprivate let name: Swift.String

    /// An asset catalog image resource bundle.
    fileprivate let bundle: Foundation.Bundle

    /// Initialize an `ImageResource` with `name` and `bundle`.
    init(name: Swift.String, bundle: Foundation.Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// Initialize a `NSColor` with a color resource.
    convenience init(resource: ColorResource) {
        self.init(named: NSColor.Name(resource.name), bundle: resource.bundle)!
    }

}

protocol _ACResourceInitProtocol {}
extension AppKit.NSImage: _ACResourceInitProtocol {}

@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension _ACResourceInitProtocol {

    /// Initialize a `NSImage` with an image resource.
    init(resource: ImageResource) {
        self = resource.bundle.image(forResource: NSImage.Name(resource.name))! as! Self
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// Initialize a `UIColor` with a color resource.
    convenience init(resource: ColorResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}

@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// Initialize a `UIImage` with an image resource.
    convenience init(resource: ImageResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// Initialize a `Color` with a color resource.
    init(_ resource: ColorResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Image {

    /// Initialize an `Image` with an image resource.
    init(_ resource: ImageResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}
#endif