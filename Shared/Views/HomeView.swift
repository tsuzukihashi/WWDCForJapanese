import SwiftUI
import NukeUI

struct HomeView: View {
    @State var searchQuery: String = ""
    @State var articles: [WWDC22Articles] = WWDC22Articles.allCases
    @Environment(\.isSearching) private var isSearching

    var body: some View {
        NavigationView {
            List {
                ForEach(articles, id: \.self) { article in
                    NavigationLink {
                        ItemDetailView(article: article.value)
                    } label: {
                        HStack {
                            LazyImage(source: article.value.imageUrl, resizingMode: .aspectFill)
                                .frame(width: 80, height: 50, alignment: .center)
                            Text(article.value.title)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "セッション名")
            .onSubmit(of: .search) {
                if searchQuery.isEmpty {
                    articles = WWDC22Articles.allCases
                } else {
                    articles = articles.filter({
                        $0.value.title.contains(searchQuery) ||
                        $0.value.title.lowercased().contains(searchQuery) ||
                        $0.value.title.uppercased().contains(searchQuery)
                    })
                }
            }
            .onChange(of: searchQuery, perform: { newValue in
                if newValue.isEmpty {
                    articles = WWDC22Articles.allCases
                }
            })
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text(String(WWDC22Articles.allCases.count))
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
