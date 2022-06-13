import Foundation

enum WWDC22Articles: CaseIterable {
    case whatsNewInSFSymbols4
    case complicationsAndWidgetsReloaded

    var value: Article {
        switch self {
        case .whatsNewInSFSymbols4:
            return .init(item: WhatsNewInSFSymbols4())
        case .complicationsAndWidgetsReloaded:
            return .init(item: ComplicationsAndWidgetsReloaded())
        }
    }
}
