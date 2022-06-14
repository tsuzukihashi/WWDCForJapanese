import Foundation

struct BringYourDriverToiPadWithDriverKit: ArticleProtocol {
    var id: String {
        title
    }

    var title: String {
        "Bring your driver to iPad with DriverKit"
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/110373/")!
    }

    var english: String {
        """
        Souvik Banerjee: Hi, and welcome to "Bring your driver to iPad with DriverKit.
        " I'm Souvik, and today I'll discuss several exciting new developments in DriverKit.
         We're going to discuss three topics today.
         First, I'll give a brief overview of DriverKit.
         Then, I'll discuss some updates to AudioDriverKit.
         And I'll end with how to bring your drivers to the iPad Let's get started with an overview.
         In 2019, we introduced DriverKit, a replacement for IOKit device drivers.
         DriverKit brought a new way to extend the system that is more reliable and secure, running in userspace.
         And it's easier to develop since your process isn't in the kernel.
         These driver extensions, also known as dexts, are bundled in apps, and you can easily distribute your apps and drivers on the Mac App Store.
         People can easily find your driver with a search, and if your driver is no longer needed, you can just delete the app to uninstall it.
         Since introducing DriverKit, we have added support for many new driver families.
        We now support Networking, Block Storage, Serial, Audio, and SCSI controller and peripheral drivers in addition to transports such as USB, PCI, and HID.
        To learn more about the kinds of drivers you can build with DriverKit, please check out the "Create audio drivers with DriverKit" session from WWDC 2021 and the "Modernize PCI and SCSI drivers with DriverKit" session from WWDC 2020.
         Next, we added several new features in AudioDriverKit recently that I want to highlight.
         One of these features is real-time operations.
         We're excited to introduce a new feature in AudioDriverKit allowing you to register a real-time callback.
         This callback gets invoked every time an IO operation happens.
         You can use this callback if you need to modify your audio buffers on a real-time thread, such as for signal processing.
        To register a real-time callback in AudioDriverKit, we declare an IOOperationHandler block to set on the IOUserAudioDevice.
         This block will be called from a real-time context when an IO operation occurs on the IOUserAudioStream buffers for the device.
        Inside the block, we check what the operation is, and we can modify the data as necessary.
         Finally, we call SetIOOperationHandler to set the block on the audio device.
         Now let's talk about entitlements.
         When we introduced AudioDriverKit, you had to use the allow-any-userclient-access entitlement on your driver.
         In macOS 12.
        1, we introduced a new entitlement specifically for AudioDriverKit.
         Please update your audio drivers to use the new audio family entitlement instead of the allow-any-userclient-access entitlement.
         You can keep the allow-any-userclient-access entitlement if you want any app to be able to communicate with your driver.
         This new entitlement is public for development, so you can get started using this today without filing a request.
         In fact, all DriverKit family entitlements are now available to use for development.
         To request this entitlement for distribution, please visit the System Extension page on developer.
        apple.
        com.
         Now, I'm really excited to tell you about DriverKit on iPad.
         Professionals are increasingly using iPad to do their best work.
         But many rely on external hardware that they couldn't use on iPad.
         So today, we're excited to announce that DriverKit is coming to iPad.
        DriverKit on macOS has made it possible to extend the system in a safe and secure way, and we're bringing that same technology to the iPad.
         In fact, if you've already created a driver with DriverKit on the Mac, you can bring that exact same driver to the iPad without any changes to your driver.
         USB, PCI, and Audio will be supported in iPadOS 16.
         This will enable Thunderbolt audio interfaces on iPad for the first time, and many more devices.
         This is made possible with the power of the M1 chip.
         All iPads with M1 will support DriverKit.
         DriverKit on iPadOS is the same as on macOS.
         This means that you can build one DriverKit driver and have it work on both platforms, no source changes required.
         In addition , using the new multiplatform apps feature in Xcode 14, you can easily create a single app target to deliver your driver on both Mac and iPad.
         For more information about multiplatform apps, please check out the "Use Xcode to develop a multiplatform app" session.
        Xcode also now supports automatic signing of DriverKit drivers.
         It knows how to handle DriverKit on iPadOS and can provision for both Mac and iPad.
         You no longer need to configure manual signing for DriverKit drivers.
         Your iPadOS app and driver can be distributed on the App Store , just like on macOS.
         This means that you can take advantage of features like in-app purchases and have your driver be easily discoverable by users.
         Let's see just how easy it is to take an existing macOS driver and app and bring it to iPad.
         Here, I have an app called DriverKitSampleApp.
         It has a SwiftUI view with a label and a button allowing the user to install the driver.
         Our driver is called NullDriver.
         It prints a message when the driver starts and starts a timer that fires every second and increments a counter called timerCount.
         To make this an iPad app, all I need to do is select the DriverKitSampleApp target in Xcode.
        ..And add iPad to Supported Destinations.
        Now I can change my run destination to the iPad I have connected to my Mac.
        Let's try running this on the iPad.
         Here's our iPad app.
         We have the label and the button from the view we saw in Xcode.
         Tapping the Install Dext button takes us to Settings, where we see this new Drivers link.
         We tap that link, and we see a list of all drivers bundled in this app.
         We can then enable our Null Driver.
         So you might have noticed several things in the demo.
         Our Null Driver is bundled inside our iPadOS app, and it gets automatically discovered by the system after installation.
         On macOS , you would need to use the SystemExtension framework to prompt the user to install the driver.
         On iPadOS, there is no SystemExtensions framework.
        Inside Xcode, you can see that our driver is embedded within our app.
         Since drivers are low-level software and are privileged, they need to be approved by the user before they can run.
         On macOS, users need to go to the Security & Privacy preferences to allow system extensions.
         On iPadOS, the driver approvals are in the Settings app.
         There are two options for driver approvals.
         If there is at least one app with a driver installed, there will be a menu inside General Settings with a list of all available drivers.
         Each driver can be toggled on or off.
         If your app contains a Settings bundle, there will be a Drivers link inside your app's Settings.
         Your app should prompt the user to enable the driver in Settings.
         Let's start again with our macOS driver project and see how we can have our app prompt the user to enable the driver in Settings.
         We start by adding iPad to our supported destinations.
        Our SwiftUI view has a button to install the driver, and our view model has a state machine that interacts with the SystemExtensions framework.
         Since this project is going to build for both Mac and iPad, we want to keep our Mac view and view model but create a new view that will be used on iPad.
        Then, we can go to Build Phases and Compile sources and change the platform filter for each file to conditionally compile for iOS or macOS.
        Now, let's add a Settings bundle to our app.
         We're going to use the default example Settings for now, but we can change these later to real Settings that the app can use.
        Now let's check the iOS view we just created.
         We can copy our macOS view to our iOS view to use as a starting point.
        Our iOS view doesn't use a view model, so we can remove that.
        We also need to change our button action to open our Settings bundle.
         This will take the user into Settings, so that they can enable the driver.
        Finally, we change the button text to make it clear that the user needs to enable the driver in Settings.
        Let's see this in action.
         We have the view we designed, and tapping the button takes us to our Settings bundle.
         Then we go into Drivers and enable the Null Driver.
        It's important to keep in mind that drivers launch on demand.
         Although we've enabled the driver in Settings, the driver only starts running when the hardware device is plugged in to the iPad.
         After the driver starts running, I can attach a debugger to it using Xcode wireless debugging.
         To do that, I go to the Debug menu in Xcode, attach to process, then select the NullDriver process.
         Once attached, I can set breakpoints or pause execution.
         Here, I've set a breakpoint in our timer.
         I'm going to print timerCount to see how many times our timer has been called.
        When you're done debugging, detach from the driver process using the Debug menu in Xcode.
        So now we have a driver.
         But a driver isn't very useful by itself.
         It needs to communicate with the rest of the system.
         Some DriverKit frameworks like AudioDriverKit handle this for you.
         But if you need to do something more advanced, such as creating a custom control panel app for your hardware, you need to have your app be able to communicate with your driver.
         This is what user clients allow you to do.
         They allow you to define your own interface, allowing app and driver communication.
         Apps use the IOKit.
        framework to open user clients.
         For an example of how this works, please see the sample code on developer.
        apple.
        com.
        So we know that apps can communicate with drivers.
         But it's important to keep security in mind.
         Since drivers are privileged, we don't want to allow every app to communicate with drivers.
        On macOS, the app needs the driverkit userclient-access entitlement, and the value is an array of allowed driver bundle identifiers.
        On iPadOS, we added a new entitlement called Communicates With Drivers.
         It replaces the macOS user client entitlement.
         This entitlement grants your app the ability to open user clients to your driver.
        If you want to add the Communicates With Drivers entitlement manually to your app, here's the XML entitlement string.
        We can also add this entitlement from Xcode.
         In Xcode, we go to Signing and Capabilities, then add a new capability.
         Then, we can search for "communicates with drivers" and add the capability to our app.
        Another use case for user clients is to allow apps from other developers to interact with your driver.
         So in this case, suppose you have an app and driver and you want to provide a service to other apps, including those from other developers.
         DriverKit user clients also support this.
        Each app that needs to communicate with drivers needs the communicates with drivers entitlement.
         The driver needs the Allow Third Party User Clients entitlement.
         This allows apps built with a different team identifier to open a user client to the driver.
         Without this entitlement, only apps from the same team can communicate with the driver.
         If you want to add the Allow Third Party User Clients entitlement manually to your driver, here's the XML entitlement string.
        Or we can add this capability from Xcode by going into Signing and Capabilities for our driver.
        These new user client entitlements are public for development, which means that you can get started using this today without any approval.
         To request these entitlements for distribution, please see our developer website.
         DriverKit drivers also have important implications for app update.
         Automatic app update ensures users always get the latest version of your app.
         However, for apps containing drivers, the update process works a little differently.
         Let's suppose you distribute version 1 of your app on the app store.
         Then, you install that app along with its bundled driver on your iPad and enable the driver in Settings.
         When you plug in the hardware device for your driver, the driver starts running, and once the driver starts running, your app can begin communicating with your driver using user clients.
         Now, suppose you find a bug in your app and you submit version 2 to the App Store.
         Because of automatic app update, the version 2 app is downloaded and installed on your iPad automatically.
         The driver approval state is maintained through updates, so you don't need to approve the driver again.
         However, notice that the hardware is still plugged in, and our version 1 driver is still running.
         Driver version 2 was downloaded with the app update but does not start running.
         Since the old driver still continues running, your version 2 app may have to communicate with the version 1 driver.
        When the hardware device is unplugged, the driver stops running, so now driver version 1 is done and we can update the driver to version 2.
        Now, if you plug in the device again, we start the version 2 driver, and now your app is communicating with the new driver.
        To recap: Apps are updated anytime with automatic app update.
         Drivers are updated after the device is unplugged.
         And your app may communicate with an old driver.
         When your app and driver are ready, you can submit them to the App Store.
         Your drivers can only run on devices that support DriverKit.
         If you want to restrict your app to those devices, such as if your app only installs a driver, add DriverKit to your app's UIRequiredDeviceCapabilities.
         This will prevent users from installing your app on a device that does not support DriverKit.
         We also suggest submitting a video to App Review showing how your app and driver work with your hardware device.
         So that's DriverKit on iPad.
         You can now bring USB, PCI, and Audio drivers to iPad with M1 and deliver those drivers inside apps on the App Store.
         And if you already have a driver, it's easy to bring that to iPad.
         We encourage developers to try using DriverKit on iPad and provide any feedback using Feedback Assistant.
         Thank you for watching.

        """
    }

    var japanese: String {
        """
        Souvik Banerjee: こんにちは、「DriverKitであなたのドライバをiPadに」のコーナーにようこそ。
        " 私はSouvikです。今日はDriverKitのいくつかのエキサイティングな新開発についてお話します。
         今日は3つのトピックについてお話します。
         まず、DriverKitの簡単な概要を説明します。
         そして、AudioDriverKitのいくつかのアップデートについてです。
         そして最後に、ドライバをiPadに対応させる方法について説明します。 まずは概要から始めましょう。
         2019年、私たちはIOKitデバイスドライバーの代替となるDriverKitを導入しました。
         DriverKitは、ユーザースペースで動作する、より信頼性が高く安全なシステムを拡張する新しい方法をもたらしました。
         そして、自分のプロセスがカーネル内にないため、開発しやすくなりました。
         dextsとも呼ばれるこれらのドライバ拡張機能はアプリケーションにバンドルされており、Mac App Storeであなたのアプリケーションとドライバを簡単に配布することができます。
         人々は検索で簡単にあなたのドライバを見つけることができますし、ドライバが不要になったら、アプリを削除してアンインストールすればいいのです。
         DriverKitの導入以来、私たちは多くの新しいドライバファミリーをサポートするようになりました。
        現在では、USB、PCI、HIDなどのトランスポートに加え、ネットワーク、ブロックストレージ、シリアル、オーディオ、SCSIコントローラや周辺機器のドライバをサポートしています。
        DriverKitで構築できるドライバの種類については、WWDC 2021の「Create audio drivers with DriverKit」セッションとWWDC 2020の「Modernize PCI and SCSI drivers with DriverKit」セッションをご覧ください。
         次に、最近AudioDriverKitにいくつかの新機能が追加されたので、それを紹介したいと思います。
         そのひとつが、リアルタイム・オペレーション機能です。
         AudioDriverKitの新機能として、リアルタイムのコールバックを登録できるようになりました。
         このコールバックは、IOオペレーションが発生するたびに呼び出されます。
         信号処理など、リアルタイムスレッドでオーディオバッファを変更する必要がある場合に、このコールバックを使用することができます。
        AudioDriverKitにリアルタイムコールバックを登録するために、IOUserAudioDeviceに設定するIOOperationHandlerブロックを宣言します。
         このブロックは、デバイスのIOUserAudioStreamバッファでIO操作が発生したときに、リアルタイムコンテキストから呼び出されます。
        ブロックの中では、操作が何であるかを確認し、必要に応じてデータを変更することができます。
         最後に、SetIOOperationHandlerを呼び出して、オーディオデバイスにブロックを設定します。
         さて、次はエンタイトルメントについてです。
         AudioDriverKitを導入した時は、ドライバにallow-any-userclient-accessエンタイトルメントを使用する必要がありました。
         macOS 12.1では、新しいエンタイトルメントを導入しました。
        1では、AudioDriverKit専用の新しいエンタイトルメントを導入しました。
         オーディオドライバをアップデートして、allow-any-userclient-access エンタイトルメントの代わりに、新しいオーディオファミリーエンタイトルメントを使用するようにしてください。
         任意のアプリがあなたのドライバと通信できるようにしたい場合は、allow-any-userclient-access エンタイトルメントを維持することができます。
         この新しいエンタイトルメントは開発用に公開されているので、リクエストを提出することなく、今日から使い始めることができます。
         実際、DriverKitファミリーのすべてのエンタイトルメントが、開発用に使用できるようになりました。
         このエンタイトルメントを配布するためにリクエストするには、developer.com の System Extension ページにアクセスしてください。
        apple.
        com にある System Extension ページをご覧ください。
         さて、DriverKit on iPadについてお話しするのがとても楽しみです。
         プロフェッショナルが最高の仕事をするためにiPadを使うことが多くなっています。
         しかし、その多くは、iPadで使用できない外部ハードウェアに依存しています。
         そこで今日、DriverKitがiPadに登場することをお知らせします。
        macOSのDriverKitは、安全でセキュアな方法でシステムを拡張することを可能にしましたが、それと同じ技術をiPadにも導入します。
         実際、Mac上のDriverKitですでにドライバを作成している場合は、ドライバを変更することなく、まったく同じドライバをiPadに導入することができます。
         iPadOS 16では、USB、PCI、オーディオがサポートされます。
         これにより、iPadで初めてThunderboltオーディオインターフェイスが使えるようになり、さらに多くのデバイスが使えるようになります。
         これは、M1チップのパワーで可能になります。
         M1を搭載したすべてのiPadは、DriverKitをサポートします。
         iPadOSのDriverKitは、macOSと同じです。
         つまり、1つのDriverKitドライバをビルドすれば、両方のプラットフォームで動作させることができ、ソースの変更は必要ありません。
         さらに、Xcode 14の新しいマルチプラットフォームアプリ機能を使用すると、MacとiPadの両方でドライバを配信するための単一のアプリターゲットを簡単に作成することができます。
         マルチプラットフォームアプリの詳細については、「Xcodeを使用してマルチプラットフォームアプリを開発する」セッションを参照してください。
        Xcodeは、DriverKitドライバの自動署名もサポートするようになりました。
         iPadOS上のDriverKitの扱い方を知っており、MacとiPadの両方に対してプロビジョニングすることができます。
         DriverKitドライバの手動署名を設定する必要はもうありません。
         iPadOSアプリとドライバは、macOSと同じようにApp Storeで配布することができます。
         つまり、アプリ内課金などの機能を活用し、あなたのドライバをユーザが簡単に発見できるようにすることができるのです。
         既存のmacOS用ドライバとアプリをiPadで利用するのがいかに簡単か、見てみましょう。
         ここでは、DriverKitSampleAppと呼ばれるアプリを持っています。
         これは、ラベルと、ユーザーがドライバーをインストールするためのボタンを持つSwiftUIビューを持っています。
        このドライバはNullDriverと呼ばれます。
         ドライバが起動するとメッセージを表示し、1秒ごとにタイマーを起動し、timerCountというカウンターをインクリメントする。
         これをiPadアプリにするには、XcodeでDriverKitSampleAppターゲットを選択するだけだ。
        そして、Supported DestinationsにiPadを追加します。
        これで、実行先をMacにつないだiPadに変更することができます。
        では、これをiPadで実行してみましょう。
         これが私たちのiPadアプリです。
         Xcodeで見たビューから、ラベルとボタンがあります。
         Install Dextボタンをタップすると、Settingsに移動し、新しいDriversのリンクが表示されます。
         このリンクをタップすると、このアプリにバンドルされているすべてのドライバのリストが表示されます。
         そして、Null Driver を有効にすることができます。
         このデモで、いくつかの点にお気づきになったかと思います。
         Null Driverは、iPadOSアプリにバンドルされており、インストール後にシステムによって自動的に検出されます。
         macOSでは、SystemExtensionフレームワークを使用して、ドライバをインストールするようにユーザに促す必要があります。
         iPadOSでは、SystemExtensionsフレームワークはありません。
        Xcodeの内部では、ドライバがアプリの中に埋め込まれているのがわかります。
         ドライバは低レベルのソフトウェアであり、特権的であるため、実行する前にユーザーの承認が必要です。
         macOSでは、ユーザはセキュリティとプライバシーの環境設定から、システム拡張を許可する必要があります。
         iPadOSでは、ドライバーの承認は「設定」アプリにあります。
         ドライバの承認には2つのオプションがあります。
         ドライバがインストールされているアプリが1つ以上ある場合、一般設定内に利用可能なすべてのドライバのリストが表示されたメニューが表示されます。
         各ドライバーは、オンまたはオフに切り替えることができます。
         アプリに設定バンドルが含まれている場合、アプリの設定内に「ドライバー」リンクが表示されます。
         アプリは、ユーザーが設定でドライバを有効にするよう促すはずです。
         macOSドライバプロジェクトを再び開始し、アプリがユーザにドライバを有効にするよう求める方法を確認しましょう。
         サポートされている目的地に iPad を追加することから始めます。
        SwiftUI ビューには、ドライバーをインストールするボタンがあり、ビューモデルには、SystemExtensions フレームワークとやり取りするステートマシンがあります。
         このプロジェクトは Mac と iPad の両方に向けてビルドする予定なので、Mac のビューとビューモデルはそのままにして、iPad で使用する新しいビューを作成したいと思います。
        次に、Build Phases と Compile sources で、各ファイルのプラットフォーム・フィルタを変更して、iOS または macOS 用に条件付きでコンパイルできるようにします。
        では、アプリに設定バンドルを追加してみましょう。
         ここでは、デフォルトのサンプル設定を使用しますが、後でアプリが使用できる実際の設定に変更することができます。
        ここで、先ほど作成した iOS のビューを確認してみましょう。
         macOSのビューをiOSのビューにコピーして、出発点として使用することができます。
        iOSビューはビューモデルを使用していないので、ビューモデルを削除します。
        また、ボタンのアクションを変更して、Settings バンドルを開くようにする必要があります。
         これにより、ユーザは設定に移動し、ドライバを有効にすることができます。
        最後に、ユーザーが設定でドライバーを有効にする必要があることを明確にするために、ボタンテキストを変更します。
        では、実際にやってみましょう。
         デザインしたビューがあり、ボタンをタップすると、設定バンドルが表示されます。
         次に、[Drivers] に移動して、Null Driver を有効にします。
        ここで重要なのは、ドライバはオンデマンドで起動するということです。
         設定]でドライバを有効にしても、ハードウェアデバイスがiPadに接続されたときにのみドライバが実行されます。
         ドライバが起動したら、Xcodeのワイヤレスデバッグを使ってデバッガを接続することができます。
         そのためには、XcodeのDebugメニューから、attach to processを選択し、NullDriverプロセスを選択します。
         アタッチしたら、ブレークポイントを設定したり、実行を一時停止したりできる。
         ここでは、タイマーにブレークポイントを設定しました。
         タイマーが何回呼び出されたかを確認するために timerCount を表示します。
        デバッグが終わったら、XcodeのDebugメニューを使ってドライバプロセスから切り離します。
        さて、これでドライバができました。
         しかし、ドライバはそれだけではあまり役に立ちません。
         システムの残りの部分と通信する必要があるのです。
         AudioDriverKitのようなDriverKitのフレームワークの中には、この処理を代行してくれるものがあります。
         しかし、もっと高度なことをする必要がある場合、例えばハードウェア用のカスタムコントロールパネルアプリを作る場合、アプリがドライバと通信できるようにする必要があります。
         これを可能にするのが、ユーザークライアントです。
         ユーザー・クライアントは、独自のインターフェースを定義し、アプリとドライバーの通信を可能にします。
         アプリはIOKit.
        フレームワークを使用して、ユーザークライアントを開きます。
         この仕組みの例については、developer.jp のサンプルコードを参照してください。
        apple.
        comにあるサンプルコードを参照してください。
        これで、アプリがドライバと通信できることがわかりました。
         しかし、セキュリティに留意することが重要です。
         ドライバは特権的なものなので、すべてのアプリがドライバと通信できるようにするのは好ましくありません。
        macOSでは、アプリはdriverkit userclient-accessエンタイトルメントを必要とし、その値は許可されたドライバーバンドル識別子の配列となります。
        iPadOSでは、Communicates With Driversと呼ばれる新しいエンタイトルメントを追加しました。
         これは、macOSのユーザークライアントエントリメントを置き換えます。
        このエンタイトルメントは、アプリにドライバへのユーザークライアントを開く能力を付与します。
        Communicates With Driversエンタイトルメントをアプリに手動で追加したい場合、ここにXMLエンタイトルメント文字列があります。
        また、Xcodeからこのエンタイトルメントを追加することもできます。
         Xcodeで、Signing and Capabilitiesに移動し、新しいケイパビリティを追加します。
         そして、"communicates with drivers "を検索して、ケイパビリティをアプリに追加します。
        ユーザークライアントのもう1つの使用例は、他の開発者のアプリがあなたのドライバと対話できるようにすることです。
         つまりこの場合、アプリとドライバがあり、他の開発者のアプリを含む他のアプリにサービスを提供したいとします。
         DriverKitのユーザークライアントもこれをサポートしています。
        ドライバと通信する必要がある各アプリは、communicates with drivers というエンタイトルメントが必要です。
         ドライバーは、Allow Third Party User Clients エンタイトルメントを必要とします。
         これにより、異なるチーム識別子でビルドされたアプリが、ドライバに対してユーザークライアントを開くことができます。
         この権限がないと、同じチームのアプリだけがドライバーと通信できます。
         Allow Third Party User Clients] エンタイトルメントをドライバーに手動で追加したい場合は、以下のXMLエンタイトルメント文字列を参照してください。
        または、XcodeからドライバのSigning and Capabilitiesにアクセスして、この機能を追加できます。
        これらの新しいユーザークライアントのエンタイトルメントは、開発用に公開されており、承認なしで今日から使い始めることができます。
         これらのエンタイトルメントを配布するためのリクエストは、私たちの開発者用ウェブサイトをご覧ください。
         DriverKitドライバは、アプリのアップデートにも重要な意味を持っています。
         アプリの自動アップデートにより、ユーザーは常に最新バージョンのアプリを入手することができます。
         しかし、ドライバを含むアプリの場合、アップデートプロセスは少し異なってきます。
         例えば、アプリのバージョン1をアプリストアで配布したとします。
         そして、そのアプリと同梱されているドライバをiPadにインストールし、「設定」でドライバを有効にします。
         ドライバ用のハードウェアデバイスを接続すると、ドライバが起動し、ドライバが起動すると、アプリはユーザクライアントを使ってドライバと通信を開始することができるようになります。
         ここで、アプリにバグを発見し、App Storeにバージョン2を提出したとします。
         アプリの自動更新があるため、バージョン2のアプリは自動的にダウンロードされ、iPadにインストールされます。
         ドライバの承認状態はアップデートによって維持されるため、再度ドライバを承認する必要はありません。
         しかし、ハードウェアはまだ接続されており、私たちのバージョン1のドライバがまだ動作していることに注意してください。
         ドライバーのバージョン2は、アプリのアップデートと一緒にダウンロードされましたが、実行を開始しません。
         古いドライバがまだ動作し続けているため、バージョン2のアプリはバージョン1のドライバと通信する必要がある可能性があります。
        ハードウェアデバイスを抜くと、ドライバーの実行が停止するので、これでドライバーのバージョン1は終了し、ドライバーをバージョン2に更新することができます。
        ここで、再びデバイスを差し込むと、バージョン2のドライバが起動し、今度はアプリが新しいドライバと通信するようになります。
        まとめますと アプリは、アプリの自動更新でいつでも更新される。
         ドライバはデバイスを抜いた後に更新される。
         そして、アプリは古いドライバと通信する可能性がある。
         アプリとドライバーの準備ができたら、App Storeに提出します。
         作成したドライバは、DriverKitに対応したデバイス上でのみ動作させることができます。
         アプリがドライバのみをインストールする場合など、アプリをそれらのデバイスに制限したい場合は、アプリのUIRequiredDeviceCapabilitiesにDriverKitを追加してください。
         これにより、ユーザーはDriverKitをサポートしていないデバイスにアプリをインストールすることができなくなります。
         また、アプリとドライバがハードウェアデバイスでどのように動作するかを示すビデオをApp Reviewに提出することをお勧めします。
         これでiPadのDriverKitは完了です。
         M1でiPadにUSB、PCI、オーディオドライバを導入し、App Storeでアプリの中にそれらのドライバを配信することができます。
         また、すでにドライバをお持ちの方は、それをiPadに簡単に取り込むことができます。
         開発者の皆様には、iPadでDriverKitを使ってみて、フィードバックアシスタントを利用してフィードバックを提供することをお勧めします。
         ご視聴ありがとうございました。
        """
    }


}
