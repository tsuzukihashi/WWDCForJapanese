import Foundation

struct PlugInAndPlayAddAppleFrameworksToYourUnityGameProjects: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Plug-in and play: Add Apple frameworks to your Unity game projects"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6558/6558_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10065/")!
    }

    var english: String {
        """
        Hi, I'm Jared Marsau and I work on Game Technologies at Apple.
         Today, I'll be talking to you about how you can use select Apple frameworks to add new features to your Unity-based games.
         We know that many of you are using tools, such as Unity, to build your games.
         Our goal is to bring you the latest features, no matter what tool you're using.
         Starting today, enhance your games with a new set of Unity plug-ins.
         Use the Game Center plug-in to add GameKit features like player authentication, leaderboards, and matchmaking.
         Use the Game Controller plug-in for input customizations and glyphs, along with support for MFi and third-party controllers.
         Use the Accessibility plug-in to improve accessibility through system features, like VoiceOver and Dynamic Type.
         Integrate Apple's data-driven rich haptic feedback system with the Core Haptics plug-in.
         Add advanced geometry-aware spatial audio with the PHASE plug-in.
         Finally, use the Apple.Core plug-in to manage build settings and simplify the build process.
         This initial set of plug-ins will let you add new gameplay mechanics, make your games more accessible, and help you more rapidly tap into the latest features and services.
         I am extremely excited to see the amazing games you create with this new set of Unity plug-ins.
         Now, I'll get into the details of the project.
         First, I'll discuss the design principles of the project.
         Then, I'll cover project concepts and organization.
         Next, I'll offer some key pointers on interacting with the project repository.
         And finally, I'll go into detail for each plug-in.
         As you may know, Apple frameworks encapsulate functionality in a modular way.
         This lets you pick and choose the right technologies for your apps while maintaining compact, efficient code.
         With the Unity plug-ins, a similar pattern is followed; each plug-in maps to a single underlying framework.
         This lets you pick and choose the set of plug-ins you want to use based upon your game's needs.
         Each plug-in exposes C#-based Unity script, which maps as directly as possible to the underlying framework.
         Doing this means that any familiarity that you might have with the underlying framework carries over to the plug-in.
         Concepts, and in many cases the framework API, carry directly over.
         Conversely, this also means that by learning the plug-in, you'll be implicitly learning the underlying framework.
         Another important detail is that these plug-ins are built as Apple platform native libraries.
         These libraries act as the glue between the C# script and the underlying framework API.
         Apple Unity plug-ins are organized as Unity packages, so managing their integration to your project can be done with the Unity Editor's built-in Package Manager.
         In some cases, plug-ins also include additional Editor functionality that makes working with the plug-in even easier and aligns with the Unity inspector-driven workflows that you're already familiar with.
         Of course, each plug-in is paired with detailed readmes, samples, and links to additional resources, such as associated Apple Developer documentation.
         Next, I'll briefly examine some key workflow concepts to help you get started.
         The first step is to clone the source from GitHub.
         You can find all of the project source and documentation there.
         This is the starting point for everyone who will be using the Apple Unity plug-ins.
         Once you've cloned the repository, building the plug-ins will be one of your first tasks.
         To simplify this process, the repository includes a Python script at the repository root: build.py.
         This script handles building native libraries, copying them to the correct locations, updating Unity meta files, packing the plug-ins, and building plug-in tests.
         The script is organized such that the simplest invocation builds all of the plug-ins, packages them into tarballs, and saves them to a build folder ready for integration into your Unity projects.
         It's important to note that fully building and packing the plug-ins will require Xcode, Python3, npm, and Unity.
         Finally, we have detailed documentation for using build.
        py in the project repository.
         Now it's time to dive into details with each of the plug-ins.
         For each plug-in, I'll cover how to add them to your Unity projects, a brief overview of included features, key scripting concepts, and some code snippets or examples in the Unity Editor highlighting how to integrate them into your projects.
         Let's start with the foundational plug-in, Apple.Core.
         Apple.Core unifies build settings for each plug-in into a single preference pane within Unity's Project Settings window.
         Because you compile each plug-in's native libraries, Apple.Core also includes an asset processor, which ensures that each plug-in library is configured for the appropriate platform on import.
         When building your projects, Apple.Core also contains scripts that run as a post-process to your build to ensure that native libraries are referenced correctly in your intermediate Xcode projects.
         Because each plug-in interacts with an underlying framework, Apple.Core also defines a handful of runtime inter-op types, which ease data passing between the C# script and native code layers.
         Finally, Apple.Core is a dependency for all other Apple Unity plug-ins.
         This means that Apple.Core should be imported into your projects before any of the other plug-ins.
         In this demo, I'll show you how to import the Apple.Core plug-in into a new project and briefly explore the Apple Build Settings preferences.
         Once the plug-ins are built and packed, Apple.Core can be imported with the Unity Package Manager.
         Just choose the option to add package from tarball and browse to the packaged plug-in.
        The Editor will then load the package and compile the scripts.
         Once complete, Apple.Core is ready to use.
        Apple.Core's primary user-facing feature is the addition of the Apple Build Settings tab in the Editor's Project Settings window.
        When you import an Apple Unity plug-in, all of it's available build options will be visible here.
         Out of the box, Apple.Core comes with some default configuration options, such as minimum supported OS version.
         It's also useful to note that you can disable the post-process build steps for any plug-in.
        Finally, you can configure common security settings, which will propagate to your intermediate Xcode projects.
         Use the Game Center plug-in to bring even more fun and connection to your games with Game Center, Apple's social gaming network.
         Game Center lets players build an identity across Apple platforms and enables features like safe, secure player authentication, in-game achievements, shared leaderboards, challenges sent between players, and multiplayer matchmaking.
         You can pick and choose which Game Center features to integrate into your games, but everything starts with player authentication.
         Add Game Center player authentication to your game and the Game Center widget can feature your game on the player's Home Screen or within the App Store.
         It also requires very little code to add player authentication.
         The first step is to add the Apple.Core and GameKit plug-ins to your project.
         The GameKit plug-in connects the Game Center service.
         When authenticating, connect with the Game Center service and initialize a GKLocalPlayer object.
         Once initialized, query for player restrictions based upon the local player's profile.
         These restrictions include limiting access to adult or explicit content for underage players, limiting access to multiplayer features, or disabling in-game communication.
         A simple way to manage a GKLocalPlayer and it's interactions with the Game Center service is to define a component within Unity.
         Here, for example, is a simple Game Manager component definition.
         This component holds a reference to a GKLocalPlayer.
         It also handles both authentication and query for player restrictions in its start method; player authentication only needs to happen once during the lifetime of the game.
         This is the GameManager component's script.
         Here's the field for caching a GKLocalPlayer.
         Within the component's start method is the one-time call to GKLocalPlayer.
        Authenticate, a static method that returns the GKLocalPlayer instance.
         Once the local player is successfully authenticated, it's time to check their player restrictions.
         Checking player restrictions in code resolves to a series of Boolean checks and can be added to the try block in the GameManager component's script.
         True here means your local player should have limited access to explicit content.
         True here means that your local player should have a restricted multiplayer experience.
         And finally, true here means that in-game communication should be disabled.
         And that's all the code changes necessary to add player authentication to your game.
         From here, there are two additional steps necessary to fully prepare your game to take advantage of Game Center.
         First, you'll need to add the Game Center capability to your intermediate Xcode projects.
         This is done from within the Xcode project UI.
         More information can be found in the Apple Developer documentation article "Enabling and Configuring Game Center.
        " Next, you'll need to add Game Center features to your app using App Store Connect.
         Check out the App Store Connect portal for more information.
         With these steps complete, you're ready to authenticate players and ensure a safe gaming environment.
         Player authentication only scratches the surface of the features made available by the Game Center Unity plug-in.
         To learn more about improving discoverability of your game, check out the session "Reach new players with Game Center dashboard.
        " To learn more about multiplayer and matchmaking, watch the "What's new in Game Center" session from last year.
         Controllers are the primary way for players to interact with the worlds that you'll create.
         Easily bring reliable and flexible game controller support to your games with the Game Controller plug-in.
         The Game Controller plug-in brings a handful of features, like support for game controller customizations, which allow players to remap buttons in one place for all games.
         Button glyphs, to ensure consistent user experience.
         And support for all MFi controllers, as well as third-party controllers like select Sony and Microsoft controllers.
         Just as with the other plug-ins, use the Package Manager to add the Apple.Core and Game Controller plug-ins to your project.
         With the Game Controller plug-in loaded, the first step is to initialize the GCControllerService.
         As we'll see shortly, this service is how controllers and their connection events are accessed.
         Once initialized, query GCControllerService for all controllers currently connected to the system.
         Connected controllers are represented by GCController objects in the Game Controller plug-in.
         For each GCController that's connected, poll for updated controller state.
         Polling can happen as little or as often as is needed by your game, but a good place to start is in Unity's regular update loop.
         Once controller state is updated, test for input on each of the controller's individual elements, such as buttons, thumb sticks, and so on.
         Not to be forgotten, controllers may come and go during your game's lifecycle -- register callbacks to handle controller connect and disconnect events.
         A quick way to get the Game Controller plug-in integrated is to create a simple input manager component.
         This component has three key elements: a container which holds all of the currently connected controllers, a start method for initialization, and an update method for handling polling and testing for input.
         First, let's take a closer look at the start method.
         This is a great place to do all of the necessary one-time setup tasks.
         Initialization of the game controller service should happen here, along with the initial check for connected controllers and registration of callbacks for connection and disconnection events.
         Here's the input manager component's script.
         All of the one-time setup code goes in the component's start method, including a call to GCControllerService.
         Initialize().
         Calling GetConnectedControllers gets an enumerable container of all the currently connected controllers.
         The final initialization step is to register callbacks for controller connect and disconnect events.
         Now that initialization is complete, the input manager also needs an update method in order to poll each connected controller to update input state, and to handle input state for each of the controller's inputs.
         To poll for input, start by iterating through the set of connected controllers.
         Call the GCController's Poll method to gather the latest state.
         Then check each button state and respond accordingly.
         And that's a quick look at how to use the Game Controller plug-in to access connected controllers and get controller input.
         To get into more detail about the Game Controller framework and learn about topics like third-party controllers and nonstandard inputs, check out prior years' sessions: "Supporting New Game Controllers" and "Advancements in Game Controllers.
        " Accessibility is about making technologies available for everyone.
         Use the Accessibility plug-in to integrate a wide range of Apple's assistive technologies into your Unity-based games.
         The Accessibility plug-in gives you the ability to add key features, such as VoiceOver, which can read programmatically tagged content to your users; Switch Control, allowing for a wide range of assistive input devices; Dynamic Type, to easily scale in-game text and UI based upon user preferences; and UI accommodation settings in order to adhere to system-wide accessibility preferences.
         There's a lot to cover with the Accessibility plug-in, so I encourage you to check out the session "Add accessibility to Unity games" for a deep dive into the Accessibility Unity plug-in.
         In that session you'll not only get examples and use cases, but you'll also build an understanding of what's possible with accessibility on Apple platforms.
         Be sure to check it out as soon as you have the opportunity.
         Adding haptic feedback to your games is a great way to increase immersion and enhance the gameplay experience.
         Integrate Apple's advanced haptic capabilities with the Core Haptics plug-in.
         Use the Core Haptics plug-in to build custom haptic patterns from a set of haptic and audio events.
         Play back synchronized custom audio and haptics.
         Programmatically define or update haptic feedback by adjusting parameters in real time.
         Use the Apple Haptic and Audio Pattern file format, or AHAP, for a file-based approach to designing and storing your patterns as assets.
         Tune your Core Haptics patterns in the Unity Editor with inspector support.
         To get the most out of the Core Haptics plug-in, you'll need to understand four fundamental elements of Core Haptics and their relationship to one another.
         The highest-level element is the CHHapticEngine.
         The haptic engine represents the link to the haptic server on the device and is required to play any haptic patterns.
         The CHHapticEngine creates CHHapticPatternPlayers.
         Pattern players are used for playback of CHHapticPatterns with controls like start, stop, pause, and resume.
         A CHHapticPattern is a logical grouping of one or more haptic and audio events.
         The CHHapticEngine uses patterns to create players.
         CHHapticEvents are the building blocks used to define a haptic experience.
         Core Haptics is a data-driven API, which allows for haptic patterns to be defined programmatically, directly in your scripts, or by leveraging AHAP files.
         One easy way to add Core Haptics support to your projects is to create a Haptics component that manages each of the necessary Core Haptics objects.
         Here is an example Haptics component that contains a CHHapticEngine, a CHHapticPatternPlayer, and an AHAP Asset.
         The AHAP asset is a custom Unity asset defined by the Core Haptics plug-in.
         This allows for easy import and export to AHAP files, as well as a custom editor extension to manage pattern creation and customization.
         Let's take a closer look.
         I'll begin by ensuring that both Apple.Core and the Core Haptics plug-ins are installed in my project.
         With those added, I can start enhancing my game with haptics.
         Here's the haptics component that I've created based upon the previous diagram.
         We'll check out the implementation in just a moment, but for now, I'll attach it to my airplane.
        Once attached, I now see that the component requires an AHAP asset, but my AHAP Assets folder is empty.
         I'll create a new one by going to Assets > Create > Apple > CoreHaptics > AHAP.
         Once created, I'll give it a fantastic and original name: MyHapticPattern.
         The Core Haptics plug-in comes with editor extensions that let me tune my new pattern right in the inspector window.
         This is where I define the CHHapticEvents that are part of the CHHapticPattern that can be played.
         By default, there's a transient event, but I can easily add a continuous event as well.
         There are also Import, Export, and Reset buttons in the UI.
         Reset clears any events that I've added and returns the pattern to its default state.
         Import and Export are great features.
         These allow your project to load and save AHAP files.
         Here I've imported a predefined AHAP called Rumble, which triggers a nice vibration effect, but I think it needs to be tweaked just a little.
         Now that I've updated the pattern, I can export it to a new AHAP file in order to share this improved haptic pattern with the rest of my team.
        Now that my asset is created and tuned, I'll go back to my airplane and point it to MyHapticPattern.
         Great! Everything is wired up.
         With the haptic pattern defined and properly referenced, all that remains is to add some logic to the Haptics component so it can play a haptic pattern.
         This can be divided into two methods: PrepareHaptics and Play.
         PrepareHaptics is where the haptic engine is initialized, and the haptic pattern player is created.
         Play will simply call the CHHapticPatternPlayer's start method to begin playback.
         And here's the Haptics component script.
         Fields are defined for a haptic engine and a haptic player.
         Importantly, add a serializeField attribute to allow the AHAP asset to be set in the editor UI.
         Next, add the code to create a CHHapticEngine, start it, and create a haptic pattern player by accessing the AHAP directly from the referenced asset.
         Of course, calling Start on the player will play the haptic pattern.
         The Core Haptics Unity plug-in gives you the tools you need to add an entirely new level of immersion into your games.
         Use the Core Haptics plug-in to create magical game moments that look, sound, and feel real.
         For a deep dive into Core Haptics, check out the session "Introducing Core Haptics.
        " For details on designing engaging haptics experiences be sure to watch "Designing Audio-Haptic Experiences" and "Practice audio haptic design.
        " Immersive audio is an incredibly important aspect of great game experiences.
         Use the PHASE Unity plug-in to unlock your creative potential and build lush soundscapes into your game worlds.
         With PHASE, you can provide complex and dynamic audio experiences to your games.
         Geometry-aware audio means that sounds emanate from and interact with meshes in the scene.
         Environments in your game will sound more realistic through reverberation and reflection.
         You can build hierarchical audio graphs that allow for dynamic audio control during gameplay The PHASE plug-in includes a set of predefined components that are game-ready.
         Simply attach them to your game objects and you can start using PHASE without writing a single line of code.
         The first component is the PHASEListener component.
         It acts as the "ears" of your game scene and processes audio based upon its position, orientation, and reverb preset.
         Next is the PHASEOccluder component.
         PHASEOccluders attach to game objects with geometry data and dampen audio when they come between sources and the listener in the scene.
         Next is the PHASESource component.
         These are attached to game objects and use the object's transform to position sounds in your game world.
         In addition to the built-in components, the PHASE plug-in also defines a custom asset, the SoundEvent asset.
         Sound events are objects which describe audio playback events and define the audio played by sources in the scene.
         To start using the PHASE plug-in, the first step is to make sure that both the Apple.Core and PHASE plug-ins are added to the project.
         Once installed, I can start adding the included components to the scene.
         In this example project, I have three game objects of interest: an airplane, a building, and then the camera.
         First, I'll attach the PHASEListener component to the camera.
         By doing that, I've added the "ears" to the scene.
         Next, I'll make the building an occluder by attaching the PHASEOccluder component.
        Finally, I'll add a source to the scene by adding the PHASESource component to the airplane.
         Now that I've added a source it needs some audio to play, so I need to attach a sound event, but the Sound Events folder is empty.
         I can create one by going to Assets > Create > Apple > PHASE > SoundEvent.
         After creating a sound event, the PHASE plug-in will immediately open the PHASE sound event composer window.
         This is the canvas used to build sound events.
         I start by right-clicking anywhere in the window.
         This shows a pop-up that allows me to add a node to the event.
         Because I want to play back a clip I’ll create a sampler node.
         I've already added an audio clip of an idling airplane to the project, so I can reference that here.
         I'll keep looping enabled so that the airplane keeps humming along.
         To hear the airplane, I need to route it to a mixer.
         I can create a mixer by dragging the output line onto the event composer's canvas, where it will show me the option to create a mixer.
        My sound event is now complete and ready to use.
         By clicking on the sound event, I can see its settings directly in the inspector.
         This allows me to adjust values without having to go back into the sound event composer.
         With the sound event created, I can now reference it in the PHASESource component I attached to the airplane earlier.
         And with that, audio in the scene is routed and configured for playback.
         The PHASE Unity plug-in opens totally new possibilities for in-game audio design.
         To learn more about PHASE and to dive deeper into the concepts I've introduced today, be sure to check out the Apple Developer documentation site and last year's introductory WWDC session video.
         And that concludes our overview of the new Apple Unity plug-ins.
         I've covered a lot today, but if you would like to know more about any of the Apple Unity plug-ins, the repository on GitHub is the best place to start.
         That's where you'll find the source, detailed documentation, and samples for each of the plug-ins.
         Find out more about integrating accessibility into your Unity games with the "Add accessibility to Unity games" session and be sure to check out "Reach new players with Game Center dashboard" to learn how to boost your game's visibility.
         Thank you for watching.


        """
    }

    var japanese: String {
        """
        こんにちは、AppleでGame Technologiesを担当しているJared Marsauです。
         今日は、Apple のフレームワークを使用して、Unity ベースのゲームに新しい機能を追加する方法についてお話します。
         皆さんの多くは、Unityなどのツールを使ってゲームを作っていると思います。
         私たちの目標は、お客様がどのようなツールを使っていても、最新の機能を提供することです。
         本日より、Unityの新しいプラグインを使用して、ゲームを拡張することができます。
         Game Center プラグインを使用すると、プレイヤー認証、リーダーボード、マッチメイキングなどの GameKit 機能を追加できます。
         Game Controller プラグインを使用して、入力のカスタマイズやグリフ、MFi およびサードパーティ製コントローラをサポートします。
         Accessibility プラグインを使用すると、VoiceOver や Dynamic Type などのシステム機能を通じてアクセシビリティを向上させることができます。
         Core Hapticsプラグインを使用して、Appleのデータ駆動型リッチハプティックフィードバックシステムを統合できます。
         PHASEプラグインで、ジオメトリを考慮した高度な空間オーディオを追加します。
         最後に、Apple.Coreプラグインを使用して、ビルド設定とシンプルさを管理します。 Coreプラグインを使用して、ビルド設定を管理し、ビルドプロセスを簡素化します。
         このプラグインの初期セットにより、新しいゲームプレイの仕組みを追加し、ゲームをより身近なものにし、最新の機能やサービスをより迅速に利用できるようになります。
         この新しいUnityプラグインのセットで、皆さんが作る素晴らしいゲームに出会えることを非常に楽しみにしています。
         さて、ここからはプロジェクトの詳細に触れていきます。
         まず、プロジェクトの設計方針について説明します。
         そして、プロジェクトのコンセプトと構成について説明します。
         次に、プロジェクトのリポジトリを使用する際の重要なポイントを説明します。
         そして最後に、それぞれのプラグインについて詳しく説明します。
         ご存知のように、Apple のフレームワークはモジュール方式で機能をカプセル化しています。
         これにより、コンパクトで効率的なコードを維持しながら、アプリケーションに適した技術を選択することができます。
         Unityのプラグインも同様のパターンで、各プラグインは1つのフレームワークに対応しています。
         このため、ゲームのニーズに応じて、使用するプラグインを選択することができます。
         各プラグインは、C#ベースのUnityスクリプトを公開し、フレームワークにできるだけ直接マッピングされます。
         このため、基本的なフレームワークに精通していれば、プラグインも同じように使用できます。
         コンセプトや、多くの場合、フレームワークのAPIがそのまま引き継がれます。
         逆に言えば、このことは、プラグインを学ぶことによって、暗黙のうちに基礎となるフレームワークを学ぶことになることを意味します。
         もう一つ重要なことは、これらのプラグインは、Appleプラットフォームネイティブのライブラリとして構築されていることです。
         これらのライブラリは、C#スクリプトと基盤となるフレームワークAPIの間の接着剤のような役割を果たします。
         Apple UnityのプラグインはUnityのパッケージとして構成されているので、プロジェクトとの統合管理はUnity Editorのビルトインパッケージマネージャで行うことができます。
         プラグインには、プラグインでの作業をより簡単にし、すでに慣れ親しんでいるUnityインスペクタ主導のワークフローに沿うような、追加のエディタ機能が含まれていることもあります。
         もちろん、各プラグインには詳細なReadmeやサンプル、関連するApple Developerドキュメントなどの追加リソースへのリンクが用意されています。
         次に、ワークフローの主要なコンセプトについて簡単に説明します。
         最初のステップは、GitHub からソースをクローンすることです。
         そこには、プロジェクトのソースとドキュメントがすべてあります。
         これはApple Unityプラグインを使うすべての人にとっての出発点です。
         リポジトリをクローンしたら、プラグインのビルドが最初のタスクのひとつになります。
         この作業を簡単にするために、リポジトリには Python スクリプトがリポジトリルートに含まれています: build.py.
         このスクリプトは、ネイティブライブラリのビルド、正しい場所へのコピー、Unity メタファイルの更新、プラグインのパッキング、プラグインテストのビルドを処理します。
         このスクリプトは、最も単純な起動ですべてのプラグインをビルドし、tarballにパッケージし、ビルドフォルダに保存して、Unityプロジェクトに統合できるように構成されています。
         プラグインのビルドとパッケージングを完全に行うには、Xcode、Python3、npm、Unityが必要であることに留意してください。
         最後に、build.py の使用に関する詳細なドキュメントをプロジェクトリポジトリに用意しています。
        py を使用するための詳細なドキュメントがプロジェクトリポジトリにあります。
         さて、いよいよ各プラグインの詳細に飛び込んでいきます。
         各プラグインについて、Unityプロジェクトに追加する方法、含まれる機能の簡単な概要、スクリプトの主要な概念、Unityエディタでのコードスニペットやサンプルなど、プロジェクトに統合する方法について説明します。
         まず、基本的なプラグインであるApple.Coreから始めましょう。
         Apple.Coreは、各プラグインのビルド設定を、UnityのProject Settingsウィンドウ内の一つのPreferenceペインに統合します。
         各プラグインのネイティブライブラリをコンパイルするため、Apple.Core にはアセットプロセッサーも含まれています。 Core にはアセットプロセッサーも含まれており、インポート時に各プラグインのライブラリが適切なプラットフォーム用に設定されていることを確認します。
         プロジェクトをビルドする際、Apple.Core にはビルドのポストプロセスとして実行され、中間 Xcode プロジェクトでネイティブライブラリが正しく参照されることを確認するスクリプトも含まれています。
         各プラグインは基礎となるフレームワークと相互作用するため、Apple.Core は、C# スクリプトとネイティブコード層間のデータの受け渡しを容易にする、少数のランタイム相互運用型も定義しています。
         最後に、Apple.Core は他のすべての Apple Unity プラグインに依存します。
         つまり、Apple.Coreは他のどのプラグインよりも先にプロジェクトにインポートする必要があります。
         このデモでは、Apple.Core プラグインを新しいプロジェクトにインポートする方法を紹介し、Apple Build Settings の環境設定について簡単に説明します。
         プラグインのビルドとパックが完了したら、Apple.CoreはUnityパッケージマネージャでインポートすることができます。
         tarballからパッケージを追加するオプションを選択し、パッケージ化されたプラグインをブラウズするだけです。
        エディターがパッケージを読み込み、スクリプトをコンパイルします。
         これでApple.Coreはすぐに使えるようになります。
        Apple.Coreのユーザー向けの主な機能は、EditorのProject SettingsウィンドウにApple Build Settingsタブが追加されたことです。
        Apple Unityプラグインをインポートすると、そのプラグインで利用可能なすべてのビルドオプションがここに表示されます。
         Apple.Coreには、最低限サポートされるOSのバージョンなど、いくつかのデフォルトの設定オプションが用意されています。
         また、プラグインのポストプロセスビルドステップを無効にすることもできます。
        最後に、共通のセキュリティ設定を構成することができ、これは中間Xcodeプロジェクトに反映されます。
         Game Centerプラグインを使用すると、AppleのソーシャルゲームネットワークであるGame Centerを使用して、ゲームにさらなる楽しさとつながりを持たせることができます。
         Game Centerは、Appleのプラットフォーム間でプレイヤーのアイデンティティを構築し、安全でセキュアなプレイヤー認証、ゲーム内の実績、共有リーダーボード、プレイヤー間のチャレンジ送信、およびマルチプレイヤー対戦などの機能を可能にします。
         ゲームに統合するGame Centerの機能は自由に選択できますが、すべてはプレイヤー認証から始まります。
         Game Centerのプレイヤー認証をゲームに追加すると、Game Centerウィジェットがプレイヤーのホーム画面またはApp Store内でゲームを紹介できます。
         また、プレイヤー認証を追加するために必要なコードはごくわずかです。
         まず、Apple.CoreとGameKitのプラグインをプロジェクトに追加します。
         GameKitプラグインは、Game Centerのサービスを接続します。
         認証の際には、Game Centerサービスと接続し、GKLocalPlayerオブジェクトを初期化します。
         初期化したら、ローカルプレーヤーのプロファイルに基づいたプレーヤーの制限を問い合わせます。
         これらの制限には、未成年のプレイヤーに対する成人向けまたは露骨なコンテンツへのアクセスの制限、マルチプレイヤー機能へのアクセスの制限、またはゲーム内の通信の無効化などが含まれます。
         GKLocalPlayer と Game Center サービスとのやりとりを管理する簡単な方法は、Unity 内でコンポーネントを定義することです。
         例えば、以下はシンプルな Game Manager コンポーネントの定義です。
         このコンポーネントは GKLocalPlayer へのリファレンスを保持します。
         また、start メソッドでプレーヤーの認証と制限の問い合わせを行います。プレーヤーの認証は、ゲームのライフタイム中に一度だけ行う必要があります。
         これは GameManager コンポーネントのスクリプトです。
         GKLocalPlayerをキャッシュするためのフィールドです。
         コンポーネントのstartメソッドの中で、GKLocalPlayer.Authenticateを一度だけ呼び出します。
        Authenticate は、GKLocalPlayer のインスタンスを返す静的メソッドです。
         ローカル プレーヤが正常に認証されたら、プレーヤの制限をチェックする必要があります。
         プレイヤーの制限をコードでチェックすると、一連のブール値チェックになり、GameManager コンポーネントのスクリプトの try ブロックに追加することができます。
         ここでのTrueは、ローカルプレーヤーが明示的なコンテンツへのアクセスを制限されるべきことを意味します。
         True の場合、ローカルプレイヤーはマルチプレイヤー体験を制限されることを意味します。
         そして最後に、「true」は、ゲーム内の通信を無効にすることを意味します。
         以上で、ゲームにプレイヤー認証を追加するために必要なコードの変更は完了です。
         ここから、Game Centerを利用するために、ゲームを完全に準備するために必要な2つの追加ステップがあります。
         まず、中間XcodeプロジェクトにGame Centerの機能を追加する必要があります。
         これは、XcodeプロジェクトのUI内から行います。
         詳細は、Apple Developerドキュメントの記事「Enabling and Configuring Game Center」に記載されています。
        " 次に、App Store Connectを使用して、アプリにGame Center機能を追加する必要があります。
         詳細については、App Store Connectポータルを確認してください。
         これらの手順が完了したら、プレイヤーを認証して安全なゲーム環境を確保する準備が整いました。
         プレイヤー認証は、Game Center Unityプラグインで利用可能な機能のほんの一部に過ぎません。
         ゲームの発見力を高めるには、セッション「Game Centerダッシュボードで新しいプレーヤーを獲得する」を参照してください。
        " マルチプレイとマッチメイキングの詳細については、昨年行われた「Game Centerの新機能」セッションをご覧ください。
         コントローラは、プレイヤーが作成する世界とインタラクトするための主要な方法です。
         Game Controllerプラグインを使えば、信頼性が高く柔軟なゲームコントローラーを簡単にサポートすることができます。
         Game Controllerプラグインは、ゲームコントローラーのカスタマイズをサポートし、プレイヤーがすべてのゲームでボタンを一度に再マップできるようにするなど、さまざまな機能を提供します。
         ボタングリフにより、一貫したユーザーエクスペリエンスを保証します。
         また、すべてのMFiコントローラ、および一部のSonyとMicrosoftのコントローラのようなサードパーティコントローラをサポートしています。
         他のプラグインと同様に、パッケージマネージャを使用して、Apple.Core と Game Controller プラグインをプロジェクトに追加します。
         Game Controller プラグインがロードされたら、最初のステップは GCControllerService を初期化することです。
         後ほど説明しますが、このサービスはコントローラーとその接続イベントにアクセスする方法です。
         初期化したら、GCControllerService に現在接続されている全てのコントローラーを問い合わせます。
         接続されているコントローラーは Game Controller プラグインの GCController オブジェクトで表現される。
         接続されている各GCControllerに対して、コントローラーの状態を更新するためにポーリングする。
         ポーリングはゲームに必要なら何度でもできるが、まずはUnityの定期的なアップデート・ループから始めるのが良いだろう。
         コントローラの状態が更新されたら、ボタン、サムスティックなど、コントローラの各要素の入力をテストします。
         忘れてはならないのは、コントローラはゲームのライフサイクルの中で出入りする可能性があるということです。コントローラの接続と切断のイベントを処理するためにコールバックを登録します。
         ゲームコントローラプラグインを統合する簡単な方法は、シンプルな入力マネージャコンポーネントを作成することです。
         このコンポーネントには、現在接続されているすべてのコントローラを格納するコンテナ、初期化のための start メソッド、入力のポーリングとテストを処理する update メソッドの3つの主要素があります。
         まず、start メソッドについて詳しく見ていきましょう。
         このメソッドでは、必要な一回限りの設定作業を行います。
         ゲームコントローラサービスの初期化、接続されているコントローラのチェック、接続と切断のイベントに対するコールバックの登録などをここで行う必要があります。
         以下は、入力マネージャコンポーネントのスクリプトです。
         一回限りのセットアップのコードはすべてコンポーネントのstartメソッドにあり、GCControllerService.Initialize()の呼び出しも含まれる。
         Initialize()を呼び出す。
         GetConnectedControllers を呼び出すと、現在接続されているすべてのコントローラの列挙可能なコンテナが取得されます。
         最後の初期化ステップは、コントローラの接続と切断のイベントのコールバックを登録することです。
         初期化が完了したら、接続されている各コントローラをポーリングして入力状態を更新し、各コントローラの入力状態を処理するために、入力マネージャも update メソッドを必要とします。
         入力をポーリングするには、まず接続されているコントローラの集合を繰り返し処理します。
         GCControllerのPollメソッドを呼び出して、最新の状態を収集します。
         それから各ボタンの状態をチェックして、それに応じて応答します。
         以上、Game Controllerプラグインを使って接続されたコントローラーにアクセスし、コントローラーの入力を得る方法を簡単に説明しました。
         Game Controller フレームワークの詳細や、サードパーティコントローラや非標準入力などのトピックについては、過去のセッションを参照してください。新しいゲームコントローラのサポート」と「ゲームコントローラの進化」をご覧ください。
        " アクセシビリティは、すべての人が技術を利用できるようにすることです。
         Accessibility プラグインを使用すると、Apple のさまざまな支援技術を Unity ベースのゲームに統合することができます。
         Accessibility プラグインを使用すると、プログラムによってタグ付けされたコンテンツをユーザーに読み上げる VoiceOver、さまざまな補助入力デバイスを使用できる Switch Control、ユーザーの好みに応じてゲーム内のテキストと UI を簡単に拡大縮小する Dynamic Type、システム全体のアクセシビリティ設定に準拠するための UI accommodation 設定などの主要機能を追加することができます。
         Accessibilityプラグインには多くの機能があるので、セッション「Add accessibility to Unity games」でAccessibility Unityプラグインを深く掘り下げてみることをお勧めします。
         このセッションでは、例や使用例を得られるだけでなく、Appleのプラットフォームでアクセシビリティに何が可能かについての理解も深められるでしょう。
         機会があれば、ぜひご覧ください。
         ゲームに触覚フィードバックを追加することは、没入感を高め、ゲームプレイ体験を向上させるための素晴らしい方法です。
         Core Hapticsプラグインを使って、Appleの高度なハプティック機能を統合しましょう。
         Core Hapticsプラグインを使って、触覚イベントとオーディオイベントのセットからカスタムハプティックパターンを構築します。
         カスタム オーディオとハプティクスを同期して再生します。
         リアルタイムでパラメータを調整することにより、触覚フィードバックをプログラムで定義または更新できます。
         Apple Haptic and Audio Pattern file format (AHAP)を使用して、ファイルベースでパターンを設計し、アセットとして保存します。
         インスペクタのサポートにより、Core HapticsパターンをUnity Editorでチューニングできます。
         Core Hapticsプラグインを最大限に活用するためには、Core Hapticsの4つの基本要素とその相互関係を理解する必要があります。
         最上位の要素は、CHHapticEngineです。
         ハプティックエンジンは、デバイス上のハプティックサーバへのリンクを表し、あらゆるハプティックパターンを再生するために必要です。
         CHHapticEngine は CHHapticPatternPlayers を作成します。
         パターン プレーヤは、開始、停止、一時停止、および再開などのコントロールを持つ CHHapticPatterns を再生するために使用されます。
         CHHapticPatternは、1つ以上の触覚と音声イベントの論理的なグループ化です。
         CHHapticEngine はパターンを使用してプレーヤーを作成します。
         CHHapticEventは、触覚体験を定義するために使用されるビルディングブロックです。
         Core Haptics はデータ駆動型 API であり、触覚パターンをプログラム的に、スクリプトに直接、または AHAP ファイルを活用して定義することが可能です。
         Core Hapticsのサポートをプロジェクトに追加する簡単な方法の一つは、必要なCore Hapticsオブジェクトをそれぞれ管理するHapticsコンポーネントを作成することです。
         以下は、CHHapticEngine、CHHapticPatternPlayer、AHAP Assetを含むHapticsコンポーネントの例です。
         AHAPアセットは、Core Hapticsプラグインで定義されたUnityのカスタムアセットです。
         これにより、AHAPファイルへのインポートやエクスポートが容易になり、パターン作成やカスタマイズを管理するためのカスタムエディタ拡張も可能です。
         では、詳しく見ていきましょう。
         まず、Apple.Core と Core Haptics プラグインの両方が私のプロジェクトにインストールされていることを確認します。
         これらを追加することで、ハプティクスを使ったゲームの拡張を始めることができます。
         先ほどの図を元に作成したハプティクスコンポーネントがこちらです。
         実装の確認はこれからですが、とりあえず飛行機に取り付けてみます。
        取り付けると、このコンポーネントにはAHAPアセットが必要ですが、AHAPアセットフォルダは空っぽです。
         Assets > Create > Apple > CoreHaptics > AHAP で新しいものを作成します。
         作成したら、MyHapticPatternという素敵でオリジナルな名前をつけてあげます。
         Core Hapticsプラグインには、インスペクタウィンドウで新しいパターンを調整できるエディタエクステンションが付属しています。
         ここでは、CHHapticPatternの一部である再生可能なCHHapticEventを定義します。
         デフォルトでは、transient イベントがありますが、continuous イベントも簡単に追加できます。
         また、UIには、Import、Export、Resetのボタンがある。
         Resetは、追加したイベントをクリアして、パターンをデフォルトの状態に戻す。
         ImportとExportは素晴らしい機能だ。
         これらによって、AHAPファイルをロードしたり保存したりすることができます。
         ここでは、Rumbleという定義済みのAHAPをインポートしました。これは、素敵な振動効果をトリガーするものですが、ほんの少し手を加える必要があるように思います。
         パターンを更新したので、新しいAHAPファイルにエクスポートして、この改善された触覚パターンを他のチームと共有することができます。
        アセットが作成され、調整されたので、飛行機に戻り、MyHapticPatternに向けます。
         素晴らしい これで配線は完了です。
         ハプティックパターンが定義され、適切に参照されたので、あとはハプティックパターンを再生できるように、Hapticsコンポーネントにいくつかのロジックを追加するだけです。
         これは2つのメソッドに分けることができます。PrepareHapticsとPlayです。
         PrepareHaptics はハプティックエンジンを初期化し、ハプティックパターンのプレーヤーを作成するところです。
         Playは、CHHapticPatternPlayerのstartメソッドを呼び出すだけで再生が始まります。
         そして、これがHapticsコンポーネントのスクリプトです。
         ハプティックエンジンとハプティックプレイヤーのためのフィールドが定義されています。
         重要なのは、エディタUIでAHAPアセットを設定できるようにserializeFieldアトリビュートを追加することです。
         次に、CHHapticEngine を作成し、それを起動し、参照されるアセットから直接 AHAP にアクセスして、触覚パターン プレーヤーを作成するコードを追加してください。
         もちろん、プレーヤーのStartを呼び出すと、ハプティックパターンが再生されます。
         Core Haptics Unity プラグインは、あなたのゲームに全く新しいレベルの没入感を追加するために必要なツールを提供します。
         Core Hapticsプラグインを使用して、見た目、音、感触がリアルな不思議なゲームの瞬間を作り出しましょう。
         Core Hapticsの詳細については、セッション "Introducing Core Haptics "をご覧ください。
        " 魅力的なハプティクス体験の設計の詳細については、「オーディオ・ハプティクス体験の設計」と「オーディオ・ハプティクス設計の実践」をぜひご覧ください。
        " 没入感のあるオーディオは、優れたゲーム体験の非常に重要な側面です。
         UnityプラグインのPHASEを使えば、クリエイティブな可能性を引き出し、ゲームの世界に豊かなサウンドスケープを構築することができます。
         PHASEを使用すると、複雑でダイナミックなオーディオ体験をゲームに提供できます。
         ジオメトリを考慮したオーディオとは、サウンドがシーン内のメッシュから発せられ、それと相互作用することを意味します。
         ゲーム内の環境は、残響と反射によって、よりリアルなサウンドになります。
         ゲームプレイ中にダイナミックなオーディオコントロールを可能にする階層的なオーディオグラフを構築することができます PHASEプラグインには、ゲームに対応した定義済みのコンポーネントが用意されています。
         それらをゲームオブジェクトにアタッチするだけで、一行のコードも書かずにPHASEを使い始めることができます。
         最初のコンポーネントは、PHASEListenerコンポーネントです。
         ゲームシーンの「耳」として機能し、オーディオの位置、向き、リバーブプリセットをもとに処理します。
         次に、PHASEOccluderコンポーネントです。
         PHASEOccluderは、ジオメトリデータを持つゲームオブジェクトに取り付け、シーン内のソースとリスナーの間に入ったときにオーディオを減衰させます。
         次に、PHASESourceコンポーネントです。
         これはゲームオブジェクトに取り付けられ、オブジェクトのトランスフォームを使 ってゲームワールドにサウンドを配置します。
         PHASEプラグインは、ビルトインのコンポーネントに加え、カスタムアセットである SoundEventアセットも定義しています。
         サウンドイベントは、オーディオ再生イベントを記述するオブジェクトで、シーンのソースで再生されるオーディオを定義します。
         PHASEプラグインを使い始めるには、まず、Apple.CoreとPHASEプラグインの両方がプロジェクトに追加されていることを確認することです。
         インストールが完了したら、同梱されているコンポーネントをシーンに追加していきます。
         このプロジェクトでは、飛行機、建物、カメラという3つのゲームオブジェクトがあります。
         まず、カメラにPHASEListenerコンポーネントを追加します。
         これによって、シーンに「耳」が追加されました。
         次に、PHASEOccluder コンポーネントを取り付けて、建物をオクルーダーにします。
        最後に、PHASESource コンポーネントを飛行機に追加して、シーンにソースを追加します。
         ソースを追加したので、オーディオを再生する必要があり、サウンドイベントをアタッチする必要がありますが、Sound Eventsフォルダは空っぽです。
         Assets > Create > Apple > PHASE > SoundEventで、イベントを作成します。
         サウンドイベントを作成すると、PHASEプラグインは、すぐにPHASEサウンドイベントコンポーザーウィンドウを開きます。
         これが、サウンドイベントを作成するためのキャンバスです。
         まず、ウィンドウ内の任意の場所を右クリックします。
         すると、イベントにノードを追加するためのポップアップが表示されます。
         今回はクリップを再生したいので、サンプラーノードを作成します。
         すでに、アイドリング中の飛行機のオーディオクリップをプロジェクトに追加しているので、それを参照することができます。
         ループを有効にして、飛行機がハミングし続けるようにします。
         飛行機の音を聞くには、ミキサーにルーティングする必要があります。
         イベントコンポーザーのキャンバスに出力ラインをドラッグすると、ミキサーを作成するためのオプションが表示されます。
        これでサウンドイベントが完成し、すぐに使えるようになりました。
         サウンドイベントをクリックすると、インスペクタに設定が表示されます。
         このため、サウンドイベントのコンポーザーに戻らなくても、値を調整することができます。
         サウンドイベントの作成が完了したら、先ほど飛行機に取り付けたPHASESourceコン ポーネントで参照できるようになりました。
         これで、シーン内のオーディオがルーティングされ、再生できるように設定され ました。
         PHASE Unityプラグインは、インゲームオーディオデザインの全く新しい可能性を切り開きます。
         PHASEの詳細や、今日紹介したコンセプトをより深く知りたい方は、Apple Developerドキュメントサイトや、昨年のWWDCセッションの紹介ビデオをぜひご覧ください。
         以上で、新しいApple Unityプラグインの概要を説明しました。
         今日はいろいろと説明しましたが、Apple Unityのプラグインについてもっと知りたい方は、GitHubのリポジトリから始めるのが一番です。
         各プラグインのソース、詳細なドキュメント、サンプルはここにあります。
         Unityゲームにアクセシビリティを追加する」セッションでは、Unityゲームにアクセシビリティを統合する方法について、また「Game Centerダッシュボードで新しいプレイヤーにアプローチする」では、ゲームの可視性を高める方法について、ぜひご覧ください。
         ご視聴ありがとうございました。


        """
    }
}

