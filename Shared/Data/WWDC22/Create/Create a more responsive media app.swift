import Foundation

struct CreateAMoreResponsiveMediaApp: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }
    
    var title: String {
        "Create a more responsive media app"
    }
    
    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6734/6734_wide_250x141_2x.jpg")!
    }
    
    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/110379/")!
    }
    
    var english: String {
        """
        Jeremy: Hi.
         I'm Jeremy, and I'm here to show you how to create a more responsive media app using AVFoundation.
         When using media assets in your app, you might like to do more than just play them.
         You might like to show thumbnails, combine media into new compositions, or get information about your assets.
         These tasks require loading data, and with big files like video, that might take some time to complete.
         Unfortunately, it can be easy to introduce latency issues in your app if this work is done synchronously on the main thread.
         A great way to keep your app responsive is to load data asynchronously, and update your UI when it's finished.
         AVFoundation has tools to make this easy.
         So here's what we'll talk about today.
         First, I'll introduce you to some new async APIs in AVFoundation.
         Then, I'll give you an update on asset inspection using the async load(_:) method we introduced last year.
         And I'll show you how to optimize custom data loading for local and cached media using AVAssetResourceLoader.
         But first, let's jump into the new async API.
         Grabbing still images from a video with AVAssetImageGenerator is a great way to create thumbnails.
         But image generation isn't instantaneous.
        To generate an image, image generator needs to load frame data from your video file.
         And for media stored on a remote server, or on the internet, that loading will be much slower.
         That's why it's important how you generate your images.
         Using a method that loads data synchronously, like copyCGImage, on the main thread can cause your UI to freeze as it waits for video to be loaded.
         This year, we've added the image(at: time) async method which uses async/await to free up the calling thread while image generator loads data.
         Image generator returns a tuple with the image and its actual time in the asset.
         There are a few reasons the actual time may vary from the time you requested, but if you only want the image, you can directly access it with the .
        image property.
         Some frames in compressed video are easier to load than others.
         iFrames can be decoded independently, while other frames rely on nearby frames to be decoded.
         For your requested time, image generator by default will use the nearest iFrame to generate your image.
         It might be tempting to set the tolerances to zero to get the exact frame for your requested time.
         But keep in mind that that frame will likely be dependent on other nearby frames that image generator will also need to load.
         Instead, consider setting wide tolerances that will still give you the result you're looking for.
         Wide tolerances help image generator to minimize data loading by giving it more frames to pick from.
         The fewer frames it needs to load, the faster it can return an image.
        To get a series of images at several times in an asset, image generator has had generateCGImagesAsynchronously(forTimes:).
         However in Swift, there is some nuance to watch out for to use it.
         New this year we've added the images(for: times) method.
         It now takes an array of CMTimes, so you don't need to map them to NSValues first.
         It also provides its results using an Async Sequence.
         In Swift, sequences let you iterate over their items using a for in loop.
         For a sequence of items that aren't ready all at once, an async sequence lets you await the next element after each iteration.
         For each successfully generated image, the result includes the originally requested time and the actual time alongside the image.
         If it fails, the result has an error to explain why.
        And if you are only interested in the image, the result has properties to directly access its values, which can also throw errors if generation fails.
         To learn more about async sequences, I recommend checking out the "meet async sequence" session.
         For a task like image generation, it's a little easier to see how it involves loading data.
         But there are some other synchronous areas of AVFoundation that are harder to pick out as problem spots.
        AVMutableComposition is one of these areas.
         Insert time range for asset needs information about the asset's tracks to add references to them in the composition.
         It synchronously inspects the tracks, so if the tracks aren't already loaded, they'll be synchronously loaded to create the new composition tracks.
        Previously, the solution would've been to await loading the asset's tracks before inserting them into the composition.
         However, this year, we're introducing an async version of insertTimeRange, which will async load the tracks for you, as needed.
        Video composition and mutable video composition have additional methods that require loading the asset's properties too.
         New this year, the "propertiesOf asset" constructor, and isValid(for:timeRange:) method now also have async counterparts.
         These new methods will asynchronously load the tracks and duration of the asset, so there's no need for you to pre-load them either.
         These new async methods make it easier to interact with assets by loading the properties they need asynchronously.
         But for when you need to load the properties of an asset yourself, let's get a refresher of async asset inspection.
         You may have noticed there are two ways to inspect an asset's properties.
         When AVFoundation was introduced, the best way to inspect properties was with async key value loading.
         Last year, we introduced async load(_:).
         It uses type safe keys to identify the properties to load, where the old async key value loading technique used hard coded strings as keys.
         Typos in these string keys are difficult to catch.
         Misspelling a key prevents it from being loaded asynchronously, and when the property is later used, it'll block while it loads.
        It's also very easy to forget to add new properties to the keys to load or to forget async loading them entirely.
         For these reasons, this year, we're deprecating async key value loading and the synchronous properties in Swift, in favor for async load.
         Async load uses type safe identifiers to prevent typos.
         It directly returns property values as requested to avoid accessing unloaded properties.
         And since all of this is checked at compile time, you'll prevent introducing any new IO bound performance issues.
         Async load is now the only recommended way to asynchronously inspect properties on AVAsset, AVAssetTrack, AVMetadataItem, and their sub classes.
         However, a handful of these classes will still offer synchronous property inspection.
         That's because the data for their properties is already available in memory.
         Let's take another look at mutable composition to see why.
        We'll use a mutable composition to splice together segments of two existing video tracks.
         We'll start by creating an empty composition and adding an empty video track.
         Then, we can synchronously insert part of the first video track into the composition track.
         Behind the scenes, this step isn't loading any data.
         Instead, it adds a new track segment that points to the desired track.
        Then we can append part of the second track in the same way.
        Since the composition itself is backed by an in memory structure and not a file, we can safely inspect its properties synchronously without needing to load them first.
         Again, for this reason, synchronous property inspection will remain available on these classes and all classes will use async load for asynchronous inspection.
        All of these new async methods in AVFoundation will make it easier to prevent blocking while loading media data.
         But, introducing concurrency into your app for the first time can be tricky.
         Check out these sessions from WWDC 21 for help getting started with Swift concurrency and for migrating to AVFoundation's async load in your app.
         For our last topic, let's talk about optimizing custom data loading for your assets.
         To start, lets take a look at how AVAsset loads data by default.
         When you create an AVAsset with a URL, the media can either be on the network, or stored locally on device.
         If it's on the network, AVAsset will dynamically cache a certain amount of data to ensure smooth playback.
         If the media is local, AVAsset can bypass the cache and load data as needed to play.
         In some cases, you might not be able to give AVAsset a direct pointer to your media.
         Maybe you store the raw bytes of an mp4 inside of a custom project file.
         For situations like this, AVAsset can use an AVAssetResourceLoader.
         Resource loader provides the asset with a way to request arbitrary bytes from your media that you have a special way to load.
         But since the asset is no longer handling reading in data, it can't predict how long it'll take each chunk to load.
         So it assumes that accessing the media involves network communication, and waits until it caches data before it becomes ready to play.
         This year, if your media is locally available, you can enable entireLengthAvailableOnDemand for your resource loader.
         Setting this flag tells the asset that it can expect to receive data as it's requested, so it can skip caching.
        For local media, entireLengthAvailableOnDemand can help reduce your app's memory usage during playback, since it won't need to cache extra data.
         It can also decrease the time it takes to start playback, since the asset won't have to wait for the cache to fill up first.
         Use caution when enabling this flag, though.
         If loading requires any network operations, including network file storage, it's likely playback will be unreliable.
        That's the new enhancement for resource loader.
         Now lets wrap things up with some next steps for your app.
        When working with media, use async/await to keep your app responsive while it loads in the background.
         Consider increasing tolerances when using image generator for faster results.
         And if you are using resource loader for locally available media, enable entire length available on demand to help increase performance.
        That's everything I have for today.
         Thanks for watching, and enjoy WWDC 22.
        """
    }
    
    var japanese: String {
        """
        Jeremy: こんにちは。
         今回は、AVFoundationを使って、よりレスポンスのよいメディアアプリを作る方法を紹介します。
         アプリでメディア資産を使うとき、単に再生するだけでなく、もっといろいろなことがしたくなるかもしれません。
         サムネイルを表示したり、メディアを組み合わせて新しいコンポジションを作ったり、アセットに関する情報を取得したりしたいかもしれません。
         このような作業にはデータの読み込みが必要で、動画のような大きなファイルでは、完了までに時間がかかる場合があります。
         残念ながら、この作業をメインスレッドで同期的に行うと、アプリに遅延の問題が発生する可能性があります。
         アプリの応答性を保つには、データを非同期にロードし、終了したらUIを更新するのがよい方法です。
         AVFoundationには、これを簡単に行うためのツールがあります。
         では、今日お話しするのはこんな感じです。
         まず、AVFoundationの新しい非同期APIをいくつか紹介します。
         そして、昨年紹介した非同期load(_:)メソッドを使ったアセットインスペクションの最新情報をお伝えする予定です。
         そして、AVAssetResourceLoader を使って、ローカルメディアとキャッシュメディアに対するカスタムデータの読み込みを最適化する方法を紹介します。
         その前に、新しい非同期 API に飛び込んでみましょう。
         AVAssetImageGenerator を使って動画から静止画を取得することは、サムネイルを作成するための素晴らしい方法です。
         しかし、画像生成は瞬時に行われるわけではありません。
        画像を生成するために、イメージジェネレータはビデオファイルからフレームデータをロードする必要があります。
         そして、リモートサーバーやインターネット上に保存されているメディアの場合、その読み込みはかなり遅くなります。
         そのため、画像をどのように生成するかが重要なのです。
         copyCGImage のような同期的にデータをロードするメソッドをメインスレッドで使用すると、ビデオのロードを待つ間に UI がフリーズすることがあります。
         今年、私たちは image(at: time) 非同期メソッドを追加しました。これは async/await を使用して、image generator がデータをロードする間、呼び出し側のスレッドを解放するものです。
         Image generator は、画像とアセット内の実際の時刻をタプルで返します。
         実際の時刻が要求した時刻と異なる理由はいくつかありますが、画像だけが必要な場合は、.image プロパティを使用して直接アクセスできます。
        image プロパティで直接アクセスできます。
         圧縮されたビデオには、読み込みが容易なフレームがあります。
         iFrameは独立してデコードできますが、他のフレームは近くのフレームに依存してデコードされます。
         要求された時間に対して、デフォルトでイメージジェネレータは、画像を生成するために最も近いiFrameを使用します。
         要求された時間の正確なフレームを得るために許容誤差をゼロに設定したくなるかもしれません。
         しかし、そのフレームは、イメージジェネレーターが読み込む必要のある、他の近くのフレームに依存する可能性が高いことに留意してください。
         その代わりに、探している結果を得られるような広い許容範囲を設定することを考えましょう。
         広い公差は、イメージジェネレータがより多くのフレームから選ぶことで、データの読み込みを最 小限にするのに役立ちます。
         ロードするフレームが少なければ少ないほど、より速く画像を返すことができます。
        アセット内のいくつかの時間で一連の画像を取得するために、イメージジェネレータはgenerateCGImagesAsynchronously(forTimes:)を持っていました。
         しかしSwiftでは、これを使うには少し気をつけなければならないニュアンスがあります。
         今年新たにimages(for: times)メソッドを追加しました。
         これは今、CMTimesの配列を取るので、最初にNSValuesにそれらをマップする必要はありません。
         また、非同期シーケンスを使用してその結果を提供します。
         Swift では、シーケンスでは、for in ループを使用してそれらのアイテム上で反復することができます。
         一度にすべて準備ができていないアイテムのシーケンスのために、非同期シーケンスでは、各反復の後に次の要素を待つことができます。
         生成に成功した画像には、最初に要求された時刻と実際の時刻が表示されます。
         失敗した場合は、その理由を説明するエラーが結果に表示されます。
        また、画像にしか興味がない場合、resultにはその値に直接アクセスするためのプロパティがあり、これも生成に失敗するとエラーを投げることがあります。
         非同期シーケンスについてもっと知りたい方は、「非同期シーケンスに出会う」セッションをチェックすることをお勧めします。
         画像生成のようなタスクの場合、データの読み込みを伴うので少しわかりやすいと思います。
         しかし、AVFoundationの他の同期領域には、問題点としてピックアップするのが難しいものがあります。
        AVMutableCompositionはそのひとつです。
         アセットに時間範囲を挿入するには、コンポジションにトラックへの参照を追加するために、アセットのトラックに関する情報が必要です。
         これは同期的にトラックを検査するため、トラックがまだロードされていない場合、新しいコンポジションのトラックを作成するために同期的にロードされます。
        以前は、アセットのトラックをコンポジションに挿入する前に、アセットのトラックのロードを待つという解決策がありました。
         しかし今年は、必要に応じてトラックを非同期的にロードする、insertTimeRange の非同期バージョンを導入しています。
        ビデオ合成とミュータブル ビデオ合成には、アセットのプロパティをロードする必要があるメソッドも追加されています。
         今年の新機能として、"propertiesOf asset" コンストラクタと isValid(for:timeRange:) メソッドに、非同期の対応するメソッドが追加されました。
         これらの新しいメソッドは、アセットのトラックとデュレーションを非同期に読み込みますので、それらを事前に読み込む必要はありません。
         これらの新しい非同期メソッドは、必要なプロパティを非同期でロードすることで、アセットとの対話を容易にします。
         しかし、自分でアセットのプロパティを読み込む必要があるときのために、非同期アセット検査について再確認しておきましょう。
         アセットのプロパティを検査する方法が2つあることにお気づきかもしれません。
         AVFoundationが導入された当時、プロパティを検査するのに最適な方法は、非同期のキー値読み込みでした。
         昨年、私たちは非同期ロード(_:)を導入しました。
         これはロードするプロパティを特定するために型安全なキーを使用します。以前の非同期キー値ロード技術では、キーとしてハードコードされた文字列を使用していました。
         このような文字列のキーのタイプミスは捕捉するのが困難です。
         キーのスペルを間違えると、非同期で読み込むことができなくなり、後でそのプロパティが使用されたときに、読み込み中にブロックされてしまう。
        また、ロードするキーに新しいプロパティを追加するのを忘れたり、非同期ロードを完全に忘れたりすることも非常に簡単です。
         これらの理由から、今年、私たちは非同期のキー値のロードとSwiftの同期プロパティを非推奨とし、非同期ロードを採用することにしました。
         非同期ロードは、タイプセーフの識別子を使用して、タイプミスを防ぎます。
         ロードされていないプロパティにアクセスするのを避けるために、要求されたプロパティ値を直接返します。
         そして、これらすべてがコンパイル時にチェックされるため、新たなIOバウンドパフォーマンスの問題の発生を防ぐことができます。
         非同期ロードは、AVAsset、AVAssetTrack、AVMetadataItem、およびそれらのサブクラス上のプロパティを非同期に検査するための唯一の推奨方法となりました。
         しかし、これらのクラスの一握りは、まだ同期のプロパティ検査を提供します。
         それは、それらのプロパティのデータがすでにメモリ上で利用可能だからです。
         その理由を見るために、ミュータブルコンポジションをもう一度見てみましょう。
        ここでは、ミュータブルコンポジションを使って、2つの既存のビデオトラックのセグメントをつなぎ合わせることにします。
         まず、空のコンポジションを作成し、空のビデオトラックを追加します。
         次に、最初のビデオトラックの一部をコンポジショントラックに同期して挿入します。
         裏側では、このステップではデータを読み込んでいません。
         代わりに、目的のトラックを指す新しいトラックセグメントを追加しています。
        次に、2つ目のトラックの一部を同じように追加することができます。
        コンポジション自体はファイルではなく、インメモリ構造でバックアップされているので、最初にロードする必要がなく、安全に同期的にプロパティを検査することができます。
         このような理由から、これらのクラスでは、同期的なプロパティ検査は引き続き利用可能で、すべてのクラスは非同期的な検査に非同期ロードを使用することになります。
        AVFoundationのこれらの新しい非同期メソッドはすべて、メディアデータのロード中にブロックを防ぐことを容易にします。
         しかし、初めてアプリに並行処理を導入するのは厄介なものです。
         Swift の並行処理を始め、あなたのアプリで AVFoundation の非同期ロードに移行するためのヘルプとして、WWDC 21 からのこれらのセッションをチェックしてみてください。
         最後のトピックとして、アセットに対するカスタムデータ読み込みの最適化について説明します。
         まず、AVAssetがデフォルトでどのようにデータをロードするかを見てみましょう。
         URLを指定してAVAssetを作成する場合、メディアはネットワーク上にあるか、デバイスにローカルに保存されているかのどちらかになります。
         ネットワーク上にある場合、AVAssetはスムーズな再生のために一定量のデータを動的にキャッシュします。
         メディアがローカルにある場合、AVAsset はキャッシュをバイパスして、再生に必要なデータをロードします。
         場合によっては、AVAssetにメディアへの直接のポインタを与えることができないかもしれません。
         例えば、カスタムプロジェクトファイルの中にmp4の生バイトを保存している場合です。
         このような場合、AVAsset は AVAssetResourceLoader を使用することができます。
         リソースローダーは、メディアから任意のバイトを読み込むための特別な方法をアセットに要求する方法を提供します。
         しかし、アセットがデータを読み込む処理をしなくなったため、各チャンクの読み込みにかかる時間を予測することができません。
         そこで、メディアへのアクセスにはネットワーク通信が必要だと仮定し、データをキャッシュしてから再生できるようになるまで待ちます。
         今年、メディアがローカルで利用可能な場合は、リソース ローダーで entireLengthAvailableOnDemand を有効にすることができます。
         このフラグを設定すると、アセットに、要求されたとおりにデータを受け取ることを期待できることを伝え、キャッシュをスキップできるようになります。
        ローカルメディアでは、allLengthAvailableOnDemand を使用すると、余分なデータをキャッシュする必要がないため、再生時のアプリのメモリ使用量を減らすことができます。
         また、キャッシュが一杯になるのを待つ必要がないため、再生にかかる時間も短縮できます。
         ただし、このフラグを有効にするときは注意が必要です。
         読み込みにネットワーク操作（ネットワークファイルの保存など）が必要な場合、再生の信頼性が損なわれる可能性があります。
        以上が、リソースローダーに関する新しい機能強化です。
         さて、最後にあなたのアプリの次のステップを紹介します。
        メディアを扱うときは、async/awaitを使用して、バックグラウンドでロードしている間、アプリの応答性を維持するようにします。
         イメージジェネレータを使用する場合は、より高速な結果を得るために許容範囲を広げることを検討してください。
         また、ローカルで利用可能なメディアに対してリソースローダーを使用している場合は、オンデマンドで全長を利用できるようにすると、パフォーマンスが向上します。
        今日のところは以上です。
         ご視聴ありがとうございました。
        """
    }
}

