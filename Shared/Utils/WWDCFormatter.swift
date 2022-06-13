import Foundation

struct WWDCFormatter {
    static func convertString<T: ArticleProtocol>(item: T) -> [String] {
        let content: [String] = (0...item.english.components(separatedBy: "\n").count).compactMap { index -> String? in
            let en = item.english.components(separatedBy: "\n")[safe: index]
            let jp = item.japanese.components(separatedBy: "\n")[safe: index]

            return (en ?? "") + "\n" + (jp ?? "")
        }
        return content
    }
}
