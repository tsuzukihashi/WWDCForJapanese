import Foundation

struct GettoKnowDeveloperMode: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Get to know Developer Mode"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6697/6697_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/110344/")!
    }

    var english: String {
        """
        Hi, folks.
         My name is Pavlo.
         I work on security technologies that help keep you and your users safe.
         Today I'm going to tell you about some upcoming changes that may impact the way you develop, test, and deploy your applications.
         First, I want to tell you what Developer Mode is, the reasoning behind why it was created, the security benefit it brings, and the workflows that it will affect.
         Then, we will discuss when and how to turn on Developer Mode.
         And then we will finish off this session with a walk-through of the tools we built to support automation flows for when you're working with many devices, like in a testing lab environment.
         OK, so what is Developer Mode? It's a new mode in iOS 16 and watchOS 9 that enables common developer workflows.
         Developer Mode is disabled by default and requires you to explicitly enroll the device into Developer Mode.
         Your enrollment persists across reboots and system updates.
         And of course, we have built tools that enable you to automate Developer Mode setup if you want.
         A natural question you will have is, "Why are we introducing Developer Mode?" The reason is that powerful developer features are being abused in targeted attacks.
         Meanwhile, the vast majority of users do not need such functionality and so they shouldn't be enabled by default.
         This way we can retain the development capabilities that you rely on and increase the security for users with mitigations that otherwise would get in your way.
         Now having said that, most common distribution flows will not require Developer Mode.
         For example, deploying your application through TestFlight or using Enterprise in-house distribution does not require Developer Mode.
         And of course, distributing your applications through the App Store does not require Developer Mode.
         It's only required for when you, the developer, are actively developing your application on your device.
         All right, by this point I'm sure you can't wait until I tell you how you would get started with using Developer Mode.
         So let's go through when you need to turn on Developer Mode and how to do it.
         You should turn Developer Mode on if you need to run and install development signed applications, including applications signed by using a Personal Team; debug and instrument your applications; or you want to use testing automation on your device.
         Turning on Developer Mode is straightforward, but first you need to connect your device to Xcode for the Developer Mode menu item to appear.
         The beta releases that you have downloaded will have the menu item always visible for the time being.
         Installing a development-signed application without Xcode, like through Apple Configurator, will also make the menu item visible.
         Once you've done that, you can find the Developer Mode controls under Privacy & Security in Settings.
         And for automation, you can use the new devmodectl that ships by default on macOS Ventura, but more on that later.
         OK, so let's walk through with how you would turn on Developer Mode.
         In front of me, I have an iPhone 13 Pro that I just picked up to run my code on.
         First, I'm going to plug it in to my Mac that has Xcode already running.
         As you can see, Xcode recognizes that this device does not have Developer Mode enabled and will prevent me from running this application.
         But now that I have plugged it in, I can go into Settings, Privacy & Security, Developer Mode.
        Turning on Developer Mode requires that you reboot your device, so let's go ahead and do that.
        Once the device has rebooted, you will be prompted once again to confirm your decision.
         Once you tap Turn On, you will be good to go.
         Now, Xcode sees that the device has Developer Mode enabled, and I can run my application.
        While this flow works when you're working with a single device, this process can be time consuming if you're dealing with multiple devices.
         For this reason, we've built tools that help you automate this process.
         Automation flows have one limitation: only devices without a passcode can have Developer Mode automatically enabled.
         This is because when you restart your iPhone you need to unlock your device before your device can be interacted with.
         To support automation, macOS Ventura ships with devmodectl that you can use to either enable Developer Mode on a single device that you have already connected, or in Streaming Mode that will automatically turn on Developer Mode on all devices that you plug in.
        Here I have two devices plugged into my Mac.
        They don't have passcodes, and I don't want to manually set up Developer Mode on them.
         So I'm going to run devmodectl with the streaming subcommand.
         This will automatically reboot the connected devices and set up Developer Mode.
         Once Developer Mode has been set up, you will get a notification on the device.
        And now these devices are good to go.
         All right, that's all I have for you today.
         To wrap it up, in iOS 16 and watchOS 9 you will have to enable Developer Mode to perform common development activities like deploying and debugging your applications.
         And if you need to automate Developer Mode setup, you can use devmodectl, which ships in macOS Ventura.
         If you want to learn more about security changes that may impact your macOS distribution workflows, check out the "What's new in notarization for Mac apps" talk.
         I hope you have a great rest of your day and happy coding!
        """
    }

    var japanese: String {
        """
        みなさん、こんにちは。
         私の名前はパブロです。
         私は、あなたとあなたのユーザーを安全に保つためのセキュリティ技術に携わっています。
         今日は、あなたのアプリケーションの開発、テスト、デプロイの方法に影響を与えるかもしれない、いくつかの今後の変更についてお話します。
         まず、デベロッパーモードとは何か、それが作られた理由、それがもたらすセキュリティ上の利点、そしてそれが影響するワークフローについてお話したいと思います。
         そして、いつ、どのようにDeveloper Modeをオンにするかについて説明します。
         そして、このセッションの最後には、テストラボ環境のように多くのデバイスを扱う場合の自動化フローをサポートするために私たちが構築したツールのウォークスルーが行われます。
         デベロッパーモードとは何でしょうか？iOS 16とwatchOS 9の新しいモードで、一般的なデベロッパーのワークフローを可能にするものです。
         デベロッパーモードはデフォルトでは無効になっており、デバイスをデベロッパーモードに明示的に登録する必要があります。
         登録した内容は、再起動やシステムアップデートを経ても持続します。
         もちろん、デベロッパーモードの設定を自動化するためのツールも用意されています。
         なぜDeveloper Modeを導入するのか」という疑問は当然あるでしょう。その理由は、強力な開発者向け機能が標的型攻撃で悪用されているからです。
         一方、大多数のユーザーはそのような機能を必要としていないので、デフォルトで有効化すべきではない。
         こうすることで、皆さんが頼りにしている開発機能を保持し、そうでなければ邪魔になるような緩和策を講じて、ユーザーのセキュリティを高めることができるのです。
         とはいえ、ほとんどの一般的な配布フローでは、Developer Mode は必要ないでしょう。
         たとえば、TestFlight を使用してアプリケーションを配布する場合や、Enterprise 社の社内配布を使用する場合、Developer Mode は必要ありません。
         もちろん、App Store を通してアプリケーションを配布する場合にも、Developer Mode は必要ありません。
         開発者であるあなたが、あなたのデバイス上でアプリケーションをアクティブに開発している場合にのみ、Developer Modeが必要となります。
         さて、ここまでくれば、デベロッパーモードの使い方を説明するのが待ち遠しくなってきたことでしょう。
         では、どのような場合にデベロッパーモードをオンにする必要があるのか、その方法を説明します。
         Personal Team で署名されたアプリケーションを含む開発署名付きアプリケーションを実行およびインストールする必要がある場合、アプリケーションをデバッグおよびインストルメントする必要がある場合、またはデバイスでテスト自動化を使用する場合、Developer Mode をオンにする必要があります。
         デベロッパーモードをオンにするのは簡単ですが、まず、デベロッパーモードのメニュー項目が表示されるように、あなたのデバイスを Xcode に接続する必要があります。
         ダウンロードしたベータ版では、当分の間、メニュー項目は常に表示されています。
         Apple Configurator 経由などで、Xcode を使わずに開発署名付きアプリケーションをインストールした場合も、メニュー項目が表示されるようになります。
         そうすると、設定の「プライバシーとセキュリティ」にデベロッパモードのコントロールが表示されるようになります。
         自動化については、macOS Venturaにデフォルトで搭載されている新しいdevmodectlを使うことができますが、これについては後で詳しく説明します。
         では、どのようにDeveloper Modeをオンにするか、順を追って説明しましょう。
         私の目の前には、コードを実行するために手に入れたばかりのiPhone 13 Proがあります。
         まず、Xcodeがすでに起動しているMacに接続します。
         見ての通り、XcodeはこのデバイスがDeveloper Modeを有効にしていないことを認識し、このアプリケーションを実行できないようにします。
         しかし、このデバイスを接続したことで、「設定」、「プライバシーとセキュリティ」、「デベロッパーモード」を開くことができます。
        開発者モードをオンにするには、デバイスを再起動する必要があるので、先にそれを行いましょう。
        デバイスの再起動が完了すると、もう一度確認画面が表示されます。
         Turn Onをタップしたら、もう大丈夫です。
         これで、XcodeはデバイスがDeveloper Modeを有効にしていることを確認し、アプリケーションを実行できるようになりました。
        このフローは、1台のデバイスで作業する場合は有効ですが、複数のデバイスを扱う場合は、このプロセスに時間がかかることがあります。
         このため、このプロセスを自動化するためのツールを開発しました。
         自動化フローには1つの制限があります。パスコードのないデバイスだけが、自動的にDeveloper Modeを有効にすることができます。
         これは、iPhoneを再起動する際に、デバイスを操作する前にロックを解除する必要があるためです。
         自動化をサポートするために、macOS Ventura には devmodectl が同梱されています。これを使えば、すでに接続している一つのデバイスに対して Developer Mode を有効にするか、ストリーミングモードで、接続した全てのデバイスに対して自動的に Developer Mode を有効にすることができます。
        ここでは2つのデバイスがMacに接続されています。
        これらはパスコードを持っていないので、手動でDeveloper Modeを設定する必要はありません。
         そこでdevmodectlにstreamingサブコマンドを付けて実行します。
         これで、接続されたデバイスが自動的に再起動し、Developer Modeが設定されます。
         Developer Mode がセットアップされると、デバイスに通知が表示されます。
        そして、これでこれらのデバイスは使えるようになりました。
         さて、今日はこれでおしまいです。
         まとめると、iOS 16とwatchOS 9では、アプリケーションのデプロイやデバッグなどの一般的な開発活動を行うために、Developer Modeを有効にする必要があります。
         また、Developer Modeのセットアップを自動化する必要がある場合は、macOS Venturaに同梱されているdevmodectlを使用することができます。
         macOSの配布ワークフローに影響を与える可能性のあるセキュリティの変更についてもっと知りたい方は、「Macアプリの公証に関する新情報」の講演をご覧ください。
         それでは、今日も良い一日をお過ごしください！ハッピーコーディング
        """
    }
}

