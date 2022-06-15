import Foundation

struct CaptureMachineReadableCodesAndTextwithVisionKit: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Capture machine-readable codes and text with VisionKit"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6518/6518_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10025/")!
    }

    var english: String {
        """
         Ron Santos: Hey, hope you're well.
         I'm Ron Santos, an input engineer.
         Today I’m here to talk to you about capturing machine-readable codes and text from a video feed, or, as we like to call it, data scanning.
         What exactly do we mean by data scanning? It’s simply a way of using a sensor, like a camera, to read data.
        Typically that data comes in the form of text.
         For example, a receipt with interesting information like telephone numbers, dates, and prices.
        Or maybe data comes as a machine-readable code, like the ubiquitous QR code.
         You’ve probably used a data scanner before, maybe in the Camera app or by using the Live Text features introduced in iOS 15.
         And I bet you’ve used apps in your day-to-day life with their own custom scanning experience.
         But what if you had to build your own data scanner? How would you do it? The iOS SDK has more than one solution for you, depending on your needs.
        One option is that you could use the AVFoundation framework to set up the camera graph, connecting inputs and outputs to a session and configuring it to yield AVMetadataObjects like machine-readable codes.
         If you also wanted to capture text, another option would be to combine both the AVFoundation and the Vision frameworks together.
         In this diagram, instead of metadata output, you create video data output.
         The video data output results in the delivery of sample buffers that can be fed to the Vision framework for use with text and barcode recognition requests, resulting in Vision observation objects.
         For more on using Vision for data scanning, check out the “Extract document data using Vision” from WWDC21.
         Okay, so that’s using AVFoundation and Vision for data scanning.
         In iOS 16, we have a new option that encapsulates all of that for you.
         Introducing the DataScannerViewController in the VisionKit framework.
         It combines the features of AVFoundation and Vision specifically for the purpose of data scanning.
         The DataScannerViewController users are treated to features like a live camera preview, helpful guidance labels, item highlighting, tap-to-focus which is also used for selection, and lastly, pinch-to-zoom to get a closer look.
        And let’s talk about features for developers like you.
         The DataScannerViewController is a UIViewController subclass that you can present however you choose.
         Coordinates for recognized items are always in view coordinates, saving you from converting from image space, to Vision coordinates, to view coordinates.
         You’ll also be able to limit the active portion of the view by specifying a region-of-interest, which is also in view coordinates.
         For text recognition, you can specify content types to limit the type of text you find.
         And for machine-readable codes, you can specify exactly which symbologies to look for.
         I get it; I use your apps, and I understand that data scanning is only a small portion of their functionality.
         But it could require a lot of code.
         With DataScannerViewController, our goal is to perform the common tasks for you, so you can focus your time elsewhere.
         Next, I’ll walk you through adding it to your app.
         Let’s start with the privacy usage description.
         When apps try to capture video, iOS asks the user to grant their explicit permission to access the camera.
         You’ll want to provide a descriptive message justifying your need.
         To do that, add a “privacy - camera usage description” to your app’s Info.
        plist file.
         Remember, be as descriptive as possible, so users know what they’re agreeing to.
         Now onto the code.
         Wherever you would like to present a data scanner, start by importing VisionKit.
        Next, because data scanning isn’t supported on all devices, use the isSupported class property to hide any buttons or menus exposing the functionality, so users aren’t presented with something they can’t use.
        If you’re curious, any 2018 and newer iPhone and iPad devices with the Apple Neural Engine support data scanning.
         You’ll also want to check for availability.
         Recall the privacy usage description? Scanning is available if the user approves the app for camera access and if the device is free of any restrictions, like the Camera access restriction set here, in Screen Time’s Content & Privacy Restrictions.
         Now you’re ready to configure an instance.
         That’s done by first specifying the types of data you’re interested in.
         For example, you can scan for both QR codes and text.
        You can optionally pass a list of languages for the text recognizer to use as a hint for various processing aspects, like language correction.
         If you have an idea what languages to expect, list them out.
         It’s especially useful when two languages have similar looking scripts.
         If you do not provide any languages, the user’s preferred languages are used by default.
         You can also request a specific text content type.
         In this example, I want my scanner to look for URLs.
        Now that you stated the types of data to recognize, you can create your DataScanner instance.
        In the previous example, I specified a barcode symbology, a recognition language, and a text content type.
        Let me take a moment to explain the other options for each of those.
        For barcode symbologies, we support all the same symbologies as Vision’s barcode detector.
        In terms of languages, as part of the LiveText feature, DataScannerViewController supports the same exact languages.
        And in iOS 16, I’m happy to say we’re adding support for Japanese and Korean.
        Of course, this can change again in future.
        So use the supportedTextRecognitionLanguages class property to retrieve the most up to date list.
        Finally, when scanning for text with specific semantic meaning, the DataScannerViewController can find these seven types.
        We’re now ready to present the Data Scanner to the user.
        Present it like any other view controller, going fullscreen, using a sheet, or adding it to another view hierarchy altogether.
        It’s all up to you.
        Afterwards, when presentation completes, call startScanning() to begin looking for data.
        So now I want to take a step back and spend some time going over Data Scanner’s initialization parameters.
        I used one here, recognizedDataTypes.
        But there are others that can help you customize your experience.
        Let’s go through each one.
        recognizedDataTypes allows you to specify what kind of data to recognize.
        Text, machine-readable codes, and what types of each.
        qualityLevel can be balanced, fast, or accurate.
        Fast will sacrifice resolution in favor of speed in scenarios where you expect large and easily-legible items, like text on signs.
        Accurate will give you the best accuracy, even with small items like micro QR codes or tiny serial numbers.
        I recommend starting with balanced, which should work great for most cases.
        recognizesMultipleItems gives you the option to look for one or more items in the frame, like if you want to scan multiple barcodes at a time.
        When it’s false, the center-most item is recognized by default until the user taps elsewhere.
        Enable high frame rate tracking when you draw highlights.
        It allows the highlights to follow items as closely as possible when the camera moves or the scene changes.
        Enable pinch-to-zoom or disable it.
        We also have methods you can use to modify the zoom level yourself.
        When you enable guidance, labels show at the top of the screen to help direct the user.
        And, finally, you can enable system highlighting if you need it, or you can disable it to draw your own custom highlighting.
        Now that you know how to present the data scanner, let’s talk about how you’d ingest the recognized items, and also how you’d draw your own custom highlights.
        First, provide a delegate to the data scanner.
        Now that you have a delegate, you can implement the dataScanner didTapOn method, which is called when the user taps on an item.
        With it, you’ll receive an instance of this new type RecognizeItem.
        RecognizedItem is an enum that holds text or a barcode as an associated value.
        For text, the transcription property holds the recognized string.
        For barcodes, if its payload contains a string, you can retrieve it with the payloadStringValue.
        Two other things you should know about RecognizedItem: First, each recognized item has a unique identifier you can use to track an item throughout its lifetime.
        That lifetime starts when the item is first seen and ends when it’s no longer in view.
        And second, each RecognizedItem has a bounds property.
        The bounds isn’t a rect, but it consists of four points, one for each corner.
        Next, let’s talk about three related delegate methods that are called when recognized items in the scene change.
        The first is didAdd, called when items in the scene are newly recognized.
        If you wanted to create your own custom highlight, you’d create one here for each new item.
        You can keep track of the highlights using the ID from its associated item.
        And when adding your new view to the view hierarchy, add them to DataScanner’s overlayContainerView, so they appear above the camera preview, but below any other supplemental chrome.
        The next delegate method is didUpdate, which is called when the items move or the camera moves.
        It can also be called when transcription for recognized text change.
        They change because the longer the scanner sees the text, the more accurate it’ll be with its transcription.
        Use the IDs from the updated items to retrieve your highlights from the dictionary you just created, and then animate the views to their newly updated bounds.
        And finally, the didRemove delegate method, which is called when items are no longer visible in the scene.
        In this method, you can forget about any highlight views you associated with the removed items, and you can remove them from the view hierarchy.
         In summary, if you draw your own highlights over items, those three delegate methods will be crucial for you to control animating highlights into the scene, animating their movement, and animating them out.
         And for each of those three previous delegate methods, you’ll also be given an array of all the items currently recognized.
         That may come in handy for text recognition because the items are placed in their natural reading order, meaning the user would read the item at index 0 before the item at index 1 and so on.
         That’s an overview of how to use the DataScannerViewController.
         Before wrapping up, I wanted to quickly mention a few other features, like capturing photos.
         You can call the capturePhoto method, which will asynchronously return a high quality UIImage.
        And if you aren’t creating custom highlights, you might not need these three delegate methods.
         Instead, you can use the recognizedItem property.
         It’s an AsyncStream that will be continuously updated as the scene changes.
        Thanks for hanging out.
         Remember, the iOS SDK gives you options for creating computer vision workflows with the AVFoundation and Vision frameworks.
         But maybe you’re creating an app that scans text or machine-readable codes with a live video feed, like a Pick-and-pack app, a back-of-the-warehouse app, or a point-of-sale app.
         If so, then give the DataScannerViewController in VisionKit a look.
         As I went over today, it has a number of initialization parameters and delegate methods that you can use to provide a custom experience that matches your app’s style and needs.
        And finally, I wanted to give a shout out to the “Add Live Text interaction to your app” session, where you can learn about VisionKit’s Live Text abilities for static images.
        Until next time, peace.

        """
    }

    var japanese: String {
        """
         ロン・サントスです。こんにちは、お元気ですか。
         私は入力エンジニアのロン・サントスです。
         今日は、ビデオ映像から機械読み取り可能なコードやテキストを取り込む、いわゆる「データスキャン」についてお話します。
         データスキャンとはどういう意味でしょうか。カメラのようなセンサーを使ってデータを読み取ることです。
        一般的に、データはテキストの形で提供されます。
         例えば、レシートには電話番号や日付、価格などの興味深い情報が書かれています。
        あるいは、QRコードのような機械読み取り可能なコードであることもあります。
         カメラアプリケーションやiOS 15で導入されたライブテキスト機能を使って、データスキャナーを使ったことがあるかもしれません。
         また、独自のスキャン機能を持つアプリケーションを日常的に使っている人も多いでしょう。
         でも、もし自分でデータスキャナーを作るとしたらどうしますか？あなたならどうしますか？iOS SDKは、あなたのニーズに応じて複数のソリューションを用意しています。
        1つの選択肢は、AVFoundationフレームワークを使用してカメラグラフを設定し、入出力をセッションに接続し、機械可読コードのようなAVMetadataObjectを生成するように設定できることです。
         もし、テキストもキャプチャしたい場合は、AVFoundationとVisionフレームワークの両方を組み合わせるという方法もあります。
         この図では、メタデータの出力の代わりに、ビデオデータの出力を作成しています。
         ビデオデータ出力は、テキストとバーコード認識要求で使用するためにVisionフレームワークに供給できるサンプルバッファの配信につながり、Vision観察オブジェクトを生み出します。
         Visionを使ったデータスキャンについては、WWDC21の「Extract document data using Vision」をご覧ください。
         さて、ここまでがAVFoundationとVisionを使ったデータスキャンの方法です。
         iOS 16では、そのすべてをカプセル化した新しいオプションが用意されています。
         VisionKitフレームワークのDataScannerViewControllerを紹介します。
         これは、特にデータスキャンを目的としたAVFoundationとVisionの機能を兼ね備えています。
         DataScannerViewControllerのユーザーは、ライブカメラプレビュー、役立つガイダンスラベル、アイテムのハイライト、タップトゥフォーカス（選択にも使用）、そして最後にピンチトゥズームでより詳しく見ることができるといった機能を享受できます。
        さらに、開発者向けの機能についても説明します。
         DataScannerViewControllerはUIViewControllerのサブクラスで、好きなように表示することができます。
         認識された項目の座標は常にビュー座標で表示されるので、画像空間、ビジョン座標、ビュー座標と変換する手間が省けます。
         また、関心領域を指定することで、ビューのアクティブな部分を制限することができます（これもビュー座標になります）。
         テキスト認識では、コンテンツタイプを指定して、検索するテキストの種類を限定することができます。
         また、機械読み取り可能なコードについては、検索する記号を正確に指定することができます。
         私はあなたのアプリケーションを使っていて、データスキャンがその機能のごく一部に過ぎないことは理解しています。
         しかし、そのためには多くのコードが必要になる可能性があります。
         DataScannerViewControllerで、私たちの目標はあなたのために共通のタスクを実行することで、あなたは他のことに時間を割くことができます。
         次に、これをあなたのアプリに追加する方法を説明します。
         まず、プライバシーの使い方の説明から始めましょう。
         アプリがビデオを撮影しようとすると、iOSはカメラへのアクセスに対する明示的な許可をユーザーに求めます。
         そのため、その必要性を正当化する説明文を提供する必要があります。
         そのためには、アプリのInfo.plistファイルに「privacy - camera usage description」を追加します。
        plistファイルに追加します。
         ユーザーが何に同意しているのかがわかるように、できるだけ説明的であることを忘れないでください。
         次に、コードについて説明します。
         データ・スキャナーを表示したい場所に、まずVisionKitをインポートしてください。
        次に、データ・スキャナーはすべてのデバイスでサポートされているわけではないので、isSupportedクラスのプロパティを使用して、機能を表示するボタンやメニューを非表示にして、ユーザーが使用できないものを表示しないようにします。
        気になる方は、Apple Neural Engineを搭載した2018年以降のiPhoneおよびiPadデバイスであれば、データスキャンに対応しています。
         また、利用可能かどうかも確認しておきたいところです。
         プライバシー利用の説明を思い出してください。スキャンは、ユーザーがカメラアクセス用のアプリを承認し、デバイスがScreen Timeのコンテンツとプライバシー制限で、ここで設定したカメラアクセス制限のような制限がない場合、利用可能です。
         これで、インスタンスを設定する準備が整いました。
         これは、最初に関心のあるデータのタイプを指定することで行われます。
         例えば、QRコードとテキストの両方をスキャンすることができます。
        オプションとして、言語修正などさまざまな処理のヒントとしてテキスト認識エンジンに使用する言語のリストを渡すことができます。
         どのような言語が予想されるか見当がつく場合は、それらをリストアップしてください。
         特に、2つの言語が似たような見た目のスクリプトを持つ場合に便利である。
         言語を指定しない場合、ユーザーの希望する言語がデフォルトで使用されます。
         また、特定のテキストコンテンツの種類を要求することもできます。
         この例では、スキャナーで URL を検索するように指定しています。
         認識するデータの種類を指定したので、DataScannerインスタンスを作成することができます。
         前の例では、バーコードの記号、認識言語、テキストのコンテンツ・タイプを指定しました。
         それぞれについて、その他のオプションについて少し説明させてください。
         バーコードの記号については、Visionのバーコード検出器と同じ記号をすべてサポートしています。
         言語に関しては、LiveTextの機能の一部として、DataScannerViewControllerは全く同じ言語をサポートしています。
         そして、iOS 16では、日本語と韓国語のサポートを追加しているのが嬉しいですね。
         もちろん、将来的にまた変わる可能性もあります。
         そのため、supportedTextRecognitionLanguagesクラスのプロパティを使って、最新のリストを取得することができます。
         最後に、特定の意味を持つテキストをスキャンする場合、DataScannerViewControllerはこれら7つのタイプを見つけることができます。
        これで、DataScanner をユーザに見せる準備ができました。
         他のビューコントローラと同じように、フルスクリーンで表示したり、シートを使ったり、別のビュー階層に追加したりすることができます。
         全てはあなた次第です。
         その後、プレゼンテーションが完了したら、startScanning()を呼び出してデータの検索を開始します。
         ここで一歩下がって、Data Scannerの初期化パラメータについて説明したいと思います。
         ここではrecognizedDataTypesというパラメータを使いました。
         しかし、他にもあなたの経験をカスタマイズするのに役立つものがあります。
        それぞれについて説明します。
         recognizedDataTypesは、認識するデータの種類を指定します。
         テキスト、機械読み取り可能なコード、そしてそれぞれの種類を指定します。
         qualityLevelは、balanced、fast、accuracyのいずれかを選択できます。
         高速は、標識のテキストのような大きくて読みやすいものを想定しているシナリオでは、速度を優先して解像度を犠牲にします。
         Accurateは、マイクロQRコードや小さなシリアルナンバーのような小さなアイテムでも、最高の精度を得ることができます。
         ほとんどの場合、balancedで開始することをお勧めします。
         recognizesMultipleItems は、一度に複数のバーコードをスキャンする場合などに、フレーム内の1つまたは複数のアイテムを探すオプションを提供します。
         falseを指定すると、ユーザが他の場所をタップするまで、最も中央のアイテムがデフォルトで認識されます。
         ハイライトを描画する際に、ハイフレームレートトラッキングを有効にします。
         これにより、カメラが動いたりシーンが変わったりしても、ハイライトが可能な限りアイテムに追従するようになります。
         ピンチ・トゥ・ズームを有効または無効にします。
         また、ズームレベルを自分で変更する方法もあります。
         ガイダンスを有効にすると、画面の上部にラベルが表示され、ユーザーを誘導することができます。
         最後に、必要であればシステムのハイライトを有効にするか、またはそれを無効にして独自のハイライトを描くことができます。
        データスキャナーの表示方法がわかったところで、認識された項目をどのように取り込むか、また、独自のカスタムハイライトをどのように描くかについて説明します。
        まず、データスキャナーにデリゲートを設定します。
         デリゲートを用意したら、ユーザーがアイテムをタップしたときに呼び出される dataScanner didTapOn メソッドを実装します。
         このメソッドでは、この新しいタイプRecognizeItemのインスタンスを受け取ります。
         RecognizedItemはenumで、関連する値としてtextまたはbarcodeを保持します。
         テキストの場合、transcriptionプロパティは、認識された文字列を保持します。
         バーコードの場合、そのペイロードに文字列が含まれていれば、payloadStringValue でそれを取得することができます。
         RecognizedItem について知っておくべきことは、他に 2 つあります。まず、各認識項目には、そのライフタイムを通じて項目を追跡するために使用できる一意の識別子があります。
         その有効期間は、アイテムが最初に表示されたときから、表示されなくなったときまでです。
         次に、各RecognizedItemはboundsプロパティを持っています。
         boundsは矩形ではなく、各コーナーに1つずつ、合計4つの点で構成されている。
         次に、シーン内の認識されたアイテムが変更されたときに呼び出される、関連する3つのデリゲートメソッドについて説明します。
         1つ目はdidAddで、シーン内のアイテムが新しく認識されたときに呼び出されます。
         独自のハイライトを作成したい場合は、新しいアイテムごとにここで作成します。
         ハイライトは、関連するアイテムのIDを使用して追跡することができます。
         また、新しいビューをビュー階層に追加するときは、DataScannerのoverlayContainerViewに追加して、カメラプレビューの上に、他の補足的なクロームの下に表示されるようにします。
        次のデリゲートメソッドはdidUpdateで、アイテムが移動したり、カメラが移動したりしたときに呼び出されます。
         これは、認識されたテキストの転写が変更されたときにも呼び出されます。
         これは、スキャナーがテキストを長く見れば見るほど、その転写の正確さが増すからです。
         更新されたアイテムのIDを使用して、作成したばかりの辞書からハイライトを取得し、ビューを新しく更新された境界に合わせてアニメーション化します。
         そして最後に、didRemoveデリゲートメソッドです。これは、アイテムがシーンから見えなくなった時に呼び出されるメソッドです。
         このメソッドでは、削除されたアイテムに関連付けたハイライトビューを忘れ、ビュー階層から削除することができます。
         まとめると、アイテムの上に独自のハイライトを描画する場合、これら3つのデリゲートメソッドは、シーンへのハイライトのアニメーション、その動き、そしてハイライトのアニメーションを制御するために非常に重要なものになります。
         また、先の3つのデリゲートメソッドには、現在認識されているすべてのアイテムの配列が渡されます。
         つまり、ユーザーはインデックス 0 のアイテムをインデックス 1 のアイテムの前に読むというように、自然な読み順でアイテムを配置するため、テキスト認識には便利でしょう。
         以上、DataScannerViewControllerの使い方の概要でした。
         最後に、写真のキャプチャなど、他の機能についても簡単に触れておきたいと思います。
         capturePhotoメソッドを呼び出すと、高画質のUIImageを非同期で返してくれます。
        また、カスタム・ハイライトを作成しないのであれば、これら3つのデリゲート・メソッドは必要ないかもしれません。
         その代わり、recognizedItemプロパティを使用することができます。
         これはAsyncStreamで、シーンが変わると継続的に更新されます。
        お付き合いいただきありがとうございました。
         iOS SDKは、AVFoundationとVisionフレームワークを使用してコンピュータビジョンのワークフローを作成するためのオプションを提供していることを忘れないでください。
         しかし、もしかしたら、ピックアンドパックアプリ、倉庫アプリ、販売時点情報管理アプリなど、ライブビデオフィードでテキストや機械読み取り可能なコードをスキャンするアプリを作成することになるかもしれません。
         もしそうなら、VisionKitのDataScannerViewControllerを一度見てみてください。
         今日説明したように、このコントローラには多くの初期化パラメータとデリゲートメソッドがあり、あなたのアプリのスタイルとニーズに合ったカスタム体験を提供するために使用することができます。
        そして最後に、静止画像に対するVisionKitのLive Text能力について学ぶことができる「Add Live Text interaction to your app」セッションにエールを送りたいと思います。
        次回まで、平和に。

        """
    }
}
