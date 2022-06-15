import Foundation

struct WhatsNewInXcode: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "What's new in Xcode"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6788/6788_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/110427/")!
    }

    var english: String {
        """
        Hello, everyone.
         I'm Jonathon Mah.
         And I'm Lisa Xiao.
         And we'd love to introduce you to what's new in Xcode 14.
         Today, we'll look at new features and enhancements throughout Xcode, including source editing and SwiftUI previews, multiplatform applications, TestFlight feedback, and performance improvements.
         There's a lot to cover, so let's get to it.
         The first thing you'll notice is how much faster it is just getting started.
         Xcode 14 is 30 percent smaller.
         It downloads and installs significantly faster.
         You can download additional platforms and simulators on demand.
         If you need them immediately, you can get them here -- or later, when you first try to use them.
        We're building Food Truck, a food-delivery application.
        SwiftUI with live previews is a great workflow, and it's getting even better.
         Now the preview canvas is interactive by default, so your changes are immediately live as you make them.
         The canvas has a new control to create additional variants of each preview without writing any code.
         You can vary the color scheme, text size, or device orientation, and then immediately see your interface rendered in each scenario.
         Let's see how our view looks with different Dynamic Type sizes.
        With these previews side by side, it's easy to validate your interface and make sure things look just right.
         Let's check the larger sizes.
        The first icon is very wide and causes the text to wrap awkwardly.
         Luckily, my designer has just asked me to change it, but only in the header.
         Our CardView doesn't support a different icon for the header yet, so let's start by adding that functionality.
         I'll switch over to the implementation.
        The header and content elements are both using the same image.
         Let's add another image property specifically for the header.
        In most of the cards, using the same image in both places looks great.
         We can save ourselves the time of updating each existing call by adding a custom initializer with a default value.
        When I start to type the initializer, Xcode 14 now offers to complete the whole thing! I can accept the default value as a starting point for my customizations, saving a ton of time.
         This also works for the codable methods.
         Let's give the headerIcon parameter a default value.
        Now, we'll return to the CardStack view and use this new functionality.
        My designer asked me to use the calendar symbol here.
         The library now includes all of the SF Symbols, so it's easy to make sure I'm using the right one.
        I can press Return to insert the right code to use the symbol.
        This symbol looks great.
         The new side-by-side comparisons we get from preview variants make it easy to ensure your app looks good with all the settings your users have chosen.
         In addition to initializer and codable definitions, Xcode 14 provides more intelligent recommendations so you can write your ideas more quickly and easily.
         Let me show you some more.
        When I start to add another CardView, the initializers now appear directly in the completion list.
         The headerIcon parameter is in italic.
         That's because it has a default value.
         If I accept the completion now, it won't include the headerIcon label, it will use the default value we just added.
         Here, I want to specialize the icon again, so I can type part of the name to opt in.
        I'll give my new card some values.
        I'd like a divider before my new card.
         Adding a Divider to the VStack gives a line across the entire width.
        To make it more subtle, I'll use frame to set a maximum width.
        The frame modifier has a lot of optional arguments.
         The new completion features make it a snap to get just the arguments I need.
        That's code completion in Xcode 14.
         This first card's title comes from a method.
         I've heard it isn't handling all numbers correctly, so let's see how it's implemented.
         I'll Command-click and choose Jump to Definition.
        The redesigned definition list highlights what's different about each of the results so that you can quickly choose the one you want.
         Since our text(for:) method is from a protocol, there are multiple options.
         The list shows the specific types that define the method: we have the declaration from the protocol and two implementations.
         I'll navigate to the server-backed implementation.
        This class implements parsing using a regular expression literal, which is new in Swift 5.7.
        My coworker told me the problem is being caught by our unit tests.
         Let's run them now.
        Yep, we have some failures.
         Let's take a look.
        Something seems wrong with extracting the event count.
         Let's check how this function is called.
         I can see that directly by opening the callers of this method by Command-clicking.
         Just like the definition list, the callers list shows the different files and functions that contain calls to this method, along with a preview of each call site.
        Here's a call from the failing test method.
         The preview shows me the test is passing the string "0 records", which gives me a hint about the problem.
         And now I can spot the bug: the regular expression is matching against the digits 1-9, but I forgot to include zero! I could fix this by updating the character range to use 0-9, or switch to the more descriptive digit character class.
        Something's still not right, but now the compiler is telling me why.
         Regular expressions are a first-class feature in Swift 5.7.
         The compiler checks my regular expression like it does with other code, and Xcode highlights my typo immediately.
         Notice that when I correct the expression, two things happen: syntax highlighting in the regular expression confirms my edit, and the errors dim gray.
        This new dimming shows that Xcode is reevaluating the diagnostics.
         When I pause for a moment, the file is reprocessed and Xcode confirms the errors are resolved.
         This dimming happens during long builds as well, so you can easily tell which problems are from the latest build and which are from a previous build.
         Let's go over to the test.
        This jumped me straight to the call, which is in the middle of a test method.
         Take a look at the top of the editor.
         Xcode 14 shows the definitions containing the visible code, even when they're scrolled out of view.
        I can use the test diamonds at the top to rerun the tests.
        Fantastic, the fix passes all the tests.
         With Xcode 14, you can write code faster with new code completions, design fluidly with SwiftUI preview variants, be more informed with improved error presentation, and navigate confidently with jump to definition.
         And there's even more.
         Here's Lisa.
         Thank you, Jonathon.
         Let's take a look at the build performance improvements.
         When Xcode builds multiple targets, like a framework and application, first it compiles the framework sources.
         Then it generates a module.
         That enables linking and compiling the application sources.
         And then it links the application, completing the build.
         Xcode 14 rearranges your build for improved parallelism.
         By eagerly producing Swift modules, Xcode unblocks build tasks and increases parallelism.
         It shortens all the critical paths of your builds, all while being more respectful of your simultaneous use of the machine.
         But we didn't stop there.
         We also made the linker up to two times faster through increased parallelism.
         All together, Xcode 14 builds projects up to 25 percent faster, with machines with the most cores seeing the biggest improvements.
         Even with the improvements to build scheduling, sometimes your project can have internal dependencies on long synchronous tasks.
         It can be hard to tell this is happening without a visualization.
         Good news, we've included that in Xcode 14! You can open the new build timeline on any build log or result bundle.
         It will help you identify unexpectedly long tasks and bottlenecks.
         Here's the build timeline for Food Truck.
         I can see a script phase constraining the build to a single core.
         You can get critical insights and identify performance opportunities in your build with the new build timeline.
         You can learn all about parallelizing builds, the new build timeline.
         and linking in "Demystify parallelization in Xcode builds" and "Link Fast: Improve build and launch."
         Parallel testing in Xcode has been a great way to run your tests faster.
         In Xcode 14, it's even better.
         We used the same techniques to improve build performance that I just showed you.
         Xcode 14 eliminates scheduling dependencies between targets and test classes to increase parallelism during testing even more.
         If you have long-running tests in different test classes and targets, this feature could improve your test execution time by up to 30 percent.
         To learn about how to improve test speed and reliability, please check out "Author fast and reliable tests for Xcode Cloud."
         Building is faster, testing is faster, and preparing your macOS app for distribution is faster too.
         We have sped up notarization by four times in Xcode 14.
         For projects using Interface Builder, I have more good news! Document loading is up to 50 percent faster, and switching between iPhones and iPads in the device bar is up to 30 percent faster.
         Canvas editing operations are incremental and prioritize the scenes you're looking at so that it gives you immediate feedback, even in large storyboards.
         Xcode 14 is faster, and it's easier to use, too.
         Let me show you how.
         Xcode 14 makes it easy to bring your app to different platforms.
         You can use a single target to define your app, and list what platforms you support.
         This eliminates the need to keep settings and files in sync, so you only have to describe what's unique on each platform.
         Check out "Use Xcode to build a multiplatform app" to take advantage of this feature in your project.
         Xcode also has great tools for making your app smaller.
         The memory debugger has always been great for exploring leaks in your application.
         It zeros in on the shortest paths from root objects to unexpectedly live objects so that you can investigate why they've leaked.
         Xcode 14 expands these capabilities so that you can see all reference paths in and out of an object.
         In addition to a more thorough explanation of leaks, now you can gauge the total weight of your objects.
         In Xcode 14, you can also extend Xcode itself with Swift Package plugins.
         Now packages can integrate plugins that process your code in place, like linters and formatters, and you can invoke them directly from the project navigator.
         You can also integrate build tools that generate code or process resources while building.
         For example, you could translate a high-level description of a remote procedure call interface into low-level glue code during the build.
         You could also compress or optimize resources while building.
         For an in-depth look at package plugins, check out "Meet Swift Package plugins" and "Create Swift Package plugins."
         You can also localize package resources just like applications.
         Now you can set your package's default localization, export the localization catalog, translate it, and reimport it.
         To learn more about localization, check out "Building global apps: Localization by example."
         Next, let's move on to the run destination chooser.
         Switching between devices is something I do all the time, and now it's even easier to get the device you need with the updated run destination chooser.
         Let's take a look.
        When you open the run destination chooser, it shows all the available run destinations for the selected scheme.
         I often switch between an iPhone and an iPad.
         The new run destination chooser prioritizes recent choices, which makes this really convenient.
         It's also easy to select other devices that I haven't used lately.
         I can filter the list here, and type "max" to bring all the Max devices together and easily pick the one I want.
         These same features are all available in the Scheme chooser, too.
         Next, let's take a look at the Organizer window.
         We've made some great improvements to the Organizer to help you identify new issues and improve your apps.
         There are two new reports in the Organizer to help you understand how your app is doing on your users' devices: Feedback and Hangs.
         Let's dive in.
        The Feedback organizer shows all of your TestFlight feedback directly in Xcode.
         Our TestFlight users sent great comments and screenshots for our recent builds.
         The inspector shows additional details -- like tester information and the device configuration -- that can help to identify the underlying problems.
         If I need a bit more context, I can email my tester directly with this button.
         TestFlight feedback is from beta users, but there are some issues that can slip past testing and make it into the App Store.
         One of the most common types of bugs like this are hangs.
         Your app hangs when it uses the main thread without taking a break to process user input.
         Your code might be doing important work, but the user experiences an unresponsive app.
         This new Hangs report shows the highest-impact hangs from App Store users so that you know which code to restructure to have the biggest impact.
         On the left, there's a list of hangs ordered by severity.
         Each one has a weighted backtrace showing the problematic code.
         Our app supports many devices and OS versions.
         Some hangs impact certain configurations more than others.
         In the inspector, it is helpful to find that this hang happens mainly on iOS 15.3.
         When I'm ready to work on this, I can jump straight into the code with this Open in Project button.
         The new Hangs and Feedback reports help you triage issues and get the right fixes to users quickly.
         To learn more about fixing hangs, check out "Track down hangs with Xcode and on-device detection."
         Next, let's take a look at icons.
         Our app icon looks great at every size, because we've taken the time to pixel hint and to choose the right number of stripes for every resolution so that it always looks crisp.
         All of this pixel hinting can be totally essential for some icons and unnecessary for others.
         Now we have a new icon.
         Let's take a look at it.
         These simpler textures don't need any hinting, and will look great drawn at any size.
         With a double click, I can select the new image.
         In Xcode 14, you can choose the level of detail that's right for you.
         For this icon, our single image looks great.
         I'll use the new Single Size feature to tell Xcode to automatically create all of our different sizes from this one.
         To do that, I can select Single Size in the inspector.
         And that's it! That was a brief overview of what's new in Xcode 14.
         It is faster and easier to help you develop.
         Thank you for watching! Jonathan: Go download it and get started today!

        """
    }

    var japanese: String {
        """
        みなさん、こんにちは。
         私はJonathon Mahです。
         そして私はLisa Xiaoです。
         そして、Xcode 14の新機能を紹介したいと思います。
         今日は、ソース編集と SwiftUI プレビュー、マルチプラットフォームアプリケーション、TestFlight のフィードバック、そしてパフォーマンスの改善など、Xcode 全体の新機能と強化点を見ていきましょう。
         カバーすることがたくさんあるので、それに取り掛かりましょう。
         まず最初に気づくのは、使い始めるだけでどれだけ速くなったかということでしょう。
         Xcode 14は、30%小さくなっています。
         ダウンロードとインストールも大幅に高速化されています。
         追加のプラットフォームやシミュレータをオンデマンドでダウンロードすることも可能です。
         すぐに必要な場合は、ここで入手できますし、後で初めて使おうとするときにも入手できます。
        私たちは、フードデリバリーのアプリケーションであるFood Truckを作っています。
        ライブプレビューを備えたSwiftUIは素晴らしいワークフローですが、さらに良くなっています。
         現在、プレビューキャンバスはデフォルトでインタラクティブになっているので、変更を加えるとすぐにライブになります。
         キャンバスには新しいコントロールがあり、コードを書かずに各プレビューのバリエーションを追加で作成できます。
         配色、テキスト サイズ、デバイスの向きを変更し、各シナリオでレンダリングされたインターフェイスをすぐに確認することができます。
         Dynamic Typeのサイズを変えて、ビューがどのように見えるか見てみましょう。
        このようにプレビューを並べて表示することで、インターフェイスを簡単に検証し、適切な表示を確認することができます。
         大きいサイズを確認してみましょう。
        最初のアイコンは幅が広いので、テキストが不格好に折り返されてしまいます。
         幸いなことに、デザイナーからヘッダーのみ変更するように言われたところです。
         私たちのCardViewはまだヘッダーの別のアイコンをサポートしていないので、その機能を追加するところから始めましょう。
         実装に切り替えてみます。
        header要素とcontent要素で同じ画像を使用しています。
         ヘッダー専用の画像プロパティをもうひとつ追加してみましょう。
        ほとんどのカードでは、両方で同じ画像を使うと見栄えがします。
         デフォルト値を持つカスタムのイニシャライザーを追加することで、既存の各呼び出しを更新する手間を省くことができます。
        イニシャライザーを入力し始めると、Xcode 14は全体を完成させることを提案してくれるようになったのです! 私は、カスタマイズの出発点としてデフォルト値を受け入れることができ、膨大な時間を節約することができます。
         これは、コード化可能なメソッドにも当てはまります。
         headerIconパラメータにデフォルト値を与えてみましょう。
        さて、CardStack ビューに戻り、この新しい機能を使ってみましょう。
        デザイナーは、ここでカレンダーのシンボルを使うようにと言いました。
         ライブラリにはすべてのSFシンボルが含まれているので、正しいシンボルを使っているかどうかを確認するのは簡単です。
        シンボルを使うための正しいコードを挿入するために、リターンキーを押すことができます。
        このシンボルはとてもいい感じです。
         プレビューバリアントから得られる新しいサイドバイサイドの比較により、ユーザーが選択したすべての設定でアプリの見栄えをよくすることが簡単にできます。
         イニシャライザおよびコード化可能な定義に加えて、Xcode 14は、よりインテリジェントな推奨を提供するので、あなたのアイデアをより迅速かつ容易に書くことができます。
         もう少しお見せしましょう。
        別のCardViewの追加を始めると、初期化子が補完リストに直接表示されるようになりました。
         headerIconパラメータはイタリック体で表示されています。
         これはデフォルトの値を持っているからです。
         もし今完成を受け入れると、headerIconラベルは含まれず、先ほど追加したデフォルト値が使われます。
         ここで、アイコンをもう一度特殊化し、名前の一部を入力してオプトインできるようにしたいと思います。
        新しいカードにいくつか値を与えてみる。
        新しいカードの前に仕切りが欲しいですね。
         VStackにDividerを追加すると、横幅全体に線が入ります。
        もっと微妙にするために、frameを使って最大幅を設定します。
        frameモディファイアは、オプションの引数がたくさんあります。
         新しい補完機能を使えば、必要な引数だけを簡単に取得することができます。
        これがXcode 14のコード補完機能です。
         この1枚目のカードのタイトルは、あるメソッドからきています。
         すべての数字を正しく処理できていないそうなので、どのように実装されているか見てみましょう。
         Command-clickして、Jump to Definitionを選んでみます。
        再設計された定義リストでは、それぞれの結果について何が違うのかが強調されているので、目的のものをすぐに選択することができます。
         今回のtext(for:)メソッドはプロトコルのものなので、複数のオプションがあります。
         リストには、このメソッドを定義している特定の型が表示されます。プロトコルからの宣言と、2つの実装があります。
         ここでは、サーバーにバックアップされた実装に移動します。
        このクラスは、Swift 5 で新しく導入された正規表現リテラルを使用してパージングを実装しています。 7.
        同僚は、問題がユニットテストによって捕捉されていると教えてくれました。
         今すぐ実行してみましょう。
        はい、いくつか失敗があります。
         見てみましょう。
        イベントカウントの抽出に何か問題があるようです。
         この関数がどのように呼び出されるかを確認してみましょう。
         このメソッドの呼び出し元をCommand-clickで開くと、直接見ることができますね。
         定義リストと同様に、呼び出し元リストには、このメソッドの呼び出しを含むさまざまなファイルや関数が、各呼び出し場所のプレビューとともに表示されます。
        ここでは、失敗したテストメソッドからの呼び出しを示しています。
         プレビューを見ると、テストは「0 records」という文字列を渡していることがわかりますが、これが問題のヒントになります。
         正規表現は1-9の数字に対してマッチングしますが、0を含めるのを忘れていました。文字範囲を更新して0-9を使用するか、よりわかりやすい数字文字クラスに切り替えることで修正できました。
        それでもまだ何かおかしいが、今度はコンパイラがその理由を教えてくれる。
         正規表現は Swift 5.7 のファーストクラスの機能です。
         コンパイラは、他のコードで行うように私の正規表現をチェックし、Xcodeはすぐに私のタイプミスをハイライトします。
         私が式を修正するとき、2つのことが起こることに注意してください：正規表現のシンタックスハイライトは、私の編集を確認し、エラーは灰色に薄暗くなります。
        この新しい薄暗がりは、Xcodeが診断を再評価していることを示しています。
         私が一時停止すると、ファイルは再処理され、Xcodeはエラーが解決されたことを確認する。
         この減光は長いビルドの間にも起こるので、どの問題が最新のビルドによるもので、どれが以前のビルドによるものか、簡単に見分けることができるのです。
         テストに移ってみましょう。
        これは、テストメソッドの途中にある呼び出しに直接ジャンプしました。
         エディタの一番上を見てください。
         Xcode 14では、目に見えるコードを含む定義が、スクロールして表示されないときでも表示されます。
        私は、一番上にあるテストダイアモンドを使って、テストを再実行することができます。
        素晴らしいことに、この修正はすべてのテストに合格しています。
         Xcode 14では、新しいコード補完機能でより速くコードを書き、SwiftUIプレビューバリアントで流動的にデザインし、改善されたエラー表示でより多くの情報を入手し、定義へのジャンプで自信を持ってナビゲートすることができます。
         そして、さらに多くのことがあります。
         リサがいます。
         Jonathon、ありがとうございます。
         ビルドパフォーマンスの改善を見てみましょう。
         Xcodeがフレームワークとアプリケーションのような複数のターゲットをビルドするとき、まず、フレームワークのソースをコンパイルします。
         それから、モジュールを生成します。
         これにより、アプリケーションのソースをリンクし、コンパイルすることができます。
         そして、アプリケーションをリンクし、ビルドを完了します。
         Xcode 14は、並列性を向上させるためにビルドを再編成します。
         Swiftのモジュールを熱心に生成することで、Xcodeはビルドタスクのブロックを解除し、並列性を向上させます。
         それは、マシンの同時使用をより尊重しながら、あなたのビルドのすべてのクリティカルパスを短縮します。
         しかし、私たちはそれだけにとどまりません。
         並列処理を強化することで、リンカーも最大で2倍高速化しました。
         Xcode 14では、全体としてプロジェクトのビルドが最大25%高速化され、最も多くのコアを搭載したマシンで最大の改善が見られます。
         ビルドスケジューリングが改善されても、プロジェクトに長い同期タスクの内部依存がある場合があります。
         このような場合、可視化しないとわからないことがあります。
         朗報です、私たちはXcode 14にそれを含めました! あなたは、任意のビルドログまたは結果バンドル上で新しいビルドタイムラインを開くことができます。
         これは、予想外に長いタスクやボトルネックを特定するのに役立ちます。
         これは、Food Truckのビルドタイムラインです。
         ビルドをシングルコアに制限しているスクリプトフェーズが見えます。
         新しいビルドタイムラインを使用して、ビルドにおける重要な洞察を得たり、パフォーマンスの機会を特定したりすることができます。
         ビルドの並列化、新しいビルドタイムラインのすべてを学ぶことができます。
         とリンクについては、"Demystify parallelization in Xcode builds" と "Link Fast: Improve build and launch" で学ぶことができます。
         Xcodeの並列テストは、テストをより速く実行するための素晴らしい方法でした。
         Xcode 14では、それがさらに良くなっています。
         先ほどお見せしたビルドのパフォーマンスを向上させるのと同じテクニックを使いました。
         Xcode 14では、ターゲットとテストクラス間のスケジューリング依存性を排除し、テスト中の並列性をさらに向上させました。
         異なるテストクラスとターゲットで長時間実行されるテストがある場合、この機能によりテストの実行時間を最大30%改善することができます。
         テストの速度と信頼性を向上させる方法については、"Author fast and reliable tests for Xcode Cloud "をご覧ください。
         ビルドはより速く、テストはより速く、そして配布用のmacOSアプリの準備もより速くなります。
         私たちは、Xcode 14で公証を4倍スピードアップさせました。
         Interface Builderを使用するプロジェクトには、さらに良い知らせがあります。ドキュメントの読み込みが最大50パーセント速くなり、デバイスバーでのiPhoneとiPadの切り替えが最大30パーセント速くなりました。
         キャンバスの編集操作はインクリメンタルで、見ているシーンに優先順位をつけるので、大きなストーリーボードでもすぐにフィードバックが得られます。
         Xcode 14は、より高速で、より使いやすくなっています。
         その方法をお見せしましょう。
         Xcode 14では、あなたのアプリケーションをさまざまなプラットフォームに簡単に対応させることができます。
         1つのターゲットでアプリを定義し、どのプラットフォームをサポートするかをリストアップできます。
         これにより、設定やファイルを同期しておく必要がなくなり、各プラットフォームで固有のものを記述するだけでよくなります。
         この機能をプロジェクトで活用するには、「Xcodeを使ってマルチプラットフォームアプリを構築する」をご覧ください。
         Xcodeには、アプリを小さくするための素晴らしいツールもあります。
         メモリデバッガは、常にアプリケーションのリークを調査するのに適しています。
         それは、ルートオブジェクトから予期しないライブオブジェクトへの最短経路にゼロを設定し、それらがリークした理由を調査することができます。
         Xcode 14では、これらの機能が拡張され、オブジェクトの出入りのすべての参照パスを見ることができるようになりました。
         リークのより詳細な説明に加えて、今、あなたはあなたのオブジェクトの総重量を測定することができます。
         Xcode 14では、SwiftパッケージプラグインでXcode自体を拡張することもできます。
         今、パッケージは、リンターやフォーマッタのように、あなたのコードをその場で処理するプラグインを統合することができ、あなたはプロジェクトナビゲータから直接それらを呼び出すことができます。
         また、ビルド中にコードを生成したり、リソースを処理するビルドツールを統合することができます。
         例えば、リモートプロシージャコールインターフェースの高レベルな記述を、ビルド中に低レベルのグルーコードに変換することができます。
         また、ビルド中にリソースを圧縮したり最適化したりすることもできる。
         パッケージプラグインの詳細については、"Swift パッケージプラグインの紹介 "と "Swift パッケージプラグインの作成 "を確認してください。
         また、アプリケーションと同じようにパッケージリソースをローカライズすることができます。
         これで、パッケージのデフォルトのローカライズを設定し、ローカライズカタログをエクスポートし、翻訳し、再インポートすることができるようになりました。
         ローカライゼーションについてより詳しく知りたい方は、「Building global apps: 例によるローカライゼーション" をご覧ください。
         次に、実行先選択ツールに移りましょう。
         デバイスの切り替えは、私がいつも行っていることですが、アップデートされた実行先選択ツールにより、必要なデバイスをより簡単に入手できるようになりました。
         さっそく見てみましょう。
        実行先選択ツールを開くと、選択したスキームで利用可能な実行先がすべて表示されます。
         私はよくiPhoneとiPadを切り替えて使っています。
         新しい実行先選択ツールは、最近選択したものを優先的に表示するようになっているので、とても便利です。
         また、最近使っていないデバイスを選択するのも簡単です。
         ここでリストを絞り込み、"max "と入力すれば、Maxデバイスをすべてまとめて、簡単に選ぶことができるんです。
         これらの機能は、Scheme Chooserでも同じように利用することができます。
         次に、オーガナイザーウィンドウを見てみましょう。
         オーガナイザーには、新しい問題を発見し、アプリを改善するのに役立つ、いくつかの素晴らしい改良が加えられています。
         Organizer には、ユーザーのデバイスでアプリがどのように動作しているかを理解するのに役立つ 2 つの新しいレポートがあります。フィードバック」と「ハングアップ」です。
         さっそく見てみましょう。
        フィードバックオーガナイザは、TestFlight のすべてのフィードバックを Xcode で直接表示します。
         TestFlightのユーザーは、最近のビルドに対して素晴らしいコメントとスクリーンショットを送ってくれました。
         インスペクタには、テスター情報やデバイス構成など、根本的な問題を特定するのに役立つ詳細が表示されます。
         もう少し詳しい情報が必要な場合は、このボタンを使ってテスターに直接メールを送ることができます。
         TestFlightのフィードバックはベータユーザからのものですが、テストを通過してApp Storeに載る問題もあります。
         このようなバグの最も一般的な種類の1つは、ハングアップです。
         ユーザーの入力を処理するために休憩を取らずにメインスレッドを使用すると、アプリがハングします。
         コードは重要な作業を行っているかもしれませんが、ユーザーは反応しないアプリを体験します。
         この新しいハングレポートでは、App Storeユーザーから寄せられたハングのうち、最も影響の大きいものが表示され、どのコードを再構築すれば最大の効果が得られるかがわかります。
         左側には、深刻度順にハングアップのリストが表示されます。
         それぞれのハングには、問題のあるコードを示す重み付けされたバックトレースが表示されます。
         私たちのアプリは、多くのデバイスと OS バージョンをサポートしています。
         一部のハングは、特定の構成に他のものより大きな影響を与えます。
         インスペクターでは、このハングは主にiOS 15.3で発生することがわかり、役に立ちました。
         この問題に取り組む準備ができたら、この「プロジェクトで開く」ボタンでコードに直接ジャンプできます。
         新しいハングとフィードバックのレポートは、問題をトリアージして、正しい修正をユーザーに迅速に提供するのに役立ちます。
         ハングアップの修正について詳しくは、「Xcodeとデバイス上の検出を使用してハングアップを追跡する」を参照してください。
         次に、アイコンについて見てみましょう。
         このアプリのアイコンは、どのサイズでも美しく見えます。これは、ピクセルヒンティングに時間をかけ、すべての解像度に対して適切な数のストライプを選択し、常に鮮明に見えるようにしたためです。
         このようなピクセルヒンティングは、あるアイコンにとっては完全に必要なものですが、別のアイコンにとっては不要なものです。
         さて、新しいアイコンができました。
         見てみましょう。
         このようなシンプルなテクスチャはヒンティングを必要としないので、どのようなサイズでも見栄えよく描画されます。
         ダブルクリックで、新しい画像を選択することができますね。
         Xcode 14では、自分に合った詳細度を選択することができます。
         このアイコンには、単一の画像がよく似合います。
         新しいシングルサイズ機能を使って、Xcodeに、この1つの画像から異なるサイズの画像をすべて自動的に作成するように指示します。
         そのためには、インスペクタで「Single Size」を選択します。
         以上です。以上が、Xcode 14の新機能の概要でした。
         より速く、より簡単に、あなたの開発をサポートします。
         ご覧いただき、ありがとうございました ジョナサン ダウンロードして、今日から始めましょう

        """
    }
}

