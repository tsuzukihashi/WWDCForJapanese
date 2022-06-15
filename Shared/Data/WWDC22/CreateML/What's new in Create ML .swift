import Foundation

struct WhatsNewInCreateML: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "What's new in Create ML"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6684/6684_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/110332/")!
    }

    var english: String {
        """
        Namaskar! Hello and welcome to WWDC22.
         My name is Vrushali Mundhe, engineer on the Create ML team, and I am excited to share with you what's new in Create ML.
         Create ML allows you to easily train powerful machine learning models with data you have collected to deliver unique experiences and enhance your apps.
         Create ML ships as an app bundled with Xcode, letting you quickly build and train Core ML models right on your Mac with no code.
         Create ML is also available as a Swift framework shipping in SDK.
         Using its APIs, you can easily automate model creation or create dynamic experiences powered by training directly from within your own app.
         To learn more about Create ML's core capabilities, you can check out these previous sessions.
         In this session, we'll talk about what's new in Create ML.
         We will start with new features in the Create ML app that can help evaluate the accuracy and utility of your models.
         We will then turn our attention to the Create ML framework, its extended capabilities, and ability to now highly customize models for your own app.
         Let's start by reviewing a typical workflow for model creation.
         Given an identified task, you begin by collecting and annotating data.
         Take, for example, wanting to visually identify groceries.
         For this image classification task, your starting point would be collecting and labeling images; here, some fruits and vegetables.
        Create ML will then help you train a model from this data, which can be used in your app.
         However, before using this model, an important step is to evaluate how well it performs; here, seeing how accurate the model is on images, which were not part of the training set.
         Depending on evaluation, you may iterate on the model with additional data and modified training settings or, once the model is performing well enough, you're ready to integrate it into your app, I would like to focus on this evaluation step further.
         When performing an evaluation, we often turn to a set of metrics measured by testing your model on new data held out from training.
         You may start by looking at a top-level accuracy metric or dive into per-class statistics to get a general sense of the model's behavior and ability to generalize beyond what it was trained on.
         Ultimately, the model will be responsible for empowering data-driven experience in your app, and during evaluation, you want to identify the model's main strengths and weaknesses in terms of categories of inputs or scenarios; it works well or may fall short of expectations.
         There are new features in the Create ML app that can help you on this part of your model-creation journey.
         Let me show you a project that I'm working on.
         Here, I have a project set up to create a model to identify groceries.
         I started with collecting various fruit and vegetable images as my training data and labeled them appropriately.
         Here are my different classes and number of images for each class.
        I have already trained my image classifier for 25 iterations.
         Next, when I click on the Evaluation tab, I can add new test data -- a set of images apart from training data that I had set aside for testing.
        I will next click Evaluate to begin testing.
         After it finishes evaluation, the UI provides details of the results.
         On the top, there is a high-level summary section which gives a quick sense of test accuracy.
         Here, the accuracy of this test data is 89 percent.
         Below in this Metrics tab, a table provides a wealth of metrics for each class.
         You can adjust what is shown here using these drop-down menus and add additional metrics like false positive and false negative.
         Let's review one of these classes.
         How about Tomato? The model classified 29 of the 32 tomato images correctly.
         It also shows the precision for this class is 91 percent, which means nine percent of the time the model says something is a tomato, it is incorrect.
         While these numbers and statistics are super useful, it's sometimes even more important to look at them in the context of the data itself.
         When I click the precision, it takes me to the images that were incorrectly classified as tomato.
         Here are three of these cases in the test data.
         For each image, the app displays its thumbnail, the class the model has predicted, and the true label below it.
         In this first example, while the model classified this as Tomato, it was labeled as Potato.
         But this sure appears to be a tomato to me.
         This seems like a case of a mislabeled test data.
         In fact, all three of these examples seem to be mislabeled.
         This should be easy to address.
         I'll make a note to double-check and revisit my test-set labeling.
         This was clearly an error on my part, but is it the only source of error? I got here by exploring the metrics on a random class of my choice.
         You may wonder, "Where should I start?" Or, "What should I explore next?" The top-level summary section is here to help you out.
         The app has selected some of the most important evaluation details that can serve as a great place to start your exploration.
         Let me restart from the top and review the successful cases.
         Clicking here, this correct count...
         Here, we can get a quick glance of all the 162 images the model correctly classified.
         Next, let me contrast this with a review of all the failures by clicking on the incorrect.
         There are 21 failures in total.
        Here is that mislabeled tomato again.
         Let me check if there are any other types of errors that can stand out.
         How about...this one? This image is labeled as Carrot, but the model predicts as Potato.
         It's hard to tell in this small thumbnail, but let's confirm by clicking on this image to get a better view.
         Well, this looks like a foot to me.
         This clearly is not a long, skinny carrot shape I'm used to but can be easily confused as a potato.
         Perhaps I should consider adding more shape variations to my training data for carrots.
         Let me make a note of this as well.
         This time, I will click on the arrow next to the filename to bring me to this image in the Finder.
        I will right-click and label this as red, as reminder of it being something I want to revisit in my next round of data collection.
         Let me continue my exploration from within this expanded view.
         Note that this view also shows full prediction results, listing the model's confidence in every class.
         It also lets me navigate through examples using these left and right arrows.
         I'll move to another example from here.
         This is an interesting case.
         It has multiple vegetables in a single image.
         It says it's an eggplant and it's true that there are eggplants here but other things as well.
         I need to think about whether this is an important use case for me to consider in my app.
         Perhaps the UI can guide my users to make sure they only point to one type of grocery at a time, or if I want to support multiple types, I may want to consider using an object detector -- another template in the app -- rather than the whole image classifier.
         Coming back to the summary section, let me check out this line about the top confusion.
         Here it says it's 'Pepper' as 'Bean'.
         Let's click to explore this case.
         Four images labeled as peppers are incorrectly classified as beans.
         These look like spicy peppers to me, but I guess they are green like beans as well.
         I wonder if the model is having trouble with peppers in general.
         Let me switch this query option from Incorrect to Correct.
        .....to contrast these failures to correctly classified peppers.
         It correctly classified 32 images; however, I do notice that most of these are bell peppers.
         I should check my training data to make sure I have a good representation of multiple peppers as well.
         This quick exploration was a great reminder of how important the quantity, quality, and variety of training and test data are for machine learning.
         In a matter of a few minutes, the app helped me visually identify some issues with labeling and representation.
         I need to make some tweaks to my training data and see if it fixes the issues we saw.
         It also revealed something I hadn't considered before: what happens if a user captures multiple vegetables in a single photo? I need to think about my app design some more.
         All of this exploration was possible because I had a collection of labeled data to evaluate.
         But what if I have unlabeled examples I want to quickly test, or consider whether or not I should explore more camera angles or lighting conditions? Here is where the Preview tab can help.
         I can drag a few examples my colleague just sent to me here and see how well it does.
        Or I can even test this live, using my iPhone as the Continuity Camera.
        As I point to these actual vegetables, the model is able to correctly classify them live.
         Here, this is a pepper and a tomato.
         To recap, you can now dive deeper into a trained model's behavior on any labeled dataset.
         The Evaluation pane provides a detailed metric summary with its extended options.
         A new Explore tab provides options which lets you filter and visualize the test evaluation results along with the associated data in a new interactive UI, currently available for image classifier, hand pose classifier, and object detection templates.
         Live preview enables immediate feedback.
         It's expanded to image classifier, hand action classifier, and body action classifier templates.
         We have also extended the feature to allow you to select from any attached webcam and we also support Continuity Cameras on macOS Ventura.
         That's a quick summary of what's new in the Create ML app.
         Let's shift over to discuss what's new in the Create ML framework.
        The Create ML framework is available on macOS, iOS, and iPadOS.
         This year, we are expanding some of its support to tvOS 16.
         The programmatic interface not only lets you automate model creation at development time but also opens up many opportunities to build dynamic features that learn directly from users' input or on-device behavior, providing personalized and adaptive experiences while preserving user privacy.
         Note that task support does differ per platform.
         For example, while tabular classifiers and regressors are available everywhere, some of the tasks with larger data and computation requirements, such as those involving video, require macOS.
         One common question you may have is, "What if I can't map my idea into one of these Create ML's predefined tasks?" To help answer this question, we are introducing a new member to the Create ML family: Create ML Components.
         Create ML Components exposes the underlying building blocks of Create ML.
         It allows you to combine them together to create pipelines and models customized to your use case.
         I highly recommend you checking out these sessions to learn more.
         In "Get to know Create ML Components," you will learn about the building blocks and how they can be composed together.
         In "Compose advanced models with Create ML Components," you dive deeper into using async temporal components and customizing training.
         There are endless capabilities; let me showcase one that I am personally excited about: action repetition counting.
         When I am not working, most likely you'll find me dancing.
         I'm a professionally trained Indian classical dance Kathak artist.
         To improve my form, I often rely on repeatedly practicing my routines.
         As a choreographer/teacher, I would like my performers to practice steps for certain counts and submit them to me.
         The new repetition counting capabilities in Create ML can help me actually do that! Here, this a chakkar -- twirl -- an integral part of Kathak dance.
        I would like to practice this for certain counts daily to build my form and my stamina.
         I have an iOS app built using Create ML that counts my moves.
         Let's try it in action.
        As I take my chakkars, the count increases to correspond to it.
         Here, I have done five chakkars, and the count reflects exactly that.
         Next, let's try a different small routine that consist of right- and left-side movements.
         The counter counts them as one.
        Here, the count shows three.
         Let me try another quick one-side arm movement.
        That's four.
         When combined with Action Classification, this will allow you to count and categorize repetitive actions at the same time.
         Repetition counting is available as a runtime API.
         It requires no training data, and adding this functionality to your app can be just a few lines of code.
         Its implementation is based on a pretrained model designed to be class-agnostic.
         Meaning, while it works on fitness or dance actions, such as jumping jacks, squats, twirls, chakkars, it's also applicable to a wide variety of full-body repetitive actions.
         You can find out more about this model and potential use case by checking out the sample code and the article linked to this session.
         So that's a quick overview of what's new in Create ML.
         Interactive evaluation and live previews in the Create ML app lets you dive deeper into understanding the models you train.
         The Create ML framework adds tvOS support, repetition counting, and has expanded to give you access to a rich set of underlying components to help you build models highly customized to your app needs.
         Thank you, and I hope you enjoyed all these exciting new features, and we can't wait to see what you do with them!
        """
    }

    var japanese: String {
        """
        ナマスカー! こんにちは、そしてWWDC22へようこそ。
         Create MLチームのエンジニア、Vrushali Mundheと申します。
         Create MLでは、収集したデータを使って強力な機械学習モデルを簡単にトレーニングし、ユニークな体験を提供したり、アプリを強化したりすることができます。
         Create MLはXcodeにバンドルされたアプリケーションとして出荷されており、Mac上でコードを書かずにCore MLモデルをすばやく構築してトレーニングすることができます。
         Create MLは、SwiftフレームワークとしてSDKで提供されることもあります。
         Create MLのAPIを使用すると、モデルの作成を簡単に自動化したり、独自のアプリケーション内から直接トレーニングによって動的な体験を作成したりすることができます。
         Create MLの中核的な機能の詳細については、過去のセッションをご覧ください。
         このセッションでは、Create MLの新機能についてお話します。
         まず、モデルの精度と実用性を評価するのに役立つCreate MLアプリの新機能について説明します。
         その後、Create MLフレームワークとその拡張機能、そして自分のアプリ用にモデルを高度にカスタマイズする機能に注目します。
         まず、モデル作成の典型的なワークフローを確認することから始めましょう。
         タスクが特定されたら、まずデータを収集し、アノテーションを付けることから始めます。
         例えば、食料品を視覚的に識別することを考えます。
         この画像分類タスクでは、まず画像を収集し、ラベル付けします。
        Create MLは、このデータからモデルを学習させ、アプリで使用することができます。
         ただし、このモデルを使用する前に、重要なステップとして、モデルのパフォーマンスを評価する必要があります。ここでは、トレーニングセットに含まれていない画像でモデルがどの程度正確であるかを確認します。
         評価によっては、データを追加して学習設定を変更し、モデルを繰り返し使用することもできますし、モデルが十分に機能するようになれば、アプリに組み込むこともできます。
         評価を行う際、私たちはしばしば、トレーニングから持ち出された新しいデータでモデルをテストすることによって測定される一連のメトリクスに注目します。
         トップレベルの精度指標を見ることから始めてもよいし、クラスごとの統計に飛び込んで、モデルの挙動や、トレーニングしたデータ以外のものを一般化する能力について、一般的な感覚を得ることもできます。
         最終的にモデルは、アプリのデータ駆動型エクスペリエンスを強化する役割を果たします。評価時には、入力のカテゴリまたはシナリオの観点から、モデルの主な長所と短所を特定したいと思います。
         Create MLアプリには、このようなモデル作成に役立つ新機能があります。
         私が取り組んでいるプロジェクトをお見せしましょう。
         ここでは、食料品を識別するモデルを作成するプロジェクトを立ち上げています。
         まず、学習データとして様々な果物や野菜の画像を収集し、適切なラベルを付けました。
         以下は、異なるクラスと各クラスの画像数です。
        画像分類器を25回繰り返し学習させました。
         次に、Evaluation タブをクリックすると、新しいテストデータ（トレーニングデータとは別にテスト用に用意した画像群）を追加することができます。
        次にEvaluateをクリックし、テストを開始します。
         評価が終わると、UIに結果の詳細が表示されます。
         上部には、テストの精度を簡単に知ることができるハイレベルなサマリーセクションがあります。
         ここでは、このテストデータの精度は 89% です。
         このメトリックス・タブの下には、各クラスの豊富なメトリックスが表で表示されます。
         ドロップダウンメニューで表示内容を調整したり、偽陽性や偽陰性のような追加メトリクスを追加することができます。
         これらのクラスの1つを確認してみましょう。
         Tomatoはどうでしょうか？このモデルは32枚のトマト画像のうち29枚を正しく分類しています。
         また、このクラスの精度は91パーセントで、モデルが何かをトマトだと言ったときの9パーセントが誤りであることを意味します。
         このような数値や統計は非常に有用ですが、データそのものの文脈で見ることがより重要な場合があります。
         精度をクリックすると、間違ってトマトと分類された画像に移動します。
         テストデータでは、このようなケースが3つあります。
         それぞれの画像について、サムネイル、モデルが予測したクラス、そしてその下に真のラベルが表示されます。
         最初の例では、モデルはこれをトマトと分類しましたが、ポテトとラベル付けされました。
         しかし、私にはこれがトマトに見えるのです。
         これは、テストデータが誤ってラベル付けされたケースと思われます。
         実際、この3つの例はすべてラベル付けが誤っているようです。
         これは簡単に対処できるはずです。
         テストセットのラベル付けを再確認し、見直すようメモしておきます。
         これは明らかに私のミスですが、エラーの原因はこれだけなのでしょうか？私は、ランダムに選んだクラスでメトリクスを調べることで、ここにたどり着きました。
         どこから始めればいいのだろう？あるいは、"次に何を探索すべきか?" と思うかもしれません。そんなあなたのために、トップレベルのサマリーセクションが用意されています。
        このアプリでは、探索のきっかけとなるような、重要な評価内容を厳選しました。
        上から順に再スタートして、成功事例を確認していきましょう。
        ここをクリックすると、この正解数...
        ここでは、モデルが正しく分類した162枚の画像をざっと見ることができます。
        次に、不正解をクリックして、すべての失敗をレビューしてみます。
        失敗した画像は全部で21枚です。
        また、トマトのラベルを間違えています。
        他にも目立つような間違いはないでしょうか。
        これは...どうでしょう？この画像はCarrotとラベル付けされていますが、モデルではPotatoと予測されています。
        この小さなサムネイルではわかりにくいのですが、この画像をクリックしてよく見て確認してみましょう。
        なるほど、これは足のように見えますね。
        これは明らかに、私が慣れ親しんだ細長いニンジンの形ではなく、ジャガイモと混同しやすいのです。
        ニンジンの学習データに、もっと形状のバリエーションを増やすことを検討すべきかもしれませんね。
        これもメモしておこう。
        今回は、ファイル名の横にある矢印をクリックして、Finderでこの画像を表示させます。
        右クリックで赤のラベルを付けて、次回のデータ収集の際に再確認したいと思います。
        この拡大表示から探索を続けてみましょう。
        このビューには、予測結果がすべて表示され、すべてのクラスにおけるモデルの信頼度がリストアップされていることに注意してください。
        また、この左右の矢印を使って、例題をナビゲートすることができます。
        ここから別の例題に移ります。
        これは面白いケースです。
        1つの画像に複数の野菜が写っています。
        ナスと書いてありますが、確かにナスもありますし、他のものもあります。
        これは、私のアプリで考慮すべき重要なユースケースなのかどうか、考える必要があります。
        おそらくUIは、一度に1種類の食料品だけを指すようにユーザーを誘導することができますし、複数の種類をサポートしたい場合は、画像分類器全体ではなく、アプリ内の別のテンプレートである物体検出器の使用を検討することもできます。
        サマリーセクションに戻り、トップの混乱に関するこの行を確認してみます。
        ここでは、'Pepper'を'Bean'と言っています。
        このケースをクリックして調べてみましょう。
        ペッパーとラベル付けされた4つの画像が、誤ってビーンズと分類されています。
        これらは私にはピーマンのように見えますが、豆のように緑色をしているのでしょう。
        ピーマン全般が苦手なモデルなのでしょうかね。
        このクエリオプションをIncorrectからCorrectに切り替えてみましょう。
        ......これらの失敗と正しく分類されたピーマンを比較するためです。
        32枚の画像が正しく分類されました。しかし、これらのほとんどがピーマンであることに気づきました。
        しかし、これらのほとんどがピーマンであることに気づきました。学習データをチェックして、複数のピーマンを適切に表現していることを確認する必要があります。
        このように、機械学習では、学習データとテストデータの量、質、種類がいかに重要かを思い知らされることになりました。
        このアプリのおかげで、数分のうちに、ラベリングと表現に関するいくつかの問題点を視覚的に確認することができました。
        トレーニングデータに少し手を加えて、見えてきた問題が解決するかどうかを確認する必要があります。
        また、これまで考えもしなかったことが明らかになりました。ユーザーが1枚の写真に複数の野菜を撮影した場合、どうなるのか？アプリのデザインも、もう少し考えないといけませんね。
        このような検証は、ラベル付けされたデータのコレクションがあったからこそできたことです。
        しかし、ラベル付けされていないサンプルを素早くテストしたり、カメラアングルや照明条件をもっと検討したりしたい場合はどうしたらよいでしょうか。ここで、プレビュータブが役に立ちます。
        同僚が送ってくれたいくつかの例をここにドラッグして、その出来栄えを確認することができます。
        また、私のiPhoneを連続カメラとして使って、ライブでテストすることもできます。
        実際の野菜を指さすと、モデルが正しく分類してくれます。
        これはピーマン、これはトマトです。
        このように、ラベル付けされたデータセットに対する学習済みモデルの振る舞いを、より深く理解することができるようになりました。
        評価ペインでは、拡張されたオプションで詳細なメトリックサマリーが表示されます。
        新しいExploreタブでは、テスト評価結果と関連データを新しいインタラクティブなUIでフィルタリングして可視化するオプションが提供されます。
        ライブプレビューにより、即時のフィードバックが可能です。
        画像分類器、ハンドアクション分類器、ボディアクション分類器のテンプレートに拡張されました。
        また、接続された任意のウェブカメラから選択できるように機能を拡張し、macOS VenturaのContinuity Cameraもサポートしました。
        以上、Create MLアプリの新機能を簡単にまとめました。
        続いて、Create MLフレームワークの新機能について説明します。
        Create MLフレームワークは、macOS、iOS、iPadOSで利用可能です。
        今年は、そのサポートの一部をtvOS 16に拡張しています。
         プログラムインターフェースは、開発時のモデル作成を自動化するだけでなく、ユーザーの入力やデバイス上の行動から直接学習する動的な機能を構築する多くの機会を提供し、ユーザーのプライバシーを保護しながらパーソナライズされた適応的な体験を提供することが可能です。
         タスクのサポートはプラットフォームごとに異なることに注意してください。
         例えば、表形式の分類器やリグレッサーはどこでも利用できますが、ビデオを含むような大きなデータと計算を必要とするタスクのいくつかは、macOSが必要です。
         よくある質問として、"自分のアイデアをこれらのCreate MLの定義済みタスクのいずれかにマッピングできない場合はどうすればよいのでしょうか？"というものがあります。この疑問に答えるため、私たちはCreate MLファミリーに新しいメンバーを導入します。Create ML Componentsです．
         Create ML Componentsは，Create MLの基本的なビルディングブロックを公開するものです．
         これらを組み合わせることで、ユースケースに合わせてカスタマイズされたパイプラインとモデルを作成することができます。
         これらのセッションで詳細を確認することを強くお勧めします。
         Get to know Create ML Components」では、ビルディングブロックとその組み合わせ方について学びます。
         Create ML Componentsで高度なモデルを構成する」では、非同期テンポラリコンポーネントの使用とトレーニングのカスタマイズについて深く掘り下げます。
         私が個人的に気に入っているのは、行動反復カウントです。
         私は仕事以外では、たいていダンスをしています。
         私はインド古典舞踊のカタックのプロとして訓練を受けています。
         自分のフォームを改善するために、私はしばしば自分のルーチンを繰り返し練習することに頼っています。
         振付師・指導者としては、パフォーマーに特定のカウントのステップを練習してもらい、それを私に提出してほしいと思っています。
         Create MLに搭載された反復練習のカウント機能を使えば、それが可能になりますね。これは、カタックダンスに欠かせないチャッカー（回転）です。
        これを毎日何回となく練習して、フォームとスタミナをつけていきたいと思っています。
         Create MLで作ったiOSアプリで、動きをカウントしています。
         実際に使ってみましょう。
        チャッカを取ると、それに対応するようにカウントが増えます。
         ここでは、5回チャッカーをしているので、その回数がそのまま反映されています。
         次に、右側と左側の動きで構成される、別の小さなルーチンを試してみましょう。
         カウンターは、それらを1つとして数えます。
        ここでは、3回とカウントされています。
         もう1つ、片方の腕を素早く動かしてみましょう。
        これで4つです。
         アクション分類と組み合わせると、繰り返し動作のカウントと分類を同時に行うことができます。
         繰り返し動作のカウントは、ランタイムAPIとして提供される。
         学習データを必要としないので、この機能をアプリに追加するには、数行のコードを書くだけでよい。
         その実装は、クラスにとらわれないように設計された事前学習済みモデルに基づいています。
         つまり、ジャンピングジャック、スクワット、旋回、チャッカーなどのフィットネスやダンスの動作に対応する一方で、全身を使った様々な反復動作にも適用できます。
         このモデルや潜在的なユースケースについては、サンプルコードとこのセッションにリンクされた記事をご覧ください。
         以上、Create MLの新機能を簡単にご紹介しました。
         Create MLアプリのインタラクティブな評価とライブプレビューにより、トレーニングしたモデルをより深く理解することができます。
         Create MLフレームワークは、tvOSのサポート、反復計算を追加し、アプリのニーズに合わせて高度にカスタマイズされたモデルを構築できるよう、豊富な基礎コンポーネントのセットへのアクセスを提供するよう拡張されています。
         これらのエキサイティングな新機能を楽しんでいただけたら幸いです。

        """
    }
}

