import SwiftUI
import UIKit

public extension Color {
    static let appleBlue = Color(red: 0x00 / 255.0, green: 0x71 / 255.0, blue: 0xE3 / 255.0)

    static let linkBlue = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0x29 / 255.0, green: 0x97 / 255.0, blue: 0xFF / 255.0, alpha: 1.0)
            : UIColor(red: 0x00 / 255.0, green: 0x66 / 255.0, blue: 0xCC / 255.0, alpha: 1.0)
    })

    static let signalBlue = Color(red: 0x29 / 255.0, green: 0x97 / 255.0, blue: 0xFF / 255.0)

    static let appCanvas = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0x00 / 255.0, green: 0x00 / 255.0, blue: 0x00 / 255.0, alpha: 1.0)
            : UIColor(red: 0xF5 / 255.0, green: 0xF5 / 255.0, blue: 0xF7 / 255.0, alpha: 1.0)
    })

    static let appWash = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0x1D / 255.0, green: 0x1D / 255.0, blue: 0x1F / 255.0, alpha: 1.0)
            : UIColor(red: 0xF4 / 255.0, green: 0xF8 / 255.0, blue: 0xFB / 255.0, alpha: 1.0)
    })

    static let appPebble = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0x33 / 255.0, green: 0x33 / 255.0, blue: 0x33 / 255.0, alpha: 1.0)
            : UIColor(red: 0xE2 / 255.0, green: 0xE2 / 255.0, blue: 0xE5 / 255.0, alpha: 1.0)
    })

    static let appCarbon = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0xF5 / 255.0, green: 0xF5 / 255.0, blue: 0xF7 / 255.0, alpha: 1.0)
            : UIColor(red: 0x1D / 255.0, green: 0x1D / 255.0, blue: 0x1F / 255.0, alpha: 1.0)
    })

    static let appAsh = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0xA1 / 255.0, green: 0xA1 / 255.0, blue: 0xA6 / 255.0, alpha: 1.0)
            : UIColor(red: 0x70 / 255.0, green: 0x70 / 255.0, blue: 0x70 / 255.0, alpha: 1.0)
    })

    static let appHairline = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0x33 / 255.0, green: 0x33 / 255.0, blue: 0x33 / 255.0, alpha: 1.0)
            : UIColor(red: 0xD2 / 255.0, green: 0xD2 / 255.0, blue: 0xD7 / 255.0, alpha: 1.0)
    })

    static let appSuccess = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0x30 / 255.0, green: 0xD1 / 255.0, blue: 0x58 / 255.0, alpha: 1.0)
            : UIColor(red: 0x24 / 255.0, green: 0x8A / 255.0, blue: 0x3D / 255.0, alpha: 1.0)
    })

    static let appError = Color(uiColor: UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0xFF / 255.0, green: 0x45 / 255.0, blue: 0x3A / 255.0, alpha: 1.0)
            : UIColor(red: 0xD7 / 255.0, green: 0x00 / 255.0, blue: 0x15 / 255.0, alpha: 1.0)
    })

    /// Fixed high-contrast text for filled appleBlue buttons in both appearances
    static let primaryButtonText = Color(red: 0xF4 / 255.0, green: 0xF8 / 255.0, blue: 0xFB / 255.0)
}
