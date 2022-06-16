import Foundation

struct AddSharedWithYouToYourApp: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Add Shared with You to your app"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6588/6588_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10094/")!
    }

    var english: String {
        """
        Karthik: Hi, I'm Karthik, an engineer on the Messages team.
         In this video, I'm going to introduce Shared with You, and how to adopt it in your app.
        Shared with You was announced in iOS 15.
         It is designed to make it easier for you to revisit links that friends and family send you in Messages.
         System applications that have adopted Shared with You are Safari, News, Music, Podcasts, the TV app and Photos.
         Shared with You meets you where you're consuming content.
         Many times content is received when we are not ready to consume it.
         For example, a friend sends a recommendation for a TV show while you are out grocery shopping, and then it's forgotten in the course of the day.
         Shared with You makes it easier to discover this TV show later on when you are browsing for TV shows to watch in the TV app Shared with You makes it convenient to pick up a Messages conversation right from within the app, allowing you to stay in context of shared content without leaving the app.
        Your content can be pinned in Messages.
         It elevates the content in Shared with You and Search.
         This is a signal that content is important, and starts the flow of automatic sharing consent.
         More on that later.
         In iOS 16, Shared with You is extended to include your apps, links, and content.
         This takes the convenience of Shared with You and puts it in your apps.
        I'll first talk about the design of Shared with You in your app, then show you how it works, and then walk you through how to adopt Shared with You.
        Starting with design.
         There are two parts of Shared with You that are part of your app experience: The Shared with You shelf, and the Shared with You attribution view.
         The Shared with You shelf is a dedicated space in your app's browsing experience that highlights content that was shared in Messages.
         For example, the TV app's "Watch Now" tab has a Shared with You shelf.
         So does the Listen Now tab in Music and Podcasts.
        The content provided by Shared with You is a ranked and ordered list.
         I'll go over that later in the video.
         For each item in the Shared with You shelf, show a rich preview along with an attribution view.
         A rich preview has thumbnail, a title, and a subtitle if applicable.
         In this example, the rich preview consists of podcast art, episode name, and the show name.
         There is also an attribution view for each shared content in the Shared with You shelf.
         This is the all of the information that allows context to be gleaned at a glance.
        Have a Show More element that can expand the view or navigate to showing all of your app's Shared with You content.
         The Attribution view is an out of process view that securely displays the names and avatars of who shared it.
         It also shows if the content was pinned in Messages.
         Show the attribution view in the details view of your content.
         This allows people to connect content in your app back to the Messages conversation it was shared in.
         For example, when I'm browsing for a TV show to watch, the attribution view helps me recall that a friend had recommend it.
         I can quickly tell my friend that I'm about to watch the show.
         All this happens right in app, and after replying, I'm right back at the content.
         The attribution view is interactive.
         Tapping on the view takes you to the Messages conversation right from within the application.
         The attribution view also presents contextual menu options such as "Reply" and "Remove".
         The "Reply" content menu option functions similar to tapping the view.
         The "Remove" context menu option is a way to tell the Shared with You not to surface a piece of content going forward.
         The same contextual menus are made available to you to add to your content's contextual menus.
         The title for the Remove context menu can be customized.
         For example in Safari, the contextual menu for the web page shows "Remove Link".
         I'll go over how you can do this in your app later on in this video.
         Now you know where to present a Shared with You shelf and where to show the Attribution View.
         Let me show you how Shared with You works.
         Links shared by friends and family in Messages are surfaced in Shared with You.
         Links in group conversations are surfaced when at least one participant is a contact.
         Shared with You is based on the same technology behind Universal Links.
         Universal Links allows for seamless linking to content in your app or on your website.
         Users have granular control over Shared with You content.
        They can choose what content is shared outside of Messages on a per conversation basis, per app, or globally.
         This permission doesn't need to be requested in advance.
         It happens organically.
         Pinning links is implicit permission to surface the content in Shared with You.
         Pinned content is always available to Shared with You in your app.
         Based on heuristics when content for your app is pinned in Messages, an option to enable automatic sharing is presented.
         When automatic sharing is turned on, further content is automatically available to Shared with You in your app.
        Content in Shared with You is ordered.
         The first item in the Shared with You shelf is curated by Siri Suggestions based on various signals from the system.
         This is followed by Pinned items and the remainder of the list is chronologically ordered.
        Siri Suggestions uses signals such as "Has the user viewed or interacted with the content?" Is the content Pinned? In which context is the content being presented? Your app plays a part in providing this feedback.
         I'll go over in detail a little later on in the video.
         All this is done to ensure that content is not too transient or stale.
         In a conversation when a link is shared multiple times, Shared with You surfaces only the most recent message.
         When a link is shared in multiple Messages conversations, Shared with You visually represents that via the attribution view.
         For example, both Enrique and Sarah have shared the Top 25 Chicago playlist.
         The attribution view shows both their contact avatars.
         Tapping on the attribution view presents a disambiguation menu, allowing you to choose which Messages conversation to reply to.
         Security and Privacy was a primary consideration and focus when designing Shared with You.
         The attribution views and disambiguation views are drawn on your behalf out of process.
         Shared with You protects your app's content via the Universal Links association so it is accessible to only your app.
         Apps do not have access to Messages recipients and conversations.
        Now you know how Shared with You works.
         On to the most exciting part– how to adopt Shared with You in your app.
         First, adopt Universal Links.
         Then, add the new Shared with You Capability, under the Capabilities tab in Xcode.
         Then, put a Shared with You shelf in your app, and add attribution view to your content.
         Let me briefly talk about adopting Universal Links.
        Universal Links allows your users to intelligently follow links to content in your app or to your website.
         Take the following steps to support universal links.
         First create a two-way association between your app and your website and specify the URLs that your app handles.
         You create them by adding the Associated Domains entitlement to your app, and by adding a JSON file to your web server.
         Next, update your app delegate to respond to the user activity object the system provides when a universal link routes to your app.
         For more information, please watch the "What's new in Universal Links" video.
         In iOS 16 we have introduced a new Framework called Shared with You.
         There are three main classes in the Shared with You Framework: SWHighlightCenter, SWHighlight, and SWAttributionView.
         SWHighlightCenter is the class that helps you get Shared with You content for your app.
         SWHighlight is a model object that wraps your app's shared content.
         SWAttributionView is the view that helps connect your content back to a Messages conversation and displays attribution information.
        The highlight center is a simple object that consists of: Highlights, which is an array of SWHighlight objects; and a delegate property by which apps get notified when there is content added, removed, or updated by Shared with You.
         A highlight is represented by the SWHighlight class.
         It is used to pass the URL for your app's content that was shared in Messages.
         You use it to refer to your content, render a rich preview, and navigate to the content in your app.
         Let me show you how to enumerate Shared with You content in your app.
        First create an instance of SWHighlightCenter.
         Then set the delegate property.
         Implement the SWHighlightCenterDelegate method.
         Use the highlights property on the highlight center to access your app's Shared with You content.
         Apps can choose to keep the previous list of highlights in order to quickly diff that list against the latest list.
        Use the URL property on each highlight to generate a Rich preview of your app's content.
         And it's as easy as that to enumerate Shared with You content in your app.
         Next, I'll show you how to add and customize the Attribution View to your app's Shared with You content.
         SWAttributionView is the view that shows the names and avatars of who shared the content.
         Each highlight has a corresponding attribution view.
         Setting the highlight Property on the attribution view triggers the out of process rendering of the attribution information.
        Specify a maximum width the attribution view can take.
         The attribution view will fill or fit the space as needed.
         Set the alignment of the attribution view within the maximum space.
         Let me show you an example.
        Create an instance of SWAttributionView and set the highlight property.
         Set the preferredMaxLayoutWidth.
         In this example it spans the bottom of the shared content thumbnail.
         Constrain this view's width anchor or set its frame width to control the maximum width of its contents.
         Set the maximum AX content size category for the view as necessary using: minimumContentSizeCategory or maximumContentSizeCategory properties on UIView.
         Provide enough vertical space around this view.
         The view's height is dependent on the preferredContentSizeCategory, and the resulting font size.
         If the view's height is unnecessarily constrained, then the view might be clipped or not get drawn.
         The horizontalAlignment is set to leading in this case.
         It can also be set to Center or Trailing.
         Next, let me show you how to customize the Attribution view.
         Setting a display context helps inform the system about how the user is consuming the attributed content.
         It also influences ranking of Shared with You content for your app.
         Set this before it's added to a window.
         The background style of the attribution view can be customized based on the content's background it is being used against.
         Let me show you an example.
         The default value for displayContext property is summary.
         This indicates that the content is being shown for consumption.
         Set the displayContext to detail when the user is actively consuming the content, like watching a movie or listening to a podcast.
         Setting the displayContext is the feedback your app can provide.
         This'll help Siri Suggestions rank content for you app.
         Set the background style for the attribution view to color when placing the attribution view over monochrome backgrounds like in this example.
         Use material when placing the attribution view over multicolored backgrounds.
         This sets a material background blur for the view's contents.
         In this example, Safari's landing page has a background image.
         The contents of the attribution view are more visible by setting the correct background style.
         Next let me show you how to add Shared with You Contextual Menus to your app's content and customize the title.
         The existing contextual menu attached to your app's content can be supplemented by the attribution view's menu.
         This menu should be added inline with or at the end of the contextual menu it augments.
         A custom title for the Remove contextual menu option can be provided.
         The string should include the word "Remove", localized correctly.
         In this example, Safari has customized the Remove menu title to "Remove Link" in its content's context menu at the end.
         Let me show you how to do this via an example.
         First create an instance of the attribution view and set the highlight property.
         Provide a custom title for the Remove context menu via the menuTitleForHideAction.
         When configuring your content's context menu, get the menu from the attribution view via the supplementalMenu property.
         Then append them to your content's context menu.
         These easy steps allow your app to add the context menu option available on the attribution view to your content's context menus.
         Now you know all that is needed to adopt Shared with You in your app.
         Let's recap the three easy steps to adopt Shared with You in your app.
         Go adopt Universal Links.
         Then add the new Shared with You Capability in Xcode for your app.
         Import and use the new Shared with You framework.
         I'm looking forward to sharing your content in Messages and using Shared with You in your app.
         Thank you for your time and attention.


        """
    }

    var japanese: String {
        """
        Karthik: こんにちは、MessagesチームのエンジニアのKarthikです。
         このビデオでは、Shared with Youの紹介と、それをアプリに採用する方法について説明します。
        Shared with Youは、iOS 15で発表されました。
         メッセージで友人や家族が送ってきたリンクを、より簡単に再訪できるようにするためのものです。
         Shared with Youを採用しているシステムアプリケーションは、Safari、ニュース、ミュージック、Podcasts、TVアプリケーション、写真です。
         Shared with Youは、あなたがコンテンツを消費している場所に対応します。
         多くの場合、コンテンツは消費する準備ができていないときに受け取られます。
         例えば、買い物に出かけている間に友だちがお薦めのテレビ番組を送ってくれても、その日のうちに忘れてしまうことがあります。
         Shared with Youを使えば、後でテレビアプリケーションで見たいテレビ番組を閲覧しているときに、このテレビ番組を簡単に発見できます。Shared with Youを使えば、アプリケーション内からメッセージの会話をすぐに拾って、アプリケーションから離れずに共有コンテンツの文脈を維持することができるため便利です。
        あなたのコンテンツはメッセージにピン留めすることができます。
         Shared with Youと検索に表示されるコンテンツが格上げされます。
         これはコンテンツが重要であることを示すシグナルであり、自動的な共有同意のフローを開始します。
         詳しくは後ほど。
         iOS 16では、「あなたと共有」が拡張され、あなたのアプリケーション、リンク、コンテンツが含まれるようになりました。
         これは、Shared with Youの便利さを、あなたのアプリに取り入れたものです。
        まず、あなたのアプリにShared with Youを導入するデザインについてお話しし、次にその仕組みを紹介し、Shared with Youを採用する方法を説明します。
        まずはデザインから。
         アプリのエクスペリエンスに含まれるShared with Youのパーツは2つあります。Shared with Youの棚と、Shared with Youのアトリビューション・ビューです。
         Shared with You棚は、メッセージで共有されたコンテンツをハイライトする、アプリのブラウジングエクスペリエンス内の専用スペースです。
         例えば、テレビアプリケーションの「Watch Now」タブには、「Shared with You」シェルフがあります。
         音楽とPodcastの「今すぐ聴く」タブも同様です。
        Shared with Youで提供されるコンテンツは、ランク付けされ、順序付けられたリストです。
         それについては、ビデオの後半で説明します。
         Shared with You」シェルフの各アイテムには、リッチプレビューとアトリビューションビューが表示されます。
         リッチプレビューには、サムネイル、タイトル、サブタイトルがあります（該当する場合）。
         この例では、リッチプレビューは、ポッドキャストアート、エピソード名、および番組名で構成されています。
         また、「Shared with You」シェルフには、各共有コンテンツのアトリビューションビューがあります。
         このように、一目で文脈を把握できる情報がすべて揃っています。
        Show More]要素を使用すると、ビューを拡大したり、アプリのすべてのShared with Youコンテンツを表示するように移動したりできます。
         アトリビューションビューは、共有した人の名前とアバターを安全に表示するアウトオブプロセスビューです。
         また、そのコンテンツがメッセージにピン留めされているかどうかも表示されます。
         コンテンツの詳細ビューでアトリビューションビューを表示する。
         これにより、あなたのアプリ内のコンテンツを、それが共有されたメッセージの会話にさかのぼって関連付けることができます。
         たとえば、見たいテレビ番組を探しているときに、アトリビューションビューを見れば、友だちがその番組をすすめていたことを思い出すことができます。
         そして、これからその番組を見ようと思っていることを、友だちにすぐに伝えることができます。
         そして、返信した後は、すぐに元のコンテンツに戻ることができるのです。
         アトリビューション・ビューは、インタラクティブです。
         ビューをタップすると、アプリケーション内からメッセージの会話に直接アクセスできます。
         アトリビューには、「返信」や「削除」などのコンテキストメニューオプションも表示されます。
         返信」コンテンツメニューオプションは、ビューをタップしたときと同様の機能を果たします。
         削除」コンテキストメニューオプションは、Shared with Youに対して、今後、コンテンツの一部を表示しないように指示する方法です。
         同じコンテキストメニューが、コンテンツのコンテキストメニューに追加できるようになっています。
         コンテキストメニューの削除のタイトルは、カスタマイズできます。
         たとえばSafariでは、ウェブページのコンテクストメニューに「リンクの削除」と表示されます。
         このビデオの後半で、アプリでこれを行う方法について説明します。
         これで、Shared with Youの棚を表示する場所と、アトリビューションビューを表示する場所がわかりました。
         Shared with Youがどのように機能するかをお見せしましょう。
         メッセージで友人や家族が共有したリンクは、「Shared with You」に表示されます。
         グループ会話に含まれるリンクは、少なくとも1人の参加者が連絡先である場合に表示されます。
         Shared with Youは、ユニバーサルリンクの背後にある同じテクノロジーをベースにしています。
         ユニバーサルリンクを使用すると、アプリケーションやウェブサイトのコンテンツにシームレスにリンクすることができます。
         ユーザーは、Shared with Youのコンテンツを細かく制御できます。
        メッセージの外部で共有するコンテンツは、会話ごと、アプリごと、またはグローバルに選択することができます。
         この許可は、事前にリクエストする必要はありません。
         自然に発生するものです。
         リンクをピン留めすることは、Shared with Youでコンテンツを表示するための暗黙の許可です。
         ピン留めされたコンテンツは、アプリ内のShared with Youで常に利用できます。
         アプリのコンテンツがメッセージにピン留めされると、ヒューリスティックに基づき、自動共有を有効にするオプションが表示されます。
         自動共有がオンになっている場合、さらなるコンテンツが自動的に「Shared with You」で利用できるようになります。
        Shared with Youのコンテンツは順番に並んでいます。
         Shared with Youの棚の最初のアイテムは、システムからのさまざまなシグナルに基づいてSiri Suggestionsがキュレーションしたものです。
         その後にピン留めされたアイテムが続き、残りのリストは時系列で並びます。
        Siri Suggestionsは、"ユーザーがそのコンテンツを見たか、または対話したか "といったシグナルを使用します。そのコンテンツはピン留めされていますか？コンテンツはどのような文脈で提示されているか？このフィードバックには、アプリが一役買っています。
         詳しくは、このビデオの後半で少し説明します。
         これらはすべて、コンテンツがあまりに一時的で陳腐化しないようにするために行われます。
         リンクが複数回共有された会話では、Shared with Youは最新のメッセージのみを表示します。
         複数のメッセージの会話でリンクが共有されると、Shared with Youはアトリビューションビューでそれを視覚的に表現します。
         たとえば、EnriqueとSarahの両方がTop 25 Chicagoプレイリストを共有しているとします。
         アトリビューには、2人の連絡先アバターが表示されます。
         このアトリビューをタップすると、曖昧さ回避のためのメニューが表示され、どちらのメッセージに返信するか選択することができます。
         Shared with Youの設計では、セキュリティとプライバシーを第一に考慮し、重視しています。
         属性ビューと曖昧さ回避ビューは、プロセスの外であなたに代わって描画されます。
         Shared with Youは、ユニバーサルリンクの関連付けによってアプリケーションのコンテンツを保護し、アプリケーションのみがアクセスできるようにしています。
         アプリは、メッセージの受信者や会話にアクセスできません。
        これで、Shared with Youの仕組みはお分かりいただけたと思います。
         次は、あなたのアプリでShared with Youを採用する方法です。
         まず、Universal Linksを採用します。
         次に、XcodeのCapabilitiesタブで新しいShared with You Capabilityを追加します。
         そして、アプリにShared with Youの棚を設置し、コンテンツにアトリビューションビューを追加します。
         ユニバーサルリンクの採用について簡単に説明します。
        ユニバーサルリンクを使用すると、ユーザーは、アプリ内のコンテンツやウェブサイトへのリンクをインテリジェントにたどることができます。
         ユニバーサルリンクに対応するために、以下のステップを踏みます。
         まず、アプリとWebサイトの間に双方向の関連付けを作成し、アプリが扱うURLを指定します。
         アプリにAssociated Domains権限を追加し、JSONファイルをWebサーバーに追加することで、これらを作成します。
         次に、アプリのデリゲートを更新して、ユニバーサルリンクがアプリにルーティングするときにシステムが提供するユーザーアクティビティオブジェクトに応答するようにします。
         詳細については、「ユニバーサルリンクの新機能」ビデオをご覧ください。
         iOS 16 では、Shared with You と呼ばれる新しい Framework を導入しました。
         Shared with You Frameworkには、3つの主要なクラスがあります。SWHighlightCenter、SWHighlight、そしてSWAttributionViewです。
         SWHighlightCenterは、アプリにShared with Youのコンテンツを取得するためのクラスです。
         SWHighlightは、アプリのSharedコンテンツをラップするモデルオブジェクトです。
         SWAttributionView は、コンテンツを Messages の会話に関連付け、アトリビューション情報を表示するためのビューです。
        ハイライトセンターは、以下のようなシンプルなオブジェクトで構成されています。ハイライトは、SWHighlightオブジェクトの配列と、Shared with Youによって追加、削除、更新されたコンテンツがあるときにアプリに通知されるデリゲートプロパティで構成される単純なオブジェクトです。
         ハイライトはSWHighlightクラスで表現されます。
         これは、メッセージで共有されたアプリのコンテンツのURLを渡すために使用されます。
         これを利用して、コンテンツの参照、リッチプレビューのレンダリング、アプリ内のコンテンツへのナビゲーションを行います。
         アプリ内のShared with Youコンテンツを列挙する方法を説明します。
        まず、SWHighlightCenter のインスタンスを作成します。
         次に、デリゲートプロパティを設定します。
         SWHighlightCenterDelegate メソッドを実装します。
         ハイライトセンターの highlights プロパティを使用して、アプリの Shared with You コンテンツにアクセスします。
         アプリは前回のハイライトリストを保持することで、最新のハイライトリストとの差分を素早く取得することができます。
        各ハイライトの URL プロパティを使用して、アプリのコンテンツの Rich プレビューを生成します。
         このように、アプリ内のShared with Youコンテンツを簡単に列挙することができます。
         次に、アプリの Shared with You コンテンツに Attribution View を追加してカスタマイズする方法を説明します。
         SWAttributionViewは、コンテンツを共有した人の名前とアバターが表示されるビューです。
         各ハイライトには、対応するアトリビューションビューがあります。
         アトリビューにハイライトのプロパティを設定することで、アトリビューション情報がアウトオブプロセスでレンダリングされます。
        アトリビューの最大幅を指定します。
         アトリビューは、必要に応じてスペースを埋めたり、合わせたりします。
         アトリビューのアラインメントを最大スペース内に設定します。
         例をお見せしましょう。
        SWAttributionViewのインスタンスを作成し、highlightプロパティを設定します。
         preferredMaxLayoutWidthを設定します。
         この例では、共有コンテンツのサムネイルの下をまたいでいます。
         このビューの幅アンカーを拘束するか、そのフレーム幅を設定して、そのコンテンツの最大幅を制御します。
         UIViewのminimumContentSizeCategory、maximumContentSizeCategoryプロパティで、必要に応じてビューの最大AXコンテンツサイズカテゴリを設定してください。
         このビューの周囲に十分な垂直方向のスペースを確保します。
         ビューの高さは、preferredContentSizeCategoryと、その結果のフォントサイズに依存します。
         ビューの高さが不必要に制約されている場合、ビューはクリップされるか、または描画されないかもしれません。
         この場合、horizontalAlignmentはleadingに設定されます。
         CenterやTrailingに設定することも可能です。
         次に、アトリビューションビューをカスタマイズする方法を紹介します。
         表示コンテキストを設定することで、ユーザーがどのようにアトリビューションコンテンツを消費しているかをシステムに通知することができます。
         また、アプリのShared with Youコンテンツのランキングに影響します。
         ウィンドウに追加される前に、これを設定します。
         アトリビューの背景スタイルは、使用されるコンテンツの背景に基づいてカスタマイズできます。
         例を挙げて説明します。
         displayContextプロパティのデフォルト値はsummaryです。
         これは、コンテンツが消費のために表示されていることを示します。
         映画を見たり、ポッドキャストを聞いたりするように、ユーザーが積極的にコンテンツを消費する場合は、displayContextをdetailに設定します。
         displayContextを設定することで、アプリが提供できるフィードバックがあります。
         これは、Siri Suggestionsがあなたのアプリにコンテンツをランク付けするのに役立ちます。
         この例のように、モノクロの背景の上にアトリビューを配置する場合は、アトリビューの背景のスタイルをカラーに設定します。
         色とりどりの背景の上にアトリビューを配置する場合は、マテリアルを使用します。
         これにより、ビューのコンテンツにマテリアル背景のぼかしが設定されます。
         この例では、Safariのランディングページには背景画像があります。
         正しい背景スタイルを設定することで、アトリビューのコンテンツがより見やすくなります。
         次に、アプリのコンテンツにShared with Youコンテクストメニューを追加し、タイトルをカスタマイズする方法を紹介します。
         アプリのコンテンツに付いている既存のコンテクストメニューは、アトリビューのメニューで補完することができます。
         このメニューは、補強するコンテクストメニューのインラインまたは末尾に追加する必要があります。
         コンテキストメニューの削除オプションのカスタムタイトルを指定することができます。
         この文字列には、正しくローカライズされた「削除」という単語が含まれている必要があります。
         この例では、SafariはRemoveメニューのタイトルを、コンテンツのコンテキストメニューの最後にある「リンクを削除する」にカスタマイズしています。
         例によって、この方法を紹介しましょう。
         まず、attributionビューのインスタンスを作成し、highlightプロパティを設定します。
         menuTitleForHideAction を使って、Remove コンテキストメニューのカスタムタイトルを設定します。
         コンテンツのコンテキストメニューを設定する場合、attribution ビューから supplementalMenu プロパティを使用してメニューを取得します。
         そして、それらをコンテンツのコンテキストメニューに追加します。
         これらの簡単な手順で、アトリビューで利用可能なコンテキストメニューオプションを、コンテンツのコンテキストメニューに追加することができます。
         これで、Shared with Youをアプリに採用するために必要なことは、すべてわかりました。
         アプリにShared with Youを採用するための3つの簡単なステップを、もう一度おさらいしておきましょう。
         Universal Linksを採用します。
         次に、あなたのアプリのXcodeで新しいShared with You Capabilityを追加します。
         新しいShared with Youフレームワークをインポートして使用する。
         メッセージであなたのコンテンツを共有し、あなたのアプリでShared with Youを使用することを楽しみにしています。
         お時間をいただき、ありがとうございました。

        
        """
    }
}

