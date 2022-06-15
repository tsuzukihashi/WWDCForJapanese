import Foundation

struct WhatsNewInAppKit: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "What's new in AppKit"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6568/6568_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10074/")!
    }

    var english: String {
        """
        Jeff Nadeau: Hello, and welcome to What's new in AppKit.
         I'm Jeff Nadeau, an engineer on the AppKit team, and I'm here to share the latest and greatest in building apps for macOS Ventura.
         It's never been a more exciting time for the Mac, between the performance and efficiency of Apple Silicon, the power of macOS, and an app ecosystem that's richer than ever.
         Your apps are an important part of that story, and we're continuing to push AppKit forward so that you can keep building the very best apps.
        I'll be covering a wide variety of topics, starting with Stage Manager, moving on to Preferences, followed by controls, SF Symbols, and sharing.
         I'll start off with Stage Manager.
        Stage Manager cleans up inactive windows in your workspace while your active window takes center stage.
         For a more advanced workflow, you can also pull windows together into sets which swap in and out as a group.
        This has an impact on how your app windows present themselves.
         Stage Manager is trying to keep the working space tidy, so when a new window is presented, existing windows will exit the stage to make room.
         That's what you want for "primary" windows, like your documents.
         Auxiliary windows like panels, popovers, settings, and others should continue to appear above the existing windows.
         NSWindow already has a lot of APIs that can help you define the behavior you'd like for a particular window.
        By default, Stage Manager won't swap out other windows if you present a floating panel, a modal window, or a window with a preference-style toolbar.
        Stage Manager also respects your window's collectionBehavior.
         This OptionSet defines how your window behaves in spaces and full screen, and it now also helps Stage Manager understand that a window is considered to be auxiliary or floating.
        If a window's collectionBehavior includes the auxiliary, moveToActiveSpace, stationary, or transient options, then it won't displace the active window in center stage.
        By setting up your windows with the right collection behaviors, you can make sure that they work great in every context, whether it's a desktop space, full screen, or now in Stage Manager.
         Next, I'd like to cover some important changes to Preferences.
         In macOS Ventura, the System Preferences app has taken on a whole new look, with a refreshed navigation scheme and all-new visual design.
         To align with the settings experience on our other operating systems, we've also renamed the app to System Settings.
        These changes extend to your application too.
         For example, you might have a preference pane bundle that appears in the System Preferences app today.
         You might also have a settings area inside of your app.
         There's also a new design system for control-rich forms that may be the perfect fit for settings interfaces or inspectors.
         If you ship a custom prefpane bundle, it'll continue to work with the new Settings app.
         Your custom pane will appear in the sidebar, and the app will load up your bundle and present your settings UI just like it did in Monterey and earlier.
        To match the newly-renamed System Settings app, we've renamed in-app preferences to "settings" as well.
         To help get you started, once you build against the newest SDK, AppKit will automatically update the name of the "Preferences," menu item in your app menu.
         However, you might be using the word "Preferences" in a number of other places, like window titles, descriptive labels, or other controls around your app.
         Search through your localized text to find places that also need updating.
        For example, TextEdit's settings window used to be called "preferences" and we chose to rename that window to Settings to match the rest of the system.
         The System Settings app also uses a new interface style for presenting all of its configuration options.
         Settings interfaces are often control-heavy, so this style is designed to present forms containing many controls in a clear and well-organized fashion.
        Since the form itself provides a lot of visual structure, many system controls adapt to this context by drawing with a lower visual weight, while revealing more prominent control backings on rollover.
        If you want to write interfaces that use this new design, SwiftUI makes it super easy.
         Place your controls into a Form view, and then apply the "insetGrouped" form style.
         SwiftUI takes care of the rest: the visual style, scrolling behavior, and layout of the form are all applied automatically.
        If you haven't gotten started with SwiftUI yet, this is a great opportunity to give it a try.
         A Settings window is often a standalone area of your app's interface, so it's the perfect place to do some incremental adoption.
        We've even created a video about using SwiftUI and AppKit together, which is a great place to learn more.
         Next, I'd like to share some updates to our controls.
         We've got a lot of exciting control enhancements to share, starting with a new control called NSComboButton.
         We've also updated NSColorWell, made some enhancements to the NSToolbar API, adjusted the design of NSAlert, and improved the performance of NSTableView.
         First, NSComboButton.
         NSComboButton is all about combining an immediate button action, and a menu for additional options.
        In today's control landscape, you'd traditionally use a button to perform some immediate action, or you would use a pull-down button to show a menu with many options.
         NSComboButton combines both elements into a single control, which joins a primary action and a pull-down menu together.
         This design is commonly used for use cases like this one in Mail, where the predicted folder is a single click away, but you can still access a menu to file your messages anywhere.
         Previously, you might've assembled something like this using the segmented control API, but now there's a dedicated control for it.
        NSComboButton comes in two styles, which dictate both the appearance and the behavior of the button.
         The default style is called "split," and it includes a separate arrow portion just for the menu.
        The second style, "unified," looks much more like an ordinary button.
         This style performs its primary action on click, and it presents its menu if you click-and-hold.
         And that's NSComboButton.
         We've also got some great new updates to NSColorWell, starting with a brand-new look.
         In place of the classic square gradient appearance, the color well has adopted a new style reminiscent of other button bezels across the system.
         This change is completely automatic, so you don't need to do any adoption to get this modern appearance.
        However, we know that color picking is an important part of creative and professional applications, so we've gone a step further and introduced two new styles for NSColorWell.
        The first is a minimal style, which shows a disclosure arrow on rollover, and provides a quick color picking experience by showing a popover to immediately select from a palette of colors, with the option to break out into the full NSColorPanel.
         By default, it uses a system standard grid of colors, but you can customize what appears here if you've got a different UI or palette in mind.
        The second is an expanded style, which you might recognize from the iWork apps.
         This style combines both interaction models: the well on the left has the same disclosure arrow and popover for quick picking, while the button on the right pulls up the full panel for more detailed color picking.
        And with that, NSColorWell now offers three different ways to pick colors.
        You can access these styles using the new colorWellStyle property on NSColorWell, which has cases for each style: default, expanded, and minimal.
        NSColorWell has also gained a new target-and-action pair for its "pulldown action.
        " This action determines what happens when you click the pulldown portion of a minimal or expanded color well.
         By default, these properties are nil, which signifies that NSColorWell should use the system-standard popover.
         However, you can customize this action and use it to present your own custom popover, Or you could even present a different picking interface, like a menu.
         And that's the new NSColorWell.
         It's got a brand new look and two new ways to quickly pick colors.
        Next up, some news on NSToolbar, where we've made a variety of API enhancements to give you better control over customization and increased flexibility for your layout.
        On the customization front, we've added two new delegate methods to give you better control over the customizability of your toolbar.
         The first is "toolbarImmovableItemIdentifiers".
         If you implement this method to return a set of item identifiers, those items won't be movable or removable by the user, and they won't animate when you enter customization mode.
        For example, the Mail app wants the Filter button to always appear here, above the message list.
         Using this API, they can prevent it from being moved away from this spot.
        The second method is called "toolbar itemIdentifier canBeInsertedAt.
        " This delegate method gives you veto power over any particular reordering, insertion, or removal from the toolbar.
         You can use it to implement your own set of customization rules – for example, you could create a toolbar item that's allowed within one section of the toolbar, but it's disallowed within another section.
        You can now specify multiple centered items for your toolbar using the new centeredItemIdentifiers property.
         If your toolbar is customizable, items in this set can still be added or removed from the toolbar, but they can only be reordered within the centered group.
         In this example, the photo editing tools all stick together in the center of the toolbar regardless of how many items are placed in the leading and trailing sections.
        Once your toolbar is customized the way you like it, you don't want the items to shift around, and that can be difficult for toolbar items that change meaning based on some other state, like the Mute and Unmute button in Mail, which toggles when you click it.
        Since the labels have different sizes, the other items in the toolbar have to shift around to accommodate the change.
        In a scenario like this, you can use the new possibleLabels property on NSToolbarItem to provide a set of the localized strings that you'll use for the item.
        NSToolbar will automatically size the item to fit the longest label, so your layout stays the same even when the item is reconfigured.
         Next, a design update for alerts.
         Alerts on macOS use a compact layout, which is optimized for a small amount of text accompanied by a few clear choices.
         And in general, that's a great way to put together an alert.
         Alerts work best with shorter text: you can communicate your message more directly, and people are more likely to read what you've written before pushing their way through the alert.
        However, sometimes you really can't shorten your description, especially if you need to communicate something complex and subtle, like this Disk Utility alert, which conveys a really important choice about your filesystem data.
         The compact layout just isn't optimal for this situation.
         For these cases, we've adapted NSAlert to provide a wider layout that's suitable for longer text.
         This adaptation happens automatically for alerts where the informative text is too long to fit comfortably in the compact size.
         We'll also use this style if you have an accessory view that's too large to fit in a compact alert window.
         There's no need for your app to opt in to this behavior – it's applied automatically system-wide.
         It's important to note that the layout is determined at the time you present the alert, so an alert won't swap styles if you modify it while it's already on screen.
        You should still aim to reduce the length of your alert text wherever possible, but this design update will improve the user experience for those cases where you can't.
        Next, an important new feature of NSTableView.
         NSTableView is designed to efficiently handle a very large number of rows, by lazily populating and reusing the views as you scroll.
        However, for tables where each row can have a different height, that can be a challenge, because in order to provide a good scrolling experience the table needs to know its total height and the location of each row in the scrolling region.
        Historically, NSTableView does this by sizing all of the rows in the table, which can have an impact on initial load times.
         In macOS Ventura, NSTableView achieves those goals while providing much better performance.
        Instead of eagerly calculating the height for each row, NSTableView now lazily calculates row heights based on which rows are within or near the scrolling viewport.
        For the rows that haven't been measured yet, NSTableView uses a running estimated height based on the row heights that it's already measured.
         As you scroll through the table, NSTableView requests row heights as needed, replacing the estimated heights with real measurements, while taking care to maintain the correct scrolling position.
        This optimization significantly improves the load times for very large tables.
         The change does alter the timing of delegate calls like "table view: height of row", so you shouldn't make assumptions about when NSTableView will request row heights from you.
        This optimization applies to both NSTableView and SwiftUI's List view, and it's automatically used for all apps on macOS Ventura with no adoption required.
         And that's NSTableView performance.
        Next, some updates on SF Symbols.
         macOS Ventura includes SF Symbols 4, which adds more than 450 new symbol images covering all kinds of subjects.
        These new symbols include laurels, all kinds of household objects, currency symbols from around the world, and even a variety of sports-related symbols.
         With a catalog of thousands of symbols, it's likely that SF Symbols includes a professionally-designed icon for any idea that you want to represent.
         But we haven't stopped there.
         SF Symbols 4 also includes some new features to further enhance your iconography.
        To recap, symbol images support a number of rendering modes that you can choose from depending on your design.
         There's monochrome, which uses a single color; hierarchical, which uses different opacities of a color to emphasize certain portions of a symbol; palette, which allows you to specify distinct colors for each part of a symbol; and multicolor, which uses colors designed directly into the symbol artwork.
        These choices give you the flexibility to realize a wide variety of designs, but we also want symbol images to look their best right out of the box, without the need to apply any configuration.
        That's why we've introduced a new feature to symbols in macOS Ventura: preferred rendering mode.
         With preferred rendering mode, symbols can specify the style of rendering that they prefer, and at runtime AppKit will use that style automatically.
         This is great for symbols like AirPods Pro, which prefers a hierarchical style to increase the clarity of those fine details.
         Of course, if you have a different design in mind, you can always use an NSImageSymbolConfiguration object to choose your preferred style.
        Some symbols don't just represent a concept, they're also meant to communicate some value or quantity, like your Wi-Fi signal strength, or audio volume.
         For cases like these, we've introduced a new type of symbol that we call a "variable symbol.
        " With a variable symbol, you supply a floating point value directly to NSImage, and the symbol embeds numeric thresholds to decide how each path should vary based on that value.
         Here's the API.
         Variable symbols are created using a new initializer.
         It's similar to the existing symbol image initializer, with the addition of a value parameter, which is a floating point number between zero and one.
         If the symbol image doesn't define any variable thresholds, this value is ignored and the symbol draws as it normally would.
         If it does, you'll see the symbol paths drawing differently based on the value you supplied.
        Each variable symbol can represent a value in its own unique way, and by providing that value at the API level, you get access to all of those variations without having to know the fine details of how the symbol is composed.
        Variable symbols work great in combination with rendering styles like palette color and multicolor, so you can adapt them to almost any design.
         Finally, I'd like to cover some big updates to Sharing macOS Ventura elevates the sharing experience on the Mac, introducing features like suggested people and new ways to invite and manage the people that you're collaborating with.
         There are some new APIs that you can adopt so that your app gets the most out of these enhancements.
        The most prominent update to the sharing experience is the new sharing popover.
         This replaces the existing share menu with a rich interface that includes more information about the document you're sharing and familiar features like suggested people.
         It supports all of the same APIs and delegate methods as the previous picker, so you can still do things like filter the list of sharing services, or insert your own custom services into the picker.
        If you're sharing a file URL, NSSharingServicePicker can automatically populate the header with an icon, name, and other metadata about the file.
         But if you're sharing a custom type instead, you can conform your items to a new protocol that NSSharingServicePicker will use to request that information.
        The protocol is called NSPreviewRepresentableActivityItem.
         Conforming types must be able to return the underlying item to share, like an NSItemProvider, and they can optionally return a title, an image provider, and an icon provider.
        For convenience, there's a conforming class in AppKit called NSPreviewRepresentingActivityItem which you can use to bundle up an existing sharing item with its metadata.
         You can provide each image parameter directly as an NSImage, or you can use NSItemProvider if it's too performance-intensive to generate those images up front.
        The new sharing picker is great for kicking off sharing from somewhere like a toolbar button, but sometimes you want to start sharing from a menu, like the main menu bar or the context menu for a selected view inside your app.
         Previously, you might've constructed your own menu to handle this, by enumerating sharing services and then building menu items for each one.
         Although that does work, it bypasses the standard picker, so now you're missing out on all of those new features.
         In macOS Ventura, NSSharingServicePicker can create a "standardShareMenuItem" for you.
         You can add the standard item to any menu to easily kick off sharing.
         Once selected, the menu item summons the sharing popover, and for context menus, it'll even anchor the popover to the same view that produced the menu.
        There's a lot of new support for managing collaboration in macOS Ventura.
        With some extra adoption, your shareable items can also become invitations to collaborate, which users can initiate via the sharing picker, drag-and-drop into Messages, or even via FaceTime.
         You can share content using CloudKit or iCloud Drive, or you can connect the invitation flow with your own collaboration server.
         Now this is a really big topic, so we've made a few videos to explain it in much greater depth.
         They're a must-see if your app supports collaboration, or if you'd like to get started with adding it.
         As you get started with macOS Ventura, make sure you're setting up your windows to work best with Stage Manager.
         Then, consider how your design might benefit from control enhancements like NSComboButton and NSColorWell.
         Improve your iconography using the newest symbols and features of SF Symbols.
         And finally, for collaboration, adopt the latest APIs so that you get the most out of macOS Ventura's new sharing experience.
        Thanks so much for watching, and thanks for continuing to build great Mac applications.

        """
    }

    var japanese: String {
        """
        Jeff Nadeau: こんにちは、What's new in AppKitへようこそ。
         AppKitチームのエンジニア、ジェフ・ナドーです。今回は、macOS Ventura向けのアプリケーション構築に関する最新情報をお届けします。
         Apple Siliconのパフォーマンスと効率性、macOSのパワー、そしてかつてないほど豊かなアプリケーションのエコシステムなど、Macにとってこれ以上ないほどエキサイティングな時代です。
         そして、あなたが最高のアプリケーションを作り続けられるように、私たちはAppKitを進化させ続けています。
        今回は、Stage Managerから始まり、Preferences、Controls、SF Symbols、Sharingと、様々なトピックを取り上げていきたいと思います。
         まず、Stage Managerから説明します。
        Stage Managerは、ワークスペース内の非アクティブなウィンドウをクリーンアップし、アクティブなウィンドウを主役にします。
         さらに高度なワークフローを実現するために、ウィンドウをグループとしてスワップイン・アウトできるセットにまとめることもできます。
        これは、アプリのウィンドウの表示方法にも影響します。
         Stage Managerは、作業空間を整頓しようとします。そのため、新しいウィンドウが表示されると、既存のウィンドウはステージから退出してスペースを確保します。
         これは、ドキュメントのような「主要な」ウィンドウに必要なことです。
         パネル、ポップオーバー、設定などの補助的なウィンドウは、既存のウィンドウの上に表示し続ける必要があります。
         NSWindow には、特定のウィンドウに必要な動作を定義するのに役立つ API がたくさん用意されています。
        デフォルトでは、フローティングパネル、モーダルウィンドウ、プリファレンススタイルのツールバーを持つウィンドウを表示しても、Stage Manager は他のウィンドウと入れ替わることはありません。
        また、Stage Manager は、ウィンドウの collectionBehavior を尊重します。
         この OptionSet は、スペースとフルスクリーンでのウィンドウの動作を定義し、さらに、ウィンドウが補助またはフローティングと見なされることを Stage Manager が理解できるようにします。
        ウィンドウの collectionBehavior に auxiliary、moveToActiveSpace、stationary、transient のオプションが含まれていると、センターステージのアクティブウィンドウをずらすことはありません。
        ウィンドウに適切なコレクションビヘイビアを設定することで、デスクトップスペース、フルスクリーン、そしてステージマネージャーなど、あらゆる状況でウィンドウがうまく動作するようになります。
         次に、「環境設定」の重要な変更点について説明します。
         macOS Venturaでは、システム環境設定アプリがまったく新しい外観になり、ナビゲーションスキームも一新され、ビジュアルデザインもまったく新しいものになりました。
         他のオペレーティングシステムでの設定と同じように、アプリの名前も「システム設定」に変更しました。
        この変更は、あなたのアプリケーションにも適用されます。
         例えば、今日、システム環境設定アプリケーションに表示される環境設定ペインバンドルがあるかもしれません。
         また、アプリの中に設定エリアがある場合もあります。
         また、コントロールリッチなフォームのための新しいデザインシステムもあり、設定インターフェイスやインスペクタに最適かもしれません。
         カスタムプレフェインバンドルを出荷している場合、新しい設定アプリでも引き続き動作します。
         カスタムペインはサイドバーに表示され、アプリはバンドルを読み込んで、Monterey およびそれ以前のバージョンと同様に設定 UI を表示します。
        新しくなったシステム設定アプリに合わせて、アプリ内の環境設定も「設定」に改名されました。
         最新の SDK に基づいてビルドすると、AppKit は自動的にアプリメニューの「Preferences」メニュー項目の名前を更新します。
         しかし、ウィンドウのタイトルや説明ラベル、アプリのコントロールなど、他の多くの場所で「Preferences」という単語を使用している可能性があります。
         ローカライズされたテキストを検索して、更新が必要な箇所を見つけます。
        例えば、TextEditの設定ウィンドウは以前は「プリファレンス」と呼ばれていましたが、システムの他の部分と一致させるために「設定」に改名することを選択しました。
         また、システム設定アプリでは、すべての設定オプションを表示するために新しいインターフェーススタイルを採用しています。
         設定」インターフェイスは、コントロールが多いため、このスタイルでは、多くのコントロールを含むフォームを明確かつ適切に整理して表示するように設計されています。
        フォーム自体が多くの視覚的構造を提供するため、多くのシステムコントロールはこのコンテキストに適応し、視覚的な重みを抑えて描画し、ロールオーバー時にはより目立つコントロールバックを表示します。
        この新しいデザインを使用するインターフェイスを書きたい場合、SwiftUIはとても簡単です。
         コントロールをフォームビューに配置し、「insetGrouped」フォームスタイルを適用します。
         ビジュアルスタイル、スクロールの動作、フォームのレイアウトはすべて自動的に適用されます。
        まだSwiftUIを使い始めていないのであれば、試してみる絶好の機会です。
         設定ウィンドウは、しばしばアプリのインターフェイスの独立した領域なので、段階的な採用を行うには完璧な場所です。
        SwiftUIとAppKitを一緒に使うことについてのビデオも作成しましたので、ぜひご覧ください。
         次に、コントロールのアップデートを紹介したいと思います。
        NSComboButton という新しいコントロールを始めとして、たくさんのエキサイティングなコントロールの拡張をご紹介します。
        また、NSColorWell の更新、NSToolbar API の強化、NSAlert のデザインの調整、NSTableView のパフォーマンスの改善も行っています。
        まず、NSComboButton です。
        NSComboButton は、即時のボタン操作と、追加オプションのためのメニューの組み合わせがすべてです。
        今日のコントロール環境では、従来は、ボタンを使って即座に何らかのアクションを実行するか、プルダウンボタンを使って多くのオプションを持つメニューを表示することになります。
        NSComboButtonは、この2つの要素を1つのコントロールに統合し、主要なアクションとプルダウンメニューを一緒にしている。
        このデザインは、このようなメールでのユースケースによく使われます。予測されるフォルダはワンクリックで移動しますが、メニューにアクセスすることでどこでもメッセージをファイリングできるのです。
        以前は、セグメントコントロールAPIを使ってこのようなものを組み立てていたかもしれないが、今は専用のコントロールがある。
        NSComboButtonには、2つのスタイルがあり、ボタンの外観と動作を決定する。
        デフォルトのスタイルは「split」と呼ばれるもので、メニュー用に独立した矢印の部分がある。
        2つ目のスタイルである「unified」は、より普通のボタンに近い見た目をしている。
        このスタイルでは、クリックすると主要な動作が行われ、クリックしたままにしておくとメニューが表示される。
        これがNSComboButtonだ。
        また、NSColorWellの外観も新しくなりました。
        従来の四角いグラデーションの外観に代わり、システム全体の他のボタンベゼルを思わせる新しいスタイルが採用されています。
        この変更は完全に自動で行われるため、このモダンな外観を得るために特別な操作をする必要はありません。
        しかし、カラーピッキングはクリエイティブでプロフェッショナルなアプリケーションの重要な部分であることを理解しているため、さらに一歩進んで、NSColorWellに2つの新しいスタイルを導入しました。
        1つ目は最小限のスタイルで、ロールオーバー時に開示矢印を表示し、色のパレットからすぐに選択できるポップオーバーを表示することで、迅速なカラーピッキング体験を提供し、フルNSColorPanelに抜け出すためのオプションも用意されています。
        デフォルトでは、システム標準のカラーグリッドが使用されますが、別のUIやパレットを考えている場合は、ここに表示されるものをカスタマイズすることができます。
        2つ目は、iWorkアプリでおなじみの拡張スタイルです。
        このスタイルでは、両方のインタラクションモデルを組み合わせています。左側のウェルには、クイックピッキングのための同じ開示矢印とポップオーバーがあり、右側のボタンはより詳細なカラーピッキングのためのフルパネルをプルアップしています。
        これにより、NSColorWellは3つの異なる方法で色を選択できるようになりました。
        これらのスタイルには、NSColorWellの新しいcolorWellStyleプロパティを使用してアクセスでき、各スタイルには、デフォルト、拡張、および最小というケースがあります。
        NSColorWell はまた、「プルダウン操作」のために新しいターゲットとアクションのペアを獲得しました。
        " このアクションは、最小または拡張カラーウェルのプルダウン部分をクリックしたときに何が起こるかを決定します。
        デフォルトでは、これらのプロパティはnilであり、これはNSColorWellがシステム標準のポップオーバーを使用することを意味します。
        しかし、このアクションをカスタマイズして、独自のポップオーバーを表示したり、メニューのような別のピッキングインターフェースを表示したりするために使用することができます。
        そして、これが新しいNSColorWellです。
        新しい外観と、すばやく色を選ぶための2つの新しい方法を備えています。
        次に、NSToolbarに関するいくつかのニュースです。カスタマイズをよりよく制御し、レイアウトの柔軟性を高めるために、APIがさまざまに強化されました。
        カスタマイズの面では、ツールバーのカスタマイズ性をよりよく制御できるように、2つの新しいデリゲートメソッドを追加しました。
        1つ目は、「toolbarImmovableItemIdentifiers」です。
        このメソッドを実装してアイテム識別子のセットを返すと、それらのアイテムはユーザーによって移動または取り外しができなくなり、カスタマイズ・モードに入ったときにアニメーションもしなくなります。
        例えば、メールアプリでは、フィルタボタンを常にメッセージリストの上のここに表示させたいとします。
        このAPIを使えば、この場所から移動させないようにすることができます。
        2つ目のメソッドは、"toolbar itemIdentifier canBeInsertedAt. "と呼ばれます。
        " このデリゲートメソッドは、ツールバーの特定の順序変更、挿入、削除に対する拒否権を与える。
        例えば、ツールバーのあるセクション内では許可されるが、別のセクション内では禁止されるツールバーアイテムを作成することができます。
        新しい centeredItemIdentifiers プロパティを使用して、ツールバーの中央に配置される複数のアイテムを指定できるようになりました。
         ツールバーをカスタマイズできる場合、このセットのアイテムはツールバーから追加または削除することはできますが、中央のグループ内でのみ並び替えが可能です。
         この例では、写真編集ツールは、先頭と末尾のセクションにいくつアイテムを配置しても、すべてツールバーの中央にまとまって配置されます。
        ツールバーを自分好みにカスタマイズした後、アイテムが移動するのは困りものですが、メールの「ミュート」と「ミュート解除」ボタンのように、他の状態によって意味が変わるツールバーのアイテムは、クリックすると切り替わるので難しい場合があります。
        ラベルのサイズが異なるため、ツールバーの他のアイテムもその変更に対応するために移動する必要があります。
        このようなシナリオでは、NSToolbarItem の新しい possibleLabels プロパティを使用して、アイテムに使用するローカライズされた文字列のセットを提供することができます。
        NSToolbarは、自動的に最も長いラベルに合うようにアイテムのサイズを調整するので、アイテムが再構成された場合でもレイアウトは同じままです。
         次に、アラートのデザインアップデートです。
         macOSのアラートはコンパクトなレイアウトを採用しており、少量のテキストにいくつかの明確な選択肢を伴うように最適化されています。
         そして一般的に、これはアラートを構成するのに最適な方法です。
         メッセージをより直接的に伝えることができ、人々はアラートを読み進める前にあなたの書いた文章を読む可能性が高くなります。
        しかし、特にこのディスクユーティリティのアラートのように、ファイルシステムのデータに関する非常に重要な選択を伝えるような複雑で微妙なことを伝える必要がある場合、どうしても説明を短くすることができないことがあります。
         このような状況では、コンパクトなレイアウトは最適とは言えません。
         このような場合、長いテキストに適した広いレイアウトを提供するために、NSAlertを適応させました。
         この適応は、情報テキストが長すぎてコンパクトなサイズに快適に収まらないアラートに対して自動的に行われます。
         また、アクセサリ表示が大きすぎてコンパクトなアラートウィンドウに収まらない場合にも、このスタイルが使用されます。
         この動作は、システム全体に自動的に適用されるため、アプリ側で選択する必要はありません。
         重要なのは、レイアウトは警告を表示するときに決定されるため、警告がすでに画面に表示されているときにそれを変更しても、スタイルが切り替わることはない点です。
        可能な限りアラートテキストの長さを短くすることを目指すべきですが、このデザインアップデートにより、そうできない場合のユーザーエクスペリエンスを向上させることができます。
        次に、NSTableViewの重要な新機能を紹介します。
         NSTableView は、非常に多くの行を効率的に処理するように設計されており、スクロールするとビューが遅延的に入力され、再利用されます。
        しかし、各行が異なる高さを持つことができるテーブルでは、良いスクロール体験を提供するために、テーブルがその総高さとスクロール領域内の各行の位置を知る必要があるため、それは挑戦となりえます。
        歴史的に、NSTableViewは、テーブルのすべての行のサイズを調整することによってこれを行い、初期のロード時間に影響を与える可能性があります。
         macOS Venturaでは、NSTableViewはこれらの目標を達成すると同時に、より優れたパフォーマンスを提供します。
        各行の高さを熱心に計算する代わりに、NSTableView は、スクロールするビューポート内またはその近くにある行に基づいて、行の高さを遅延的に計算するようになりました。
        まだ測定されていない行については、NSTableView は、すでに測定された行の高さに基づいて、実行中の推定高さを使用します。
         テーブルをスクロールすると、NSTableViewは必要に応じて行の高さを要求し、正しいスクロール位置を維持しながら、推定高さを実測値に置き換えます。
        この最適化により、非常に大きなテーブルのロード時間が大幅に改善されます。
         この変更により、"table view: height of row "のようなデリゲートコールのタイミングが変更されるため、NSTableViewが行の高さを要求するタイミングについて仮定するべきではありません。
        この最適化は NSTableView と SwiftUI の List view の両方に適用され、macOS Ventura のすべてのアプリで自動的に使用され、採用の必要はありません。
         そして、これがNSTableViewのパフォーマンスです。
        次に、SF Symbolsのアップデートについて。
         macOS VenturaにはSF Symbols 4が搭載されており、あらゆるテーマをカバーする450以上の新しいシンボル画像が追加されています。
        この新しいシンボルには、月桂樹、あらゆる種類の家庭用品、世界中の通貨記号、そしてスポーツ関連のさまざまなシンボルが含まれています。
         SF Symbolsには、あなたが表現したいあらゆるアイデアに対応する、プロがデザインしたアイコンが含まれています。
         しかし、私たちはそれだけにとどまりません。
         SF Symbols 4には、あなたのアイコンをさらに充実させるための新機能がいくつかあります。
        シンボル画像はいくつかのレンダリングモードをサポートしており、デザインに応じて選択することができます。
         単色を使用するモノクロ、色の不透明度を変えてシンボルの特定の部分を強調するヒエラルキー、シンボルの各部分に個別の色を指定できるパレット、シンボルアートワークに直接デザインした色を使用するマルチカラーがあります。
        これらの選択により、さまざまなデザインを実現することができます。しかし、シンボル画像は、何も設定することなく、箱から出してすぐに最高の状態で使えることが望まれます。
        macOS Venturaのシンボルに新しい機能、優先レンダリングモードを導入したのは、そのためです。
         優先レンダリングモードでは、シンボルが好みのレンダリングスタイルを指定すると、ランタイム時にAppKitが自動的にそのスタイルを使用します。
         これはAirPods Proのように、細かいディテールをより鮮明にするために階層的なスタイルを好むシンボルにとって、とても便利な機能です。
         もちろん、別のデザインを考えている場合は、NSImageSymbolConfigurationオブジェクトを使用して、いつでも好みのスタイルを選択することができます。
        シンボルの中には、単に概念を表すだけでなく、Wi-Fiの信号強度やオーディオの音量など、何らかの値や量を伝えることを意図しているものもあります。
         このような場合のために、新しいタイプのシンボルを導入し、「変数シンボル」と呼んでいます。
        " 可変シンボルでは、浮動小数点数の値を直接NSImageに与え、その値に基づいて各パスがどのように変化すべきかを決める数値の閾値をシンボルに埋め込んでいます。
         以下はそのAPIです。
         変数シンボルは、新しいイニシャライザーを使って作成されます。
         これは既存のシンボルイメージのイニシャライザーに似ていますが、0から1の間の浮動小数点数である値パラメーターが追加されています。
         シンボルイメージに可変スレッショルドが定義されていない場合、この値は無視され、シンボルは通常と同じように描画されます。
         もしそうであれば、シンボルパスはあなたが与えた値に基づいて異なる方法で描画されるのがわかります。
        各可変シンボルはそれ自身のユニークな方法で値を表すことができ、APIレベルでその値を提供することによって、シンボルがどのように構成されるかの細かい詳細を知ることなく、それらのすべてのバリエーションにアクセスすることができます。
        変数シンボルは、パレットカラーやマルチカラーなどのレンダリングスタイルと組み合わせて使うことができるので、ほとんどのデザインに適応させることができる。
         最後に、MacOS Venturaの共有機能の大きなアップデートを紹介します。
         新しいAPIもいくつか用意されているので、あなたのアプリケーションがこれらの機能拡張を最大限に活用できるようになります。
        共有エクスペリエンスに対する最も顕著なアップデートは、新しい共有ポップオーバーです。
         これは、既存の共有メニューに代わるもので、共有する文書に関するより多くの情報や、提案された人々などのおなじみの機能を含むリッチなインターフェイスを備えています。
         以前のピッカーと同じ API とデリゲートメソッドをすべてサポートしているので、共有サービスのリストをフィルタリングしたり、独自のカスタムサービスをピッカーに挿入したりすることができます。
        ファイル URL を共有している場合、NSSharingServicePicker は、ファイルに関するアイコン、名前、その他のメタデータを自動的にヘッダに入力できます。
         しかし、カスタムタイプを共有する場合、NSSharingServicePickerが情報を要求するために使用する新しいプロトコルにアイテムを適合させることができます。
        このプロトコルは、NSPreviewRepresentableActivityItem と呼ばれます。
         適合するタイプは、NSItemProvider のように、共有する基本アイテムを返すことができなければならず、オプションでタイトル、画像プロバイダ、およびアイコンプロバイダを返すことができます。
        便宜上、AppKit には NSPreviewRepresentingActivityItem という適合クラスがあり、既存の共有アイテムとそのメタデータをバンドルするために使用することができます。
         各画像パラメータを NSImage として直接提供することもできますし、これらの画像を前もって生成するのがパフォーマンス的に難しい場合は、NSItemProvider を使用することもできます。
        新しい共有ピッカーは、ツールバーボタンのような場所から共有を開始するには最適ですが、メインメニューバーやアプリ内の選択したビューのコンテキストメニューのようなメニューから共有を開始したい場合もあります。
         以前は、共有サービスを列挙し、それぞれのメニュー項目を作成することで、独自のメニューを作成して対応していたかもしれません。
         しかし、これでは標準のピッカーが使えないので、せっかくの新機能が台無しです。
         macOS Venturaでは、NSSharingServicePickerが "standardShareMenuItem "を作成することができます。
         この標準アイテムを任意のメニューに追加することで、簡単に共有を開始することができます。
         メニュー項目が選択されると、共有ポップオーバーが呼び出され、コンテキストメニューの場合は、ポップオーバーがメニューを表示しているのと同じビューに固定されるようにもなっています。
        macOS Venturaには、コラボレーションを管理するための新しいサポートがたくさんあります。
        この招待状は、共有ピッカー、メッセージへのドラッグ＆ドロップ、FaceTime経由で送信することもできます。
         CloudKitやiCloud Driveを使ってコンテンツを共有したり、招待状のフローを独自のコラボレーションサーバーに接続したりすることができます。
         このトピックは非常に大きなテーマなので、より深く説明するためにいくつかのビデオを作成しました。
         あなたのアプリケーションがコラボレーションをサポートしている場合、またはコラボレーションを追加するために始めたい場合、これらは必見です。
         macOS Venturaを使い始めたら、Stage Managerで最適に動作するようにウィンドウをセットアップしてください。
         次に、NSComboButtonやNSColorWellなどのコントロール機能の強化が、あなたのデザインにどのようなメリットをもたらすかを考えてみてください。
         SF Symbolsの最新のシンボルや機能を使って、アイコンをより良くしましょう。
         そして最後に、macOS Venturaの新しい共有体験を最大限に活用するために、最新のAPIを採用してコラボレーションを実現しましょう。
        そして、これからも素晴らしいMacアプリケーションを作り続けてください。

        """
    }
}

