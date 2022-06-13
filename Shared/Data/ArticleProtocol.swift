import Foundation

protocol ArticleProtocol: Identifiable, Codable {
    var id: String { get }
    var title: String { get }
    var link: URL { get }
    var english: String { get }
    var japanese: String { get }
}

struct Article: ArticleProtocol {
    var id: String
    var title: String
    var link: URL
    var english: String
    var japanese: String

    init<T: ArticleProtocol>(item: T) {
        self.id = item.id
        self.title = item.title
        self.link = item.link
        self.english = item.english
        self.japanese = item.japanese
    }
}
