import Foundation

struct MeetSwiftAsyncAlgorithmsArticle: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Meet Swift Async Algorithms"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6709/6709_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/110355/")!
    }

    var english: String {
        """
        Hi, my name's Philippe.
         Swift has a growing catalog of open source packages.
         I am pleased to introduce you to one of the newest additions: Swift Async Algorithms.
         This package is alongside the other packages, like Swift Collections and Swift Algorithms.
         The Swift Async Algorithms package is a set of algorithms specifically focused on processing values over time using AsyncSequence.
         But before we get into it, let's take a brief moment to recap AsyncSequence.
         AsyncSequence is a protocol that lets you describe values produced asynchronously.
         Basically, it's just like Sequence, but has two key differences.
         The next function from its iterator is asynchronous, being that it can deliver values using Swift concurrency.
         It also lets you handle any potential failures using Swift's throw effect.
         And just like sequence, you can iterate it, using the for-await-in syntax.
         In short, if you know how to use Sequence, you already know how to use AsyncSequence.
         Now, when AsyncSequence was introduced, we added in almost all the tools you would expect to find with Sequence right there with the async versions.
         You have algorithms like map, filter, reduce, and more.
         The Swift Async Algorithms package takes this a step further by incorporating more advanced algorithms, as well as interoperating with clocks to give you some really powerful stuff.
         This is an open source package of AsyncSequence algorithms that augment Swift concurrency.
         Last year we introduced the Swift Algorithms package.
         To demonstrate the uses of those algorithms, we made a messaging app.
         This was a great example of some of the rich and powerful things you can do with that package.
         We decided there were a number of really good opportunities to take advantage of migrating the app to use Swift concurrency.
         To highlight just a few of the asynchronous algorithms, I'm gonna take you through some of the things that we used and how they work.
         First off, we have a family of algorithms for working with multiple input AsyncSequences.
         These are algorithms focused on combining AsyncSequences together in different ways.
         But they all share one characteristic: They take multiple input AsyncSequences and produce one output AsyncSequence.
        One you might already be familiar with is Zip.
         The Zip algorithm takes multiple inputs and iterates them such that it produces a tuple of the results from each of the bases.
         Each of the inputs to Zip are the bases that the Zip is constructed from.
         The asynchronous Zip algorithm works just like the Zip algorithm in the standard library, but it iterates each of the bases concurrently and rethrows errors if a failure occurs on iterating any of them.
         Now, accomplishing that concurrent iteration with rethrowing errors can be rather involved.
         But the Swift Async Algorithms package took care of all of that for us in our messaging app.
         We previously had a lot of code coordinating asynchronously generating previews of video recordings and transcoding video into multiple sizes for efficient storage and transmission.
         By using Zip we can ensure that the transcoded video gets a preview when we send it off to the server.
         Since Zip is concurrent, neither the transcoding or the preview will delay each other.
         But this goes a bit further.
         Zip itself has no preference on which side produced a value first or not, so a video could be produced first or a preview, and no matter which side it is, it will await for the other to send a complete tuple.
         We can await the pairs such that they can be uploaded together because Zip awaits each side concurrently to construct a tuple of the values.
         We came to the conclusion that modeling our incoming messages as an AsyncSequence made a lot of sense.
         So we decided to use AsyncStream to handle those messages since it preserves order and turns our callbacks into an AsyncSequence of messages.
         One of the requested features we needed to tackle is that we wanted to support multiple accounts.
         So each account creates an AsyncStream of incoming messages, but when implementing this, we need to handle them all together as one singular AsyncSequence.
         This means we needed an algorithm for merging those AsyncSequences together.
         Thankfully the Swift Async Algorithms package has an algorithm for exactly that, aptly named "Merge.
        " It works similarly to Zip in the regards that it concurrently iterates multiple AsyncSequences.
         But instead of creating paired tuples, it requires the bases to share the same element type and merges the base AsyncSequences into one singular AsyncSequence of those elements.
         Merge works by taking the first element produced by any of the sides when iterated.
         It keeps iterating until there are no more values that could be produced, specifically when all base AsyncSequences return nil from their iterator.
         If any of the bases produces an error, the other iterations are cancelled.
         This lets us take the AsyncSequences of messages and merge them.
         These combining algorithms work concurrently on when values are produced, but sometimes it is useful to actually interact with time itself.
         The Swift Async Algorithms package brings in a family of algorithms to work with time by leveraging the new Clock API in Swift.
         Time itself can be a really complex subject, and new in Swift (5.
        7) are a set of APIs to make that safe and consistent: Clock, Instant, and Duration.
        The Clock protocol defines two primitives, a way to wake up after a given instant and a way to produce a concept of now.
         There are a few built in clocks.
         Two of the more common ones are the ContinuousClock and the SuspendingClock.
         You can use the ContinuousClock to measure time just like a stopwatch, where time progresses no matter the state of the thing being measured.
         The SuspendingClock, on the other hand, does what its name implies; it suspends when the machine is put to sleep.
         We used the new clock API in our app to migrate from existing callback events to clock sleep function to handle dismissing alerts after a deadline.
         We were able to create the deadline by adding a duration value that indicated specifically the number of seconds we wanted to delay.
         Clock also has some handy methods to measure the elapsed duration of execution of work.
         Here we have those two common clocks I mentioned earlier, the SuspendingClock and ContinuousClock.
        Below are displays showing the potential elapsed duration of work being measured.
         The key difference between these two clocks comes from its behavior when the machine is asleep.
        For long running work like these, the work can be paused, just as we did here, but when we resume the execution, the ContinuousClock has progressed while the machine was asleep, but the SuspendingClock did not.
         Commonly, this difference can be the key detail to make sure things like animations work as expected by suspending the timing of the execution.
         If you need to interact with time in relation to the machine, like for animations, use the SuspendingClock.
        Measuring tasks in relation to the human in front of the device is better suited for the ContinuousClock.
         So if you need to delay by an absolute duration, something relative to humans, use the ContinuousClock.
         The Swift Async Algorithms package uses these new Clock, Instant, and Duration types to build generic algorithms for dealing with many of the concepts of how events are processed with regards to time.
         In our messaging app, we found these really helpful for providing precise control over events.
         It let us rate limit interactions and efficiently buffer messages.
        Perhaps the most prominent area that we utilized time was searching messages.
         We created a controller that manages a channel of results.
         The channel marshals search results from the search task back to our UI.
         The search task itself needed to have some specific characteristics with regards to time.
         We wanted to make sure to rate limit searching sent messages on the server.
        The algorithm Debounce awaits a quiescence period before it emits the next values when iterated.
         It means that events can come in fast, but we want to make sure to wait for a quiet period before dealing with values.
         When user input from a search field is changed rapidly, we don't want the search controller to fire off a search request for each change.
         Instead, we want to make sure to wait for a quiet period when we're certain typing was likely to be done.
         By default, the Debounce algorithm will use the ContinuousClock.
         In this case, we can debounce the input such that it awaits a specified duration while nothing has occurred.
         Clocks and durations are not just used for debouncing, but they're used for other algorithms too.
         One area that we found that was really useful was sending batches of messages to the server.
         In the Swift algorithms package, there's a set of algorithms to chunk values.
         The Swift Async Algorithms package offers those, but also adds a set of versions that interoperate with clocks and durations.
         The family of chunking algorithms allow for control over chunks by count, by time, or by content.
         If an error occurs in any of these, that error is rethrown, so our code is safe when it comes to failures.
        We used the "chunked(by:)" API to ensure that chunks of messages are serialized and sent off by a certain elapsed duration.
         That way, our server gets efficient packets sent from the clients.
         We were able to use this API to build batches of messages every 500 milliseconds.
         That way, if someone's really excited and typing really fast, the requests sent to the server are grouped up.
         When working with collections and sequence, it's often useful and performant to lazily process elements.
         AsyncSequence works much like how the lazy algorithms work in the Swift standard library.
         But just like those lazy algorithms, there are often times where you need to move back into the world of collections.
         The Swift Async Algorithms package offers a set of initializers for constructing collections using AsyncSequence.
         These let you build up dictionaries, sets, or arrays with input AsyncSequences that are known to be finite.
         The collection initializers let us build in conversions right into our initialization of messages and keep our data types as Array.
         This was really useful since we had numerous features that really could use some updating to use Swift concurrency.
         And by keeping our existing data structures, we can migrate parts of our app incrementally and where it makes sense.
         So far, we've just gone over just a handful of the highlights of Swift Async Algorithms package.
         There are a whole lot more than just what we've covered today.
         We have algorithms ranging from combining multiple AsyncSequences, rate limiting by time, breaking things into chunks, but those were just the highlights that we ended up using extensively in our app.
         This package has a lot more than just those.
         It ranges from buffering, reducing, joining, to injecting values intermittently, and more.
         The Swift Async Algorithms package takes the set of algorithms for dealing with things over time and expands it to a wide range of advanced functionality that can help you in your apps.
         Try it out.
         We're really excited to discover what you build with these, and that excitement is shared.
         This package is being developed in the open with you.
         Thanks for watching, and enjoy the rest of the conference.

        """
    }

    var japanese: String {
        """
        こんにちは、私の名前はPhilippeです。
         Swiftは、オープンソースパッケージのカタログを増やしています。
         私は、最新の追加パッケージの1つを紹介することを嬉しく思います。Swift Async Algorithms です。
         このパッケージは、Swift Collections や Swift Algorithms といった他のパッケージと一緒に並んでいます。
         Swift Async Algorithms パッケージは、特に AsyncSequence を使用して時間をかけて値を処理することに焦点を当てたアルゴリズムのセットです。
         しかし、それに入る前に、AsyncSequence を簡単に振り返ってみましょう。
         AsyncSequenceは、非同期に生成される値を記述するためのプロトコルです。
         基本的にはSequenceと同じなのですが、2つの重要な違いがあります。
         そのイテレータから次の関数は非同期であり、Swift の並行処理を使用して値を配信できることです。
         また、Swift の throw 効果を使用して、潜在的な失敗を処理することができます。
         そして、シーケンスと同じように、for-await-in構文を使用して、それを反復することができます。
         要するに、もしあなたがシーケンスの使い方を知っているなら、あなたはすでにAsyncSequenceの使い方を知っているのです。
         さて、AsyncSequenceが導入されたとき、Sequenceで期待されるほぼすべてのツールが非同期バージョンでそのまま追加されました。
         map、filter、reduce などのアルゴリズムがあります。
         Swift Async Algorithms パッケージは、より高度なアルゴリズムと、本当に強力なものを提供するためのクロックとの相互運用を組み込むことによって、これをさらに一歩進めています。
         これは Swift の並行処理を補強する AsyncSequence アルゴリズムのオープンソースパッケージです。
         昨年、私たちは Swift Algorithms パッケージを導入しました。
         これらのアルゴリズムの使い方を示すために、私たちはメッセージングアプリを作りました。
         これは、そのパッケージでできる豊かで強力なもののいくつかの素晴らしい例でした。
         私たちは、Swift の並行処理を使用するためにアプリを移行することを利用する、本当に良い機会がたくさんあることを決定しました。
         非同期アルゴリズムのほんの一部を強調するために、私たちが使用したものと、それらがどのように動作するかについて、説明したいと思います。
         まず最初に、複数の入力AsyncSequencesを処理するためのアルゴリズムのファミリーがあります。
         これらは、AsyncSequencesをさまざまな方法で組み合わせることに焦点を当てたアルゴリズムです。
         しかし、これらはすべて1つの特徴を共有しています：複数の入力AsyncSequenceを取り、1つの出力AsyncSequenceを生成します。
        既にお馴染みかもしれないが、Zipがある。
         Zipアルゴリズムは複数の入力を受け取り、それを反復して各基底からの結果のタプルを生成する。
         Zip の各入力は、Zip が構築されるベースです。
         非同期 Zip アルゴリズムは、標準ライブラリの Zip アルゴリズムと同様に動作しますが、各基底を同時に反復処理し、いずれかの反復処理に失敗した場合にエラーを再投与します。
         さて、このエラーを投げ直しながらの同時反復処理を実現するのは、かなり大変なことです。
         しかし、Swift Async Algorithms パッケージは、私たちのメッセージングアプリのためにそのすべてを引き受けました。
         以前は、ビデオ録画のプレビューを非同期に生成し、効率的なストレージと送信のためにビデオを複数のサイズにトランスコードすることを調整する多くのコードを持っていました。
         Zip を使用することで、トランスコードされた動画をサーバーに送信するときに、プレビューを確実に表示することができます。
         Zip は同時進行なので、トランスコードとプレビューのどちらも互いに遅れることはありません。
         しかし、これはもう少し先の話です。
         Zip 自身はどちらが先に値を生成するか、しないかについて優先順位を持たないので、ビデオが先に生成されるか、プレビューが生成されるか、それがどちらであっても、他方が完全なタプルを送信するのを待ちます。
         Zipは各サイドを同時に待ち、値のタプルを構築するので、一緒にアップロードできるようなペアを待つことができるのです。
         私たちは、受信メッセージをAsyncSequenceとしてモデル化することは、非常に理にかなっているという結論に達しました。
         つまり、AsyncStreamは順序を保持し、コールバックをメッセージのAsyncSequenceに変えるので、これらのメッセージを処理するために使用することにしたのです。
         私たちが取り組む必要があった要求された機能の1つは、複数のアカウントをサポートしたいということです。
         そのため、各アカウントは受信メッセージのAsyncStreamを作成しますが、これを実装する場合、それらをまとめて1つのAsyncSequenceとして処理する必要があります。
         これは、それらの AsyncSequence を一緒にマージするためのアルゴリズムが必要であることを意味します。
         ありがたいことに、Swift の Async Algorithms パッケージには、まさにそのためのアルゴリズムがあり、適切な名前の "Merge" があります。
        " 複数の AsyncSequence を同時に反復する点では、Zip と同様に動作します。
         しかし、ペアのタプルを作成するのではなく、ベースが同じ要素タイプを共有することを必要とし、ベースの AsyncSequence をそれらの要素の 1 つの単一 AsyncSequence にマージする。
         マージは、反復されたときにいずれかの側によって生成された最初の要素を取ることによって動作します。
         生成される値がなくなるまで、つまり、すべてのベース AsyncSequences がイテレータから nil を返すまで反復し続けます。
         いずれかのベースがエラーを生成した場合、他のイテレーションはキャンセルされる。
         これにより、メッセージのAsyncSequencesを取り、それらを結合することができます。
         これらの結合アルゴリズムは、値が生成されるときに同時に動作しますが、時には実際に時間そのものと対話することが有用です。
         Swift Async Algorithms パッケージは、Swift の新しい Clock API を活用することで、時間を扱うアルゴリズムのファミリーを取り込みます。
         時間自体は本当に複雑なテーマで、Swift の新しい (5.
        7) では、それを安全かつ一貫したものにするための API のセットが新たに追加されました。Clock、Instant、および Duration です。
        Clockプロトコルは、2つのプリミティブ、与えられた瞬間の後に目を覚ます方法と、今の概念を生成する方法を定義しています。
         組み込みのクロックはいくつかある。
         よく使われるのは、ContinuousClockとSuspendingClockの2つ。
         ContinuousClockは、ストップウォッチのように時間を計測することができ、計測されるものの状態に関係なく時間が進行する。
         一方、SuspendingClockは、その名の通り、マシンがスリープ状態になると停止する。
         私たちのアプリでは、新しい時計APIを使って、既存のコールバック・イベントから時計のスリープ関数に移行し、期限後のアラートの解除を処理するようにしました。
         遅延させたい秒数を具体的に示す duration 値を追加することで、デッドラインを作成することができました。
         時計には、作業の実行時間の経過を測定するための便利なメソッドもあります。
         ここでは、先ほど紹介したSuspendingClockとContinuousClockの2つの一般的なクロックを使用しています。
        下図は、測定された作業時間の経過を示す表示です。
         この2つのクロックの大きな違いは、マシンがスリープしているときの動作にある。
        このような長時間の作業では、今回のように作業を一時停止することができますが、実行を再開すると、マシンがスリープしている間にContinuousClockは進行していますが、SuspendingClockは進行していないことになります。
         一般的に、この違いは、実行のタイミングを一時停止することで、アニメーションのようなものが期待通りに動作することを確認するための重要な詳細となり得ます。
         もし、アニメーションのように、マシンとの関係で時間を操作する必要がある場合は、SuspendingClockを使用してください。
        デバイスの前にいる人間との関係でタスクを測定する場合は、ContinuousClockが適している。
         ですから、絶対的な時間、人間との相対的な何かによって遅延させる必要がある場合は、ContinuousClockを使用してください。
         Swift Async Algorithms パッケージは、イベントが時間に関して処理される方法の概念の多くを扱うための汎用アルゴリズムを構築するために、これらの新しい Clock、Instant、および Duration 型を使用します。
         私たちのメッセージング・アプリでは、イベントを正確に制御するために、これらが本当に役に立つことがわかりました。
         これにより、インタラクションを制限し、メッセージを効率的にバッファリングできるようになりました。
        おそらく、時間を利用する最も顕著な領域は、メッセージの検索でしょう。
         私たちは、検索結果のチャンネルを管理するコントローラを作成しました。
         このチャンネルは、検索タスクから UI に戻ってきた検索結果をマーシャルします。
         検索タスクは、時間に関していくつかの特別な特性を持つ必要がありました。
         サーバに送信されるメッセージの検索を制限することを確認したかったのです。
        Debounceアルゴリズムは、反復処理されたときに次の値を出力する前に静止期間を待ちます。
         つまり、イベントは高速にやってくるが、値を扱う前に静止期間を待つようにしたいのです。
         検索フィールドからのユーザー入力が急激に変更された場合、変更のたびに検索コントローラが検索リクエストを発行するのは避けたい。
         その代わりに、入力が行われそうだと確信できる静かな期間を待つようにしたいのです。
         デフォルトでは、Debounceアルゴリズムは、ContinuousClockを使用します。
         この場合、何も発生していない状態で指定された時間だけ入力を待つようにデバウンスすることができます。
         クロックと継続時間はデバウンスに使用されるだけでなく、他のアルゴリズムにも使用されます。
         私たちが本当に便利だと感じた1つの領域は、サーバーにメッセージのバッチを送信することでした。
         Swift のアルゴリズムパッケージには、値をチャンクするための一連のアルゴリズムがあります。
         Swift の非同期アルゴリズムパッケージは、それらを提供するだけでなく、クロックとデュレーションと相互運用するバージョンのセットも追加しています。
         チャンキングアルゴリズムのファミリーは、カウント、時間、または内容によってチャンクを制御することができます。
         これらのいずれかにエラーが発生した場合、そのエラーは再投げされるので、私たちのコードは失敗しても安全です。
        私たちは "chunked(by:) "を使いました。APIを使用して、メッセージのチャンクがシリアライズされ、ある経過時間までに送信されるようにしました。
         そうすれば、サーバーはクライアントから送られてくるパケットを効率的に受け取ることができます。
         私たちはこのAPIを使って、500ミリ秒ごとにメッセージのバッチをビルドすることができました。
         そうすれば、誰かが興奮して速くタイピングしても、サーバーに送信されるリクエストはグループ化されます。
         コレクションとシーケンスで作業する場合、要素を遅延処理するのが便利でパフォーマンスも良いことが多い。
         AsyncSequence は、Swift 標準ライブラリで遅延アルゴリズムがどのように動作するかによく似ています。
         しかし、それらの怠惰なアルゴリズムと同様に、コレクションの世界に戻る必要がある場合がよくあります。
         Swift の非同期アルゴリズムパッケージは、AsyncSequence を使用してコレクションを構築するための初期化子のセットを提供します。
         これらは、有限であることが知られている入力 AsyncSequence を使用して、辞書、セット、または配列を構築することができます。
         コレクション・イニシャライザーは、メッセージの初期化で変換を組み込み、データ型をArrayのまま維持することができます。
         Swift の並行処理を使用するために、本当にいくつかの更新を使用できる多数の機能があったので、これは本当に便利でした。
         そして、既存のデータ構造を維持することによって、私たちのアプリケーションの一部を、意味のある場所で、段階的に移行することができます。
         これまでのところ、Swift 非同期アルゴリズムパッケージのハイライトのほんの一握りを見てきました。
         今日取り上げたものだけでなく、もっとたくさんのものがあります。
         複数の AsyncSequence を組み合わせることから、時間による速度制限、チャンクへの分割まで、さまざまなアルゴリズムがありますが、これらは私たちのアプリで広範囲に使用することになったハイライトにすぎません。
         このパッケージには、これら以外にも多くの機能があります。
         バッファリング、削減、結合、断続的な値の注入など、多岐にわたります。
         Swift Async Algorithms パッケージは、時間をかけて物事を処理するための一連のアルゴリズムを、あなたのアプリで役立つ幅広い高度な機能へと拡張したものです。
         試してみてください。
         私たちは、あなたがこれらを使って何を作るか、とても楽しみにしていますし、その興奮は共有されています。
         このパッケージは、みなさんと一緒にオープンに開発しています。
         ご視聴ありがとうございました。残りのカンファレンスもお楽しみください。

        """
    }
}

