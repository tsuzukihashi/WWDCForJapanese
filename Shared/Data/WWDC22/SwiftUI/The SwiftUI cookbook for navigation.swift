import Foundation

struct TheSwiftUICookbookForNavigation: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "The SwiftUI cookbook for navigation"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6547/6547_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10054/")!
    }

    var english: String {
        """
        Hi. I'm Curt, an engineer on the SwiftUI team.
         There are some exciting new APIs for navigation in SwiftUI.
         I've been enjoying building apps with these new APIs and I'm thrilled to be able to share them with you.
         These APIs scale from basic stacks -- like on Apple TV, iPhone, and Apple Watch -- to powerful multicolumn presentations.
         The new APIs bring robust support for programmatic navigation and deep linking, letting you compose pieces to build the perfect structure for your app.
         In this talk, I'll give you some straightforward recipes for cooking up an app with navigation in SwiftUI.
         And if you're already using SwiftUI, we hope these new APIs will help you kick it up a notch.
         I'll start with the ingredients that go into the new data-driven navigation APIs.
         Then, we'll move to our tasting menu: several quick and easy recipes for full programmatic control of navigation.
         For the dessert course, I'll share some tips on using the new APIs to persist navigation state in your apps.
         If you've used navigation in SwiftUI before, you might be wondering how the new APIs are different.
         So before digging in, let's review some of the existing API.
         The existing APIs are based on links that send views that are shown in other columns or on a stack.
         For example, I might have a list of navigation links in a root view.
         When I tap one of these links, the link pushes its view on the stack.
         This works great for basic navigation, and you can continue using this pattern.
         But let's pop back to the root view.
         With the existing navigation API, to present a link programmatically, I add a binding to the link.
         For example, I can present this link's view by setting item.
        showDetail to true.
         But this means I need a separate binding for each link.
         With the new API, we lift the binding up to the entire container, called a NavigationStack.
         The path here is a collection that represents all the values pushed on the stack.
         NavigationLinks append values to the path.
         You can deep link by mutating the path; or pop to the root view by removing all the items from the path.
         In this talk, I'll show you how the new navigation API enables data-driven programmatic navigation.
         I hope you find it powerful and easy to use.
         Before jumping into recipes for using the new navigation APIs, I thought it would be helpful to share what's on the menu.
         I've really gotten into cooking lately and I've been working on an app to keep track of my recipes.
         I have a lot of ideas about different ways to present this info.
         For example, here's a three-column approach.
         The first column lets me select a recipe category.
         When I select a category, the second column lists the recipes I've collected.
         And when I select a recipe, the detail area shows the ingredients for that recipe.
         The detail area also has links to a selection of related recipes.
         My grandma always said, "The crust makes the pie.
        " So that's what we're cooking up today.
         Our ingredients are the new navigation APIs.
         Let's dig into those, then we'll look at some specific navigation recipes that mix them together.
         The new navigation APIs introduce a couple of new container types that you can use to describe the structure of your app, along with a fresh new varietal of NavigationLink for helping your guests move around that structure.
         The first new container is NavigationStack.
         NavigationStack represents a push-pop interface like you see in Find My on Apple Watch, Settings on iPhone, and the new System Settings app on macOS Ventura.
         The second new container type is NavigationSplitView.
         NavigationSplitView is perfect for multicolumn apps like Mail or Notes on Mac and iPad.
         And NavigationSplitView automatically adapts to a single-column stack on iPhone, in Slide Over on iPad, and even on Apple Watch and Apple TV.
         NavigationSplitView has two sets of initializers.
         One set, like shown here, creates a two-column experience.
         The other set of initializers creates a three-column experience.
         NavigationSplitView comes with a cartload of configuration options that let you customize column widths, sidebar presentation, and even programmatically show and hide columns.
         I won't dive into the configuration options in this talk, but please check out my colleague Raj's talk, "SwiftUI on iPad: Organize your interface" and the great documentation on how to tune NavigationSplitView to be just right for your app.
         Previously, NavigationLinks always included a title and view to present.
         The new varieties still include a title, but instead of a view to present, they present a value.
         For example, this link is presenting the recipe for apple pie.
         As we'll see, NavigationLink is smart.
         A link's behavior depends on the NavigationStack or list that it appears in.
         To see how these tasty new APIs work together, let's look at some specific recipes for using them in my cookbook app, and in your apps.
         Our first recipe is a basic stack of views, like you'd find in Find My on Apple Watch or Settings on iPhone.
         I have a section for each category.
         Within a section, I can tap on a recipe to see the details.
         Within any recipe, I can tap one of the related recipes to push it onto the stack.
         I can use the back button to return to the original recipe and then to the categories list.
         This recipe combines a NavigationStack with the new variety of NavigationLink, and a navigation destination modifier.
         Let's see how.
         I'll start with a basic NavigationStack.
         Inside, I have a List that iterates over all my categories and a navigationTitle.
         Inside the List, I have a section for each category.
         Next, inside each section, I'll add a NavigationLink for each recipe in the category.
         For now, I'll make the link present my RecipeDetail view.
         This is using the existing view destination NavigationLink.
         And that's enough to get this navigation experience cooking along.
         But what about programmatic navigation? To add programmatic navigation, I need to tease apart two pieces of this navigation link: the value it presents and the view that goes with that value.
         Let's see how.
         First, I'll pull the destination view out of the link and into the new navigationDestination modifier.
         This modifier declares the type of the presented data that it's responsible for; here, that's a Recipe.
         The modifier takes a view builder that describes what view to push onto the stack when a recipe value is presented.
         Then, I'll switch to one of the new NavigationLinks and just present the recipe value.
         Let's peek under the hood and see how NavigationStack makes this work.
         Every navigation stack keeps track of a path that represents all the data that the stack is showing.
         When the stack is just showing its root view, like shown here, the path is empty.
         Next, the stack also keeps track of all the navigation destinations declared inside it, or inside any view pushed onto the stack.
         In general, this is a set, though for this example, we only have one destination.
         Let's add the pushed views to the diagram, too.
         Now, because the path is empty, so is the list of pushed views.
         Now, like milk and cookies, the magic happens when we put these together.
         When I tap a value-presenting link, it appends that value to the path.
         Then, the navigation stack maps its destinations over the path values to decide which views to push on the stack.
         Now, from my apple pie recipe, if I tap Pie Crust, the link appends that to the path, too.
         NavigationStack does its magic and pushes another RecipeDetail view onto the stack.
         For every value I add to the path, NavigationStack pushes another view.
         When I tap the back button, NavigationStack removes the last item from the path and from the pushed views.
         And NavigationStack has one more trick to offer.
         It lets us connect to this path using a binding.
         Let's go back to our code.
         Here's where we were.
         To bind the path, first I'll add some State.
         Because every value pushed on this stack is a recipe, I can use an array of recipes as my path.
         If you need to present a variety of data on a stack, be sure to check out the new type-erasing NavigationPath collection.
         Once I have my path state, I add an argument to my NavigationStack and pass a binding to the path.
         With that in place, I can make my stack sizzle.
         For example, I could add a method to jump to a particular recipe.
         Or from anywhere on my stack, I can pop back to the root just by resetting the path.
         That's how to prepare a pushable stack using the new NavigationStack, value-presenting NavigationLinks, and navigationDestinations in SwiftUI.
         This recipe works on all platforms, including the Mac, but really shines on iPhone, Apple TV, and Apple Watch.
         To see NavigationStack in action, be sure to check out "Build a productivity app for Apple Watch.
        " Our next recipe is for multicolumn presentation without any stacks, like you'd find in Mail on Mac and iPad.
         On iPad, the sidebar is initially hidden.
         I can reveal it and choose a category.
         Then, in the second column, I can choose a recipe.
         The third column shows the recipe details.
         This recipe combines a NavigationSplitView with the new variety of NavigationLink, and a List selection.
         This recipe is great on larger devices because it helps avoid modality.
         I can see all my information without having to drill in.
         Let's see how.
         I'll start with a three-column NavigationSplitView with placeholder views for the content and detail.
         Then, I'll add a List in the sidebar that iterates over all my categories, and a navigationTitle.
         Inside the List, I have a NavigationLink for each category.
         Next, I'll introduce some State to keep track of which category is selected.
         I'll tweak our list in the sidebar to use the selectedCategory.
         Note that we're passing a binding to the selection.
         This lets the list and its contents manipulate the selection.
         When you put a value-presenting link inside a list with a matching selection type -- category here -- the link will automatically update the selection when tapped or clicked.
         So now when I select a category in the sidebar, SwiftUI updates the selectedCategory.
         Check out Raj's "Organize your interface" talk that I mentioned earlier for some great information on selection and lists.
         Next, I'll replace my placeholder in the content column with a list of the recipes for the selected category, and add a navigationTitle for this column too.
         Just like for the selected category, I can use the same technique to keep track of the selected recipe in the content list.
         I'll use State for the selectedRecipe, have my content list use that state, and use a value-presenting link for each recipe.
         Finally, I'll update the detail column to show, well, the details for the selectedRecipe.
         With this in place, I again have full programmatic control over navigation.
         For example, to navigate to my recipe of the day, I just need to update my selection state.
         That's how to prepare a multi-column navigation experience using the new NavigationSplitView, value-presenting NavigationLinks, and Lists with selection in SwiftUI.
         One super cool thing about combining List selection and NavigationSplitView like this, is that SwiftUI can automatically adapt the split view to a single stack on iPhone or in Slide Over on iPad.
         Changes to selection automatically translate into the appropriate pushes and pops on iPhone.
         Of course, this multicolumn presentation also works great on the Mac.
         And although Apple TV and Apple Watch don't show multiple columns, those platforms also get the automatic translation to a single stack.
         NavigationSplitView in SwiftUI works on all platforms.
         Next, let's look at how we can put all these ingredients together by building a two-column navigation experience like that in Photos on iPad and Mac.
         When I select a category, the detail area shows a grid of all my recipes in that category.
         When I tap a recipe, it's pushed onto a stack in the detail area.
         When I tap a related recipe, it's also pushed onto the stack.
         And I can navigate back to the grid of recipes.
        This recipe is our pièce de résistance, combining navigation split view, stack, link, destination, and list.
         Let's see how all these ingredients go together.
         I'll start with a two-column NavigationSplitView.
         The first column is exactly like the previous recipe.
         I have some State to track the selectedCategory and a List that uses a binding to that state and a value-presenting NavigationLink, and the requisite navigationTitle.
         The differences in this recipe are in the detail area.
         The new navigation APIs really take advantage of composition.
         Just like I can put a list inside a column of a NavigationSplitView, I can also put a NavigationStack inside a column.
         The root view of this Navigation Stack is my RecipeGrid.
         Notice that the RecipeGrid is inside the NavigationStack.
         That means I can put stack-related modifiers inside RecipeGrid.
         Let's zoom in to the body of RecipeGrid to see what that means.
         RecipeGrid is a view and takes a category as a parameter.
         Because category is optional here, I'll start with an if-let.
         The else case handles an empty selection.
         Inside my if, I'll add a scroll view and a lazy grid.
         Lazy grid layout takes a sequence of views.
         Here, I'm using ForEach to iterate over my recipes.
         For each recipe, I have a value-presenting NavigationLink.
         The link presents a recipe value.
         The link's label, in this trailing closure, is my RecipeTile with the thumbnail and title.
         So what's left to finish this grid? Well, I haven't told the NavigationStack how to map from recipes to detail views.
         Like I mentioned with the first recipe, the new NavigationStack uses the navigationDestination modifier to map from values on its path to views shown on the stack.
         So let's add a navigationDestination modifier.
         But where should I attach it? I'm tempted to attach it directly to the link, but this is wrong for two reasons.
         Lazy containers, like List, Table, or, here, LazyVGrid, don't load all of their views immediately.
         If I put the modifier here, the destination might not be loaded, so the surrounding NavigationStack might not see it.
         Second, if I put the modifier here, it will be repeated for every item in my grid.
         Instead, I'll attach the modifier to my ScrollView.
         By attaching the modifier outside the ScrollView, I ensure that the NavigationStack can see this navigationDestination regardless of the scroll position.
         Another thing I like about putting the modifier here is that it's still close to the links that target it.
         Navigation destination gives me flexibility to organize my code the way that makes sense to me or my team.
         Popping back to my NavigationSplitView, there's just one more thing to enable full programmatic navigation here.
         I need to add a navigation path.
         I'll add State to hold the path and bind the state to my NavigationStack.
         With full programmatic navigation in place, I can write a method to show my recipe of the day in this navigation experience.
         That's how to prepare a multicolumn navigation experience with stacks using the new NavigationSplitView, NavigationStack, value-presenting NavigationLinks, and Lists with selection in SwiftUI.
         As with the previous recipe, this one also automatically adapts to narrow presentations and works on all platforms.
         It was fun exploring these recipes for structuring the navigation in my app, but our navigation feast wouldn't be complete without dessert.
         For that, let's look at how to persist the navigation state.
         To persist navigation state in my app, I just need two more ingredients: Codable and SceneStorage.
         This recipe has three basic steps.
         First, I'll encapsulate my navigation state in a NavigationModel type.
         That lets me save and restore it as a unit so it's always consistent.
         Then, I'll make my navigation model Codable.
         Finally, I'll use SceneStorage to save and restore my model.
         I'll have to take care along the way -- I don't want my app to crash like a fallen soufflé -- but the steps are straightforward.
         Let's look at step one.
         Here's the code from the end of our last recipe.
         My navigation state is stored in the selectedCategory and path properties.
         The selectedCategory tracks the selection in the sidebar.
         The path tracks the views pushed onto the stack in the detail area.
         I'll introduce a new NavigationModel class and make it conform to ObservableObject.
         Next, I'll move my navigation state into my model object, changing the property wrappers from State to Published.
         Then, I'll introduce a StateObject to hold an instance of my NavigationModel and change the parameters to use the new model object.
         Next, I'll make my navigation model Codable.
         I'll start by adding the Codable conformance to the class.
         In many cases, Swift can automatically generate Codable conformance, but I want to implement my own conformance here.
         The main reason is that Recipe is a model value.
         I don't want to store the entire model value for state restoration.
         There are two reasons for this.
         First, my recipe database already contains all the details for the recipe.
         It's not a good use of storage to repeat that information in my saved navigation state.
         Second, if my recipe database can change independently of my local navigation state -- say, because I finally get around to adding syncing -- I don't want my local navigation state to contain stale data.
         For custom codability, next I'll add CodingKeys.
         One of the keys is just selectedCategory.
         But notice that I named the other "recipePathIds” I'm planning to just store the identifiers of the recipes on the path.
         In my encode method, I'll create a keyed container using my coding keys and add the selected category to the container.
         I'm using encodeIfPresent, so I only write the value if it's non-nil.
         Then, I'll add the recipe path identifiers.
         Note that I'm mapping over the path to get the identifiers to encode.
         For example, suppose my navigation state included Dessert as a selected category, with Apple Pie and Pie Crust on the path, like shown in the green box on top.
         This might be encoded to JSON, like shown in this other box.
         To finish up Codability, I'll add the required initializer.
         The interesting bit is here where I decode the recipe IDs, then use my shared data model to convert the IDs back into recipes.
         I'm using compactMap to discard any recipes that couldn't be found.
         For example, this might happen if I delete a recipe on another device after I have sync working -- something I'm definitely going to do someday.
         This is a place you'll need to use discretion in your own apps to make sure any restored navigation state still makes sense.
         Finally, I'll add a computed property for reading and writing my model as JSON data.
         Now that I have a navigation model and it knows how to encode and decode itself, all that's left is to actually save and restore it.
         For that I'll use SceneStorage.
         Here's where we left our main view.
         I was using a StateObject to hold my NavigationModel.
         Now, I'll introduce some SceneStorage to persist my NavigationModel.
         SceneStorage properties automatically save and restore their associated values.
         When the type of the storage is optional, like my data here, the value is nil when a new scene is created.
         When the system restores a scene, SwiftUI ensures that the value of the SceneStorage property is also restored.
         I'll take advantage of this to persist my NavigationModel.
         To do that, I'll add a task modifier to my view.
         The task modifier runs its closure asynchronously.
         It starts when the view appears and is cancelled when the view goes away.
         Whenever my view appears, I'll first check whether I have any existing data from a previous run of the app.
         If so, I'll update my navigation model with that data.
         Then, I'll start an asynchronous for loop that will iterate whenever my navigation model changes.
         The body of this loop will run on each change, so I can use that to save my navigation state back to my scene storage data.
         And that's it! When I leave my app to go check out some vintage Julia Child cooking shows on the web, it remembers where I was.
         When I return to the app, it takes me back to where I left off.
         Now, no cookbook would be complete without a weird section at the end with handy kitchen tips.
         I don't have three great substitutes for cilantro, but I do have some navigation tips to share.
         Switch to the new NavigationStack and NavigationSplitView as soon as you can.
         If you're using NavigationView with the stack style, switch to NavigationStack.
         NavigationStack is also a good first choice on Apple TV, Apple Watch, or in sheets on iPad and iPhone, where the stack style has always been the default.
         If you're using a multicolumn NavigationView, switch to NavigationSplitView.
         And if you've already adopted programmatic navigation using the links that take bindings, I strongly encourage you to move to the new value-presenting NavigationLink along with navigation paths and list selection.
         The old-style programmatic links are deprecated beginning in iOS 16 and aligned releases.
         For details and examples on migrating to the new APIs, check out the article, "Migrating to new navigation types" in the developer documentation.
         Next, keep in mind that List and the new NavigationSplitView and NavigationStack were made to mix together.
         Compose them to create navigation experiences your guests will love.
         When using navigation stacks, navigation destinations can be anywhere inside the stack or its subviews.
         Consider putting destinations near the corresponding links to make maintenance easier, but remember not to put them inside of lazy containers.
         Finally, I'd encourage you to start building your navigation experiences with NavigationSplitView when it makes sense.
         Even if you're initially developing for iPhone, NavigationSplitView will automatically adapt to the narrower device.
         And when you're ready to support iPhone Pro Max in landscape, or to bring your app to iPad or Mac, NavigationSplitView will take advantage of all that additional space.
         Thanks for the chance to share the new SwiftUI Navigation APIs with you! Besides the talks I mentioned earlier, I invite you to check out "Bring multiple windows to your SwiftUI app" for some great info on opening new windows and scenes in your apps.
         I hope that these recipes for navigation in our cookbook app were palate-pleasing.
         I'm looking forward to seeing the great experiences you cook up in your own apps.
         Bon appétit!

        """
    }

    var japanese: String {
        """
        こんにちは。私はSwiftUIチームのエンジニア、Curtです。
         SwiftUIには、ナビゲーションのためのエキサイティングな新しいAPIがいくつかあります。
         私はこれらの新しいAPIを使ってアプリケーションを構築することを楽しんできましたので、あなたとそれを共有できることに興奮しています。
         これらの API は、Apple TV、iPhone、Apple Watch のような基本的なスタックから、強力なマルチカラムプレゼンテーションまで拡張します。
         新しい API は、プログラムによるナビゲーションとディープリンクを強力にサポートし、アプリケーションに最適な構造を構築するためのピースを構成することができます。
         この講演では、SwiftUI でナビゲーション付きのアプリを調理するための簡単なレシピをいくつか紹介します。
         そして、もしあなたが既にSwiftUIを使っているなら、これらの新しいAPIが、あなたがそれを一段と向上させる助けになることを願っています。
         私は、新しいデータ駆動型ナビゲーションAPIに入る材料から始めます。
         それから、ナビゲーションをプログラムで完全に制御するためのいくつかの手軽で簡単なレシピの試食に移ろうと思います。
         デザートのコースでは、あなたのアプリでナビゲーションの状態を永続化するために新しい API を使用する際のヒントをいくつか紹介します。
         以前に SwiftUI でナビゲーションを使用したことがある場合、新しい API がどのように異なるのか不思議に思うかもしれません。
         そこで、掘り下げる前に、既存のAPIをいくつかおさらいしておきましょう。
         既存のAPIは、他の列またはスタック上に表示されるビューを送信するリンクに基づいています。
         例えば、ルートビューにナビゲーションリンクのリストがあるとします。
         これらのリンクの1つをタップすると、リンクはそのビューをスタックにプッシュします。
         これは基本的なナビゲーションに最適で、このパターンを使い続けることができます。
         しかし、ルート・ビューに戻りましょう。
         既存のナビゲーションAPIで、プログラム的にリンクを表示するには、リンクにバインディングを追加します。
         例えば、item.showDetailをtrueに設定することによって、このリンクのビューを表示することができます。
        showDetailをtrueに設定します。
         しかし、これではリンクごとに個別のバインディングが必要になってしまいます。
         新しいAPIでは、バインディングをNavigationStackと呼ばれるコンテナ全体にまで引き上げます。
         ここでのパスは、スタックにプッシュされたすべての値を表すコレクションです。
         NavigationLinksは、このパスに値を追加します。
         パスを変更することでディープリンクができ、パスからすべてのアイテムを削除することでルートビューにポップアップします。
         この講演では、新しいナビゲーションAPIがどのようにデータ駆動型のプログラムナビゲーションを可能にするかをお見せします。
         パワフルで使いやすいことを実感していただければと思います。
         新しいナビゲーションAPIの使い方のレシピに飛びつく前に、メニューにあるものを共有しておくと便利だと思います。
         最近、料理に凝っていて、自分のレシピを記録するアプリに取り組んでいます。
         この情報を表示するさまざまな方法について、多くのアイデアを持っています。
         例えば、3カラムのアプローチです。
         最初のカラムでは、レシピのカテゴリーを選択することができます。
         カテゴリーを選択すると、2番目のカラムに収集したレシピがリストアップされます。
         そして、レシピを選択すると、詳細エリアにそのレシピの材料が表示されます。
         詳細エリアには、関連するレシピへのリンクもあります。
         私の祖母はいつも、「パイは生地で作るもの」と言っていました。
        " 今日は、それを実践してみます。
         材料は、新しいナビゲーションAPIです。
         新しいナビゲーションAPIについて詳しく説明し、それらを組み合わせた具体的なナビゲーションレシピをいくつか見ていきましょう。
         新しいナビゲーションAPIでは、アプリの構造を記述するために使用できる新しいコンテナタイプがいくつか導入され、その構造内を移動するゲストを支援するための新しい種類のNavigationLinkが追加されました。
         最初の新しいコンテナはNavigationStackです。
         NavigationStackは、Apple WatchのFind My、iPhoneのSettings、macOS Venturaの新しいSystem Settingsアプリに見られるようなプッシュポップインターフェースを表します。
         2つ目の新しいコンテナタイプは、NavigationSplitViewです。
         NavigationSplitViewは、MacやiPad上のメールやメモのようなマルチカラムのアプリケーションに最適です。
         そしてNavigationSplitViewは、iPhone、iPadのSlide Over、そしてApple WatchやApple TVでも、シングルカラムのスタックに自動的に適応します。
         NavigationSplitViewには、2組のイニシャライザーがあります。
         1つのセットは、ここに示すように、2カラムのエクスペリエンスを作成します。
         もう1つのイニシャライザーは、3カラムを作成します。
         NavigationSplitViewには、カラムの幅、サイドバーの表示、カラムの表示/非表示をカスタマイズするための設定オプションが豊富に用意されています。
         この講演では設定オプションについて深く掘り下げませんが、同僚のRajの講演、「SwiftUI on iPad」をご覧ください。NavigationSplitViewをあなたのアプリにちょうどいいように調整する方法についての素晴らしいドキュメントをご覧ください。
         以前は、NavigationLinks は常にタイトルと表示するビューを含んでいました。
         新しい種類は、タイトルをまだ含んでいますが、提示するビューの代わりに値を提示します。
         例えば、このリンクはアップルパイのレシピを表示しています。
         これから説明するように、NavigationLink はスマートです。
         リンクの動作は、それが表示されるNavigationStackまたはリストに依存します。
         これらのおいしい新しいAPIがどのように連携するかを見るために、私の料理本アプリやあなたのアプリでそれらを使用するためのいくつかの具体的なレシピを見てみましょう。
         最初のレシピは、Apple Watchの「Find My」やiPhoneの「設定」にあるような、基本的なビューの積み重ねです。
         カテゴリーごとにセクションを設けています。
         セクションの中で、レシピをタップして詳細を見ることができます。
         レシピの中で、関連するレシピをタップすると、スタックに追加されます。
         戻るボタンで、元のレシピに戻り、カテゴリーリストに戻ることができます。
         このレシピは、NavigationStackと新しい種類のNavigationLink、そしてナビゲーション・デスティネーションのモディファイアを組み合わせています。
         どのようにするか見てみましょう。
         まず、基本的なNavigationStackから始めます。
         内部には、すべてのカテゴリーを繰り返し表示するListと、navigationTitleがあります。
         Listの内部には、各カテゴリーのセクションがあります。
         次に、各セクションの中に、カテゴリー内の各レシピのNavigationLinkを追加します。
         とりあえず、このリンクは私のRecipeDetailビューを表示するようにします。
         これは、既存のビュー先NavigationLinkを使用しています。
         そして、このナビゲーション・エクスペリエンスを調理するためには、これで十分です。
         しかし、プログラムによるナビゲーションはどうでしょうか？プログラムナビゲーションを追加するには、このナビゲーションリンクの2つの部分を分離する必要があります：それが示す値と、その値に対応するビューです。
         その方法を見てみましょう。
         まず、リンクから目的地ビューを取り出し、新しいnavigationDestination修飾子に入れます。
         このモディファイアは、担当する提示データのタイプを宣言します。
         この修飾子は、レシピの値が提示されたときに、どのビューをスタックにプッシュするかを記述するビュービルダーを取ります。
         そして、新しいNavigationLinksの1つに切り替えて、レシピの値だけを表示することにします。
         フードの下を覗いて、NavigationStackがこれをどのように動作させるか見てみましょう。
         すべてのナビゲーションスタックは、スタックが表示しているすべてのデータを表すパスを追跡しています。
         このように、スタックがルートビューを表示しているだけの場合、パスは空です。
         次に、スタックは、その内部で宣言されたすべてのナビゲーションデスティネーション、またはスタックにプッシュされたビューの内部で宣言されたすべてのナビゲーションデスティネーションのトラックも保持します。
         一般的に、これはセットですが、この例では、目的地は1つだけです。
         プッシュされたビューもダイアグラムに追加してみましょう。
         ここで、パスが空であるため、プッシュされたビューのリストも空となります。
         さて、ミルクとクッキーのように、これらを組み合わせると、魔法が起きます。
         値を表示するリンクをタップすると、その値がパスに追加されます。
         そして、ナビゲーションスタックは、パスの値の上に目的地をマッピングして、スタックにプッシュするビューを決定します。
         今、私のアップルパイのレシピから、私が「パイ生地」をタップすると、リンクはそのパイ生地もパスに追加します。
         NavigationStackは魔法を使い、別のRecipeDetailビューをスタックにプッシュします。
         私がパスに値を追加するたびに、NavigationStackは別のビューをプッシュします。
         私が戻るボタンをタップすると、NavigationStackはパスとプッシュされたビューから最後のアイテムを削除します。
         さらに、NavigationStackにはもう1つのトリックがあります。
         それは、バインディングを使用してこのパスに接続することです。
         コードに戻りましょう。
         ここで、私たちがいた場所はここです。
         パスをバインドするために、まずStateをいくつか追加します。
         このスタックにプッシュされた値はすべてレシピなので、レシピの配列をパスとして使用することができます。
         スタック上に様々なデータを表示する必要がある場合は、新しい型消去のNavigationPathコレクションをぜひチェックしてみてください。
         パスの状態が決まったら、NavigationStackに引数を追加して、パスへのバインディングを渡します。
         この状態で、スタックを華やかにすることができます。
         例えば、特定のレシピにジャンプするメソッドを追加することができます。
         また、スタックのどこからでも、パスをリセットするだけでルートにポップバックすることができます。
         以上、SwiftUI の新しい NavigationStack、値を提示する NavigationLinks、および navigationDestinations を使用して、プッシュ可能なスタックを準備する方法でした。
         このレシピは Mac を含むすべてのプラットフォームで動作しますが、iPhone、Apple TV、Apple Watch で本当に輝きを放ちます。
         NavigationStack が動いているところを見るには、「Apple Watch 用の生産性アプリを作る」をぜひご覧ください。
        " 次のレシピは、MacやiPadのメールに見られるような、スタックを使用しないマルチカラムのプレゼンテーションです。
         iPadでは、最初はサイドバーが非表示になっています。
         iPadの場合、最初はサイドバーが非表示になっていますが、表示させてカテゴリーを選択することができます。
         2列目ではレシピを選択します。
         3列目には、レシピの詳細が表示されます。
         このレシピは、NavigationSplitViewと新しい種類のNavigationLink、そしてListの選択を組み合わせています。
         このレシピは、モダリティを回避することができるので、大きなデバイスで素晴らしいです。
         ドリルインすることなく、すべての情報を見ることができるのです。
         では、その方法を見てみましょう。
         まず、3列のNavigationSplitViewで、コンテンツと詳細のプレースホルダー・ビューを作成します。
         次に、すべてのカテゴリーを繰り返し表示するサイドバーのリストと、NavigationTitleを追加します。
         Listの内部には、各カテゴリーのNavigationLinkがあります。
         次に、どのカテゴリーが選択されたかを追跡するために、いくつかの状態を導入します。
         サイドバーのリストを微調整して、selectedCategoryを使用するようにします。
         選択項目にバインディングを渡していることに注意してください。
         これにより、リストとそのコンテンツが選択範囲を操作することができます。
         一致する選択タイプ - ここではカテゴリ - を持つリスト内部に値を示すリンクを置くと、タップもしくはクリックされたときにリンクは自動的に選択範囲を更新します。
         サイドバーでカテゴリを選択するとき、SwiftUIはselectedCategoryを更新します。
         選択とリストに関するいくつかの素晴らしい情報については、以前紹介したRajの「Organize your interface」トークをチェックしてください。
         次に、コンテンツカラムのプレースホルダーを選択したカテゴリのレシピのリストに置き換え、このカラムのナビゲーションタイトルを追加します。
         選択されたカテゴリと同じように、コンテンツ・リストで選択されたレシピを追跡するために同じテクニックを使用することができます。
         selectedRecipeにStateを使用し、コンテンツリストにそのstateを使用させ、各レシピに値を提示するリンクを使用することにします。
         最後に、詳細カラムを更新して、selectedRecipeの詳細を表示するようにします。
         これで、ナビゲーションをプログラムで完全に制御できるようになりました。
         例えば、今日のレシピに移動するには、選択状態を更新するだけでよいのです。
         以上、SwiftUIで新しいNavigationSplitView、値を表示するNavigationLinks、選択とリストを使用して、複数カラムのナビゲーション体験を準備する方法を説明しました。
         このようにリストの選択とNavigationSplitViewを組み合わせることの1つの超クールな点は、SwiftUIが自動的にiPhone上の単一のスタックまたはiPad上のスライドオーバーに分割ビューを適応させることができるということです。
         選択範囲への変更は、iPhoneでは適切なプッシュとポップに自動的に変換されます。
         もちろん、このマルチカラムのプレゼンテーションは、Macでもうまく機能します。
         Apple TVとApple Watchは複数のカラムを表示しませんが、これらのプラットフォームでも、単一のスタックに自動的に変換されます。
         SwiftUIのNavigationSplitViewはすべてのプラットフォームで動作します。
         次に、iPadとMacのPhotosのような2列のナビゲーションエクスペリエンスを構築することで、これらの材料をどのようにまとめることができるかを見てみましょう。
         カテゴリを選択すると、詳細領域に、そのカテゴリにあるすべてのレシピのグリッドが表示されます。
         レシピをタップすると、そのレシピは詳細エリアのスタックにプッシュされます。
         関連するレシピをタップすると、そのレシピもスタックに押し出されます。
         そして、レシピのグリッドに戻ることができます。
        このレシピは、ナビゲーションのスプリットビュー、スタック、リンク、目的地、リストを組み合わせた、私たちの最高の作品です。
         それでは、これらの要素をどのように組み合わせるか見てみましょう。
         まず、2列のNavigationSplitViewから始めます。
         最初のカラムは、前のレシピとまったく同じです。
         selectedCategoryを追跡するStateと、そのStateへのバインディングを使用するList、値を示すNavigationLink、そして必要なnavigationTitleがあります。
         このレシピの違いは、詳細部分にあります。
         新しいナビゲーションAPIは、コンポジションを本当に活用しています。
         NavigationSplitViewのカラムの中にリストを入れることができるように、カラムの中にNavigationStackを入れることもできるのです。
         このナビゲーションスタックのルートビューは、私のRecipeGridです。
         RecipeGridはNavigationStackの中にあることに注意してください。
         つまり、RecipeGridの中にスタックに関連するモディファイアを置くことができるのです。
         RecipeGridの本体にズームインして、その意味するところを確認してみましょう。
         RecipeGridはビューであり、パラメータとしてカテゴリーを受け取ります。
         ここではカテゴリはオプションなので、if-letから始めます。
         elseケースは、空の選択を処理します。
         ifの中で、スクロールビューとレイジーグリッドを追加します。
         レイジーグリッドのレイアウトは、一連のビューを受け取ります。
         ここでは、レシピを繰り返し表示するためにForEachを使っています。
         各レシピには、値を表示するナビゲーションリンクがあります。
         このリンクは、レシピの値を表示します。
         リンクのラベルは、この末尾のクロージャでは、サムネイルとタイトルを持つ私のRecipeTileです。
         さて、このグリッドを完成させるために何が残っているでしょうか？さて、私はレシピから詳細なビューにマッピングする方法をNavigationStackに伝えていません。
         最初のレシピで述べたように、新しい NavigationStack は navigationDestination モディファイアを使用して、パス上の値からスタックに表示されるビューにマッピングします。
         そこで、navigationDestinationモディファイアを追加してみましょう。
         しかし、どこに付けるべきでしょうか？リンクに直接付けたい気もしますが、これは2つの理由で間違っています。
         リスト、テーブル、あるいはここではLazyVGridのような遅延コンテナは、すべてのビューをすぐにロードしません。
         もし、ここにモディファイアを置くと、目的地がロードされないかもしれないので、周囲のNavigationStackはそれを見ることができないかもしれません。
         第二に、ここにモディファイアを置くと、グリッドのすべてのアイテムで繰り返されます。
         代わりに、モディファイアをScrollViewに取り付けます。
         ScrollViewの外側にモディファイアを付けることで、スクロール位置に関係なくNavigationStackがこのnavigationDestinationを見ることができるようにします。
         モディファイアをここに置くことのもう一つの利点は、モディファイアをターゲットにするリンクの近くにあることです。
         ナビゲーション・デスティネーションは、私や私のチームにとって意味のある方法でコードを整理する柔軟性を与えてくれます。
         NavigationSplitViewに戻ると、完全なプログラムナビゲーションを可能にするために、もう一つ必要なものがあります。
         ナビゲーションパスを追加する必要があります。
         そのパスを保持するためにStateを追加し、そのStateをNavigationStackにバインドすることにします。
         フル・プログラマティック・ナビゲーションが整えば、このナビゲーション体験の中で今日のレシピを表示するメソッドを書くことができます。
         以上、SwiftUIの新しいNavigationSplitView、NavigationStack、値を表示するNavigationLinks、選択を伴うListsを使って、スタックを使ったマルチカラムナビゲーション体験を準備する方法でした。
         前のレシピと同様に、このレシピも狭いプレゼンテーションに自動的に適応し、すべてのプラットフォームで動作します。
         私のアプリでナビゲーションを構造化するためにこれらのレシピを探索するのは楽しかったですが、ナビゲーションのごちそうはデザートなしでは完全ではありません。
         そのために、ナビゲーションの状態を永続化する方法について見てみましょう。
         私のアプリでナビゲーションの状態を永続化するためには、あと 2 つの材料が必要です。Codable と SceneStorage です。
         このレシピには、3つの基本的なステップがあります。
         まず、ナビゲーションステートを NavigationModel タイプにカプセル化します。
         これによって、保存と復元を1つのユニットとして行うことができ、常に一貫した状態を保つことができます。
         そして、ナビゲーションモデルをCodableにします。
         最後に、SceneStorageを使って、モデルの保存と復元をします。
         アプリが落ちたスフレのようにクラッシュしないように、途中で気をつけなければなりませんが、手順は簡単です。
         ステップ1を見てみましょう。
         これは、前回のレシピの最後にあったコードです。
         私のナビゲーションの状態は、selectedCategoryとpathプロパティに格納されています。
         selectedCategory は、サイドバーでの選択を追跡します。
         パスは、詳細領域でスタックにプッシュされたビューを追跡します。
         新しい NavigationModel クラスを導入し、ObservableObject に準拠するようにします。
         次に、ナビゲーションの状態をモデルオブジェクトに移し、プロパティラッパーをStateからPublishedに変更します。
         そして、NavigationModelのインスタンスを保持するためにStateObjectを導入し、新しいモデルオブジェクトを使用するようにパラメータを変更します。
         次に、私のナビゲーションモデルをCodableにします。
         私は、クラスに Codable 適合性を追加することから始めます。
         多くの場合、Swiftは自動的にCodable適合性を生成することができますが、私はここで私自身の適合性を実装したいと思います。
         主な理由は、Recipeがモデルの値であることです。
         状態復元のためにモデル値全体を保存したくないのです。
         これには2つの理由があります。
         まず、私のレシピデータベースはすでにレシピのためのすべての詳細を含んでいます。
         保存されたナビゲーションステートでその情報を繰り返すのは、ストレージの良い使い方ではありません。
         第二に、私のレシピデータベースが私のローカルナビゲーションステートと独立して変更できる場合、例えば、私が最終的に同期を追加するようになったので、私は私のローカルナビゲーションステートが古いデータを含むことを望みません。
         カスタム・コーダビリティのために、次にCodingKeysを追加します。
         キーの1つは、selectedCategoryです。
         しかし、他のキーに "recipePathIds "と名付けたことに注目してほしい。私は、パス上のレシピの識別子を保存することを計画しているのだ。
         エンコードメソッドでは、コーディングキーを使ってキー付きコンテナを作成し、選択されたカテゴリーをコンテナに追加することにする。
         私はencodeIfPresentを使用しているので、それが非NILである場合にのみ値を書き込みます。
         それから、レシピのパス識別子を追加します。
         エンコードする識別子を得るためにパス上にマッピングしていることに注意してください。
         例えば、私のナビゲーションの状態が選択されたカテゴリとしてデザートを含み、アップルパイとパイ生地が上の緑色のボックスで示されるようにパスにあるとします。
         これは、この別のボックスのようにJSONにエンコードされるかもしれません。
         Codabilityの仕上げとして、必要なイニシャライザーを追加しておく。
         興味深いのは、ここでレシピのIDをデコードし、共有データモデルを使ってIDをレシピに変換しているところです。
         コンパクトマップを使用して、見つからなかったレシピを破棄しています。
         例えば、いつか必ずやろうと思っていることなのですが、シンクした後に他のデバイスのレシピを削除した場合などです。
         これは、復元されたナビゲーションの状態がまだ意味をなしていることを確認するために、自分のアプリケーションで慎重に使用する必要がある場所です。
         最後に、モデルをJSONデータとして読み書きするためのcomputedプロパティを追加します。
         これで、ナビゲーションモデルができ、それ自身をエンコード、デコードする方法を知ったので、あとは、実際に保存、復元するだけです。
         そのためには、SceneStorageを使います。
         ここで、私たちはメイン・ビューを離れました。
         NavigationModel を StateObject で保持していました。
         今度は、SceneStorage を導入して、NavigationModel を保持するようにします。
         SceneStorage のプロパティは、自動的に関連する値を保存、復元します。
         このデータのように、ストレージのタイプがオプションの場合、新しいシーンが作成されると、値は nil になります。
         システムがシーンを復元するとき、SwiftUI は SceneStorage プロパティの値も復元されることを保証します。
         これを利用して、NavigationModel を永続化することにします。
         これを行うには、ビューにタスク修飾子を追加します。
         タスク モディファイアは、非同期にクロージャを実行します。
         ビューが表示されると開始され、ビューが消えるとキャンセルされます。
         ビューが表示されるたびに、私はまず、アプリの以前の実行から既存のデータがあるかどうかをチェックします。
         もしあれば、そのデータでナビゲーションモデルを更新します。
         それから、ナビゲーションモデルが変更されるたびに、非同期のforループを開始し、それを繰り返します。
         このループの本体は、変更のたびに実行されるので、それを使ってナビゲーションの状態をシーン・ストレージ・データに保存することができます。
         これで完了です。ジュリア・チャイルドのヴィンテージ料理番組をウェブでチェックするためにアプリを離れると、アプリは私がどこにいたかを記憶しています。
         アプリに戻ると、中断していた場所に戻ってくるのです。
         さて、どんな料理本でも、最後に便利なキッチンのコツを紹介する奇妙なセクションがなければ、完全とは言えません。
         コリアンダーの代用になるような素晴らしい食材は3つもありませんが、ナビゲーションのコツならあります。
         新しいNavigationStackとNavigationSplitViewにできるだけ早く切り替えてください。
         NavigationViewをスタックスタイルで使っている人は、NavigationStackに切り替えてください。
         NavigationStackは、Apple TV、Apple Watch、またはスタックスタイルが常にデフォルトであるiPadとiPhoneのシートでも、最初の選択肢として適しています。
         マルチカラムのNavigationViewを使用している場合は、NavigationSplitViewに切り替えてください。
         また、バインディングを取るリンクを使ったプログラムナビゲーションをすでに採用している場合は、ナビゲーションパスやリスト選択とともに、新しい値を表示するNavigationLinkに移行することを強くお勧めします。
         旧式のプログラマティックリンクは、iOS 16とそれに準じたリリースから非推奨となります。
         新しいAPIへの移行の詳細と例については、デベロッパードキュメントの記事「Migrating to new navigation types」をご覧ください。
         次に、Listと新しいNavigationSplitViewとNavigationStackは一緒に混ぜるために作られたことを心に留めておいてください。
         これらを組み合わせて、ゲストが喜ぶようなナビゲーション体験を作りましょう。
         ナビゲーションスタックを使用する場合、ナビゲーションの目的地はスタックやそのサブビューの中のどこにでも置くことができます。
         メンテナンスを容易にするために、対応するリンクの近くに目的地を置くことを検討してください。ただし、遅延コンテナの中に置かないことを忘れないでください。
         最後に、NavigationSplitViewを使ったナビゲーション体験は、それが理にかなったものである場合に始めることをお勧めします。
         最初はiPhone向けに開発していたとしても、NavigationSplitViewは自動的に狭いデバイスに適応してくれます。
         そして、iPhone Pro Maxを横向きでサポートする準備ができたとき、あるいはiPadやMacにアプリケーションを提供するとき、NavigationSplitViewは、すべての追加スペースを利用します。
         新しいSwiftUIナビゲーションAPIを共有する機会をいただき、ありがとうございました 先に述べた講演の他に、アプリで新しいウィンドウとシーンを開くための素晴らしい情報のために、「Bring multiple windows to your SwiftUI app」をチェックアウトすることをお勧めします。
         私たちのクックブックアプリのナビゲーションのためのこれらのレシピが、お口に合うものであったことを願っています。
         私は、あなたが自分のアプリで作る素晴らしい体験を見るのを楽しみにしています。
         それでは、また。

        """
    }
}

