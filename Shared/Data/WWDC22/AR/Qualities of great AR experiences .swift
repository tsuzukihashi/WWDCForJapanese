import Foundation

struct QualitiesOfGreatARExperiences: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Qualities of great AR experiences"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6628/6628_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10131/")!
    }

    var english: String {
        """
        Welcome to "Qualities of great AR experiences."
        I'm Alli Dryer, and I'm part of the Apple Design team working on augmented reality.
        AR lets you deliver experiences that blend virtual objects with the real world, creating the illusion that these objects actually exist.
        AR can be surprisingly immersive, and yet at the same time, it's always grounded in what's really happening.
        It allows you to visualize things that would be impossible, risky, or hard to do from a practical standpoint.
        Blurring the line between imagination and reality, an AR experience really feels like magic.
        You can completely transform people's surroundings through visuals and sound so they experience something new.
        You can also add new layers of information to the environment to enable quick and lightweight interactions.
        Designing for augmented reality can be very different from designing for 2D applications, but don't worry, we'll break it down here.
        Today I'm going to share criteria you can use to decide if AR is right for the experience you're building, along with tips for handling some of the unique aspects of augmented reality when you're designing your first AR experience.
        OK.
         So you're designing an app or feature and wondering whether AR makes sense for you.
        Here are a few things to consider.
        AR can help you deliver a true representation of things.
        To show what I mean, let's look at an example of something AR does really well, which is to present the real-world size of an object.
        Say you're trying to educate people about how big a dinosaur is.
        You could just write it out, or show a picture, or you could unleash a virtual T.
         rex on the scene.
        In that case, there's no need to imagine how big the dinosaur is.
        The AR experience gives the viewer an instant, visceral sense of scale in a way that's truly immersive.
        This example comes from the app Monster Park, a game that lets people explore and control the movement of animated three-dimensional dinosaurs.
        It's fitting that the entire app revolves around this large-as-life AR experience, also emphasizing the creation of photos and videos for sharing.
        AR is at its most delightful when it affects and responds to what's immediately around you, involving physical space in a meaningful way.
        Say you're trying to design an app that helps with interior design, and you want to help people choose a paint color for their walls.
        You could use swatches or stock photography, but those aren't very accurate.
        Even better, you could show someone how their very own room would look with freshly painted walls.
        The Color Snap app does just that.
        It allows people to choose a paint color and then tap a wall to preview the effect.
        Because it's AR, people can move around to see how the new color will affect their space from different vantage points.
        Next, augmented reality allows you to create experiences that visualize virtual objects in 3D, which makes it easier to understand and evaluate them.
        With AR, you can build features that help people try on things in a way that's virtual yet realistic enough for someone to make a confident purchasing decision.
        For example, the Warby Parker app lets people try on virtual glasses so they can place an order knowing exactly how their frames will fit.
        It's faster to switch between frame styles in AR than it would be to swap glasses in real life.
        Grounding virtual objects in the scene is also really important.
        The quality of lighting and shadows in your experiences can have a huge impact on people's feeling that things are really there, even when an object isn't very realistic.
        The IKEA Place app allows people to place a piece of virtual furniture in their home and get a more accurate sense of what the updated room would look like.
        IKEA Place takes advantage of ARKit's built-in lighting for realistic shadows that really settle the virtual furniture into the room.
        Visualizing in 3D can refer to objects, but don't forget about using people's surroundings as a canvas for your experiences.
        You can create new features with advanced visual effects, provide maps and 3D models that fit your brand, and even bring people's spaces into the game you're building with iOS's new RoomPlan API.
        We've got a session on creating 3D room scans that goes into detail about RoomPlan if you want to learn more.
        AR lets you streamline actions by attaching digital capabilities to physical things, making your apps and features more efficient.
        You might have already experienced how using the real world as input can speed things up if you've ever scanned a code to order at a restaurant.
        You can use AR to build compact yet incredibly useful features that save people time.
        In iOS's Measure App, centering the camera on a person automatically displays her height in just the right spot.
        The experience feels lightweight because there's very little UI, the interaction is based on device movement, and the measurement information disappears after you've seen it.
        This AR experience would be too limited to offer as an app on its own, but it really complements the other capabilities of the Measure app.
        So, now you know you can use AR for your apps and features when you want to deliver a true representation, involve physical space in a meaningful way, visualize in 3D, and streamline actions by making use of what's in the environment.
        And as you can see, there are a lot of different ways to incorporate AR into the experiences you're creating, whether it's as the main focus of the app or with a lighter hand as a feature that reduces friction.
        So, you've decided AR is right for your purposes and now it's time to get started with design.
        When you're designing for AR, you'll need to consider some of the aspects that make it different than traditional 2D interfaces.
        AR is spatial.
        AR is movement-based.
        And AR is tied to the physical environment.
        You'll need to think about how to blend virtual elements into the scene, about ergonomics, and about working with a limited field of view.
        Now I'll go through tips you can keep in mind when designing AR experiences.
        People using your app might be in places that are difficult for AR, so what you can do to help is coach them through different ways to get to a better experience.
        The Mission to Mars app does a great job of getting people set up for success with a strong coaching sequence.
        Let's take a closer look at this example.
        As you're getting started, Mission to Mars highlights three different requirements you need in your environment to have a great session.
        First, there's a reminder that AR can be immersive, and it's wise to find a safe place to engage with it.
        This can be a particular concern for experiences that involve wayfinding, where you'll need to take extra care not to draw people's attention to the screen for long periods of time.
        Next, the app suggests that AR performs best on surfaces with texture, rather than on glass or smooth white featureless planes.
        LiDAR can help overcome some of these challenging environmental conditions, so you might be able to omit this suggestion for some devices.
        And last, Mission to Mars advises people to find a bright space because AR works best in environments that are properly lit.
        What's great about this coaching sequence is that it's quick, easy to navigate, and helps people understand how to set up their environment for the best AR experience.
        The next tip is to take advantage of screen space.
        You'd be surprised how large a role it can play in AR experience design.
        So, what is screen space? Think of screen space as a 2D layer that sits on top of the three-dimensional world that's captured by your camera view.
        It's best to place text and interactive elements like buttons here in screen space, rather than in the 3D world of the camera to preserve legibility.
        Here's a great example from the Mission to Mars app that illustrates how to handle text in screen space.
        High-contrast text and buttons sit in a 2D screen space layer on top of the 3D scene below.
        The text updates as the camera moves to help you understand how it relates to the 3D objects in the scene.
        If you do need to lock your text to something in the world, try to keep it billboarded or parallel to the screen when possible.
        Focus on increasing contrast, bumping up type sizes and putting text on a background so you can maintain accessibility.
        Design for constant movement.
        It's important that people understand how and when to move their devices.
        Sometimes they'll need to move their bodies as well in order to experience AR.
        Try to provide real-time feedback with visual effects and sound as people move, so that even if the action is taking place out of view, people can still connect with the experience.
        Use simple, glanceable instructions and animations to coach people how to move.
        It helps to place instructions in screen space and to show them on an as-needed basis, rather than all up front.
        It's great to leverage the built-in coaching animations, but you can also create your own onboarding instructions that relate to your app, like this example from the app DoodleLens that shows an iPhone panning back and forth in front of a doodle.
        Ergonomic considerations are really important for AR.
        It can be exhausting to hold your arm out for long periods of time, and uncomfortable to reach for buttons that aren't positioned properly for one-handed use.
        Emphasize legibility at arm's length for the entire interface.
        Simplify interactions so that they can be completed with minimal effort.
        Use oversized buttons with high-contrast icons that are easy to tap one-handed with a thumb.
        Here's a nice example at the bottom of the screen in DoodleLens.
        People are viewing AR experiences with a limited field of view offered through a handheld device, so there's a good chance they might not be able to see the full extent of something large.
        There's also a possibility that a virtual object might be located out of view.
        Allow people to adjust the scale of an object, in case they're not able to back up far enough to see the whole thing.
        This example from AR Quick Look uses a pinch gesture for direct manipulation.
        There's also a haptic so that you can feel it when you scale something past 100 percent.
        When something is out of view to the right or to the left, use sounds and haptics and provide simple indicators or text instructions in screen space.
        It can also be helpful to provide a map or bird's-eye view showing someone's orientation and illustrating that the object is located in the opposite direction.
        In this example from the RoomPlan experience, the small 3D model drawing at the bottom of the view helps you preview your results and keep track of what has been scanned so far.
        It can be difficult for people peering through a screen to understand the location of virtual objects in space unless they're behaving realistically.
        Depth cues that help people see how far away things are can help with this.
        The size of objects, perspective effects like diminishing towards the horizon, realistic shadows and lighting, the proper amount of detail in your textures, and overlapping objects create a feeling of depth and help people perceive spatial relationships.
        I want to highlight one depth cue that's tricky to work with but can really help people understand where things are located relative to each other: overlapping, also known as occlusion.
        Here's an example of overlapping you can see in AR Quick Look.
        The virtual airplane seems like it's positioned behind the wooden blocks on the desk because the lower part of it is hidden.
        Finally, craft experiences that last no more than a minute or two.
        This is for the ergonomic reasons I mentioned earlier, but also because AR is a resource-intensive superpower that has a big impact on battery and thermals.
        If you do end up creating a longer experience, make sure that you build in breaks.
        For All Mankind: Time Capsule is an AR experience that allows you to explore the For All Mankind universe.
        The app complements the TV show, telling stories through interactive objects.
        Time Capsule is presented in chapters that provide moments of rest and a place to pause then return to the experience.
        Today I shared tips to help overcome some of the challenges with working on AR features.
        You've learned to guide people to the right environment, to take advantage of screen space, to design for constant movement, to think about ergonomics and a limited field of view, to use depth cues, and to limit the duration of the experience to keep people from getting fatigued.
        Augmented Reality feels like magic when it's useful, delightful, and relates to the physical world.
        AR allows you to see virtual objects or even to transform your environment.
        You can attach digital capabilities to physical things to create a layer of useful information and actions.
        The AR features and apps that you create will transform how people work, learn, play, shop, and connect with the world.
        I can't wait to see what you'll build next in augmented reality.
        Thank you!
        """
    }

    var japanese: String {
        """
        "優れたAR体験の資質 "へようこそ。
        私はアリ・ドライヤーと申します。Apple Designチームの一員として、拡張現実を研究しています。
        ARは、仮想の物体を現実の世界と融合させ、あたかもその物体が実際に存在するかのような錯覚を起こさせる体験を提供することができます。
        ARは驚くほど没入感があり、同時に、常に現実に起きていることに根ざしています。
        現実には不可能なこと、危険なこと、困難なことを視覚化することができるのです。
        想像と現実の境界線が曖昧になるAR体験は、まるで魔法のようなものです。
        映像や音で周囲の環境を一変させ、新しい体験をさせることができます。
        また、環境に新たな情報レイヤーを追加することで、迅速かつ軽快なインタラクションを実現することも可能です。
        拡張現実のためのデザインは、2Dアプリケーションのためのデザインとは大きく異なりますが、心配しないでください、ここではそれを分解して説明します。
        今日は、構築する体験にARが適しているかどうかを判断するために使用できる基準と、初めてのAR体験をデザインするときに拡張現実のユニークな側面を処理するためのヒントを紹介します。
        わかりました。
         アプリや機能を設計しているときに、ARが意味を持つかどうか疑問に思うことがありますよね。
        ここでは、考慮すべき点をいくつか紹介します。
        ARは、物事の真の表現を提供するのに役立ちます。
        どういう意味か説明するために、ARが非常にうまく機能する例を見てみましょう。それは、オブジェクトの実際の大きさを提示することです。
        例えば、恐竜の大きさを説明する場合。
        ただ書き出したり、写真を見せたりすることもできますが、バーチャルなT.
         レックスを登場させることもできます。
        その場合、恐竜の大きさを想像する必要はありません。
        AR体験では、直感的にスケール感を感じられるので、まさに没入感が得られます。
        このアプリは、立体的な恐竜のアニメーションを操作して探索するゲーム「Monster Park」の例です。
        アプリ全体がこの大きなAR体験を中心に展開され、写真や動画を作成して共有することに重点を置いているのは、まさにその通りです。
        ARが最も楽しいのは、身の回りのものに影響を与え、反応し、物理的な空間を有意義に巻き込むときです。
        例えば、インテリアのデザインに役立つアプリをデザインしようとしていて、壁のペンキの色を選ぶのを手伝いたいとします。
        見本や写真を使うこともできますが、それではあまり正確ではありません。
        それよりも、塗ったばかりの自分の部屋がどうなるかを見せられたら。
        Color Snapは、まさにそれを実現するアプリです。
        ペンキの色を選び、壁をタップすると、その効果をプレビューすることができます。
        ARなので、人々は動き回って、新しい色が自分の空間にどのような影響を与えるかを、さまざまな視点から見ることができます。
        次に、拡張現実では、仮想の物体を3Dで視覚化することで、理解や評価を容易にする体験を作ることができます。
        ARを使えば、バーチャルでありながら、人が自信を持って購入を決断できるほどリアルに試着できる機能を構築することができます。
        例えば、Warby Parkerのアプリでは、バーチャルなメガネを試着することで、フレームのフィット感を正確に把握しながら注文をすることができます。
        ARのフレームは、現実のメガネと同じように素早く交換することができます。
        また、仮想オブジェクトの接地も非常に重要です。
        照明や影の質は、たとえオブジェクトがあまりリアルでなくても、そこにあるものを本当にそこにあると感じさせるのに、大きな影響を与えます。
        IKEA Placeのアプリでは、バーチャルな家具を自宅に置くことで、アップデートされた部屋がどのように見えるかをより正確に感じ取ることができます。
        IKEA Placeは、ARKitの内蔵照明を利用してリアルな影を作り出し、バーチャル家具を部屋の中にしっかりと定着させます。
        3Dでのビジュアライゼーションは、オブジェクトを参照することができますが、人の周囲をキャンバスとして使って体験することも忘れてはいけません。
        高度な視覚効果で新しい機能を作成したり、ブランドに合った地図や3Dモデルを提供したり、iOSの新しいRoomPlan APIを使って、人々の空間をあなたの作っているゲームの中に取り入れることもできます。
        3Dルームスキャンの作成に関するセッションで、RoomPlanについて詳しく説明していますので、よろしければご覧ください。
        ARは、物理的なものにデジタルな機能をつけることで行動を効率化し、アプリや機能をより効率的にすることができます。
        レストランで注文するためにコードをスキャンしたことがある人は、実世界を入力として使用することでスピードアップできることをすでに経験しているかもしれません。
        ARを使えば、コンパクトでありながら非常に便利な機能を構築し、人々の時間を節約することができます。
        iOSの計測アプリでは、カメラを人物に向けると、自動的にちょうどいい位置に身長が表示されます。
        UIがほとんどなく、デバイスの動きに応じてインタラクションが行われ、測定情報は見た後に消えてしまうため、この体験は軽量に感じられます。
        このAR体験は、単独でアプリとして提供するにはあまりに限定的ですが、Measureアプリの他の機能を大いに補完するものです。
        このように、ARをアプリや機能に使うことで、真の表現を届けたいとき、物理的な空間を有意義に巻き込みたいとき、3Dで視覚化したいとき、環境にあるものを利用して行動を効率化したいとき、に使えることがおわかりいただけたと思います。
        このように、アプリのメインとして、あるいは摩擦を減らす機能として軽く手を加えるなど、作成する体験にARを組み込む方法はさまざまです。
        さて、ARが目的に合っていると判断したら、次はデザインに取りかかりましょう。
        ARをデザインする際には、従来の2Dインターフェースとは異なるいくつかの側面を考慮する必要があります。
        ARは空間的です。
        ARは動きベースです。
        そして、ARは物理的な環境と結びついています。
        仮想要素をシーンに溶け込ませる方法、人間工学、限られた視野での作業について考える必要があります。
        それでは、ARをデザインする際のヒントを紹介します。
        アプリを使用する人は、ARにとって困難な場所にいるかもしれません。そこで、より良い体験を得るためのさまざまな方法を指導することができます。
        Mission to Marsアプリは、強力なコーチングシークエンスによって、人々を成功へと導く素晴らしい仕事をしています。
        この例をもう少し詳しく見てみましょう。
        セッションを始めるにあたり、Mission to Marsは、優れたセッションを行うために必要な3つの異なる要件を強調します。
        まず、ARは没入感をもたらすので、安全な場所を見つけることが賢明であることを強調しています。
        特に、道案内のような体験では、長時間スクリーンに注意を引かれないような配慮が必要でしょう。
        次に、このアプリは、ARがガラスや特徴のない滑らかな白い平面ではなく、テクスチャのある表面で最もうまく機能することを示唆しています。
        LiDARは、こうした厳しい環境条件を克服するのに役立つので、デバイスによっては、この提案を省略できるかもしれません。
        そして最後に、Mission to Marsは、ARが適切に照明された環境で最もよく機能するため、明るい場所を探すようにアドバイスしています。
        このコーチングシークエンスが優れているのは、素早く、簡単にナビゲートでき、最高のAR体験のためにどのように環境を整えればよいかを理解できる点です。
        次のヒントは、スクリーンスペースを活用することです。
        AR体験のデザインにおいて、スクリーンスペースが果たす役割の大きさに驚かれることでしょう。
        では、スクリーンスペースとは何でしょうか？カメラで撮影された3次元の世界の上にある2次元のレイヤーがスクリーンスペースだと考えてください。
        テキストやボタンなどのインタラクティブな要素は、カメラの3次元世界ではなく、このスクリーンスペースに配置するのが読みやすさを維持するために最適です。
        Mission to Marsアプリケーションの素晴らしい例で、スクリーンスペースでのテキストの扱い方を説明します。
        高コントラストのテキストとボタンが、下の3Dシーンの上にある2Dの画面空間レイヤーに配置されています。
        カメラの動きに合わせてテキストが更新されるので、シーン内の3Dオブジェクトとの関連性を理解しやすくなります。
        テキストを世界の何かに固定する必要がある場合は、可能な限り、ビルボード状または画面と平行になるようにします。
        アクセシビリティを維持するために、コントラストを上げ、文字サイズを大きくし、テキストを背景に配置することに注力しましょう。
        常に動けるようにデザインする
        端末をいつ、どのように動かせばよいかを理解してもらうことが重要です。
        また、ARを体験するためには、体を動かす必要がある場合もあります。
        その際、視覚効果や音声によるリアルタイムなフィードバックを提供することで、たとえ視界に入らない場所でのアクションであっても、体験者の心をつかむことができるようにしましょう。
        動作の指導には、一目でわかるシンプルな指示やアニメーションを使用します。
        指示は、前もってすべて表示するのではなく、画面内に配置し、必要に応じて表示するのが効果的です。
        内蔵のコーチングアニメーションを活用するのもよいですが、アプリに関連するオンボーディングの指示を独自に作成することもできます。たとえば、DoodleLensというアプリでは、落書きの前でiPhoneを前後にパンする例が示されています。
        人間工学的な配慮は、ARにとって本当に重要です。
        長時間腕を出し続けるのは疲れるし、片手で操作するために適切な位置にないボタンに手を伸ばすのは不快です。
        インターフェイス全体において、腕を伸ばした状態での読みやすさを重視します。
        インタラクションをシンプルにし、最小限の労力で完了できるようにする。
        親指でタップしやすい大きめのボタンやコントラストの高いアイコンを使用する。
        これは、DoodleLensの画面下部の良い例です。
        携帯端末という限られた視野の中でARを体験するわけですから、大きなものは全体が見えない可能性があります。
        また、仮想オブジェクトが視界の外側にある可能性もあります。
        全体を見るために十分な距離を取ることができない場合に備えて、オブジェクトのスケールを調整できるようにしましょう。
        AR Quick Lookのこの例では、ピンチ・ジェスチャーを使って直接操作しています。
        また、100パーセントを超えるスケールを設定すると、それを感じられるように触覚もあります。
        何かが右や左にずれているときは、音や触覚を使って、簡単なインジケータやテキストによる指示をスクリーンスペースで提供します。
        また、誰かの方向を示す地図や鳥瞰図を提供し、対象物が反対方向にあることを説明することも有効です。
        このRoomPlanの体験の例では、ビューの下部にある小さな3Dモデルの図面は、結果をプレビューし、これまでにスキャンされたものを追跡するのに役立ちます。
        スクリーン越しに見る人は、仮想オブジェクトがリアルに動作していない限り、空間内の位置を理解するのは難しいでしょう。
        このような場合、物体がどのくらい遠くにあるかを示す「奥行き」の手がかりが役に立ちます。
        オブジェクトの大きさ、地平線に向かって小さくなるような遠近効果、リアルな影や照明、テクスチャの適切なディテール、オブジェクトの重なりなどは、奥行き感を生み出し、空間的な関係を認識するのに役立ちます。
        ここで、扱いが難しいが、物体の相対的な位置関係を理解するのに役立つ奥行きの手がかりを1つ紹介したい。
        ARクイックルックで見ることができるオーバーラップの例です。
        バーチャル航空機の下部が隠れているため、机の上の木製のブロックの後ろに配置されているように見えます。
        最後に、1～2分以内の体験を作りましょう。
        これは、先に述べた人間工学的な理由もありますが、ARはバッテリーとサーマルに大きな影響を与えるリソース集約型の超能力であることも理由です。
        もし、長い体験を作ることになったら、必ず休憩を入れるようにしてください。
        For All Mankind: Time Capsuleは、For All Mankindの世界を探検できるAR体験です。
        このアプリは、テレビ番組を補完するもので、インタラクティブなオブジェクトを通じてストーリーが語られます。
        Time Capsuleは章立てで表示され、休憩時間や一時停止して体験に戻る場所を提供します。
        今日は、AR機能に取り組む際の課題を克服するためのヒントをお伝えしました。
        人々を正しい環境に導くこと、スクリーンスペースを活用すること、常に動けるようにデザインすること、人間工学と限られた視野について考えること、奥行きの手がかりを使うこと、人々が疲れないように体験時間を制限すること、などを学びましたね。
        拡張現実が魔法のように感じられるのは、それが便利で楽しいものであり、物理的な世界と関連しているときです。
        ARは、仮想の物体を見たり、環境を変化させたりすることができます。
        物理的なものにデジタルの機能を付けて、便利な情報や行動のレイヤーを作ることができるのです。
        あなたが作るAR機能とアプリは、人々の働き方、学び方、遊び方、買い物、そして世界とのつながり方を変えていくでしょう。
        皆さんが次に拡張現実で何を作ってくれるのか、楽しみでなりません。
        ありがとうございました。

        """
    }
}

