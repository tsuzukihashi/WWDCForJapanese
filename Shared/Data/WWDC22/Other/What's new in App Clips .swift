import Foundation

struct WhatsNewInAppClips: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "What's new in App Clips"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6591/6591_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10097/")!
    }

    var english: String {
        """
        Hi. I'm Charles Ying.
         Welcome to What's new in App Clips.
         An App Clip is a small part of an app.
         They're light and fast, and easy to discover, so you can quickly get what you need right when you need it.
         They can be found in Messages, Maps, Spotlight, and Safari, or out in the world with QR codes and App Clip Codes.
         One really cool example is Toast.
         Toast's app clip lets you scan a QR code to pay for your food right at your table! Toast configured their App Clip to open from an existing QR code printed on a receipt.
         The App Clip has resulted in users checking out faster, and more users choosing to install the full app.
         Building an App Clip into an existing flow is a great way to streamline your experience.
        Today you'll learn about new features that let your users do more with your App Clip, and make developing App Clips even easier.
         Let's start with the App Clip size limit.
        App Clips are light and fast, and designed for speed.
         To make App Clips feel instant, they need to be small.
         And since wireless networks are faster than they were two years ago, I'm happy to say that new in iOS 16, App Clips can now be up to 15 MB in size.
         This gives you more room to build your ideal experience.
         Set your App Clip's minimum version to iOS 16 for the new limit, or stay under 10 MB to be compatible with iOS 15 and earlier.
         Either way, you can always download additional resources after your App Clip launches.
         Speed is still key to a great experience.
         Your users won't always be in locations with a fast network, so optimizing your App Clip is still as critical as ever.
         To learn more about optimizing your App Clip, please watch, "Build light and fast App Clips”.
         Next, I'm really excited to show you a simple new tool that makes sure your App Clip experience or universal link is set up correctly.
         Here's how it works.
         On your iPhone or iPad, go to Developer Settings and under App Clips Testing, select Diagnostics.
         Now, enter your URL.
         You can turn on Developer Settings by connecting your device to Xcode.
         iOS will check your URL's configuration.
         If everything is set up right, you'll see these green checkboxes.
        But, if there's something wrong, you'll see a screen like this one that tells you exactly what's happening.
         This will help you fix problems like Safari's banner not showing, or navigating to a web page instead of your App Clip.
         Each diagnostic has a link to documentation to explain the configuration step further.
         Now you'll be able to see exactly what's wrong.
        App Clip diagnostics checks App Clip experiences that use physical codes, Safari and iMessage, and it will also check your universal link associated domains configuration.
         This simple new tool makes it so much easier to get your configuration right.
        Next, CloudKit.
        CloudKit is a framework that lets your app access data stored on iCloud.
         Up until now, CloudKit has not been available for App Clips.
         Your App Clip might be using a server to read data or resources.
        New in iOS 16, App Clips can also read data and resources stored in a CloudKit public database.
         You can now share the same code, access the same data in both your app and App Clip with all the power and scale CloudKit provides.
         An important difference between apps and App Clips is that App Clips can read from a public database but can't write data to CloudKit.
         App Clips also can't use cloud documents and the key-value store.
         This keeps the promise to users that when an App Clip isn't used anymore, iOS will delete the App Clip and its data.
        To enable CloudKit for your App Clip in Xcode, open your App Clip target's Signing and Capabilities tab, and select the CloudKit container you want your App Clip to use.
         This CloudKit container can be a new or existing container shared with your full app.
        Here's an example of how to read CloudKit public data from your App Clip.
         Create a CKContainer with the container's identifier and access the publicCloudDatabase property.
         Then fetch the record you want from the public database.
        Next, keychain migration.
        Today, when you want to transfer sensitive information, like authentication tokens and payment information from your App Clip to your full app, your App Clip would store this data in a shared app group container.
         iOS saves this data when a user upgrades from your App Clip to your full app.
        Your full app reads the app group container and stores that information in the keychain.
        However, the keychain is the ideal place to securely store this type of information.
         New this year, when a user installs your app, items stored in your App Clip's keychain are transferred from your App Clip to your app.
         Now your App Clip can simply store secure items in the keychain and they will be moved to your app when it's installed.
        Shared keychain groups and iCloud Keychain are not supported.
         This keeps the promise to users that keychain information won't stick around when an App Clip isn't used anymore.
        Here's an example of how to store and read login information in the keychain.
         The code is the same for both app and App Clip.
         You can add new items to the keychain with SecItemAdd.
         And fetch these items from the keychain with SecItemCopyMatching.
         And add a label to your items to help your full app identify that the items were saved by your App Clip.
        Finally, the App Clip experiences API.
         As your app clip grows, you'll have more and more advanced App Clip experiences, each with their own information or location.
         You need an easy way to add and update all of these experiences.
         App Store Connect has an App Clip experiences web API that's designed to automate this workflow.
         Let's look at an example that uses this API to add an advanced App Clip experience.
        First, get the App Clip resource ID.
         Next, upload your header image.
         Last, create the advanced App Clip experience.
         First, let's find the resource ID for the app clip.
         Call the web API with your app's item ID and App Clip bundle ID.
         And from the response, save the App Clip resource ID for later.
         Next, upload a header image for the advanced App Clip experience.
         Save the header image's resource ID for the next step.
         Last, with your App Clip resource ID and your header image ID, we can now create your advanced App Clip experience.
        There are three dictionaries to fill in: attributes, relationships, and included.
        In the attributes dictionary, add information like the action name, which category and language, and the link for the advanced App Clip experience.
         If your advanced experience is tied to a Maps location, add a place dictionary.
         In the place dictionary, add the matching Maps business place name, a map action, and the map coordinates.
         In the relationships dictionary, add the App Clip resource ID and the header image ID.
         And in the included dictionary, add a localized title and subtitle for the advanced App Clip experience.
         And that's it! With this App Store Connect API, you can fully automate creating advanced App Clip experiences.
         To learn more about App Store Connect, check out “Automating App Store Connect” and “What's new in App Store Connect” from WWDC 2020.
        To wrap up, the new App Clip size limit gives you more room to build your ideal experience.
         App Clip diagnostics tools are a great way to understand your App Clip and universal link configuration end to end.
         CloudKit and keychain can ease your development by sharing more code with your app.
         And the App Clip experiences API automates the workflow for managing your advanced App Clip experiences.
         To learn more about developing App Clips, please watch “What's new in App Clips” from WWDC 2021 and “Design great App Clips” from WWDC 2020.
        You developers have made such great App Clips.
         They're so creative! We hope these new features help you build your next great App Clip.
         Thanks for watching!

        """
    }

    var japanese: String {
        """
        こんにちは。私はチャールズ・インです。
         What's new in App Clipsへようこそ。
         アプリクリップは、アプリの小さな部品です。
         軽くて速く、発見しやすいので、必要なものを必要な時にすばやく手に入れることができます。
         メッセージ、マップ、Spotlight、Safariで見つけることができるほか、QRコードやApp Clipコードを使って世界中に配置することもできます。
         たとえば、Toastは実にクールな例です。
         トーストのアプリクリップを使えば、QRコードをスキャンして、テーブルに座ったまま食事の代金を支払うことができます。トーストは、レシートに印刷された既存のQRコードからアプリクリップを開くように設定しました。
         アプリクリップは、ユーザーのチェックアウト時間を短縮し、より多くのユーザーが完全なアプリをインストールすることを選択する結果となりました。
         既存のフローにApp Clipを組み込むことは、お客様のエクスペリエンスを効率化する素晴らしい方法です。
        今日は、ユーザーがApp Clipでより多くのことを行えるようにする新機能と、App Clipの開発をより簡単にする機能について説明します。
         まず、App Clipのサイズ制限について説明します。
        App Clipは、軽くて速い、スピード重視のデザインです。
         App Clipは、軽くて速く、スピード感を重視して設計されています。そのため、App Clipは小さくなければなりません。
         iOS 16では、ワイヤレスネットワークが2年前よりも高速になったため、App Clipのサイズを最大15MBまで増やせるようになりました。
         これによって、理想的なエクスペリエンスを構築するための余裕が生まれます。
         iOS 16ではApp Clipの最小バージョンを15MBに設定し、iOS 15以前では10MBに設定します。
         いずれにせよ、App Clipの起動後にいつでも追加のリソースをダウンロードすることができます。
         優れた体験の鍵は、やはりスピードです。
         ユーザーが常に高速ネットワークのある場所にいるとは限らないため、App Clipを最適化することはこれまでと同様に重要です。
         アプリクリップの最適化について詳しくは、「軽くて高速なアプリクリップを構築する」をご覧ください。
         次に、App Clipエクスペリエンスやユニバーサルリンクが正しく設定されているかどうかを確認するための、シンプルな新しいツールを紹介します。
         その仕組みは次のとおりです。
         iPhoneまたはiPadで、開発者設定に移動し、App Clips Testingで、Diagnosticsを選択します。
         ここで、あなたのURLを入力します。
         デバイスをXcodeに接続することで、Developer Settingsをオンにすることができます。
         iOSがあなたのURLの設定をチェックします。
         すべてが正しく設定されていれば、このような緑色のチェックボックスが表示されます。
        しかし、何か問題がある場合は、このような画面が表示され、何が起こっているのかを正確に教えてくれます。
         Safariのバナーが表示されない、アプリクリップではなくウェブページに移動してしまうなどの問題を解決するのに役立ちます。
         各診断には、設定ステップをさらに詳しく説明するためのドキュメントへのリンクがあります。
         これで、何が問題なのかを正確に把握することができます。
        App Clip診断では、物理コード、Safari、iMessageを使うApp Clip体験をチェックし、ユニバーサルリンクの関連ドメイン設定も確認します。
         このシンプルな新しいツールによって、設定を正しく行うことがとても簡単になります。
        次に、CloudKitです。
        CloudKitは、アプリがiCloudに保存されているデータにアクセスできるようにするフレームワークです。
         これまで、CloudKitはApp Clipでは利用できませんでした。
         あなたのApp Clipは、データやリソースを読み込むためにサーバーを使用しているかもしれません。
        iOS 16の新機能として、App ClipはCloudKitのパブリックデータベースに保存されたデータやリソースも読み取れるようになりました。
         CloudKitが提供するすべてのパワーとスケールを使って、アプリとApp Clipの両方で同じコードを共有し、同じデータにアクセスできるようになりました。
         アプリとApp Clipの重要な違いは、App Clipはパブリックデータベースから読み取ることができますが、CloudKitにデータを書き込むことはできないことです。
         また、App Clipsはクラウド・ドキュメントとKey-Value Storeを使用することができません。
         これにより、App Clipが使用されなくなると、iOSがApp Clipとそのデータを削除するというユーザへの約束が守られます。
        XcodeでApp ClipのCloudKitを有効にするには、App ClipターゲットのSigning and Capabilitiesタブを開き、App Clipに使用させたいCloudKitコンテナを選択します。
         このCloudKitコンテナは、フルアプリと共有される新規または既存のコンテナにすることができます。
        以下は、App ClipからCloudKitのパブリックデータを読み込む方法の例です。
         コンテナの識別子でCKContainerを作成し、publicCloudDatabaseプロパティにアクセスします。
         そして、パブリックデータベースから欲しいレコードをフェッチします。
        次に、キーチェーンマイグレーションです。
        今日、認証トークンや支払い情報などの機密情報を App Clip からフルアプリに転送したい場合、App Clip はこのデータを共有アプリグループコンテナに保存することになります。
         iOSは、ユーザーがApp Clipからフルアプリケーションにアップグレードする際に、このデータを保存します。
        フルアプリは、アプリグループコンテナを読み取り、その情報をキーチェーンに保存します。
        しかし、キーチェーンは、この種の情報を安全に保存するための理想的な場所です。
         今年の新機能として、ユーザーがアプリケーションをインストールすると、App Clipのキーチェーンに保存されているアイテムが、App Clipからアプリケーションに転送されます。
         これにより、App Clipはキーチェーンに安全なアイテムを保存するだけで、それがインストールされた時にあなたのアプリケーションに移動するようになります。
        共有キーチェーングループとiCloud Keychainはサポートされていません。
         これにより、App Clipが使われなくなっても、キーチェーンの情報が残らないというユーザーへの約束が守られます。
        以下は、ログイン情報をキーチェーンに保存し、読み取る方法の例です。
         コードは、アプリとApp Clipの両方で同じです。
         SecItemAddを使うと、キーチェーンに新しいアイテムを追加することができます。
         そしてSecItemCopyMatchingでキーチェーンからこれらのアイテムをフェッチします。
         また、アイテムにラベルを追加することで、そのアイテムがApp Clipによって保存されたことを、アプリ全体で識別できるようになります。
        最後に、App ClipエクスペリエンスAPIです。
         アプリクリップが成長するにつれて、より高度なアプリクリップ体験を持つようになり、それぞれが独自の情報や場所を持つようになります。
         これらのエクスペリエンスをすべて簡単に追加および更新する方法が必要です。
         App Store Connectには、このワークフローを自動化するために設計されたApp Clip Experience Web APIがあります。
         このAPIを使用して、高度なApp Clipエクスペリエンスを追加する例を見てみましょう。
        まず、App ClipリソースIDを取得します。
         次に、ヘッダー画像をアップロードします。
         最後に、高度なApp Clipエクスペリエンスを作成します。
         まず、アプリクリップのリソースIDを取得しましょう。
         アプリのアイテムIDとApp ClipのバンドルIDを指定して、Web APIを呼び出します。
         そして、その応答から、App ClipのリソースIDを保存しておきます。
         次に、高度なApp Clipを体験してもらうために、ヘッダー画像をアップロードします。
         ヘッダー画像のリソースIDは、次のステップのために保存しておきます。
         最後に、App ClipリソースIDとヘッダー画像IDを使って、高度なApp Clipエクスペリエンスを作成します。
        属性、リレーションシップ、インクルードという3つの辞書を入力します。
        属性辞書には、アクション名、どのカテゴリと言語、高度なApp Clipエクスペリエンスのリンクなどの情報を追加します。
         高度なエクスペリエンスがマップの場所に結び付けられている場合は、場所辞書を追加します。
         場所辞書に、一致するMapsビジネスプレイス名、マップアクション、およびマップ座標を追加します。
         リレーションシップ辞書に、App ClipリソースIDおよびヘッダー画像IDを追加します。
         また、included辞書に、高度なApp Clipエクスペリエンスのためのローカライズされたタイトルとサブタイトルを追加します。
         以上です。このApp Store Connect APIを使用すると、高度なApp Clipエクスペリエンスの作成を完全に自動化することができます。
         App Store Connectについてもっと知りたい方は、WWDC 2020の「Automating App Store Connect」と「What's new in App Store Connect」をご覧ください。
        最後に、新しいApp Clipのサイズ制限により、理想的なエクスペリエンスを構築するための余地が増えました。
         App Clip診断ツールは、App Clipとユニバーサルリンクの構成を端から端まで把握するのに最適な方法です。
         CloudKitとkeychainは、より多くのコードをアプリと共有することで、あなたの開発を容易にします。
         また、App Clip experiences APIは、高度なApp Clip体験を管理するためのワークフローを自動化します。
         App Clipの開発については、WWDC 2021の「What's new in App Clips」、WWDC 2020の「Design great App Clips」をご覧ください。
        開発者のみなさんは、とても素晴らしいApp Clipを作っていますね。
         彼らはとてもクリエイティブです これらの新機能が、次の素晴らしいApp Clipを作る手助けになることを願っています。
         ご視聴ありがとうございました。

        """
    }
}

