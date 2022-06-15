import Foundation

struct CreateParametric3DRoomScansWithRoomPlanArticle: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Create parametric 3D room scans with RoomPlan"
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10127/")!
    }

    var english: String {
        """
        Praveen Sharma: Hi.
         My name is Praveen, and I'm from the Prototyping team here at Apple.
        Kai Kang: Hi.
         My name is Kai and I'm from the Video Engineering team.
        Praveen: Over the past few years Apple has enabled powerful new ways for people to bring the world into their apps.
        Last year, we introduced Object Capture, which takes in photos of real-world objects, and using the Photogrammetry API in RealityKit, turns them into a 3D model ready for use in your app.
        Previous to Object Capture, we released the Scene Reconstruction API which gives you a coarse understanding of the geometric structure of your space and enables brand-new augmented reality use cases in your apps.
        This year, we are very excited to announce a brand-new framework called RoomPlan.
        RoomPlan allows you to scan your room using your LiDAR-enabled iPhone or iPad.
        It generates a parametric 3D model of the room and its room-defining objects which you can use in your app.
        Let's take a look at what a RoomPlan scanning experience looks like.
        RoomPlan uses sophisticated machine learning algorithms powered by ARKit to detect walls, windows, openings, and doors, as well as room-defining objects like fireplaces, couches, tables, and cabinets.
        With our RoomCaptureView API, which uses RealityKit to render scanning progress in real time, you can easily integrate a scanning experience into your app.
        And when you are finished scanning, RoomCaptureView presents the final post-processed results for you to use however best fits your use case.
        For the first time, without the complexities of implementing machine learning and computer vision algorithms, people can now interact with their room in brand new ways.
        For example, interior design apps can preview wall color changes and accurately calculate the amount of paint required to repaint a room.
        Architecture apps can now easily allow someone to preview and edit changes to their room's layout in real time.
        Real estate apps can now seamlessly enable agents to capture floor plans and 3D models of a listing.
        And e-commerce apps can engage customers through product visualization in their physical spaces.
        These are just a few examples of applications RoomPlan enables, and you'll be surprised to see how simple it is to integrate RoomPlan into your app.
        Let's take a look.
        There are two main ways you can use RoomPlan.
        The first is our out-of-the-box scanning experience which allows you to seamlessly integrate RoomPlan into your app.
        The second is our data API which enables your app to use the live parametric data from a scan however best suits your use case.
        With both of these APIs, we recommend some best practices to help you achieve the best possible scan results, which we'll go over in the last section of this presentation.
        First, let's talk about the scanning experience that you can bring into your app using our new RoomCaptureView API.
        RoomCaptureView is a UIView subclass that you can easily place in your app.
        It handles the presentation of world space scanning feedback, real-time room model generation, as well as coaching and user guidance.
        Let's take a closer look at the design elements presented during a RoomCaptureView-based scan.
        During an active RoomCaptureView session, animated lines outline detected walls, windows, openings, doors, and room-defining objects in real time.
        The interactive 3D model generated in real time at the bottom of the RoomCaptureView, gives you an overview of your scanning progress at a glance.
        Finally, text coaching guides you to the best possible scanning results.
        Let's take a look at how you can start using RoomCaptureView in just four easy steps.
        First, we create a RoomCaptureView reference in our ViewController.
        Second, we create a reference to our RoomCaptureSession configuration object.
        Third, we start our scan session, passing in our configuration to the capture session's run function.
        And finally, our application tells the capture session to stop scanning.
        Optionally, your app can adhere to our RoomCaptureViewDelegate protocol and opt out of post-processed results and their presentation or handle the post-processed scan results once they have been presented.
        For example, you can export a USDZ of the results by calling the export function available on the provided CapturedRoom data struct.
        And that's how simple it is to integrate RoomPlan into your app.
        We are so excited to see what you make with this API.
        Now my colleague Kai will talk about RoomCaptureSession and RoomPlan's Data API.
        Kai: Thanks, Praveen.
        In this section, we will walk you through the Data APIs that provide you the access to the underlying data structures during scanning and can help you build a custom visualization of the scanning experience from ground up.
        The basic workflow consists of three parts: scan, process, and export.
        For scanning, we will cover the basics of how to set up and start the capture session, as well as display and monitor the capture process.
        Then we'll look at how your scanned data is processed and the final model is received for presentation.
        Finally, we'll discuss how you can generate and export the output USD file which can also be used in your USD workflows.
        Now, let's look into the Scan step in detail.
        We will use the RoomCaptureSession API to set up the session and display the progress as we continue scanning.
        Let me show you in code.
        Here's a simple RealityKit app as an example.
        To start, simply import RoomPlan into your Swift project.
        In the ViewController of your app, you can have a custom type to visualize the results and to initiate a RoomCaptureSession instance.
        Additionally, RoomCaptureSession provides a handle to the underlying AR session so that your apps can draw planes and object bounding boxes in the AR view.
        RoomCaptureSession adopts the delegate pattern.
        In your ViewController class, you can assign the ViewController itself as the captureSession's delegate.
        This would allow the ViewController to get real-time updates from the RoomCaptureSession.
        Theses updates include 3D models and instructions in order to guide people during the capture.
        To get these updates, your ViewController needs to conform to the RoomCaptureSessionDelegate protocol and implement two methods.
        The first one is captureSession(_ session: didUpdate room:) method in order to get the real-time CapturedRoom data structure.
        Your visualizer can use it to update AR view of the 3D model, which provides real-time feedback to people on the progress.
        We will dive into the CapturedRoom structure more in a later part of the talk.
        This method will be called when we detect updates to the captured room.
        The second method is captureSession(_ session: didProvide instruction:).
        This method provides you with an instruction structure which contains real-time feedback.
        Your visualizer can use the instruction to guide people during the scan.
        Let's go through the instructions that this API provides.
        These instructions include distance to the objects, scanning speed, lighting adjustment to the room, as well as focusing on specific areas of the room that have more textures.
        These instructions will be provided during the scan in order to guide people with real-time feedback.
        Next, we will move on to the process part.
        In this section, we will use the RoomBuilder class to process the scanned data and generate the final 3D models.
        To process the captured data, the first step is to initiate a RoomBuilder instance in your ViewController class.
        Next, in order to receive the sensor data after the capture process, your app needs to implement the captureSession(_ session: didEndWith data: error:) method.
        When the RoomCaptureSession is stopped, by calling the stop() function in your app, or due to an error, this function will be called to return a CaptureRoomData object and an optional error.
        Finally, to process the captured data, we call the roomBuilder's async roomModel(from:) method with the await keyword.
        The method runs asynchronously to process the scanned data and build the final 3D model.
        It utilizes the Swift async/await function that we introduced in last year's WWDC.
        Within just a few seconds, the model will be available for the final presentation in your app.
        Now, let's dive into the details of the CapturedRoom data structure and how you can export it to use in your app.
        At the top level, there is CapturedRoom which consists of Surfaces and Objects.
        Surface contains unique attributes to represent curves such as radius; starting and ending angles; four different edges of the surface; and architecture categories of wall, opening, window, door.
        Object contains furniture categories such as table, bed, sofa, etc.
        Surface and Object share some common attributes such as dimensions; confidence, which gives you three levels of confidence for the scanned surface or object; the 3D transform matrix; as well as a unique identifier.
        Let's see how they are represented in code.
        The CapturedRoom structure is a fully parametric representation of the elements in the room.
        It contains five properties including walls, openings, doors, windows, and objects in the room.
        For the first four elements, they are represented as the Surface structure which represents 2D planar architectural structures.
        On the right, you can see the various properties of Surface we covered earlier.
        The last property is an array of 3D objects in the room, and they are represented as cuboids.
        On the right, you can see the various properties of Object.
        Here is the list of object types we support in RoomPlan.
        These include a variety of common furniture types such as sofa, table, chair, bed, and many more.
        Finally, the export function allows you to export this CapturedRoom into a USD or USDZ data for your existing workflows.
        Here is an example to show how you can directly open the USD output in Cinema 4D to browse and edit the hierarchical data structure of the room, as well as the dimensions and location of each room element or object.
        You can also leverage your existing USD and USDZ workflows to add renders of the captured room into a variety of applications such as real estate, e-commerce, utilities, and interior design.
        So far, we covered the scanning experience and underlying RoomPlan APIs.
        We'll now go through some best practices to help you get good results with RoomPlan.
        We will cover the recommended conditions that allow for a good scan, room features to look out for while selecting a room, as well as a few scanning and thermal considerations to keep in mind.
        RoomPlan API supports most common architectural structures and objects in a typical household.
        It works best for a single residential room with a maximum room size of 30 feet by 30 feet or around 9 by 9 meters.
        Lighting is also important for the API to get a clear video stream and good AR tracking performance.
        A minimum 50 lux or higher is recommended for using the API, which is typical for a family living room at night.
        For the hardware, RoomPlan API is supported on all LiDAR-enabled iPhone and iPad Pro models.
        There are some special conditions that can present a challenge for the API.
        For example, full-height mirrors and glass pose a challenge for the LiDAR sensor to produce the expected output.
        Even high ceilings could exceed the limit of the scanning range of the LiDAR sensor.
        Also, very dark surfaces could be hard for the device to scan.
        There are some considerations to get better scanning results.
        First, for applications that have high accuracy requirements, preparing the room before scanning can enhance the quality of the scan.
        For example, opening the curtains can let more natural light in and reduce window occlusions, which works best for daytime scans.
        Closing the doors can reduce the chance of scanning unnecessary area outside of the room.
        Following a good scanning motion is also very important to achieving good scanning results with the API.
        And that is why we provide the user instruction delegate method in order to provide feedback on textures, distance, speed, and lighting conditions to people during the scans.
        Another thing to keep in mind is battery and thermals of the device.
        We have done many optimizations on RoomPlan API to ensure a good scanning experience.
        Nevertheless, it's best to avoid repeated scans or single long scans over 5 minutes.
        These could not only cause fatigue but also drain out the battery and create thermal issues which might in turn impact the user experience of your app.
        There is a lot that we covered today.
        We introduced a brand-new API, RoomPlan.
        It provides an intuitive scanning experience to capture your rooms, powerful machine learning models to understand the environment, as well as a fully parametric USD output format for easy integration in your apps.
        For guidance on how to better design and implement your new RoomPlan experience, please check out the related talks below.
        Praveen: It's time for you to try RoomPlan in your app.
        We can't wait to see what you can create with this new API.
        Kai: Thanks for watching! ♪
        """
    }

    var japanese: String {
        """
        Praveen Sharma：こんにちは。
         私はプラヴィーンです。Appleのプロトタイピングチームから来ました。
        Kai Kang：こんにちは。
         私はカイと申します。ビデオエンジニアリングのチームから来ました。
        プラヴィーンです。過去数年間、Appleは、人々が世界をアプリに取り込むためのパワフルな新しい方法を実現してきました。
        これは、現実世界の物体の写真を取り込み、RealityKitのPhotogrammetry APIを使用して、アプリで使用できる3Dモデルに変換するもので、昨年、私たちはObject Captureを発表しました。
        オブジェクト・キャプチャーに先立ち、空間の幾何学的構造を粗く理解し、アプリでまったく新しい拡張現実の使用例を可能にする Scene Reconstruction API をリリースしました。
        今年は、RoomPlan という全く新しいフレームワークを発表できることを大変嬉しく思っています。
        RoomPlanは、LiDARを搭載したiPhoneやiPadを使って、部屋をスキャンすることができます。
        このフレームワークは、部屋のパラメトリックな3Dモデルとその部屋を定義するオブジェクトを生成し、あなたのアプリケーションで使用することができます。
        RoomPlanのスキャン体験がどのようなものかを見てみましょう。
        RoomPlan は、ARKit を利用した高度な機械学習アルゴリズムを使用して、壁、窓、開口部、ドア、および暖炉、ソファ、テーブル、キャビネットなどの部屋を定義するオブジェクトを検出します。
        RealityKit を使用してスキャンの進捗状況をリアルタイムでレンダリングする RoomCaptureView API を使用すると、スキャン体験を簡単にアプリに組み込むことができます。
        スキャンが終了すると、RoomCaptureViewは、最終的な後処理結果を表示し、あなたの用途に最適な方法で使用することができます。
        機械学習やコンピュータビジョンアルゴリズムの複雑な実装をすることなく、初めて人々は全く新しい方法で部屋と対話することができるようになりました。
        例えば、インテリア・デザインのアプリケーションでは、壁の色の変更をプレビューしたり、部屋の塗り替えに必要な塗料の量を正確に計算したりできます。
        建築のアプリケーションでは、部屋のレイアウトをリアルタイムでプレビューして編集できるようになりました。
        不動産アプリケーションでは、エージェントが物件の間取り図や3Dモデルをシームレスに取り込むことができるようになりました。
        また、eコマース・アプリケーションでは、物理的な空間における製品のビジュアライゼーションを通じて、顧客の関心を引くことができます。
        これらは、RoomPlan が可能にするアプリケーションのほんの一例です。そして、RoomPlan をあなたのアプリに統合することがいかに簡単であるか、きっと驚かれることでしょう。
        それでは、見てみましょう。
        RoomPlan を使用する主な方法は 2 つあります。
        1 つ目は、すぐに使えるスキャン機能で、RoomPlan をお客様のアプリにシームレスに統合できます。
        2 つ目は、データ API で、お客様のアプリでスキャンからのライブ パラメトリック データを使用できるようにするもので、お客様の用途に最も適した方法で使用できます。
        これらのAPIでは、可能な限り最高のスキャン結果を得るために、いくつかのベストプラクティスを推奨しています。
        まず、新しい RoomCaptureView API を使って、あなたのアプリにもたらすことができるスキャン体験について説明します。
        RoomCaptureView は UIView のサブクラスで、アプリに簡単に配置することができます。
        このクラスは、世界空間スキャンのフィードバック、リアルタイムのルームモデル生成、およびコーチングとユーザーガイダンスの表示を処理します。
        RoomCaptureViewベースのスキャン中に表示されるデザイン要素について詳しく見ていきましょう。
        RoomCaptureViewのセッション中は、検出された壁、窓、開口部、ドア、および部屋を定義するオブジェクトの輪郭を、アニメーション化されたラインでリアルタイムに表示します。
        また、RoomCaptureView の下部にリアルタイムで生成されるインタラクティブな 3D モデルにより、スキャンの進捗状況を一目で把握することができます。
        最後に、テキストコーチングにより、最適なスキャン結果を得ることができます。
        それでは、たった4つのステップでRoomCaptureViewを使い始めることができるのか見ていきましょう。
        まず、RoomCaptureView の参照を ViewController 内に作成します。
        次に、RoomCaptureSession 設定オブジェクトへの参照を作成します。
        そして、スキャンセッションを開始し、キャプチャセッションの run 関数に設定を渡します。
        そして最後に、アプリケーションはキャプチャセッションにスキャンを停止するように指示します。
        オプションとして、アプリケーションは RoomCaptureViewDelegate プロトコルに準拠し、後処理された結果とその提示をオプトアウトしたり、後処理されたスキャン結果が提示された後にそれを処理したりすることが可能です。
        例えば、提供されたCapturedRoomデータ構造で利用可能なexport関数を呼び出すことで、結果のUSDZをエクスポートすることができます。
        このように、RoomPlan をお客様のアプリに簡単に統合することができます。
        この API を使って何を作るか、とても楽しみです。
        では、同僚のKaiがRoomCaptureSessionとRoomPlanのData APIについてお話しします。
        Kai: ありがとう、Praveen。
        このセクションでは、スキャン中に基礎となるデータ構造へのアクセスを提供し、スキャン体験のカスタム可視化をゼロから構築するのに役立つデータAPIについて説明します。
        基本的なワークフローは、スキャン、処理、エクスポートの3つの部分から構成されています。
        スキャンについては、キャプチャセッションのセットアップと開始方法、キャプチャプロセスの表示と監視の基本を説明します。
        次に、スキャンしたデータがどのように処理されるかを見ていきます。
        最後に、USDワークフローで使用することができる出力USDファイルを生成してエクスポートする方法について説明します。
        では、Scan のステップを詳しく見ていきましょう。
        RoomCaptureSession API を使用してセッションをセットアップし、スキャンを継続しながら進行状況を表示します。
        コードでお見せしましょう。
        ここでは、例として簡単なRealityKitアプリを紹介します。
        まず始めに、RoomPlan を Swift のプロジェクトにインポートするだけです。
        アプリの ViewController で、結果を視覚化し、RoomCaptureSession インスタンスを開始するためのカスタムタイプを持つことができます。
        さらに、RoomCaptureSession は、アプリが AR ビューで平面とオブジェクトのバウンディング ボックスを描画できるように、基礎となる AR セッションへのハンドルを提供します。
        RoomCaptureSession は、デリゲートパターンを採用しています。
        ViewController クラスで、ViewController 自体を captureSession のデリゲートとして割り当てることができます。
        これにより、ViewControllerはRoomCaptureSessionからリアルタイムの更新情報を取得することができます。
        これらの更新には、3Dモデルや、キャプチャ中に人々を誘導するための指示が含まれます。
        これらの更新を取得するために、ViewControllerはRoomCaptureSessionDelegateプロトコルに準拠し、2つのメソッドを実装する必要があります。
        最初のメソッドは captureSession(_ session: didUpdate room:) メソッドで、リアルタイムの CapturedRoom データ構造を取得するために使用します。
        ビジュアライザーはこれを用いて、3DモデルのARビューを更新し、進捗状況をリアルタイムにフィードバックすることができます。
        CapturedRoomの構造については、後ほど詳しく説明します。
        このメソッドは、キャプチャされた部屋の更新を検出したときに呼び出されます。
        2つ目のメソッドはcaptureSession(_ session: didProvide instruction:)です。
        このメソッドは、リアルタイムのフィードバックを含むインストラクション構造を提供します。
        ビジュアライザーは、このインストラクションを使って、スキャン中に人々を誘導することができます。
        このAPIが提供するインストラクションを見てみましょう。
        オブジェクトまでの距離、スキャン速度、部屋の照明の調整、テクスチャの多い場所へのフォーカスなど、さまざまな指示があります。
        これらの指示は、スキャン中に提供され、リアルタイムにフィードバックされます。
        次に、プロセス編です。
        ここでは、RoomBuilderクラスを使って、スキャンしたデータを処理し、最終的な3Dモデルを生成していきます。
        取り込んだデータを処理するために、まず、ViewController クラスで RoomBuilder インスタンスを開始します。
        次に、キャプチャ処理後のセンサーデータを受け取るために、アプリは captureSession(_ session: didEndWith data: error:) メソッドを実装する必要があります。
        アプリ内で stop() 関数を呼び出すなどして RoomCaptureSession が停止したとき、またはエラーによってこの関数が呼び出され、CaptureRoomData オブジェクトとオプションでエラーが返されます。
        最後に、キャプチャしたデータを処理するために、roomBuilder の async roomModel(from:) メソッドを await キーワードで呼び出します。
        このメソッドは、スキャンされたデータを処理し、最終的な3Dモデルを構築するために非同期で実行されます。
        これは、昨年のWWDCで紹介したSwiftのasync/await関数を利用しています。
        ほんの数秒で、モデルはあなたのアプリで最終的なプレゼンテーションに利用できるようになります。
        では、CapturedRoomのデータ構造の詳細と、それをどのようにエクスポートしてアプリで使用できるかを説明します。
        トップレベルのCapturedRoomは、SurfacesとObjectsから構成されています。
        Surfaceには、半径などのカーブを表す固有の属性、開始角度と終了角度、サーフェスの4つの異なるエッジ、壁、開口部、窓、ドアなどの建築のカテゴリが含まれます。
        オブジェクトには、テーブル、ベッド、ソファなどの家具カテゴリが含まれる。
        SurfaceとObjectは、寸法、スキャンされたサーフェスやオブジェクトの信頼度を3段階で示すconfidence、3D変換マトリックス、一意の識別子など、いくつかの共通した属性を持ちます。
        では、これらがどのようにコードで表現されるかを見てみましょう。
        CapturedRoom 構造体は、部屋の要素を完全にパラメトリックに表現したものです。
        壁、開口部、ドア、窓、部屋の中のオブジェクトなど、5つのプロパティが含まれています。
        最初の4つの要素については、2Dの平面的な建築構造を表現するSurface構造として表現しています。
        右側には、先ほど説明したSurfaceの様々なプロパティを見ることができます。
        最後のプロパティは、部屋の中にある3Dオブジェクトの配列で、キューボイドとして表現されます。
        右側には、Objectの様々なプロパティを見ることができます。
        RoomPlanでサポートしているオブジェクトの種類のリストです。
        ソファ、テーブル、椅子、ベッドなど、一般的な家具の種類も含まれています。
        最後に、エクスポート機能により、この CapturedRoom を USD または USDZ データにエクスポートして、既存のワークフローに使用することができます。
        ここでは、Cinema 4DでUSD出力を直接開いて、部屋の階層的なデータ構造、各部屋の要素やオブジェクトの寸法と位置をブラウズして編集できる例を紹介します。
        また、既存の USD および USDZ ワークフローを活用して、不動産、E コマース、公共事業、インテリアデザインなどのさまざまなアプリケーションに、キャプチャした部屋のレンダリングを追加することも可能です。
        これまで、スキャン体験と RoomPlan API について説明しました。
        次に、RoomPlan を使用して良い結果を得るためのベストプラクティスを紹介します。
        良いスキャンを行うための推奨条件、部屋を選択する際に注意すべき部屋の特徴、また、覚えておくべきいくつかのスキャンと熱に関する考慮事項について説明します。
        RoomPlan APIは、一般的な家庭の建築構造とオブジェクトのほとんどをサポートしています。
        最大で30フィート×30フィート（約9メートル×9メートル）の部屋の大きさの住宅用シングルルームに最適です。
        照明もまた、APIがクリアなビデオストリームと優れたARトラッキング性能を得るために重要です。
        APIを使用する際には、最低でも50ルクス以上を推奨しており、これは夜間の一般的な家庭のリビングルームの明るさに相当します。
        ハードウェアについては、RoomPlan APIは、LiDAR対応のiPhoneとiPad Proの全モデルに対応しています。
        API を使用する上で課題となる特殊な条件もあります。
        例えば、フルハイトの鏡やガラスは、LiDARセンサーが期待通りの出力をするための課題となります。
        高い天井も、LiDARセンサーのスキャン範囲の限界を超えてしまう可能性があります。
        また、非常に暗い表面は、デバイスがスキャンするのが難しいかもしれません。
        より良いスキャン結果を得るためには、いくつかの考慮事項があります。
        まず、高い精度が要求される用途では、スキャン前に部屋を準備することで、スキャンの質を高めることができます。
        例えば、カーテンを開けると自然光が入りやすくなり、窓の蔽いを減らすことができるので、日中のスキャンには最適です。
        また、ドアを閉めれば、部屋の外側の不要な場所をスキャンする可能性を減らすことができます。
        また、APIを使ったスキャンでは、スキャン動作を正しく行うことが重要です。
        そのため、スキャン中にテクスチャー、距離、速度、照明の状態などのフィードバックを提供するために、ユーザー指示のデリゲートメソッドを提供しています。
        もうひとつ気をつけなければならないのは、デバイスのバッテリーとサーマルです。
        RoomPlan API では、良好なスキャン体験を保証するために、多くの最適化を行いました。
        しかし、繰り返しのスキャンや5分以上の長時間のスキャンは避けた方がよいでしょう。
        これらは疲労を引き起こすだけでなく、バッテリーを消耗し、熱問題を発生させ、アプリのユーザー体験に影響を与える可能性があります。
        今日、私たちがカバーしたことはたくさんあります。
        新しいAPIであるRoomPlanを紹介しました。
        これは、あなたの部屋をキャプチャするための直感的なスキャン体験、環境を理解するための強力な機械学習モデル、そしてあなたのアプリに簡単に統合するための完全にパラメトリックなUSD出力形式を提供します。
        新しいRoomPlanエクスペリエンスをより良く設計し、実装する方法についてのガイダンスは、以下の関連する講演を参照してください。
        プラベーン あなたのアプリで RoomPlan を試すときが来ました。
        この新しいAPIでどんなものが作れるか、楽しみですね。
        Kai: ご視聴ありがとうございました。♪

        """
    }


}
