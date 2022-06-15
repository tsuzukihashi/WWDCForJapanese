import Foundation

struct GetMoreMileageOutOfYourAppWithCarPlay: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Get more mileage out of your app with CarPlay"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6508/6508_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10016/")!
    }

    var english: String {
        """
        Well, greetings and welcome to "Get more mileage out of your app with CarPlay.
        " My name is André, and I'll be driving you through the session today.
        As you know, CarPlay is the smarter, safer way to use your iPhone in the car.
         Today's session is all about your apps and how to enable them in CarPlay.
         We'll start with a quick refresher on the types of apps that are supported, then talk about some new app types we are enabling this year, and finally go over a new tool we have made available to support the development of your apps.
         We'll finish today with an important new feature specific to navigation apps.
         Without further ado, let's get right into it! One of the most fundamental things about CarPlay is that it is built for drivers.
         People who are actively driving are the primary users you should consider when building your app.
         As a result, you should only enable use cases that are relevant while driving, and you should omit any use cases that people shouldn't do while driving.
         Things like one time configuration, signing in to your app, or reading terms and conditions, are things that are better to do before or after driving, so they shouldn't appear in your app's CarPlay UI.
        Note that an entitlement is needed for your app to appear in CarPlay.
         You can request the entitlement on the Apple CarPlay developer website based on the type of app you'd like to make available.
         Here are the types of apps we support in CarPlay today.
         These cover a wide number of tasks drivers may want to do while driving, but we've heard from many of you that there are even more driving-relevant apps you'd like to enable.
         I'm happy to announce we are adding two new types to our list this year, Fueling and Driving Task apps.
         We'll go over these in more detail shortly, but first, let's take a quick pit stop and talk a bit about Templates.
         Templates are how apps in CarPlay present their UI.
         Your app supplies the data, and the system draws the UI onto the vehicle's display on your behalf.
         This system of templates is simple for your app to adopt and has several benefits, including helping steer your app towards making it appropriate for the road.
         You don't have to worry about things like font sizes, the templates help you ensure your UI is of low complexity, and finally, the UI of your app is consistent with other apps in CarPlay, making it easier for your users to quickly take actions in it as needed.
         Just as important, the templates take care of making sure your app's UI works great in any car that supports CarPlay, regardless of the size of the screen or the type of input device used in the car.
         You may still want to test your app in different configurations, and we'll talk more about testing later on in the session, but suffice it to say, the templates take care of most of the work for you.
         You have several templates to choose from when building your app.
         From the grid template showing an array of buttons, to the list template showing a table, these templates should be familiar to you, both as a developer, and an iOS user.
         Most importantly, they will be familiar to your users driving with CarPlay as they appear all throughout CarPlay.
         We spoke just before about the different types of apps we support in CarPlay.
         Some of these templates are more relevant to some of those types than others.
         This chart helps you understand which templates your app can use, depending on which type it is.
         I realize trying to read this is a bit like taking a DMV eye exam, but fear not, you'll find this exact chart in our developer documentation online.
         The thing to take away here now is that the templates your app can use depend on its type.
         Only templates that are relevant and appropriate for a particular app type are permitted.
         Now that we've talked about templates, let's take a closer look at the new app types we are launching with iOS 16.
         First let's talk about the new Fueling app type.
        As you may remember, in iOS 14 we launched support for EV Charging apps.
         These apps aren't just for finding locations of EV chargers, they do more than that - for example, they may help the user connect to the right charging station and start it up.
         We've heard from many developers that this type of functionality would be great for more than just electric vehicles.
         Whether it is traditional gasoline-enabled cars or alternative fuel vehicles, this new category enables you to support CarPlay in your fueling app.
         Note that many users use navigation apps to find and drive to particular locations, so your fueling app should enable more functionality in its CarPlay UI than simply finding a location.
         A great example of what your app could enable is, for instance, starting up a gas pump.
         Now, let's talk about Driving Task applications.
         Driving Task is a new type of CarPlay app designed to enable a wider variety of very simple apps.
         Keep in mind the primary purpose of these apps must be to enable tasks people need to do while driving-- it's for tasks that actually help with the drive, not just a task to be done while you drive.
        Some examples of apps that would fall under this type include apps to help control car accessories, apps that provide driving or road status and information, and apps to help with tasks at the start and end of a drive.
         Let's take a look at some more concrete examples of these.
        First, here we have a road status app that can inform users about important road information.
         This app was built using the CPPointOfInterestTemplate.
         Keep in mind, a user using this app is driving, so an app like this should provide a very short list of important items near where the user is located.
         This is not intended for apps helping users do full route planning ahead of a drive.
        In this app, here's what a user sees when they select a location.
         Note that the amount of space for text is intentionally limited to keep this information glanceable, so you should be concise in the language you choose here.
        Next, let's look at an application designed to control a car accessory-- in this case a trailer controller.
         This app uses the CPInformationTemplate to provide basic information on a connected accessory, as well as a couple of buttons for the user to take actions.
         Note that in this example, this is the app's entire UI in CarPlay.
         There are no other screens! Of course, the app has plenty of other functionality, for instance, the ability to manage paired accessories, but any functionality that isn't needed for driving is simply not included in the CarPlay UI for that app.
         Users are best served doing non-driving tasks using the app's primary UI on iPhone when they're out of the vehicle.
        Finally, let's look at a couple examples using the CPGridTemplate.
         This is an extremely simple app that has two buttons - that's it! And lets the users keep track of their miles as either personal or business miles.
         This app fits the new Driving Task app type perfectly, as it enables a very simple task that users need to do while driving, without enabling any other non-critical tasks.
         Simple, and to the point.
         Just to show you that this style of UI can serve multiple types of apps, here's another example with a near identical UI.
         This is an express lane toll transponder app that uses the CPGridTemplate to let users choose how many occupants are in the car.
         It meets the exact same goals as the previous example and is another perfect Driving Task app.
        To recap, when designing your Driving Task app, definitely consider making a single screen app that provides the minimum functionality your users need while driving and only enable tasks that can be accomplished in a few seconds.
         You should avoid enabling complex or infrequent use cases.
         A great example of this is first time set up or detailed configuration.
         And finally, you should not add functionality to your app that isn't needed while driving, even if it's car-related.
         The kitchen sink, this is not.
         And that's it on Driving Task apps.
         Now let's shift gears a bit and talk about how to test your CarPlay app.
         We'll review the different ways in which you can go about this, and I'll introduce a new tool called CarPlay Simulator.
         As a developer, you have a few different tools at your disposal to test your CarPlay-enabled app.
         First, you can use the Xcode simulator, which has a built-in CarPlay window.
         If you're already using the Xcode simulator to test the rest of your app, this is a great way to quickly test your CarPlay UI, too.
         Second, for testing your app on a real iPhone, you can, of course, connect your phone to a real CarPlay-enabled vehicle, or an aftermarket head unit.
         Until recently, this was the only way to test your app's CarPlay UI running on a real iPhone, but I'm happy to report we have a third option for you now that may just become your favorite-- the CarPlay Simulator! Let's look at this in more detail.
         So what is it? CarPlay Simulator is a stand-alone Mac application that replicates a CarPlay environment.
         You simply download the "Additional Tools for Xcode" package on the Apple developer website, run the app, and connect your iPhone to your Mac using a cable.
         CarPlay will start on the phone and run just the same as if you had it connected to a real car.
         So what's the big deal, and why would you want to use this? Well, there are several benefits.
        First of all, when you are using CarPlay Simulator, CarPlay is actually running on your iPhone the same way it would be in a real car.
         This means you can test your app running on your phone without constantly having to run back and forth to your parking spot or having to buy an aftermarket head unit.
         Another huge benefit is that because your phone is connected to your Mac when you're using CarPlay Simulator, you can use all of the other fantastic developer tools on your Mac simultaneously, whether it is debugging in Xcode or tuning performance in Instruments.
         Similarly on the iOS side of things, because your app is running on an actual iPhone, you have access to complete iPhone functionality.
         Some scenarios cannot be tested without either a real CarPlay system, or now, CarPlay Simulator.
        A great example is testing that your navigation app's voice instructions correctly mix with a car's native audio source, like FM radio.
         You can now test this at the convenience of your desk.
        Last but not least, you can use CarPlay Simulator to test multiple different configurations of cars, too, for example, cars with different display sizes.
         Let's see what CarPlay Simulator looks like in action.
         So here it is.
         As you can see, the CarPlay display from the connected iPhone appears right in the app, alongside several controls.
         Let's go through what some of these do.
         At the bottom of the screen are buttons that simulate various different hard keys and knob controls in a car.
        You can also click directly in the CarPlay view to simulate a touch in touchscreen vehicles.
        At the top of the window we have some quick controls.
         The limit UI button allows you to simulate when a car in motion requests for CarPlay to limit certain content on screen, which, for example, could shorten the contents of lists in an audio app.
        The next two buttons are to simulate when a car requests dark or light appearance for UI and map content, respectively.
        The last button lets you quickly simulate disconnecting and reconnecting your phone to CarPlay.
         Because your phone will still remain connected to your Mac when you use this button, you can use it to debug CarPlay reconnection scenarios in your app using Xcode.
        But what about that first button that I skipped? As you might have guessed, this will pop up a secondary window with more advanced functionality.
         Let's take a look at those advanced features now.
        In the General tab, you're able to choose the display size for the main CarPlay display.
         If your application UI is composed only of templates, you can try different sizes to see what your UI will look like in different cars, but as we talked about before, the system will make sure everything works great regardless.
         If your app is a navigation app, however, it's critically important that you try different sizes and aspect ratios to ensure your map drawing code works correctly.
         Here are some recommended display sizes to test with your app.
         Let's take a look at the Cluster Display tab.
         As you will see here, you are able to simulate cars with a second display in the instrument cluster! Simply check the box to enable it, restart the session, and a second window will appear for the instrument cluster alongside the primary display.
         Again, this is most relevant to navigation apps.
         The instrument cluster display is used to display either a map or turn card for the driver right in their field of view in the car's instrument cluster.
         We'll chat more about the instrument cluster in a second, but that's a quick tour of the new CarPlay Simulator app.
         We hope you find it as useful as we do! We just saw how CarPlay can now draw a live map in the instrument cluster.
         But what about your navigation app? How can you add - and test - instrument cluster support in your app? Let's take a look.
         You may remember that back in iOS 13, we added APIs to enable navigation apps to appear in the CarPlay Dashboard.
         To do this, you edited your app's Info.
        plist to declare support for Dashboard and implemented the required delegates.
         The delegates notify your app when it is appearing and disappearing in Dashboard, and also pass over a UIWindow to your app in which to draw your map content.
         It's easy.
         If you've already done this, then the great news is adding instrument cluster support will be a piece of cake, as it follows the exact same pattern.
         Let's look at how I did this in my own navigation test app, Space Roads.
         I edited my Info.
        plist to declare support for the instrument cluster navigation scene and added the required Scene Session Role.
         Then, I implemented my CPTemplateApplicationInstrumentCluster Scene delegate as well as my CPInstrumentClusterControllerDelegate.
         These will both give you a window in which to draw your content as well as notify you when the instrument cluster starts and finishes, making your instrument cluster view visible.
         That's all it takes to have your map appear live in the car's instrument cluster! While this is all very similar to implementing Dashboard support, there are a few more considerations specific to the instrument cluster.
         First of all, the instrument cluster may allow users to zoom the map in and out.
         It's your responsibility to implement this in your app using the CPInstrumentClusterControllerDelegate.
         Similarly, if your app includes a compass or speed limit, the corresponding delegates will tell your app when it is appropriate to draw them or not.
         Finally, note that your instrument cluster view may be partially obscured by other elements in the car's instrument cluster.
         Of course, iOS already has a first class mechanism for dealing with such a thing, safe areas! You can override viewSafeAreaInsetsDidChange on your view controller to know when the safe area changes, and use the safeAreaLayoutGuide on your cluster view to keep critical content in the area of the view guaranteed to be visible.
         If you have a blue route line showing the user's location, for instance, you'd want to ensure the critical parts are contained within the safe area.
         We just saw some new features for you as a developer building CarPlay apps, and we saw a new tool for you to test your apps.
         Let's take a look at it in action.
         First, I'm going to start here on my Mac, showing you CarPlay Simulator.
         I have the app running, and I'll simply connect my phone.
        And voilà, here it is running CarPlay.
         Let's see how CarPlay Simulator can help you when testing your apps.
         Even if your app is primarily template based, you can use it to make sure the artwork in your app works great in both light and dark appearances.
         Let me run the Express Lane app.
        ..And I can use the button in the toolbar to toggle between light and dark appearances.
         Notice how my app has provided different artwork for both styles.
         Looks great.
         Now let's switch over to Space Roads, a navigation test app I've written.
        I'll use the main configuration panel to try my map drawing code at a different screen size.
        And finally, I will enable the instrument cluster display to test the instrument cluster support.
        Here it is.
         It works great! Earlier, I fully tested my apps in CarPlay Simulator, so now, I have full confidence they will work great in a real car.
         Let's give it a try! Alright, here we are in my car, and as you can see, I have my phone connected to the vehicle and running CarPlay.
        First, let's try running my connected trailer controller app so I can show you how templates have taken care of making the app work great in a knob enabled vehicle.
        This particular vehicle has both a touch screen and a knob controller, but many users like to use the knob controller while driving, so it's important for apps to work great using the knob.
         As you can see, I have full access to the buttons in my app here, and the best part is, I didn't have to do anything special - the templates did all the work for me! Next, let's switch over to my navigation app, Space Roads.
         We'll launch the app.
        .. and we'll start navigation.
        .. and then I press go.
         Boom! My app now shows a live map view on both the center console and in the instrument cluster! It's great having the live map right in my line of sight as a driver.
         I'm certain drivers using your navigation app will love it, too.
         Well, that's all I have for you today.
         For more information, be sure to check out the CarPlay developer portal at developer.apple.com/carplay Thank you, and happy roads, everyone!
        """
    }

    var japanese: String {
        """
        さて、ご挨拶がてら「CarPlayでアプリの燃費を上げよう」。
        " 本日のセッションを担当させていただきます、アンドレと申します。
        ご存知の通り、CarPlayは車内でiPhoneをよりスマートに、より安全に使用する方法です。
         本日のセッションは、アプリとそれをCarPlayで有効にする方法についてです。
         まず、サポートされているアプリの種類を簡単に確認し、次に今年から可能になった新しいアプリの種類、そして最後にアプリの開発をサポートするために用意された新しいツールについて説明します。
         最後に、ナビゲーションアプリに特化した重要な新機能をご紹介します。
         それでは、さっそく本題に入りましょう。CarPlayの最も基本的なことのひとつは、ドライバーのために作られていることです。
         アクティブに運転する人は、アプリを構築する際に考慮すべき主要なユーザーです。
         そのため、運転中に関連するユースケースのみを有効にし、運転中に行うべきではないユースケースは省くべきです。
         ワンタイムコンフィグレーション、アプリへのサインイン、利用規約の閲覧などは、運転前または運転後に行った方が良いことなので、アプリのCarPlay UIに表示されるべきではありません。
        アプリをCarPlayに表示するにはエンタイトルメントが必要であることに注意してください。
         エンタイトルメントは、利用可能にしたいアプリの種類に応じて、Apple CarPlay開発者向けWebサイトでリクエストできます。
         現在、私たちがCarPlayでサポートしているアプリの種類は以下のとおりです。
         これらは、ドライバーが運転中に行いたい様々なタスクをカバーしていますが、多くの方から、さらに多くの運転に関連するアプリを有効にしたいとのご意見をいただいています。
         そこで、今年から新たに「給油」と「運転タスク」の2つのアプリを追加しました。
         この2つのアプリの詳細については後ほど説明しますが、その前に少し立ち止まって、テンプレートについて少しお話ししましょう。
         テンプレートは、CarPlay のアプリが UI を表示する方法です。
         アプリがデータを提供し、システムがあなたに代わって車のディスプレイにUIを描画します。
         このテンプレートのシステムは、アプリが採用するのが簡単で、アプリが道路に適したものになるように誘導するなどの利点があります。
         フォントサイズなどを気にする必要がなく、テンプレートはUIの複雑さを軽減し、最終的にアプリのUIはCarPlayの他のアプリと一貫性があり、ユーザーが必要に応じて素早くアクションを起こすことを容易にします。
         同様に重要なこととして、テンプレートは、画面のサイズや車内で使用される入力デバイスの種類に関係なく、CarPlayをサポートするどの車でもあなたのアプリのUIが素晴らしく動作するように配慮しています。
         アプリをさまざまな構成でテストしたいと思うかもしれません。テストについては、セッションの後半で詳しく説明しますが、テンプレートが作業のほとんどを担ってくれるということだけは確かです。
         アプリを構築する際には、いくつかのテンプレートから選択することができます。
         ボタンを並べたグリッドテンプレートから、表を表示するリストテンプレートまで、これらのテンプレートは開発者としても、iOSユーザーとしても馴染みがあるはずです。
         最も重要なことは、CarPlay でドライブするユーザーにとって、CarPlay の至る所に表示されるため、馴染みがあるということです。
         先ほど、私たちがCarPlayでサポートするさまざまな種類のアプリについてお話しました。
         これらのテンプレートの中には、他のタイプよりも関連性が高いものがあります。
         この表は、あなたのアプリがどのタイプであるかによって、どのテンプレートを使用できるかを理解するのに役立ちます。
         これを読もうとすると、DMVの視力検査を受けるようなものだと思いますが、心配はいりません。この正確な表は、オンラインの開発者向けドキュメントにあります。
         ここで重要なことは、アプリが使用できるテンプレートは、アプリのタイプによって異なるということです。
         特定のアプリの種類に関連し、適切なテンプレートだけが許可されます。
         テンプレートについて説明したところで、iOS 16で提供される新しいアプリの種類を詳しく見ていきましょう。
         まず、新しいFuelingアプリ・タイプについて説明します。
        iOS 14 で EV 充電アプリのサポートを開始したことは覚えているかと思います。
         これらのアプリは、EV充電器の場所を見つけるだけでなく、それ以上のことをします。たとえば、ユーザーが正しい充電ステーションに接続して、それを起動するのを助けることもあります。
         このような機能は、電気自動車だけでなく、多くの開発者から素晴らしいという声を聞いています。
         従来のガソリン対応車であれ、代替燃料車であれ、この新しいカテゴリーによって、給油アプリでCarPlayをサポートすることが可能になります。
         多くのユーザーは、特定の場所を探して運転するためにナビゲーションアプリを使用しているため、給油アプリは、単に場所を見つけるだけでなく、CarPlay UI でより多くの機能を有効にする必要があることに留意してください。
         アプリで実現できることの例として、たとえば、ガソリンスタンドを起動することなどが挙げられます。
         次に、Driving Task アプリケーションについて説明します。
         Driving Taskは、より多様でシンプルなアプリを実現するために設計された、新しいタイプのCarPlayアプリです。
        これらのアプリの主な目的は、運転中に必要なタスクを可能にすることでなければならないことに留意してください--それは、運転中に行うべきタスクではなく、実際に運転に役立つタスクのためです。
        このタイプに該当するアプリの例としては、カーアクセサリーの操作を支援するアプリ、運転や道路の状況や情報を提供するアプリ、ドライブの開始時や終了時のタスクを支援するアプリなどが挙げられます。
        では、具体的な例を挙げてみましょう。
        まず、重要な道路情報をユーザーに知らせることができる道路状況アプリを紹介します。
        このアプリは、CPPointOfInterestTemplateを使用して作成されています。
        このアプリを使用するユーザーは車を運転しているので、このようなアプリは、ユーザーがいる場所の近くにある重要な項目のごく短いリストを提供する必要があることに留意してください。
        これは、ユーザーがドライブの前に完全なルート計画を立てるためのアプリを意図したものではありません。
        このアプリでは、ユーザーが場所を選択すると、次のような画面が表示されます。
        なお、ひと目でわかるように文字量をあえて制限していますので、文言は簡潔にしてください。
        次に、カーアクセサリー（ここではトレーラーコントローラー）を制御するためのアプリケーションを見てみましょう。
        このアプリケーションでは、CPInformationTemplate を使用して、接続されたアクセサリーの基本的な情報と、ユーザーがアクションを起こすためのいくつかのボタンを提供しています。
        この例では、これが CarPlay でのアプリの UI 全体であることに注意してください。
        他の画面はありません。もちろん、このアプリには、ペアリングされたアクセサリーを管理する機能など、他の機能もたくさんありますが、運転に必要ない機能は、そのアプリのCarPlay UIに含まれていないだけなのです。
        ユーザーは、車の外にいるとき、iPhone上のアプリの主要なUIを使用して、運転以外の作業を行うのが最善です。
        最後に、CPGridTemplate を使用したいくつかの例を見てみましょう。
        このアプリは、2つのボタンがあるだけの非常にシンプルなものです。このアプリでは、ユーザーが個人的な走行距離とビジネスでの走行距離を記録することができます。
        このアプリは、運転中にユーザーが行う必要のある非常に単純なタスクを実現し、他の重要でないタスクを有効にしないので、新しい Driving Task アプリのタイプに完全に適合しています。
        シンプルで、ポイントを押さえたものです。
        このスタイルのUIが複数の種類のアプリに対応できることを示すために、ほぼ同じUIを持つ別の例を紹介します。
        これは高速レーンの料金トランスポンダーのアプリで、CPGridTemplateを使用して、ユーザーが車に乗っている人数を選択できるようにしたものです。
        前の例とまったく同じ目標を達成し、もうひとつの完璧な Driving Task アプリです。
        まとめると、Driving Taskアプリを設計するときは、運転中にユーザーが必要とする最低限の機能を提供し、数秒で完了するタスクのみを有効にする1画面アプリを作成することを検討してください。
        複雑なユースケースや使用頻度の低いユースケースを有効にすることは避けなければなりません。
        例えば、初回セットアップや詳細な設定などがその例です。
        そして最後に、運転中に必要のない機能をアプリに追加してはいけません。たとえそれが車に関するものであってもです。
        台所の流し台、これはダメです。
        以上、Driving Taskアプリについてでした。
        ここで少し話を変えて、CarPlayアプリをテストする方法について説明します。
        ここでは、さまざまな方法を検討し、CarPlay Simulator と呼ばれる新しいツールを紹介します。
        開発者として、CarPlay対応アプリをテストするために、いくつかの異なるツールを自由に使用することができます。
        まず、CarPlayウィンドウを内蔵しているXcodeシミュレータを使用することができます。
        すでにXcodeシミュレータを使用してアプリの残りの部分をテストしている場合、これはCarPlay UIを迅速にテストするための素晴らしい方法です。
        第二に、実際のiPhoneでアプリをテストするには、もちろん、あなたの携帯電話を実際のCarPlay対応車、またはアフターマーケットのヘッドユニットに接続することができます。
        最近まで、これが本物のiPhone上でアプリのCarPlay UIをテストする唯一の方法でしたが、嬉しいことに、あなたのお気に入りになるかもしれない3番目のオプション、CarPlayシミュレータを用意しました それでは、このシミュレーターについて詳しく見ていきましょう。
        それは何でしょうか？CarPlay Simulatorは、CarPlay環境を再現するスタンドアローンのMacアプリケーションです。
        Appleのデベロッパーサイトから「Additional Tools for Xcode」パッケージをダウンロードしてアプリを起動し、iPhoneとMacをケーブルで接続するだけです。
        実際のクルマに接続した場合と同じように、iPhone上でCarPlayが起動し、実行されます。
        では、何が重要なのか、なぜこれを使いたいのか？まあ、いくつかの利点があります。
        まず第一に、CarPlayシミュレータを使用しているとき、CarPlayは実際の車と同じようにあなたのiPhone上で実行されています。
         つまり、駐車場まで何度も走ったり、アフターマーケットのヘッドユニットを購入したりすることなく、携帯電話上で動作するアプリをテストすることができるのです。
         もう一つの大きな利点は、CarPlay Simulatorを使用しているとき、携帯電話がMacに接続されているので、XcodeでのデバッグやInstrumentsでのパフォーマンスチューニングなど、Mac上の他のすべての素晴らしいデベロッパツールを同時に使用することができる点です。
         iOS側でも同様に、アプリケーションは実際のiPhone上で実行されるため、iPhoneの完全な機能にアクセスできます。
         シナリオによっては、実際のCarPlayシステム、またはCarPlay Simulatorがなければテストできないものもあります。
        例えば、ナビゲーションアプリの音声案内が、FMラジオのような車のネイティブなオーディオソースと正しくミックスされるかどうかをテストすることが挙げられます。
         このテストは、あなたのデスクで簡単に行えます。
        また、CarPlay Simulatorを使えば、ディスプレイサイズの異なる車など、複数の異なる構成の車をテストすることも可能です。
         では、実際にCarPlay Simulatorがどのようなものか見てみましょう。
         では、こちらです。
         ご覧のように、接続したiPhoneのCarPlayディスプレイがアプリ内に表示され、いくつかのコントロールが並んでいます。
         これらの機能のいくつかを見てみましょう。
         画面下には、車のハードキーやノブを模したボタンがあります。
        また、CarPlayビューで直接クリックすることで、タッチスクリーン車のタッチをシミュレートすることができます。
        ウィンドウの上部には、いくつかのクイックコントロールがあります。
         limit UIボタンは、走行中の車がCarPlayに画面上の特定のコンテンツを制限するよう要求したときのシミュレーションを行うもので、例えば、オーディオアプリのリストの内容を短くすることができます。
        次の2つのボタンは、自動車がUIとマップのコンテンツに対してそれぞれダークまたはライトアピアランスを要求したときのシミュレーションを行うためのものです。
        最後のボタンは、携帯電話とCarPlayの接続を解除・再接続するシミュレーションを素早く行うことができます。
         このボタンを使用しても、あなたの電話は Mac に接続されたままなので、Xcode を使用してアプリで CarPlay 再接続シナリオをデバッグするために使用することができます。
        しかし、私がスキップした最初のボタンはどうでしょうか？ご想像の通り、これはより高度な機能を持つセカンダリウィンドウをポップアップします。
         では、その高度な機能を見てみましょう。
        General]タブでは、メインのCarPlayディスプレイの表示サイズを選択することができます。
         アプリケーションのUIがテンプレートだけで構成されている場合、異なる車でUIがどのように見えるかを確認するために異なるサイズを試すことができますが、前に説明したように、システムはすべてがうまく機能するようにします。
         しかし、ナビゲーションアプリの場合は、地図描画コードが正しく動作するように、さまざまなサイズやアスペクト比を試すことが非常に重要です。
         ここでは、アプリでテストするために推奨される表示サイズをいくつか紹介します。
         クラスタ表示]タブを見てみましょう。
         ここで見るように、インストルメントクラスターに2つ目のディスプレイを持つ車をシミュレートすることができます! ボックスをチェックして有効にし、セッションを再起動するだけで、プライマリディスプレイの横にインストルメントクラスター用のセカンドウィンドウが表示されます。
         これもまた、ナビゲーションアプリに最も関連性の高い機能です。
         インストルメントクラスターディスプレイは、ドライバーの視界にマップまたはターンカードを表示するために使用されます。
         インストルメントクラスターについては後述しますが、以上が新しいCarPlay Simulatorアプリの簡単な説明です。
         ぜひご覧ください。先ほど、CarPlayがインストルメントクラスター内にライブマップを描画することを確認しました。
         しかし、あなたのナビゲーションアプリはどうでしょうか？アプリに計器クラスタ サポートを追加し、テストするにはどうしたらよいでしょうか。見てみましょう。
         iOS 13 で、ナビゲーション アプリを CarPlay ダッシュボードに表示できるようにするための API を追加したことを覚えているかと思います。
         これを行うには、アプリのInfo.plistを編集して、Dashboardのサポートを宣言します。
        plist を編集して Dashboard のサポートを宣言し、必要なデリゲートを実装します。
         デリゲートは、アプリが Dashboard に表示されたり消えたりするときに通知し、地図コンテンツを描画するための UIWindow をアプリに渡します。
         簡単ですね。
         もし、すでにこの方法をとっているのであれば、計器群のサポートを追加するのも、まったく同じパターンで簡単にできます。
         私が作成したナビゲーション テスト アプリ「Space Roads」でどのように行ったか見てみましょう。
         私は、Info.
        plist を編集して、インストルメントクラスターのナビゲーションシーンをサポートすることを宣言し、必要な Scene Session Role を追加しました。
         そして、CPTemplateApplicationInstrumentCluster Scene デリゲートと、CPInstrumentClusterControllerDelegate を実装しました。
         これらは、コンテンツを描画するためのウィンドウを提供し、インストルメントクラスターの開始と終了を通知して、インストルメントクラスタービューを表示することができます。
        これだけで、車の計器用等級にマップがライブで表示されます。これは、Dashboard サポートの実装と非常に似ていますが、計器用クラスタに固有の考慮事項がいくつかあります。
        まず、インストルメントクラスターでは、ユーザーがマップをズームイン/アウトできる場合があります。
        CPInstrumentClusterControllerDelegate を使用してアプリにこれを実装するのは、あなたの責任です。
        同様に、アプリにコンパスや速度制限が含まれている場合、対応するデリゲートは、それらを描画することが適切であるかどうかをアプリに伝えます。
        最後に、インストルメント・クラスターのビューは、車のインストルメント・クラスター内の他の要素によって部分的に隠されている可能性があることに留意してください。
        もちろん、iOSにはそのような場合に対処するための第一級のメカニズム、セーフエリアがすでにあります! ビューコントローラーのviewSafeAreaInsetsDidChangeをオーバーライドして、安全領域が変更されたときにそれを知ることができます。クラスタービューのsafeAreaLayoutGuideを使用して、ビューの見えることが保証されている領域に重要なコンテンツを保持することができます。
        例えば、ユーザーの位置を示す青いルートラインがある場合、重要な部分がセーフエリア内に収まるようにしたいものです。
        CarPlayアプリを開発するデベロッパーのための新機能と、アプリをテストするための新ツールをご紹介しました。
        実際に使って見ましょう。
        まず、私のMacでCarPlay Simulatorをお見せします。
        アプリを起動し、携帯電話を接続します。
        そして、ほら、ここにCarPlayが起動しています。
        CarPlayシミュレータがアプリのテストにどのように役立つか見てみましょう。
        アプリが主にテンプレートベースであっても、アプリ内のアートワークが明るい画面でも暗い画面でもうまく動作することを確認するために使用することができます。
        Express Laneアプリを実行してみましょう。
        ツールバーのボタンを使って、明るい色と暗い色の表示を切り替えることができます。
        このアプリは、両方のスタイルで異なるアートワークを提供していることに注目してください。
        いい感じです。
        次に、私が作成したナビゲーションテストアプリ「Space Roads」に切り替えてみましょう。
        メイン設定パネルを使って、地図描画コードを異なる画面サイズで試してみます。
        そして最後に、計器クラスタの表示を有効にして、計器クラスタのサポートをテストしてみます。
        ほら、これです。
        素晴らしい動作です。先ほど、CarPlayシミュレータでアプリを完全にテストしたので、これで実際の車でもうまく動作することが確信できました。
        では、試してみましょう。さて、ここが私の車の中です。ご覧の通り、私のスマホは車に接続され、CarPlayを起動しています。
        まず、私のコネクテッドトレーラーコントローラーアプリを実行してみてください。
        この車両には、タッチスクリーンとノブコントローラの両方がありますが、多くのユーザーは運転中にノブコントローラを使いたいので、ノブを使ってアプリをうまく動作させることが重要です。
        このように、アプリのボタンに完全にアクセスすることができ、しかも特別なことは何もしていません。次に、ナビゲーションアプリ「Space Roads」に切り替えてみましょう。
        アプリを起動します。
        ...そして、ナビゲーションを開始します。
        ...そして、GOを押す。
        ドキッ! センターコンソールとインストルメントクラスターの両方にライブマップが表示されるようになりました。ライブマップが目の前にあるのは、ドライバーとしてとても嬉しいことです。
        ナビアプリを使うドライバーも、きっと気に入るはずです。
        では、今日はこの辺で。
        詳しくは、CarPlay開発者向けポータルサイトdeveloper. apple. com/carplay ありがとうございました。

        """
    }
}
