import Foundation

struct MeetDesktopClassIPad: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Meet desktop-class iPad"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6563/6563_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10069/")!
    }

    var english: String {
        """
         David Duncan: Hi, I’m David Duncan, and in this video, I’ll be introducing you to desktop class iPad.
         iOS 16 brings advances to the tools used to design and build great apps, apps that bring more and better tools to the forefront and take advantage of all the hardware, both built in and attached.
         UIKit adds many tools to help you meet these goals for your apps.
         Updates to UINavigationBar allow you to take better advantage of screen real estate and build a great experience on all Apple platforms.
        The new Find and Replace UI is a snap to enable on built-in views and easy to add to custom ones.
         The Edit menu has been overhauled, with a new interaction-based API that integrates with the menu system.
         And collection view improvements make it easier than ever to build interfaces that let your users select and act on their content.
        For more information on Find and Replace and Edit Menu, watch "Adopt desktop class editing interactions.
        " And to see how all these features work together, watch "Build a desktop class iPad app.
        " In this video, I'll discuss changes to navigation that impact how you design your app for iOS 16.
        First are new features that make it easy to build more discoverable interfaces.
         Then features that are especially powerful for document based apps.
         And, finally, updates to Search to help accelerate and polish the experience.
        UINavigationBar is used for many different purposes on iOS, and iOS 16 acknowledges that by providing new optimized UI for many of these cases.
         UINavigationItem adds a style property, used to select from these styles: navigator, browser, and editor.
         I'll dive into each of these styles now.
        The default style, navigator, behaves exactly as a traditional UINavigationBar.
        The title is centered, there are leading and trailing bar button items, and a back button appears when there is more than 1 item on the stack.
         The browser style rearranges contents to be better optimized for interfaces where history matters as much as location, like in Files or Safari.
        The title is moved to the leading position in this styling.
        The editor style is optimized for when the primary function is document editing.
         Just like the browser style, the title is leading aligned.
         Editor UIs are often a destination, such as after selecting a document with a document picker, and so present a back button for easy access to that UI.
        The browser and editor styles both free up a lot of space in the center of the bar.
        iOS 16 takes advantage of this liberated space by allowing you to place additional controls in this region.
        Center items are part of a suite of changes to take better advantage of screen real estate, and include support for UIBarButtonItemGroup, customization support, and overflow.
        Overflow support is available in all modes, and allows the navigator style to indirectly support center items as well.
        Individual controls continue to be specified as UIBarButtonItems, but now are organized as UIBarButtonItemGroups.
         This allows for denser presentation when space is at a premium.
         In this example, there are 5 items in the bar, consisting of 4 groups.
        The first group contains a single bar button item, so this example uses a convenience method of UIBarButtonItem, creatingFixedGroup(), to create it.
        If you need a fixed group with more than 1 item, you can use the UIBarButtonItemGroup method instead.
        Fixed groups always appear first in the bar, and cannot be removed or moved by customization.
         The draw group contains a single item, so it also uses a convenience API, creatingMovableGroup (customizationIdentifier).
         Like fixed groups, movable groups cannot be removed, but can be moved.
        Because of this, they require a customizationIdentifier so their position can be tracked and saved.
         If you need a group with more than one item, you can use the UIBarButtonItemGroup method instead.
        The shapes group contains multiple items, and so uses the UIBarButtonItemGroup API to create the group.
        This group should be movable within the bar, as well as removable, and so is created as an optional group.
        This group also specifies a representativeItem, allowing UIKit to collapse the group to save space when necessary.
        The representativeItem does not specify an action, further allowing UIKit to synthesize a menu allowing selection of the items in the group.
        When the customization UI is invoked, UIKit automatically applies the rules you've specified based on how you've created your groups.
         While fixed and movable groups must stay in the bar, optional groups can be added or removed in any number.
        UIKit will try collapsing groups to keep as much functionality as possible in the bar, but if space isn't available, extra items will be moved to overflow.
        The overflow menu contains any items that are part of the customization but could not be fit into the bar, as well as the option to customize the bar.
        While UIKit will synthesize default menu elements for each bar button item, you have the option to customize the menuRepresentation if you wish.
         Finally, this example enables customization and adds the centerItemGroups.
        You enable customization by setting UINavigationItem.
        customizationIdentifier.
        The customizationIdentifier defines a unique customization of the bar, so pick a string that won't conflict with other customizations within your app.
        UIKit automatically saves and restores customizations based on this identifier.
        Next, provide the centerItemGroups themselves.
         The first four groups I've already covered.
        The format group is an optional group that isn't in the default customization, and so this code overrides the default value of the isInDefaultCustomization parameter to exclude it.
         You can still use centerItemGroups without setting UINavigationItem.
        customizationIdentifier, but customization will not be available.
         In Mac Catalyst, the UINavigationBar automatically translates its content to NSToolbar.
        The leading, center, and trailing item groups are added in order, and the customization properties of the center item groups are respected when using NSToolbar customization.
        All of the expected NSToolbar behaviors are available, as well as other properties such as the title & window proxy.
        All of this occurs by default when you optimize for the Mac.
         Next, let’s focus in on interactions that are powerful, specifically when dealing with documents.
         UINavigationBar now supports adding a menu to the title view, giving a central location to add actions that operate on the content as a whole.
         Additionally, you can add support for the share sheet and drag & drop from this menu.
         First, I’ll focus on the menu items themselves.
         Once enabled, the default title menu offers 5 commands: duplicate, move, rename, export, and print.
         These items are filtered based on specific methods in your responder chain.
         UINavigationBar has specific support for renaming, and so it will also be included if you’ve implemented a renameDelegate.
        To enable the title menu, set the titleMenuProvider, a closure that returns the final menu to be displayed.
        The closure is passed an array of suggested elements.
         You can use these as is, filter them, or add your own.
         In our example, we're adding a single additional action to the menu.
         Finally, you return the composed UIMenu.
        The title menu also allows sharing via the activity view controller and support for drag & drop.
        To enable these features, you provide a UIDocumentProperties instance that describes your document.
        UIDocumentProperties represents metadata about your document, including a preview.
         This example creates one with a URL, allowing UIKit to fetch the necessary metadata automatically.
        To enable additional features, this example creates an NSItemProvider to represent the document.
        Set a dragItemsProvider to enable drag & drop.
         This closure is past a UIDragSession, and returns an array of UIDragItems.
         This example returns a single item representing the document.
        Setting a activityViewControllerProvider enables sharing.
         This closure configures and returns a UIActivityViewController.
        Finally, assign the filled-out object to UINavigationItem.
        documentProperties, and when the title is tapped, UIKit presents the header alongside other titleMenu items.
        On Mac Catalyst, the suggested items that would be passed to the titleMenuProvider already exist in the File menu.
         Any items that you would have added to the title menu will need to be made available by other means.
        You can use the UIMenuBuilder API to add these items, or filter existing items as necessary.
        If you specify document properties, UIKit will automatically use the URL provided to manage the macOS proxy icon.
        If you set the representedURL for your windowScene manually, that will supersede UIKit's management.
        UIKit provides two mechanisms to enable Rename.
         Inline Rename is provided by setting UINavigationItem.
        renameDelegate, and provides a dedicated UI for editing the title on all platforms.
        When completed, the resulting name is passed to the delegate.
        Alternatively you can take full control over the rename experience by implementing UIResponder.
        rename(_:) and providing whatever UI you prefer.
        On iOS, the UINavigationBar provides the rename UI directly within the title view.
         On macOS, the rename UI is provided by the window's title when the navigation bar is hosted in an NSToolbar.
        To implement inline rename, conform to the UINavigationItemRenameDelegate protocol and set the navigation item's renameDelegate.
         There is only one required method, navigationItem(_:didEndRenamingWith:), that is used to receive the title accepted by the user.
        For file based apps, UIDocumentBrowserViewController now offers a renamed API.
        Search is how many users find their most important data, and advances in iOS 16 make it easier to provide an excellent search experience.
         The first thing to note is that search now takes up less space by being in line in the navigation bar on iPadOS and the toolbar on macOS.
         On iPadOS, you can restore the old behavior with UINavigationItem .
        preferredSearchBarPlacement.
         Additionally, the search bar can collapse to a button to grant more space for other controls.
         When search is activated, search suggestions appear, and they can be updated alongside the updating search query, allowing you the opportunity to assist your users in their search.
         Next, I'll describe the code needed to setup search suggestions.
        To manage search suggestions, conform to UISearchResultsUpdating and set your searchController's searchResultsUpdater.
         This allows you to update suggestions as the query changes and to act on a selected search suggestion.
        When the query changes, updateSearchResults(for:) is called, allowing you to update search suggestions.
        What suggestions to provide is up to you.
         Setting an empty array will clear the suggestions UI.
        UIKit provides UISearchSuggestionItem to specify suggestion content.
        To respond to the selection of a suggestion, implement updateSearchResults(for:selecting:).
         This method passes the selected search suggestion, so you may react to it appropriately.
         In this example I update the search by replacing the current query with the one specified by the search suggestion.
         UISearchTextField also has searchSuggestions, so if you prefer to use that class on its own, you can still implement search suggestions.
         But if you are using UISearchController, you should use its property instead.
        In iOS 16, UIKit provides new API to help you bring more productivity to your users.
         Bring more discoverability to your advanced features with center items and the title menu.
        Improve your document support by providing drag & drop and sharing directly from the navigation bar.
        Make it easier and faster to search by providing search suggestions and get a great Mac experience right out of the box, with nearly zero effort.
         Thanks for watching this video.
         I can't wait to see how you enhance your apps to be desktop class!

        """
    }

    var japanese: String {
        """
        David Duncan: こんにちは、David Duncanです。このビデオでは、デスクトップクラスのiPadを紹介します。
         iOS 16は、優れたアプリを設計・構築するためのツールに進歩をもたらし、より多くの優れたツールを前面に押し出し、内蔵と付属の両方のハードウェアをすべて活用するアプリを実現します。
         UIKitは、アプリのこれらの目標を達成するために多くのツールを追加します。
         UINavigationBarのアップデートにより、スクリーンリアエステートをより有効に活用し、すべてのAppleプラットフォームで素晴らしいエクスペリエンスを構築することができます。
        新しい検索と置換の UI は、ビルトイン ビューで簡単に有効にでき、カスタム ビューに追加するのも簡単です。
         編集メニューは、メニューシステムと統合された新しいインタラクションベースのAPIによって、一新されました。
         また、コレクションビューの改善により、ユーザーがコンテンツを選択して操作するためのインターフェイスをこれまで以上に簡単に構築できます。
        検索と置換と編集メニューの詳細については、"デスクトップクラスの編集インタラクションを採用する "をご覧ください。
        " また、これらの機能がどのように連携しているかを見るには、"Build a desktop class iPad app "をご覧ください。
        " このビデオでは、iOS 16 用のアプリの設計方法に影響を与えるナビゲーションの変更について説明します。
        まず、より発見しやすいインターフェイスを簡単に構築するための新機能。
         次に、ドキュメントベースのアプリケーションで特に威力を発揮する機能。
         そして最後に、エクスペリエンスを加速させ、洗練させるための検索機能のアップデートです。
        UINavigationBarは、iOS上で様々な目的で使用されており、iOS 16は、これらのケースの多くに最適化された新しいUIを提供することで、それを認めています。
         UINavigationItem には style プロパティが追加され、ナビゲータ、ブラウザ、エディタといったスタイルから選択するために使用されます。
         これから、それぞれのスタイルについて詳しく説明します。
        デフォルトのスタイルであるナビゲータは、従来のUINavigationBarと全く同じように動作します。
        タイトルは中央に配置され、先頭と末尾にバー・ボタン・アイテムがあり、スタック上に1つ以上のアイテムがある場合は戻るボタンが表示されます。
         ブラウザのスタイルでは、FilesやSafariのように履歴が場所と同じくらい重要なインタフェースに最適化されるように、コンテンツを並べ替えます。
        このスタイルでは、タイトルを先頭に移動しています。
        エディタスタイルは、ドキュメントの編集を主目的とする場合に最適化されたスタイルである。
         ブラウザスタイルと同様、タイトルが先頭に配置される。
         エディターのUIは、ドキュメントピッカーでドキュメントを選択した後など、目的地となることが多いので、そのUIに簡単にアクセスできるように戻るボタンを表示します。
        ブラウザスタイル、エディタスタイルともに、バー中央のスペースが大きく解放されています。
        iOS 16では、この解放されたスペースを利用して、この領域に追加のコントロールを配置することができます。
        センターアイテムは、画面の領域をよりよく活用するための一連の変更の一部であり、UIBarButtonItemGroup のサポート、カスタマイズのサポート、およびオーバーフローを含みます。
        オーバーフローのサポートは、すべてのモードで利用可能で、ナビゲータスタイルが間接的にセンターアイテムをサポートすることも可能になります。
        個々のコントロールは引き続き UIBarButtonItems として指定されますが、UIBarButtonItemGroups として整理されるようになりました。
         これにより、スペースが限られている場合、より密な表現が可能になります。
         この例では、バーには5つのアイテムがあり、4つのグループから構成されています。
        最初のグループには、バーボタン項目が一つ入っているので、この例では、UIBarButtonItem の便利なメソッドである creatingFixedGroup() を使って作成しています。
        1つ以上のアイテムを含む固定グループが必要な場合は、代わりに UIBarButtonItemGroup メソッドを使用できます。
        固定グループは、常にバーの最初に表示され、カスタマイズによって削除したり移動したりすることはできません。
         描画グループは1つのアイテムを含むので、これも便利なAPI、creatingMovableGroup (customizationIdentifier)を使用します。
         固定グループと同様に、移動可能グループも削除はできませんが、移動は可能です。
        このため、位置を追跡して保存できるように、customizationIdentifierを必要とします。
         複数のアイテムを持つグループが必要な場合は、代わりにUIBarButtonItemGroupメソッドを使用することができます。
        shapesグループは、複数のアイテムを含むので、UIBarButtonItemGroup APIを使用して、グループを作成します。
        このグループはバー内で移動可能で、かつ取り外し可能である必要があるため、オプションのグループとして作成されます。
        また、このグループはrepresentativeItemを指定し、UIKitが必要に応じてグループを折りたたんでスペースを確保できるようにします。
        representativeItemはアクションを指定しないので、さらにUIKitはグループ内のアイテムを選択できるメニューを合成することができます。
        カスタマイズUIが起動されると、UIKitはグループの作成方法に基づいて指定されたルールを自動的に適用します。
         固定グループと移動可能グループはバー内に留まらなければなりませんが、オプションのグループはいくつでも追加したり削除したりすることができます。
        UIKitはできるだけ多くの機能をバーに残すためにグループを折りたたもうとしますが、スペースがない場合、余分な項目はオーバーフローに移動します。
        オーバーフローメニューには、カスタマイズの一部でありながらバーに収まりきらなかったアイテムや、バーをカスタマイズするためのオプションが含まれています。
        UIKitは各バーボタンのアイテムに対してデフォルトのメニュー要素を合成しますが、必要に応じてmenuRepresentationをカスタマイズするオプションが用意されています。
         最後に、この例ではカスタマイズを有効にして、centerItemGroupsを追加しています。
        カスタマイズを有効にするには、UINavigationItem.CustomizationIdentifierを設定します。
        customizationIdentifierを設定することでカスタマイズを有効にします。
        customizationIdentifierは、バーのユニークなカスタマイズを定義するので、アプリ内の他のカスタマイズと衝突しないような文字列を選びます。
        UIKitはこの識別子に基づいてカスタマイズを自動的に保存・復元します。
        次に、centerItemGroupsそのものを用意します。
         最初の4つのグループはすでに説明したとおりです。
        formatグループはデフォルトのカスタマイズにはないオプションのグループなので、このコードではisInDefaultCustomizationパラメータのデフォルト値をオーバーライドして除外しています。
         UINavigationItem.CustomizationIdentifierを設定しなくても、centerItemGroupsを使用することができます。
        customizationIdentifier を設定しなくても centerItemGroups を使用することはできますが、カスタマイズは使用できなくなります。
         Mac Catalyst では、UINavigationBar はそのコンテンツを NSToolbar に自動的に変換します。
        先頭、中央、末尾のアイテム・グループは順番に追加され、中央のアイテム・グループのカスタマイズ・プロパティは、NSToolbar カスタマイズを使用するときに尊重されます。
        期待されるNSToolbarのすべての動作は、タイトル＆ウィンドウ・プロキシなどの他のプロパティと同様に利用可能です。
        Mac用に最適化すると、これらすべてがデフォルトで発生します。
         次に、特にドキュメントを扱うときに強力なインタラクションに焦点を当てましょう。
         UINavigationBarは、タイトルビューへのメニューの追加に対応し、コンテンツ全体を操作するアクションを追加するための中心的な場所を提供するようになりました。
         さらに、このメニューから共有シートとドラッグ＆ドロップのサポートを追加することができます。
         まず、メニュー項目自体に焦点を当てます。
         デフォルトのタイトルメニューには、複製、移動、名前の変更、エクスポート、印刷の5つのコマンドが用意されています。
         これらの項目は、レスポンダチェーン内の特定のメソッドに基づいてフィルタリングされます。
         UINavigationBar は名前の変更に固有のサポートを持っているので、renameDelegate を実装している場合は、それも含まれるようになります。
        タイトルメニューを有効にするには、titleMenuProviderを設定します。これは、最終的に表示されるメニューを返すクロージャです。
        このクロージャーには、提案された要素の配列が渡されます。
         これらをそのまま使ったり、フィルタリングしたり、独自のものを追加したりすることができる。
         この例では、メニューに1つのアクションを追加しています。
         最後に、構成されたUIMenuを返します。
        タイトルメニューは、アクティビティ・ビュー・コントローラーを介した共有やドラッグ＆ドロップのサポートも可能です。
        これらの機能を有効にするには、ドキュメントを記述するUIDocumentPropertiesインスタンスを提供します。
        UIDocumentPropertiesは、プレビューを含む、ドキュメントに関するメタデータを表します。
         この例では、UIKit が必要なメタデータを自動的に取得できるように、URL を使用して 1 つを作成します。
        追加の機能を有効にするために、この例ではドキュメントを表す NSItemProvider を作成しています。
        ドラッグ＆ドロップを可能にするために、dragItemsProvider を設定します。
         このクロージャは、UIDragSessionを過ぎて、UIDragItemsの配列を返します。
         この例では、ドキュメントを表す1つのアイテムを返します。
        activityViewControllerProvider を設定すると、共有が可能になります。
         このクロージャーは、UIActivityViewController を設定し、返します。
        最後に、記入されたオブジェクトをUINavigationItem.DocumentPropertiesに割り当てます。
        documentPropertiesに割り当て、タイトルがタップされると、UIKitは他のtitleMenu項目と一緒にヘッダーを表示します。
        Mac Catalystでは、titleMenuProviderに渡される項目はすでにFileメニューに存在しています。
         タイトルメニューに追加する項目は、他の手段で利用可能にする必要があります。
        UIMenuBuilder APIを使用してこれらのアイテムを追加したり、必要に応じて既存のアイテムをフィルタリングしたりすることができる。
        ドキュメントのプロパティを指定した場合、UIKit は自動的に提供された URL を使用して macOS プロキシアイコンを管理します。
        windowSceneのrepresentedURLを手動で設定した場合は、それがUIKitの管理より優先されます。
        UIKitはRenameを有効にするために2つのメカニズムを提供しています。
         インラインRenameは、UINavigationItem.RenameDelegateを設定することで提供されます。
        renameDelegateを設定することで提供され、すべてのプラットフォームでタイトルを編集するための専用のUIが提供されます。
        完了すると、結果の名前は、デリゲートに渡されます。
        また、UIResponder.rename(_:)を実装することで、名前の変更を完全に制御することができます。
        rename(_:) を実装し、好みの UI を提供することで、名前の変更を完全に制御することもできます。
        iOSでは、UINavigationBarはタイトルビュー内で直接リネームUIを提供します。
         macOS では、ナビゲーションバーが NSToolbar でホストされている場合、rename UI はウィンドウのタイトルで提供されます。
        インラインの名前を変更するには、UINavigationItemRenameDelegateプロトコルに準拠し、ナビゲーションアイテムのrenameDelegateを設定します。
         必須メソッドは1つだけで、 navigationItem(_:didEndRenamingWith:) は、ユーザーによって受け入れられたタイトルを受け取るために使用されます。
        ファイルベースのアプリの場合、UIDocumentBrowserViewControllerがリネームAPIを提供するようになった。
        検索は多くのユーザーが最も重要なデータを見つける方法ですが、iOS 16の進歩により、優れた検索エクスペリエンスを提供することが容易になりました。
         まず注目すべきは、検索がiPadOSではナビゲーションバーに、macOSではツールバーに並ぶことで、より少ないスペースを占めるようになったことです。
         iPadOSでは、UINavigationItem .PreferredSearchBarPlacementで以前の挙動に戻すことができます。
        preferredSearchBarPlacementで以前の動作を復元できます。
         さらに、検索バーをボタンに折りたたんで、他のコントロールのためのスペースを確保することもできます。
         検索を有効にすると、検索候補が表示され、更新中の検索クエリと一緒に更新することができるので、ユーザーの検索を支援する機会が得られます。
         次に、検索サジェストを設定するために必要なコードを説明します。
        検索サジェストを管理するには、UISearchResultsUpdatingに準拠し、searchControllerのsearchResultsUpdaterを設定します。
         これにより、クエリの変更に応じてサジェストを更新したり、選択された検索サジェストに対してアクションを起こしたりすることができるようになります。
        クエリが変更されると updateSearchResults(for:) が呼び出され、検索サジェストを更新できるようになります。
        どのようなサジェストを提供するかは、あなた次第です。
         空の配列を設定すると、サジェストUIがクリアされます。
        UIKitでは、サジェスト内容を指定するためにUISearchSuggestionItemを用意しています。
        サジェストの選択に応答するには、updateSearchResults(for:selecting:)を実装します。
         このメソッドは選択された検索サジェストを渡すので、それに対して適切に反応することができます。
         この例では、現在のクエリを検索サジェストで指定されたクエリに置き換えて、検索を更新しています。
         UISearchTextFieldにもsearchSuggestionsがあるので、そのクラスを単独で使用したい場合でも、検索サジェストを実装することは可能です。
         しかし、UISearchControllerを使用している場合は、代わりにそのプロパティを使用する必要があります。
        iOS 16では、UIKitが新しいAPIを提供し、ユーザーにさらなる生産性を提供することを支援します。
         センターアイテムやタイトルメニューによって、高度な機能をより発見しやすくすることができます。
        ナビゲーションバーから直接ドラッグ＆ドロップや共有ができるようになり、ドキュメントのサポートが向上します。
        検索候補を表示して検索をより簡単かつ迅速にし、ほとんど労力をかけずに、箱から出してすぐに素晴らしい Mac エクスペリエンスを実現できます。
         このビデオをご覧いただき、ありがとうございました。
         あなたのアプリケーションをデスクトップクラスに強化する方法を見るのが楽しみです。

        """
    }
}

