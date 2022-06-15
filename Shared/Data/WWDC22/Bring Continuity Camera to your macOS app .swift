import Foundation

struct BringContinuityCameraToYourMacOSApp: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Bring Continuity Camera to your macOS app"
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10018/")!
    }

    var english: String {
        """
        Hi, my name is Karen Xing.
         I'm an engineer in the Camera Software team.
         Welcome to "Bring Continuity Camera support to your macOS app" To start this session I will talk about, what is Continuity Camera? Next, I will discuss how your application can build an automatic camera selection experience with Continuity Camera.
         And finally, I will walk through the APIs that are new in macOS 13 for Continuity Camera.
         With Continuity Camera, you can now use iPhone as your webcam.
         Setup is seamless; just bring your iPhone close to your Mac.
         And it works wirelessly so you can quickly join a call.
         Your iPhone will appear on your Mac as an external camera and microphone under several conditions.
         First, you must be running macOS 13 and iOS 16.
         Both Mac and iPhone must be signed into the same Apple ID using two-factor authentication.
         For wired connection, the phone needs to be connected to Mac over USB.
         Or for wireless connection, the two devices need to be in proximity and have both Bluetooth and Wi-Fi turned on.
         Rather than talking through it, let me show you right away how magical Continuity Camera looks on devices.
         Here I have a MacBook Pro and iPhone 13 Pro.
         Both devices are signed in to the same Apple ID.
        The phone is placed on a stand attached to my MacBook.
         I will be joining a video conferencing call with my colleague Eric today and show you how we can use Continuity Camera in Zoom.
        The app is launched using the built-in camera first, and then an onboarding dialogue shows up describing what you can do with the new camera.
         The dialogue shows up one time after your Mac is upgraded to macOS 13 when you open a camera application for the first time and there's an iPhone eligible for Continuity Camera.
        Hi, Eric! Eric: Oh, Karen! Hi! Karen: After the onboarding dialogue is shown on the system, Continuity Camera and microphone devices will become available in all applications.
        Let's switch to use this camera and see how it looks.
        Continuity Camera uses the rear camera system on the iPhone, so you get the same great video quality that you expect from iPhone.
         And it works with all four orientations of the phone.
        The portrait orientation gives you a more zoomed in field of view compared to landscape orientation.
        Continuity Camera also lets you do things that were never before possible with a webcam, including several new video effects.
         You're probably already familiar with Center Stage and Portrait video effects introduced in iOS 14.
        5 and macOS 12.3.
         If not, I highly recommend watching the "What's new in Camera Capture" session from WWDC 2021 to learn more about system video effects and how to interact with them in applications.
         Let's go to Control Center and enable system video effects on Continuity Camera.
        Center Stage keeps you in frame as you move around in the scene.
        Portrait blurs the background and naturally puts the focus on you.
         Portrait is only supported on Apple silicon Macs, but with Continuity Camera, it is now available on all Intel and Apple silicon Macs.
        Studio Light is a new system video effect available on macOS 13.
         It is supported by Continuity Camera when using iPhone 12 or newer.
         Enable this when you want to look your best on screen.
         It provides a stunning lighting effect that dims the background and illuminates your face.
         Studio Light is perfect for tough lighting situations, like when you're in front of a window.
         Even though I'm showing you each video effect separately for a clear comparison, all of them work well together.
        And any combination of the effects can be applied at the same time.
        Here's another exciting feature I really want to show you for Continuity Camera.
         When you want to work together and share what's on your desk, you can now use Desk View.
         The Desk View app comes with macOS 13 and can be launched right here in Control Center.
        It works like an overhead camera setup, without needing all the complicated equipment.
         iPhone will split the Ultra Wide camera feed in two, showing off your desk and face both at the same time, so you can collaborate on a school project or teach a friend a knitting stitch.
         It leverages the extended vertical field of view of our Ultra Wide angle camera, applies perspective distortion correction onto cropped frames, and then rotates the frames to create this Desk View.
         You can use the share window function available in most video conferencing apps to share this Desk View feed, running in parallel with the main video camera feed.
        Desk View can also be used alone without streaming from the main camera at the same time.
         But when you do stream from both Desk View and the main camera, we recommend enabling Center Stage on the main camera for a better framing to capture face and body there.
         The feature is supported when the phone is placed in either landscape or portrait orientation.
        The portrait orientation provides the most versatility, as there's a larger vertical field of view.
         There's also a Desk View camera API to provide customized integration suitable for your application.
         I will talk about the API in a moment.
         During a video conferencing call on your Mac, we want you to focus on the session but we also want to make sure you are not missing anything important.
         When Continuity Camera is in use, all notifications on your phone will be silenced and important call notifications will be forwarded on your Mac.
         Bye, Eric! Eric: Bye, Karen! Karen: We've just talked about all the great experiences available to users without writing a single line of new code in your application.
         But with some adoption of new APIs, you can make the Continuity Camera experience even more magical and polished in your app.
         Now that most users will get at least two camera devices on the Mac, we've thought more on how cameras should be managed.
         Prior to macOS 13, when a device is either unplugged or a better camera becomes available on the system, a manual selection step is usually required in applications.
         We'd like to offer customers a magical experience by switching cameras automatically in applications.
         We've added two new APIs in the AVFoundation framework to help you build this function in your app: the class properties userPreferredCamera and systemPreferredCamera on AVCaptureDevice.
         userPreferredCamera is a read/write property.
         You will need to set this property whenever a user picks a camera in the application.
         This allows the AVCaptureDevice class to learn users' preference, store a list of cameras for each application across app launches and reboots, and use that information to suggest a camera.
         It also takes into account whether any camera becomes connected or disconnected.
         This property is key-value observable and intelligently returns the best selection based on user preference.
         When the most recent preferred device becomes disconnected, it spontaneously changes to the next available camera in the list.
         Even when there's no user selection history or none of the preferred devices are connected, the property will always try to return a camera device that's ready to use and prioritize cameras that have been previously streamed.
         It only returns nil when there's no camera available on the system.
         systemPreferredCamera is a read-only property.
         It incorporates userPreferredCamera as well as a few other factors to suggest the best choice of cameras present on the system.
         For example, this property will return a different value than userPreferredCamera when a Continuity Camera shows up signaling that it should be automatically chosen.
         The property also tracks device suspensions internally so it prioritizes unsuspended devices over suspended ones.
         This is helpful for building automatic switching behavior to change to another camera if the built-in camera gets suspended from closing the MacBook lid.
         Continuity Camera signals itself to be automatically chosen when the phone is placed on a stationary stand in landscape orientation, the screen is off, and either connected over USB to the Mac or within a close range of the Mac.
         In this scenario, the user's intention is clear that the device should be used as Continuity Camera.
        When adopting systemPreferredCamera API, you should always key-value observe this property and update your AVCaptureSession's video input device accordingly to offer a magic camera selection experience.
         userPreferredCamera and systemPreferredCamera are already adopted by first-party applications.
         With more and more applications adopting these APIs, we will be able to provide customers a universal and consistent method of camera selection on Apple devices.
         Let me show you a demo to illustrate how automatic switching with Continuity Camera looks like in FaceTime.
        Here in FaceTime, I'm in the Automatic Camera Selection mode.
         For applications that want to offer both manual and automatic behavior, we recommend adding a new UI for enabling and disabling auto mode.
        FaceTime is currently streaming from the built-in camera.
         When I pick up the phone from the desk and place it on a stand behind the MacBook......
        FaceTime switches to stream from the Continuity Camera seamlessly.
         That is where the new class property systemPreferredCamera comes in: the property value changes to Continuity Camera when the phone is in a position ready to stream.
         You might want to build your application in a similar way.
         Here's my recipe for how to implement Automatic Camera Selection and manual selection mode.
         When Automatic Camera Selection is on, start key-value observing the systemPreferredCamera property.
         Follow the systemPreferredCamera whenever it changes by updating your session's input device.
        In auto mode, we highly recommend still providing options to let users pick a camera by themselves.
         When a different camera gets picked, set the userPreferredCamera to that device, which then gets reflected in systemPreferredCamera property value.
         When Automatic Camera Selection is off, stop key-value observing the systemPreferredCamera property.
         Instead of following systemPreferredCamera, you will need to update session's input device with the user-picked camera in manual mode.
         But same as auto mode, you still need to set the userPreferredCamera property every time a user picks a different camera, so we maintain the user's history of preferred cameras and suggest the right camera when getting back to Automatic Camera Selection mode.
         For best practices on how to incorporate userPreferredCamera and systemPreferredCamera APIs, please check out the new sample app, "Continuity Camera Sample.
        " Besides bringing a magical webcam experience to the Mac, Continuity Camera also presents you with new opportunities to harness the power of iPhone-specific camera features in your Mac app.
         We've added a few AVCapture APIs on macOS 13 to help applications better utilize Continuity Camera devices.
         We're bringing the amazing quality of iPhone photo captures to macOS, thanks to Continuity Camera.
         First off, we support capturing high-resolution photos.
         Previously, macOS has only supported photo captures at video resolution.
         Starting with macOS 13, you will be able to capture up to 12 megapixel photos with Continuity Camera.
         This can be enabled by first setting highResolutionCaptureEnabled to true on AVCapturePhotoOutput object before starting a capture session, and then setting the highResolutionPhotoEnabled property to true on your photoSettings object for each capture.
         In addition to capturing high-res photos, Continuity Camera supports controlling how photo quality should be prioritized against speed by first setting the maximum photo quality prioritization on the photoOutput object, then choosing the prioritization for each capture by setting photoQualityPrioritization property on the AVCapturePhotoSettings object.
         To learn more about choosing the right prioritization for your application, please check out "Capture high-quality photos using video formats" in WWDC2021.
         Another photo-related feature is flash capture.
         You can now set flashMode on your photoSettings object to control whether flash should be on, off, or automatically chosen based on the scene and lighting conditions.
         We are also making AVCaptureMetadataOutput available on macOS to allow processing timed metadata produced by a capture session.
         You can now stream face metadata objects and human body metadata objects from iPhone.
         Let's go through how to setup a session to receive face metadata objects.
         After setting up the session with proper video input and output, you will need to create an AVCaptureMetadataOutput and call addOutput to add it to the session.
         To receive face metadata in particular, set your object types array on the output to include the face object type.
         Make sure the metadata types requested are supported by checking availableMetadataObjectTypes property.
         Then setup the delegate to receive metadata callbacks.
         After the session starts running, you will get callbacks with face metadata objects produced in real time.
         Besides AVCapturePhotoOutput and AVCaptureMetadataOutput we just talked about, Continuity Camera also supports video data output, movie file output, and AVCaptureVideoPreviewLayer.
         Here's a list of video formats supported by Continuity Camera that you'll want to be aware of when integrating this camera into your application.
         It supports three 16 by 9 formats -- from 640 by 480 to 1080p -- and one 4 by 3 format: 1920 by 1440.
         You can choose between formats supporting up to 30 frames per second or 60 frames per second, based on the need.
         Another major addition is Desk View device API.
         Desk View camera is exposed as a separate AVCaptureDevice.
         There are two ways you can find this device.
         First one is by looking up AVCaptureDeviceType DeskViewCamera in device discovery session.
         Alternatively, if you already know the AVCaptureDevice object of the main video camera, you can use the companionDeskViewCamera property on that device to access a Desk View device.
         This API will be helpful to pair main camera and Desk View device when there are multiple Continuity Camera devices around.
         Once you have the AVCaptureDevice object of the desired Desk View camera, you can use it with an AVCapture video data output, movie file output, or video preview layer in the capture session just as you can with other camera devices.
         Desk View device currently supports one streaming format in 420v pixel format.
         The resolution of the format is 1920 by 1440, and the maximum frame rate supported is 30 fps.
         This is the end of the session.

        You learned about Continuity Camera, how to build a magical camera selection on macOS, and a handful of new APIs to integrate Continuity Camera in your Mac application.
        I'm excited to see you adopting all these APIs, and have a great rest of WWDC.

        """
    }

    var japanese: String {
        """
        こんにちは、私はカレン・シンです。
         カメラソフトウェアチームのエンジニアです。
         本セッションではまず、Continuity Cameraとは何か？次に、Continuity Cameraを使用して、あなたのアプリケーションがどのように自動カメラ選択エクスペリエンスを構築できるかを説明します。
         そして最後に、Continuity CameraのためにmacOS 13で新たに追加されたAPIについて説明します。
         Continuity Cameraを使用すると、iPhoneをウェブカメラとして使用できるようになります。
         セットアップはシームレスで、iPhoneをMacに近づけるだけです。
         また、ワイヤレスで動作するので、すぐに通話に参加することができます。
         iPhoneは、いくつかの条件を満たすことで、外部カメラおよびマイクとしてMac上に表示されます。
         まず、macOS 13とiOS 16を搭載していることが条件です。
         MacとiPhoneの両方が、2ファクタ認証を使って同じApple IDにサインインしている必要があります。
         有線接続の場合は、iPhoneとMacをUSBで接続する必要があります。
         また、無線接続の場合は、2つのデバイスが近接し、BluetoothとWi-Fiの両方がオンになっている必要があります。
         まずは、Continuity Cameraがどのように見えるかをお見せしましょう。
         ここでは、MacBook ProとiPhone 13 Proを用意しました。
         どちらのデバイスも同じApple IDにサインインしています。
        iPhoneはMacBookに取り付けたスタンドの上に置いています。
         今日は同僚のEricとビデオ会議に参加し、ZoomでContinuity Cameraをどのように使うかを紹介します。
        まず内蔵カメラでアプリを起動し、新しいカメラで何ができるかを説明するオンボーディングダイアログが表示されます。
         ダイアログは、MacをmacOS 13にアップグレードした後、初めてカメラアプリを開いたときに1回だけ表示され、Continuity Cameraの対象となるiPhoneがあります。
        ハイ、エリック! エリック：あ、カレン! ハイ！エリック カレン: オンボーディングダイアログがシステムに表示された後、Continuity Cameraとマイクデバイスがすべてのアプリケーションで使用できるようになります。
        このカメラを使うように切り替えて、どんな風に見えるか見てみましょう。
        Continuity Cameraは、iPhoneのリアカメラシステムを使用しているので、iPhoneに期待されるような素晴らしいビデオ画質を得ることができます。
         また、iPhoneの4つの方向すべてで動作します。
        縦のオリエンテーションは横のオリエンテーションと比較される視野のよりズームレンズを与える。
        また、Continuity Cameraでは、いくつかの新しいビデオエフェクトなど、これまでのウェブカメラでは不可能だったことが可能です。
         iOS 14.5とmacOS 12.0で導入されたCenter StageとPortraitのビデオエフェクトは、すでにおなじみでしょう。
        5とmacOS 12. 3.
         そうでない場合は、WWDC 2021の「What's new in Camera Capture」セッションを見て、システムのビデオエフェクトとアプリケーションでの操作方法について学ぶことを強くお勧めします。
         コントロールセンターに行き、Continuity Cameraのシステムビデオエフェクトを有効にしましょう。
        Center Stageは、シーンの中で動き回ってもフレーム内に収まるようにします。
        ポートレートは、背景をぼかし、自然にあなたに焦点を当てます。
         PortraitはAppleシリコンMacにのみ対応していますが、Continuity CameraではIntelとAppleシリコンMacのすべてで利用できるようになりました。
        Studio Lightは、macOS 13で利用できる新しいシステムビデオエフェクトです。
         iPhone 12以降を使用している場合、Continuity Cameraでサポートされます。
         スクリーン上で自分を最高に見せたいときに有効にしてください。
         背景を暗くし、顔を明るくする魅力的な照明効果を提供します。
         スタジオライトは、窓の前にいるときなど、厳しい照明の状況に最適です。
         わかりやすく比較するために各ビデオエフェクトを別々に紹介していますが、どのエフェクトも一緒に使うと効果的です。
        また、どのエフェクトを組み合わせても、同時に適用することができます。
        もうひとつ、「Continuity Camera」の魅力的な機能をご紹介しましょう。
         机の上にあるものをみんなで共有して作業したい時、Desk Viewが使えるようになったのです。
         Desk ViewはmacOS 13に搭載されたアプリケーションで、コントロールセンターから起動できます。
        オーバーヘッドカメラのような仕組みで、複雑な機材は必要ありません。
         iPhoneがウルトラワイドカメラの映像を2分割し、あなたのデスクと顔を同時に映し出すので、学校のプロジェクトで共同作業をしたり、友だちに編み物の手ほどきをしたりすることができます。
         ウルトラワイドカメラの縦方向の広い視野を活かし、切り出したフレームに遠近感の補正を施し、フレームを回転させることでデスクビューを作成します。
         デスクビューは、多くのビデオ会議アプリに搭載されている共有ウィンドウ機能を使って、メインのビデオカメラ映像に並行して共有することができます。
        デスクビューは、メインカメラから同時にストリーミングせずに、単独で使用することもできます。
         しかし、Desk Viewとメインカメラの両方からストリーミングする場合は、メインカメラのCenter Stageを有効にして、顔や体をより良いフレーミングで撮影することをお勧めします。
         この機能は、携帯電話が横向きまたは縦向きに置かれているときにサポートされます。
        縦方向は、垂直方向の視野が広いため、最も汎用性が高いです。
         また、Desk ViewカメラAPIも用意されており、アプリケーションに適したカスタマイズされたインテグレーションを提供します。
         このAPIについては、後ほど説明します。
         Macでのビデオ会議では、セッションに集中してもらいたいのはもちろんですが、重要なことを見逃していないか確認することも重要です。
         Continuity Cameraの使用中は、携帯電話の通知はすべて消音され、重要な通話の通知はMac上で転送されます。
         さようなら、エリック! エリック:さようなら、カレン! カレン: 今、あなたのアプリケーションに一行の新しいコードも書かずに、ユーザーが利用できるあらゆる素晴らしい体験についてお話ししてきました。
         しかし、新しいAPIをいくつか採用することで、あなたのアプリでContinuity Cameraの体験をさらに魔法のように洗練されたものにすることができるのです。
         ほとんどのユーザーがMacで少なくとも2つのカメラデバイスを手に入れることになる今、私たちはカメラをどのように管理すべきかについて、より深く考えました。
         macOS 13以前では、デバイスが取り外されたり、より良いカメラがシステム上で利用できるようになると、通常、アプリケーションで手動による選択手順が必要になります。
         私たちは、アプリケーションで自動的にカメラを切り替えることで、お客様に不思議な体験を提供したいと考えています。
         AVFoundationフレームワークに2つの新しいAPIを追加し、アプリでこの機能を構築できるようにしました。AVCaptureDeviceのuserPreferredCameraとsystemPreferredCameraというクラスプロパティです。
         userPreferredCamera は read/write プロパティです。
         ユーザがアプリケーションでカメラを選択する際には、必ずこのプロパティを設定する必要があります。
         これにより、AVCaptureDevice クラスは、ユーザーの好みを学習し、アプリの起動や再起動にわたって各アプリケーションのカメラのリストを保存し、その情報を使用してカメラを提案することができます。
         また、どのカメラが接続されたか、切断されたかも考慮されます。
         このプロパティはKey-Value観測可能であり、ユーザーの好みに基づいて最適な選択をインテリジェントに返します。
         最も新しく選択されたデバイスが切断されると、リスト内の次に利用可能なカメラに自発的に変更されます。
         ユーザーの選択履歴がない場合や、優先デバイスが1台も接続されていない場合でも、このプロパティは常に使用可能なカメラデバイスを返そうとし、以前にストリーミングされたカメラを優先的に表示します。
         システム上に利用可能なカメラが存在しない場合のみ、nil を返す。
         systemPreferredCamera は、読み取り専用のプロパティです。
         このプロパティは、userPreferredCamera と他のいくつかの要素を組み込み、システム上に存在するカメラの最適な選択肢を提案します。
         例えば、連続性カメラが表示された場合、このプロパティは userPreferredCamera とは異なる値を返し、自動的に選択されるべきことを示します。
         また、このプロパティは、デバイスのサスペンドを内部的に追跡し、サスペンドされたデバイスよりもサスペンドされていないデバイスを優先的に使用します。
         これは、MacBookの蓋を閉めたときに内蔵カメラがサスペンドされた場合に、他のカメラに切り替える自動切り替え動作を構築するのに便利です。
         Continuity Cameraは、携帯電話を横向きに固定したスタンドに置き、画面を消した状態で、MacとUSB接続するか、Macの至近距離にある場合に、自動的に選択されるように信号を送ります。
         この場合、ユーザーの意図は、デバイスをContinuity Cameraとして使用することであることは明らかです。
        systemPreferredCamera APIを採用する場合は、常にこのプロパティをKey-Valueで監視し、それに応じてAVCaptureSessionのビデオ入力デバイスを更新して、マジックカメラ選択のエクスペリエンスを提供する必要があります。
         userPreferredCameraとsystemPreferredCameraは、すでにファーストパーティアプリケーションで採用されています。
         これらのAPIを採用するアプリケーションが増えれば、Appleのデバイスで普遍的で一貫性のあるカメラ選択方法をお客様に提供できるようになります。
         FaceTimeでContinuity Cameraを使った自動切り替えがどのように見えるか、デモをお見せしましょう。
        ここでは、FaceTimeで、自動カメラ選択モードにしています。
         手動と自動の両方の動作を提供したいアプリケーションには、自動モードの有効・無効のための新しいUIを追加することをお勧めします。
        FaceTimeは現在、内蔵カメラからのストリーミングです。
         机の上にある電話機を手に取り、MacBookの後ろのスタンドに置くと......。
        FaceTimeはシームレスにContinuity Cameraからのストリーミングに切り替わります。
         そこで、新しいクラスプロパティsystemPreferredCameraの登場です。このプロパティ値は、携帯電話がストリーミングできる位置にあるときにContinuity Cameraに変更されます。
         同じような方法でアプリケーションを構築したいと思うかもしれません。
         以下は、自動カメラ選択と手動選択モードを実装する方法についての私のレシピです。
         Automatic Camera Selectionがオンの場合、systemPreferredCameraプロパティのKey-Value観測を開始します。
         systemPreferredCameraが変更されるたびに、セッションの入力デバイスを更新することで追従します。
        オートモードでは、ユーザが自分でカメラを選べるような選択肢を用意しておくことを強く推奨します。
         別のカメラが選択された場合、userPreferredCameraをそのデバイスに設定し、systemPreferredCameraプロパティ値に反映させる。
         カメラ自動選択機能がOFFの場合は、systemPreferredCameraプロパティのKey-Value観測を停止します。
         systemPreferredCameraに従う代わりに、手動モードでユーザーが選んだカメラでセッションの入力デバイスを更新する必要があります。
         しかし、自動モードと同様に、ユーザーが別のカメラを選択するたびに userPreferredCamera プロパティを設定する必要があります。
         userPreferredCameraとsystemPreferredCamera APIの組み込み方のベストプラクティスは、新しいサンプルアプリ「Continuity Camera Sample」をご確認ください。
        " Macに魔法のようなウェブカメラ体験をもたらすだけでなく、Continuity CameraはあなたのMacアプリにiPhone特有のカメラ機能のパワーを活用する新しい機会を提供します。
         macOS 13では、アプリケーションがContinuity Cameraデバイスをよりよく利用できるように、いくつかのAVCapture APIを追加しました。
         Continuity Cameraのおかげで、iPhoneの写真キャプチャの素晴らしい品質をmacOSでも実現できます。
         まず、高解像度の写真のキャプチャをサポートします。
         これまでmacOSは、ビデオ解像度の写真キャプチャにしか対応していませんでした。
         macOS 13からは、Continuity Cameraで最大12メガピクセルの写真をキャプチャできるようになります。
         これは、まずキャプチャセッションを開始する前にAVCapturePhotoOutputオブジェクトでhighResolutionCaptureEnabledをtrueに設定し、その後キャプチャごとにphotoSettingsオブジェクトでhighResolutionPhotoEnabledプロパティをtrueに設定すれば有効化されます。
         高解像度写真のキャプチャに加え、Continuity Cameraは、写真品質と速度の優先順位の制御にも対応しています。まずphotoOutputオブジェクトに最大写真品質の優先順位を設定し、次にAVCapturePhotoSettingsオブジェクトのphotoQualityPrioritizationプロパティを設定して、キャプチャごとに優先順位を選択することが可能です。
         用途に応じた優先順位の選択については、WWDC2021の「ビデオ形式を用いた高画質な写真のキャプチャ」をご覧ください。
         もう一つの写真関連の機能は、フラッシュキャプチャです。
         photoSettingsオブジェクトにflashModeを設定することで、フラッシュをオンにするかオフにするか、あるいはシーンや照明条件に応じて自動的に選択するかを制御できるようになりました。
         また、AVCaptureMetadataOutputをmacOSで利用可能にし、キャプチャセッションで生成される時間指定メタデータを処理できるようにします。
         iPhoneから顔メタデータオブジェクトや人体メタデータオブジェクトをストリーミングできるようになりました。
         ここでは、顔メタデータオブジェクトを受信するためのセッションを設定する方法を説明します。
         ビデオの入出力を適切に設定した後、AVCaptureMetadataOutputを作成し、addOutputを呼び出してセッションに追加する必要があります。
         特に顔のメタデータを受信するには、出力にオブジェクトタイプの配列を設定し、顔のオブジェクトタイプを含めます。
         availableMetadataObjectTypesプロパティを確認し、要求されたメタデータのタイプがサポートされていることを確認します。
         その後、メタデータのコールバックを受け取るようにデリゲートを設定します。
         セッションの実行開始後、リアルタイムに生成される顔メタデータオブジェクトを含むコールバックを受け取ることができます。
         Continuity Cameraは、先ほど説明したAVCapturePhotoOutput、AVCaptureMetadataOutputの他に、ビデオデータ出力、ムービーファイル出力、AVCaptureVideoPreviewLayerに対応しています。
         以下は、Continuity Camera がサポートしているビデオフォーマットのリストです。
         640 x 480 から 1080p までの 16 x 9 フォーマットを 3 つ、4 x 3 フォーマットを 1 つサポートしています。1920×1440をサポートしています。
         必要に応じて、最大30フレーム/秒または60フレーム/秒をサポートするフォーマットを選択することができます。
         もう一つの大きな追加機能は、Desk ViewデバイスAPIです。
         Desk Viewカメラは、独立したAVCaptureDeviceとして公開されています。
         このデバイスを見つけるには、2つの方法があります。
         最初の方法は、デバイス発見セッションでAVCaptureDeviceType DeskViewCameraを検索することです。
         または、メインビデオカメラの AVCaptureDevice オブジェクトを既に知っている場合、そのデバイスの companionDeskViewCamera プロパティを使用して Desk View デバイスにアクセスすることができます。
         このAPIは、周囲に複数のContinuity Cameraデバイスがある場合に、メインカメラとDesk Viewデバイスをペアリングするのに便利です。
         目的のDesk ViewカメラのAVCaptureDeviceオブジェクトを取得すると、他のカメラデバイスと同様に、キャプチャセッションのAVCaptureビデオデータ出力、ムービーファイル出力、ビデオプレビューレイヤーでそれを使用することができます。
         Desk Viewデバイスは現在、420vピクセルフォーマットの1つのストリーミングフォーマットをサポートしています。
         このフォーマットの解像度は1920×1440で、サポートされる最大フレームレートは30fpsです。
         以上でセッションは終了です。

        Continuity Cameraについて、macOSで魔法のようなカメラセレクションを構築する方法、そしてContinuity CameraをあなたのMacアプリケーションに統合するための新しいAPIをいくつか学びましたね。
        これらのAPIをすべて採用することを楽しみにしています。WWDCの残りの期間も、素晴らしい時間をお過ごしください。

        """
    }
}

