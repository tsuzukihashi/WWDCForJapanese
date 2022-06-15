import Foundation

struct WhatsNewInNearbyInteraction: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "What's new in Nearby Interaction"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6497/6497_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10008/")!
    }

    var english: String {
        """
        Hi, I'm Jon Schoenberg, and I'm an engineer on the Location Technologies team at Apple.
        In this session, I'll cover the new features we've brought to Nearby Interaction, that are going to enable you to build richer and more diverse experiences with spatial awareness.
        The Nearby Interaction framework makes it simple to take advantage of the capabilities of U1 -- Apple's chip for Ultra Wideband technology -- and enables creating precise and spatially aware interactions between nearby Apple devices or accessories compatible with Apple's U1 chip for Ultra Wideband.
        Let's get started with a quick review of what's been available to you over the last two years.
        When Nearby Interaction was introduced at WWDC 2020, the functionality focused on creating and running a session between two iPhones with U1.
        At WWDC 2021, the functionality was extended to support running sessions with Apple Watch and third-party Ultra Wideband-compatible accessories.
        If you're interested in a deep dive into the Nearby Interaction framework's APIs, please review the WWDC talk "Meet Nearby Interaction" from 2020 and "Explore Nearby Interaction with third-party accessories" from 2021.
        We've been blown away by the community's response to Nearby Interaction, and in this session, I'm excited to unveil the new capabilities and improvements for you.
        I will focus on two main topics: enhancing Nearby Interaction with ARKit and background sessions.
        Along the way, I'll share some improvements that make it easier to use the Nearby Interaction framework and I'll conclude with an update on third-party hardware support that was announced last year.
        We're excited about what you will do with the new capabilities, so let's dive right into the details.
        I'll start with an exciting new capability that tightly integrates ARKit with Nearby Interaction.
        This new capability enhances Nearby Interaction by leveraging the device trajectory computed from ARKit.
        ARKit-enhanced Nearby Interaction leverages the same underlying technology that powers Precision Finding with AirTag, and we're making it available to you via Nearby Interaction.
        The best use cases are experiences that guide a user to a specific nearby object such as a misplaced item, object of interest, or object that the user wants to interact with.
        By integrating ARKit and Nearby Interaction, the distance and direction information is more consistently available than using Nearby Interaction alone, effectively broadening the Ultra Wideband field of view.
        Finally, this new capability is best used for interacting with stationary devices.
        Let's jump right into a demonstration of the possibilities this new integration of ARKit and Nearby Interaction enable with your application.
        I've got an application here for my Jetpack Museum that has Ultra Wideband accessories to help guide users to the exhibits.
        Let's go find the next jetpack.
        As the user selects to go to the next exhibit, the application discovers the Ultra Wideband accessory and performs the necessary exchanges to start using Nearby Interaction.
        The application then instructs the user to move the phone side to side while it begins to determine the physical location of the next exhibit, using the enhanced Nearby Interaction mode with ARKit.
        Now that the application understands the direction that corresponds to the next exhibit, a simple arrow icon telling the user the direction to head to check it out appears.
        This rich, spatially-aware information utilizing the combination of ARKit and Nearby Interaction can even indicate when the exhibit is behind the user and the user is heading in a direction away from the exhibit.
        Finally, the application can display, in the AR world, an overlay of the next exhibit's location, and the application prompts the user to move the iPhone up and down slightly to resolve where the exhibit is in the AR world.
        Once the AR content is placed in the scene, the powerful combination of Nearby Interaction -- with its Ultra Wideband measurements -- and ARKit, allows the user to easily head over to check out the next jetpack.
        I may not have found a jetpack, but I found a queen.
        Let's turn now to how you can enable this enhanced Nearby Interaction mode.
        With iOS 15, you probably have a method in your application that accepts the NIDiscoveryToken from a nearby peer, creates a session configuration, and runs the NISession.
        Enabling the enhanced mode with ARKit is easy on new and existing uses of Nearby Interaction with a new isCameraAssistanceEnabled property on the subclasses of NIConfiguration.
        Setting the isCameraAssistanceEnabled property is all that's required to leverage the enhanced mode with ARKit.
        Camera assistance is available when interacting between two Apple devices, and an Apple device to third-party Ultra Wideband accessories.
        Let's look at the details of what happens when an NISession is run with camera assistance enabled.
        When camera assistance is enabled, an ARSession is automatically created within the Nearby Interaction framework.
        You are not responsible for creating this ARSession.
        Running an NISession with camera assistance enabled will also run the ARSession that was automatically created within the Nearby Interaction framework.
        The ARSession is running within the application process.
        As a result, the application must provide a camera usage description key within the application's Info.plist.
        Be sure to make this a useful string to inform your users why the camera is necessary to provide a good experience.
        Only a single ARSession can be running for a given application.
        This means that if you already have an ARKit experience in your app, it is necessary to share the ARSession you create with the NISession.
        To share the ARSession with the NISession, a new setARSession method is available on the NISession class.
        When setARSession is called, prior to run, on the NISession, an ARSession will not be automatically created within the Nearby Interaction framework when the session is run.
        This ensures the application ARKit experience happens concurrently to the camera assistance in Nearby Interaction.
        In this SwiftUI example, as part of the makeUIView function, the underlying ARSession within the ARView is shared with the NISession via the new setARSession method.
        If you are using an ARSession directly, it is necessary to call run on the ARSession with an ARWorldTrackingConfiguration.
        In addition, several properties must be configured in a specific manner within this ARConfiguration to ensure high-quality performance from camera assistance.
        The worldAlignment should be set to gravity, collaboration and userFaceTracking disabled, a nil initialWorldMap, and a delegate whose sessionShouldAttempt Relocalization method returns false.
        Let's turn to some best practices when sharing an ARSession you created.
        In your NISessionDelegate didInvalidateWith error method, always inspect the error code.
        If the ARConfiguration used to run the shared ARSession does not conform to the outlined properties, the NISession will be invalidated.
        A new NIError code invalidARConfiguration will be returned.
        To receive nearby object updates in your app, continue to use the didUpdateNearbyObjects method in your NISessionDelegate.
        In your didUpdateNearbyObjects method, you probably check the nearby objects for your desired peer and update the UI based on distance and direction properties of the NINearbyObject when available, always being careful to recall these can be nil.
        When camera assistance is enabled, two new properties are available within the NINearbyObject.
        The first is horizontalAngle.
        This is the 1D angle in radians indicating the azimuthal direction to the nearby object.
        When unavailable, this value will be nil.
        Second, verticalDirectionEstimate is the positional relationship to the nearby object in the vertical dimension.
        This is a new VerticalDirectionEstimate type.
        Distance and direction represent the key spatial relationship between the user's device and a nearby object.
        Distance is measured in meters and direction is a 3D vector from your device to the nearby object.
        Horizontal angle is defined as the angle between the device running the NISession and the nearby object within a local horizontal plane.
        This accounts for any vertical displacement offset between the two devices and any horizontal rotation of the device itself.
        While direction is 3D, horizontal angle is a 1D representation of the heading between the two devices.
        This horizontal angle property is complimentary to the direction property, and if the direction cannot be resolved, the horizontal angle can be available to help you guide your user to a nearby object.
        Vertical direction estimate is a qualitative assessment of the vertical position information.
        You should use it to guide the user between floor levels.
        Let's look now at the new VerticalDirectionEstimate type.
        VerticalDirectionEstimate is a nested enum within the NINearbyObject and represents a qualitative assessment of the vertical relationship to the nearby object.
        Be sure to check if the VerticalDirectionEstimate is unknown before using the property.
        The vertical relationship can be same, above, below, or a special aboveOrBelow value that represents the nearby object is not on the same level, but not clearly above or below the device.
        The Ultra Wideband measurements are subject to field of view and obstructions.
        The field of view for direction information corresponds to a cone projecting from the rear of the device.
        The device trajectory computed from ARKit when camera assistance is enabled allows the distance, direction, horizontal angle, and vertical direction estimate to be available in more scenarios, effectively expanding the Ultra Wideband sensor field of view.
        Let's turn now to leveraging this integration of ARKit and Nearby Interaction to place AR objects in your scene.
        To make it easier for you to overlay 3D virtual content that represents the nearby object onto a camera feed visualization, we've added a helper method: worldTransform on NISession.
        This method returns a worldTransform in ARKit's coordinate space that represents the given nearby object's position in the physical environment when it's available.
        When not available, this method returns nil.
        We used this method in the demonstration to place the floating spheres above the next exhibit.
        We want to make it as easy as possible for you to leverage Nearby Interaction positional output to manipulate content in the AR world in your app.
        Two powerful systems in iOS, combined.
        Your users must sweep the device sufficiently in vertical and horizontal directions to allow the camera assistance to adequately compute the world transform.
        This method can return nil when the user motion is insufficient to allow the camera assistance to fully converge to an ARKit world transform.
        When this transform is important to your app experience, it is important to coach the user to take action to generate this transform.
        Let's look now at some additions we've made to the NISessionDelegate to make it possible for you to guide the user similar to what you saw in the demonstration.
        To aid in guiding the user towards your object, an NISessionDelegate callback provides information about the Nearby Interaction algorithm convergence via the new didUpdateAlgorithmConvergence delegate method.
        Algorithm convergence can help you understand why horizontal angle, vertical direction estimate, and worldTransform are unavailable and what actions the user can take to resolve those properties.
        The delegate provides a new NIAlgorithmConvergence object and an optional NINearbyObject.
        This delegate method is only called when you have enabled camera assistance in your NIConfiguration.
        Let's look at the new NIAlgorithmConvergence type.
        NIAlgorithmConvergence has a single-status property that is an NIAlgorithm ConvergenceStatus type.
        The NIAlgorithmConvergenceStatus type is an enum that represents whether the algorithm is converged or not.
        If the algorithm is not converged, an array of associated values NIAlgorithmConvergenceStatus .
        Reasons is provided.
        Let's return to the new delegate method and say you want to update the status of the camera assistance to the user, you can switch on the convergence status and if unknown or converged, display that information to the user.
        Be sure to inspect the NINearbyObject.
        When the object is nil, the NIAlgorithmConvergence state applies to the session itself, rather than a specific NINearbyObject.
        When the status is notConverged, it also includes an associated value that describes the reasons the algorithm is not converged.
        A localized description is available for this reason to help you communicate better with your users.
        Let's look next at how to use these values.
        Inspecting the notConverged case more closely and the associated reasons value, it is possible to guide the user to take actions that helps produce the desired information about a nearby object.
        The associated value is an array of NIAlgorithmConvergence StatusReasons.
        The reason can indicate there's insufficient total motion, insufficient motion in the horizontal or vertical sweep, and insufficient lighting.
        Be mindful that multiple reasons may exist at the same time and guide the user sequentially through each action based on which is most important for your application.
        Recall how I moved the phone in the demonstration and needed to sweep in both the horizontal and vertical direction to resolve the world transform.
        That's the most important bits about the enhanced Nearby Interaction mode with camera assistance.
        We've made some additional changes to help you better leverage this mode.
        Previously, a single isSupported class variable on the NISession was all that was necessary to check if Nearby Interaction was supported on a given device.
        This is now deprecated.
        With the addition of camera assistance, we've made the device capabilities supported by Nearby Interaction more descriptive with a new deviceCapabilities class member on the NISession that returns a new NIDeviceCapability object.
        At a minimum, checking the supportsPreciseDistance Measurement property is the equivalent of the now deprecated isSupported class variable.
        Once you've established that the device supports the precise distance measurement, you should use NIDeviceCapability to fully understand the capabilities available from Nearby Interaction on the device running your application.
        It is recommended you tailor your app experience to the capabilities of the device by checking the additional supportsDirectionMeasurement and supportsCameraAssistance properties of the NIDeviceCapability object.
        Not all devices will support direction measurements nor camera assistance, so be sure to include experiences that are tailored to the capabilities of this device.
        In particular, be mindful to include distance-only experiences in order to best support Apple Watch.
        That's all for camera assistance as a way to enhance Nearby Interaction with ARKit.
         So let's turn our attention now to accessory background sessions.
        Today, you can use Nearby Interaction in your app to allow users to point to other devices, find friends, and show controls or other UI based on distance and direction to an accessory.
        However, when your app transitions to the background or when the user locks the screen on iOS and watchOS, any running NISessions are suspended until the application returns to the foreground.
        This means you needed to focus on hands-on user experiences when interacting with your accessory.
        Starting in iOS 16, Nearby Interaction has gone hands-free.
        You're now able to use Nearby Interaction to start playing music when you walk into a room with a smart speaker, turn on your eBike when you get on it, or trigger other hands-free actions on an accessory.
        You can do this even when the user isn't actively using your app via accessory background sessions.
        Let's look at how you can accomplish this exciting new capability.
        Let's spend just a minute reviewing the sequence for how to configure and run an NISession with an accessory.
        You might recognize this sequence from last year's WWDC presentation.
        The accessory sends its Ultra Wideband accessory configuration data over to your application via a data channel, and you create an NINearbyAccessoryConfiguration from this data.
        You create an NISession, set an NISessionDelegate to get Ultra Wideband measurements from the accessory.
        You run the NISession with your configuration and the session will return sharable configuration data to setup the accessory to interoperate with your application.
        After sending this sharable configuration data back to the accessory, you are now able to receive Ultra Wideband measurements in your application and at the accessory.
        For all the details on configuring and running Nearby Interaction with third-party accessories, please review last year's WWDC session.
        Let's look now at how you set up the new background sessions.
        The previous sequence diagram showed data flowing between your application and the accessory.
        It is very common to have the communication channel between an accessory and your application use Bluetooth LE.
        When paired to the accessory using Bluetooth LE, you can enable Nearby Interaction to start and continue sessions in the background.
        Let's look closely at how this is possible.
        Today, you can configure your app to use Core Bluetooth to discover, connect to, and exchange data with Bluetooth LE accessories while your app is in the background.
        Check out the existing Core Bluetooth Programming Guide or the WWDC session from 2017 for more details.
        Taking advantage of the powerful background operations from Core Bluetooth to efficiently discover the accessory and run your application in the background, your application can start an NISession with a Bluetooth LE accessory that also supports Ultra Wideband in the background.
        Let's look now at how the sequence diagram updates to reflect this new mode.
        To interact with this accessory, first, ensure that it is Bluetooth LE-paired.
        Then, connect to the accessory.
        When the accessory generates its accessory Ultra Wideband configuration data, it should both send it to your application and populate the Nearby Interaction GATT service; more on this next.
        Finally, when your application receives the accessory's configuration data, construct an NINearbyAccessoryConfiguration object using a new initializer providing both your accessory's UWB configuration data and its Bluetooth peer identifier.
        Run your NISession with this configuration and ensure you complete the setup by receiving the sharable configuration in your NISessionDelegate and send the sharable configuration to the accessory.
        In order for your accessory to create a relationship between its Bluetooth identifier and the Ultra Wideband configuration, it must implement the new Nearby Interaction GATT service.
        The Nearby Interaction service contains a single encrypted characteristic called Accessory Configuration Data.
        It contains the same UWB configuration data used to initialize the NINearbyAccessoryConfiguration object.
        iOS uses this characteristic to verify the association between your Bluetooth peer identifier and your NISession.
        Your app cannot read from this characteristic directly.
        You can find out more about the details of this new Nearby Interaction GATT service on developer.apple.com/ nearby-interaction.
        If your accessory supports multiple NISessions in parallel, create multiple instances of Accessory Configuration Data, each with a different NISession's UWB configuration.
        That's what's necessary on the accessory.
        Let's turn to what you need to implement in your application by diving into some code! Accessory background sessions require that the accessory is LE-paired to the user's iPhone.
        Your app is responsible for triggering this process.
        To do this, implement methods to scan for your accessory, connect to it, and discover its services and characteristics.
        Then, implement a method to read one of your accessory's encrypted characteristics.
        You only need to do this once.
        It will show the user a prompt to accept pairing.
        Accessory background sessions also require a Bluetooth connection to your accessory.
        Your app must be able to form this connection even when it's backgrounded.
        To do this, implement a method to initiate a connection attempt to your accessory.
        You should do this even if the accessory is not within Bluetooth range.
        Then, implement CBManagerDelegate methods to restore state after your app is relaunched by Core Bluetooth and handle when your connection is established.
        Now you're ready to run an accessory background session.
        Create an NINearbyAccessoryConfiguration object by providing both the accessory's UWB configuration data and its Bluetooth peer identifier from the CBPeripheral identifier.
        Run an NISession with that configuration and it will run while your app is backgrounded.
        That's it! Well, there is one more setting you need to update for your app in Xcode.
        This background mode requires the Nearby Interaction string in the UIBackgroundModes array in your app's Info.plist.
        You can also use Xcode capabilities editor to add this background mode.
        You will also want to ensure you have "Uses Bluetooth LE accessories" enabled to ensure your app can connect with the accessory in the background.
        One important note about this new accessory background session.
        When your application is in the background, the NISession will continue to run and will not be suspended, so Ultra Wideband measurements are available on the accessory.
        You must consume and act on the Ultra Wideband measurements on the accessory.
        Your application will not receive runtime, and you will not receive didUpdateNearbyObject delegate callbacks until your application returns to the foreground.
        When using this new background mode, let's review the following best practices.
        Triggering LE pairing with your accessory will show the user a prompt to accept the pairing.
        Do this at a time that is intuitive to the user why they want to pair the accessory.
        This could be in the setup flow that it creates the relationship with the accessory or when the user clearly indicates their desire to interact with the accessory.
        While your app is backgrounded, your NISession will not be suspended, but it will not receive didUpdateNearbyObject delegate callbacks.
        However, your accessory will receive Ultra Wideband measurements.
        Process these measurements directly on your accessory to determine what action should happen for the user.
        Finally, manage battery usage by only sending data from your accessory to your app during a significant user interaction; for example, to show a notification to the user.
        That's all you need to know on background sessions and leads me to the last topic on third-party hardware support.
        Today, I'm happy to announce that the previously available beta U1-compatible development kits are now out of beta and available for wider use.
        Please visit developer.apple.com /nearby-interaction to find out more about compatible Ultra Wideband development kits.
        We've also updated the specification for accessory manufacturers to support the new accessory background sessions, including the Nearby Interaction GATT service, and it is available on the same website.
        So, let's summarize what we've discussed in this session.
        Nearby Interaction now includes a new camera-assisted mode that tightly integrates ARKit and Nearby Interaction to provide a seamless experience for you to create spatially aware experiences that guide users to a nearby object.
        The accessory background sessions enable you to initiate and extend sessions into the background for you to build a more hands-off experience for your users.
        We've announced exciting updates to the third-party compatible Ultra Wideband hardware support.
        That's it for the Nearby Interaction updates this year.
        Download the demos, reach out with feedback on the updated capabilities, review the updated third-party specification, and go build amazing apps with spatial experiences.
        Thank you.

        """
    }

    var japanese: String {
        """
        AppleのLocation TechnologiesチームでエンジニアをしているJon Schoenbergです。
        このセッションでは、Nearby Interactionに追加された、空間認識によるリッチで多様な体験を可能にする新機能について説明します。
        Nearby Interaction フレームワークは、Ultra Wideband 技術用の Apple のチップである U1 の機能を簡単に利用できるようにし、近くにある Apple デバイスや Ultra Wideband 用 Apple U1 チップに対応したアクセサリーの間で、正確で空間を意識したインタラクションを作成できるようにするものです。
        まず、過去2年間に利用可能だったものを簡単に振り返ってみましょう。
        WWDC 2020でNearby Interactionが紹介されたとき、その機能はU1を搭載した2台のiPhoneの間でセッションを作成し、実行することに重点を置いていました。
        WWDC 2021では、Apple WatchやサードパーティのUltra Wideband対応アクセサリとのセッションの実行をサポートするために機能が拡張されました。
        Nearby InteractionフレームワークのAPIを深く知りたい方は、2020年のWWDC講演「Meet Nearby Interaction」、2021年の「Explore Nearby Interaction with third-party accessories」をご覧ください。
        私たちは、Nearby Interactionに対するコミュニティの反応に圧倒され、このセッションでは、新しい機能と改善点を皆さんにお披露目することに興奮しています。
        ARKitによるNearby Interactionの強化とバックグラウンドセッションの2つのトピックに焦点を当てます。
        途中、Nearby Interactionフレームワークをより使いやすくするための改善点も紹介し、最後に昨年発表したサードパーティ製ハードウェアのサポートについての最新情報をお伝えします。
        新しい機能を使ってどんなことができるのか、私たちはとても楽しみにしていますので、早速その詳細を見ていきましょう。
        まず、ARKitとNearby Interactionを緊密に統合したエキサイティングな新機能から説明します。
        この新機能は、ARKitから計算されたデバイスの軌跡を活用することで、Nearby Interactionを強化します。
        ARKitで強化されたNearby Interactionは、AirTagのPrecision Findingと同じ基礎技術を活用しており、Nearby Interactionを通じて利用できるようになります。
        最適なユースケースは、置き忘れたアイテム、興味のあるオブジェクト、またはユーザが対話したいオブジェクトなど、特定の近くのオブジェクトにユーザを誘導するエクスペリエンスです。
        ARKitとNearby Interactionを統合することで、Nearby Interactionだけを使用するよりも距離と方向の情報を一貫して利用でき、Ultra Widebandの視野を効果的に広げることができます。
        最後に、この新しい機能は、静止しているデバイスとのインタラクションに最適に使用されます。
        さっそく、ARKitとNearby Interactionの新しい統合が可能にするアプリケーションの可能性について、デモをご覧ください。
        ここには、ウルトラワイドバンドアクセサリーでユーザーを展示物まで案内する、私のジェットパックミュージアムのアプリケーションがあります。
        次のジェットパックを見つけに行きましょう。
        ユーザーが次の展示物に行くことを選択すると、アプリケーションはUltra Widebandアクセサリーを検出し、Nearby Interactionの使用を開始するために必要な交換を実行します。
        次に、アプリケーションはユーザーに携帯電話を左右に動かすよう指示し、ARKitで強化されたNearby Interactionモードを使って、次の展示物の物理的な位置の特定を始めます。
        そして、次の展示物の方向を把握すると、その展示物を見に行く方向を示すシンプルな矢印のアイコンが表示されます。
        ARKitとNearby Interactionを組み合わせたリッチな空間認識情報により、展示物がユーザーの背後にあり、ユーザーが展示物から離れる方向に向かっている場合にも、その方向を示すことができます。
        最後に、アプリケーションは、ARの世界で、次の展示物の位置をオーバーレイ表示することができ、アプリケーションは、ユーザーがiPhoneをわずかに上下に動かして、ARの世界で展示物がどこにあるかを解決するように促します。
        ARコンテンツが配置されると、ウルトラワイドバンド測定のNearby InteractionとARKitの強力な組み合わせにより、ユーザーは簡単に次のジェットパックをチェックしに行くことができます。
        ジェットパックは見つからなかったかもしれませんが、女王は見つかりました。
        では次に、この強化されたNearby Interactionモードを有効にする方法について説明します。
        iOS 15 では、Nearby Peer から NIDiscoveryToken を受け取り、セッション構成を作成し、NISession を実行するメソッドがアプリケーションに用意されていると思われます。
        ARKitで拡張モードを有効にするには、NIConfigurationのサブクラスで新しいisCameraAssistanceEnabledプロパティを使用して、Nearby Interactionの新規および既存の使用で簡単に行うことができます。
        isCameraAssistanceEnabledプロパティを設定するだけで、ARKitの拡張モードを利用することができます。
        カメラアシストは、2つのAppleデバイス間、およびAppleデバイスとサードパーティ製のUltra Widebandアクセサリとの間でやり取りする際に利用できます。
        カメラアシストを有効にしてNISessionを実行するとどうなるのか、詳しく見ていきましょう。
        カメラアシストが有効な場合、Nearby Interactionフレームワーク内にARSessionが自動的に作成されます。
        この ARSession の作成は、お客様の責任ではありません。
        カメラアシストを有効にしてNISessionを実行すると、Nearby Interactionフレームワーク内に自動的に作成されたARSessionも実行されます。
        ARSessionは、アプリケーションのプロセス内で実行されます。
        そのため、アプリケーションは、アプリケーションのInfo.plist内にカメラの使用方法の説明キーを提供する必要があります。
        この文字列は、良い体験を提供するためにカメラが必要な理由をユーザーに知らせるために、必ず有用な文字列にしてください。
        1つのアプリケーションで実行できるARSessionは1つだけです。
        つまり、すでにアプリでARKitを体験している場合は、作成したARSessionをNISessionと共有する必要があります。
        ARSessionをNISessionと共有するために、NISessionクラスには新たにsetARSessionメソッドが用意されています。
        NISessionの実行前にsetARSessionを呼び出すと、セッション実行時にNearby Interactionフレームワーク内にARSessionが自動生成されなくなります。
        これは、アプリケーションの ARKit 体験が Nearby Interaction のカメラ補助と同時に起こることを保証します。
        この SwiftUI の例では、makeUIView 関数の一部として、ARView 内の基礎となる ARSession は、新しい setARSession メソッドを介して NISession と共有されます。
        ARSession を直接使用する場合、ARWorldTrackingConfiguration を使用して ARSession 上で run を呼び出す必要があります。
        さらに、カメラアシストによる高品質なパフォーマンスを確保するために、この ARConfiguration 内でいくつかのプロパティを特定の方法で設定する必要があります。
        worldAlignment は重力に設定し、コラボレーションと userFaceTracking は無効にし、initialWorldMap を nil にし、sessionShouldAttempt Relocalization メソッドが false を返すデリゲートを設定する必要があります。
        それでは、作成した ARSession を共有する際のベストプラクティスを紹介します。
        NISessionDelegate didInvalidateWith error メソッドでは、常にエラーコードを調べてください。
        共有された ARSession を実行するために使用される ARConfiguration が、概要のプロパティに準拠していない場合、NISession は無効化されます。
        新しいNIErrorコードinvalidARConfigurationが返されます。
        アプリで近くのオブジェクトの更新を受け取るには、NISessionDelegateのdidUpdateNearbyObjectsメソッドを引き続き使用します。
        didUpdateNearbyObjects メソッドでは、おそらく目的のピアに対して近くのオブジェクトをチェックし、利用可能な場合は NINearbyObject の距離と方向プロパティに基づいて UI を更新します。
        カメラアシストが有効な場合、2つの新しいプロパティがNINearbyObject内で利用可能になります。
        1つ目は、horizontalAngleです。
        これは、近くのオブジェクトへの方位角を示すラジアン単位の 1 次元角度です。
        利用できない場合、この値はnilになる。
        2つ目のverticalDirectionEstimateは、垂直方向における近傍オブジェクトとの位置関係を示すものである。
        これは新しいVerticalDirectionEstimateタイプです。
        距離と方向は、ユーザーのデバイスと近くのオブジェクトの間の重要な空間的関係を表します。
        距離はメートル単位で測定され、方向はユーザーのデバイスから近くのオブジェクトへの3Dベクトルです。
        水平角は、ローカルな水平面内でのNISessionを実行しているデバイスと近くのオブジェクトの間の角度と定義されます。
        これは、2つのデバイス間の垂直方向の変位オフセットと、デバイス自体の水平方向の回転を考慮したものです。
        方向が3Dであるのに対し、水平角は2つのデバイス間の方位を1Dで表現しています。
        この水平角プロパティは、方向プロパティを補完するもので、方向が解決できない場合、水平角を利用することで、ユーザーを近くのオブジェクトに誘導することができます。
        垂直方向推定は、垂直位置情報の定性的評価です。
        階数間の誘導に利用するとよいでしょう。
        ここで、新しいVerticalDirectionEstimateタイプを見てみましょう。
        VerticalDirectionEstimate は、NINearbyObject 内にネストされた enum で、近くのオブジェクトとの垂直関係の定性的な評価を表します。
        プロパティを使用する前に、必ず VerticalDirectionEstimate が不明であるかどうかを確認してください。
        垂直関係は、same、above、below、または特別なaboveOrBelow値で、近くのオブジェクトが同じレベルではないが、デバイスの上や下に明確にないことを表すことができる。
        ウルトラワイドバンドの測定は、視野と障害物の影響を受ける。
        方向情報の視野は、デバイスの背面から投影される円錐に対応します。
        カメラアシストが有効な場合にARKitから計算されるデバイスの軌跡は、距離、方向、水平角、および垂直方向の推定をより多くのシナリオで利用できるようにし、Ultra Widebandセンサーの視野を効果的に拡大します。
        それでは、このARKitとNearby Interactionの統合を活用して、シーンにARオブジェクトを配置する方法を説明します。
        カメラフィードのビジュアライゼーションに、近くのオブジェクトを表す3Dバーチャルコンテンツを簡単にオーバーレイできるように、NISessionにworldTransformというヘルパーメソッドを追加しました。
        このメソッドは、ARKit の座標空間における worldTransform を返すもので、物理環境における与えられた近くのオブジェクトの位置を表します。
        利用できない場合、このメソッドはnilを返します。
        デモでは、このメソッドを使用して、次の展示物の上に浮遊球体を配置しました。
        Nearby Interactionの位置情報出力を活用して、あなたのアプリでAR世界のコンテンツを操作することが、できるだけ簡単にできるようにしたいと考えています。
        iOSの2つの強力なシステムの組み合わせ。
        カメラアシストが世界の変換を適切に計算できるように、ユーザーはデバイスを垂直方向と水平方向に十分に掃引する必要があります。
        このメソッドは、カメラアシストが ARKit ワールド変換に完全に収束するためにユーザーの動きが不十分な場合に、nil を返すことができます。
        この変換がアプリのエクスペリエンスにとって重要である場合、この変換を生成するためにユーザーが行動を起こすように指導することが重要です。
        ここで、デモで見たようなユーザーを誘導することを可能にするために、NISessionDelegateに行ったいくつかの追加について見てみましょう。
        NISessionDelegateコールバックは、Nearby Interactionのアルゴリズム収束に関する情報を新しいdidUpdateAlgorithmConvergenceデリゲートメソッドで提供し、ユーザをあなたのオブジェクトへ誘導する手助けをします。
        アルゴリズムの収束は、水平角、垂直方向の推定値、および worldTransform が利用できない理由と、それらのプロパティを解決するためにユーザがどのようなアクションを取ることができるかを理解するのに役立ちます。
        デリゲートは新しい NIAlgorithmConvergence オブジェクトとオプションで NINearbyObject を提供します。
        このデリゲートメソッドは、NIConfiguration でカメラアシストを有効にしている場合にのみ呼び出されます。
        新しい NIAlgorithmConvergence の型を見てみましょう。
        NIAlgorithmConvergence は、NIAlgorithm ConvergenceStatus 型の単一状態プロパティを持っています。
        NIAlgorithmConvergenceStatus 型は、アルゴリズムが収束しているかどうかを表す列挙型です。
        アルゴリズムが収束していない場合、関連する値 NIAlgorithmConvergenceStatus の配列が提供されます。
        Reasons が提供されます。
        新しいデリゲートメソッドに戻り、ユーザーに対してカメラアシストの状態を更新したいとします。収束ステータスのスイッチを入れ、不明または収束した場合、その情報をユーザーに表示することができます。
        必ずNINearbyObjectを検査してください。
        オブジェクトが nil の場合、NIAlgorithmConvergence 状態は、特定の NINearbyObject ではなく、セッション自体に適用されます。
        状態が notConverged である場合、アルゴリズムが収束しない理由を記述した関連する値も含まれる。
        この理由については、ローカライズされた説明が用意されており、ユーザーとのコミュニケーションを円滑にすることができます。
        次にこれらの値をどのように使うか見てみよう。
        notConvergedケースと関連する理由値をより詳細に調べると、近くのオブジェクトについて必要な情報を生成するのに役立つアクションを取るようにユーザーを導くことができます。
        関連する値は、NIAlgorithmConvergence StatusReasons の配列です。
        理由は、全体の動きが不十分であること、水平または垂直方向の掃引の動きが不十分であること、および照明が不十分であることを示すことができる。
        複数の理由が同時に存在する可能性があることに留意し、アプリケーションにとって最も重要なものに基づいて、ユーザーを各アクションに順次誘導してください。
        デモで私が携帯電話を動かしたとき、ワールドトランスポートを解決するために水平方向と垂直方向の両方を掃引する必要があったことを思い出してください。
        これが、カメラアシストによって強化されたNearby Interactionモードの最も重要な部分です。
        このモードをよりよく活用できるように、さらにいくつかの変更を加えました。
        以前は、NISessionのisSupportedクラス変数1つだけで、Nearby Interactionが特定のデバイスでサポートされているかどうかをチェックする必要がありました。
        これは現在では非推奨です。
        カメラアシストの追加に伴い、Nearby Interactionがサポートするデバイスの機能をより分かりやすくするため、NISessionに新しいdeviceCapabilitiesクラスメンバーを設け、新しいNIDeviceCapabilityオブジェクトを返せるようにしました。
        最低限、supportsPreciseDistance Measurementプロパティをチェックすることは、現在では非推奨のisSupportedクラス変数と同等です。
        デバイスが正確な距離測定をサポートしていることを確認したら、NIDeviceCapability を使用して、アプリケーションを実行しているデバイスの Nearby Interaction から利用できる機能を完全に理解する必要があります。
        NIDeviceCapability オブジェクトの supportsDirectionMeasurement および supportsCameraAssistance プロパティを確認し、デバイスの能力に合わせたアプリ体験を提供することをお勧めします。
        すべてのデバイスが方向測定やカメラ補助をサポートするわけではないので、このデバイスの能力に合わせたエクスペリエンスを含めるようにしてください。
        特に、Apple Watchをサポートするために、距離のみのエクスペリエンスを含めるように意識してください。
        ARKitでNearby Interactionを強化するためのカメラアシストについては以上です。
         では次に、アクセサリのバックグラウンドセッションに目を向けてみましょう。
        現在、アプリでNearby Interactionを使用すると、ユーザーがアクセサリーまでの距離や方向に応じて、他のデバイスを指したり、友達を探したり、操作やその他のUIを表示したりすることができます。
        しかし、アプリがバックグラウンドに遷移したとき、またはiOSとwatchOSでユーザーが画面をロックしたとき、アプリケーションがフォアグラウンドに戻るまで、実行中のNISessionsは中断されます。
        つまり、アクセサリーとインタラクションする際には、ハンズオンのユーザーエクスペリエンスにフォーカスする必要がありました。
        iOS 16から、Nearby Interactionはハンズフリー化されました。
        スマートスピーカーで部屋に入ると音楽再生を開始したり、eBikeに乗ると電源を入れたり、アクセサリーの他のハンズフリーアクションをトリガーするためにNearby Interactionを使用することができるようになりました。
        これは、ユーザーがアクティブにアプリを使用していないときでも、アクセサリーのバックグラウンドセッションを介して行うことができます。
        このエキサイティングな新機能を実現する方法について見ていきましょう。
        アクセサリで NISession を構成して実行する方法を少し復習してみましょう。
        この手順は、昨年のWWDCのプレゼンテーションで見たことがあるかもしれません。
        アクセサリはUltra Widebandアクセサリの設定データをデータチャネル経由でアプリケーションに送信し、このデータからNINearbyAccessoryConfigurationを作成します。
        NISessionを作成し、NISessionDelegateを設定して、アクセサリからウルトラワイドバンドの測定値を取得します。
        NISessionを設定した状態で実行すると、セッションから共有可能な設定データが返され、アプリケーションと相互運用できるようにアクセサリを設定できます。
        この共有可能な設定データをアクセサリに送り返すと、アプリケーションとアクセサリでウルトラワイドバンド測定値を受信できるようになります。
        サードパーティ製アクセサリとのNearby Interactionの設定と実行に関する詳細は、昨年のWWDCセッションをご覧ください。
        それでは、新しいバックグラウンドセッションをどのように設定するか見てみましょう。
        先ほどのシーケンス図では、アプリケーションとアクセサリーの間でデータが流れていました。
        アクセサリーとアプリケーションの間の通信経路は、Bluetooth LEを使用するのが一般的です。
        Bluetooth LEを使用してアクセサリとペアリングすると、Nearby Interactionを有効にしてバックグラウンドでセッションを開始したり継続したりすることができます。
        どのようにしてこれが可能になるのか、詳しく見ていきましょう。
        現在、Core Bluetooth を使用して、アプリがバックグラウンドで Bluetooth LE アクセサリを検出、接続、およびデータ交換するように設定することができます。
        詳しくは、既存の「Core Bluetoothプログラミングガイド」または2017年のWWDCセッションをご確認ください。
        Core Bluetoothによる強力なバックグラウンド操作を利用して、効率的にアクセサリを検出し、バックグラウンドでアプリケーションを実行することで、アプリケーションはバックグラウンドでUltra Widebandにも対応するBluetooth LEアクセサリとNISessionを開始することができます。
        それでは、この新しいモードを反映するためにシーケンス図がどのように更新されるかを見てみましょう。
        このアクセサリーと対話するには、まず、Bluetooth LEがペアリングされていることを確認します。
        そして、アクセサリーに接続します。
        アクセサリーが Ultra Wideband 設定データを生成すると、アプリケーションに送信し、Nearby Interaction GATT サービスにデータを入力します。
        最後に、アプリケーションがアクセサリの設定データを受信したら、アクセサリのUWB設定データとBluetoothピア識別子の両方を提供する新しいイニシャライザを使用して、NINearbyAccessoryConfigurationオブジェクトを構築します。
        この構成でNISessionを実行し、NISessionDelegateで共有可能な構成を受信してセットアップを完了し、共有可能な構成をアクセサリーに送信することを確認します。
        アクセサリーがBluetooth識別子とUltra Wideband設定間の関係を作成するためには、新しいNearby Interaction GATTサービスを実装する必要があります。
        Nearby Interactionサービスは、Accessory Configuration Dataと呼ばれる単一の暗号化された特性を含んでいます。
        これには、NINearbyAccessoryConfiguration オブジェクトの初期化に使用されたものと同じ UWB コンフィギュレーションデータが含まれています。
        iOS は、この特性を使用して、Bluetooth ピア識別子と NISession の間の関連付けを確認します。
        アプリがこの特性から直接読み取ることはできません。
        この新しいNearby Interaction GATTサービスの詳細については、developer.apple.com/ nearby-interactionで確認することができます。
        アクセサリーが複数のNISessionを並行してサポートする場合、NISessionのUWB設定が異なる複数のAccessory Configuration Dataのインスタンスを作成します。
        以上が、アクセサリ側で必要なことです。
        では、実際にアプリケーションに実装するために必要なコードを紹介します。アクセサリーのバックグラウンドセッションは、アクセサリーがユーザーのiPhoneとLEペアリングされていることが必要です。
        あなたのアプリケーションは、このプロセスをトリガーする責任があります。
        これを行うには、アクセサリをスキャンし、接続し、そのサービスと特性を検出するメソッドを実装します。
        次に、アクセサリの暗号化された特性の1つを読み取るメソッドを実装します。
        これを一度だけ行う必要があります。
        ユーザーにペアリングを受け入れるよう促すプロンプトを表示します。
        アクセサリーのバックグラウンドセッションには、あなたのアクセサリーとのBluetooth接続も必要です。
        アプリは、バックグラウンドでもこの接続を形成できる必要があります。
        これを行うには、アクセサリへの接続を開始するメソッドを実装します。
        アクセサリがBluetoothの範囲内にない場合でも、これを実行する必要があります。
        そして、Core Bluetoothによってアプリが再起動された後に状態を復元するCBManagerDelegateメソッドを実装し、接続が確立されたときに処理します。
        これで、アクセサリのバックグラウンドセッションを実行する準備が整いました。
        アクセサリの UWB 設定データと CBPeripheral 識別子からの Bluetooth ピア識別子の両方を提供して、NINearbyAccessoryConfiguration オブジェクトを作成します。
        その構成でNISessionを実行すると、アプリがバックグラウンドで実行されます。
        以上です。さて、もう一つXcodeでアプリのために更新する必要がある設定があります。
        このバックグラウンドモードは、アプリのInfo.plistのUIBackgroundModes配列にあるNearby Interaction文字列が必要です。
        また、Xcodeの機能エディタを使用して、この背景モードを追加することができます。
        また、アプリがバックグラウンドでアクセサリと接続できるように、「Uses Bluetooth LE accessories」が有効になっていることを確認する必要があります。
        この新しいアクセサリバックグラウンドセッションに関する重要な注意事項が1つあります。
        アプリケーションがバックグラウンドにあるとき、NISessionは実行され続け、中断されないので、Ultra Wideband測定はアクセサリで利用可能です。
        アクセサリ上でUltra Wideband測定値を消費し、動作させる必要があります。
        アプリケーションはランタイムを受け取らず、アプリケーションがフォアグラウンドに戻るまでdidUpdateNearbyObjectデリゲートコールバックを受け取ることはありません。
        この新しいバックグラウンド・モードを使用する場合、以下のベスト・プラクティスを確認しましょう。
        アクセサリとの LE ペアリングをトリガーすると、ペアリングを受け入れるかどうかのプロンプトがユーザーに表示されます。
        これは、ユーザーがアクセサリーをペアリングする理由を直感的に理解できるタイミングで行ってください。
        これは、アクセサリとの関係を作成するセットアップフロー中、または、ユーザがアクセサリと対話することを明確に示したときに行うことができます。
        アプリがバックグラウンド化されている間、NISessionは中断されませんが、didUpdateNearbyObjectデリゲートコールバックを受信しません。
        しかし、アクセサリはUltra Wideband測定値を受信します。
        これらの測定値をアクセサリで直接処理し、ユーザーに対してどのようなアクションを起こすべきかを決定します。
        最後に、ユーザーへの通知を表示するなど、重要なユーザーインタラクションの間のみ、アクセサリからアプリにデータを送信することで、バッテリーの使用量を管理します。
        バックグラウンド・セッションについて知っておくべきことは以上ですが、最後のトピックとして、サードパーティのハードウェア・サポートについてお話します。
        本日、これまでベータ版として提供していたU1対応開発キットが、ベータ版から脱却し、より広く利用できるようになったことをお知らせします。
        デベロッパーをご覧ください。 apple. com /nearby-interaction で、互換性のある Ultra Wideband 開発キットの詳細をご覧ください。
        また、Nearby Interaction GATTサービスを含む新しいアクセサリーバックグラウンドセッションに対応するため、アクセサリーメーカー向けの仕様も更新し、同ウェブサイトで公開しています。
        それでは、このセッションでお話したことをまとめてみましょう。
        Nearby Interaction には、ARKit と Nearby Interaction を緊密に統合し、ユーザーを近くのオブジェクトに誘導する空間認識体験をシームレスに作成できる、新しいカメラアシストモードが追加されました。
        アクセサリのバックグラウンドセッションを使用すると、セッションをバックグラウンドに開始および拡張できるため、ユーザーに対してよりハンズオフな体験を構築することができます。
        サードパーティと互換性のあるUltra Widebandハードウェアのサポートに関するエキサイティングなアップデートを発表しました。
        今年のNearby Interactionのアップデートは以上です。
        デモをダウンロードし、更新された機能についてのフィードバックを提供し、更新されたサードパーティーの仕様を確認し、空間体験のある素晴らしいアプリを構築してください。
        ありがとうございました。

        """
    }
}

