import Foundation

enum WWDC22Articles: CaseIterable {
    case whatsNewInSFSymbols4
    case complicationsAndWidgetsReloaded
    case createParametric3DRoomScansWithRoomPlan
    case helloSwiftCharts

    var value: Article {
        switch self {
        case .whatsNewInSFSymbols4:
            return .init(item: WhatsNewInSFSymbols4())
        case .complicationsAndWidgetsReloaded:
            return .init(item: ComplicationsAndWidgetsReloaded())
        case .createParametric3DRoomScansWithRoomPlan:
            return .init(item: CreateParametric3DRoomScansWithRoomPlan())
        case .helloSwiftCharts:
            return .init(item: HelloSwiftCharts())
        }
    }
}
