import Foundation

struct EnhanceVoiceCommunicationWithPushToTalk: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Enhance voice communication with Push to Talk"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6613/6613_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10117/")!
    }

    var english: String {
        """
        Kevin Ferrell: Hi, my name is Kevin, and I'm an engineer working on the new PushToTalk framework, which enables a walkie-talkie system experience for apps on iOS.
         Later I'll be joined by my colleague Trevor to talk about how you can enhance voice communication in your apps with this new framework.
         First, I'll introduce the PushToTalk framework and explain how it fits into your app.
         Next, we'll go over how to configure your app for PushToTalk.
         After that, Trevor will walk through how to transmit and receive audio using the framework.
         Finally, Trevor will wrap up with best practices for enhancing the Push To Talk user experience while preserving battery life for your users.
         I'll get started by introducing key features of the new PushToTalk framework.
         The PushToTalk framework enables you to build a new class of audio communication app on iOS that provides a walkie-talkie style experience for your users.
         Push To Talk apps have many uses in fields where rapid communication is essential such as health care and emergency services.
         To provide a great Push To Talk experience, users need a way to quickly access audio transmission features while also being able to see who is responding to them.
         At the same time, a Push To Talk app must be power efficient to ensure that users can maintain all-day battery life while using the app.
         The PushToTalk framework provides you with APIs to utilize a system UI that users can access anywhere on the system without having to directly launch your app.
         The system UI allows a user to quickly activate an audio transmission, which will launch your app in the background to record and stream audio to your server.
         The system provides transparency to users by showing who's speaking when your app plays audio from your server.
         The PushToTalk framework accomplishes this by introducing a new push notification type that notifies your app when new audio is available for playback.
         When your app receives this notification, it is launched in the background so that it can stream and play audio.
         The PushToTalk framework is designed to be compatible with existing end-to-end communication solutions and backend infrastructure.
         If you've already implemented a Push To Talk workflow in your app, it should be easy for you to integrate the PushToTalk framework into your existing code.
         The framework allows your app to implement its own audio encoding and streaming process to transmit audio between users.
         This provides flexibility in how audio transmission is handled by your app and enables compatibility with other platforms.
         Finally, many Push To Talk apps rely on wireless Bluetooth accessories to trigger audio recording and transmission.
         Your apps can continue to integrate with these accessories using the CoreBluetooth framework and can trigger audio recording in PushToTalk.
         If you are building your first Push To Talk app, keep these integration considerations in mind as you begin architecting your code.
         Before we begin walking through the code for the new PushToTalk framework, we want to demonstrate how the Push To Talk experience can work in your app.
         Trevor and I have built a demo app to show how PushToTalk works.
         To start, I'll tap the join button to connect to a Push To Talk session, which we call a channel.
         Once I'm joined to the channel, I can transmit and receive audio to other members of the channel.
         Trevor and a few of our colleagues have joined the same channel so that we can communicate throughout the day.
         I can transmit audio directly from the app using the microphone button, but the PushToTalk framework allows me to access the transmit feature from anywhere in the system.
         When there is an active Push To Talk channel, a blue pill will appear in the status bar.
         Tapping that pill shows the system UI.
         The system UI displays the name of the Push To Talk channel that I've joined and an image provided by the app to help users quickly identify the channel.
         I can transmit audio to the channel by pressing and holding the Talk button and then waiting for the system chime to indicate that I can begin speaking.
        Hey, Trevor.
         Are you ready to cover your WWDC slides? Over.
         Trevor Sheridan: When my device received Kevin's message, it displayed a notice that contained his name and image, providing transparency into who I'm receiving messages from.
         Once I launch the system UI, I can quickly respond to Kevin's message or leave the channel without having to stop what I'm doing.
         I don't want to leave Kevin waiting, so I'll reply now.
         Hey, Kevin.
         I'll be ready in a few minutes.
         Over.
         Kevin: The PushToTalk system UI can also be accessed from the Lock Screen so a user can receive and respond to messages without having to unlock their device.
        OK, see you soon! Over.
         Now that we've discussed how PushToTalk works, we'll review how to integrate the framework in your own app.
         There are a few modifications that you need to make to your Xcode project to support the PushToTalk framework.
         First, you need to add the new Push To Talk background mode.
         This enables your app to run in the background when responding to Push To Talk events.
         Next, you must also add the Push To Talk capability to your app to enable the framework features.
         The push notification capability is required to allow APNS to wake your app in the background to play received audio.
         Finally, your app must request recording permission from the user and include a microphone purpose string in its Info.
        plist file.
         Now we're ready to begin integrating the code.
         The first step in the Push To Talk workflow is to join a channel.
         The channel represents and describes the Push To Talk session to the system.
         Your app interacts with channels through a channel manager.
         The channel manager is the primary interface for your app to join channels and perform actions like transmitting and receiving audio.
         When you join a channel, the Push To Talk system UI becomes available and your app receives an APNS device token that can be used throughout the life of the channel.
         You must join a channel before you can begin transmitting and receiving audio.
         The first step is to create a channel manager using the class initializer.
         This initializer requires that you provide a channel manager delegate and a channel restoration delegate.
         Multiple calls to the initializer result in the same shared instance being returned, but we recommend that you store the channel manager in an instance variable.
         It is important to initialize your channel manager as soon as possible during app start up in your ApplicationDelegate's didFinishLaunchingWithOptions method.
         This ensures that the channel manager is initialized quickly so that existing channels can be restored and push notifications will be delivered to your app when it launches in the background.
         Now we're ready to join a channel.
         When someone joins a channel from your app, you must provide a UUID to identify the channel and a descriptor that describes the channel to the system.
         The same UUID will be used when interacting with the manager throughout the life of this channel.
         The descriptor includes a name and an image.
         Providing a unique image to represent the channel makes it easier for your users to identify the channel when interacting with the system.
         Your app joins a channel by calling the requestJoin method on the channel manager.
         Note that it is only possible to join a channel when your app is running in the foreground.
         When your app joins a channel, the channel manager delegate's didJoinChannel method will be called.
         This delegate method is your indication that your app has joined the channel.
         In addition, the delegate's receivedEphemeralPushToken method will be called with the APNS push token that can be used to send Push To Talk notifications to this device.
         This token will only be active for the life of the Push To Talk channel.
         Keep in mind that APNS push tokens are variable length and that you should not hardcode their length into your app.
         It is possible for the channel join request to fail, such as when attempting to join a channel when another channel is already active.
         If this occurs, the error handler will be called and the error will indicate the reason for the failure.
         When the user leaves a channel, the delegate's didLeaveChannel method will be called.
         Your user may leave the channel as a result of either your app requesting to leave programmatically or the user can tap the Leave Channel button in the system UI.
         The channel manager delegate has an associated LeaveChannel error-handling method that will be called if the request to leave the channel fails.
         PushToTalk supports restoring previous channels whenever your app is relaunched after being terminated or after a device reboot.
         In order for the system to accomplish this, you must provide a channel descriptor to update the system.
         Here we have a helper method that will fetch our cached channel descriptor in our restoration delegate.
         In order to keep the system responsive, you should return from this method as quickly as possible and should not perform any long-running or blocking tasks such as a network request to retrieve your channel descriptor.
         Throughout the lifecycle of your Push To Talk session, you should provide updates to the descriptor whenever information about the channel changes.
         You should also inform the system about changes to your network connection or server availability using the service status object.
         Here we're updating the descriptor for the channel.
         You can call this method whenever you need to update the channel name or image.
         In this example, we are providing an update to the system to indicate that the app's connection to its sever is in a reconnecting state.
         This updates the system UI accordingly and prevents the user from transmitting audio if the service status is connecting or disconnected.
         Once a connection is reestablished, you should update the service status to "ready.
        " Now let's review how to send and receive audio using PushToTalk.
         Trevor, are you ready to walk through the rest of the API? Over.
         Trevor: Yep.
         Send them over.
         Over.
         Now that we've seen how to configure the PushToTalk framework, let's explore how to transmit and receive audio.
         A core capability of the PushToTalk framework is to allow your users to quickly transmit audio.
         Users can begin audio transmission from within your app, or from the system Push To Talk UI.
         If your app supports Bluetooth accessories through CoreBluetooth, you can also begin transmission in the background in response to a peripheral's characteristic change.
         When transmitting, the PushToTalk framework unlocks the device's microphone and activates your app's audio session to enable audio recording in the background.
         Let's review this process in detail.
         To begin transmission from within your app, you can call the requestBeginTransmitting function.
         This can be called whenever your app is running in the foreground or when reacting to a change of a Bluetooth peripheral's characteristic.
         If the system is not able to begin transmitting, the delegate's failedToBeginTransmitting InChannel method will be called with the reason for the failure.
         For example, if the user has an ongoing cellular call active, they will not be able to begin a Push To Talk transmission.
         To stop transmitting, call the channel manager's stopTransmitting method.
         To handle failures when attempting to stop transmitting, such as when the user was not in a transmitting state, the channel manager delegate has an associated failedToStopTransmitting InChannel method.
         Whether you begin transmission from within your app or if the user starts from the system UI, your channel manager delegate will receive a "Did begin transmitting" callback.
         The transmission source will be passed to the method and indicate whether the transmission was started from the system UI, the programmatic API, or a hardware button event.
         Once transmission begins, the system will activate the audio session for your app.
         This is your signal that you can now begin recording.
         You should not start or stop your own audio session.
         When transmission ends, your channel manager delegate will receive the end transmission and audio session deactivation events.
         Keep in mind that while your transmission is active, your audio session may be interrupted by other sources, such as phone and FaceTime calls for which you need to handle within your app.
         The PushToTalk framework also allows your app to receive and play audio from other users while in the background.
         This process relies on a new Apple Push Notification type that is specific to Push To Talk apps.
         When your Push To Talk server has new audio for a user to receive, it should send the user a Push To Talk notification using the device push token you received when joining the channel.
         When the push notification is received by your app, it must report an active speaker to the framework, which will cause the system to activate your app's audio session and allow it to begin playback.
         The new Push To Talk notification is similar to other notification types on iOS and there are specific attributes that you must set to enable delivery to your Push To Talk app.
         First, the APNS push type must be set to "pushtotalk" in the request header.
         Next, the APNS topic header must be set to your app's bundle identifier with a ".
        voip-ptt" suffix appended to the end.
         The push payload can contain custom keys that are relevant to your app, such the name of an active speaker or an indication that the session has ended and the app should leave the Push To Talk channel.
         The body of the "aps" property can be left blank.
         Additionally, like other communication-related push types, Push To Talk payloads should have an APNS priority of 10 to request immediate delivery and an APNS expiration of zero to prevent older pushes that are no longer relevant from being delivered later.
         When your server sends a Push To Talk notification, your app will be started in the background and the incoming push delegate method will be called.
         When you receive a push payload, you will need to construct a push result type to indicate what action should be performed as a result of the push notification.
         To indicate that a remote user is speaking, return a push result that includes the active participant's information, including their name and an optional image.
         This will cause the system to set the active participant on the channel and indicate that the channel is in receive mode.
         The system will then activate your audio session, and call the didActivateaudioSession delegate method.
         You should wait for this method to be called before beginning playback.
         If your server decides that a user should no longer be joined to a channel, it may indicate this in the push payload, for which you can return a leaveChannel push result.
         It's important to note that you should return a PTPushResult from this method as quickly as possible and not block the thread.
         If you are attempting to set the active remote participant and do not have their image stored locally, you can return an activeRemoteParticipant with only the speaker's name.
         Then download their image on a separate thread, and once the image is retrieved, update the activeRemoteParticipant by calling setActiveRemoteParticipant on the channel manager.
         When the remote participant has finished speaking, you should set the activeRemoteParticipant to nil.
         This indicates to the system that you are no longer receiving audio on the channel and that the system should deactivate your audio session.
         This will also update the system Push To Talk UI and allow the user to transmit again.
         Now that we've covered the basics of how to integrate PushToTalk into your app, let's review some best practices for optimizing the user experience and preserving battery life.
        The PushToTalk framework provides a system UI for users to begin a transmission and leave a channel from anywhere within the system.
         Additionally, it is flexible and allows you to implement your own custom Push To Talk UI when your app is in the foreground.
         The PushToTalk framework utilizes shared system resources.
         Only one Push To Talk app can be active on the system at a time, and Push To Talk communication will be superseded by cellular, FaceTime, and VoIP calls.
         Your app should handle PushToTalk failures gracefully and respond accordingly.
         As mentioned earlier, the PushToTalk framework handles activating and deactivating your audio session for you.
         However, you should still configure your audio session's category to play and record when your app launches.
         The system provides built-in sound effects to alert the user that the microphone is activated and deactivated when transmitting.
         You should not provide your own sound effects for these events.
         It is also important for your app to monitor and respond to AVAudioSession notifications, such as session interruptions, route changes, and failures.
         Your Push To Talk app can be affected by these audio session events just like any other audio app on the system.
         It's important to optimize your app to preserve battery life.
         The PushToTalk framework provides your app with background runtime when needed, such as when transmitting and receiving audio.
         When your app is not being used by the user, it will be suspended by the system to preserve battery life.
         You should not activate or deactivate your own audio sessions.
         The system will handle audio session activation for you at the appropriate times.
         This ensures that your audio session has the proper priority within the system and can be suspended when it is not being used.
         Your Push To Talk server should use the new push notification type to alert your app that there is new audio to be played, or that the Push To Talk session has ended.
         For more information about improving the battery life in your app, refer to the "Power down: Improve battery consumption" session.
         When your Push To Talk app is in the background and the app is not transmitting or receiving audio, it will be suspended by the system.
         When your app is suspended, any network connections will be disconnected.
         You should consider adopting Network.
        framework and QUIC to reduce the steps needed to establish a secure TLS connection and improve initial connection speed.
         Network.
        framework has built-in support for QUIC.
         Check out the "Reduce networking delays for a more responsive app" session for more information about how to use QUIC.
         The PushToTalk framework enables you to build robust and power-efficient walkie-talkie style communication experiences within your apps.
         If you already have an app that implements a walk-talkie style experience on iOS, you should begin updating your existing app to use the new API.
         If you're implementing a new walkie-talkie app, you should use the PushToTalk framework now.
         Finally, please submit feedback as you begin testing the new framework and integrating it with your app.
         Thank you and have a great WWDC! Over and out!
        """
    }

    var japanese: String {
        """
        ケビン・フェレル: こんにちは、私はケビンです。新しいPushToTalkフレームワークに取り組んでいるエンジニアで、iOS上のアプリでトランシーバーシステムの体験を可能にするものです。
         この後、同僚のTrevorと一緒に、この新しいフレームワークを使ってアプリ内の音声通信を強化する方法についてお話します。
         まず、PushToTalkフレームワークを紹介し、それがあなたのアプリにどのようにフィットするかを説明します。
         次に、PushToTalk用にアプリを構成する方法について説明します。
         その後、Trevorは、フレームワークを使用して音声を送信および受信する方法を説明します。
         最後に、Trevorは、ユーザーのバッテリー寿命を維持しながら、Push To Talkのユーザー体験を向上させるためのベストプラクティスについてまとめます。
         まず、新しいPushToTalkフレームワークの主要な機能を紹介します。
         PushToTalkフレームワークを使用すると、ユーザーにトランシーバースタイルの体験を提供する新しいクラスのオーディオ通信アプリをiOSで構築することができます。
         Push To Talkアプリは、ヘルスケアや緊急サービスなど、迅速なコミュニケーションが不可欠な分野で多く利用されています。
         優れたPush To Talk体験を提供するためには、ユーザーが音声送信機能に素早くアクセスする方法と、誰が応答しているかを確認できることが必要です。
         同時に、Push To Talkアプリは、ユーザーがアプリを使用中に1日中バッテリーの寿命を維持できるように、電力効率に優れている必要があります。
         PushToTalkフレームワークは、ユーザーがアプリを直接起動しなくても、システム上のどこにでもアクセスできるシステムUIを利用するためのAPIを提供します。
         システムUIにより、ユーザーは素早く音声伝送を起動することができ、バックグラウンドでアプリを起動して音声を録音し、サーバーにストリーミングすることができます。
         アプリがサーバーから音声を再生すると、誰が話しているのかが表示され、ユーザーに透明性を提供します。
         PushToTalkフレームワークは、新しいオーディオが再生可能になったときにアプリに通知する新しいプッシュ通知タイプを導入することによって、これを実現します。
         アプリがこの通知を受け取ると、バックグラウンドで起動し、オーディオをストリーミングして再生できるようになります。
         PushToTalkフレームワークは、既存のエンドツーエンド通信ソリューションやバックエンドインフラと互換性があるように設計されています。
         すでにアプリにPush To Talkのワークフローを実装している場合、PushToTalkフレームワークを既存のコードに統合するのは簡単なはずです。
         このフレームワークにより、アプリはユーザー間で音声を伝送するための独自のオーディオエンコーディングとストリーミングプロセスを実装することができます。
         これにより、アプリによる音声伝送の処理方法に柔軟性が生まれ、他のプラットフォームとの互換性も確保できます。
         最後に、多くの Push To Talk アプリは、音声の録音と送信をトリガーするために、ワイヤレス Bluetooth アクセサリに依存しています。
         アプリは、CoreBluetoothフレームワークを使用してこれらのアクセサリと統合し、PushToTalkでオーディオ録音をトリガすることができます。
         初めてPush To Talkアプリを作成する場合は、コードの設計を始める際にこれらの統合に関する考慮事項を心に留めておいてください。
         新しいPushToTalkフレームワークのコードを説明し始める前に、Push To Talkの体験があなたのアプリでどのように機能するかを実証したいと思います。
         Trevor と私は、PushToTalk がどのように機能するかを示すためにデモ アプリを作りました。
         まず、参加ボタンをタップして、Push To Talkセッション（チャンネルと呼びます）に接続します。
         チャンネルに参加すると、そのチャンネルの他のメンバーと音声を送受信することができます。
         Trevorと数人の同僚が同じチャンネルに参加しているので、一日中コミュニケーションをとることができます。
         アプリからマイクボタンを使って直接音声を送信することもできますが、PushToTalkフレームワークを使えば、システム内のどこからでも送信機能にアクセスできます。
         アクティブなPush To Talkチャンネルがある場合、ステータスバーに青い錠剤が表示されます。
         その錠剤をタップすると、システムUIが表示されます。
         システムUIには、私が参加したPush To Talkチャンネルの名前と、ユーザーがチャンネルをすばやく識別できるようにアプリが提供する画像が表示されます。
         トークボタンを長押しして、チャイムが鳴るのを待つと、そのチャンネルに音声を送信することができます。
        やあ、トレバー。
         WWDCのスライドをカバーする準備はできたか？どうぞ
         トレバー・シェリダンです。私の端末がKevinからのメッセージを受信すると、彼の名前と画像を含む通知が表示され、誰からのメッセージなのかが透けて見えるようになっています。
         システムUIを立ち上げれば、今やっていることを中断することなく、すぐにKevinのメッセージに返信したり、チャンネルを外したりすることができるのです。
         ケビンを待たせておくわけにはいかないので、今返信します。
         やあ、Kevin。
         数分で準備するよ。
         どうぞ。
         ケビン：PushToTalkのシステムUIはロック画面からもアクセスできるので、ユーザーはデバイスのロックを解除しなくてもメッセージを受信して応答することができます。
        OK、またね! オーバー
         さて、PushToTalkの仕組みについて説明しましたが、次にフレームワークを自分のアプリに統合する方法について復習します。
         PushToTalkフレームワークをサポートするために、あなたのXcodeプロジェクトに必要ないくつかの修正があります。
         まず、新しいPush To Talkバックグラウンドモードを追加する必要があります。
         これにより、Push To Talkイベントに応答するときに、アプリがバックグラウンドで実行されるようになります。
         次に、フレームワークの機能を有効にするために、アプリにPush To Talkケイパビリティを追加する必要もあります。
         プッシュ通知機能は、APNSがバックグラウンドでアプリを起動し、受信した音声を再生できるようにするために必要です。
         最後に、アプリは、ユーザーから録音許可を要求し、マイク目的の文字列をInfo.
        plistファイルに含める必要があります。
         これで、コードの統合を開始する準備が整いました。
         Push To Talkのワークフローにおける最初のステップは、チャンネルに参加することです。
         チャネルは、Push To Talkセッションをシステムで表現し、説明します。
         あなたのアプリは、チャネルマネージャを通じてチャネルと対話します。
         チャネルマネージャは、アプリがチャネルに参加し、音声の送受信などのアクションを実行するための主要なインタフェースです。
         チャンネルに参加すると、Push To TalkシステムのUIが利用可能になり、アプリはチャンネルの有効期間中ずっと使用できるAPNSデバイストークンを受け取ります。
         音声の送受信を開始する前に、チャネルに参加する必要があります。
         最初のステップは、クラス・イニシャライザを使用してチャネル・マネージャを作成することです。
         このイニシャライザでは、チャネルマネージャデリゲートとチャネルレストレーションデリゲートを提供することが必要です。
         このイニシャライザーを複数回呼び出すと、同じ共有インスタンスが返されますが、チャンネルマネージャーをインスタンス変数に格納することをお勧めします。
         アプリの起動中に ApplicationDelegate の didFinishLaunchingWithOptions メソッドでチャンネル・マネージャーをできるだけ早く初期化することが重要です。
         これにより、チャンネル・マネージャーは迅速に初期化され、既存のチャンネルを復元できるようになり、アプリがバックグラウンドで起動したときにプッシュ通知が配信されるようになります。
         これでチャンネルに参加する準備が整いました。
         誰かがあなたのアプリからチャネルに参加するとき、チャネルを識別するための UUID と、チャネルを説明するディスクリプタをシステムに提供する必要があります。
         同じ UUID は、チャネルの存続期間中、マネージャとやりとりする際に使用されます。
         記述子は名前と画像を含みます。
         チャネルを表す一意の画像を提供することで、ユーザがシステムと対話する際にチャネルを識別しやすくなります。
         アプリがチャネルに参加するには、チャネルマネージャの requestJoin メソッドを呼び出します。
         チャネルへの参加は、アプリがフォアグラウンドで動作しているときのみ可能であることに注意してください。
         アプリがチャネルに参加すると、チャネルマネージャデリゲートの didJoinChannel メソッドが呼び出されます。
         このデリゲートメソッドは、アプリがチャネルに参加したことを示すものです。
         さらに、デリゲートのreceivedEphemeralPushTokenメソッドが、このデバイスにPush To Talk通知を送信するために使用できるAPNSプッシュトークンと共に呼び出されます。
         このトークンは、Push To Talkチャネルの存続期間中のみ有効です。
         APNSプッシュトークンは可変長であり、アプリにその長さをハードコードしてはいけないことに注意してください。
         チャネルへの参加要求が失敗することがあります。たとえば、別のチャネルがすでにアクティブなときにそのチャネルに参加しようとすると、失敗することがあります。
         この場合、エラーハンドラが呼び出され、失敗の理由がエラーに表示されます。
         ユーザがチャネルから退出すると、デリゲートの didLeaveChannel メソッドが呼び出されます。
         ユーザがチャネルから退出する場合、アプリがプログラムで退出を要求するか、ユーザがシステム UI の「チャネルを退出」ボタンをタップすることで退出します。
         チャネルマネージャデリゲートは、チャネルからの退出要求が失敗した場合に呼び出される LeaveChannel エラーハンドリングメソッドを持っています。
         PushToTalkは、アプリが終了した後やデバイスの再起動後に再スタートするたびに、以前のチャネルを復元することをサポートしています。
         これを実現するために、システムを更新するためのチャネルディスクリプタを提供する必要があります。
         ここでは、復元用デリゲートにキャッシュされたチャネルディスクリプタを取得するヘルパーメソッドを用意しています。
         システムの応答性を高めるため、このメソッドからの返り値はできるだけ早くする必要があります。また、チャンネル記述子を取得するためのネットワークリクエストのような、長時間にわたって実行されたりブロックされたりするタスクは実行しないでください。
         Push To Talk セッションのライフサイクルを通じて、チャネルに関する情報が変更されるたびに、記述子の更新を行う必要があります。
         また、ネットワーク接続やサーバの可用性の変化についても、 サービスステータスオブジェクトを使用してシステムに通知する必要があります。
         ここでは、チャネルのディスクリプタを更新しています。
         このメソッドは、チャネル名や画像を更新する必要がある場合にいつでも呼び出すことができます。
         この例では、アプリとサーバーの接続が再接続状態であることを示す更新をシステムに提供しています。
         これにより、システムのUIが適宜更新され、サービスステータスが接続中または切断中の場合、ユーザーが音声を送信することができなくなります。
         接続が再確立されたら、サービスステータスを「準備完了」に更新する必要があります。
        " それでは、PushToTalkを使用して音声を送受信する方法を確認しましょう。
         Trevor、残りのAPIについて説明する準備はできましたか？Over.
         Trevor: うん。
         送ってみてください。
         どうぞ。
         さて、PushToTalkフレームワークの設定方法について見てきましたが、次は音声の送信と受信の方法について見ていきましょう。
         PushToTalkフレームワークの中核となる機能は、ユーザーが素早く音声を送信できるようにすることです。
         ユーザーは、アプリ内から、またはシステムのPush To Talk UIから音声送信を開始することができます。
         また、アプリがCoreBluetoothを通じてBluetoothアクセサリをサポートしている場合、周辺機器の特性変化に応じてバックグラウンドで送信を開始することも可能です。
         送信時、PushToTalkフレームワークはデバイスのマイクをアンロックし、アプリのオーディオセッションをアクティブにしてバックグラウンドでのオーディオ録音を可能にします。
         この処理の詳細を確認しましょう。
         アプリ内から送信を開始するには、requestBeginTransmitting関数を呼び出します。
         これは、アプリがフォアグラウンドで動作しているときや、Bluetooth周辺機器の特性変更に反応したときにいつでも呼び出すことができます。
         送信を開始できない場合、失敗の理由を記述したデリゲートのfailedToBeginTransmitting InChannelメソッドが呼び出されます。
         例えば、ユーザーが携帯電話との通話を継続している場合、Push To Talk送信を開始することはできません。
         送信を停止するには、チャネルマネージャのstopTransmittingメソッドを呼び出します。
         ユーザーが送信中でない場合など、送信を停止しようとしたときの失敗を処理するために、チャネルマネージャデリゲートは、failedToStopTransmitting InChannelメソッドを持っています。
         アプリ内から送信を開始した場合でも、ユーザーがシステムUIから送信を開始した場合でも、チャネルマネージャデリゲートは「Did begin transmitting」コールバックを受け取ります。
         送信元はメソッドに渡され、送信がシステムUI、プログラムAPI、またはハードウェアボタンイベントのいずれから開始されたかを示します。
         送信を開始すると、システムはアプリのオーディオセッションを有効にします。
         これは、録音を開始できるようになったという合図です。
         自分自身でオーディオセッションを開始したり停止したりしてはいけません。
         送信が終了すると、チャネルマネージャーデリゲートは、end transmissionとaudio session deactivationイベントを受信します。
         送信中は、電話やFaceTimeの通話など、他のソースからオーディオセッションが中断される可能性があり、アプリ内で処理する必要があることに留意してください。
         PushToTalkフレームワークは、アプリがバックグラウンドで他のユーザーから音声を受信して再生することも可能にします。
         この処理は、Push To Talkアプリに特化した新しいApple Push Notificationタイプに依存しています。
         Push To Talkサーバーは、ユーザーが受信する新しいオーディオがあると、チャンネル参加時に受け取ったデバイスプッシュトークンを使って、ユーザーにPush To Talk通知を送信する必要があります。
         アプリがプッシュ通知を受信すると、フレームワークにアクティブなスピーカーを報告する必要があり、これによってシステムはアプリのオーディオセッションをアクティブにして再生を開始できるようにします。
         新しいPush To Talk通知は、iOSの他の通知タイプと似ており、Push To Talkアプリへの配信を有効にするために設定する必要のある特定の属性があります。
         まず、リクエスト・ヘッダでAPNSプッシュ・タイプを "pushtotalk "に設定する必要があります。
         次に、APNSのトピックヘッダには、アプリのバンドル識別子を設定する必要があります。
        voip-ptt "を末尾に付加してください。
         プッシュペイロードには、アクティブスピーカーの名前や、セッションが終了しアプリがPush To Talkチャネルを離れることを示す表示など、アプリに関連するカスタムキーを含めることができます。
         aps」プロパティの本文は、空白にすることができます。
         さらに、他の通信関連のプッシュタイプと同様に、Push To Talkペイロードは、即時配信を要求するためにAPNS優先度10を持ち、もはや関連性のない古いプッシュが後で配信されるのを防ぐためにAPNS有効期限をゼロにする必要があります。
         サーバーがPush To Talk通知を送信すると、アプリがバックグラウンドで起動し、incoming push delegateメソッドが呼び出されます。
         プッシュペイロードを受信したら、プッシュ通知の結果として実行されるべきアクションを示すために、プッシュ結果型を構築する必要があります。
         リモートユーザーが発言していることを示すには、アクティブな参加者の情報（名前とオプションの画像など）を含むプッシュ結果を返します。
         これにより、システムはアクティブな参加者をチャンネルに設定し、チャンネルが受信モードであることを示します。
         その後、システムはオーディオセッションをアクティブにし、didActivateaudioSessionデリゲートメソッドを呼び出します。
         このメソッドがコールされるのを待ってから、再生を開始する必要があります。
         サーバ側でユーザをチャンネルに参加させるべきではないと判断した場合、その旨をプッシュペイロードに記述して leaveChannel というプッシュ結果を返すことができます。
         このメソッドから PTPushResult をできるだけ早く返し、スレッドをブロックしないようにすることが重要です。
         アクティブなリモート参加者を設定しようとしていて、その画像がローカルに保存されていない場合、発言者の名前だけを含む activeRemoteParticipant を返すことができます。
         その後、別スレッドで画像をダウンロードし、画像が取得できたら、チャンネル・マネージャのsetActiveRemoteParticipantを呼び出してactiveRemoteParticipantを更新してください。
         リモート参加者が話し終えたら、activeRemoteParticipant を nil に設定する必要があります。
         これにより、そのチャンネルでの音声受信が終了し、音声セッションが非アクティブになったことがシステムに通知されます。
         これにより、システムのPush To Talk UIも更新され、ユーザーが再び送信できるようになります。
         さて、PushToTalkをアプリに統合する方法の基本を説明しましたが、ユーザー体験を最適化し、バッテリ寿命を維持するためのベストプラクティスを確認しましょう。
        PushToTalkフレームワークは、ユーザーがシステム内のどこからでも送信を開始し、チャンネルを終了するためのシステムUIを提供します。
         さらに、柔軟性があり、アプリがフォアグラウンドにあるときに、独自のカスタムPush To Talk UIを実装することができます。
         PushToTalkフレームワークは、共有システムリソースを利用します。
         一度にシステム上でアクティブにできるPush To Talkアプリは1つだけで、Push To Talk通信は携帯電話、FaceTime、VoIP通話に取って代わられる予定です。
         アプリは、PushToTalkの障害を優雅に処理し、それに応じて応答する必要があります。
         前述のとおり、PushToTalkフレームワークは、あなたに代わってオーディオセッションのアクティブ化と非アクティブ化を処理します。
         しかし、アプリの起動時にオーディオセッションのカテゴリを設定し、再生と録音を行う必要があります。
         システムは、送信時にマイクがアクティブになったこと、および非アクティブになったことをユーザーに知らせるために、組み込みのサウンドエフェクトを提供します。
         これらのイベントに対して、独自のサウンドエフェクトを提供するべきではありません。
         また、セッションの中断、経路変更、障害など、AVAudioSession の通知をアプリが監視し、対応することも重要です。
         Push To Talkアプリは、システム上の他のオーディオアプリと同様に、これらのオーディオセッションイベントの影響を受ける可能性があります。
         バッテリーの寿命を維持するために、アプリを最適化することが重要です。
         PushToTalkフレームワークは、音声の送受信時など、必要なときにアプリにバックグラウンドランタイムを提供します。
         アプリがユーザーによって使用されていないときは、バッテリ寿命を維持するためにシステムによって中断されます。
         あなた自身のオーディオセッションをアクティブにしたり、非アクティブにしたりするべきではありません。
         システムは、適切なタイミングであなたのためにオーディオセッションのアクティベーションを処理します。
         これにより、オーディオセッションはシステム内で適切な優先順位を持ち、使用されていないときには一時停止することができます。
         Push To Talkサーバーは、新しいプッシュ通知タイプを使用して、再生すべき新しいオーディオがあること、またはPush To Talkセッションが終了したことをアプリに通知する必要があります。
         アプリのバッテリー消費を改善するための詳細については、「パワーダウン。バッテリーの消費量を改善する」セッションを参照してください。
         Push To Talkアプリがバックグラウンドにあり、アプリが音声を送受信していない場合、システムによってアプリが一時停止されます。
         アプリがサスペンドされると、あらゆるネットワーク接続が切断されます。
         Network.Frameworkの採用を検討する必要があります。
        フレームワークとQUICを採用することで、安全なTLS接続を確立するために必要な手順を減らし、初期接続速度を向上させることができます。
         Network.frameworkはQUICをサポートしています。
        frameworkには、QUICのサポートが組み込まれています。
         QUICの使用方法については、「Reduce networking delays for a more responsive app」セッションを確認してください。
         PushToTalkフレームワークを使用すると、アプリ内で堅牢で電力効率に優れたトランシーバースタイルの通信体験を構築できます。
         iOS でトランシーバースタイルのエクスペリエンスを実装しているアプリを既にお持ちの場合は、新しい API を使用するために既存のアプリのアップデートを開始してください。
         新しいトランシーバーアプリを実装する場合は、今すぐPushToTalkフレームワークを使用する必要があります。
         最後に、新しいフレームワークのテストとアプリへの統合を開始したら、フィードバックを送信してください。
         ありがとうございました、そして素晴らしいWWDCをお過ごしください 以上、よろしくお願いします。
        """
    }
}
