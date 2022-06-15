import SwiftUI

struct HomeView: View {
    @State var searchQuery: String = ""
    @State var articles: [WWDC22Articles] = WWDC22Articles.allCases
    @Environment(\.isSearching) private var isSearching

    var body: some View {
        NavigationView {
            List {
                ForEach(articles, id: \.self) { article in
                    NavigationLink(article.value.title) {
                        ItemDetailView(article: article.value)
                    }
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search")
            .onSubmit(of: .search) {
                if searchQuery.isEmpty {
                    articles = WWDC22Articles.allCases
                } else {
                    articles = articles.filter({
                        $0.value.title.contains(searchQuery)
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
