import Foundation

struct MeetWebPushForSafari: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Meet Web Push for Safari"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6592/6592_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10098/")!
    }

    var english: String {
        """
        Brady Eidson: Hello.
         My name is Brady Eidson.
         I'm an engineer on the WebKit Architecture team.
         I am thrilled to introduce you to Web Push in Safari.
         Web Push lets you remotely send notifications to your web application's users.
         Here, a notification displays from webkit.org in the upper-right of the screen.
         Clicking the notification opens a WebKit blog post in a new window.
         Before I get into other details on how this works, I want to answer a few questions up front I know many of you will have.
        Web Push is supported in Mac Safari beginning with macOS Ventura.
         And Web Push will be coming to iOS and iPadOS next year.
        Apple's Safari Push Notifications have been an option for reaching Mac Safari users for quite a while.
         While it will continue to work, today I'm happy to announce that we have added support for Web Push, and this really is Web Push! The same combination of various web standards as implemented in other browsers.
         We'll go over those standards more later, but… the most important takeaway is that if you've coded your application to web standards, you won't need to make any changes for it to work in Safari.
         Of course, if you exclude Safari through browser detection, then you have some work ahead of you.
         Now would be a great time to switch from browser detection to feature detection, which has always been the best practice.
         We're using the same Apple Push Notification service that powers native push on all Macs and iOS devices, but no Apple Developer account is required to reach Safari users.
         We are using new end point URLs for Web Push, which brings up another thing you might be doing to unintentionally exclude Safari.
         If you tightly manage push end points on your server, make sure you allow URLs from any subdomain of push.apple.com.
         Moving beyond answers to those important questions, let's get into more detail.
         First, we'll look at the Web Push experience in Safari from a user's perspective.
         Then we'll cover the entire Web Push flow, from asking for permission to handling a click on an entry in Notification Center.
         Finally, we'll see what it takes to add Web Push to an existing web app.
         But first, the Mac Safari user experience.
         And I can think of no better way to cover that than with a demo.
         Here's Safari on macOS Ventura.
         I have webkit.org open in this browser tab.
         I need to keep up-to-date with the WebKit open source project, and Web Push is a great way to do that.
         webkit.org is not allowed to request permission to push without the user asking with a user gesture.
         So I'll click this bell-shaped button here to subscribe for notifications.
         What you see here is the system notifications prompt– the same one you'd see for any other application.
         In this case, it's on behalf of webkit.org.
         I will click "allow," and I'm all set.
         webkit.org is giving me the option to be notified about new blog posts as well as new commits to the source code repository.
         I know being notified for every commit will distract me from important work, but I absolutely want to be notified about new blog posts.
         So I'll check that box now.
         Coincidentally, somebody must've just published the WebKit blog post about Web Push.
         This notification looks just like any other and is attributed to webkit.org.
         I can click it to activate, and there is the blog post, open in Safari.
         Once a user has granted permissions to a website, they maintain control over that permission.
         As a macOS user, I'm used to managing Notification preferences inside System Settings, and that's where I can go to configure webkit.org's notifications.
         The same rich configuration as I'd find for any other app or service.
         As a Safari user, I'm used to managing website settings from inside Safari preferences.
         I can also go there to turn webkit.org's permissions on or off.
         And that's how Web Push works for users in Mac Safari.
         Before we move on, I want to reiterate a few things covered in that demo.
         First, we don't want users to be spammed by subscription requests they haven't asked for.
         So a website may only request a push subscription in response to a mouse click or a keystroke.
         Once a website has permission to show notifications to the user, the user controls that permission.
         They can choose to manage it in Safari's preferences or System Settings.
         And the setting will stay in sync if they happen to manage it in both.
         Finally, if you provide notifications for different types of events, it is a best practice to provide fine-grained controls for notification types within your web app, just like other apps do.
         Now that you've seen Web Push in action, let's dig in to what's happening at each step.
         Some of you are already intimately familiar with this.
         But for those of you new to Web Push, I'll go step by step, referring you to the relevant standards and documentation along the way.
         The first thing that happens is a user visits your website in a browser tab.
         Here's webkit.org open in Safari.
         Since it is open in a tab, it can install a Service Worker.
         A Service Worker is a unit of JavaScript that operates on behalf of an entire domain, separate from a currently open browser tab.
         Once the Service Worker script is installed, your web app is eligible to request a push subscription.
         As already mentioned, this request must be tied to a user gesture.
         webkit.org requests permission when clicking this bell-shaped button, which fulfills the user gesture requirement.
         When your site asks for a push subscription, the user sees this system prompt.
         Here is where they can make the final call on granting your website this powerful ability.
        It is possible the user might deny the request.
         Your JavaScript should be prepared to handle that.
         But assuming the user grants permission, your JavaScript gets back a PushSubscription object.
         This includes everything your server needs to send a push message to this user in this browser.
         Information like the exact URL end point to use.
         You send this PushSubscription payload back to your server in whatever manner works best for your web app.
         Many popular server packages have Web Push support to manage subscriptions, or you can roll your own.
         The same pertains to how and when to actually send a push message to the URL end points your server knows about.
         I can't tell you when to do so.
         That's up to you and your website.
         But once you've decided to send that push message, I can help with what happens next.
         Remember how push requires an installed Service Worker? Once your server has sent a push message and Safari receives it, Safari wakes up your Service Worker and sends it a JavaScript push event.
         Showing a notification to the user in Notification Center is a requirement while handling the push event.
         Receiving the push event and displaying the notification happens if your website is currently open in a browser tab.
         It also happens if your website is not currently open in a browser tab.
         In the case of Safari on macOS Ventura, this happens even if Safari is not currently running.
         The final step: If your user clicks on that notification, a notificationclick event is sent to your Service Worker so it can respond appropriately.
         For example, by opening a new window to the URL associated with that notification.
         With that understanding of the Web Push flow under our belt, it's time to get into even more detail by actually adding Web Push support to an existing web app.
         Besides webkit.org, Browser Pets is the most mission critical internal tool for the Safari and WebKit teams.
         Keeping everyone in the department up-to-date on their favorite WebKittens and Pups on Safari has always been the mission statement of Browser Pets, and Web Push has made that easier than ever.
         Our internal BrowserPets domain already had a ServiceWorker script registered to speed up page loads and synchronize between multiple tabs.
         At a high level, a ServiceWorker script looks a lot like this.
         When an engineer visits the Browser Pets page in a tab, this JavaScript excerpt either determines if the Service Worker script has already been registered, or registers it if necessary.
         Notice we're practicing feature detection here, previously mentioned as a best practice.
         With the Service Worker prerequisite taken care of, we're ready to subscribe for push.
         Remember, you cannot request a push subscription without an explicit user gesture.
         Running this script in response to a button's onclick handler is one of many ways to satisfy that requirement.
         Once the user clicks that button, here's code to request a push subscription.
         I'll go into each of these points in more detail.
         First, we need to configure the request for a push subscription.
         An important bit for that is the public key our server uses to identify themselves to Apple's push servers.
         Here we use the standard technology called VAPID, the same as other browsers.
         I won't go over the sometimes complex details of VAPID here, but there are resources on the web to help you with the best solution for your server's setup.
         With the VAPID key set, we're ready to configure the subscription request.
         Notice we are explicitly stating that we promise to always make pushes user visible.
         While the standard for the JavaScript Push API optionally accommodates silent JavaScript runtime in response to a push, most browsers do not support that.
         Safari does not support that.
         And like most websites, Browser Pets does not need that.
         Then we request permission to push.
         This line of JavaScript results in the permission prompt for the user to either approve or reject.
         Assuming the user grants permission– which all Safari team members do for Browser Pets– this gives us a PushSubscription object with the details on how to reach this user in their browser.
         Things like the URL end point and the key used to encrypt the push message for transit.
         Finally, we need to send all of those details to our server.
         As mentioned before, the specifics of this will vary based on your exact application.
         Our BrowserPets server uses WordPress, which already has a few plugins to support standard Web Push.
         It's likely you'll find the same is true for your backend, and there are resources on the web to help find the right solution for just about any setup.
         Now we need to go back to our Service Worker JavaScript code.
         It will need to handle a few new events, starting with the push event.
         When a push message makes its way from the Browser Pets server to this browser, this Service Worker has a push event sent to it.
         That event contains a PushMessageData object which has multiple ways of accessing the data sent by your server.
         We use the JSON accessor here.
         Remember how when we subscribed for push, our JavaScript promised they would always be user visible? That means we must always show a platform native notification in response to each push.
         It is best to do this as early as possible in your push event handler.
         We're pulling everything we need out of that JSON blob to configure the notification, including setting up an action with a URL.
         That will come in handy in just a moment.
         After the notification is shown, we need to handle the user clicking on it.
         One more event for our Service Worker script to handle.
         In this notificationclick handler, BrowserPets will take the URL from the notification that was clicked to open a new window.
         Take note: This is a very common pattern.
         That's all the JavaScript we need to write to support Web Push.
         Of course, it's best to have some help while developing.
         As usual, that's where Web Inspector comes in.
         In addition to helping debug your website open in a browser tab, Web Inspector can also inspect Service Worker instances and set breakpoints on event handlers.
         All of this together will let you inspect and debug the JavaScript that subscribes for push as well as the service worker code that handles the push event and notification events.
         Additionally, the Apple Push Notification servers will give you human readable errors if something goes wrong when you attempt to publish a push message.
         Check out the links associated with this session for further documentation.
         I'd also like to get into more detail on a few points that came up while writing that code, with direct regards to user privacy and power usage.
         Importantly–and this is not the first time I've said this– subscribing for push requires a user gesture.
         As with other privileged features of the web platform, it's the right thing for user trust to require that the user actually asked to enable Web Push.
         As mentioned when I showed you the code on how to request a push subscription, you must promise that pushes will be user visible.
         Handling a push event is not an invitation for your JavaScript to get silent background runtime.
         Doing so would violate both a user's trust and a user's battery life.
         When handling a push event, you are in fact required to post a notification to Notification Center.
         Other browsers all have countermeasures against violating the promise to make pushes user visible, and so does Safari.
         In the beta build of macOS Ventura, after three push events where you fail to post a notification in a timely manner, your site's push subscription will be revoked.
         You will need to go through the permission workflow again.
         That's all.
         We're genuinely proud to support Web Push and excited that any site can use it, no Apple Developer account required.
         As long as you've coded to the standards and use feature detection, so you don't unwittingly exclude Safari, your users will already get the benefit of Web Push in Safari 16 on macOS Ventura.
         As usual, we've added tons of other new stuff to Safari and WebKit this year, and I hope you'll check out that session to learn more.
         Thank you for watching.
         I hope you have a great rest of WWDC 2022.

        """
    }

    var japanese: String {
        """
        Brady Eidson：こんにちは。
         私の名前はBrady Eidsonです。
         WebKitアーキテクチャーチームのエンジニアです。
         SafariのWeb Pushを紹介できることを嬉しく思っています。
         Web Pushを使うと、Webアプリケーションのユーザにリモートで通知を送ることができます。
         ここでは、webkit.org からの通知が右上に表示されています。 org からの通知が画面右上に表示されています。
         この通知をクリックすると、WebKit のブログ記事が新しいウィンドウで表示されます。
         この仕組みの詳細に入る前に、多くの人が抱くであろういくつかの質問に先に答えておきたいと思います。
        Web Pushは、macOS VenturaからMac Safariでサポートされています。
         そして、Web Pushは来年にはiOSとiPadOSに搭載される予定です。
        AppleのSafari Push Notificationは、かなり長い間、Mac Safariのユーザーにリーチするためのオプションとして存在してきました。
         今後も機能しますが、今日はWeb Pushのサポートを追加したことをお知らせします。これは本当にWeb Pushなんですよ。他のブラウザで実装されているのと同じように、さまざまなウェブ標準を組み合わせています。
         それらの標準については後で詳しく説明しますが、...最も重要なことは、アプリケーションをウェブ標準に合わせてコーディングした場合、Safariで動作させるために変更を加える必要がない、ということです。
         もちろん、ブラウザ検出によってSafariを除外している場合は、いくつかの作業を行う必要があります。
         今こそ、ブラウザ検出から、常にベストプラクティスである機能検出に切り替える絶好の機会でしょう。
         すべてのMacとiOSデバイスでネイティブプッシュを駆動するのと同じApple Push Notificationサービスを使用していますが、Safariユーザーに到達するためにApple Developerアカウントは必要ありません。
         Webプッシュの新しいエンドポイントURLを使用しているため、意図せずにSafariを除外している可能性があります。
         サーバーでプッシュのエンドポイントを厳密に管理している場合は、push.apple.comの任意のサブドメインからのURLを許可していることを確認してください。
         これらの重要な質問に対する答えの先にある、より詳細な説明に入りましょう。
         まず、ユーザーの視点からSafariでのWeb Pushの体験を見ていきます。
         次に、許可を求めるところから、通知センターのエントリをクリックしたときの処理まで、Web Pushの全体的なフローを取り上げます。
         最後に、既存のWebアプリケーションにWeb Pushを追加するために必要なことを見ていきます。
         その前に、Mac Safariのユーザーエクスペリエンスについて説明します。
         そのためには、デモを行う以外に方法はありません。
         これがmacOS VenturaのSafariです。
         このブラウザのタブでwebkit.orgを開いています。 orgをこのブラウザのタブで開いています。
         私はWebKitオープンソースプロジェクトの最新情報を入手する必要がありますが、Web Pushはそのための素晴らしい方法です。
         webkit. org は、ユーザーがジェスチャーで尋ねることなく、プッシュの許可を要求することはできません。
         そこで、ここにあるこの鐘の形をしたボタンをクリックして、通知を購読することにします。
         ここに表示されているのは、システム通知のプロンプトです - 他のアプリケーションでも表示されるものと同じです。
         この場合、webkit.org を代表しています。 org を代表しています。
         許可」をクリックすると、すべての設定が完了します。
         webkit. webkit.org は、新しいブログの投稿やソースコードリポジトリへの新しいコミットについて通知するオプションを提供してくれています。
         すべてのコミットについて通知を受けると重要な仕事から遠ざかってしまうことは分かっていますが、新しいブログの投稿については絶対に通知されたいのです。
         というわけで、今すぐチェックを入れることにする。
         偶然にも、誰かが WebKit のブログで Web Push に関する記事を公開したところだったのでしょう。
         この通知は他のものと同じように見え、webkit.org に起因しています。 org に帰属します。
         この通知をクリックして有効にすると、ブログの記事がSafariで開かれます。
         ユーザーがウェブサイトにアクセス許可を与えると、その許可に対するコントロールが維持されます。
         macOSユーザーとして、私はシステム設定内の通知設定の管理に慣れており、そこでwebkit. そこで webkit.org の通知を設定することができます。
         他のアプリやサービスと同じように、豊富な設定を行うことができます。
         Safariのユーザーとして、私はSafariの環境設定からウェブサイトの設定を管理することに慣れています。
         また、webkit.orgのパーミッションのオン／オフもここで行えます。 orgのパーミッションのオン／オフを切り替えることもできます。
         そして、これがMac Safariのユーザーに対するWeb Pushの仕組みです。
         次に進む前に、このデモで取り上げられたいくつかの事柄をもう一度説明したいと思います。
         まず、ユーザーが要求していない購読のリクエストによってスパムを受けることを望んでいません。
         そのため、Webサイトは、マウスクリックまたはキーストロークに対応してのみ、プッシュ配信を要求することができます。
         Webサイトがユーザーに通知を表示する許可を得ると、その許可をユーザーが管理できるようになります。
         ユーザーは、Safariの環境設定またはシステム設定から、その管理を選択することができます。
         また、両方で管理した場合、設定は同期されたままになります。
         最後に、さまざまな種類のイベントに対する通知を提供する場合、他のアプリと同様に、Webアプリ内で通知の種類を細かく制御できるようにすることがベストプラクティスと言えます。
         さて、Web Pushの動作を見たところで、各ステップで何が起こっているのかを掘り下げてみましょう。
         すでによくご存知の方もいらっしゃると思います。
         しかし、Web Push に初めて触れる方のために、関連する標準やドキュメントを参照しながら、順を追って説明します。
         まず、ユーザーがブラウザのタブであなたの Web サイトを訪問します。
        Safariでwebkit.orgを開いたところです。
         タブで開いているため、Service Workerをインストールすることができます。
         Service Worker は、現在開いているブラウザのタブとは別に、ドメイン全体を代表して動作する JavaScript のユニットです。
         Service Workerスクリプトがインストールされると、WebアプリはPush購読を要求する資格を得ます。
         すでに述べたように、このリクエストはユーザーのジェスチャーに関連付ける必要があります。
         webkit.org は、このベル型のボタンをクリックしたときに許可を要求しますが、これはユーザーのジェスチャーの要件を満たしています。
         あなたのサイトがプッシュ購読を要求すると、ユーザーはこのシステムプロンプトを目にします。
         ここでユーザーは、あなたのウェブサイトにこの強力な機能を許可するかどうか、最終的な判断を下すことができます。
        ユーザーは、この要求を拒否する可能性があります。
         JavaScriptは、そのような場合に対応できるように準備する必要があります。
         しかし、ユーザーが許可を与えたと仮定すると、JavaScriptはPushSubscriptionオブジェクトを取得します。
         これには、あなたのサーバーがこのブラウザのこのユーザーにプッシュメッセージを送信するために必要なものがすべて含まれています。
         正確なURLのエンドポイントなどの情報です。
         この PushSubscription のペイロードを、あなたのウェブアプリケーションに最適な方法でサーバーに送り返します。
         多くの一般的なサーバーパッケージは、サブスクリプションを管理するための Web Push サポートを備えていますし、自分で作成することもできます。
         同じことは、サーバーが知っている URL のエンドポイントに、いつ、どのように実際にプッシュメッセージを送信するのかにも当てはまります。
         私は、いつそうすべきかを指示することはできません。
         それは、あなたとあなたのウェブサイト次第です。
         しかし、一度プッシュメッセージを送ることを決めたら、次に何が起こるかについてはお手伝いできます。
         プッシュにはService Workerのインストールが必要なのを覚えていますか？サーバーがプッシュメッセージを送信し、Safariがそれを受信すると、SafariはService Workerを起動し、JavaScriptのプッシュイベントを送信します。
         通知センターでユーザーに通知を表示することは、プッシュイベントを処理する際の必要条件です。
         プッシュイベントを受信して通知を表示するのは、Webサイトをブラウザのタブで開いている場合です。
         また、Webサイトをブラウザーのタブで開いていない場合にも発生します。
         macOS VenturaのSafariの場合、Safariが起動していなくても発生します。
         最後のステップです。ユーザーが通知をクリックすると、notificationclickイベントがService Workerに送信され、適切に応答できるようになります。
         たとえば、その通知に関連するURLの新しいウィンドウを開くなどです。
         Web Push のフローを理解したところで、既存の Web アプリに Web Push サポートを実際に追加して、さらに詳細な情報を得るときが来ました。
         ブラウザペットは、webkit.orgの他に、SafariとWebKitのチームにとって最もミッションクリティカルな社内ツールです。
         部署の全員が、Safari上のお気に入りのWebKittensやPupsについて最新の情報を得ることが、常にBrowser Petsの使命でしたが、Web Pushはそれをこれまで以上に容易にしてくれました。
         社内のBrowserPetsドメインには、すでにページロードの高速化と複数タブ間の同期を行うためのServiceWorkerスクリプトが登録されていました。
         ServiceWorkerスクリプトは、大きく分けるとこんな感じです。
         エンジニアがタブで Browser Pets ページにアクセスすると、この JavaScript 抜粋は、Service Worker スクリプトがすでに登録されているかどうかを判断し、必要であれば登録します。
         ベストプラクティスとして以前紹介した、機能検出をここで実践していることに注目してください。
         Service Worker の前提条件が整ったので、Push 購読の準備ができました。
         ユーザーの明示的なジェスチャーがなければ、Push 購読をリクエストできないことを忘れないでください。
         ボタンの onclick ハンドラに応答してこのスクリプトを実行することは、この要件を満たすための多くの方法のうちの 1 つです。
         ユーザーがボタンをクリックすると、プッシュ配信を要求するコードが表示されます。
         それぞれのポイントについて、より詳しく説明します。
         まず、プッシュ配信のリクエストを設定する必要があります。
         そのために重要なのは、サーバーがAppleのプッシュ・サーバーに対して自分自身を識別するために使用する公開鍵です。
         ここでは、他のブラウザと同じ VAPID と呼ばれる標準的な技術を使用しています。
         VAPIDの複雑な説明はここではしませんが、あなたのサーバーの設定に最適なソリューションを提供するためのリソースがウェブ上にあります。
         VAPID キーが設定されたので、サブスクリプションリクエストを設定する準備ができました。
         ここで、プッシュしたユーザーを常に表示することを約束すると明記していることに注目してください。
         JavaScript Push API の標準では、Push に応答する JavaScript のサイレントランタイムにオプションで対応していますが、ほとんどのブラウザはそれをサポートしていません。
         Safari はそれをサポートしていません。
         そして、ほとんどのウェブサイトと同様に、Browser Pets もそれを必要としません。
         次に、プッシュの許可を求めます。
         このJavaScriptの行は、ユーザーが承認または拒否するための許可プロンプトを表示します。
         ユーザーが許可を出したと仮定すると（Browser PetsではSafariのチームメンバー全員が許可しています）、このユーザーのブラウザに到達する方法の詳細を含むPushSubscriptionオブジェクトが得られます。
         URLのエンドポイントや、転送用のプッシュメッセージの暗号化に使用する鍵などです。
         最後に、これらの詳細情報をすべてサーバーに送信する必要があります。
         前述したように、これの詳細は、あなたの正確なアプリケーションに基づいて異なります。
         BrowserPetsのサーバーはWordPressを使用しており、標準的なWebプッシュをサポートするプラグインがすでにいくつかあります。
         同じことが、あなたのバックエンドにも当てはまると思いますし、どんなセットアップにも適切なソリューションを見つけるのに役立つリソースがウェブ上にあります。
         さて、Service Worker の JavaScript コードに戻る必要があります。
         まず、push イベントを始めとするいくつかの新しいイベントを処理する必要があります。
         Browser Pets サーバーからこのブラウザーにプッシュメッセージが届くと、この Service Worker にプッシュイベントが送られます。
         このイベントには、PushMessageDataオブジェクトが含まれており、サーバーから送信されたデータにアクセスするための複数の方法が用意されています。
         ここではJSONアクセサーを使います。
         プッシュを申し込んだとき、JavaScript は常にユーザーの目に触れるようにすると約束したのを覚えていますか？つまり、各プッシュに対して、常にプラットフォームネイティブの通知を表示しなければなりません。
         これは、プッシュ イベント ハンドラでできるだけ早く行うのが最善です。
         URLを使ったアクションの設定など、通知を設定するために必要なすべてをJSON blobから取り出しています。
         これは、すぐに役に立つでしょう。
         通知が表示された後、ユーザーがそれをクリックするのを処理する必要があります。
         サービスワーカー スクリプトが処理するイベントがもう1つあります。
         このnotificationclickハンドラで、BrowserPetsは、新しいウィンドウを開くためにクリックされた通知から、URLを取得します。
         注意：これは、非常に一般的なパターンです。
         以上で、Web Pushをサポートするために必要なJavaScriptは、すべて完了です。
         もちろん、開発中に何らかの手助けがあるのがベストです。
         いつものように、そこでWeb Inspectorの出番です。
         Web Inspector は、ブラウザーのタブで開いているウェブサイトのデバッグを支援するだけでなく、Service Worker インスタンスを検査したり、イベントハンドラにブレークポイントを設定したりすることもできます。
         これらすべてを合わせて、プッシュを購読する JavaScript と、プッシュイベントと通知イベントを処理する Service Worker コードを検査し、デバッグすることができます。
         さらに、Apple Push Notification サーバーは、プッシュメッセージを発行しようとしたときに何か問題が発生すると、人間が読めるエラーを出します。
         さらなるドキュメントについては、このセッションに関連するリンクをチェックしてみてください。
         また、このコードを書いている間に出てきた、ユーザーのプライバシーと電力使用に関するいくつかのポイントについて、より詳しく説明したいと思います。
         重要なことは、これは初めて言うことではありませんが、プッシュを購読するには、ユーザーのジェスチャーが必要だということです。
         Web プラットフォームの他の特権的な機能と同様に、ユーザーが実際に Web Push を有効にするよう頼んだことを要求するのは、ユーザーの信頼にとって正しいことなのです。
         プッシュ購読を要求する方法のコードを紹介したときに述べたように、プッシュがユーザーの目に触れることを約束する必要があります。
         プッシュイベントを処理することは、JavaScript がバックグラウンドの実行時に沈黙することを促すものではありません。
         そうすると、ユーザーの信頼とバッテリー寿命の両方を侵害することになります。
         プッシュイベントを処理する場合、実際には通知センターに通知を投稿する必要があります。
         他のブラウザはすべて、プッシュユーザーを可視化するという約束に違反することへの対策を持っており、Safariも同様です。
         macOS Venturaのベータ版では、適時に通知を投稿できないプッシュイベントが3回発生すると、サイトのプッシュ購読が取り消されます。
         再度、許可ワークフローを実行する必要があります。
         以上です。
         私たちは、Web Push をサポートできることを心から誇りに思いますし、どんなサイトでも Apple Developer アカウントなしで利用できることに興奮しています。
         標準に従ってコーディングし、機能検出を使用して、知らず知らずのうちに Safari を除外しない限り、ユーザーは macOS Ventura 上の Safari 16 ですでに Web Push の恩恵を受けることができます。
         いつものように、私たちは今年、SafariとWebKitに他の新しいものを大量に追加しましたので、そのセッションをチェックして、もっと学んでいただければと思います。
         ご視聴ありがとうございました。
         WWDC 2022の残りの期間もよろしくお願いします。

        """
    }
}

