import Foundation

struct AddLiveTextInteractionToYourApp: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Add Live Text interaction to your app"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6519/6519_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10026/")!
    }

    var english: String {
        """
        Hi! My name is Adam Bradford.
         I'm an engineer on the VisionKit team, and if you're looking to add Live Text to your app, you're in the right place.
         But first, what is Live Text? Live Text analyzes an image and provides features for the users to interact with its content, such selecting and copying text, perform actions like lookup and translate, providing data-detection workflows, such as mapping an address, dialing a number, or jumping to a URL.
         Live Text even allows for QR code interaction.
         Imagine how you could put this to use in your app? You want to know more? Well, you're in the right place.
         For this session, I'm going to start with a general overview of the Live Text API.
         Then I will explore how to implement this API in an existing application.
         Next, I will dive into some tips and tricks which may help you when adding Live Text to your app.
         Now for an overview of the Live Text API.
         At a high level, the Live Text API is available in Swift.
         It works beautifully on static images and can be adapted to be used for paused video frames.
         If you need to analyze video in a live camera stream to search for items like text or QR codes, VisionKit also has a data scanner available.
         Check out this session from my colleague Ron for more info.
         The Live Text API is available starting on iOS 16 for devices with an Apple Neural Engine, and for all devices that support macOS 13.
         It consists of four main classes.
         To use it, first, you'll need an image.
         This image is then fed into an ImageAnalyzer, which performs the async analysis.
         Once the analysis is complete, the resulting ImageAnalysis object is provided to either an ImageAnalysisInteraction or ImageAnalysisOverlayView, depending on your platform.
         Seems pretty straightforward so far, right? Now, I'm going to demonstrate how one would add it to an existing application.
         And here's our application.
         This is a simple image viewer, which has an image view inside of a scroll view.
         Notice, I can both zoom and pan.
         But try as I might, I cannot select any of this text or activate any of these data detectors.
         This simply will not do.
         Here's the project in Xcode.
         To add Live Text to this application, I'll be modifying a view controller subclass.
         First, I'm going to need an ImageAnalyzer, and an ImageAnalysisInteraction.
         Here, I'm simply overriding viewDidLoad and adding the interaction to the imageview.
         Next, I need to know when to perform the analysis.
        Notice that when a new image is set, I first reset the preferredInteractionTypes and analysis which were meant for the old image.
         Now everything is ready for a new analysis.
         Next, I'm going to create the function we will use and then check that our image exists.
        If so, then create a task.
         Next, create a configuration in order to tell the analyzer what it should be looking for.
         In this case, I'll go with text and machine-readable codes.
         Generating the analysis can throw, so handle that as appropriate.
         And now finally, I'm ready to call the method analyzeImageWithConfiguration, which will start the analysis process.
         Once the analysis is complete, an indeterminate amount of time has passed, and the state of the application may have changed, so I will check that both the analysis was successful and that the displayed image has not changed.
         If all of these checks pass, I can simply set the analysis on the interaction and set the preferredInteractionTypes.
         I'm using .
        automatic here, which will give me the default system behavior.
         I think this is ready for a test.
         Oh, look at that! I see the Live Text button has appeared, and yep, I can now select text.
         Notice how these interface elements are positioned for me automatically, and keep their position inside of both the image bounds and the visible area, with no work on my part.
         OK, notice that tapping the Live Text button will both highlight any selectable items, underline data detectors, and show Quick Actions.
         I can easily tap this Quick Action to make a call, and even see more options by long-pressing.
         You have to admit, this is pretty cool.
         With just these few lines of code, I've taken an ordinary image and brought it to life.
         This simple application now has the ability to select text on images, activate data detectors, QR codes, lookup, translate text, and more.
         Not too shabby from just this few lines of code, if you ask me.
         And now that you've have seen how to implement Live Text, I'm going to go over a few tips and tricks that may help you with your adoption.
         I'll start by exploring interaction types.
         Most developers will want .
        automatic, which provides text selection, but will also highlight data detectors if the Live Text button is active.
         This will draw a line underneath any applicable detected items and allows one-tap access to activate them.
         This is the exact same behavior you would see from built-in applications.
         If it makes sense for your app to only have text selection without data detectors, you may set the type to .
        textSelection and it will not change with the state of the Live Text button.
         If, however, it makes sense for your app to only have data detectors without text selection, set the type to .
        dataDetectors.
         Note that in this mode, since selection is disabled, you will not see a Live Text button, but data detectors will be underlined and ready for one-tap access.
         Setting the preferredInteractionTypes to an empty set will disable the interaction.
         And also, a last note, with text selection or automatic mode, you'll find you can still activate data detectors by long-pressing.
         This is controlled by the allowLongPressForDataDetectorsIn TextMode property, which will be active when set to true, which the default.
         Simply set to false to disable this if necessary.
         I would like to now take a moment and talk about these buttons at the bottom, collectively known as the supplementary interface.
         This consists of the Live Text button, which normally lives in the bottom right-hand corner, as well as Quick Actions which appear on the bottom left.
         Quick Actions represent any data detectors from the analysis and are visible when the Live Text button is active.
         The size, position, and visibility are controlled by the interaction.
         And while the default position and look matches the system, your app may have custom interface elements which may interfere or utilize different fonts and symbol weights.
         Let's look at how you can customize this interface.
         First off, the isSupplementary InterfaceHidden property.
         If I wanted to allow my app to still select text but I did not want to show the Live Text button, if I set the SupplementaryInterfaceHidden to true, you will not see any Live Text button or Quick Actions.
         We also have a content insets property available.
         If you have interface elements that would overlap the supplementary interface, you may adjust the content insets so the Live Text button and Quick Actions adapt nicely to your existing app content when visible.
         If your app is using a custom font you'd like the interface to adopt, setting the supplementaryInterfaceFont will cause the Live Text button and Quick Actions to use the specified font for text and font weight for symbols.
         Please note that for button-sizing consistency, Live Text will ignore the point size.
         Switching gears for a moment, if you are not using UIImageview, you may discover that highlights do not match up with your image.
         This is because with UIImageView, VisionKit can use its ContentMode property to calculate the contentsRect automatically for you.
         Here, the interaction's view has a bounds that is bigger than its image content but is using the default's content rect, which is a unit rectangle.
         This is easily solved by implementing the delegate method contentsRectForInteraction and return a rectangle in unit coordinate space describing how the image content relates to the interaction's bounds in order to correct this.
         For example, returning a rectangle with these values would correct the issue, but please return the correct normalized rectangle based on your app's current content and layout.
         contentsRectForInteraction will be called whenever the interaction's bounds change, however, if your contentsRect has changed but your interaction's bounds have not, you can ask the interaction to update by calling setContentsRectNeedsUpdate().
         Another question you may have when adopting Live Text may be, Where is the best place to put this interaction? Ideally, Live Text interactions are placed directly on the view that hosts your image content.
         As mentioned before, UIImageView will handle the contentsRect calculations for you, and while not necessary, is preferred.
         If you are using UIImageview, just set the interaction on the imageView and VisionKit will handle the rest.
         However, if your ImageView is located inside of a ScrollView, you may be tempted to place the interaction on the ScrollView, however, this is not recommended and could be difficult to manage as it will have a continually changing contentsRect.
         The solution here is the same, place the interaction on the view that hosts your image content, even if it is inside a ScrollView with magnification applied.
         I'm going talk about gestures for a moment, Live Text has a very, very rich set of gesture recognizers, to say to least.
         Depending on how your app is structured, it's possible you may find the interaction responding to gestures and events your app should really handle or vice versa.
         Don't panic.
         Here are a few techniques you can use to help correct if you see these issues occur.
         One common way to correct this is to implement the delegate method interactionShouldBeginAtPointFor InteractionType.
         If you return false, the action will not be performed.
         A good place to start is to check if the interaction has an interactive item at the given point or if it has an active text selection.
         The text selection check is used here so you will be able to have the ability tap off of the text in order to deselect it.
         On the other hand, if you find your interaction doesn't seem to respond to gestures, it may be because there's a gesture recognizer in your app that's handling them instead.
         In this case, you can craft a similar solution using your gestureRecognizer's gestureRecognizerShouldBegin delegate method.
         Here, I perform a similar check and return false if there is an interactive item at the location or there's an active text selection.
         On a side note.
         In this example, I'm first converting the gestureRecognizer's location to the window's coordinate space by passing in nil, and then converting it to the interaction's view.
         This may be necessary if your interaction is inside of a ScrollView with magnification applied.
         If you find your points aren't matching up, give this technique a try.
         Another similar option I have found to be useful is to override UIView's hitTest:WithEvent.
         Here, once again, similar story, I perform the same types of checks as before, and in this case, return the appropriate view.
         As always, we want your app to be as responsive as possible, and while the Neural Engine makes analysis extremely efficient, there a few ImageAnalyzer tips I'd like to share for best performance.
         Ideally, you want only one ImageAnalyzer shared in your app.
         Also, we support several types of images.
         You should always minimize image conversions by passing in the native type that you have; however, if you do happen to have a CVPixelBuffer, that would be the most efficient.
         Also, in order to best utilize system resources, you should begin your analysis only when, or just before, an image appears onscreen.
         If your app's content scrolls -- for example, it has a timeline -- begin analysis only once the scrolling has stopped.
         Now this API isn't the only place you'll see Live Text, support is provided automatically in a few frameworks across the system your app may already use.
         For example, UITextField or UITextView have Live Text support using Camera for keyboard input.
         And Live Text is also supported in WebKit and Quick Look.
         For more information, please check out these sessions.
         New this year for iOS 16, we've added Live Text support in AVKit.
         AVPlayerView and ViewController support Live Text in paused frames automatically via the allowsVideoFrameAnalysis property, which is enabled by default.
         Please note, this is only available with non-FairPlay protected content.
         If you're using AVPlayerLayer, then you are responsible for managing the analysis and the interaction but it is very important to use the currentlyDisplayedPixelBuffer property to get the current frame.
         This is the only way to guarantee the proper frame is being analyzed.
         This will only return a valid value if the video play rate is zero, and this is a shallow copy and absolutely not safe to write to.
         And once again, only available for non-FairPlay protected content.
         We are thrilled to help bring Live Text functionality to your app.
         On behalf of everybody on the Live Text team, thank you for joining us for this session.
         I am stoked to see how you use it for images in your app.
         And as always, have fun!

        """
    }

    var japanese: String {
        """
        こんにちは！私はアダム・ブラッドフォードです。
         VisionKitチームのエンジニアです。もし、あなたのアプリにLive Textを追加したいと思っているなら、ここは正しい場所です。
         その前に、Live Textとは何でしょうか？Live Textは画像を解析し、ユーザーがそのコンテンツと対話するための機能を提供します。テキストの選択やコピー、検索や翻訳などのアクションの実行、住所のマッピング、電話番号のダイヤル、URLへのジャンプなどのデータ検出ワークフローを提供することが可能です。
         ライブテキストでは、QRコードによるインタラクションも可能です。
         これをあなたのアプリケーションでどのように使えるか、想像してみてください。もっと知りたいですか？それなら、ここにいますよ。
         このセッションでは、まずLive Text APIの一般的な概要を説明します。
         そして、既存のアプリケーションにこのAPIを実装する方法を探ります。
         次に、あなたのアプリにLive Textを追加するときに役立つヒントとトリックを紹介します。
         さて、Live Text APIの概要です。
         Live Text APIはSwiftで利用可能です。
         これは静止画像で美しく動作し、一時停止したビデオフレームに使用するために適応させることができます。
         ライブカメラストリームのビデオを分析して、テキストやQRコードのようなアイテムを検索する必要がある場合、VisionKitにはデータスキャナも用意されています。
         詳しくは、同僚のRonのこのセッションをチェックしてください。
         Live Text APIは、Apple Neural Engineを搭載したデバイスではiOS 16から、macOS 13をサポートするすべてのデバイスで利用可能です。
         4つの主要なクラスから構成されています。
         これを使うには、まず画像が必要です。
         この画像をImageAnalyzerに送り込み、非同期で解析を行います。
         分析が完了すると、結果の ImageAnalysis オブジェクトは、プラットフォームに応じて ImageAnalysisInteraction または ImageAnalysisOverlayView のいずれかに提供されます。
         ここまでは、かなり簡単なように見えますね？では、既存のアプリケーションにこれをどのように追加するか、デモを行います。
         これが私たちのアプリケーションです。
         これはシンプルな画像ビューアであり、スクロールビューの中に画像ビューがあります。
         ズームとパンの両方ができることに注意してください。
         しかし、いくらやっても、テキストを選択したり、データ検出器を起動したりすることはできません。
         これでは、どうしようもありません。
         これがXcodeのプロジェクトです。
         このアプリケーションにLive Textを追加するために、ビューコントローラのサブクラスを変更します。
         まず、ImageAnalyzerとImageAnalysisInteractionが必要です。
         ここでは、単純に viewDidLoad をオーバーライドして、imageview にインタラクションを追加しています。
         次に、いつ分析を実行するかを知る必要があります。
        新しい画像が設定されると、まず古い画像用に設定されていた preferredInteractionTypes と analysis をリセットしていることに注意してください。
         これで、新しい解析のための準備が整いました。
         次に、使用する関数を作成し、画像が存在するかどうかをチェックします。
        存在する場合は、タスクを作成します。
         次に、コンフィギュレーションを作成し、アナライザーが何を探すべきかを伝えます。
         今回は、テキストと機械読み取り可能なコードにします。
         解析の生成は投げられることがあるので、適宜対処してください。
         そして最後に、analyzeImageWithConfigurationメソッドを呼び出して、解析処理を開始する準備ができました。
         解析が完了すると、不確定な時間が経過し、アプリケーションの状態が変化している可能性があるので、解析が成功したことと、表示される画像が変化していないことをチェックします。
         これらのチェックがすべて通れば、あとはインタラクションの解析と preferredInteractionTypes の設定を行うだけです。
         ここでは.automaticを使っています。
        を使っていますが、これはデフォルトのシステム動作になります。
         これでテストの準備ができたと思います。
         あれ、見てください! ライブテキストボタンが表示され、テキストを選択できるようになりました。
         これらのインターフェイス要素が自動的に配置され、画像境界と可視領域の両方の内側に位置し、私が何もしなくても維持されていることに注目してください。
         ライブテキストボタンをタップすると、選択可能なアイテムがハイライトされ、データ検出器に下線が引かれ、クイックアクションが表示されることに注意してください。
         このクイックアクションをタップすると、電話をかけることができ、さらに長押しすることで他のオプションを見ることもできます。
         これはかなりクールだと認めざるを得ません。
         たった数行のコードで、普通の画像に命が吹き込まれたのです。
         このシンプルなアプリケーションは、画像上のテキストを選択したり、データ検出器やQRコードを起動したり、ルックアップやテキストの翻訳など、さまざまな機能を備えています。
         この数行のコードから、私に言わせれば、あまりにみすぼらしいものではありません。
         さて、Live Textの実装方法をご覧いただいたところで、これからいくつかのヒントやトリックを紹介します。
         まず、インタラクションの種類を調べることから始めます。
         ほとんどの開発者は.automaticを望んでいるでしょう。
        これはテキストを選択するものですが、Live Textボタンがアクティブな場合、データ検出器をハイライトします。
         これは、該当する検出項目の下に線を引き、ワンタップでアクセスできるようにして、それらをアクティブにします。
         これは、内蔵アプリケーションで見られる動作とまったく同じです。
         データ検出器を使わずにテキスト選択のみを行うことがアプリにとって理にかなっている場合は、typeを.textSelectionに設定すれば、ライブテキストボタンの状態によって変化することはありません。
        textSelectionに設定すれば、Live Textボタンの状態によって変化することはありません。
         しかし、テキストを選択せずにデータディテクタのみを使用する場合は、タイプを.
        dataDetectorsに設定してください。
         このモードでは、選択が無効になっているため、Live Textボタンは表示されませんが、データ検出器には下線が表示され、ワンタップでアクセスできるようになることに注意してください。
         preferredInteractionTypesに空のセットを設定すると、インタラクションは無効になります。
         また、テキスト選択や自動モードでも、長押しでデータディテクタを起動できることに注意してください。
         これは、allowLongPressForDataDetectorsInTextModeプロパティによって制御されます。
         必要であれば、falseに設定し、これを無効にすることができます。
         次に、補足インターフェースとして知られている、下部にあるこれらのボタンについて説明します。
         これは、通常右下にあるライブテキスト・ボタンと、左下にあるクイックアクションで構成されています。
         クイックアクションは、分析から得られた任意のデータ検出器を表し、ライブテキストボタンがアクティブのときに表示されます。
         サイズ、位置、および可視性は、インタラクションによって制御されます。
         また、デフォルトの位置と外観はシステムと一致していますが、アプリにはカスタムインターフェース要素があり、干渉したり、異なるフォントや記号の重みを利用したりすることがあります。
         このインターフェイスをどのようにカスタマイズできるかを見てみましょう。
         まず、isSupplementary InterfaceHiddenプロパティです。
         アプリでテキストを選択できるようにしたいが、ライブテキスト・ボタンは表示したくない場合、SupplementaryInterfaceHidden を true に設定すると、ライブテキスト・ボタンやクイックアクションが表示されなくなる。
         また、コンテンツインセットというプロパティも用意されています。
         補足インターフェースに重なるインターフェース要素がある場合、コンテンツインセットを調整して、Live TextボタンとQuick Actionsが表示されているときに既存のアプリコンテンツにうまく適応できるようにすることができます。
         アプリがインターフェイスに採用したいカスタムフォントを使用している場合、supplementaryInterfaceFontを設定すると、Live Textボタンとクイックアクションは、テキストに指定したフォントとシンボルに指定したフォントウェイトを使用するようになります。
         ボタンサイズの一貫性を保つために、Live Textはポイントサイズを無視することに注意してください。
         少し話は変わりますが、UIImageviewを使用していない場合、ハイライトが画像と一致しないことに気づくかもしれません。
         これは、UIImageViewを使用すると、VisionKitはそのContentModeプロパティを使って、contentsRectを自動的に計算することができるからです。
         ここでは、インタラクションのビューは、その画像コンテンツよりも大きなboundsを持っていますが、単位長方形であるデフォルトのコンテンツrectを使用しています。
         これは、デリゲートメソッド contentsRectForInteraction を実装し、画像コンテンツとインタラクションの境界の関係を記述した単位座標空間の矩形を返すことで簡単に解決できます。
         例えば、これらの値を持つ矩形を返せば問題は解決しますが、アプリの現在のコンテンツとレイアウトに基づいた正しい正規化矩形を返してください。
         contentsRectForInteraction は、インタラクションの境界が変更されるたびに呼び出されますが、contentsRect が変更されてもインタラクションの境界が変更されていない場合は、 setContentsRectNeedsUpdate() を呼び出して、インタラクションに更新を要求することが可能です。
         Live Textを採用する際のもう一つの疑問は、このインタラクションをどこに置くのがベストなのか、ということでしょう。理想的には、Live Text インタラクションは画像コンテンツをホストするビューに直接配置されます。
         先に述べたように、UIImageViewはcontentsRectの計算を処理するので、必要ではありませんが、好ましいです。
         UIImageviewを使用している場合は、imageViewにインタラクションを設定するだけで、あとはVisionKitが処理します。
         しかし、ImageViewがScrollViewの中にある場合、ScrollViewにインタラクションを設定したくなるかもしれませんが、これはお勧めしませんし、絶えず変化するcontentsRectを持つことになるので、管理が難しくなる可能性があります。
         この場合も解決方法は同じで、画像コンテンツを保持するビューにインタラクションを配置します。たとえそれが拡大表示されたScrollViewの中にあったとしてもです。
         Live Textは、控えめに言っても、非常に豊富なジェスチャー認識機能を備えています。
         アプリの構造によっては、アプリが本当に処理すべきジェスチャーやイベントにインタラクションが反応したり、その逆が起こる可能性があります。
         慌てないでください。
         このような問題が発生した場合、修正に役立ついくつかのテクニックを紹介します。
         一般的な修正方法としては、interactionShouldBeginAtPointForInteractionTypeというデリゲートメソッドを実装することです。
         false を返すと、そのアクションは実行されません。
         まず始めに、指定した位置にインタラクティブアイテムがあるかどうか、またはアクティブなテキスト選択があるかどうかをチェックするのがよいでしょう。
         テキスト選択のチェックは、テキストをタップして選択解除できるようにするために行います。
         一方、ジェスチャーに反応しない場合は、アプリ内のジェスチャー認識ツールがジェスチャーを処理している可能性があります。
         この場合、gestureRecognizerのgestureRecognizerShouldBeginデリゲートメソッドを使用して、同様の解決策を作成することができます。
         ここでは、同様のチェックを行い、その場所にインタラクティブなアイテムがある場合、またはアクティブなテキスト選択がある場合に false を返します。
         余談ですが
         この例では、まず nil を渡して gestureRecognizer の位置をウィンドウの座標空間に変換し、次にそれをインタラクションのビューに変換しています。
         これは、インタラクションが拡大表示された ScrollView の中にある場合に必要になることがあります。
         もし、ポイントが合わない場合は、この方法を試してみてください。
         もうひとつ、UIViewのhitTest:WithEventをオーバーライドする方法も便利だと感じています。
         ここでもまた似たような話で、前と同じ種類のチェックを行い、この場合は適切なビューを返します。
         Neural Engineは非常に効率的に分析を行いますが、最高のパフォーマンスを得るためにImageAnalyzerのヒントをいくつか紹介したいと思います。
         理想的には、アプリ内で共有するImageAnalyzerは1つだけにしたいものです。
         また、複数の種類の画像をサポートしています。
         しかし、もし CVPixelBuffer があれば、それが最も効率的でしょう。
         また、システムリソースを最大限に活用するために、画像が画面に表示されたとき、またはその直前にのみ解析を開始する必要があります。
         アプリのコンテンツがスクロールする場合（たとえば、タイムラインなど）、スクロールが止まってから解析を開始します。
         Live Textは、このAPIだけでなく、アプリがすでに使用しているシステム全体のいくつかのフレームワークでも自動的にサポートされています。
         例えば、UITextFieldやUITextViewは、カメラを使ってキーボード入力するLive Textをサポートしています。
         また、Live Textは、WebKitとQuick Lookでもサポートされています。
         詳しくは、これらのセッションをご覧ください。
         iOS 16の今年の新機能として、AVKitでのLive Textのサポートが追加されました。
         AVPlayerView と ViewController は、デフォルトで有効になっている allowsVideoFrameAnalysis プロパティを介して、一時停止中のフレームでの Live Text を自動的にサポートします。
         これは、FairPlay で保護されていないコンテンツでのみ利用可能であることに注意してください。
         AVPlayerLayer を使用している場合、解析とインタラクションの管理はあなたの責任ですが、現在のフレームを取得するために currentlyDisplayedPixelBuffer プロパティを使用することは非常に重要なことです。
         これは、適切なフレームが分析されていることを保証する唯一の方法です。
         これは、ビデオ再生速度がゼロの場合にのみ有効な値が返され、これは浅いコピーであり、書き込むのは絶対に安全ではありません。
         そしてもう一度言いますが、FairPlay で保護されていないコンテンツにのみ利用可能です。
         私たちは、あなたのアプリに Live Text 機能を提供するお手伝いができることを嬉しく思っています。
         Live Textチームのみんなを代表して、このセッションに参加してくれてありがとうございます。
         アプリ内の画像にどのように使用されるのか、楽しみにしています。
         そして、いつもどおり、楽しんでください。

        """
    }
}

