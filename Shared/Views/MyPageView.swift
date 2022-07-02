import SwiftUI

struct MyPageView: View {
    var body: some View {
        NavigationView {
            Text("MyPage")
                .navigationTitle("MyPage")
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
