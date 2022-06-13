import Foundation

struct ComplicationsAndWidgetsReloaded: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Complications and widgets: Reloaded"
    }

    var description: [String] {
        WWDCFormatter.convertString(item: self)
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10050/")!
    }

    var english: String {
        """
        Hi! My name is Devon.
         I'm an engineer on the watchOS team, and today, I'll be talking about iOS.
         And I'm Graham, an engineer from iOS, and today, I'll be talking about watchOS.
         We'll be talking about API additions to WidgetKit that enable you to write accessory widgets for the Lock Screen and complications for watchOS.
         We'll show how you can develop both together, along with additions to SwiftUI to help you along the way.
         If you're unfamiliar with widgets, timelines, and reloading, I encourage you to seek out prior WidgetKit sessions.
         First, we'll talk about the history of complications and how they've evolved.
         Then, we'll talk about new API to color your widgets and complications in their new environments.
         After that, Graham will demo how to get started making your own widgets and moving your existing widget extension to watchOS.
         Next, Graham will walk you through how to make the most of these smaller views.
         And lastly, we'll talk about the different privacy environments your widgets may appear in.
         Complications are a key piece of the watchOS platform, presenting quick, glanceable information on the watch face.
         They convey immediately accessible, high-value information and a tap takes you to the relevant location in the app.
         In watchOS 2, ClockKit enabled you to create your own complications.
         Complications have come a long way since then.
        Rich complications were introduced in watchOS 5, with graphic content and a suite of new families.
         SwiftUI complications and multiple complications were introduced in watchOS 7, which enabled you to take your complications to the next level and provide more options than ever.
         Today, complications have been reimagined and remade with WidgetKit, embracing SwiftUI and bringing the glanceable complication experience to iOS in the form of widgets.
         With WidgetKit in iOS 16 and watchOS 9, you can build great glanceable widgets and complications across both platforms, enabling you to write your code once and share infrastructure with your existing Home Screen widgets.
         To do this, we've added new widget families to the existing WidgetFamily type, prefixed with the word "accessory.
        " The new accessoryRectangular family can be used to show multiple lines of text or small graphs and charts, similar to the existing ClockKit graphicRectangular family.
         The accessoryCircular family is great for brief information, gauges, and progress views.
         This family also replaces the graphicCircular ClockKit family.
         The all-new accessoryInline is a text-only slot present on many faces on watchOS and above the time on iOS.
         The inline slot comes in many sizes, and we'll talk about how to make the best use of them all later on.
        Specific to watchOS is the new accessoryCorner family, mixing a small circle of widget content with gauges and text.
         This talk focuses on families common between iOS and watchOS.
         For more details on this new watchOS family and complication-specific features, check out the "Go further with WidgetKit complications" session.
         Let's talk about colors and rendering modes.
         You may have noticed that accessory widgets take on a few different appearances.
         The system controls the look of accessory family widgets, and we've given you some tools to help adapt them to the rendering style.
         There are three different rendering modes your widget may be shown in.
         Your widget can be full color, accented, or vibrant.
         We've introduced the WidgetRenderingMode type to represent these three different presentations.
         You can access this value from the Environment, using the widgetRenderingMode keypath.
         After that, you can change your content conditionally to make sure it looks just right everywhere that it'll show up.
         In watchOS's full-color mode, your content is displayed exactly as you specify.
         Many existing complications take on a colorful appearance in full color, like the gradient in Weather's gauges, or the Activity rings' colors.
         In the accented rendering mode, your views are split into two groups and colored independently.
         The two coloring groups are flatly colored, preserving only their original opacities.
         You can tell the system how to group your views with the .
        widgetAccentable() view modifier, or switch out your content based on the Widget Rendering Mode environment value to look perfect when flattened.
         Note that the system can tint your content in a number of ways, some of which are inverted.
         Some are on a black background, while others are on the new full-color backgrounds in watchOS 9.
         In the iOS vibrant rendering mode, your content is desaturated then colored appropriately for the Lock Screen background.
         The system maps your greyscale content in to a material appearance.
         This material is adaptive to the content behind it, appearing just right in its environment.
         Additionally, the Lock Screen can be configured to give the vibrant rendering mode a colored tint.
         A light source color ends up mostly opaque and brighter.
         On the other end, a dark source color appears as a less prominent blur of the background behind it, with only a slight amount of brightening.
         To ensure legibility, avoid using transparent colors in this mode.
         Instead, use darker colors or black to represent less prominent content while maintaining legibility.
         To help you with some of this nuance, we've also introduced the AccessoryWidgetBackground view to give a consistent backdrop to widgets that need them, like this circular calendar.
         While most accessory widgets have no background, some styles can be enhanced with one.
         The background view takes on different appearances in the various widget rendering modes and is tuned by the system to look right for the style of the face or Lock Screen.
         This is a soft transparent view in full color and accented, and black in the vibrant environment, which results in a low brightness and full blur.
         Graham is super excited to get started making some new widgets for the Lock Screen and complications on watchOS -- I'll hand it off to him.
         Hi again! I'll be adding support for our new widget families to an existing app -- Emoji Rangers -- which some of you might be familiar with from WWDC2020's "Widgets Code-along.
        " Before I begin, a note for those with existing widget-free projects.
         You can get started by adding the Widget Extension target to your project, which already exists on iOS and has been brought to watchOS.
         But I know that many of you have apps with widgets already, so today let's start there and talk about adding new widgets and complications.
        We'll continue the Emoji Rangers project.
         This app keeps track of our favorite Emoji Rangers and keeps you up to date with their health and recharge time with the use of Home Screen widgets.
         We've already brought Emoji Rangers over to watchOS, bringing our favorite app to our wrists.
         Today we'll be extending Emoji Rangers with support for our new widget families and bringing its widget extension to the watch.
         Let's get started with getting the widget extension onto the watch.
         We'll add a new watchOS target that shares code with the existing iOS target.
         We'll duplicate the iOS widget extension target, give it a better name, change the bundle identifier to be prefixed with the watch app's, target watchOS, and embed our new extension in our watch app.
        Now we need to get our code building on watchOS -- let's get on with that.
        Glancing through the EmojiRangerWidget code, we can see the timeline provider, which is used when the system reloads content, the view which uses SwiftUI to generate content for our different families, the widget configuration, and the Xcode preview provider.
         The Emoji Rangers app already supports iOS Home Screen widgets.
         It offers the system small and medium families, and here in the widget configuration, I'm going to add the new families.
        Because system families are unavailable on the watch, we'll need to use a platform macro to specify our supportedFamilies.
        In the preview provider, I'm going to add previews for the new families.
        Next, we need to implement the new IntentRecommendation API before we can successfully build for watchOS.
         While Intents are fully configurable in the widgets editing UI on iOS, on watchOS, we need to provide a preconfigured list.
         We can do that by overriding the new recommendations method on our IntentTimelineProvider.
        Now we're building successfully.
         Let's resume the previews and see what our circular widget looks like.
        The content intended for even a small widget doesn't fit well inside our new form factor.
         The new widget families are smaller than iOS widgets found on the Home Screen, and you'll need to consider the content of your complications.
         Now let's talk about some new views we can use to make our complications stand out.
         Let's go to the view.
         We can see code for the systemSmall and other widgets; let's add code for the accessoryCircular case.
         I think it would look good just with the avatar.
        This provides a quick shortcut in to our app but doesn't offer users any information.
         Let's add a progress view around the edge, which will give the users an idea of when the Ranger will be ready for combat again.
        Trouble is animating this progress view to be current will require a lot of timeline entries in short succession.
         Instead, we can use SwiftUI's new auto-updating ProgressView.
         That takes a date interval over which our Ranger will be fully healed.
         The system will keep our progress view updated, meaning we only need one timeline entry here.
        Much better.
         Now let's add the rectangular family.
        We'll select the rectangular preview.
         This gives us more space, so we'll make a three-line view in the style of a complication.
         First the character's name, then their level, and then the time until fully healed, for which we'll use an auto-updating date field.
         I'd like the character's name to stand out, so I'll size the text, using a font style of headline, and add the widgetAccentable modifier which will adjust its color.
        Our view looks great here in vibrant, now let's see how it looks in our other rendering modes on the watch.
        You can see how the character's name takes on the accent color.
         To make your widgets and complications feel at home in their environment, it's important that you use the default font parameters and make use of font styles.
         The font styles and sizes are different between iOS and watchOS.
         iOS uses the regular text design, while watchOS uses a rounded design with a heavier weight.
         Your widgets and complications will sit onscreen adjacent to others.
         And so they look consistent, we recommend using the font styles Title, Headline, Body, and Caption.
        Xcode's preview shows we still have room leftover to add the avatar too.
        Let's see how this looks on the iPhone.
        That looks great! Finally, let's add the third style, accessoryInline, which displays a line of text and optionally an image.
         Note that inline accessories are drawn according to system-defined coloring and font.
         Let's select the preview.
        Let's show our hero's name and recharge countdown.
        This text is too long for our watch slot.
         So now's a good time to show you ViewThatFits.
         I can supply multiple views, from lengthy to concise, and ViewThatFits will choose the first content view that fits the available space without truncation or clipping.
         Let's shorten the text.
        Even that might be too long for the shortest watch slot, so let's offer a third alternative by switching out the avatar for the name.
        Let's see what that looks like.
        Refer to the "Compose Custom layouts with SwiftUI" session for more about this.
         Awesome! Even Emoji Rangers like to enjoy some privacy, so I'll hand it back to Devon to talk about that.
         Hello again! Let's talk about privacy.
         So far in this talk, we've discussed the active state of your widgets and complications.
         However, across our platforms, you'll need to consider whether the device is redacting content or in a low-luminance state.
         On the iOS Lock Screen, the default behavior is to show your content even while the device is locked, which is the top-left cell in our grid here.
         However, this is configurable in Settings, and users can choose to redact their widget when locked, much like Notifications.
         On watchOS, the device stays unlocked as long as the watch is being worn.
         When inactive, the watch transitions into always-on, with content in a low-luminance presentation and a lower update cadence.
         By default, your content is not redacted in low luminance, which is the state on the bottom left.
         Like the Lock Screen, your users can configure their complication content to be redacted in this always-on state.
         In this state, you'll need to make sure your content is prepared for both redaction and low luminance.
         Together, the platforms cover each of the four states shown here.
         Consider all these possible states and ensure your complications and widgets work well in all cases.
         Let's talk about how you can do that.
         On the watch, your widget needs to support the always-on display experience.
         You can adapt your content for always-on with the isLuminanceReduced environment value.
         If you're coming from ClockKit, note that you now can prepare always-on content for every timeline entry, not just one.
         When in always-on, your time-relative text and progress views will change to a reduced fidelity mode to support the low update cadence of always-on.
         To support this mode, use the environment value to remove any time-sensitive content and optimize your content for the lower update frequency.
         Now let's talk about redaction.
         By default, the privacy mode will show a redacted version of the placeholder view your TimelineProvider creates.
         If you have some elements that are sensitive and others that don't need to be redacted, you can use the .
        privacySensitive modifier to mark only some of the views to be redacted.
         In this example, we've redacted the heart rate in our widget but left the image unredacted.
         Now you're ready to make awesome widgets for the Lock Screen and WidgetKit complications.
         For more on what's new in SwiftUI, check out the "Compose Custom Layouts with SwiftUI" talk.
         Thanks for watching.
        """
    }

    var japanese: String {
        """
        こんにちは! 私はデボンです。
         watchOSチームのエンジニアで、今日はiOSについて話します。
         そして私はiOSのエンジニア、グラハムです！今日はwatchOSについてお話します。
         WidgetKitに追加された、watchOSのロック画面やコンプリケーション用のアクセサリウィジェットを書くことができるAPIについてお話します。
         どのように両方を一緒に開発することができるかを、途中であなたを助けるために SwiftUI に追加されたものと一緒にお見せします。
         ウィジェット、タイムライン、およびリロードに慣れていない場合は、以前の WidgetKit のセッションを検索することをお勧めします。
         まず、コンプリケーションの歴史と、コンプリケーションがどのように進化してきたかについて話します。
         そして、ウィジェットとコンプリケーションを新しい環境で彩るための新しいAPIについて説明します。
         その後、Grahamが独自のウィジェットの作成と既存のウィジェット拡張機能のwatchOSへの移行を開始する方法をデモで紹介します。
         次に、Grahamは、これらの小さなビューを最大限に活用する方法について説明します。
         そして最後に、ウィジェットが表示されるさまざまなプライバシー環境について説明します。
         コンプリケーションは、watchOSプラットフォームの重要な要素であり、時計の文字盤上に素早く、一目でわかる情報を表示します。
         コンプリケーションは、すぐにアクセスできる価値の高い情報を提供し、タップするとアプリ内の関連する場所に移動します。
         watchOS 2では、ClockKitによって独自のコンプリケーションを作成できるようになりました。
         それ以来、コンプリケーションは大きく進化してきました。
        watchOS 5では、グラフィックコンテンツと一連の新しいファミリーを備えたリッチコンプリケーションが導入されました。
         SwiftUI のコンプリケーションと複数のコンプリケーションは watchOS 7 で導入され、コンプリケーションを次のレベルに引き上げ、これまで以上に多くのオプションを提供することができるようになりました。
         今日、コンプリケーションはWidgetKitで再構築され、SwiftUIを採用し、一目でわかるコンプリケーション体験をウィジェットという形でiOSにもたらしました。
         iOS 16とwatchOS 9のWidgetKitを使用すると、両方のプラットフォームで優れた一目でわかるウィジェットとコンプリケーションを構築でき、コードを一度書いて、既存のホーム画面ウィジェットとインフラを共有することが可能になります。
         これを実現するために、既存のWidgetFamilyタイプに、"accessory "という接頭語を持つ新しいウィジェットファミリーを追加しました。
        " 新しい accessoryRectangular ファミリーは、既存の ClockKit graphicRectangular ファミリーと同様に、複数行のテキストや小さなグラフやチャートを表示するために使用できます。
         accessoryCircular ファミリーは、簡単な情報、ゲージ、進捗状況表示などに最適です。
         このファミリは、ClockKitのgraphicCircularファミリも置き換えます。
         全く新しい accessoryInline は、watchOS では多くの文字盤に、iOS では時刻の上に表示されるテキストのみのスロットです。
         インラインスロットは様々な大きさがあり、それらを最大限に活用する方法については後ほど説明します。
        watchOSに特有なのは、新しいaccessoryCornerファミリーで、ウィジェットの小さな円形コンテンツとゲージやテキストが混在しています。
         本講演では、iOSとwatchOSで共通するファミリーに焦点を当てます。
         この新しいwatchOSファミリーやコンプリケーション特有の機能の詳細については、「Go further with WidgetKit complications」セッションをご覧ください。
         色とレンダリングモードについて説明します。
         アクセサリーウィジェットがいくつかの異なる外観をとることにお気づきかもしれません。
         アクセサリ系列のウィジェットの外観はシステムで制御されますが、レンダリングスタイルに合わせるためのツールをいくつか紹介します。
         ウィジェットの表示には、3つの異なるレンダリングモードがあります。
         ウィジェットは、フルカラー、アクセントカラー、ビビッドカラーの3種類で表示されます。
         これらの 3 つの異なる表示を表すために、WidgetRenderingMode タイプを導入しました。
         この値には、環境から widgetRenderingMode キーパスでアクセスできます。
         その後、コンテンツを条件付きで変更し、表示されるすべての場所で正しく表示されるようにすることができます。
         watchOSのフルカラーモードでは、コンテンツはあなたが指定したとおりに表示されます。
         天気予報のゲージのグラデーションやアクティビティリングの色など、既存の多くのコンプリケーションがフルカラーでカラフルに表示されます。
         アクセント付きレンダリングモードでは、ビューが2つのグループに分割され、それぞれ独立して着色されます。
         2つの着色グループは、元の不透明度のみを保持して平坦に着色されます。
         ビューをグループ化する方法は、.NET Framework 2.0を使用してシステムに指示することができます。
        widgetAccentable()ビュー修飾子でビューのグループ化をシステムに指示するか、またはWidget Rendering Mode環境値に基づいてコンテンツを切り替えて、平坦化したときに完璧に見えるようにすることができます。
         システムは、いくつかの方法でコンテンツを着色することができ、そのうちのいくつかは反転していることに注意してください。
         黒い背景のものもあれば、watchOS 9の新しいフルカラー背景のものもあります。
         iOSの鮮やかなレンダリングモードでは、コンテンツは脱色された後、ロック画面の背景に合わせて適切に色付けされます。
         グレイスケールのコンテンツは、システムによってマテリアルアピアランスにマップされます。
         この素材は、背後にあるコンテンツに適応し、その環境にちょうどよく表示されます。
         さらに、鮮やかなレンダリングモードに色味を持たせるように、ロック画面を設定することもできます。
         光源色は、ほとんど不透明でブリッグに終わります。
        一方、暗いソースカラーは、背後の背景のぼかしが目立たなくなり、ほんの少し明るくなった程度にしか見えません。
         読みやすさを確保するために、このモードでは透明な色の使用は避けてください。
         代わりに、濃い色や黒を使って、可読性を維持しつつ、あまり目立たないコンテンツを表現してください。
         このようなニュアンスを表現するために、AccessoryWidgetBackgroundビューを導入し、円形カレンダーのような背景が必要なウィジェットに一貫した背景を与えることができるようになりました。
         ほとんどのアクセサリウィジェットには背景がありませんが、いくつかのスタイルでは背景を追加することができます。
         背景ビューは、さまざまなウィジェットレンダリングモードで異なる外観になり、顔またはロック画面のスタイルに適した外観になるようにシステムによって調整されます。
         これは、フルカラーでアクセントのあるソフトな透明ビューであり、鮮やかな環境ではブラックとなり、低輝度と完全なブラーを実現します。
         グラハムは、watchOSのロック画面とコンプリケーションのための新しいウィジェットを作り始めることに超興奮しています -- 彼に譲りますね。
         こんにちは。WWDC2020の "Widgets Code-along "でおなじみのEmoji Rangersという既存のアプリに、新しいウィジェットファミリーのサポートを追加する予定です。
        " 始める前に、既存のウィジェットなしのプロジェクトを持っている人への注意事項です。
         iOSではすでに存在し、watchOSにも導入されているWidget Extensionターゲットをプロジェクトに追加することで、始めることができます。
         しかし、すでにウィジェットを使ったアプリをお持ちの方も多いと思いますので、今日はそこから始めて、新しいウィジェットの追加やコンプリケーションについてお話ししましょう。
        引き続き、「絵文字レンジャー」プロジェクトを紹介します。
         このアプリは、私たちのお気に入りの絵文字レンジャーを記録し、ホーム画面のウィジェットを使って、彼らの健康状態や充電時間を知らせてくれます。
         私たちはすでに絵文字レンジャーをwatchOSに移植し、私たちのお気に入りのアプリを手首に運んできました。
         今日、私たちはEmoji Rangersを新しいウィジェットファミリーのサポートで拡張し、そのウィジェット拡張を腕時計にもたらす予定です。
         まずは、ウィジェットエクステンションを時計に取り込むところから始めましょう。
         既存のiOSターゲットとコードを共有する新しいwatchOSターゲットを追加します。
         iOS のウィジェット拡張ターゲットを複製し、より良い名前を付け、バンドル識別子を時計アプリのプレフィックスに変更し、watchOS をターゲットとし、新しい拡張機能を時計アプリに埋め込みます。
        あとは、watchOS上でコードをビルドする必要があります。
        EmojiRangerWidget のコードをちらっと見ると、システムがコンテンツを再ロードするときに使用するタイムラインプロバイダ、異なる家族のためにコンテンツを生成するために SwiftUI を使用するビュー、ウィジェットの設定、Xcode プレビュープロバイダを見ることができます。
         絵文字レンジャーのアプリは、すでにiOSのホーム画面ウィジェットをサポートしています。
         システムの小ファミリーと中ファミリーを提供していますが、ここのウィジェット設定で、新しいファミリーを追加することにします。
        システムファミリは時計では利用できないので、プラットフォームマクロを使用してsupportedFamiliesを指定する必要があります。
        プレビュープロバイダでは、新しいファミリのプレビューを追加するつもりです。
        次に、watchOS 用のビルドを成功させる前に、新しい IntentRecommendation API を実装する必要があります。
         iOS では Intent はウィジェット編集 UI で完全に設定可能ですが、watchOS では事前に設定されたリストを提供する必要があります。
         IntentTimelineProvider の new recommendations メソッドをオーバーライドすることで、それが可能になります。
        これで、ビルドが成功しました。
         プレビューを再開して、私たちの円形ウィジェットがどのように見えるか見てみましょう。
        小さなウィジェットのために意図されたコンテンツでさえ、新しいフォームファクターにうまく収まりません。
         新しいウィジェットファミリーは、ホーム画面にある iOS ウィジェットよりも小さいので、複雑な内容を検討する必要があります。
         それでは、コンプリケーションを目立たせるために使える新しいビューについて説明します。
         ビューに移動してみましょう。
         systemSmallなどのウィジェットのコードが見えますが、accessoryCircularのケースのコードを追加してみましょう。
         アバターがあるだけで見栄えが良くなると思います。
        これは、アプリへのクイックショートカットを提供しますが、ユーザーには何も情報を提供しません。
         そこで、レンジャーがいつ戦えるようになるのか、進捗状況を表示させることにしましょう。
        問題は、この進行状況をアニメーションで表示するには、短時間で多くのタイムラインエントリーが必要になることです。
         その代わりに、SwiftUIの新しい自動更新のProgressViewを使用することができます。
         これは、Rangerが完全に回復するまでの日付間隔を取ります。
         システムはプログレスビューを更新し続けるので、ここでは1つのタイムラインエントリーが必要なだけです。
        とても良いことです。
         では、長方形のファミリーを追加してみましょう。
        長方形のプレビューを選択します。
         これでスペースに余裕ができたので、こじつけ風に3行表示にしてみます。
         まず、キャラクターの名前、レベル、完治までの時間、これは自動更新の日付フィールドを使います。
         キャラクターの名前を目立たせたいので、文字のサイズを大きくして、フォントスタイルを見出しにし、widgetAccentableモディファイアを追加して、次のようにします。
        ここでは鮮やかな色で表示しましたが、時計の他のレンダリングモードでどのように見えるか見てみましょう。
        キャラクターの名前がアクセントカラーになっているのがわかると思います。
         ウィジェットやコンプリケーションが環境になじむようにするには、デフォルトのフォントパラメータを使用し、フォントスタイルを利用することが重要です。
         iOSとwatchOSでは、フォントスタイルとサイズが異なります。
         iOSは通常のテキストデザインを使用し、watchOSは重めのウェイトで丸みを帯びたデザインを使用しています。
         ウィジェットやコンプリケーションは、画面上で他のものと隣り合って配置されます。
         そのため、フォントスタイルTitle、Headline、Body、Captionを使用することをお勧めします。
        Xcodeのプレビューでは、まだアバターを追加するスペースが残っています。
        では、iPhoneで見てみましょう。
        いい感じですね。最後に、3つ目のスタイル、accessoryInlineを追加してみましょう。
         インラインアクセサリーは、システムで定義されたカラーリングとフォントにしたがって描画されることに注意してください。
         プレビューを選択してみましょう。
        ヒーローの名前と充電のカウントダウンを表示しましょう。
        このテキストはウォッチスロットには長すぎます。
         そこで、今こそViewThatFitsを見せる良い機会です。
         長いものから簡潔なものまで、複数のビューを指定すると、ViewThatFits は、切り捨てたり切り取ったりせずに、利用可能なスペースに収まる最初のコンテンツビューを選択します。
         テキストを短くしてみましょう。
        アバターと名前を入れ替えることで、第三の選択肢を提供しましょう。
        どのように見えるか見てみましょう。
        これについては、「SwiftUIでカスタムレイアウトを作成する」セッションを参照してください。
         すごい! 絵文字レンジャーでさえ、プライバシーを楽しみたいので、それについてはDevonにバトンタッチします。
         またまたこんにちは! プライバシーについて話しましょう。
         これまで、ウィジェットのアクティブな状態やコンプリケーションについて説明してきました。
         しかし、私たちのプラットフォーム全体では、デバイスがコンテンツを冗長化しているか、低輝度状態であるかを考慮する必要があります。
         iOSのロック画面では、デバイスがロックされている間でもコンテンツを表示するのがデフォルトの動作で、このグリッドの左上のセルがそうなっています。
         しかし、これは「設定」で設定可能であり、ユーザーはロック中にウィジェットを再表示することを選択でき、これは「通知」と同様です。
         watchOSの場合、デバイスは、ウォッチが装着されている限り、ロックされていない状態を維持します。
         非アクティブ時には、常時オンに移行し、コンテンツは低輝度の表示で、更新頻度も低くなります。
         デフォルトでは、低輝度のコンテンツは編集されず、左下の状態になります。
         ロック画面と同様に、ユーザーはこの常時表示状態で複雑なコンテンツが朱書きされるように設定することができます。
         この状態では、コンテンツが再編集と低輝度の両方に対応していることを確認する必要があります。
         このように、プラットフォームはここに示した4つの状態のそれぞれをカバーしています。
         これらの可能性のある状態をすべて考慮し、あなたのコンプリケーションとウィジェットがすべてのケースでうまく機能するようにしましょう。
         では、その方法について説明します。
         時計では、ウィジェットが常時表示エクスペリエンスをサポートする必要があります。
          常時表示用にコンテンツを適応させるためには isLuminanceReduced環境値でコンテンツを常時点灯に適合させることができます。
         ClockKitから来た場合は、1つのタイムラインエントリーだけでなく、すべてのタイムラインエントリーに常時表示コンテンツを準備できるようになったことに注意してください。
         常時接続の場合、時間軸のテキストと進捗表示は、常時接続の低い更新周期をサポートするために、忠実度を下げたモードに変更されます。
         このモードをサポートするには、環境値を使用して、時間の影響を受けやすいコンテンツを削除し、低い更新頻度に合わせてコンテンツを最適化します。
         次に、リダクショ ンについて説明します。
         デフォルトでは、プライバシーモードは TimelineProvider が作成するプレースホルダービューの編集されたバージョンを表示します。
         もし、機密性の高い要素とそうでない要素がある場合、.privacySensitive修飾子を使うことで、redactedする必要がない要素をマークすることができます。
        privacySensitive修飾子を使い、一部のビューだけを編集するようにマークすることが出来ます。
         この例では、ウィジェットの心拍数を編集し、画像は編集しないままにしています。
         これで、ロック画面とWidgetKitのコンプリケーション用の素晴らしいウィジェットを作成する準備が整いました。
         SwiftUIの新機能の詳細については、「SwiftUIでカスタムレイアウトを構成する」のトークをご覧ください。
         ご視聴ありがとうございました。
        """
    }
}
