import Foundation

struct WhatsNewInSharePlay: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "What's new in SharePlay"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6637/6637_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10140/")!
    }

    var english: String {
        """
        Adam: Hi, my name's Adam and I'm an engineer on the SharePlay team.
         I'm excited to talk to you about what's new in SharePlay and how you can adopt it in your app.
         To start, we'll talk about some new APIs for starting SharePlay from your app.
         Next, we'll get into some exciting GroupSessionMessenger updates.
         Finally, some best practices around implementing a SharePlay experience.
         Starting SharePlay from your app.
         We heard your feedback and we delivered, As of iOS 15.4 you can now leverage new API to allow your app to start SharePlay without an existing FaceTime call.
         So let's see what that looks like.
         So now all we have to do is find our favorite SharePlay app.
         Let's say the Music app.
         And we'll find a song that we want to SharePlay, like Viral Hits, and press and hold it.
         Now in the contextual menu, you'll see that we now have a new SharePlay button.
         So I'll go ahead and press that, and it brings up the people picker.
         So we can select Sue and start a FaceTime call.
        And, as you can see, we now have a pill here with the staged activity.
         So if Sue joins, we can go ahead and start, and we'll have group session.
        Well, I thought that was all pretty cool, but let's break that down into some more detail.
        Here we have the ability for users to start SharePlay from share sheet, and you may be wondering what you need to do for this to work.
         Well, the answer is that if your app is entitled for SharePlay then you get this button for free with our zero adoption flow, but this isn't the optimal user experience since the user won't be able to start the GroupActivity through system UI and will, instead, need to re-interact with your app to pick the content to SharePlay.
         So let's see how you'd adopt our new APIs for your app.
         The answer is, it's as simple as registering your GroupActivity on NSItemProvider and then providing the ItemProvider to the share sheet.
        Want to still offer the SharePlay button but not display it as prominently? No problem.
         You can tune the behavior with allowsProminentActivity on the UIActivityViewController.
         Just set allowsProminentActivity to false.
        Or what if you have a piece of content in your app that doesn't support SharePlay? Well, while we'd love for everything to support SharePlay, you can make SharePlay not show up in the share sheet by telling UIActivityViewController to exclude the SharePlay activity type.
        And if you want to place a button directly within your app, then you can use our new API GroupActivitySharingController to create our UIViewController and then, just present it! Once someone presses your in-app experience and starts a FaceTime or SharePlay session, they'll then be presented with the ability to activate the staged GroupActivity.
         Once activated, your app will receive the GroupSession.
         And don't worry if you're saying to yourself "Wait, Adam, did you just say 'Staged GroupActivity'?" Why, yes.
         Yes, I did! But let's hold onto that thought and dive deeper into that later when we're talking about best practices.
         For now, let's see how we can adopt this in our DrawTogether app.
        This is our DrawTogether app.
         It's the same app from our previous WWDC talk from 2021 "Build custom experiences with Group Activities," so if you haven't seen it already, I highly recommend checking it out.
         Now that you've gone ahead and seen that, you'll remember there weren't any share buttons in our app, but we did have a SharePlay button when you were eligible for a GroupSession.
         Let's go ahead and modify that behavior so that even when isEligibleForGroupSession is false, we show the button and, now, allow the user to start a SharePlay session.
        And now we can go ahead and see it in action.
         Let's go ahead and go to our ControlBar code.
         Now, as you can see here, we have an ‘if’ statement that makes sure that we don't have a group session and that we're eligible for a group session.
         So let's go ahead and remove the latter statement, and move it down here.
        And now what we have to do is register a new variable so that we know when to present our GroupActivity sharing controller.
         So we'll have a new variable up here, and now let's handle when that variable changes to true.
        And we have to have a wrapper now so we can present the GroupActivity sharing controller in SwiftUI.
        And now, finally, all we have to do is have an 'else' statement to set isSharingControllerPresented to true if we're not eligible for a GroupSession.
        And now we can see our code in action.
         So we'll go ahead and go to the DrawTogether app., and you can see, we have our SharePlay button.
         So we can now press it, and we're given the people picker.
        And now we've got a great experience for starting SharePlay from your app.
         But that's not the only update we made.
         So now let's talk about some of the GroupSessionMessenger updates we've made.
         We've got two exciting new updates in our GroupSessionMessenger.
         For the first update, you may have run into this magical number.
         It's the payload size you're able to send over the GroupSessionMessenger.
         Well, not anymore.
         We've now made it so that the payload size is four times larger at 256KB.
         With this change, your app doesn't need to worry about breaking up your message into smaller messages.
         You can simply send your message and focus on building a great experience.
         And if that didn't excite you enough, then I'm sure our next update will.
         Unreliable messaging.
         As part of the GroupSessionMessenger, you can now choose your messages' reliability.
         This allows you to choose between reliable or unreliable messaging depending on your desired experience.
        All we have to do is leverage the new initializer on GroupSessionMessenger that allows us to specify the MessageReliability.
        Now that we understand how to use the API, what about the experience? When would we want to use unreliable messaging? Well, that's a great question People are performing real-time actions on FaceTime and SharePlay.
         So let's imagine that we have three people in a session.
         Amy, Brian, and Chris.
         They're all joined into a session and synced so as time progresses so does our movie.
         But what happens if Amy wants to do something relevant to the specific time that they're at in that moment? Well, if you use reliable messaging, then we guarantee that messages will be received on all the devices, but that doesn't mean that they'll be received at the time that they're expecting it.
         For example, Chris received the message, but Brian has the message dropped the first time and receives it properly after that.
         But remember, the movie is still playing.
         So now we get to where Amy intended the message to be reflected and Brian doesn't have it.
         He receives it later, but at that point, it's too late.
         Well, this is a perfect case for unreliable networking.
         It allows you, the developer, to know what information needs to be reliably received on the other side and what information doesn't.
         This is an important concept to understand when designing protocols that have the user experience deeply affected by latency.
         Unreliable messages are using UDP and have less latency and overhead with each message involved and, as a result of that, you'll have a more real-time experience when sending messages through them.
         So now let's talk about how we're going to use this for our DrawTogether app You may remember this screen from WWDC '21, especially with my beautifully drawn smiley face.
         Let's dive a bit into what happens when you're drawing your smiley face on the screen.
        In our app we have some code that listens to a GestureRecognizer and then we sent messages each time we noticed a change.
         This meant that as we were drawing our smiley face, we were constantly sending new messages for each point our GestureRecognizer gives us.
         That's a lot of messages! Well, we can now change our protocol to use unreliable messaging to make a more seamless drawing experience.
        What we'll do here is make it so that each time we receive an update from our GestureRecognizer, we'll send our newly added point using unreliable messaging.
         Once the gesture is complete, we'll then use reliable messaging and give all of the points so a client can catch up with any points that they missed.
         This allows us to take advantage of the lower latency provided by unreliable messaging to have a more immediate drawing experience.
         So let's see how we would do this in code.
         So first let's go to our messages file.
        And we'll go ahead and define our new message type.
        As you can see, this new message type is pretty much the same as our old one, but this time, will contain all of the points for our stroke.
         Now we'll go over to our canvas file.
        And we need to set up a handler function to handle the new message that we're gonna get.
        And let's go ahead and create our unreliable messenger.
         First, we'll create a variable.
        And now, let's just initialize it.
        Now we'll listen for the finished stroke message.
        And mark the previous message as unreliable messenger as well.
        But we need a way to send the message.
         So we'll go up to finishedStroke.
        And we'll go ahead and send our new message type.
        And let's change our old function for sending all of the points to use the unreliable messenger.
        And now we can see our code in action.
         So we go over to the DrawTogether app and we can see how seamless it is.
         And that's it! And now, as promised, let's talk about some best practices for your SharePlay implementation.
         You may remember this term from earlier: Staged GroupActivity.
         What does that term mean for your app? Well, let's talk through a scenario.
        Let's say that the device on our left, "Adam", starts SharePlay with the device on our right, "Brian".
         But Adam is trying to resume the show they were watching.
         So when someone activates the staged GroupActivity, we want to jump into that resumed show at a specific time, rather than starting over.
         This poses a problem because "Adam" knew we had 11 minutes remaining in the show, but Brian's device didn't.
         This means that if Brian's device activated the staged GroupActivity, the show may start over.
         So what can we do here? It really depends on your app and experience.
        So let's walk through some ideas.
         For the playback case, we'll want to have each device contribute its initial playback state to the others in catch-up.
         This means that since Adam's device knew the playback state was 23 seconds, when he joins the session, he'll tell all the other devices his intended playback state, and they'll use that as the source of truth.
         This same principle applies to any experience you create using SharePlay.
         Each person that joins a session should contribute their understanding of the session to the others.
         This is because sessions are peer-to-peer and ownerless.
         So let's talk a bit more about that.
         Ownerless sessions are a hard concept to grasp, but they're important when designing a proper SharePlay experience.
         In this case, Adam, on the left, wants to hand off his session to his Apple TV.
         This results in his phone dropping off the GroupSession and his TV joining.
         But what happens if we had ownership implemented? Well, the owner dropped off, so...
         And remember, this isn't just for TVs.
        In iOS 16 we now have FaceTime handoff.
         So Adam goes ahead and hands off his iPad, and well, same thing.
         Boom And that isn't all.
         We just talked about some examples of a user flow where someone tries to move the session from one device to another, but there's other cases to think about.
         Okay, don't worry, we'll keep it short with just one more example.
         This screen may seem a little familiar.
         It's the FaceTime HUD.
         But what happens if we click the SharePlay button? We're now presented with a button, End SharePlay, that allows you, you guessed it, end SharePlay.
         This allows you to end SharePlay for everyone, essentially the system calling .
        end() on the GroupSession on your application's behalf.
         This means that no matter how careful you are about not calling .
        end() unless that device is the owner, the system is still able to call .
        end() on the GroupSession on your behalf.
         So remember, while it may be a hard concept to grasp, making sure that your application doesn't have a sense of ownership means that it'll, overall, result in a much better experience.
         Now that you've listened to the whole session, go and adopt our new APIs for starting SharePlay from within your app, and explore ways for your app to communicate in new, low latency, ways using unreliable messaging.
        We love hearing from you all, so please continue to file feedback using the Feedback Assistant.
         I hope you enjoyed all the changes that we've made and we look forward to seeing all the amazing experiences that you build.
         If you haven't already, check out our other WWDC talk, "Make a great SharePlay experience".
         Or, if you're looking for some amazing enhancements we've made around media playback, check out "Display ads and other interstitials in SharePlay".
         If you have any questions, please find us at the GroupActivities labs and challenges.
         As always, thank you all for tuning in, and have a great WWDC.
         We can't wait to see what you build.


        """
    }

    var japanese: String {
        """
        アダム：こんにちは、私の名前はアダムで、SharePlayチームのエンジニアです。
         SharePlayの新機能と、それをあなたのアプリにどのように採用できるかについてお話できることを楽しみにしています。
         まず始めに、アプリからSharePlayを起動するためのいくつかの新しいAPIについてお話します。
         次に、いくつかのエキサイティングなGroupSessionMessengerのアップデートに触れます。
         最後に、SharePlayエクスペリエンスを実装するためのベストプラクティスをいくつか紹介します。
         アプリから SharePlay を開始する。
         iOS 15.4では、新しいAPIを利用して、既存のFaceTime通話がなくてもアプリからSharePlayを開始できるようになりました。
         では、どのように見えるか見てみましょう。
         さて、あとはお気に入りのSharePlayアプリを見つけるだけです。
         例えば、「ミュージック」アプリです。
         そして、我々はSharePlayしたい曲を見つけるでしょう, Viral Hitsのように, そしてそれを押したままに.
         今すぐコンテキストメニューで、あなたは今、我々は新しいSharePlayボタンを持っていることがわかります.
         これを押すと、ピープルピッカーが表示されます。
         Sueを選択して、FaceTime通話を開始することができます。
        そしてご覧のとおり、ステージングされたアクティビティを持つ錠剤がここにあります。
         スーが参加すれば、グループセッションを開始することができます。
        さて、ここまではとてもクールな内容だと思いましたが、もう少し詳しく説明しましょう。
        ここでは、ユーザーが共有シートからSharePlayを開始できるようにしていますが、これを動作させるために何をする必要があるのか疑問に思うかもしれません。
         しかし、これは最適なユーザー体験ではありません。なぜなら、ユーザーはシステムの UI から GroupActivity を開始することができず、代わりにアプリと再インタラクトして SharePlay するコンテンツを選択する必要があるからです。
         では、どのように新しいAPIをあなたのアプリに採用するか見てみましょう。
         答えは、GroupActivityをNSItemProviderに登録し、そのItemProviderをシェアシートに提供することで簡単に実現できます。
        SharePlayボタンを提供したいが、それほど目立つように表示したくないですか？問題ありません。
         UIActivityViewControllerのallowProminentActivityで動作を調整することができます。
         allowsProminentActivityをfalseに設定するだけです。
        また、アプリ内にSharePlayをサポートしないコンテンツがある場合はどうでしょうか？すべてのコンテンツがSharePlayをサポートすることを望みますが、UIActivityViewControllerにSharePlayアクティビティタイプを除外するように指示すれば、SharePlayがシェアシートに表示されないようにすることが可能です。
        また、アプリ内に直接ボタンを配置したい場合は、新しいAPI GroupActivitySharingControllerを使ってUIViewControllerを作成し、それを表示するだけです！誰かがアプリ内のボタンを押すと、そのボタンが表示されます。誰かがあなたのアプリ内体験を押して FaceTime または SharePlay セッションを開始すると、ステージングされた GroupActivity をアクティベートする機能が表示されるようになります。
         アクティベートされると、アプリはGroupSessionを受け取ります。
         "ちょっと待って、アダム、今「Staged GroupActivity」と言った？" と言われても、心配しないでください。そうなんです。
         そうです、そうです。しかし、その考えは保留にして、後でベストプラクティスの話をするときに、さらに深く掘り下げましょう。
         とりあえず、DrawTogetherアプリでこれをどのように採用するか見てみましょう。
        これはDrawTogetherのアプリです。
         2021年のWWDCでの講演「グループ活動でカスタム体験を構築しよう」と同じアプリなので、まだ見ていない方はぜひチェックしてみてください。
         このアプリにはシェアボタンがありませんでしたが、GroupSessionの対象となったときにSharePlayボタンがあったのを覚えていると思います。
         その動作を変更して、isEligibleForGroupSession が false の場合でも、ボタンを表示し、ユーザーが SharePlay セッションを開始できるようにします。
        そして、実際にそれを見てみましょう。
         ControlBarのコードに移動してください。
         ここでわかるように、グループセッションがないこと、およびグループセッションの対象であることを確認する「if」ステートメントが用意されています。
         そこで、後者のステートメントを削除して、下に移動してみましょう。
        そして、GroupActivity共有コントローラをいつ表示するかを知るために、新しい変数を登録する必要があります。
         ここで新しい変数を作成し、この変数がtrueに変わったときに処理するようにします。
        そして、SwiftUIでGroupActivity共有コントローラを表示できるように、ラッパーを用意しなければなりません。
        そして最後に、GroupSessionの資格がない場合、isSharingControllerPresentedをtrueに設定する'else'ステートメントを用意すればよいのです。
        そして、このコードが実際に動く様子を見ることができます。
         次に、DrawTogether アプリに移動して、SharePlay ボタンがあることを確認します。
         このボタンを押すと、ピープルピッカーが表示されます。
        これで、アプリからSharePlayを開始するための素晴らしいエクスペリエンスを手に入れました。
         しかし、私たちが行ったアップデートはこれだけではありません。
         それでは、GroupSessionMessengerのアップデートについて説明します。
         GroupSessionMessengerには、2つのエキサイティングなアップデートがあります。
        最初のアップデートで、この不思議な数字に出くわしたかもしれません。
        これは、GroupSessionMessenger で送信できるペイロードサイズです。
        でも、もう大丈夫です。
        ペイロードサイズは4倍の256KBになりました。
        この変更により、アプリはメッセージをより小さなメッセージに分割することを心配する必要がなくなりました。
        メッセージを送信するだけで、優れたエクスペリエンスを構築することに集中できます。
        もし、これで十分な興奮を覚えられなかったのなら、次のアップデートがきっとそうさせてくれるでしょう。
        信頼性のないメッセージング
        GroupSessionMessenger の一部として、メッセージの信頼性を選択できるようになりました。
        これにより、希望するエクスペリエンスに応じて、信頼性のあるメッセージングと信頼性のないメッセージングを選択することができます。
        GroupSessionMessenger の新しいイニシャライザーを利用して、MessageReliability を指定することができます。
        さて、API の使い方は理解できましたが、エクスペリエンスについてはどうでしょうか。信頼性のないメッセージングを使いたいのはどんなときでしょうか？FaceTimeやSharePlayでリアルタイムのアクションを実行する人たちは、それは素晴らしい質問です。
        そこで、セッションに3人の人がいると想像してみましょう。
        Amy、Brian、Chrisです。
        彼らは全員セッションに参加し、同期しているので、時間が進むにつれて映画も進行します。
        しかし、Amyがその瞬間にいる特定の時間に関連したことをしたいとしたらどうなるでしょうか。信頼性の高いメッセージングを使用する場合、すべてのデバイスでメッセージが受信されることは保証されますが、それは彼らが期待する時間に受信されることを意味しません。
        例えば、クリスはメッセージを受け取りましたが、ブライアンは最初の1回でメッセージを落としてしまい、その後ちゃんと受け取っています。
        でも、ムービーはまだ上映中であることを忘れないでください。
        そこで今度は、Amyが意図したメッセージが反映される場所に行き、Brianはメッセージを持っていない。
        後で受け取るのですが、その時点で手遅れなのです。
        これは、信頼性のないネットワークの完璧なケースです。
        開発者は、どの情報が相手側で確実に受信される必要があり、どの情報がそうでないかを知ることができるのです。
        これは、ユーザーエクスペリエンスがレイテンシーに深く影響されるプロトコルを設計する際に理解すべき重要な概念です。
        信頼性のないメッセージはUDPを使用しており、関係する各メッセージのレイテンシーとオーバーヘッドが少なく、その結果、それらを介してメッセージを送信する際に、よりリアルタイムなエクスペリエンスを得ることができるのです。
        では次に、これをDrawTogetherアプリにどのように使うかについて説明します。この画面はWWDC '21で見たもので、特に私が美しく描いたスマイリーフェイスを覚えているかもしれませんね。
        スマイリーフェイスを画面に描くときに何が起こるか、少し掘り下げてみましょう。
        私たちのアプリでは、GestureRecognizerをリッスンするコードをいくつか用意し、変化に気づくたびにメッセージを送信していました。
        つまり、スマイリーフェイスを描いている間、GestureRecognizerが示すポイントごとに常に新しいメッセージを送信していたのです。
        これは膨大な数のメッセージです。そこで、よりシームレスな描画を実現するために、信頼性の低いメッセージングを使用するようにプロトコルを変更することができます。
        ここでは、GestureRecognizer から更新を受け取るたびに、新しく追加されたポイントを信頼性のないメッセージングを使って送信するようにします。
        ジェスチャーが完了したら、信頼できるメッセージングを使用してすべてのポイントを送信し、クライアントが取りこぼしたポイントを取り戻せるようにします。
        これにより、信頼性のないメッセージングが提供する低遅延を利用し、より即時性の高い描画体験を提供することができます。
        では、これをコードでどのように行うか見てみましょう。
        まず、messages ファイルに移動しましょう。
        そして、新しいメッセージタイプを定義していきます。
        見てわかるように、この新しいメッセージタイプは以前のものとほとんど同じですが、今回はストロークのためのすべてのポイントを含んでいます。
        次に、Canvas ファイルに移動します。
        そして、これから受け取る新しいメッセージを処理するために、ハンドラ関数をセットアップする必要があります。
        それでは、信頼できないメッセンジャーを作りましょう。
        まず、変数を作成します。
        そして、それを初期化しましょう。
        次に、ストロークが終了したメッセージを受け取ります。
        そして、前のメッセージも同様に信頼できないメッセンジャーとしてマークします。
        しかし、メッセージを送信する方法が必要です。
        そこで、finishedStrokeに移動します。
        そして、新しいメッセージタイプを送信してみましょう。
        そして、すべてのポイントを送信するための古い関数を、信頼性の低いメッセンジャーを使用するように変更しましょう。
        そして、このコードが実際に動くところを見ることができます。
        このように、DrawTogetherのアプリでは、シームレスに動作することが確認できます。
        以上です。さて、約束通り、SharePlayの実装におけるベストプラクティスについてお話ししましょう。
        先ほどからこの言葉を覚えているかもしれません。Staged GroupActivity（ステージド グループ アクティビティ）です。
        この用語は、あなたのアプリにとってどのような意味を持つのでしょうか？では、シナリオを説明しましょう。
        左側のデバイス「Adam」が、右側のデバイス「Brian」と SharePlay を開始したとします。
        しかしアダムは、彼らが見ていた番組を再開しようとしています。
        そこで、誰かがステージングされたGroupActivityをアクティブにすると、最初からやり直すのではなく、特定の時間に再開されたショーに飛び込むようにしたいのです。
        このとき、「Adam」は番組の残り時間が11分であることを知っていますが、「Brian」の端末は知らないため、問題が発生します。
        つまり、BrianのデバイスがステージングされたGroupActivityをアクティブにすると、ショーがやり直しになる可能性があります。
        では、どうすればいいのでしょうか？それは、あなたのアプリと経験次第です。
        そこで、いくつかのアイデアを紹介しましょう。
        再生する場合、各デバイスの最初の再生状態を、他のデバイスのキャッチアップに反映させるようにします。
        つまり、Adamのデバイスは再生状態が23秒であることを知っているので、彼がセッションに参加したときに、彼が意図した再生状態を他のすべてのデバイスに伝え、それを真実のソースとして使用することになります。
        この原則は、SharePlayを使用して作成するあらゆるエクスペリエンスに当てはまります。
        セッションに参加する各自は、セッションの理解を他の人に提供する必要があります。
        これは、セッションがピアツーピアでオーナーレスであるためです。
        では、そのことについてもう少し詳しくお話ししましょう。
        オーナーレスセッションは把握しにくい概念ですが、適切なSharePlayエクスペリエンスを設計する上で重要です。
        この例では、左側のアダムは、セッションをApple TVに渡したいと思っています。
        この結果、彼の携帯電話は GroupSession から外れ、テレビが参加することになります。
        しかし、もし所有権を実装していたらどうなるでしょうか？オーナーが脱落したわけですから...
        そして、これはテレビに限ったことではないことを忘れないでください。
        iOS 16では、FaceTimeのハンドオフが可能になりました。
        アダムがiPadを手渡すと、同じことが起こります。
        ブーム それだけではありません。
        セッションをあるデバイスから別のデバイスに移動させようとするユーザーフローの例についてお話ししましたが、他にも考えるべきケースがあります。
        心配しないでください、もう1つの例で手短に済ませましょう。
        この画面は少し見覚えがあるかもしれません。
        これはFaceTime HUDです。
        しかし、「SharePlay」ボタンをクリックするとどうなるでしょうか？End SharePlay」というボタンが表示され、その名の通り、SharePlayを終了することができます。
        これにより、全員の SharePlay を終了させることができ、基本的にシステムは GroupSession 上で .
        これは、基本的にシステムがあなたのアプリケーションに代わってGroupSession上で.end()を呼び出すことです。
        これは、あなたがどんなに注意して.end()を呼び出さないようにしても、そのデバイスはあなたの代わりにGroupSession上で.end()を呼び出すことを意味します。
        end()を呼び出さないようにいくら注意しても、システムは、そのデバイスが所有者でない限り、GroupSession上で.end()を呼び出すことができるのです。
        end()を呼び出すことができるということです。
        このように、難しい概念かもしれませんが、アプリケーションが所有者意識を持たないようにすることは、全体として、より良いエクスペリエンスにつながるということを忘れないでください。
        セッションをすべてお聞きになった方は、アプリ内からSharePlayを起動するための新しいAPIを採用し、信頼性の低いメッセージを使用して、アプリが新しい低遅延の方法で通信する方法を探ってみてください。
        私たちは皆さんの声を聞くのが好きなので、引き続きフィードバック・アシスタントを使ってフィードバックをお寄せください。
        私たちが行ったすべての変更を楽しんでいただけたらと思いますし、皆さんが作る素晴らしい体験を見るのを楽しみにしています。
        まだの方は、私たちのWWDCでの講演「Make a great SharePlay experience（素晴らしいSharePlay体験を作ろう）」をご覧ください。
        また、メディア再生に関して行った素晴らしい機能拡張をお探しなら、「SharePlayにおけるディスプレイ広告とその他のインタースティシャル」をご覧ください。
        ご質問は、GroupActivitiesのラボやチャレンジでお受けしています。
        そして、素晴らしいWWDCをお過ごしください。
        そして、WWDCを楽しんでください。


        """
    }
}

