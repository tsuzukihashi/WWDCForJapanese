import Foundation

struct BuildYourFirstAppinSwiftPlaygrounds: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Build your first app in Swift Playgrounds"
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/110348/")!
    }

    var english: String {
        """
         - Welcome to "Build your first app in Swift Playgrounds.
        " I am Collett Charlton, an engineer on the Swift Playgrounds team.
         - And I'm Connor Wakamo, another engineer on the Swift Playgrounds team.
         - Swift Playgrounds has been a great tool for learning to code in Swift, and now you can take things a step further and build apps too! Today, we're going to walk through building an app in Swift Playgrounds, starting with a blank template.
         We'll then show how to debug issues using previews and the console, and finally, we'll submit our app to TestFlight.
        Something our team really loves is making and drinking tea.
         We love it so much that we want to make an app for that.
         Connor and I are going to build a little app to help us at tea time, giving us a list of teas to help us pick what to drink each day.
         Swift Playgrounds works great on Mac and iPad.
         I've got my Mac with me today, so I'm going to start building this app there.
        Whether you are new to coding, or are an experienced developer, Swift Playgrounds offers a variety of templates and instructional content to get you started.
         For our tea app, we'll begin by clicking the blank App template in the bottom left corner of the screen.
        Now that we have our template, let's double click to open.
        Great.
         On the right is a live interactive preview showing the Hello World text.
        Before we start coding, let's customize the app a little using the App Settings.
         To do this, I'll click the app settings button in the top left corner of the sidebar.
         Here, you can customize various project properties like the app name and the accent color.
         You can also add a custom or placeholder app icon, capabilities, or purpose string, and a bundleID.
         I'll update the app's name to Tea Time.
        I'll set the accent color to brown.
         And I'll update the placeholder icon to the mug.
        Great.
         Now that the important part's out of the way, let's start writing some code by selecting the template text and replacing it with our first View from the Library.
         The Library can be accessed by clicking the plus button in the project toolbar.
         It contains easy-to-use snippets of different Views, Modifiers, SF Symbols, and Colors.
         We'll be using a List View to display our list of teas, so I'll type list into the search field and click it to insert one.
        Now that we have our List View, let's add some tea items to it.
         I'll start typing Text.
        ..and use the return key to accept and insert the code completion suggestion from the inline code completion panel.
        Alright, now we have our List View with one tea added.
         Let's add some more.
        Wait, it looks like I accidentally added Jasmine Green twice.
         In order to avoid duplicating our teas, we should store them as an orderedSet.
         Luckily for us, Apple's swift-collection package offers just that.
         So, let's add the swift-collection package to our project.
         To do this, let's open the File Menu and select Add Package.
        I'll begin by entering the URL for the swift-collections package, and then press the return key.
        After the package is fetched, we can see the package version and other products that can be added to our project.
         For this app, we'll only select Collections then click Add to Project.
        Now we have swift-collections added to our project in the sidebar under Packages.
         Let's create an OrderedSet of String to store our list of teas.
        Wait.
         It seems like we have an issue.
         Let's take a look by clicking the issue icon.
         "Cannot find type ordered set in scope.
        " Oh, I see what the problem is.
         I forgot to import the Collections module in our project.
         Let's import that, and the issue should be resolved.
        Now that we have resolved that issue, let's update our List View to use the collection we just created.
         To do this, we'll use a ForEach View.
        Alright, there we have it-- our list of teas being displayed from our tea collection.
         As I'm working on this project, I'm getting more and more ideas on features to add.
         It would be so cool if our app could listen for whistling tea kettles to let us know when it's time to pour.
         I'm not going to implement this now, but let's walk through the steps we would take to explain to users why our app needs to use the microphone.
         To add this, let's go back into our app settings.
        .. and click Capabilities.
         Using the plus button in the top righthand corner, we'll get a list of capabilities we can add to our project.
         Let's find microphone and click it to add.
         For the purpose string, we'll write: "Tea Time uses the microphone to listen for whistling tea kettles.
        " I'll click add, and then close app settings.
        Alright, we've done a lot today, and I'm excited to share the project and the cool ideas I have with Connor.
        I'll share it with Connor by adding it to our shared iCloud folder.
         But first, let's give it a better filename than My App.
        Now, I'll drag it to the shared iCloud Folder.
        Now that I'm done, I'm going to hand it over to Connor to finish the app.
         Thanks Collett.
        I'm going to pick things up on iPad.
        Since we're sharing our project via an iCloud Shared Folder, it doesn't show up in the main list of projects.
        But if I tap on "Locations," I can get access to projects from elsewhere in iCloud, or even from third-party document providers.
        I'm already in our Shared Folder, so I'll tap on Tea Time to open the project.
        Any changes I make will automatically be reflected in the shared project.
        It looks like Collett is such a good engineer that just uploading the project to iCloud added some extra features! She implemented a TabView here so we don't just have a list of teas but also an Assistant.
        If I tap on the Assistant tab, it's a little bit bare-bones, but it does the job.
        I can ask for a recommendation, and it'll give me a tea I should drink.
        Seems today I should have the Jasmine Green.
        Now I know Collett was working on a fun new way to pick teas to give this a little extra pizzaz.
        Let's open the sidebar to try to find it.
        TeaWheelView seems promising, so let's tap on that to open it.
        We've got a View which takes a collection of data.
        Let's add a view preview so we can try TeaWheelView out before it's a part of the main app.
        I'll scroll to the bottom of the file.
        ..And I'll begin typing "preview provider.
        " I'll accept the code completion suggestion by pressing the Return key, and I'll name it TeaWheelView_Previews.
        Page dots have now appeared at the bottom of the preview area, which tells me that Swift Playgrounds recognizes my preview provider.
        If I tap on the right chevron underneath the app preview… then I can use my view preview instead of the app preview.
        Right now it just says "Hello, world!" so let's add in some code to create a TeaWheelView.
        First I'll add an array with a few items in it as a static property so it can be used by my preview.
        I'll leave the insertion point between the two square brackets and then I'll drag on the closing bracket to create placeholders for a few items.
        Next, I'll replace the placeholders with a few strings that'll serve as our items.
        Now that we've got a few items, let's add in the TeaWheelView.
        I'll select the Hello, world! example and replace it with a TeaWheelView that displays my items.
        I'll also add in a little bit of padding.
        Great! Now our view preview is showing a wheel, and what a beautiful wheel it is! I can spin it, and it'll pick different items based on where it lands.
        Let's go back to the assistant tab and add this wheel in.
        I'll use the sidebar to open the AssistantTab Swift file, and I'm going to delete the Button and replace it with a TeaWheelView instead.
        TeaWheelView optionally takes an action closure which is called when the wheel stops spinning.
        I'll use it to set last picked tea to the selected tea, and I'll set show pick alert to true so SwiftUI knows to show the alert.
        Okay, great! We've got our wheel in here, so now let's try it! I'll swipe to spin it.
        ..and it told me to drink Byte's Oolong.
        I'll swipe it again...And it's still Byte's Oolong.
        One more time.
        Hmm.
        Something seems wrong.
        Even though it's landing on different spots on the wheel, it's always telling me to drink the Byte's Oolong.
        While that is a good tea, I'd like a little bit of variety.
        Let's switch back to the wheel view and try to figure out what's up.
        It's not obvious from this what's going wrong, since the wheel does spin and land on different spots.
        Let's add a print statement into our view preview to check if the preview is broken too.
        Now when I spin the wheel...
        A console message pops up at the bottom left of the source editor.
        Item one... item one…item one.
        Aha! Each spin gives us item one, which suggests something isn't quite hooked up right! Since it's giving me the first one every time, I'm going to use project-wide find to search for first.
        I'll tap in the search field at the top of the sidebar on the left hand side of the screen and then type "first" and press Return.
        That result seems promising, so I'll tap on it.
        Ah, it looks like Collett left some debugging code in here that made it return the first item every time instead of the right result.
        Let's fix that up real quick and then give it another spin.
        Item two...item four.
        Great! It seems to be working now.
        If we switch back to our app preview by tapping on the left chevron underneath the preview, we can try it out in the real app.
        I'll spin the wheel, and it's telling me to have the English Breakfast.
        So now we've got a working assistant.
        Awesome! Just to confirm the app works well at all sizes, I can run it in its own window by pressing the Run button in the upper left of the screen.
        Okay, seems like everything is here.
        I've got my list of teas, and I've got the assistant here with the wheel and everything.
         I can go back to the project in Swift Playgrounds by tapping on the little Swift icon in the status bar, and then by selecting the "Show Project" button in the sheet that pops up.
        I'm ready to test this app myself and with my friends and family.
         Swift Playgrounds makes it easy to test because you can submit directly to TestFlight from within Swift Playgrounds! If I bring up the app settings sheet and scroll to the bottom, there's an "Upload to App Store Connect" button.
         If I tap on that, Swift Playgrounds does all of the hard work of creating an app record and uploading my app to App Store Connect so I can distribute it on TestFlight and eventually the App Store.
        Now that my app is uploaded, I can go to App Store Connect and submit it for Beta App Review.
         After waiting a bit, we can go over to the TestFlight app and install it from there, even on iPhone! I'll tap "Install" to install Tea Time.
         Now that it's installed, I'll tap "Open" to open it.
         I'll tap to the test notes, as well as these instructions on how to provide feedback.
         And there you have it-- our app is running on iPhone.
         What tea should I have today? Looks like I'm having the Matt P's Tea Party.
         Today, Collett and I showed you how you can use Swift Playgrounds on your Mac and iPad to build apps.
         We demonstrated using the library and code completion to insert new code, we shared our project via iCloud Shared Folders, and we used view previews and the console to debug an issue with our code.
         We even submitted an app to TestFlight, right from iPad! Hopefully you've learned a thing or two along the way, and we can't wait to see what you build with Swift Playgrounds.
         Thank you for watching, and enjoy the rest of WWDC!
        """
    }

    var japanese: String {
        """
         - Swift Playgroundsで初めてのアプリを作ろう」へようこそ。
        " 私はSwift Playgroundsチームのエンジニア、コレットチャールトンです。
         - そして、Swift Playgroundsチームのもう一人のエンジニア、Connor Wakamoです。
         - Swift Playgrounds は、Swift でのコーディングを学ぶための素晴らしいツールでしたが、さらに一歩進んで、アプリも作れるようになりました! 今日は、Swift Playgrounds でアプリを構築する方法を説明します。
         次に、プレビューとコンソールを使用して問題をデバッグする方法を説明し、最後にTestFlightにアプリを送信します。
        私たちのチームが本当に好きなことは、お茶を入れたり飲んだりすることです。
         あまりに好きなので、そのためのアプリを作りたいと思っています。
         Connorと私は、お茶の時間に、毎日何を飲むか選ぶのに役立つお茶のリストを提供する、小さなアプリを作るつもりです。
         Swift Playgroundsは、MacとiPadでうまく機能します。
         今日はMacを持っているので、そこでこのアプリを作り始めようと思っています。
        コーディングが初めての人でも、経験豊富な開発者でも、Swift Playgroundsにはさまざまなテンプレートや説明コンテンツが用意されているので、すぐに始めることができます。
         私たちのお茶のアプリのために、画面の左下隅にある空白のアプリテンプレートをクリックすることから始めます。
        これでテンプレートができましたので、ダブルクリックして開いてみましょう。
        素晴らしい。
         右側には、Hello Worldのテキストを表示するライブインタラクティブプレビューがあります。
        コーディングを始める前に、アプリの設定を使ってアプリを少しカスタマイズしてみましょう。
         これを行うには、サイドバーの左上隅にあるアプリ設定ボタンをクリックします。
         ここでは、アプリ名やアクセントカラーなど、さまざまなプロジェクトのプロパティをカスタマイズできます。
         また、カスタムまたはプレースホルダーのアプリのアイコン、機能、または目的の文字列、およびbundleIDを追加することができます。
         アプリの名前を Tea Time に更新します。
        アクセントカラーは茶色に設定します。
         そして、プレースホルダのアイコンをマグカップに更新します。
        素晴らしい。
         さて、重要な部分が終わったので、コードを書き始めましょう。テンプレートテキストを選択し、それをライブラリから最初のビューに置き換えます。
         ライブラリは、プロジェクトのツールバーのプラスボタンをクリックすることでアクセスできます。
         ライブラリには、さまざまなビュー、モディファイア、SFシンボル、カラーなどの使いやすいスニペットが含まれています。
         今回は、お茶のリストを表示するためにリストビューを使用するので、検索フィールドに list と入力してクリックし、挿入します。
        リストビューができたので、そこにお茶のアイテムを追加してみましょう。
         まず、Text と入力します。
        . . と入力し、リターンキーを使ってインラインコード補完パネルからのコード補完候補を受け入れ、挿入します。
        さて、これでリストビューにお茶が1つ追加されました。
         さらに追加してみましょう。
        待ってください、誤ってジャスミングリーンを2つ追加してしまったようです。
         紅茶の重複を避けるには、orderedSetとして保存する必要があります。
         幸いなことに、Appleのswift-collectionパッケージがそれを提供してくれます。
         それでは、swift-collection パッケージをプロジェクトに追加してみましょう。
         これを行うには、File メニューを開き、Add Package を選択します。
        まず、swift-collections パッケージの URL を入力し、リターンキーを押してみます。
        パッケージが取得されると、パッケージのバージョンとプロジェクトに追加可能な他の製品が表示されます。
         今回は、Collectionsのみを選択し、Add to Projectをクリックします。
        これで、サイドバーの「Packages」に、プロジェクトに追加された「swift-collections」が表示されました。
         紅茶のリストを格納するために、StringのOrderedSetを作成しましょう。
        待ってください。
         問題があるようです。
         問題アイコンをクリックして見てみましょう。
         "Cannot find type ordered set in scope.
        " ああ、何が問題なのか分かったわ。
         プロジェクトにCollectionsモジュールをインポートするのを忘れていたんだ。
         それをインポートすれば、問題は解決するはずです。
        これで問題が解決したので、リストビューを更新して、先ほど作成したコレクションを使用するようにしましょう。
         これを行うには、ForEach ビューを使用します。
        これで、紅茶コレクションから紅茶のリストが表示されるようになりました。
         このプロジェクトに取り組んでいるうちに、追加すべき機能のアイデアがどんどん湧いてきました。
         例えば、茶釜の音を聞いて、お茶を入れるタイミングを知らせてくれるような機能があれば、とてもクールだと思います。
         今すぐには実装しませんが、なぜこのアプリがマイクを使う必要があるのか、ユーザーに説明する手順を説明しましょう。
         これを追加するには、アプリの設定に戻りましょう。
        . . をクリックし、[機能]をクリックします。
         右上隅にあるプラスボタンを使用すると、プロジェクトに追加できる機能のリストが表示されます。
         マイクを探し、クリックして追加しましょう。
         目的の文字列には、次のように書きます。"Tea Timeは、マイクを使って茶釜の音を聞きます。
        " 追加をクリックし、アプリの設定を閉じます。
        さて、今日はたくさんのことをやりました。このプロジェクトと、私が持っているクールなアイデアをConnorと共有するのが楽しみです。
        iCloudの共有フォルダにプロジェクトを追加して、Connorと共有します。
         でもその前に、My Appよりもいいファイル名をつけておきましょう。
        さて、それを共有のiCloudフォルダにドラッグします。
        これで、アプリを完成させるために、Connorに渡します。
         ありがとう、コレット。
         iPadでいろいろ拾ってくる。
         iCloudの共有フォルダ経由でプロジェクトを共有しているため、プロジェクトのメインリストには表示されません。
         しかし、「場所」をタップすると、iCloudの他の場所や、サードパーティのドキュメントプロバイダーからプロジェクトにアクセスすることができます。
         すでに共有フォルダにいるので、「Tea Time」をタップしてプロジェクトを開いてみます。
         私が加えたすべての変更は、自動的に共有プロジェクトに反映されます。
         コレットは優秀なエンジニアなので、プロジェクトをiCloudにアップロードするだけで、さらにいくつかの機能が追加されました。ここではTabViewを実装して、お茶のリストだけでなく、アシスタントも表示されるようにしてくれています。
         アシスタントのタブをタップしてみると、ちょっと素っ気ないですが、ちゃんと機能しています。
         お勧めのお茶を尋ねると、飲むべきお茶を教えてくれます。
         今日はジャスミングリーンがよさそうです。
         コレットは、お茶の選び方に工夫を凝らして、このアプリをさらに楽しくしてくれました。
         サイドバーを開いて、それを探してみましょう。
        TeaWheelViewが期待できそうなので、これをタップして開いてみましょう。
         データの集まりを受け取るViewができました。
         メインアプリの一部になる前にTeaWheelViewを試せるように、ビュープレビューを追加してみましょう。
         ファイルの一番下までスクロールします。
        ...そして、"preview provider "とタイプし始めます。
        " リターンキーを押してコード補完の提案を受け入れ、TeaWheelView_Previewsという名前にします。
        プレビューエリアの下にページドットが表示され、Swift Playgroundsが私のプレビュープロバイダを認識していることがわかります。
         アプリのプレビューの下にある右のシェブロンをタップすると...アプリのプレビューの代わりに私のビュープレビューを使用することができます。
         今は「Hello, world！」と表示されているだけなので、TeaWheelViewを作成するコードをいくつか追加してみましょう。
         まず、いくつかのアイテムを含む配列を静的プロパティとして追加し、プレビューで使用できるようにします。
        挿入ポイントを2つの角括弧の間に置いてから、閉じ括弧をドラッグしていくつかの項目のプレースホルダーを作ります。
        次に、プレースホルダーをアイテムとして使用する文字列で置き換えます。
        いくつかのアイテムができたので、TeaWheelViewを追加してみましょう。
         Hello, world! のサンプルを選択して、アイテムを表示するTeaWheelViewに置き換えてみます。
        また、少しパディングを追加しています。
        素晴らしい これで、ビューのプレビューに車輪が表示されるようになりました。このホイールは回転させることができ、着地した場所に応じてさまざまなアイテムを選択することができます。
         アシスタントタブに戻り、このホイールを追加してみましょう。
         サイドバーを使ってAssistantTab Swiftファイルを開き、Buttonを削除して、代わりにTeaWheelViewに置き換えるつもりです。
        TeaWheelViewはオプションで、ホイールの回転が止まったときに呼び出されるアクションクロージャーを取ります。
        最後に選んだお茶を選択したお茶に設定するためにそれを使用し、SwiftUIがアラートを表示することを知るためにshow pick alertをtrueに設定します。
        OK、すばらしい! では試してみましょう! スワイプして回してみます。
        そして、バイトのウーロン茶を飲むように言われました。
         もう一度スワイプしてみると...やはりバイトのウーロン茶。
         もう一回。
        うーん。
         何かおかしいぞ。
         ホイールのいろいろなところに着地しているのに、いつも「バイトのウーロン茶を飲んでください」と言われる。
         それはそれでおいしいのだが、もう少しバリエーションが欲しいところだ。
         ホイールビューに戻り、何が起きているのか考えてみましょう。
        ホイールは回転し、さまざまな場所に着地するので、これだけでは何が間違っているのかわかりません。
         ビューのプレビューに print 文を追加して、プレビューが壊れているかどうかを確認してみましょう。
        ホイールを回すと...
         ソースエディタの左下にコンソールメッセージがポップアップ表示されます。
         アイテム1...アイテム1...アイテム1です。
         回転させるたびにアイテム1が表示されるのは、何かが正しく接続されていないことを示唆しています。毎回最初の項目が表示されるので、プロジェクト全体の検索を使用して最初の項目を検索してみます。
         画面左側のサイドバー上部にある検索フィールドをタップし、「first」と入力してリターンキーを押してみます。
        この結果は期待できそうなので、タップしてみます。
         ああ、コレットはここにデバッグ用のコードを残していたようで、正しい結果ではなく、毎回最初の項目を返すようになっていますね。
         それを修正して、もう一回やってみましょう。
        アイテム2...アイテム4。
         素晴らしい！これでうまくいったようです。
         プレビューの下にある左のシェブロンをタップしてアプリのプレビューに戻ると、実際のアプリで試してみることができます。
         ホイールを回すと、イングリッシュブレックファストを食べるように指示されます。
         これで、アシスタントが機能するようになりました。
         すごい 画面左上の「実行」ボタンを押すと、アプリがどのサイズでもうまく動くことを確認できます。
        さて、これですべて揃ったようです。
         お茶のリストもありますし、アシスタントも車輪と一緒にここにあります。
         私は、ステータスバーの小さなSwiftアイコンをタップし、ポップアップするシートで「プロジェクトを表示」ボタンを選択することで、Swift Playgroundsのプロジェクトに戻ることができます。
        私はこのアプリを自分自身や友人や家族と一緒にテストする準備ができています。
         Swift Playgroundsの中からTestFlightに直接投稿できるので、Swift Playgroundsは簡単にテストを行うことができます！アプリの設定シートを表示すると、Swift Playgroundsが表示されます。アプリの設定シートを表示し、一番下までスクロールすると、「Upload to App Store Connect」ボタンがあります。
         これをタップすると、Swift Playgrounds がアプリの記録を作成し、アプリを App Store Connect にアップロードして、TestFlight と最終的には App Store で配布できるようにするためのハードワークのすべてを行います。
        アプリがアップロードされたので、App Store Connectに行き、Beta App Reviewのためにアプリを提出することができます。
         少し待つと、TestFlightアプリに移動して、そこからインストールすることができます。インストール」をタップして、Tea Timeをインストールします。
         インストールが完了したら、"Open "をタップして開いてみます。
         テストの注意事項や、フィードバックの方法などが書いてあるので、タップしてみます。
         これで、私たちのアプリはiPhoneで動作するようになりました。
         今日はどんなお茶を飲もうかな？Matt P's Tea Partyをやっているようです。
         今日、Collettと私は、MacとiPadでSwift Playgroundsを使ってアプリを作る方法を紹介しました。
         ライブラリとコード補完を使って新しいコードを挿入することを実演し、iCloud の共有フォルダを使ってプロジェクトを共有し、コードの問題をデバッグするためにビュープレビューとコンソールを使いました。
         さらに、iPadからTestFlightにアプリを送信することもできました。あなたが Swift Playgrounds で何を作るか見るのが楽しみです。
         そして、WWDCの残りを楽しんでください。
        """
    }
}
