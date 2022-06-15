import Foundation

struct WhatsNewInUIKit: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "What's new in UIKit"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6562/6562_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10068/")!
    }

    var english: String {
        """
        Welcome to "What's New in UIKit" in iOS 16.
         I'm Dima, and I'm an engineering manager on the UIKit team.
         UIKit is the powerful framework at the core of your apps.
         It has been updated to support new features in iOS 16.
        In this video, I will cover UI improvements for productivity, Control enhancements, API refinements, and I will talk about exciting new ways to use UIKit and SwiftUI together.
        We made it even easier in UIKit to develop streamlined, discoverable user interfaces with improved navigation bars that feature a new title menu, find and replace, and reimagined editing interactions for cut, copy, and paste.
         You will be able to enhance your document-based applications.
         I'll start by taking a closer look at navigation bars, updated to support desktop class toolbar capabilities.
        In iOS 16, UIKit introduces two new navigation styles to better support the needs of document based apps: browser and editor.
        The browser style is designed for apps that use history or folder structure for navigation, like web and document browsers.
        The editor is intended for interfaces centered around editing documents.
        in iOS 16, you can add a variety of bar button items to your app, a subset of which will be displayed in the center of the navigation bar.
        By tapping the "customize toolbar" entry in the menu, items can be rearranged by dragging to and from the items popup.
        The resulting new configuration persists across app launch.
        To accommodate a size change, for example, when entering side-by-side mode with another app, the system automatically provides an overflow menu to access any items that don't fit.
        We have added a title menu that works with the new navigation styles and supports a few standard functions: duplicate, move, rename, export, and print.
         These are displayed in the menu automatically when the corresponding delegate methods are implemented.
         It's also possible to add completely custom items to the title menu.
        Additionally, apps built with Mac Catalyst take advantage of the improved navigation bars by seamlessly integrating with NSToolbar with no additional code required.
        iOS 16 introduces new ways to manipulate text consistently across various apps.
         The first one is the new find and replace.
         Conceptually, it is different from the more high-level in-app search that operates on data model objects such as photos or calendar events.
         Instead, find and replace is purposefully built to work with text.
         It only takes setting a flag to activate the feature for built-in UIKit views such as UITextView and WKWebView.
        Additionally, it seamlessly works across multiple views and documents that opted into this system.
        Next, the edit menu has received a major upgrade.
         It now looks different depending on the input method used.
         On touch interaction, you get a redesigned menu that is more interactive.
        When using a pointer, you get a more full-featured context menu.
        To provide both of these experiences in a seamless way, we've introduced UIEditMenuInteraction as a full replacement for the now-deprecated UIMenuController.
        There is also new API to insert actions into a text view's menu.
        Watch "Adopt desktop class editing interactions" to learn all the details on the new edit menu, and learn how to adopt find interaction for custom views.
        There is one visual UI update I'd like to cover.
         In iOS 16, the sidebar in slide over mode automatically becomes vibrant without any additional code.
         To achieve this, UIKit manages a set of private views on your behalf.
        Those are the new productivity features in UIKit: the new customizable navigation bars, find and replace, editing interactions, as well as the powerful title menu.
         I am just scratching the surface here.
         To learn a lot more, check the "Meet desktop class iPad" session, as well as a more in depth "Build a desktop class iPad app," where you'll be walked through improving a sample app with new advanced UIKit features in iOS 16.
        Now I'm going to introduce two new controls we've added and discuss some enhancements to UIPageControl.
        The inline calendar style of UIDatePicker is now available as a standalone fully-featured component, in the form of UICalendarView.
         UICalendarView supports different types of selection behaviors, like optional single dates, as well as selecting multiple dates.
         On top of the available date range, it also supports disabling individual dates from selection.
        Moreover, you can annotate individual dates with decorations.
        One major difference between UICalendarView and UIDatePicker is that UICalendarView represents dates as NSDateComponents, rather than NSDate.
         Unlike NSDate, date components are a better, and a more correct representation of a date whereas NSDate is a representation of a point in time.
        Because NSDateComponents offer many flexibilities, you should be very explicit about which NSCalendar the components are represented by.
        Note that you should not make assumptions about the type of the current calendar.
         If you need the calendar to be Gregorian, explicitly specify the Gregorian calendar.
        To configure a Calendar view like the one shown earlier, first, create the Calendar view and set its delegate.
         To ensure that the Calendar is backed by the Gregorian NSCalendar, set the calendar property on the calendarView to a Gregorian NSCalendar.
        Next, to configure the multi-date selection.
         Create a UICalendarSelectionMultiDate object, and set the selected dates property on the selection object to existing dates you have from your data model to show in the Calendar view.
        Then, set the selection object to the calendar view's selection behavior.
        To prevent the selection of individual dates in the Calendar, implement the multiDateSelection:canSelectDate: method from the calendar's selection's delegate to control which dates can be selected.
        Dates that cannot be selected will appear greyed out in the calendar view.
        To annotate individual dates with decorations, implement the calendar delegate's calendarView:decorationForDateComponents: Method.
        For no decorations, simply return nil.
        For a default grey circle, return the default decoration.
        You can also create image decorations with options to customize its color.
         And if you need more, use the customView decoration and return your view in the view provider.
        Please note that the custom view decorations do not allow interaction and are clipped to the available space.
        The page control is also improved.
         We added the support for custom indicator images for the current page, so you can now choose different images depending on whether the page is selected or not.
        Now you can also fully customize both the orientation and the direction of the page control.
        Here is an example of configuring a vertical page control whose indicators change between the current versus the non-current pages.
        I set the page control's direction to top-to-bottom and set preferred indicator image and preferred current indicator image and that's it! Apple is committed to protecting user privacy and security.
         In iOS 15, when an application programmatically accessed the pasteboard without using system provided Paste interfaces, a banner would appear to indicate that the pasteboard was accessed.
        New to iOS 16, the system behavior has changed.
         Now, instead of a banner, we will display an alert that asks for permission to use the pasteboard.
        System paste interfaces that the users interact with provide implicit access to the pasteboard and will avoid the alert.
        If you have custom paste controls, you can replace them with the new UIPasteControl that looks and behaves like a filled UIButton.
        It is enabled whenever the pasteboard gets content compatible with the control's paste target.
        So those are the new powerful UICalendarView, the improved UIPageControl, as well as the security-oriented UIPasteControl.
         Go ahead and try them out.
         Now I'll walk you through some API refinements we've made.
        In iOS 15, detents were added to sheets which enabled building flexible and dynamic UIs.
         In iOS 16, we added support for custom detents so you can make sheets any size.
        To take advantage of this feature, use the new ".
        custom" detent and specify the sheet's height in points in an associated block.
         You can return a constant value, or a percentage of the maximum detent height.
        And you can also give your custom detent an identifier if you need to refer to it from other APIs, for example, to disable dimming above your custom detent.
        Note that the value you return from the custom block shouldn't account for the bottom safe area inset.
         This is so the same calculation works for both floating and edge-attached sheets.
        To learn more about customizing sheets with system detents and other options, watch the Customize and resize sheets in UIKit video.
         The sample code for that video has also been updated to show these new custom detent APIs.
        There are new features for SF Symbols in UIKit.
         Symbols support four rendering modes: monochrome, multicolor, hierarchical, and palette.
         UIKit would use monochrome rendering by default unless the symbol was configured with a different rendering mode.
         In iOS 16, UIKit may render individual symbols with a mode other than monochrome if no rendering mode is specified.
        Take these device symbols, for example.
         In iOS 15 and earlier, these symbols use monochrome rendering if no rendering mode is specified.
        In iOS 16, these symbols instead default to hierarchical rendering.
        Generally, a symbol's default rendering mode is the preferred way to display the symbol.
         So in this case, you should allow the default hierarchical rendering to take effect.
         However, monochrome rendering can be explicitly requested with the new UIImage.
        SymbolConfiguration. preferringMonochrome() API.
        UIKit added support for variable symbols, which allows apps to display variations of a symbol based on a value from 0 to 1.
         Suppose an app wants to depict the current volume level with a symbol.
         The app can use the speaker.3.wave.fill symbol, which has been updated to support variable rendering.
         At a value of 0, the speaker waves are faded out, indicating the lowest volume level.
         As the value increases up to 1, the speaker waves progressively fill in, indicating higher volume levels.
        If a symbol supports variable rendering, then apps can request a version of the symbol reflecting a value between 0 and 1.
        Using variable symbols is straightforward.
         You can get the regular non-variable version of a symbol with the standard SF Symbols API on UIImage.
        To get a version of that symbol with a particular variable value, simply add the variableValue parameter.
        You can even mix variable rendering with other rendering modes, such as palette, to further style the symbol.
        Many system symbols now support variable rendering, and apps can update their custom symbols to support variability as well.
        To learn how to create custom variable symbols, check out the sessions "Adopt variable color in SF Symbols" and "What's new in SF Symbols 4”.
        We've modernized UIKit to work with new Swift Concurrency features, including making immutable types such as UIImage and UIColor conform to Sendable, so you can send them between the MainActor and custom actors without compiler warning.
        For example, here we have a custom actor called Processor, and a view controller called ImageViewer which is bound to the MainActor.
         In the method sendImageForProcessing, the ImageViewer sends an image to the Processor actor for processing, to make it fancy like adding glitter and rainbows to it.
         This is safe because UIImage is immutable, so Processor has to make new copy to add the rainbows and glitter.
        Any code that has a reference to the original image doesn't show these modifications, and a shared state is not unsafely mutated.
        Contrast this with UIBezierPath, which is not Sendable because it is mutable.
        How cool is it that something that could previously only be expressed in documentation can now be checked by the compiler? To learn more about Sendable and Swift Concurrency, check out "Eliminate data races using Swift Concurrency" and "Visualize and optimize Swift Concurrency" videos.
        iOS 16 features new powerful support for external displays.
         The great news is that you don't have to update your app to take advantage of this, unless you are using old UIScreen APIs.
        You can no longer assume your app is on the main screen.
         Instead, defer to more specific APIs, like trait collection and UIScene APIs, to get the information you need.
         If your app is still not using UIScene, there's now even more reason to upgrade and to support multiple windows.
        Self-sizing cells in UICollectionView and UITableView got a major upgrade.
         Now cells are also self-resizing! In iOS 16, when the content inside a visible cell changes, the cell will automatically be resized to fit the new content.
        This new behavior is enabled by default, and UICollectionView and UITableView each have a new selfSizingInvalidation property that gives you control over this new functionality.
        Here is how it works: When selfSizingInvalidation is enabled, cells can request to be resized by their containing collection or table view.
        If you're using UIListContentConfiguration to configure cells, the invalidation happens automatically whenever the cell's configuration changes.
        For any other cases, you can call the invalidateIntrinsicContentSize method on the cell or its contentView to resize the cell.
        By default, cells will be resized with animation, but you can wrap the call to invalidateIntrinsicContentSize inside performWithoutAnimation to resize without animation.
         UICollectionView and UITableView intelligently coalesce size invalidation from cells into a single update performed at the optimal time.
        If you're using Auto Layout in your cells, you can opt-in to an even more comprehensive behavior by choosing enabledIncludingConstraints.
         This means when a cell detects any auto layout changes inside its contentView, it will automatically call invalidateIntrinsicContentSize on itself so that the containing collection or table view can resize it if necessary.
         This makes it incredibly easy to have cells that automatically adjust their size in response to content or layout updates.
        UIKit is powerful and flexible.
         You can also take advantage of the expressiveness of implementing UIs using SwiftUI.
         We've made it much easier to incorporate both frameworks in the same app.
        In iOS 16, there is an entirely new way to build cells for your collection and table views using SwiftUI.
        This is made possible by a new content configuration type named UIHostingConfiguration.
         With just one line of code, you can start writing SwiftUI right inside your cells-- no extra views or view controllers needed at all.
        Here is a simple custom cell written in SwiftUI using UIHostingConfiguration.
         It is extremely easily to build this cell.
        Not only is this a great way to start integrating SwiftUI into your app, the expressive nature of SwiftUI means there's never been a more powerful way to build custom cells in UIKit.
         There is a lot more to this topic, so be sure to check out the video "Use SwiftUI with UIKit" to learn more.
        There are a couple of small but important changes that you should be aware of.
         To prevent users from being fingerprinted, UIDevice.
        name now reports the model name rather than the user's custom device name.
         Using the customized name now requires getting an entitlement.
        Setting UIDevice.
        orientation is no longer supported.
         Instead, use UIViewController APIs such as preferredInterfaceOrientation to express the intended orientation of your interface.
        What's next? Compile your app using iOS 16 SDK.
         Test out the new features such as text edit menus and find and replace.
         Adopt the new UIKit APIs to use new enhanced controls and productivity features.
         And experiment with the new exciting ways to incorporate SwiftUI in your UIKit app.
         Thank you.


        """
    }

    var japanese: String {
        """
        iOS 16の「UIKitの新機能」へようこそ。
         私はUIKitチームでエンジニアリング・マネージャーをしているDimaです。
         UIKit は、あなたのアプリケーションの中核となるパワフルなフレームワークです。
         iOS 16の新機能をサポートするためにアップデートされました。
        このビデオでは、生産性を高めるためのUIの改善、コントロールの強化、APIの改良を取り上げ、UIKitとSwiftUIを一緒に使うエキサイティングな新しい方法についてお話します。
        UIKitでは、新しいタイトルメニュー、検索と置換、カット、コピー、ペーストのための再創造された編集インタラクションを備えた改良されたナビゲーションバーによって、合理的で発見しやすいユーザーインターフェイスをより簡単に開発できるようになりました。
         ドキュメントベースのアプリケーションを強化することができるようになります。
         まずは、デスクトップクラスのツールバー機能をサポートするためにアップデートされたナビゲーションバーについて詳しく見ていきます。
        iOS 16 では、ドキュメントベースのアプリケーションのニーズをよりよくサポートするために、UIKit にブラウザとエディタという 2 つの新しいナビゲーションスタイルが導入されています。
        ブラウザスタイルは、ウェブブラウザやドキュメントブラウザのように、ナビゲーションに履歴やフォルダ構造を使用するアプリのために設計されています。
        エディタは、ドキュメントの編集を中心としたインターフェイスを対象としています。
        iOS 16では、さまざまなバーボタン項目をアプリに追加でき、そのサブセットがナビゲーションバーの中央に表示されます。
        メニューの「ツールバーのカスタマイズ」エントリーをタップすると、アイテムポップアップにドラッグしてアイテムを並べ替えることができます。
        新しい設定は、アプリの起動中も維持されます。
        他のアプリとサイドバイサイドになったときなど、サイズの変更に対応するため、自動的にオーバーフローメニューが用意され、サイズに合わない項目にもアクセスできるようになりました。
        新しいナビゲーションスタイルに対応したタイトルメニューを追加し、複製、移動、名前の変更、エクスポート、印刷といった標準的な機能をサポートします。
         これらは、対応するデリゲートメソッドが実装されると、自動的にメニューに表示されます。
         また、タイトルメニューに完全にカスタム化された項目を追加することも可能です。
        さらに、Mac Catalystでビルドされたアプリケーションは、追加のコードなしでNSToolbarとシームレスに統合することにより、改善されたナビゲーションバーを活用できます。
        iOS 16では、さまざまなアプリケーションで一貫してテキストを操作するための新しい方法が導入されています。
         まず一つ目は、新しい検索と置換です。
         概念的には、写真やカレンダーイベントのようなデータモデルオブジェクトを操作する、より高度なアプリ内検索とは異なります。
         その代わり、検索と置換は、テキストを扱うために特別に作られています。
         UITextViewやWKWebViewのようなUIKitの組み込みビューでは、フラグを設定するだけで機能を有効にすることができます。
        さらに、このシステムにオプトインした複数のビューやドキュメントにまたがってシームレスに動作します。
        次に、編集メニューが大幅にアップグレードされました。
         入力方法によって表示が変わるようになりました。
         タッチ操作の場合は、よりインタラクティブなメニューに生まれ変わります。
        ポインターを使う場合は、よりフル機能のコンテキストメニューが表示されます。
        これら両方の体験をシームレスに提供するために、今では非推奨となっている UIMenuController の完全な代替として、UIEditMenuInteraction を導入しました。
        また、テキストビューのメニューにアクションを挿入するための新しいAPIも用意されています。
        デスクトップクラスの編集インタラクションを採用する」を見て、新しい編集メニューの詳細と、カスタムビューに find インタラクションを採用する方法を学んでください。
        視覚的なUIのアップデートとして、1つ取り上げておきたいことがあります。
         iOS 16では、スライドオーバーモードのサイドバーが、追加のコードなしに自動的に鮮やかになります。
         これを実現するために、UIKitはあなたに代わって一連のプライベートビューを管理します。
        カスタマイズ可能なナビゲーションバー、検索と置換、編集インタラクション、そして強力なタイトルメニューなど、これらはUIKitの新しい生産性向上機能です。
         ここでは表面だけを取り上げています。
         さらに詳しく知りたい方は、「Meet desktop class iPad」セッションと、「Build a desktop class iPad app」で、iOS 16の新しい高度なUIKit機能を使ってサンプルアプリを改善する手順をご覧ください。
        それでは、今回追加した2つの新しいコントロールを紹介し、UIPageControlの機能強化について説明します。
        UIDatePickerのインラインカレンダースタイルは、UICalendarViewという形で、スタンドアロンの全機能付きコンポーネントとして利用できるようになりました。
         UICalendarViewは、複数の日付を選択するだけでなく、オプションで1つの日付を選択するなど、さまざまなタイプの選択動作をサポートしています。
         また、選択可能な日付の範囲に加え、個々の日付を選択から外すこともできます。
        さらに、個々の日付に装飾を施すことも可能です。
        UICalendarViewとUIDatePickerの大きな違いは、UICalendarViewが日付をNSDateではなくNSDateComponentsで表現していることです。
         NSDateとは異なり、日付コンポーネントは、NSDateがある時点の表現であるのに対し、より良い、より正しい日付の表現です。
        NSDateComponentsは多くの柔軟性を備えているので、コンポーネントがどのNSCalendarによって表現されているかを明確にする必要があります。
        現在のカレンダーの種類を仮定してはいけないことに注意。
         グレゴリオ暦が必要な場合は、明示的にグレゴリオ暦を指定してください。
        先に示したような Calendar ビューを構成するには、まず、Calendar ビューを作成し、そのデリゲートを設定します。
         カレンダーのバックグランドがグレゴリオ暦のNSCalendarであることを保証するために、calendarViewのcalendarプロパティにグレゴリオ暦のNSCalendarを設定します。
        次に、複数日付の選択を設定します。
         UICalendarSelectionMultiDateオブジェクトを作成し、選択オブジェクトのselectedDatesプロパティに、データモデルからCalendarビューに表示するために持っている既存の日付をセットしてください。
        そして、選択オブジェクトにカレンダービューの選択動作を設定します。
        カレンダーで個々の日付を選択できないようにするには、カレンダーの選択オブジェクトのデリゲートから multiDateSelection:canSelectDate: メソッドを実装して、どの日付を選択できるようにするか制御します。
        選択できない日付は、カレンダービューでグレーアウトして表示されます。
        個々の日付に装飾を施すには、カレンダーデリゲートの calendarView:decorationForDateComponents メソッドを実装します。メソッドを実装します。
        装飾を行わない場合は、単に nil を返します。
        デフォルトの灰色の円については、デフォルトの装飾を返します。
        また、画像の装飾を作成して、その色をカスタマイズすることもできます。
         さらに必要なら、customView デコレーションを使用して、 ビュープロバイダでビューを返します。
        カスタムビュー装飾はインタラクションを許可せず、利用可能なスペースにクリッピングされることに注意してください。
        ページコントロールも改良されています。
         現在のページに対するカスタムインジケーター画像のサポートを追加し、ページが選択されているかどうかに応じて異なる画像を選択できるようになりました。
        また、ページコントロールの方向と向きを完全にカスタマイズできるようになりました。
        ここでは、現在のページとそうでないページでインジケータが変化する垂直ページコントロールを設定する例を示します。
        ページコントロールの方向を上から下に設定し、優先インジケータ画像と優先カレントインジケータ画像を設定して完了です。Appleは、ユーザーのプライバシーとセキュリティの保護に取り組んでいます。
         iOS 15 では、アプリケーションが、システムが提供する Paste インターフェースを使用せずに、プログラムでペーストボードにアクセスすると、ペーストボードにアクセスしたことを示すバナーが表示されることがありました。
        iOS 16では、新たにシステムの動作が変更されました。
         現在は、バナーの代わりに、ペーストボードの使用許可を求めるアラートを表示するようになりました。
        ユーザーが操作するシステムペーストインターフェースは、ペーストボードへの暗黙のアクセスを提供しているため、アラートを回避することができます。
        もし、カスタムのペーストコントロールがある場合は、それらを新しい UIPasteControl に置き換えることができます。このコントロールは、塗りつぶされた UIButton のように見え、動作します。
        これは、ペーストボードがコントロールのペーストターゲットと互換性のあるコンテンツを取得するたびに有効化されます。
        以上、パワフルなUICalendarView、改良されたUIPageControl、そしてセキュリティに配慮したUIPasteControlを紹介しました。
         早速、試してみてください。
         次に、私たちが行ったAPIの改良について説明します。
        iOS 15 では、シートにディテントを追加し、柔軟で動的な UI を構築できるようになりました。
         iOS 16 では、カスタムデテントがサポートされ、任意のサイズのシートを作成できるようになりました。
        この機能を利用するには、新しい ".
        custom" detent を使用し、関連するブロックの中でシートの高さをポイントで指定します。
         定数値、または最大ディテント高さのパーセンテージを返すことができます。
        また、カスタムデテントを他の API から参照する必要がある場合、例えば、カスタムデテントより上の調光機能を無効にする場合、カスタムデテントに識別子を与えることができます。
        カスタムブロックから返される値は、下部の安全領域のインセットを考慮してはいけないことに注意してください。
         これは、同じ計算が、フローティング・シートとエッジ・アタッチド・シートの両方で機能するようにするためです。
        システムデテントやその他のオプションによるシートのカスタマイズの詳細については、UIKit のシートのカスタマイズとサイズ変更に関するビデオをご覧ください。
         このビデオのサンプルコードも、これらの新しいカスタムデテント API を示すために更新されました。
        UIKit の SF Symbols に新機能が追加されました。
         シンボルは、モノクロ、マルチカラー、ヒエラルキー、パレットの4つのレンダリングモードをサポートしています。
         UIKit は、シンボルに別のレンダリングモードが設定されていない限り、デフォルトでモノクロのレンダリングを使用することになります。
         iOS 16 では、レンダリングモードが指定されていない場合、UIKit は個々のシンボルをモノクロ以外のモードでレンダリングすることがあります。
        例えば、これらのデバイスシンボルを見てみましょう。
         iOS 15 およびそれ以前では、レンダリングモードが指定されていない場合、これらのシンボルはモノクロームレンダリングを使用します。
        iOS 16 では、これらのシンボルのデフォルトは階層的なレンダリングになります。
        一般に、シンボルのデフォルトのレンダリングモードは、そのシンボルを表示するための好ましい方法です。
         したがって、この場合、デフォルトの階層型レンダリングが有効になるようにする必要があります。
         ただし、モノクロ レンダリングは、新しい UIImage.SymbolConfiguration を使用して明示的に要求することができます。
        SymbolConfiguration.preferringMonochrome() API を使用して明示的にモノクロレンダリングを要求することができます。
        UIKitは、0から1までの値に基づいてシンボルのバリエーションを表示することができる可変シンボルをサポートするようになりました。
         例えば、あるアプリが現在の音量レベルをシンボルで表現したいとします。
         このアプリは、可変レンダリングに対応するために更新された speaker.3.wave.fill シンボルを使用することができます。
         値0では、スピーカーの波がフェードアウトし、音量が最小であることを示します。
         値が1まで増加すると、スピーカーの波が徐々に埋まっていき、より高い音量レベルを示します。
        シンボルが可変レンダリングをサポートしている場合、アプリは0と1の間の値を反映したバージョンのシンボルを要求することができます。
        可変シンボルの使用方法は簡単です。
         UIImage の標準的な SF Symbols API を使用すると、通常の非可変シンボルを取得できます。
        特定の変数値を持つシンボルのバージョンを取得するには、単に variableValue パラメータを追加します。
        可変レンダリングとパレットなどの他のレンダリングモードを混在させて、シンボルをさらにスタイル化することも可能です。
        多くのシステムシンボルは現在可変レンダリングをサポートしており、アプリはカスタムシンボルを更新して同様に可変をサポートすることができます。
        カスタム可変シンボルの作成方法については、セッション「SF Symbols で可変カラーを採用する」と「SF Symbols 4 の新機能」をご覧ください。
        UIImage や UIColor などの immutable 型を Sendable に準拠させるなど、Swift の新しい同時実行機能に対応するように UIKit を最新化しました。これにより、コンパイラの警告なしに MainActor とカスタムアクターの間でそれらを送信できるようになりました。
        例えば、ここではProcessorというカスタムアクタと、MainActorにバインドされたImageViewerというビューコントローラがあるとします。
         sendImageForProcessingメソッドで、ImageViewerはProcessorアクタに画像を送って加工し、キラキラや虹をつけるなど派手にしています。
         これはUIImageが不変なので安全で、Processorは虹やキラキラを追加するために新しいコピーを作成する必要があります。
        元の画像を参照しているコードには、このような変更は表示されませんし、共有された状態が安全でない形で変更されることはありません。
        UIBezierPathはミュータブルなのでSendableではありません。
        以前はドキュメントでしか表現できなかったものが、今ではコンパイラでチェックできるようになったというのは、なんとクールなことでしょう。Sendable と Swift Concurrency についてもっと知りたい方は、「Swift Concurrency を使ってデータレースを排除する」と「Swift Concurrency を可視化して最適化する」のビデオをご覧ください。
        iOS 16は、外部ディスプレイの新しい強力なサポートを備えています。
         素晴らしいニュースは、古い UIScreen API を使用していない限り、これを利用するためにアプリを更新する必要がないことです。
        あなたのアプリがメイン画面上にあると仮定することはもうできません。
         代わりに、trait collection や UIScene API など、より具体的な API に委ねるようにしましょう。
         まだ UIScene を使用していないアプリは、アップグレードしてマルチウィンドウをサポートする理由がさらに増えました。
        UICollectionViewとUITableViewのセルフサイズ・セルがメジャー・アップグレードされました。
         セルもセルフリサイズされるようになりました iOS 16では、表示可能なセル内のコンテンツが変更されると、セルは新しいコンテンツに合わせて自動的にリサイズされます。
        この新しい動作はデフォルトで有効になっており、UICollectionViewとUITableViewにはそれぞれ新しいselfSizingInvalidationプロパティがあり、この新機能を制御することができます。
        以下は、その仕組みです。selfSizingInvalidationが有効な場合、セルは、それを含むコレクションビューまたはテーブルビューによってサイズ変更を要求することができます。
        UIListContentConfigurationを使用してセルを構成している場合、セルの構成が変更されるたびに無効化が自動的に行われる。
        それ以外の場合は、セルまたはそのcontentViewに対してinvalidateIntrinsicContentSizeメソッドを呼び出して、セルのサイズを変更することができます。
        デフォルトでは、セルはアニメーション付きでリサイズされますが、アニメーションなしでリサイズするために、invalidateIntrinsicContentSizeの呼び出しをperformWithoutAnimationの中でラップすることができます。
         UICollectionViewとUITableViewは、セルからのサイズ無効化を、最適なタイミングで実行される単一の更新にインテリジェントにまとめます。
        セルでAuto Layoutを使用している場合、enabledIncludingConstraintsを選択することで、さらに包括的な動作にオプトインすることができます。
         これは、セルがそのcontentView内で自動レイアウトの変更を検出すると、セル自身が自動的にinvalidateIntrinsicContentSizeを呼び出し、必要であれば含むコレクションまたはテーブルビューがそのサイズを変更できるようにすることを意味します。
         これにより、コンテンツやレイアウトの更新に応じて自動的にサイズを調整するセルを、驚くほど簡単に作成することができます。
        UIKitは強力かつ柔軟です。
         SwiftUI を使って UI を実装することで、その表現力の高さを利用することもできます。
         私たちは、両方のフレームワークを同じアプリに組み込むことを、より簡単にできるようにしました。
        iOS 16では、SwiftUIを使ってコレクションとテーブルビューのセルを構築する全く新しい方法があります。
        これはUIHostingConfigurationという新しいコンテンツ構成タイプによって実現されています。
         たった1行のコードで、セルの内部でSwiftUIを書き始めることができます。追加のビューやビューコントローラーはまったく必要ありません。
        ここでは、UIHostingConfiguration を使って SwiftUI で書かれたシンプルなカスタムセルを紹介します。
         このセルを構築するのはとても簡単です。
        これはアプリにSwiftUIを統合する素晴らしい方法であるだけでなく、SwiftUIの表現力は、UIKitでカスタムセルを構築するためにこれ以上強力な方法がないことを意味します。
         このトピックにはもっとたくさんのことがあるので、もっと学ぶためにビデオ「UIKitでSwiftUIを使う」をぜひご覧ください。
        小さな、しかし重要な変更がいくつかありますので、注意してください。
         ユーザーがフィンガープリントされるのを防ぐために、UIDevice.
        name は、ユーザーのカスタムデバイス名ではなく、モデル名を報告するようになりました。
         カスタマイズされた名前を使用するには、エンタイトルメントを取得する必要があります。
        UIDevice.Orientationの設定はサポートされなくなりました。
        orientationの設定は、サポートされなくなりました。
         その代わり、preferredInterfaceOrientation などの UIViewController API を使用して、意図するインターフェースの向きを表現してください。
        次に行うことは？iOS 16 SDK を使ってアプリをコンパイルします。
         テキスト編集メニューや検索と置換などの新機能をテストする。
         新しいUIKit APIを採用して、強化された新しいコントロールと生産性機能を使用します。
         そして、あなたの UIKit アプリに SwiftUI を組み込む新しいエキサイティングな方法を試してみてください。
         ありがとうございました。

        """
    }
}

