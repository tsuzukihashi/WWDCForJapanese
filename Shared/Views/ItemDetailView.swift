import SwiftUI

struct ItemDetailView: View {
    let article: Article
    @State var targetString = ""

    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(WWDCFormatter.convertString(item: article), id: \.self) { text in
                        Text(text)
                            .fontWeight(text == targetString ? .heavy : .light)
                            .textSelection(.enabled)
                            .onTapGesture {
                                targetString = text
                            }
                            .animation(.easeIn, value: targetString)
                    }
                }
                .padding(.horizontal, 8)
            }
        }
        .navigationTitle(article.title)
        .toolbar {
            ToolbarItem(id: "link", placement: .navigationBarTrailing, showsByDefault: true) {
                Link(destination: article.link) {
                    Image(systemName: "link")
                }
            }
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(article: WWDC22Articles.HelloSwiftCharts.value)
    }
}
