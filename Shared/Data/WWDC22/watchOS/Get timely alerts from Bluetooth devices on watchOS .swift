import Foundation

struct GetTimelyAlertsFromBluetoothDevicesOnWatchOS: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Get timely alerts from Bluetooth devices on watchOS"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6632/6632_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10135/")!
    }

    var english: String {
        """
         Yann Ly-Gagnon: Hi.
         my name is Yann.
         I'm a core Bluetooth engineer.
         Today, I want to talk to you about timely alerts for your Bluetooth devices on Apple Watch.
        First, we will review how to update a complication while your watchOS App is in the background.
        Then, we will dive into how to listen for timely alerts on your watchOS App.
        We will also see new ways you can discover peripherals on watchOS 9.
        Finally, we will provide best practices and recommendations to help you design your Bluetooth accessory.
        Let's jump into our first topic: how to update a complication in the background for your watchOS App.
         Last year, in watchOS 8, we introduced a way to update complications with your Bluetooth accessory during Background app refresh.
        This is great for data that can be updated periodically, like in this example showing me the current air temperature.
        As a quick refresher, last year watchOS allows you to update your complication and use Background app refresh, which runs periodically in the background.
         Whenever Background app refresh happens, it allows your app to reconnect to your Bluetooth peripheral, retrieves data, and then disconnects from your peripheral.
         For more details about this, watch the video called "Connect Bluetooth devices to Apple Watch.
        " But what if a time-sensitive event happens on your Bluetooth peripheral that the user wants to know about? In watchOS 9, we are introducing a way to listen for alerts from your Bluetooth accessories in the background.
        Here's how it works.
         You will connect your device when your app is running, and start monitoring a characteristic.
        When your app stops running, Core Bluetooth maintains the connection to your device on your behalf, and continues listening for changes to your characteristic.
        When your device changes the value of that characteristic, your app will get runtime to process that event.
         You could post a local notification or send a network request, for example.
         This is intended to provide users with time-sensitive information they care about.
        Let's say I have a food thermometer.
         I can set a desired cook temperature to get alerted when I should remove my food from the oven.
         As the temperature approaches the desired temperature, the thermometer changes a characteristic's value, and the app posts a local notification that the food is almost ready.
        When the food is done, I receive the desired notification.
        And if the temperature keeps rising, I get one final notification.
        First, let's review how to configure the Background modes.
        Add Bluetooth-central to UIBackgroundModes in your Watch app's Info.
        plist.
        In Xcode it's called "Required background modes," and you should add "App communicates using CoreBluetooth.
        " Note that those Info.
        plist entries are the same as your app has for iOS if you want to use background execution as a central.
        You will need to edit your watchApp info.
        plist manually and not rely on the iOS "Signing capabilities.
        " Let's look at the code.
         Assuming you're already connected, you found a GATT service and just discovered a GATT characteristic.
         You will get the didDiscoverCharacteristicFor callback.
        Inside the callback, you can decide to get notifications every time the value changes.
        This is the same API as in watchOS 8, with the difference that it will also work while your app is in the background.
        Then implement the delegate method to handle changes to the characteristic's value with didUpdateValueFor.
        Once the characteristic changes, you can post a local notification here, send a network request, or whatever makes sense for your app.
         This method will be called both in the foreground and in the background, so make sure you perform the correct action in both cases.
        Now, let's talk about some situations you need to consider.
        First, on the topic of Bluetooth reconnections.
         If your device goes out of range, the Bluetooth connection will disconnect after a timeout.
        If this happens, your app will briefly get background runtime to call "connectPeripheral" in order to attempt reconnection.
         This is the same as what happens on iOS.
         As soon as the device is in range again, Core Bluetooth will reconnect to it.
        Now, let's talk about some limits.
         These limits are important to maintain optimal battery life for Apple Watch users.
        If your device is on the edge of Bluetooth range and repeatedly disconnects while in Background BLE connection, the reconnection range will be reduced.
         This means only devices close to the Apple Watch will reconnect.
        Those limits are counted on a rolling window of 24 hours and are reset whenever the user interacts on your App.
         Another limitation is regarding the number of background runtime opportunities for timely alerts.
        Only monitor characteristics that will change when something critical to the user happens.
         If you need to gather periodical data from your device, this should be done with Background app refresh.
        When your app is about to exceed the limit, the notification LeGattNearBackgroundNotificationLimit will be posted.
         It is a good practice for your app to monitor that error and realize that the user isn't interacting with the watchOS app.
        If this alert is important, it might be the right time to find another way to communicate with your user, such as through a network request or UI changes on your Bluetooth peripheral.
        After the limit is exceeded, the notification called LeGattExceededBackgroundNotificationLimit will be posted.
        After this point, your app will no longer receive background runtime and will revert back to watchOS 8 behavior, where there will be no background connection and only background app refresh.
        You can retrieve those two notifications in the error field of the GATT Notification Update.
         For background BLE connection, we recommend using the error to know when the limit is reached instead of counting down.
         For watchOS 9, the background runtime limit is set to 5.
         Both of these limits are reset whenever the user interacts with your app.
         They also reset 24 hours after the limit was reached in case there has been no user interaction with your app.
         Note: These limits only apply to Bluetooth Background LE connections.
         Background app refresh will continue to happen if your complication is on the active watch face, regardless of these limits.
        The amount of time you get to process each event is very short.
         There may not be enough time to do extremely complex processing, but enough to alert the user something important is happening.
         Finally, listening for timely alerts in the background requires Apple Watch Series 6 or later.
         Listening for alerts isn't the only thing you can do in the background.
         In watchOS 9, you can discover peripherals while your app is in the background.
        Let's say I have a Bluetooth medical device and a watchOS app that detects any timely alerts from it.
         To conserve power, the peripheral doesn't advertise until it detects a serious condition.
        Therefore, there's no connection between the device and Apple Watch yet.
         Here, the watchOS App will scan for a unique Service UUID from the medical device.
        Now, when the medical device detects something is serious, it starts advertising.
         The Apple Watch discovers this peripheral and launches the app in the background.
        The app can then alert the user of the condition detected.
        Here's how it works: The Watch app will initiate a scan for peripherals, and Core Bluetooth will continue scanning in the background.
        Once the peripheral's advertisement is detected, the app is given background runtime and can initiate a connection.
        Let's dive into the code to make this happen.
         The API hasn't changed from watchOS 8, but the scan will be honored even the app is in the background.
        Call "scanForPeripherals" with the service UUID you want to watch for.
         You can do this while your app is in foreground, and it will continue while the app is in the background.
         Note that if you ask for the option "allowDuplicatesKey," it will only be available when the app is in foreground.
         Now, let's talk about some limits.
         There is a limit on the number of times your app will be given background runtime between app launches.
         This limit is combined with the background runtime we saw previously when a GATT characteristic changes.
         Also, scanning for peripherals in the background requires Apple Watch Series 6 or later.
        In summary, we can now scan for a limited number of Bluetooth service UUID while the watch is scanning in the background.
         Now let's talk about how to design your accessory to make the most of these features.
        There is a power tradeoff you need to consider when designing your Bluetooth accessory.
        If power consumption is a concern, you should opt for a topology where your device can go into deep sleep and only advertise relevant information when an alert happens.
         The tradeoff is, you will have extra latency with the Bluetooth discovery time at every timely alerts, but you will be able to save more power.
        This is the topology provided in the example with the medical device.
        On the other hand, if you need low latency for your timely alerts, but the power is not so much a concern, you can consider using Background LE connection and send your alerts with GATT indications.
         Note that there is a limit of two Bluetooth connections for each app.
        This is the topology we saw in the example for temperature sensor.
        In order for your users to have the best experience with timely alerts, consider adding as much processing and intelligence on your peripheral to filter the data that is time critical versus non-time critical.
        Coming back to our temperature example, instead of transmitting every temperature, you can send only the relevant events or when the temperature changes.
         The benefit of this approach is, if you properly separate the time-critical events from periodic data, both your peripheral and the Apple Watch user will save on power, thus an overall better experience.
        When your device disconnects, we recommend advertising to re-establish the connection.
         The advertisement interval depends on the requirement of your Bluetooth peripheral, such as how fast it needs to reconnect, battery life, et cetera.
         In the accessory guidelines, we offer a few different values you can use.
         For example, if your device is battery constrained, you can use a value of 1022.
        5 milliseconds.
        Another example: if you advertise at a rate of 20 milliseconds, it should allow for a detection within a second in ideal conditions.
        You could design such that this high advertisement rate can be used only while a critical event happens.
        Now let's talk about connection interval.
         If you opt for a topology where your device remains connected in the background, we highly recommend using a long connection interval, such as at least 150 milliseconds.
         This will allow to save battery on your peripheral and provides best user experience on Apple Watch.
         Bluetooth 5.3 is coming to Apple Watch, along with connection sub-rating.
         This would allow to increase the connection interval while the Bluetooth peripheral is idle and quickly change to smaller connection interval when you need lower latency.
        Here is a table showing the differences between platforms.
         These are the currently supported configurations for Bluetooth Low Energy.
         Last year we introduced Background app refresh for watchOS as a new background execution mode.
         This year, if you own a Series 6 and above, we improved the background execution with timely alerts as we described today.
        Thanks for watching!

        """
    }

    var japanese: String {
        """
         Yann Ly-Gagnon：こんにちは。
         私の名前はヤンです。
         コアなBluetoothエンジニアです。
         今日は、Apple WatchのBluetoothデバイスのタイムリーなアラートについてお話したいと思います。
        まず、watchOS App がバックグラウンドにあるときにコンプリケーションを更新する方法を確認します。
        次に、watchOS App でタイムリーアラートを聞く方法について説明します。
        さらに、watchOS 9 で周辺機器を検出する新しい方法についても説明します。
        最後に、Bluetooth アクセサリーの設計に役立つベストプラクティスと推奨事項を紹介します。
        最初のトピックに飛び込みましょう：watchOS Appのバックグラウンドでコンプリケーションを更新する方法です。
         昨年のwatchOS 8では、Backgroundアプリの更新時にBluetoothアクセサリでコンプリケーションを更新する方法を紹介しました。
        これは、この例のように、現在の気温を表示してくれるような、定期的に更新できるデータには最適です。
        簡単におさらいすると、昨年のwatchOSでは、コンプリケーションを更新するために、バックグラウンドで定期的に実行されるBackground app refreshを使用することができます。
         Background app refreshが発生するたびに、アプリはBluetooth周辺機器に再接続し、データを取得した後、周辺機器との接続を切ります。
         この詳細については、「BluetoothデバイスをApple Watchに接続する」というビデオをご覧ください。
        " しかし、ユーザーが知りたいと思うようなタイムセンシティブなイベントがBluetooth周辺機器で発生した場合はどうでしょうか？watchOS 9では、Bluetoothアクセサリからのアラートをバックグラウンドで聞く方法を導入しています。
        その仕組みは次のとおりです。
         アプリが起動しているときにデバイスを接続し、特性の監視を開始します。
        アプリの実行を停止すると、Core Bluetoothがあなたに代わってデバイスとの接続を維持し、特性の変化をリッスンし続けます。
        デバイスがその特性の値を変更すると、アプリはそのイベントを処理するためにランタイムを取得します。
         例えば、ローカル通知を投稿したり、ネットワークリクエストを送信したりすることができます。
         これは、ユーザーが気になるタイムセンシティブな情報を提供するためのものです。
        例えば、私が食品の温度計を持っているとしましょう。
         希望の調理温度を設定し、オーブンから食品を取り出すべきときにアラートを受け取ることができます。
         希望する温度に近づくと、温度計の特性値が変化し、アプリがローカルに「もうすぐ食べごろです」という通知を出します。
        料理ができあがると、希望の通知が届きます。
        そして、温度が上がり続けると、最後にもう一回通知が来る。
        まず、Backgroundモードの設定方法を確認しましょう。
        WatchアプリのInfo.plistのUIBackgroundModesにBluetooth-centralを追加します。
        plistに追加します。
        Xcodeでは「Required background modes」となっているので、「App communicates using CoreBluetooth」を追加してください。
        " これらのInfo.
        plistのエントリは、バックグラウンド実行をセントラルとして使用したい場合、アプリがiOS用に持っているものと同じであることに注意してください。
        watchAppのInfo.
        plistを手動で編集し、iOSの "Signing capabilities "に依存しないようにする必要があります。
        " コードを見てみましょう。
         すでに接続していると仮定して、GATTサービスを見つけ、GATT特性を発見したところです。
         あなたはdidDiscoverCharacteristicForコールバックを取得します。
        このコールバックの中で、値が変化するたびに通知を受けるかどうかを決めることができます。
        これはwatchOS 8と同じAPIですが、アプリがバックグラウンドにある間にも動作する点が異なります。
        次に、didUpdateValueForでcharacteristicの値の変更を処理するデリゲートメソッドを実装します。
        特性が変更されると、ここにローカル通知を投稿したり、ネットワークリクエストを送信したり、アプリにとって意味のあることを行うことができます。
         このメソッドはフォアグラウンドとバックグラウンドの両方で呼び出されるので、どちらの場合でも正しいアクションを実行することを確認してください。
        それでは、考慮すべきいくつかの状況について説明します。
        まず、Bluetoothの再接続の話題です。
         デバイスが圏外になった場合、Bluetooth接続はタイムアウト後に切断されます。
        この場合、アプリは再接続を試みるために、バックグラウンドのランタイムを短時間取得して "connectPeripheral "を呼び出します。
         これは、iOSで起こることと同じです。
         デバイスが再び範囲内に入ると、Core Bluetoothはデバイスに再接続します。
        さて、いくつかの制限について説明します。
         これらの制限は、Apple Watchユーザーのバッテリー寿命を最適に維持するために重要です。
        デバイスがBluetoothの範囲の端にあり、バックグラウンドBLE接続中に切断を繰り返すと、再接続の範囲が狭くなります。
         つまり、Apple Watchに近いデバイスだけが再接続されます。
        これらの制限は、24時間のローリングウィンドウでカウントされ、ユーザーがあなたのAppでインタラクションするたびにリセットされます。
         もう一つの制限は、タイムリーなアラートのためのバックグラウンドランタイムの機会の数に関するものです。
        ユーザーにとって重要なことが起きたときに変化する特性のみを監視する。
         デバイスから定期的にデータを収集する必要がある場合は、Background app refreshで行う必要があります。
        アプリが制限を超えそうになると、LeGattNearBackgroundNotificationLimitという通知が掲示されます。
         アプリがそのエラーを監視し、ユーザーがwatchOSアプリとインタラクトしていないことを認識するのは良い習慣です。
        このアラートが重要であれば、ネットワークリクエストやBluetooth周辺機器のUI変更など、ユーザーとコミュニケーションする別の方法を見つけるのに適したタイミングかもしれません。
        制限を超えると、LeGattExceededBackgroundNotificationLimitという通知が掲示されます。
        この時点以降、アプリはバックグラウンドでの実行を受けなくなり、バックグラウンドでの接続がなく、バックグラウンドでのアプリの更新のみとなる watchOS 8 の動作に戻ります。
        この2つの通知は、GATT Notification Updateのエラー欄で取得することができます。
         バックグラウンドでのBLE接続の場合、カウントダウンではなく、エラーで上限に達したことを知ることをお勧めします。
         watchOS 9の場合、バックグラウンドの実行時間の上限は5に設定されています。
         これらの制限は、ユーザーがアプリとインタラクションするたびにリセットされます。
         また、アプリとのインタラクションがない場合は、制限に達してから24時間後にリセットされます。
         注：これらの制限は、Bluetooth Background LE接続にのみ適用されます。
         バックグランドアプリの更新は、これらの制限に関係なく、あなたのコンプリケーションがアクティブなウォッチフェイス上にある場合、引き続き行われます。
        各イベントを処理するために得られる時間は非常に短いです。
         極めて複雑な処理を行うには十分な時間ではないかもしれませんが、何か重要なことが起こっていることをユーザーに知らせるには十分な時間です。
         最後に、バックグラウンドでタイムリーなアラートを聴くには、Apple Watch Series 6以降が必要です。
         バックグラウンドでできることは、アラートのリスニングだけではありません。
         watchOS 9では、アプリがバックグラウンドにある間に周辺機器を検出することができます。
        例えば、Bluetooth医療機器と、そこからのタイムリーなアラートを検出するwatchOSアプリがあるとしましょう。
         電力を節約するために、周辺機器は深刻な状態を検出するまで広告を出しません。
        したがって、デバイスとApple Watchの間にはまだ接続がありません。
         ここで、watchOS Appは、医療機器から固有のサービスUUIDをスキャンします。
        さて、医療機器は何か深刻な状態を検出すると、広告を開始します。
         Apple Watchはこの周辺機器を発見し、バックグラウンドでアプリを立ち上げる。
        そして、アプリは検出された状態をユーザーに警告することができます。
        その仕組みはこうです。Watchアプリが周辺機器のスキャンを開始し、Core Bluetoothがバックグラウンドでスキャンを継続します。
        周辺機器の広告が検出されると、アプリにバックグラウンドのランタイムが与えられ、接続を開始することができます。
        これを実現するためのコードに飛び込んでみましょう。
         APIはwatchOS 8から変わっていませんが、アプリがバックグラウンドにあってもスキャンは優先されます。
        scanForPeripherals "に監視したいサービスのUUIDを指定して呼び出します。
         アプリがフォアグラウンドにあるときに実行すれば、アプリがバックグラウンドにある間でも継続されます。
         allowDuplicatesKey "オプションを指定した場合、アプリがフォアグラウンドのときのみ有効であることに注意してください。
         さて、いくつかの制限について説明します。
         アプリの起動と起動の間に、アプリにバックグラウンド実行時間を与える回数に制限があります。
         この制限は、以前に見たGATT特性が変化したときのバックグラウンドランタイムと組み合わされます。
         また、バックグラウンドで周辺機器をスキャンするには、Apple Watch Series 6 以降が必要です。
        まとめると、腕時計がバックグラウンドでスキャンしている間に、限られた数のBluetoothサービスのUUIDをスキャンできるようになったということです。
         では、これらの機能を最大限に活用するために、アクセサリーをどのように設計するかについて説明します。
        Bluetoothアクセサリーを設計する際に考慮しなければならないのは、電力のトレードオフです。
        消費電力が気になる場合は、デバイスがディープスリープに入り、アラートが発生したときだけ関連情報をアドバタイズするトポロジーを選択する必要があります。
         トレードオフは、タイムリーなアラートが発生するたびにBluetoothの検出時間による余分な待ち時間が発生することですが、より多くの電力を節約することができるようになります。
        これは、医療機器の例で提供されているトポロジーです。
        一方、タイムリーアラートのために低遅延が必要だが、電力はそれほど気にならない場合は、Background LE接続を使用し、GATT表示でアラートを送信することを検討することができます。
         なお、各アプリのBluetooth接続は2つまでとなっています。
        これは、温度センサーの例で見たトポロジーです。
        ユーザーがタイムリーなアラートで最高の体験をするために、周辺機器にできるだけ多くの処理とインテリジェンスを追加して、タイムクリティカルなデータとそうでないデータをフィルタリングすることを検討してください。
        温度の例に戻ると、すべての温度を送信するのではなく、関連するイベントや温度が変化したときだけ送信することができます。
         この方法の利点は、タイムクリティカルなイベントと定期的なデータを適切に分離すれば、周辺機器とApple Watchユーザーの両方が電力を節約でき、全体としてより良いエクスペリエンスが得られるということです。
        デバイスが切断された場合、接続を再確立するために広告を出すことをお勧めします。
         広告の間隔は、再接続に必要な速度、バッテリー寿命など、お使いの Bluetooth 周辺機器の要件に依存します。
         アクセサリーのガイドラインでは、使用できるいくつかの異なる値を提供しています。
         例えば、デバイスがバッテリーに制約がある場合、1022.5ミリ秒の値を使用することができます。
        5ミリ秒です。
        別の例では、20ミリ秒のレートで広告を出すと、理想的な条件下では1秒以内に検出できるはずです。
        この高いアドバタイズレートは、重要なイベントが発生している間のみ使用できるように設計することができます。
        次に、接続間隔について説明します。
         デバイスがバックグラウンドで接続を維持するトポロジーを選択する場合、少なくとも150ミリ秒など、長い接続間隔を使用することを強くお勧めします。
         これにより、周辺機器のバッテリーを節約し、Apple Watchで最高のユーザーエクスペリエンスを提供することができます。
         Bluetooth 5.3は、接続のサブレーティングとともにApple Watchに搭載されます。
         これにより、Bluetooth周辺機器がアイドル状態の時は接続間隔を長くし、低遅延が必要な時は素早く接続間隔を短く変更することができます。
        以下は、プラットフォームごとの違いを示した表です。
         これらは、現在サポートされているBluetooth Low Energyの設定です。
         昨年、新しいバックグラウンド実行モードとして、watchOSのBackground app refreshを紹介しました。
         今年は、Series 6以上をお持ちの方は、本日ご紹介したようなタイムリーなアラートによるバックグラウンド実行を改善しました。
        ご視聴ありがとうございました。

        """
    }
}

