import Foundation

struct AdoptDesktopClassEditingInteractions: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Adopt desktop-class editing interactions"
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10071/")!
    }

    var english: String {
        """
        Andy: Hi there.
        Welcome to "Adopt desktop class editing interactions.
        " I'm Andy, a UIKit frameworks engineer, and I will be joined later by my colleague, James.
        The iPad is continuously evolving, without compromising the interactions that make it simple and easy to use.
        In this video, you'll learn about the exciting new editing interactions that will transform your app to become more desktop class.
        First, I'll go over the new edit menus, which received a major facelift in iOS 16.
        Later, James will dive into the new system find and replace experience.
        In iOS 16, the edit menu features an all-new design that remains familiar but is more interactive and is easier to discover actions.
        The edit menu now has alternate presentations based on the input method used.
        For touch interactions, the edit menu still has the familiar compact appearance, but with an improved paging behavior, allowing actions to be more discoverable than before.
        With the Magic Keyboard or a trackpad, a context menu is presented on secondary or right click for a more desktop class experience.
        Similarly, touch interaction on the iPhone will display the new edit menu.
        And for Mac Catalyst apps, context menus that Mac users are familiar with is presented.
        In iOS 16, the text edit menu gets a major power-up with new data detectors integration.
        This includes inline unit and currency conversions, as well as smart lookup which displays contextual actions depending on the selected text.
        For example, if you select an address in Safari, you will get Maps-based actions, like "Get Directions" or "Open in Maps," on top of the existing edit menu actions.
        The best part is, there is no adoption required! These features are available in every text edit menu, including text interaction views, WebKit and Safari, as well as PDFKit.
        To insert actions into a text view's menu, implement the new TextViewDelegate method to customize the displayed menu for text in the given range with system provided actions.
        If you don't need to customize anything, return nil to get the standard system menu.
        There are also similar methods on UITextFieldDelegate and UITextInput to customize the menu there too.
        Please note that inserting menu items using UIMenuController is now deprecated in iOS 16, and you should instead move to use the new methods to add menu elements into your text edit menus, because where we're going, we don't need menu controllers! Here is an example of a text view with some custom actions.
        When a menu is presented on some text selection, a custom "Highlight" and "Insert Photo" action is shown after the system suggested actions.
        Selecting the highlight action performs a highlight on the text as expected.
        Next, when the menu is presented without any text selection where there is nothing to highlight, the menu only displays the "Insert Photo" action after the system suggested actions.
        I'll show you how to add these actions using the new API.
        To insert actions into the menu dynamically on presentation, implement the UITextViewDelegate method textView editMenuForTextIn range suggestedActions In this example, I only want to add the "Highlight" action when there is selected text, so I can add the action dynamically through this method.
        The "Insert Photo" action is always valid, so I can add it into the array to always display the action in the menu.
        Finally, I'll append my actions to the system suggested actions, which includes items like Cut, Copy, and Paste, and return the menu.
        And that's it! UIEditMenuInteraction is the UIInteraction API that powers the new edit menu.
        The interaction allows you to programmatically present the lightweight edit menu outside of text views based on your own gesture, and has native support to present a context menu on secondary click.
        In iOS 16, UIMenuController and all of its related APIs are replaced by the new edit menu interaction.
        To present an edit menu from scratch, first, create the interaction and add it to the view.
        Next, configure a gesture recognizer to present the menu from.
        To ensure that the menu only appears on direct touch and not from indirect pointer clicks, be sure to set the allowedTouchTypes property of the gesture recognizer to be direct touch only.
        Then, add the gesture recognizer to the view.
        Finally, when the gesture recognizer fires, determine if there is content at the location of the gesture that could display the menu.
        Then, create an edit menu configuration with a source point at the gesture's location.
        The source point is used to determine performable actions in the interaction's view to display in the menu.
        Once configured, call presentEditMenu(with: configuration) to show the menu.
        When I right-click anywhere within the selected "Jello there!" view, a context menu is presented with performable system actions for the app's content.
        Even more, when I tap on the selected view, the edit menu is presented where my touch occurred, showing the same actions as the context menu.
         This is good, but it can be better.
         While it is nice that the menu appears where the touch occurred, it's actually blocking the selected view's content.
         Moreover, I want to insert a new "Duplicate" action into the menu, which is not a system default action.
         Let's go back and change this.
         To show the menu around the selected view, implement the delegate method editMenuInteraction targetRectFor configuration This method returns a CGRect used to determine where to present the menu from and is in the coordinate space of the interaction's view.
         If the method is not implemented or a null CGRect is provided, the menu will be presented from the source point of the configuration.
         In this case, to prevent the menu from occluding the selected view, return its frame.
         Next, to add the "Duplicate" action, implement editMenuInteraction menuFor configuration suggestedActions and append the custom action after the system suggested actions, similar to how you would insert actions into a text view's menu before.
        Now, when I tap again on the selected view, the menu no longer occludes "Jello there!" and instead presents around it.
         The new "Duplicate" action is also included when the menu is presented, all with just a few lines of code.
         Brilliant! For Mac Catalyst apps, the edit menu bridges to the familiar context menus that users expect on the Mac when they right click on the interaction's view.
         For iPad idiom Mac Catalyst apps, programmatically presented edit menus also bridge into context menus.
         Please note that programmatic presentation of the edit menu is not supported for Mac idiom apps.
         To offer seamless bridging between different presentation styles, UIEditMenuInteraction is built on top of the UIMenuElement family of APIs.
         These offer more flexibility and customizability than before, including support for submenus and images.
         If this is your first time using UIMenus, watch "Modernizing Your UI for iOS 13" to learn more about menus and actions.
         Building on top of UIMenuElement also means that the edit menu has access to a wide variety of APIs, like UIMenuSystem, that support menus already.
         The edit menu uses the existing UIMenuSystem.
        context system to build its menus.
         To find out more about the menu builder, as well as a deeper dive on responder chain traversal and command validation, watch "Taking your iPad apps to the next level.
        " Speaking of menus, there are several new enhancements to UIMenu in iOS 16.
         UIMenu now has a preferred element size property that allows you to choose between different layouts in the context menu.
         The small size gives the menu a more compact side-by-side appearance, fitting more actions in a single row.
         The medium size also displays actions in a side-by-side appearance but with a little more detail.
         This is used by the text edit menu to display the standard edit menu.
         And finally, the large element size gives the menu its default, full-width appearance.
         Additionally, there is a new .
        keepsMenuPresented attribute on UIMenuElement to keep menus presented after an action is performed.
         Use this attribute to allow actions to be performed multiple times without re-presenting the menu.
         That's just the tip of the iceberg for the new edit menu.
         Extend text editing functionality by customizing the text edit menu.
         Make sure that your actions have titles and images so that the menus look complete in different presentation styles.
         Most importantly, adopt the new UIEditMenuInteraction for better customizability and improved consistency across platforms and different input methods.
         Adding support for the new edit menu is a great first step.
         To complete the desktop class editing experience, I'll hand it over to James to talk about the new system find and replace experience.
        James Magahern: Ah, there it is! Hi, I'm James Magahern, a UIKit engineer, and I'm here to talk about find and replace.
         New in iOS 16, we introduced a new UI component for finding and replacing text in apps.
         It's standard across the system and included with many of the built-in apps, and allows your users to flex their muscle memory with even more commonly used editing shortcuts.
         This is the new find panel running on iPad.
         We will automatically transition from floating inline with the shortcut bar when a hardware keyboard is attached, to resting on top of the software keyboard when used without a hardware keyboard.
         On iPhone, we'll adapt to the smaller screen size by using a more compact layout.
         Automatic dismissal, minimization, and keyboard avoidance are all taken care of by the system.
         When running your app on a Mac, we'll present the find panel inline with your content, behaving just like the AppKit find bar, and using a familiar layout that users expect on the Mac.
        If you're using UITextView, WKWebView, or PDFViews to display text content in your apps, all you need to do to get started is set isFindInteractionEnabled to true on the built-in find interaction.
         It's that simple! In addition, if you're using QuickLook to display text content, this will already be available without any work from you.
        With a hardware keyboard, all of the standard system shortcuts like command+F for find, command+G for find next, command+shift+G for find previous, et cetera, will work just as expected.
         Access to these commands are available via the menu bar when running on a Mac.
         All you need to do is make sure the view displaying the content can and does become first responder.
         For users who are not using a hardware keyboard, you can invoke the find interaction programmatically via presentFindNavigator, on the included find interaction property.
         It might be a good idea to make this available via a navigation bar item, for example.
        When running on a Mac, there's a couple other things to keep in mind.
         For instance, on iOS, the find panel is presented as part of the software keyboard or shortcut bar.
         On the Mac, we'll display it inline with your content.
         If you're installing the find interaction on a scroll view, we’ll automatically adjust the content insets to accommodate the find panel, and adapt to trait collection changes automatically.
         You should otherwise make sure that there's enough room to host the find panel in your UI on macOS.
        Additionally, we'll show a menu containing a standard set of find options available when tapping on the magnifying glass icon.
         You can customize the contents of this menu by using the optionsMenuProvider property on UIFindInteraction.
         This will be more important with custom implementations.
         And that's all it takes if you're using one of the built-in views that I mentioned before.
         If your app is displaying textual content by other means, like a completely custom view or something like a list view, shown here, you can still add the find interaction to your app.
         Let me show you how.
        The good news about find interaction is that you can install it on any arbitrary view.
         If you have an existing find and replace implementation in your app, it's a snap to bridge over to UIFindInteraction and take advantage of the system's UI.
         If you don't already have an existing find implementation for your custom view, it's still super easy to get started, especially if you've already implemented the UITextInput protocol in order to work with the system keyboard.
         Here's how UIFindInteraction works with custom views.
         After installing UIFindInteraction on your custom view, set up a find interaction delegate.
         The find interaction delegate, besides being notified about when a find session begins or ends, is responsible for dealing out UIFindSessions.
         UIFindSession is an abstract base class that encapsulates all of the state for a given session, such as the currently highlighted result.
         It also services all actions requested from the UI, such as "go to the next result," or "search for this string.
        " If you want to manage all of this state yourself, you can choose to vend a subclass of UIFindSession from your find interaction delegate.
        This is a good option if you already have an existing find and replace implementation in your app, and want to bridge it over to the system UI.
         Otherwise, it would be a much better idea to let the system take care of the state for you, and instead adopt the UITextSearching protocol on whatever class encapsulates the content of the document being displayed.
         To do this, you would return a UITextSearchingFindSession, and connect it with your document class.
        This is the best option if you don't yet have a find implementation for your custom view.
         Here's how to do this in code.
        This example has a custom document class and a custom view which displays this document.
         The UIFindInteraction will be installed on this view, and a UITextSearchingFindSession will be provided with this document as the "searchable object.
        " Make sure either your view controller or your custom view can become first responder so keyboard shortcuts work as expected.
        Create the find interaction, and provide a session delegate to deal out find sessions.
         Here, the view controller is the session delegate.
         Then, when asked for a find session by the interaction, just return a new UITextSearchingFindSession providing your document as the searchable object.
         You will of course need to make sure that your document class conforms to the UITextSearching protocol.
        The class which implements the UITextSearching protocol is responsible for actually finding text in your document.
         The system will call performTextSearch, and hand you an aggregator object to which you can provide results.
         The aggregator works with UITextRange to represent results in your document.
        This is another abstract class that you can use to encapsulate whatever data makes sense for how you store text.
         For example, this could represent a DOM range for clients who use WebKit to render text.
         The aggregator is also thread-safe, so you can provide it results on a background thread.
         Finally, since the find interaction doesn't know how to display results using your custom view, you'll also need to decorate results for a given style when decorate() is called.
         The UITextSearching find session and protocol also support multiplexing across multiple visible documents using the same interaction.
        In other words, if your app displays content in a manner similar to Mail's conversation view, where each "document" in that case is a mail message, you can install a single find interaction on the root level collection view and perform a find across all documents at the same time, allowing your users to jump between results in different documents with ease.
         So that's all it takes to get started with the new find interaction in iOS 16.
         For system views that display a lot of text content, make sure to enable isFindInteractionEnabled.
         Move your existing find implementation to UIFindInteraction.
         Implement UITextSearching and use UITextSearchingFindSession if you don't yet have text searching in your app.
         And lastly, check and make sure you don't have any conflicting keyboard shortcuts in your app.
         And that is what it takes to refresh your app's editing interactions for iOS 16 and make them truly desktop class.
        Try the new text edit menu in your app, and adopt the edit menu interaction for custom UI.
         And boost productivity by making your app's text content searchable.
         I'm looking forward to finding these great new features in your app.
         Thanks for watching! Make sure to like, comment, and subscribe.
        """
    }

    var japanese: String {
        """
         アンディ: こんにちわ。
         デスクトップ・クラス編集インタラクションを採用する」へようこそ。
        " UIKitフレームワークエンジニアのAndyです。この後、同僚のJamesと一緒にお送りします。
         iPadは、シンプルで使いやすいインタラクションを損なうことなく、常に進化を続けています。
         このビデオでは、あなたのアプリをデスクトップクラスに変身させる、エキサイティングな新しい編集インタラクションについて学びます。
         まず、iOS 16で大きく生まれ変わった新しい編集メニューについて説明します。
        その後、Jamesは新しいシステムの検索と置換のエクスペリエンスに飛び込みます。
         iOS 16では、編集メニューのデザインが一新され、使い慣れたデザインでありながら、よりインタラクティブになり、アクションを見つけやすくなっています。
        編集メニューは、使用する入力メソッドに応じて、別の表示方法を持つようになりました。
         タッチ操作の場合、編集メニューは使い慣れたコンパクトな外観のままですが、ページング動作が改善され、アクションを以前より見つけやすくなっています。
        Magic Keyboardやトラックパッドでは、セカンダリクリックや右クリックでコンテキストメニューが表示され、よりデスクトップ的な操作性を実現します。
         同様に、iPhoneでタッチ操作を行うと、新しい編集メニューが表示されます。
        また、Mac Catalystアプリケーションでは、Macユーザーに馴染みのあるコンテキストメニューが表示されます。
         iOS 16では、新しいデータ検出器の統合により、テキスト編集メニューが大幅にパワーアップします。
         これには、インラインでの単位や通貨の変換、選択したテキストに応じてコンテキストに応じたアクションを表示するスマートルックアップが含まれます。
         例えば、Safariで住所を選択すると、既存の編集メニューのアクションに加えて、「行き方を調べる」「地図で開く」といったマップベースのアクションが表示されます。
         何より素晴らしいのは、アドプションが必要ないことです。これらの機能は、PDFKitだけでなく、テキストインタラクションビュー、WebKit、Safariを含むすべてのテキスト編集メニューで利用可能です。
        テキストビューのメニューにアクションを挿入するには、新しいTextViewDelegateメソッドを実装して、与えられた範囲のテキストに対して表示されるメニューを、システムが提供するアクションでカスタマイズします。
         もし、何もカスタマイズする必要がなければ、nilを返して標準のシステムメニューを取得します。
         UITextFieldDelegateやUITextInputにも同様のメソッドがあり、そちらでもメニューのカスタマイズができる。
         UIMenuControllerを使ったメニューの挿入はiOS 16で非推奨となったので、代わりに新しいメソッドを使ってテキスト編集メニューにメニュー要素を追加する必要があることに注意しよう。以下は、カスタムアクションを持つテキストビューの例です。
         テキスト選択時にメニューが表示されると、システムが提案するアクションの後に、カスタムの「ハイライト」と「写真の挿入」アクションが表示されます。
         ハイライトアクションを選択すると、予想通りテキストにハイライトが実行されます。
         次に、ハイライトするものが何もないテキスト選択状態でメニューを表示すると、システム提案アクションの後に「写真を挿入」アクションのみが表示されます。
         新しいAPIを使用して、これらのアクションを追加する方法を紹介します。
         プレゼンテーション時に動的にメニューにアクションを挿入するには、UITextViewDelegateメソッド textView editMenuForTextIn range suggestedActions を実装します。この例では、選択テキストがあるときだけ「ハイライト」アクションを追加したいので、このメソッドを使って動的にアクションを追加しています。
        Insert Photo" アクションは常に有効なので、これを配列に追加して常にメニューに表示させることができます。
         最後に、カット、コピー、ペーストなどの項目を含むシステム提案アクションに私のアクションを追加して、メニューを返します。
         これで完了です。UIEditMenuInteractionは、新しいエディットメニューを動かすUIInteraction APIです。
        このインタラクションを使用すると、独自のジェスチャーに基づいてテキストビューの外側に軽量な編集メニューをプログラム的に表示することができ、二次クリック時にコンテキストメニューを表示するためのネイティブサポートを備えています。
         iOS 16では、UIMenuControllerとそれに関連するすべてのAPIが、新しい編集メニューインタラクションに置き換えられました。
        最初から編集メニューを表示するには、まずインタラクションを作成し、それをビューに追加します。
         次に、メニューを表示するためのジェスチャーレコグナイザーを設定します。
         メニューが、間接的なポインターのクリックではなく、直接タッチされた場合にのみ表示されるように、ジェスチャー認識機能の allowedTouchTypes プロパティを、直接タッチのみに設定することを確認してください。
         次に、ジェスチャー認識器をビューに追加します。
         最後に、ジェスチャー認識ツールが起動したら、ジェスチャーの位置に、メニューを表示できるコンテンツがあるかどうかを判断します。
         次に、ジェスチャーの位置にソース ポイントを持つ編集メニュー設定を作成します。
         ソースポイントは、メニューに表示されるインタラクションのビューで実行可能なアクションを決定するために使用されます。
        設定が完了したら、presentEditMenu(with: configuration)を呼び出してメニューを表示させます。
        選択した「Jello there！」ビュー内の任意の場所を右クリックすると、アプリのコンテンツに対して実行可能なシステムアクションを含むコンテキストメニューが表示されます。
        さらに、選択したビューをタップすると、タッチした場所に編集メニューが表示され、コンテキストメニューと同じアクションが表示されます。
         これは良いことなのですが、もっと良い方法があります。
         タッチした場所にメニューが表示されるのはいいのですが、実際には選択したビューのコンテンツをブロックしているのです。
         さらに、メニューに新しい「複製」アクションを挿入したいのですが、これはシステムのデフォルトアクションではありません。
         戻ってこれを変更しましょう。
         選択されたビューの周囲にメニューを表示するには、デリゲートメソッド editMenuInteraction targetRectFor 設定を実装します。 このメソッドは、どこからメニューを表示するかを決めるために使用する CGRect を返し、インタラクションのビューの座標空間内に存在します。
         このメソッドが実装されていない場合、またはNullのCGRectが提供された場合、メニューは設定のソースポイントから提示されます。
         この場合、メニューが選択されたビューにかぶさるのを防ぐため、そのフレームを返します。
         次に、"Duplicate "アクションを追加するには、editMenuInteraction menuFor configuration suggestedActionsを実装し、以前テキストビューのメニューにアクションを挿入したのと同様に、システム提案アクションの後にカスタムアクションを追加してください。
        これで、選択したビューをもう一度タップしても、メニューが "Jello there!"を囲むように表示されなくなりました。
         新しい「複製」アクションも、メニューが表示されたときに含まれます。すべて、ほんの数行のコードで実現されています。
         すばらしい Mac Catalystアプリケーションでは、編集メニューは、ユーザーがインタラクションのビューを右クリックしたときにMacで期待されるおなじみのコンテキストメニューに橋渡しされます。
         iPadイディオムのMac Catalystアプリでは、プログラムによって表示される編集メニューが、コンテキストメニューにつながります。
         Macイディオムアプリでは、プログラムによる編集メニューの表示はサポートされていないことに注意してください。
         UIEditMenuInteractionは、UIMenuElementファミリーのAPIの上に構築されており、異なるプレゼンテーション・スタイル間のシームレスな橋渡しを提供します。
         これらは、サブメニューや画像のサポートなど、以前よりも柔軟でカスタマイズ性の高い機能を提供します。
         UIMenusを初めて使用する場合は、「Modernizing Your UI for iOS 13」を見て、メニューとアクションについて詳しく学んでください。
         UIMenuElementの上に構築することは、編集メニューが、UIMenuSystemのような、すでにメニューをサポートしている様々なAPIにアクセスできることも意味します。
         エディットメニューは、既存のUIMenuSystem.
        コンテキスト・システムを使用してメニューを構築します。
         メニュービルダについての詳細、およびレスポンダチェーントラバーサルとコマンドバリデーションについての深堀りは、「iPadアプリを次のレベルに引き上げる」をご覧ください。
        " メニューといえば、iOS 16ではUIMenuにいくつかの新しい機能強化がなされています。
         UIMenuに優先要素サイズのプロパティが追加され、コンテキストメニューで異なるレイアウトを選択できるようになりました。
         小サイズでは、メニューがよりコンパクトなサイドバイサイドの外観になり、より多くのアクションが一列に収まります。
         中サイズでは、アクションが横に並んで表示されますが、より詳細な情報が表示されます。
         これは、標準の編集メニューを表示するためのテキスト編集メニューで使用されます。
         そして最後に、大きい要素サイズでは、メニューがデフォルトのフルワイドの外観になります。
         さらに、新しい .
        keepsMenuPresented属性がUIMenuElementに追加され、アクションが実行された後もメニューが表示されたままになります。
         この属性を使用すると、メニューを再提示することなく、アクションを複数回実行することができます。
         これは、新しい編集メニューの氷山の一角に過ぎません。
         テキスト編集メニューをカスタマイズすることで、テキスト編集機能を拡張することができます。
         アクションにタイトルと画像を付けて、さまざまな表示スタイルでメニューが完成するようにしましょう。
         最も重要なことは、新しいUIEditMenuInteractionを採用して、カスタマイズ性を高め、プラットフォームや異なる入力メソッド間の一貫性を向上させることです。
         新しい編集メニューのサポートを追加することは、素晴らしい最初のステップです。
         デスクトップ・クラスの編集エクスペリエンスを完成させるために、Jamesに新しいシステムの検索と置換のエクスペリエンスについて話してもらうことにします。
        James Magahern：あ、あったあった。UIKitのエンジニアのJames Magahernです。
         iOS 16で新たに、アプリ内のテキストを検索して置き換えるためのUIコンポーネントが導入されました。
         これはシステム全体に標準装備され、多くの内蔵アプリに含まれています。さらによく使われる編集用のショートカットを使って、ユーザーのマッスルメモリーを柔軟にすることができるようになりました。
         これは、iPad上で動作する新しい検索パネルです。
         ハードウェアキーボードが装着されているときはショートカットバーのインラインに浮かび、ハードウェアキーボードが装着されていないときはソフトウェアキーボードの上に表示されるように、自動的に切り替わります。
         iPhoneでは、よりコンパクトなレイアウトで、より小さな画面サイズに対応します。
         自動解除、最小化、キーボード回避は、すべてシステム側で行います。
         Mac でアプリを実行する場合は、AppKit の検索バーと同じように動作し、ユーザーが Mac で期待する使い慣れたレイアウトを使用して、コンテンツとインラインで検索パネルを表示します。
        UITextView、WKWebView、PDFViewを使用してアプリケーションにテキストコンテンツを表示している場合、ビルトインの検索インタラクションでisFindInteractionEnabledをtrueに設定するだけで、すぐに使い始めることができます。
         とても簡単です。さらに、QuickLookを使ってテキストコンテンツを表示している場合は、何もしなくても、すでにこの機能が利用可能です。
        ハードウェアキーボードでは、command+Fで検索、command+Gで次を検索、command+shift+Gで前を検索など、標準のシステムショートカットはすべて期待通りに動作します。
         Macでは、メニューバーからこれらのコマンドにアクセスすることができます。
         あとは、コンテンツを表示しているビューがファーストレスポンダーになれるかどうか、確認するだけです。
         ハードウェアキーボードを使用していないユーザーのために、同梱の find interaction プロパティで presentFindNavigator を介してプログラム的に find interaction を呼び出すことができます。
         例えば、ナビゲーションバーアイテムでこれを利用できるようにするのは良いアイデアかもしれません。
        Macで実行する場合、他にもいくつか注意すべき点があります。
         例えば、iOSの場合、検索パネルはソフトウェアキーボードまたはショートカットバーの一部として表示されます。
         Macでは、コンテンツとインラインで表示されます。
         スクロールビューに検索インタラクションをインストールする場合、検索パネルに合わせてコンテンツのインセットを自動的に調整し、形質コレクションの変更に自動的に対応します。
         macOS では、UI に検索パネルを配置するための十分なスペースがあることを確認する必要があります。
        さらに、虫眼鏡アイコンをタップしたときに利用できる、標準的な検索オプションのセットを含むメニューを表示することにします。
         UIFindInteraction の optionsMenuProvider プロパティを使用すると、このメニューの内容をカスタマイズすることができます。
         これは、カスタム実装でより重要になるでしょう。
         そして、先に述べた組み込みビューの1つを使用している場合は、これだけでよいのです。
         もしあなたのアプリが他の方法でテキストコンテンツを表示している場合、例えば完全にカスタム化されたビューや、ここに示すリストビューのようなものでも、あなたのアプリにfindインタラクションを追加することは可能です。
         その方法を説明しましょう。
        findインタラクションの良いところは、任意のビューにインストールできることです。
         もしあなたのアプリに既存のfindやreplaceの実装があるなら、UIFindInteractionに橋渡ししてシステムのUIを利用するのは簡単です。
         カスタムビューに既存の検索実装がない場合でも、特にシステムのキーボードと連携するためにUITextInputプロトコルを既に実装していれば、簡単に始めることができます。
         UIFindInteractionがカスタムビューでどのように動作するかを説明します。
         カスタムビューにUIFindInteractionをインストールしたら、findインタラクションデリゲートをセットアップします。
         findインタラクションデリゲートは、検索セッションが開始または終了したときに通知されるほか、UIFindSessionを処理する役割を担っています。
         UIFindSession は抽象的な基底クラスで、現在ハイライトされている結果など、与えられたセッションのすべての状態をカプセル化します。
         また、UIから要求されたすべてのアクション、例えば「次の結果に移動する」、「この文字列を検索する」なども提供します。
        " この状態をすべて自分で管理したい場合は、 find インタラクションのデリゲートから UIFindSession のサブクラスをベンダリングすることを選択できます。
        これは、すでにアプリに既存の検索と置換の実装があり、それをシステムUIに橋渡ししたい場合に有効なオプションです。
         それ以外の場合は、システムに状態を任せて、表示されるドキュメントのコンテンツをカプセル化したクラスでUITextSearchingプロトコルを採用する方がはるかに良いアイデアでしょう。
         そのためには、UITextSearchingFindSessionを返して、それをドキュメントクラスと接続します。
        これは、カスタムビューにまだ find の実装がない場合に最適な方法です。
         コードでこれを行う方法を説明します。
        この例では、カスタム ドキュメント クラスと、このドキュメントを表示するカスタム ビューがあります。
         UIFindInteraction はこのビューにインストールされ、 UITextSearchingFindSession はこのドキュメントを "検索対象" として提供されるでしょう。
        " キーボードショートカットが期待通りに動作するように、 ビューコントローラかカスタムビューのどちらかがファーストレスポンダになれるようにしてください。
        find インタラクションを作成し、 find セッションを処理するためのセッションデリゲートを提供します。
         ここでは、ビューコントローラがセッションデリゲートとなります。
         そして、このインタラクションから検索セッションを要求されたら、 新しい UITextSearchingFindSession を返して、 検索可能なオブジェクトとしてドキュメントを提供します。
         もちろん、あなたのドキュメントクラスがUITextSearchingプロトコルに適合していることを確認する必要があります。
        UITextSearching プロトコルを実装したクラスは、実際にドキュメント内のテキストを検索する役割を担います。
         システムは performTextSearch を呼び出し、結果を提供するためのアグリゲータオブジェクトを渡します。
         アグリゲータは UITextRange と連携して、ドキュメント内の結果を表します。
        これも抽象クラスで、テキストを保存するのに必要なデータをカプセル化するために使用します。
         たとえば、WebKit を使用してテキストをレンダリングするクライアントのために DOM 範囲を表すことができます。
         アグリゲーターはスレッドセーフでもあるので、バックグラウンドスレッドで結果を提供することができます。
         最後に、findインタラクションはカスタムビューを使用して結果を表示する方法を知らないので、decorate()が呼ばれたときに、指定したスタイルで結果を装飾する必要があります。
         UITextSearchingの検索セッションとプロトコルは、同じインタラクションを使用して複数の可視ドキュメントにまたがる多重化もサポートしています。
        つまり、アプリがMailの会話ビューのような方法でコンテンツを表示し、その場合の各「ドキュメント」がメールメッセージである場合、ルートレベルのコレクションビューに単一の検索インタラクションをインストールし、すべてのドキュメントを同時に検索して、ユーザーが異なるドキュメントの結果を簡単に行き来できるようにすることが可能です。
         iOS 16の新しい検索インタラクションを使い始めるために必要なことは、以上です。
         多くのテキストコンテンツを表示するシステムビューでは、isFindInteractionEnabledを必ず有効にしてください。
         既存のfind実装をUIFindInteractionに移行します。
         UITextSearchingを実装し、アプリにまだテキスト検索がない場合は、UITextSearchingFindSessionを使用してください。
         そして最後に、アプリ内でキーボードショートカットが競合していないことを確認します。
         これで、アプリの編集インタラクションを iOS 16 用に更新し、真のデスクトップクラスにすることができます。
        あなたのアプリで新しいテキスト編集メニューを試し、カスタムUIのための編集メニューインタラクションを採用しましょう。
         そして、アプリのテキストコンテンツを検索可能にすることで、生産性を高めましょう。
         あなたのアプリでこれらの素晴らしい新機能を見つけることを楽しみにしています。
         ご視聴ありがとうございました。いいね！」、「コメント」、「購読」を必ずお願いします。
        """
    }
}
