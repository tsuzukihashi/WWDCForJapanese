import Foundation

struct WhatsNewInSwiftUI: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "What's new in SwiftUI"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6545/6545_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10052/")!
    }

    var english: String {
        """
        Hi, I'm Nick.
         And I'm Franck, and we are SwiftUI engineers.
         Today, we're going to cover "What's new in SwiftUI."
         SwiftUI is growing alongside our operating systems, each pushing the bounds of the other.
         We continue to be amazed and delighted by what you are making with SwiftUI.
         We take to heart all flavors of feedback from the community.
         That's why we're especially excited to share what we've focused on this year.
         With this year's APIs, we've gone deeper.
         We've made more custom experiences possible.
         We've introduced some amazing new graphical techniques.
         We've architected a new SwiftUI app structure, and much more.
         SwiftUI enabled us to build designs and features that reflect the future of our platforms.
         From redesigns of classic apps to completely new features to deep system integrations.
         This comprehensive adoption within Apple further pushes evolution of SwiftUI.
         Many of these new designs and features are only possible because of how SwiftUI has evolved how we write apps at Apple.
         Today we're celebrating these APIs, And we're also celebrating SwiftUI's birthday, Franck and I are the lucky cochairs of the party-planning committee.
         Let me tell you about the activities we've got planned for the party.
         I'll introduce you to a brand-new framework called Swift Charts that allows you to create delightful data visualizations across all of our platforms.
         I'll show off SwiftUI's data-driven, strongly-typed model for navigation and new window techniques.
         Franck will take you through a suite of new controls and deeper customizations of existing controls.
         Then he'll show you how we've brought sharing elegantly into the universe of SwiftUI with the Transferable protocol.
         Finally, I'll close with whimsical new graphics APIs and advanced new layout APIs.
         Let's get going with Swift Charts.
         Swift Charts is a declarative framework for building beautiful state-driven charts.
         The fundamental design principles that make SwiftUI great and the process of plotting data have been composed harmoniously to create Swift Charts -- a world-class data-visualization framework.
         This is a bar chart plotting the number of party tasks Franck and I need to complete before the party can start.
         Swift Charts has built a magnificent, customizable chart from only a few lines of code.
         Like SwiftUI, Swift Charts picks intelligent defaults.
         Here, the framework chose satisfyingly round numbers for the y-axis values, and provided a default color for the bar marks.
        If you know SwiftUI, you can already read the declarative, state-driven syntax of Swift Charts.
         Chart is just some View, and you declare it just like you do lists and tables -- by providing data and then building the chart content with that data.
         For this chart, I've chosen a BarMark, but if I switch to a LineMark and add a foreground style to group by category, I can see more to the story as Swift Charts draws individual lines for each category and adds a legend to the chart automatically.
         It's fun to give these charts a little personality.
         I can add points to the line with the symbol modifier on the LineMark.
         These modifiers are no different from SwiftUI modifiers.
         You can even use SwiftUI views within a chart.
         Like List, the data argument to Chart can instead be passed to a ForEach.
         This allows adding more marks to the Chart builder, like a RuleMark to show our daily goal.
        The spirit of SwiftUI shines through again, as Swift Charts handles localization, Dark Mode, and Dynamic Type automatically, and of course, works across all of our platforms.
         If you want to see how to make your own charts, check out "Hello Swift Charts."
         If you're interested in advanced plotting techniques, follow it up with the "Raise the bar" session.
         Next up, let's talk about navigation and windows.
         SwiftUI already supports the most common app navigation patterns, such as immersive push-and-pop navigation stacks; expansive, detail-rich split views; and powerful, multi-window experiences.
        This year, SwiftUI has big updates for all three of these patterns.
         Let's start with stacks.
         SwiftUI is introducing a new container view, simply called NavigationStack, for supporting push-and-pop-style navigation.
         A NavigationStack wraps a root content view, like this food inventory list for our party-planning app.
         As you'd expect, it works great with existing APIs like NavigationLink and navigationTitle().
         When we select a link, SwiftUI pushes its detail view on top of the stack.
         In our app, each detail view contains more links for related food items for quick browsing.
        This approach might be all you need.
         But there is a new way to present views and have programmatic control over that presented state.
         If you need control of a navigation stack's state, adopt the new data-driven APIs.
         The new navigationDestination() modifier lets us associate navigation destinations with specific data types.
        And this year, we taught NavigationLink a new party trick: instead of a destination view, it can take a value that represents a destination.
         When tapping on a link, SwiftUI will use its value's type to find the right destination and push it on the stack, just like before.
         Because we now use data to drive our stack, it's possible to represent the current navigation path as explicit state.
         In this case, the navigation path is simply an array of all the food items that we've visited.
         With direct access to this state, it couldn't be easier to add a button for quickly jumping back to the first selected item.
         As views are pushed onto the stack, items are appended to the selectedFoodItems array.
         In the button's action, we can just remove all the items from the path except for the first one.
        And with a tap, we're right back where we started.
        Now let's talk about split views for multicolumn navigation.
         We're introducing another new container called NavigationSplitView for multicolumn navigation.
         NavigationSplitView can declare two- and three-column layouts.
         Party Planner uses a simple two-column layout, wrapping a sidebar list of our party-planning tasks and a detail view that changes its content with the selected task.
         Split views work great with the new value-based NavigationLinks we saw earlier, using the link's value to drive the list's selection.
         NavigationSplitView will automatically collapse into a stack on smaller-size classes or devices, making it a great tool for building adaptive, multiplatform apps.
         NavigationSplitView and NavigationStack are designed to work together and can be directly composed to build more complex navigation structures.
         We use this in the Party Planner app to turn the detail column into its own, self-contained navigation stack, which also shows off the new support for navigation stacks on macOS.
        Well, we've talked a lot about food, but I hear that my colleague Curt is cooking up a storm over in his talk, "The SwiftUI cookbook for navigation."
         Check it out to learn even more about navigation stacks and navigation split views.
         But for now, let's step outside the box and talk about new scene APIs.
         You're likely already familiar with WindowGroup, which is a great way to build the main interface of your app, and can generate multiple windows to allow different perspectives into your app's data.
         New this year, we're adding window, which -- you guessed it -- declares a single, unique window for your app.
         Here, I've added a Party Budget window that shows the total cost of the party.
        By default the window is available and can be shown by selecting its name in the app's Window menu.
         But we can make that even easier by assigning a Command-0 keyboard shortcut to open the window.
         To make sure I stay a budget-conscious party planner, I'll add a toolbar button with an action that also shows this window.
         Using the environment action openWindow, I can now programmatically open new SwiftUI-managed windows.
         In fact, we've added a whole suite of new window customizations this year, including modifiers for default size, position, resizability, and more.
         I don't want the party budget getting in the way, so by default it appears as a small corner window.
         But if I adjust its position or size, SwiftUI will automatically remember that across app launches.
         The new standalone window scene is great for little auxiliary windows like this one on the Mac, but Party Planner is a multiplatform app, and we need a better design for smaller screens.
         For example, on iOS we've chosen to display our budget within a resizable sheet instead.
         This is possible with the new presentationDetents() modifier.
         In this case, I configured a resizable sheet that sticks to two different sizes: one at 250 points, and another at a system-defined medium height.
         It is simple to iterate between platforms this year with multiplatform targets in Xcode powering up your SwiftUI-based apps.
         One target can be deployed to multiple platforms.
         Just pick your platform from the usual pull-down menu in Xcode's toolbar.
         Watch "What's new in Xcode" and follow it up with "Use Xcode to develop a multiplatform app" to learn more.
         For the final new scene type, we can turn our attention to the menu bar.
         With macOS Ventura, you can now build MenuBarExtras entirely in SwiftUI! These can be defined alongside other scene types in your application and will always be shown in the menu bar while your app is running.
         Or, you can build an entire app using just a MenuBarExtra! These are such a fun way to bring even the simplest of ideas to life on macOS.
         "Bring Multiple Windows to your SwiftUI App" has more detail on how to take advantage of all the new scene types and features.
         Now that we've got control of windows, I'll pass it over to Franck, to put controls in windows.
         Franck: Thanks, Nick! This year, we have a variety of enhancements across all our APIs for building interactive content.
         We have a lot to cover, so let's get this party started with some fun enhancements to forms.
         macOS Ventura comes with a brand-new System Settings app, that features a streamlined navigation structure, built using the navigation split view and stacks that Nick just walked us through.
         It also sports a fresh and modern interface style.
         Settings interfaces are control-heavy, so this style was specifically designed to present forms containing many controls in a consistent and well-organized fashion.
         We've also adopted this new design within our Party Planner app.
         Let's take a look.
         Our Event Details view also features many different types of controls grouped into sections, serving a similar purpose as a settings interface.
         This makes it a great candidate to adopt the new visual style from System Settings.
        You can enable this design using the new grouped formStyle on macOS.
         And thanks to the flexibility of SwiftUI's declarative APIs, content and controls within the form will automatically adapt to the new style.
         For example, sections will visually group their content below their headers; and controls will consistently align their labels and values to the leading and trailing edges.
         Some controls may adapt their visual appearance as well, such as how toggles display as trailing mini switches for consistent layout and alignment.
         And since the form itself provides a lot of visual structure, other controls adapt to this context with a lighter-weight visual appearance, and reveal more prominent control backings on rollover.
         SwiftUI makes it easy to align other types of content to this new style, using the new LabeledContent view, which can be used to build new controls or even just display some read-only information.
         In this case, we're displaying some text for the location of the event, and SwiftUI automatically adjusts the styling and allows selection of that text.
        But LabeledContent can also wrap any kind of view, like if we wanted to use a custom view for displaying more entire addresses.
         SwiftUI is now smarter about applying default styling to text in other cases too.
         It will hierarchically format multiple pieces of text within a control's label to form titles and subtitles.
         This new form design looks great on macOS, but we can also share a lot of this same code with the iOS version of our app.
        You'll notice some improved designs on iOS as well, like these pop-up menu pickers with a visual style inspired by macOS, but with their interactions and appearance optimized to fit beautifully within a touch-based interface.
         Of course, the same code works great on iPad's larger screen, and together with the Mac, you can see how SwiftUI's declarative model helps you share code when building shared interfaces, helping you bring the party to every platform.
         Of course, we're also improving controls beyond just form styles.
         So let's take a lightning-round tour of some other new control features we're using in the Party Planner app.
         Let's start with the New Activity page in our iOS app.
         Text fields can be configured to expand vertically using the new axis parameter, growing their height to fit the text and, if specified, capping their height to the line limit.
         But the lineLimit modifier now also supports more advanced behaviors, like reserving a minimum amount of space and expanding as more content is added, and then scrolling once the content exceeds the upper limit.
         Below our text fields, we also see an example of the new MultiDatePicker control, supporting noncontiguous date selection to help us spread our party activities throughout the week.
        Now at this point, maybe you're having some mixed feelings about the party theme for this talk.
         The great news is you can now express those feelings in SwiftUI, using mixed-state controls! Here we have a group of toggles that can be collapsed into a single aggregate toggle.
         The inner toggles each take a single binding whereas the aggregate Toggle takes a collection of all the bindings displaying a mixed state if their values don't all match.
        Pickers work the same way.
         This decoration theme picker changes its value to reflect the currently selected decoration.
         But if we select multiple decorations, it will show the themes for all them using a mixed-state indicator.
         Now, let's switch back to our iOS app.
         We have a few button-style toggles for choosing the event hashtags.
         We can help differentiate each toggle by simply adding a bordered button style.
         Button styles like this will now apply to any control that supports a button-like appearance, including toggles, menus, and pickers.
         Moving on to steppers, you can now provide a format for its value.
         On macOS, a formatted stepper will display its value in an editable field.
         And steppers are also now available on watchOS.
         Apple Watch sports one of my favorite new features: Accessibility Quick Actions, an alternative way to perform actions by clenching your hand.
         A Quick Action can be defined just like any other UI action, using a button, allowing us to share the same code for both visible buttons and their equivalent Quick Actions.
         All right, we just covered a lot of different controls, but of course, controls are not the only sources of interactivity.
         So let's take a look at what's new with larger interactive containers, like tables and lists.
        I am excited to share that tables are now supported on iPadOS.
         As you would expect, tables on iPadOS are defined using the same Table API we introduced last year for macOS, making it easy to share code between platforms.
         Our Invitations table shows three columns for the name, city, and invitation status of each person, taking advantage of the iPad's large display.
         But this table will also render appropriately in compact size classes, including on iPhone, showing just the primary column within the smaller screen space.
         Let's switch contexts and check out this table on macOS.
         It's looking great! But speaking on contexts, I'd love to add some context menus for performing common actions within the table.
         This is a job for the new selection-based contentMenu modifier.
         The modifier takes a selection type, and will be enabled within any compatible table or list that supports selection.
         Within the menu builder, you are given a collection of the current selection, allowing you to build advanced context menus that can operate on a single selected row, multiple selected rows, or even no row selected, such as when clicking on the empty area of the table.
         Context menus reveal actions directly within the table, which is great for speed and efficiency.
         But I would also like to make these actions more discoverable.
         A great way to improve discoverability is by displaying common actions as buttons in the toolbar, and iPadOS has a new and improved toolbar design to help achieve that extra level of polish.
         iPad toolbars can now support user customization and reordering, which your app can implement by providing explicit identifiers for each toolbar item, the same API available on macOS.
         These identifiers allow SwiftUI to automatically save and restore custom toolbar configurations across app launches.
         Note that on iPadOS, not all toolbar items allow customization.
         Customizable actions are configured using the new secondaryAction toolbar item placement, which shows up in the center of the toolbar by default, or in an overflow menu in compact-size classes.
         All right! The word is spreading around and it looks like the number of attendees is growing exponentially.
         Let's help our table manage the scale by adding support for search.
         SwiftUI already supports basic search with a searchable modifier.
         And new this year, search fields can support tokenized inputs and suggestions to help build more structured search queries.
         To help with filtering results, SwiftUI now supports search scopes, which appear in a scope bar beneath the toolbar on macOS and as a segmented control within the navigation bar on iOS.
         We have only scratched the surface of what is possible with SwiftUI on iPad this year.
         Check out the "SwiftUI on iPad" series and learn more.
         Now that we have a bit more control over the event details and logistics, let's share the news and get people even more excited.
         Sharing content with other people, as well as sharing data across applications are essential parts of many apps.
         Taking advantage of these features makes your app even more integrated into the workflows of the people who use them.
         This year we have a few exciting areas to make that even easier.
         Let's start with PhotosPicker, a new multiplatform and privacy-preserving API for picking photos and videos.
         Since photos are an essential part of any party, I've added a feature to the Party Planner app that adds fun birthday effects to photos that were taken.
         The new PhotosPicker view can be placed anywhere in your app, and on activation, presents the standard photos-picking UI to select photos or videos from the user's library.
         PhotosPicker take a binding to a selected item, which provides access to the actual photo and video data.
        It also has additional rich configuration options, such as filtering the type of content, preferred photo encoding, and more.
        This is the most photogenic cupcake I have ever seen.
         But one cupcake isn't enough.
         Let's apply the special effect as we move on.
         Now that we have our customized photo, we're ready to share it with the new ShareLink API.
         Each platform has a standard interface for allowing people to share content from your apps.
         With watchOS 9, you can now also present the share sheet from within your watch apps.
         The new ShareLink view enables presenting that system share sheet from within your app.
         You can simply provide it with the content to be shared and a preview to use in the share sheet, and it automatically creates a standard share icon button.
        On tap, it presents the standard share sheet to send off the content.
         Share links adapt to the context they're applied to, such as in context menus and across platforms.
         PhotosPicker, ShareLink, and more all take advantage of the new Transferable protocol, a Swift-first declarative way to describe how types are transferred across applications.
         Transferable types are used to power SwiftUI features like drag-and-drop, which makes it easy to drop images from other apps into the Party Planner gallery.
         This makes use of the new dropDestination API, which accepts a payload type, in this case, just an image.
         The completion block provides a collection of the received images together with the drop location.
        Many standard types, such as string and image, already conform to Transferable.
         So it wasn't much work to get the ball rolling in our app, but you can easily take things further and implement Transferable in your own custom types.
         When it's time to do that, your conformance declares the representations appropriate for your type, such as using Codable support and a custom content type.
         To learn more about Transferable, other representations, and advanced tips and tricks, check out the "Meet Transferable" talk.
         While we were preparing the cupcakes, Nick was laying out all the supplies.
         Nick, how's it going over there? Nick: Almost done! I'm arranging these party horns in a completely custom layout, but I'll need a little more time.
         Let's talk graphics first.
         ShapeStyle has new APIs to achieve rich graphical effects this year.
         We'll use these APIs to give this guest card some party pop! Color has a new gradient property that adds a subtle gradient derived from the color.
         These look great with the system colors.
        ShapeStyle also got a new shadow modifier.
         Adding it to the white foreground style adds a shadow to the text and to the symbol.
         And the detail of this shadow is remarkable.
         The drop shadow has applied to every element of the Calendar symbol.
        With the whole world of SF Symbols and the new SwiftUI ShapeStyle extensions, you can make some absolutely gorgeous icons.
        Now, it's time to bring that grid of SF Symbols to the party.
         We'll iterate quickly on it using SwiftUI Previews, which has some fantastic improvements this year.
         Previews have always been a convenient way to see a view in multiple configurations at the same time.
         With Xcode 14, we're making this easier than ever with preview variants.
         These let you develop your view in multiple appearances, type sizes, or orientations at the same time without writing any configuration code.
         We can use that same gradient again, or we can style it as an elliptical gradient to give these images a soft glow.
         and preview it in dark and light appearances.
        Previews now runs in live mode by default.
         It can't be a great birthday party without a little dancing, so let's get these SF Symbols dancing.
         ♪ Electronic dance music ♪ ♪ Those jovial icons demonstrate something profound.
         SwiftUI has taken text and image animations to the next level.
         Let's watch that text animate again in slow motion.
         Text can now be beautifully animated between weights, styles, and even layouts.
         And the best part: this takes advantage of the same animation APIs used throughout the rest of SwiftUI.
         Let's close by talking about my absolute favorite part of UI programming, applied geometry -- or as we call it, Layout.
         SwiftUI has added new ways to lay out views.
         Grid is a new container view that arranges views in a two-dimensional grid.
         Grid will measure its subviews up front to enable cells that span multiple columns and enable automatic alignments across rows and columns.
         In fact, you already got a look at grid earlier.
        Using Grid, GridRow, and the gridCellColumns modifier, you can build up a grid piecemeal.
         Of course, just like all layouts in SwiftUI, they're built for composition.
         We introduced SwiftUI's layout model with the first release, providing a toolbox of primitive layout types to achieve some of the most common layouts.
         Most of the time, you can get the job done with these primitive layout types, but sometimes, sometimes, you want that imperative layout code: the size, the minX, the frame.origin.x minus frame.midX divided by 2 plus 3.
         It's times like these when you should reach for the new Layout protocol.
         With it, you have the full power and flexibility we used to implement SwiftUI's stacks and grids to build your own first-class layout abstractions.
         Using Layout, I built this bespoke seating chart layout for the guests at our birthday party.
         Should our party guests sit in rows or pods? With the power of Layout, we don't have to choose.
         Using the Layout protocol, you can build all kinds of efficient layouts, tailored to the specific needs of your view hierarchies.
         To learn how to adopt Layout and about other new, great layout techniques, check out the "Compose custom layouts with SwiftUI" session.
         I've prepared a taste of Layout especially for you.
         Using the new AnyLayout type, I can switch between the Grid layout and a custom scattered layout I've written.
         As this session draws to a close, there's one surprise left: You're invited! ♪ You are invited to celebrate SwiftUI's birthday and all of the new APIs with us this week.
         There is a lot of detail left to explore in the APIs we covered, and even more APIs that we didn't have time to include.
         Enjoy the party, and enjoy WWDC 2022.
         And we are going to enjoy some cake.

        """
    }

    var japanese: String {
        """
        こんにちは、私はニックです。
         そして私はフランクで、私たちはSwiftUIのエンジニアです。
         今日は、"SwiftUIの新情報 "を取り上げます。
         SwiftUIは、私たちのオペレーティングシステムと一緒に成長しており、それぞれが他の境界を押し広げています。
         私たちは、あなたがSwiftUIで作っているものに驚き、喜び続けています。
         私たちは、コミュニティからのあらゆる種類のフィードバックを心に留めています。
         それが、私たちが今年に焦点を当てたものを共有することに特に興奮している理由です。
         今年のAPIで、私たちはより深くなりました。
         より多くのカスタム体験を可能にしました。
         驚くほど新しいグラフィカルな技術も導入しました。
         新しいSwiftUIアプリの構造を設計し、さらに多くのことを行いました。
         SwiftUIによって、私たちのプラットフォームの未来を反映するデザインと機能を構築することができました。
         古典的なアプリの再設計から、全く新しい機能、深いシステム統合まで。
         このApple内での包括的な採用は、SwiftUIの進化をさらに推し進めます。
         これらの新しいデザインと機能の多くは、SwiftUIがAppleでアプリケーションを書く方法を進化させたからこそ、可能になったのです。
         今日、私たちはこれらのAPIを祝い、また、SwiftUIの誕生日を祝っています。
         私たちがパーティーのために計画したアクティビティについてお話しましょう。
         私は、Swift Chartsと呼ばれる全く新しいフレームワークを紹介し、私たちのすべてのプラットフォームで楽しいデータの視覚化を作成できるようにします。
         私は、SwiftUI のデータ駆動型、強い型付けのナビゲーションモデルと新しいウィンドウのテクニックを披露します。
         Franck は、一連の新しいコントロールと、既存のコントロールのより深いカスタマイズを紹介します。
         そして、Transferableプロトコルによって、SwiftUIの世界にどのようにエレガントに共有を持ち込んだかをお見せします。
         最後に、気まぐれな新しいグラフィックスAPIと先進的な新しいレイアウトAPIで締めくくります。
         それでは、Swift Chartsを始めましょう。
         Swift Chartsは美しいステートドリブンなチャートを構築するための宣言的なフレームワークです。
         SwiftUI を優れたものにする基本的な設計原則と、データをプロットするプロセスが、世界クラスのデータ可視化フレームワークである Swift Charts を作成するために調和して構成されています。
         これは、Franckと私がパーティーの開始前に完了しなければならないタスクの数をプロットした棒グラフです。
         Swift Charts は数行のコードから壮大でカスタマイズ可能なチャートを構築しました。
         SwiftUI のように、Swift Charts はインテリジェントなデフォルトを選択します。
         ここでは、フレームワークはY軸の値のために満足のいく丸い数字を選び、バーのマークのためにデフォルトの色を提供しました。
        SwiftUIを知っていれば、すでにSwift Chartsの宣言的でステートドリブンな構文を読み取ることができます。
         データを提供し、そのデータでチャートのコンテンツを構築することによって、リストやテーブルを行うのと同じようにそれを宣言します。
         このチャートでは、BarMarkを選びましたが、LineMarkに切り替えて、カテゴリでグループ化するために前景スタイルを追加すると、Swift Chartsがそれぞれのカテゴリに対して個別の線を描き、チャートに自動的に凡例を追加するので、ストーリーがもっと見えてきます。
         これらのチャートに少し個性を持たせるのは楽しいことです。
         ラインマークのシンボル修飾子で線にポイントを追加することができます。
         これらのモディファイアはSwiftUIのモディファイアと何ら変わりません。
         チャートの中でSwiftUIのビューを使うこともできます。
         リストのように、Chartへのデータ引数は、代わりにForEachに渡すことができます。
         これにより、毎日の目標を示すRuleMarkのような、より多くのマークをChartビルダーに追加することができます。
        Swift Chartsはローカライズ、ダークモード、ダイナミックタイプを自動的に処理し、もちろん、すべてのプラットフォームで動作するので、SwiftUIの精神は再び輝きを取り戻しました。
         あなた自身のチャートを作る方法を見たいなら、"Hello Swift Charts" をチェックしてください。
         高度なプロットテクニックに興味があるなら、"Raise the bar" セッションでフォローアップしてください。
         次は、ナビゲーションとウィンドウについてです。
         SwiftUIはすでに、没入感のあるプッシュ＆ポップ式のナビゲーションスタック、広くて詳細なスプリットビュー、パワフルでマルチウィンドウの体験など、最も一般的なアプリのナビゲーションパターンをサポートしています。
        今年、SwiftUIはこれらの3つのパターンすべてに対して大きなアップデートを行いました。
         スタックから始めましょう。
         SwiftUI は、プッシュアンドポップスタイルのナビゲーションをサポートするために、単に NavigationStack と呼ばれる、新しいコンテナビューを導入します。
         NavigationStackは、パーティーを計画するアプリの食べ物の在庫リストのような、ルートコンテンツビューを包み込みます。
         予想されるように、これは NavigationLink や navigationTitle() のような既存の API とうまく機能します。
         リンクを選択すると、SwiftUIはその詳細なビューをスタックの一番上にプッシュします。
         私たちのアプリでは、それぞれの詳細ビューには、素早くブラウジングするために関連する食品アイテムのためのより多くのリンクが含まれています。
        このアプローチはあなたが必要とするすべてかもしれません。
         しかし、ビューを表示し、その表示状態をプログラムで制御する新しい方法があります。
         ナビゲーションスタックの状態を制御する必要がある場合は、新しいデータ駆動型APIを採用してください。
         新しいnavigationDestination()修飾子を使用すると、ナビゲーションの目的地を特定のデータ型と関連付けることができます。
        そして今年、私たちは NavigationLink に新しいパーティートリックを教えました: 目的地ビューの代わりに、目的地を表す値を取ることができます。
         リンクをタップするとき、SwiftUIは値の型を使用して正しい目的地を見つけ、以前のようにスタックにそれをプッシュします。
         スタックを駆動するためにデータを使用するので、明示的な状態として現在のナビゲーションパスを表現することができます。
         この場合、ナビゲーションパスは、これまでに訪れたすべての食品の配列になります。
         この状態に直接アクセスできるので、最初に選択したアイテムにすばやくジャンプして戻るためのボタンを追加するのは、これ以上ないほど簡単なことです。
         ビューがスタックにプッシュされると、selectedFoodItems 配列にアイテムが追加されます。
         ボタンのアクションでは、最初のアイテムを除いて、すべてのアイテムをパスから削除できます。
        そして、タップすれば、元の場所に戻ることができます。
        次に、マルチカラムナビゲーションのためのスプリットビューについて説明します。
         マルチカラムナビゲーション用に、NavigationSplitViewという別の新しいコンテナを導入します。
         NavigationSplitViewは、2カラムと3カラムのレイアウトを宣言することができます。
         パーティープランナーでは、シンプルな2カラムのレイアウトを使用し、パーティープランニングのタスクのサイドバーリストと、選択したタスクによって内容が変わる詳細ビューをラップしています。
         スプリットビューは、先に紹介した新しい値ベースのナビゲーションリンクと相性がよく、リンクの値を使ってリストの選択を行います。
         NavigationSplitViewは、小さいサイズのクラスやデバイスでは自動的にスタックに折り畳まれるので、適応性のあるマルチプラットフォームアプリケーションを構築するための素晴らしいツールになります。
         NavigationSplitViewとNavigationStackは一緒に動作するように設計されており、直接合成してより複雑なナビゲーション構造を構築することができます。
         パーティー プランナー アプリでは、これを使用して、詳細列を独自の自己完結型ナビゲーション スタックに変換しています。
        さて、私たちは食べ物についてたくさん話しましたが、私の同僚であるCurtは、彼の講演 "The SwiftUI cookbook for navigation "で嵐を炊いているそうです。
         ナビゲーションスタックとナビゲーションのスプリットビューについてさらに学ぶために、それをチェックしてみてください。
         しかし、今のところ、箱の外に出て、新しいシーンAPIについて話しましょう。
         WindowGroupは、アプリのメインインターフェイスを構築する優れた方法であり、複数のウィンドウを生成してアプリのデータに異なる視点を持たせることができるため、すでにおなじみでしょう。
         今年新たに追加された window は、ご想像のとおり、アプリに単一のユニークなウィンドウを宣言するものです。
         ここでは、パーティーの総費用を表示する「Party Budget」ウィンドウを追加しています。
        このウィンドウはデフォルトで使用可能で、アプリのウィンドウメニューで名前を選択することで表示されます。
         しかし、Command-0のキーボードショートカットを割り当てれば、もっと簡単にウィンドウを開くことができます。
         予算重視のパーティープランナーであり続けるために、このウィンドウを表示するアクションを持つツールバーボタンを追加しておきます。
         環境のアクションopenWindowを使うことで、SwiftUIで管理された新しいウィンドウをプログラムによって開くことができます。
         実際、デフォルトのサイズ、位置、リサイズ可能性などのための修飾子を含む、新しいウィンドウのカスタマイズのスイートを今年追加しました。
         私はパーティーの予算が邪魔にならないように、デフォルトでは小さなコーナーウィンドウとして表示されます。
         しかし、その位置やサイズを調整すると、SwiftUIは自動的にアプリの起動を越えてそれを記憶します。
         新しいスタンドアロンウィンドウのシーンは、Macでのこのような小さな補助ウィンドウには最適ですが、Party Plannerはマルチプラットフォームのアプリであり、小さなスクリーンにはより良いデザインが必要です。
         たとえば、iOS では、サイズを変更できるシートの中に予算を表示することにしました。
         これは、新しいpresentationDetents()モディファイアを使用することで可能です。
         今回は、250ポイントと、システムで定義された中間の高さの2種類のサイズにこだわったリサイズ可能なシートを設定しました。
         XcodeのマルチプラットフォームターゲットがSwiftUIベースのアプリをパワーアップしているので、今年は、プラットフォーム間で反復するのが簡単です。
         1つのターゲットを複数のプラットフォームにデプロイすることができる。
         Xcodeのツールバーの通常のプルダウンメニューからプラットフォームを選択するだけです。
         Xcodeの新機能」を見て、「Xcodeを使用してマルチプラットフォームアプリを開発する」で詳細を確認してください。
         最後の新しいシーンタイプについては、メニューバーに目を向けることができます。
         macOS Venturaでは、MenuBarExtrasを完全にSwiftUIで構築できるようになりました! これらは、アプリケーションの他のシーンタイプと一緒に定義することができ、アプリケーションが実行されている間、常にメニューバーに表示されます。
         または、MenuBarExtraだけを使って、アプリ全体を構築することもできます! これらは、最もシンプルなアイデアをmacOS上で実現する、とても楽しい方法です。
         「SwiftUI アプリに複数の Windows を導入する」で、すべての新しいシーンタイプと機能を利用する方法についてより詳しく説明しています。
         ウィンドウのコントロールができたので、ウィンドウにコントロールを入れるために、Franckにバトンタッチします。
         Franckです。ありがとう、Nick! 今年は、インタラクティブなコンテンツを構築するためのAPIが、さまざまに強化されています。
         その中から、まずはフォームの拡張をご紹介します。
         macOS Venturaには、まったく新しいシステム設定アプリが搭載されています。このアプリは、先ほどNickが説明したナビゲーションのスプリットビューとスタックを利用して構築された、合理的なナビゲーション構造を特徴としています。
         また、新鮮でモダンなインターフェイスのスタイルも採用されています。
         設定」のインターフェイスはコントロールが多いため、このスタイルは、多くのコントロールを含むフォームを一貫してうまく整理して表示するために特別に設計されました。
         パーティープランナー」アプリでも、この新しいデザインを採用しています。
         見てみましょう。
         イベントの詳細」画面でも、さまざまな種類のコントロールがセクションにまとめられており、設定画面と同じような役割をしています。
         このため、システム設定から新しいビジュアルスタイルを採用するのに最適な候補となります。
        macOSの新しいグループ化されたformStyleを使用して、このデザインを有効にすることができます。
         そして SwiftUI の宣言型 API の柔軟性のおかげで、フォーム内のコンテンツとコントロールは自動的に新しいスタイルに適応します。
         たとえば、セクションはヘッダーの下にあるコンテンツを視覚的にグループ化し、コントロールは一貫してラベルと値を先頭と末尾のエッジに揃えます。
         例えば、トグルは一貫したレイアウトと配置のために末尾のミニスイッチとして表示されるなど、いくつかのコントロールは見た目を適応させることができます。
         そして、フォーム自体が多くの視覚的な構造を提供するので、他のコントロールは軽量な視覚的な外観でこのコンテキストに適応し、ロールオーバーでより目立つコントロールバックを表示します。
         SwiftUI では、新しい LabeledContent ビューを使用して、他のタイプのコンテンツをこの新しいスタイルに簡単に揃えることができます。
         この場合、イベントの場所のためにいくつかのテキストを表示しており、SwiftUIは自動的にスタイルを調整し、そのテキストを選択することができます。
        しかし、LabeledContentは、より多くの全体のアドレスを表示するためのカスタムビューを使用したい場合のように、任意の種類のビューをラップすることができます。
         SwiftUIは他のケースでもテキストにデフォルトのスタイルを適用することをより賢くなりました。
         タイトルやサブタイトルを形成するために、コントロールのラベル内の複数のテキストを階層的にフォーマットします。
         この新しいフォームのデザインは macOS で素晴らしく見えますが、この同じコードの多くを iOS 版のアプリと共有することもできます。
        例えば、ポップアップメニューピッカーは、macOSのビジュアルスタイルにインスパイアされていますが、タッチベースのインターフェイスに美しくフィットするようにインタラクションや外観が最適化されており、iOSでもいくつかのデザインが改善されていることに気づかれるでしょう。
         もちろん、同じコードはiPadの大きなスクリーンでも素晴らしく機能します。Macと一緒に、SwiftUIの宣言型モデルが、共有インターフェースを構築する際にコードの共有を助け、すべてのプラットフォームでパーティを開催するのに役立つことがお分かりいただけると思います。
         もちろん、私たちはフォームスタイル以外のコントロールも改善しています。
         そこで、Party Plannerアプリで使用している他の新しいコントロール機能のライトニングラウンドツアーに参加しましょう。
         まず、iOSアプリの「新規活動」ページです。
         テキストフィールドは、新しい axis パラメータを使用して垂直方向に展開し、テキストに合わせて高さを伸ばし、指定された場合は行の制限に高さの上限を設定することができます。
         しかし、lineLimit修飾子は、最小限のスペースを確保し、コンテンツが追加されると拡大し、コンテンツが上限を超えるとスクロールするなど、より高度な動作もサポートするようになりました。
         テキストフィールドの下には、新しい MultiDatePicker コントロールの例もあり、連続しない日付の選択をサポートしているので、パーティーの活動を週単位で分散させることができます。
        さて、この時点で、今回のパーティーのテーマについて、複雑な心境になっているかもしれませんね。
         素晴らしいニュースは、混合状態のコントロールを使用して、SwiftUIでその感情を表現できるようになったことです。ここでは、1つの集約されたトグルに折り畳むことができるトグルのグループを持っています。
         内側のトグルはそれぞれ単一のバインディングを取るのに対し、集約されたトグルはすべてのバインディングのコレクションを取り、それらの値がすべて一致しない場合、混合状態を表示します。
        ピッカーも同じように動作します。
         この装飾テーマピッカーは、現在選択されている装飾を反映してその値を変更します。
         しかし、複数の装飾を選択した場合は、すべての装飾のテーマが混在した状態で表示されます。
         さて、iOS アプリに話を戻しましょう。
         イベントのハッシュタグを選択するための、いくつかのボタン型トグルがあります。
         それぞれのトグルを区別するために、境界線のあるボタンスタイルを追加します。
         このようなボタンスタイルは、トグル、メニュー、ピッカーなど、ボタンのような外観をサポートするすべてのコントロールに適用されます。
         ステッパーに話を移すと、その値のフォーマットを指定できるようになりました。
         macOSでは、フォーマットされたステッパーは、編集可能なフィールドにその値を表示します。
         そしてステッパーは、watchOSでも利用できるようになりました。
         Apple Watchは、私のお気に入りの新機能の一つを備えています。アクセシビリティ・クイックアクションは、手を握ることでアクションを実行する代替手段です。
         クイックアクションは、他のUIアクションと同じように、ボタンを使って定義することができ、目に見えるボタンとそれに相当するクイックアクションの両方で同じコードを共有することができます。
         もちろん、コントロールだけがインタラクティビティの源ではありません。
         そこで、テーブルやリストなど、より大きなインタラクティブコンテナの新機能について見ていきましょう。
        iPadOSでテーブルがサポートされたことをお知らせできるのは、とてもうれしいことです。
         ご想像のとおり、iPadOSのテーブルは、昨年macOSで導入したのと同じテーブルAPIを使って定義されており、プラットフォーム間でのコードの共有が容易になっています。
         この招待状テーブルでは、iPadの大きなディスプレイを活かして、各人の名前、都市、招待状ステータスの3列を表示しています。
         しかし、このテーブルは、iPhoneを含むコンパクトなサイズのクラスでも適切にレンダリングされ、より小さなスクリーンスペースで主要なカラムだけを表示します。
         では、コンテキストを変えて、macOSでこの表を確認してみましょう。
         素晴らしい出来栄えです。しかし、コンテキストについて言えば、テーブルの中で一般的なアクションを実行するためのコンテキストメニューを追加したいですね。
         これは新しい選択ベースのcontentMenuモディファイアの仕事です。
         このモディファイアは選択型を取り、選択をサポートする互換性のあるテーブルやリストで有効になります。
         メニュービルダーでは、現在の選択範囲のコレクションが与えられ、選択された1行、複数行、あるいはテーブルの空の領域をクリックしたときのように選択されていない行に対して操作できる高度なコンテキストメニューを構築することが可能になります。
         コンテキストメニューは、テーブルの中で直接アクションを表示するので、スピードと効率に優れています。
         しかし、これらのアクションをもっと発見しやすくしたいと思います。
         発見力を高めるには、よく使う操作をツールバーのボタンとして表示するのが効果的ですが、iPadOSでは、そのためにツールバーのデザインが新しく改良されました。
         iPadのツールバーは、ユーザーのカスタマイズと並べ替えをサポートするようになり、アプリは、macOSで利用できるのと同じAPIである、各ツールバーアイテムの明示的な識別子を提供することによって実装することができます。
         これらの識別子によって、SwiftUI はアプリの起動中にカスタムツールバーの設定を自動的に保存し、復元することができます。
         iPadOSでは、すべてのツールバーアイテムがカスタマイズを許可しているわけではないことに注意してください。
         カスタマイズ可能なアクションは、デフォルトでツールバーの中央に表示される新しいsecondaryActionツールバーアイテムの配置、またはコンパクトサイズのクラスでオーバーフローメニューを使用して設定されます。
         よしっ! 噂が広まって、参加者が急激に増えているようですね。
         検索のサポートを追加することで、テーブルが規模を管理するのを助けましょう。
         SwiftUIはすでに検索可能なモディファイアで基本的な検索をサポートしています。
         そして今年の新機能として、検索フィールドはより構造化された検索クエリを構築するのに役立つトークン化された入力とサジェストをサポートすることができます。
         結果のフィルタリングを助けるために、SwiftUI は現在、検索スコープをサポートしており、macOS ではツールバーの下のスコープバーで、iOS ではナビゲーションバー内のセグメント化されたコントロールとして表示されます。
         私たちは今年、iPad上のSwiftUIで可能なことの表面を削ったに過ぎません。
         iPad上のSwiftUI」シリーズをチェックして、もっと学んでください。
         イベントの詳細とロジスティックスをもう少しコントロールできるようになったので、ニュースを共有し、人々をさらに興奮させましょう。
         他の人とコンテンツを共有したり、アプリケーション間でデータを共有したりすることは、多くのアプリケーションに不可欠な部分です。
         これらの機能を活用することで、アプリを利用する人のワークフローに、より深く溶け込むことができます。
         今年は、それをさらに容易にするためのエキサイティングな分野がいくつかあります。
         まずは、写真やビデオをピックするための、マルチプラットフォームでプライバシーを保護する新しい API、PhotosPicker から始めましょう。
         写真はどんなパーティーでも欠かせないものなので、撮影した写真に楽しい誕生日エフェクトを加える機能をパーティー・プランナー・アプリに追加しました。
         新しい PhotosPicker ビューは、アプリ内の任意の場所に配置でき、起動時に標準的な写真ピッキング UI を表示して、ユーザーのライブラリから写真やビデオを選択します。
         PhotosPickerは、選択されたアイテムへのバインディングを取り、実際の写真やビデオデータにアクセスすることができます。
        また、コンテンツの種類のフィルタリングや、好みの写真エンコーディングなど、豊富な設定オプションが追加されています。
        これは私が今まで見た中で最もフォトジェニックなカップケーキです。
         でも、カップケーキ1つでは物足りない。
         スペシャルエフェクトをかけながら、次に進みましょう。
         カスタマイズした写真ができたので、新しいShareLink APIを使って写真を共有する準備ができました。
         各プラットフォームには、アプリからコンテンツを共有できるようにするための標準的なインターフェイスがあります。
         watchOS 9では、ウォッチアプリの中からシェアシートを提示することもできるようになりました。
         新しいShareLinkビューは、アプリ内からそのシステムのシェアシートを提示することを可能にします。
         共有したいコンテンツと、共有シートで使用するプレビューを提供するだけで、標準的な共有アイコンボタンが自動的に作成されます。
        タップすると、標準の共有シートが表示され、コンテンツを送信することができます。
         共有リンクは、コンテキストメニューやプラットフォーム間など、適用されたコンテキストに適応します。
         PhotosPicker、ShareLink などはすべて、新しい Transferable プロトコルを利用しています。これは、アプリケーション間で型を転送する方法を記述するための Swift 初の宣言的な方法です。
         Transferable プロトコルは、ドラッグアンドドロップのような SwiftUI の機能を強化するために使用され、他のアプリケーションからパーティープランナーのギャラリーに画像を簡単にドロップできるようにします。
         これは新しい dropDestination API を利用し、ペイロード型(この場合は単なる画像)を受けとります。
         補完ブロックは、受け取った画像とドロップ先のコレクションを提供します。
        文字列や画像など、多くの標準的な型はすでに Transferable に適合しています。
         このアプリでこれを実現するのはそれほど大変な作業ではありませんでしたが、もっと踏み込んで独自のカスタムタイプに Transferable を実装することも簡単にできます。
         その際には、Codable サポートやカスタムコンテンツタイプを使うなど、自分のタイプに適した表現方法を適合性で宣言します。
         Transferable やその他の表現、高度なヒントについてもっと知りたい方は、「Meet Transferable」の講演をご覧ください。
         カップケーキの準備をしている間、ニックはすべての備品を並べていました。
         ニック、そっちはどうだい？Nick: ほぼ完成していますよ。このパーティホーンを完全にカスタムレイアウトでアレンジしているのですが、もう少し時間が必要です。
         まずはグラフィックの話をしましょう。
         ShapeStyleは今年、リッチなグラフィック効果を実現するための新しいAPIを導入しました。
         このAPIを使って、このゲストカードにポップな印象を与えてみましょう。カラーには新しいグラデーションプロパティがあり、カラーに由来する微妙なグラデーションを追加します。
         システムカラーとの相性も抜群です。
        ShapeStyleには、新しいシャドウ修飾子が追加されました。
         これを白の前景スタイルに追加すると、テキストとシンボルに影が追加されます。
         そして、このシャドウのディテールは注目に値します。
         ドロップシャドウは、カレンダーシンボルのすべての要素に適用されました。
        SFシンボルの世界全体と新しいSwiftUI ShapeStyleエクステンションを使えば、絶対にゴージャスなアイコンを作ることができます。
        さて、いよいよSFシンボルのそのグリッドをパーティに持ち込む時が来ました。
         今年、いくつかの素晴らしい改良がなされたSwiftUIプレビューを使用して、素早く反復していきます。
         プレビューは常に、同時に複数の構成でビューを見るための便利な方法でした。
         Xcode 14では、プレビューのバリアントによって、これまで以上に簡単にできるようになりました。
         これにより、設定コードを記述することなく、複数の外観、文字サイズ、または方向で同時にビューを開発することができます。
         同じグラデーションをもう一度使うこともできますし、楕円形のグラデーションにして、画像に柔らかな輝きを持たせることもできます。
         と、ダークとライトのアピアランスでプレビューすることができます。
        プレビューは、デフォルトでライブモードで実行されるようになりました。
         このSF Symbolsを踊らせましょう。
         この陽気なアイコンは、何か深いものを示しています。
         SwiftUIはテキストと画像のアニメーションを次のレベルまで引き上げました。
         そのテキストのアニメーションをもう一度スローモーションで見てみましょう。
         テキストはウェイト、スタイル、さらにはレイアウトの間で美しくアニメーションさせることができるようになりました。
         そして最も良いところは、SwiftUIの残りの部分で使われているのと同じアニメーションAPIを利用しているところです。
         UIプログラミングで私が絶対に好きな部分、適用された幾何学、または私たちが呼ぶところのレイアウトについて話して、締めくくりましょう。
         SwiftUIはビューをレイアウトするための新しい方法を追加しました。
         Gridは新しいコンテナビューで、2次元のグリッドにビューを配置します。
         グリッドは、複数の列にまたがるセルを有効にし、行と列をまたぐ自動的な整列を可能にするために、そのサブビューを前もって測定します。
         実は、グリッドについては、以前にすでに見ています。
        Grid、GridRow、そしてgridCellColumns修飾子を使えば、グリッドを部分的に構築することができます。
         もちろん、SwiftUIのすべてのレイアウトと同じように、これらは構成のために構築されています。
         最初のリリースでSwiftUIのレイアウトモデルを導入し、最も一般的なレイアウトのいくつかを実現するために原始的なレイアウトタイプのツールボックスを提供しました。
         ほとんどの場合、これらの原始的なレイアウトタイプで仕事を終わらせることができますが、時には、時には、サイズ、minX、frame.origin.xマイナスframe.midX÷2＋3といった命令的なレイアウトコードが必要になることがあります。
         そんな時、新しいレイアウトプロトコルに手を伸ばしてみてください。
         これを使えば、あなた自身のファーストクラスのレイアウト抽象化を構築するために、SwiftUIのスタックとグリッドを実装するために使った完全なパワーと柔軟性を手に入れることができます。
         誕生日パーティーのゲストのために、Layoutを使ってオーダーメイドの座席表レイアウトを作りました。
         パーティーのゲストは、列に座るべきか、ポッドに座るべきか？Layout のパワーで、選ぶ必要はありません。
         レイアウトプロトコルを使用すると、ビュー階層の特定のニーズに合わせて、あらゆる種類の効率的なレイアウトを構築できます。
         レイアウトを採用する方法と他の新しい、素晴らしいレイアウトテクニックについて学ぶには、「SwiftUIでカスタムレイアウトを構成する」セッションをチェックしてください。
         私はあなたのために特別にレイアウトの味を用意しました。
         新しい AnyLayout タイプを使用して、Grid レイアウトと私が書いたカスタム散布レイアウトの間を切り替えることができます。
         このセッションも終わりに近づいてきましたが、ひとつだけサプライズが残っています。あなたは招待されています! あなたは、SwiftUIの誕生日と新しいAPIのすべてを祝うために、今週私たちと一緒に招待されています。
         私たちがカバーしたAPIには、探索すべき多くの詳細が残されており、さらに私たちが含める時間がなかったAPIもたくさんあります。
         パーティーを楽しみ、WWDC 2022を満喫してください。
         そして、私たちはケーキを楽しむつもりです。
        """
    }
}

