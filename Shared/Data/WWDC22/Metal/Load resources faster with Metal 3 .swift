import Foundation

struct LoadResourcesFasterWithMetal3: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Load resources faster with Metal 3"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6598/6598_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10104/")!
    }

    var english: String {
        """
        Hi, my name is Jaideep Joshi, and I'm a GPU software engineer at Apple.
         In this session, I will introduce a new feature in Metal 3 that will simplify and optimize resource loading for your games and apps.
         I'll start by showing you how the fast resource loading feature can fit into your app's asset-loading pipeline.
         It has several key features that harness new storage technologies on Apple products.
         Fast resource loading has some advanced features that solve interesting scenarios your applications may run into.
         There are a few best practice recommendations you should know about that will help you effectively use these features in your apps.
         As you add fast resource loading to your apps, tools like Metal System Trace and the GPU debugger can help profile and fix issues you may run into.
         At the end, I'll walk through an example that shows fast resource loading in action.
         So here's what you can do with Metal 3's fast resource loading.
        With Metal 3's fast resource loading, your games and apps can load assets with low latency and high throughput by taking advantage of the Apple silicon unified memory architecture and fast SSD storage included with Apple platforms.
         You will learn the best ways to stream data and reduce load times to ensure that your game's assets are ready on time.
         A key aspect of reducing load times is to load only what you need at the smallest possible granularity.
         The high throughput and low latency in Metal 3 lets your apps stream higher-quality assets, including textures, audio, and geometry data.
         Now I'll walk you through an example of asset loading in a game.
         Games typically show a loading screen when they first start up, or at the beginning of a new level, so they can load the game's assets into memory.
         As the player moves through the level, the game loads more assets for the scene.
         The downside is the player has to wait a long time while the game makes multiple requests to the storage system to load assets up front.
         Plus, those assets can have a large memory footprint.
         There are a few ways to improve this experience.
         Games can improve this experience by dynamically streaming objects as the player gets closer to them.
         This way, the game only loads what it needs at first and gradually streams other resources as the player moves through the level.
         For example, the game initially loads this chalkboard at a lower resolution, but as the player walks towards it, the game loads a higher-resolution version.
         This approach reduces the time the player waits at the loading screen.
         However, the player might still see lower-resolution items in the scene even when they are up close, because it takes too long to load the higher-resolution versions.
         One way to deal with this is to stream smaller portions of each asset.
         For example, your game could load only the visible regions of the scene with sparse textures that stream tiles instead of whole mip levels.
         This vastly reduces the amount of data your app needs to stream.
         With that approach, the load requests get smaller, and there are more of them.
         But that's OK, because modern storage hardware can run multiple load requests at once.
         This means that you can increase the resolution and scale of your scene without compromising the gameplay.
         Along with issuing a large number of small-load requests, you also have the ability to prioritize your load requests, to ensure that high-priority requests finish in time.
         Now that I have covered the ways to boost visual fidelity of games while reducing load times, I'll show you how Metal 3's fast resource loading helps you do this.
         Fast resource loading is an asynchronous API that loads resources from storage.
         Unlike existing load APIs, the thread which issues the loads does not need to wait for the loads to finish.
         The load operations execute concurrently to better utilize the throughput of faster storage.
         You can batch load operations to further minimize the overhead of resource loading.
         And finally, with Metal 3, you can prioritize load operations for lower latency.
         Now I'll show you the key features that will help you build your asset-loading pipeline, starting with the steps to load resources.
         There are three steps to load resources: open a file, issue the necessary load commands, and then synchronize these load commands with rendering work.
         Here's how you do that, starting with opening a file.
         You open an existing file by creating a file handle with a Metal device instance.
         For example, this code uses the Metal device instance to create a file handle by calling its new makeIOHandle method with a file path URL.
         Once you have a file handle, you can use it to issue load commands.
         Here's a typical scenario in an application, where it performs load operations and encodes GPU work.
         With existing load APIs, the app has to wait for the loading work to finish before it can encode the rendering work.
         Metal 3 lets your app asynchronously execute load commands.
         Start by creating a Metal IO command queue.
         Then use that queue to create IO command buffers and encode load commands to those buffers.
         However, as command buffers execute asynchronously on the command queue, your app does not need to wait for the load operations to finish.
         In fact, not only do all commands within an IO command buffer execute concurrently, IO command buffers themselves execute concurrently and complete out of order.
         This concurrent execution model better utilizes faster-storage hardware by maximizing throughput.
         You can encode three types of IO commands to a command buffer: loadTexture, which loads to a Metal texture for texture streaming; loadBuffer, which loads to a Metal buffer for streaming scene or geometry data; and loadBytes, which loads to CPU-accessible memory.
         You create IO command buffers from an IO command queue.
         To create a queue, first make and configure an IO command queue descriptor.
         By default, the queues are concurrent, but you can also set them to run command buffers sequentially and completely in order.
         Then pass the queue descriptor to the Metal device instance's makeIOCommandQueue method.
         Create an IO command buffer by calling the command queue's makeCommandBuffer method.
         Then use that command buffer to encode load commands that load textures and buffers.
         Metal's validation layer will catch encoding errors at runtime.
         The load commands are what use the fileHandle instance created earlier.
         When you are done adding load commands to a command buffer, submit it to the queue for execution by calling the command buffer's commit method.
         Now that I've covered how to create IO command queues, command buffers, issue load commands, and submit them to the queue, I want to show you how you can synchronize loading work with the other GPU work.
         An app typically kicks off its rendering work after it finishes loading resources for that rendering.
         But an app that uses fast resource loading needs a way to synchronize the IO command queue with the render command queue.
         You can synchronize these queues with a Metal shared event.
         Metal hared events let you synchronize the command buffers from your IO queue with the command buffers from your rendering queue.
         You can tell a command buffer to wait for a shared event by encoding a waitEvent command.
         Similarly, you can tell that command buffer to signal a shared event by encoding a signalEvent command.
         Metal ensures that all IO commands within the command buffer are complete before it signals the shared event.
         To synchronize between command buffers, you first need a Metal shared event.
         You can tell a command buffer to wait for a shared event by calling its waitForEvent method.
         Similarly, you can tell a command buffer to signal a shared event by calling its signalEvent method.
         You can add similar logic to a corresponding GPU command buffer so that it waits for the IO command buffer to signal the same shared event.
         To recap, here are the key features and APIs that load resources in your Metal apps.
         Open a file by creating a Metal file handle.
         Issue load commands by creating an IO command queue and an IO command buffer.
         Then, encode load commands to the command buffer for execution on the queue.
         And finally, use wait and signalEvent commands with Metal shared events to synchronize loading and rendering.
         Now, I'll go over a few advanced features that you might find helpful.
         Here's a typical scenario where a game can't fit its entire map in memory, which is why it subdivides the map into regions.
         As the player progresses through the map, the game starts preloading regions of the map.
         Based on the player's direction, the game determines that the best regions to preload are the northwest, west, and southwest regions.
         However, once the player moves to the western region and starts heading south, preloading the northwestern region is no longer beneficial.
         To reduce the latency of future loads, Metal 3 allows you to attempt to cancel load operation.
         Let's look at how to do that in practice.
         When the player is in the center region, encode and commit IO command buffers for three regions.
         Then when the player is in the western region and heading south, use the tryCancel method to cancel the loads for the northwestern region.
         Cancelling is at the command buffer granularity, so you can cancel the command buffer mid-execution.
         If at some later point, you want to know whether the region was completely loaded, you can check the status of the command buffer.
         Metal 3 also lets you prioritize your IO work.
         Consider a game scenario where the player teleports to a new part of the scene and your game starts streaming in large amounts of graphics assets.
         At the same time, the game needs to play the teleportation sound effect.
         Fast resource loading allows you to load all your app's assets, including audio data.
         To load audio, you can use the loadBytes command discussed earlier to load to application-allocated memory.
         In this example, texture and audio IO command buffers are concurrently executing on a single IO command queue.
         This simplified diagram shows the requests at the storage layer.
         The storage system is able to execute both audio and texture load requests in parallel.
         To avoid delayed audio, it is critical that the streaming system be able to prioritize audio requests over texture requests.
         To prioritize audio requests, you can create a separate IO command queue, and set its priority to high.
         The storage system will ensure that high-priority IO requests have a lower latency and are prioritized over other requests.
         After creating a separate high-priority queue for audio assets, the execution time of the audio load requests has gotten smaller, while that of the parallel texture load requests has gotten larger.
         Here's how you create a high-priority queue.
         Simply set the command queue descriptor's priority property to high.
         You can also set the priority to normal or low, then create a new IO command queue from the descriptor as usual.
         Just remember that you cannot change a queue's priority level after you create it.
         As you add fast resource loading to your apps, here's some best practices to keep in mind.
         First, consider compressing your assets.
         You can reduce your app's disk footprint by using built-in or custom compression.
         Compression lets you trade runtime performance for a smaller disk footprint.
         Additionally, you can improve storage throughput by tuning the sparse page size when using sparse textures.
         I'll go through each of these in more detail, starting with compression.
         You can use Metals 3's APIs to compress your asset files offline.
         First, create a compression context and configure it with a chunk size and compression method.
         Then pass parts of your asset files to the context to produce a single compressed version of all your files.
         The compression context works by chunking all the data and compresses it with the codec of your choosing and stores it to a pack file.
         In this example, the context compresses the data in 64K chunks, but you can choose a suitable chunk size based on the size and type of data you want to compress.
         Here's how you use the compression APIs in Metal 3.
         First, create a compression context by providing a path for creating the compressed file, a compression method, and a chunk size.
         Next, get file data and append it to the context.
         Here, the file data is in an NSData object.
         You can append data from different files by making multiple calls to append data.
         When you're done adding data, finalize and save the compressed file by calling the flush and destroy compression context function.
         You can open and access a compressed file by creating a file handle.
         This file handle is used when issuing load commands.
         For compressed files, Metal 3 performs inline decompression, by translating the offsets to a list of chunks it needs to decompress, and loads them to your resources.
         You create a file handle with a Metal device instance.
         For example, this code uses the Metal device instance to create a file handle by providing the compressed file path to the makeIOHandle method I covered earlier.
         For compressed files, an additional parameter is the compression method.
         This is the same compression method you used at the time of creating the compressed file.
         Now, I'll go through the different compression methods supported and the characteristics of each of them, so you can better understand how to choose between them.
         Use LZ4 when decompression speed is critical and your app can afford a large disk footprint.
         If a balance between codec speed and compression ratio is important to you, use ZLib, LZBitmap, or LZFSE.
         Amongst the balanced codecs, ZLib works better with non-Apple devices.
         LZBitmap is fast at encoding and decoding, and LZFSE has a high compression ratio.
         If you need the best compression ratio, consider using the LZMA codec, if your app can afford the extra time it takes to decode assets.
         It is also possible to use your own compression scheme.
         You may have cases where your data benefits from a custom compression codec.
         In that case, you can replace the compression context with your own compressor and translate offsets and perform decompression at runtime yourself.
         Now that you have seen how to use compression to reduce disk footprint, let's look at tuning sparse page size.
         Earlier versions of Metal support loading tiles to sparse textures at a 16K granularity.
         With Metal 3, you can specify two new sparse tile sizes: 64 and 256K.
         These new sizes let you to stream textures at a larger granularity to better utilize and saturate the storage hardware.
         Note that there is a tradeoff between streaming larger tiles sizes and the amount of data you stream, so you'll have to experiment to see which sizes work best with your app and its sparse textures.
         Next, let's look at how you can use the set of Metal Developer Tools to profile and debug fast resource loading in your app.
         Xcode 14 includes full support for fast resource loading.
         From runtime profiling with Metal System Trace to API inspection and advanced dependency analysis with Metal debugger.
        Let's start with runtime profiling.
         In Xcode 14, Instruments can profile fast resource loading with the Metal System Trace template.
         Instruments is a powerful analysis and profiling tool that will help you achieve the best performance in your Metal app.
         The Metal System Trace template allows you to check when load operations are encoded and executed.
         You will be able to understand how they correlate with the activity that your app is performing on both the CPU and the GPU.
         To learn how to profile your Metal app with Instruments, please check out these previous sessions, "Optimize Metal apps and games with GPU counters" and "Optimize high-end games for Apple GPUs.
        " Now, let's switch gears to debugging.
         With the Metal debugger in Xcode 14, you can now analyze your game's use of the new fast resource loading API.
         Once you take a frame capture, you will be able to inspect all fast resource loading API calls.
         From the IO command buffers created to the load operations that were issued.
         You can now visually inspect fast resource loading dependencies with the new Dependency viewer.
         The Dependency viewer gives a detailed overview of resource dependencies between IO command buffers and Metal passes.
         From here, you can use all the features in the new Dependency viewer, such as the new synchronization edges and graph filtering, to deep dive and optimize your resource loading dependencies.
         To learn more about the new Dependency viewer in Xcode 14, please check out this year's "Go bindless with Metal 3" session.
         Now, let's look at fast resource loading in action.
         This is a test scene that uses the new fast resource loading APIs to stream texture data by using sparse textures with a tile size of 16 kilobytes.
         This video is from a MacBook Pro with an M1 Pro chip.
         The streaming system queries the GPU's sparse texture access counters to identify two things: the tiles it has sampled but not loaded and the loaded tiles the app isn't using.
         The app uses this information to encode a list of loads for the tiles it needs and a list of evictions for tiles it doesn't need.
         That way, the working set contains only the tiles the app is mostly likely to use.
         If the player decides to travel to another part of the scene, the app needs to stream in a completely new set of high-resolution textures.
         If the streaming system is fast enough, the player will not notice this streaming occurring.
         If I pause the scene, you can observe the image differences more clearly.
         The left side is loading sparse tiles on a single thread using the pread API.
         The right side is loading sparse tiles using the fast resource loading APIs.
         As the player enters the scene, most of the textures haven't fully loaded.
         Once the loads complete, the final high-resolution version of the textures is visible.
         If I go back to the beginning of this scene and slow it down, it is easier to notice the improvements that fast resource loading provides.
         To highlight the differences, this rendering marks tiles the app has not yet loaded with a red tint.
         At first, the scene shows that the app hasn't loaded most of the tiles.
         However, as the player enters the scene, fast resource loading improves the loading of high-resolution tiles and minimizes the delay compared to the single-threaded pread version.
         Metal 3's fast resource loading helps you build a powerful and efficient asset-streaming system that lets your app take advantage of the latest storage technologies.
         Use it to reduce load times by streaming assets just in time, including higher-quality images.
         Use Metal's shared events to asynchronously load assets while the GPU renders a scene.
         For assets that your app needs in a hurry, minimize latency by creating a command queue with a higher priority.
         And remember, keep the storage system busy by sending load commands early.
         You can always cancel the ones you don't need.
         Fast resource loading in Metal 3 introduces new ways to harness the power of modern storage hardware for high-throughput asset loading.
         I can't wait to see how you use these features to improve your app's visual quality and responsiveness.
         Thanks for watching.

        """
    }

    var japanese: String {
        """
        こんにちは、AppleでGPUソフトウェアエンジニアをしているJaideep Joshiです。
         このセッションでは、ゲームやアプリのリソースロードを簡素化し、最適化するMetal 3の新機能を紹介します。
         まず、高速リソースローディング機能がどのようにアプリのアセットローディングパイプラインに適合するかを紹介します。
         この機能には、Apple製品の新しいストレージ技術を利用したいくつかの重要な機能があります。
         高速リソース読み込みには、アプリケーションが遭遇する可能性のある興味深いシナリオを解決する、いくつかの高度な機能があります。
         これらの機能をアプリケーションで効果的に使用するために、知っておくべきいくつかのベストプラクティスの推奨事項があります。
         アプリに高速リソースローディングを追加する際、Metal System Trace や GPU デバッガなどのツールは、遭遇する可能性のある問題のプロファイリングや修正に役立つことがあります。
         最後に、高速リソースローディングの動作を示す例を紹介します。
         それでは、Metal 3の高速リソースローディングで何ができるかを説明します。
        Metal 3の高速リソースロードでは、Appleプラットフォームに搭載されているAppleシリコン統一メモリアーキテクチャと高速SSDストレージを活用することで、ゲームやアプリが低レイテンシーかつ高スループットでアセットをロードすることが可能です。
         ゲームのアセットを時間通りに準備するために、データをストリーミングしてロード時間を短縮する最適な方法を学びます。
         ロード時間を短縮するための重要なポイントは、可能な限り小さな粒度で必要なものだけをロードすることです。
         Metal 3 の高いスループットと低いレイテンシーにより、テクスチャ、オーディオ、ジオメトリデータなど、より高品質なアセットをアプリケーションでストリーミングすることができます。
         次に、ゲームにおけるアセットローディングの例を説明します。
         ゲームは通常、最初の起動時や新しいレベルの開始時にローディング画面を表示し、ゲームのアセットをメモリにロードします。
         プレイヤーがレベル内を移動すると、そのシーンに必要なアセットがさらにロードされます。
         しかし、ゲーム側がアセットをロードするためにストレージシステムに何度もリクエストを出すため、プレイヤーは長い時間待たされることになります。
         さらに、これらのアセットは大きなメモリフットプリントを持つ可能性があります。
         この問題を解決するには、いくつかの方法があります。
         ゲームでは、プレイヤーがオブジェクトに近づくにつれて、オブジェクトを動的にストリーミングすることで、このエクスペリエンスを改善することができます。
         この方法では、ゲームは最初に必要なものだけをロードし、プレイヤーがレベル内を移動するにつれて他のリソースを徐々にストリームします。
         たとえば、この黒板は最初は低解像度で読み込まれますが、プレイヤーが歩いてくると高解像度のものが読み込まれます。
         こうすることで、プレイヤーがローディング画面で待つ時間が短縮されます。
         しかし、高解像度のものを読み込むのに時間がかかりすぎるため、プレーヤーは低解像度のものを近くに置いても見えてしまうことがあります。
         この問題を解決する方法の1つは、各アセットの一部をストリーミングすることです。
         たとえば、ゲームでは、ミップレベル全体ではなくタイルをストリームする疎なテクスチャでシーンの見える領域のみをロードすることができます。
         これにより、アプリがストリームする必要のあるデータ量が大幅に削減されます。
         この方法では、ロードリクエストは小さくなりますが、その数は多くなります。
         しかし、最新のストレージハードウェアは、複数のロードリクエストを一度に実行できるので、それで十分なのです。
         つまり、ゲームプレイを損なうことなく、シーンの解像度とスケールを上げることができるのです。
         小さなロードリクエストを大量に発行するのと同時に、ロードリクエストに優先順位をつけて、優先度の高いリクエストが時間内に終了するようにすることもできます。
         ここまで、ゲームのビジュアルを忠実に再現しつつ、ロード時間を短縮する方法について説明してきましたが、Metal 3の高速リソースローディングがどのように役立つかを紹介します。
         高速リソースロードは、ストレージからリソースをロードする非同期APIです。
         既存のロードAPIとは異なり、ロードを発行するスレッドはロードの終了を待つ必要がありません。
         ロード操作は同時に実行され、高速なストレージのスループットをより有効に活用することができます。
         リソースロードのオーバーヘッドをさらに最小化するために、ロード操作をバッチ処理することができます。
         そして最後に、Metal 3では、ロードオペレーションに優先順位をつけて、レイテンシーを低くすることができます。
         それでは、リソースロードの手順から、アセットロードパイプラインの構築に役立つ主要な機能を紹介します。
         リソースのロードには、ファイルを開く、必要なロードコマンドを発行する、そしてそのロードコマンドをレンダリング作業と同期させる、という3つのステップがあります。
         まず、ファイルを開くところから説明します。
         既存のファイルを開くには、Metalのデバイスインスタンスでファイルハンドルを作成します。
         例えば、このコードでは、Metalデバイスインスタンスを使用して、ファイルパスのURLを指定して新しいmakeIOHandleメソッドを呼び出し、ファイルハンドルを作成します。
         ファイルハンドルが作成されると、それを使ってロードコマンドを発行することができます。
         ここでは、アプリケーションでロード操作を実行し、GPU作業をエンコードする典型的なシナリオを紹介します。
         既存のロードAPIでは、アプリはレンダリング作業をエンコードする前に、ロード作業が終了するのを待たなければなりません。
         Metal 3では、アプリが非同期にロードコマンドを実行することができます。
         まず、MetalのIOコマンドキューを作成します。
         次に、そのキューを使用してIOコマンドバッファを作成し、それらのバッファにロードコマンドをエンコードします。
         しかし、コマンドバッファはコマンドキュー上で非同期に実行されるので、アプリケーションはロードオペレーションが終了するのを待つ必要はありません。
         実際、IO コマンドバッファ内のすべてのコマンドが同時に実行されるだけでなく、IO コマンドバッファ自体も同時に実行され、順番に完了することはありません。
         この同時実行モデルは、スループットを最大化することによって、より高速なストレージハードウェアをよりよく利用します。
         loadTextureはテクスチャストリーミングのためにMetalテクスチャにロードし、loadBufferはシーンまたはジオメトリデータストリーミングのためにMetalバッファにロードし、loadBytesはCPUアクセス可能メモリにロードするコマンドバッファに3種類のIOコマンドをエンコードすることができる。
         IOコマンドバッファは、IOコマンドキューから作成します。
         キューを作成するには、まずIOコマンドキューディスクリプターを作成し、設定します。
         デフォルトでは、キューは同時実行ですが、コマンドバッファを順次、完全に順番に実行するように設定することも可能です。
         次に、キュー記述子をMetalデバイスインスタンスのmakeIOCommandQueueメソッドに渡します。
         コマンドキューのmakeCommandBufferメソッドを呼び出して、IOコマンドバッファを作成します。
         そして、そのコマンドバッファを使用して、テクスチャやバッファをロードするロードコマンドをエンコードします。
         Metalの検証レイヤーは、実行時にエンコーディングエラーを検出します。
         ロードコマンドは、先に作成したfileHandleインスタンスを使用するものです。
         コマンドバッファにロードコマンドを追加し終えたら、コマンドバッファのコミットメソッドを呼び出して実行キューに投入します。
         IO コマンドキュー、コマンドバッファの作成、ロードコマンドの発行、キューへの投入を説明したところで、ロード作業と他の GPU 作業を同期させる方法を紹介したいと思います。
         通常、アプリはレンダリング用のリソースのロードが終了すると、レンダリング 作業を開始します。
         しかし、高速なリソースロードを使用するアプリは、IO コマンドキューとレンダリングコマンドキューを同期させる方法が必要です。
         これらのキューは、Metal共有イベントを使用して同期させることができます。
         Metal共有イベントを使用すると、IOキューのコマンドバッファとレンダリングキューのコマンドバッファを同期させることができます。
         コマンドバッファに共有イベントを待つように指示するには、waitEventコマンドをエンコードします。
         同様に、signalEventコマンドをエンコードすることで、コマンドバッファに共有イベントを通知するように指示することができます。
         Metalは、共有イベントを通知する前に、コマンドバッファ内のすべてのIOコマンドが完了することを保証します。
         コマンドバッファ間の同期を取るには、まずMetalの共有イベントが必要です。
         コマンドバッファのwaitForEventメソッドを呼び出すことで、共有イベントを待つようにコマンドバッファに指示することができます。
         同様に、コマンドバッファの signalEvent メソッドを呼び出すことで、コマンドバッファに共有イベントを通知させることができます。
         対応する GPU コマンドバッファに同様のロジックを追加して、IO コマンドバ ッファが同じ共有イベントを通知するのを待つようにすることができます。
         要約すると、Metalアプリケーションでリソースをロードするための主要な機能とAPIは次のとおりです。
         Metalファイルハンドルを作成してファイルを開きます。
         IOコマンドキューとIOコマンドバッファを作成し、ロードコマンドを発行する。
         次に、キューで実行するために、ロードコマンドをコマンドバッファにエンコードします。
         最後に、WaitコマンドとSignalEventコマンドをMetalの共有イベントと組み合わせて、ロードとレンダリングを同期させます。
         さて、ここで、役に立つと思われるいくつかの高度な機能について説明します。
         典型的なシナリオとして、ゲームではマップ全体をメモリに収めることができないため、マップを地域に分割しています。
         プレイヤーがマップを進むと、ゲームはマップの領域のプリロードを開始します。
         プレイヤーの進行方向から、北西、西、南西の3つの地域が最適と判断され、プリロードされます。
         しかし、プレイヤーが西部地域に移動し、南下し始めると、北西部地域のプリロードは有益ではなくなります。
         将来のロードの待ち時間を短縮するために、Metal 3ではロード操作のキャンセルを試みることができます。
         実際にどのように行うか見てみましょう。
         プレイヤーが中央のリージョンにいるとき、3つのリージョンのIOコマンドバッファをエンコードしてコミットします。
         そしてプレイヤーが西のリージョンにいて南に向かっているときに、tryCancelメソッドを使って北西のリージョンに対するロードをキャンセルします。
         キャンセルはコマンドバッファの粒度なので、コマンドバッファを実行の途中でキャンセルすることができます。
         もし、後でその地域が完全にロードされたかどうか知りたくなったら、コマンドバッファの状態を確認すればよいのです。
         また、Metal 3では、IO作業の優先順位をつけることもできます。
         プレイヤーがシーンの新しい部分にテレポートし、ゲームが大量のグラフィックアセットのストリーミングを開始するというゲームシナリオを考えてみましょう。
         同時に、ゲームではテレポートの効果音を再生する必要があります。
         高速なリソースロードにより、オーディオデータを含むアプリの全アセットをロードすることができます。
         オーディオをロードするには、先に説明したloadBytesコマンドを使用して、アプリケーションに割り当てられたメモリにロードすることができます。
         この例では、テクスチャとオーディオの IO コマンドバッファは、1 つの IO コマンドキューで同時に実行されます。
         この簡略化された図は、ストレージ層での要求を示しています。
         ストレージシステムは、オーディオとテクスチャのロードリクエストを並行して実行することができます。
         オーディオの遅延を避けるには、ストリーミングシステムがテクスチャリクエストよりもオーディオリクエストに優先順位をつけることができることが重要です。
         オーディオリクエストに優先順位をつけるには、別の IO コマンドキューを作成し、その優先順位を高に設定することができます。
         ストレージシステムは、優先度の高い IO リクエストのレイテンシーを低くし、他のリクエストよりも優先されるようにします。
         オーディオアセット用に別の高優先度キューを作成したところ、オーディオロードリクエストの実行時間は短くなり、並列のテクスチャロードリクエストの実行時間は長くなりました。
         高優先度キューの作成方法は以下の通りです。
         コマンドキューディスクリプターの優先度プロパティをhighに設定するだけです。
         また、優先順位をnormalまたはlowに設定し、通常通り、記述子から新しいIOコマンドキューを作成することもできます。
         ただ、キューを作成した後に、そのキューの優先順位を変更することはできないことを覚えておいてください。
         アプリケーションに高速なリソースロードを追加する際に、心に留めておくべきベストプラクティスをいくつか紹介します。
         まず、アセットを圧縮することを検討してください。
         組み込みまたはカスタムの圧縮を使用することで、アプリのディスク使用量を減らすことができます。
         圧縮を使用すると、ランタイムパフォーマンスとより小さなディスクフットプリントを交換することができます。
         さらに、スパーステクスチャを使用する場合は、スパースページサイズを調整することで、ストレージのスループットを向上させることができます。
         それぞれの詳細について、まず圧縮から説明します。
         Metals 3 の API を使用すると、オフラインでアセットファイルを圧縮することができます。
         まず、圧縮コンテキストを作成し、チャンクサイズと圧縮方式を設定します。
         次に、アセットファイルの一部をコンテキストに渡すと、すべてのファイルの単一の圧縮バージョンが作成されます。
         圧縮コンテキストは、すべてのデータをチャンクして、選択したコーデックで圧縮し、パックファイルに格納することで動作します。
         この例では、コンテキストは64Kチャンクでデータを圧縮しますが、圧縮したいデータのサイズと種類に基づいて適切なチャンクサイズを選択することができます。
         ここでは、Metal 3 の圧縮 API の使用方法を説明します。
         まず、圧縮ファイルを作成するためのパス、圧縮方法、チャンクサイズを指定して圧縮コンテキストを作成します。
         次に、ファイルデータを取得し、コンテキストに追加します。
         ここでは、ファイルデータはNSDataオブジェクトになっています。
         append dataを複数回呼び出すことで、異なるファイルのデータを追加することができます。
         データの追加が終わったら、圧縮コンテキストの flush and destroy 関数を呼び出して圧縮ファイルを確定し、保存します。
         ファイルハンドルを作成することで、圧縮ファイルを開いたりアクセスしたりすることができる。
         このファイルハンドルは、ロードコマンドを発行するときに使用されます。
         圧縮ファイルの場合、Metal 3はインライン解凍を実行し、オフセットを解凍に必要なチャンクのリストに変換して、リソースにロードします。
         ファイルハンドルは、Metalのデバイスインスタンスで作成します。
         たとえば、このコードでは、Metal デバイス インスタンスを使用して、先に説明した makeIOHandle メソッドに圧縮ファイルのパスを提供してファイル ハンドルを作成します。
         圧縮ファイルの場合、追加のパラメーターとして圧縮方式を指定します。
         これは、圧縮ファイルを作成するときに使用した圧縮方法と同じです。
         では、対応している圧縮方式とそれぞれの特徴を説明しますので、どのように選択すればよいのか、よりよく理解できるはずです。
         解凍速度が重要で、アプリケーションが大きなディスクフットプリントを許容できる場合は、LZ4を使用します。
         コーデックの速度と圧縮率のバランスが重要な場合は、ZLib、LZBitmap、またはLZFSEを使用してください。
         バランスの取れたコーデックの中では、ZLibがApple以外のデバイスでより良く機能します。
         LZBitmapはエンコードとデコードが速く、LZFSEは圧縮比が高いです。
         最高の圧縮率が必要な場合、アプリがアセットのデコードにかかる余分な時間に余裕があれば、LZMAコーデックを使用することを検討してください。
         また、独自の圧縮方式を使用することも可能です。
         カスタム圧縮コーデックを使用すると、データに利点がある場合があります。
         この場合、圧縮コンテキストを独自のコンプレッサーに置き換えてオフセットを変換し、実行時に自分で解凍することができます。
         圧縮を使用してディスクフットプリントを削減する方法を見たので、スパースページサイズのチューニングを見てみましょう。
         Metalの以前のバージョンでは、16Kの粒度でスパーステクスチャにタイルをロードすることをサポートしています。
         Metal 3では、新たに2つのスパースタイルサイズを指定することができます。64Kと256Kです。
         これらの新しいサイズにより、より大きな粒度でテクスチャをストリーミングして、ストレージハードウェアをよりよく利用し、飽和させることができます。
         より大きなタイル サイズのストリーミングとストリーミング データ量との間にはトレードオフがあるため、どのサイズがアプリとその疎なテクスチャに最適か、実験する必要があることに注意してください。
         次に、Metal Developer Toolsのセットを使用して、アプリの高速リソースロードのプロファイルとデバッグを行う方法について見てみましょう。
         Xcode 14は、高速リソースローディングを完全にサポートしています。
         Metal System Traceによるランタイムプロファイリングから、Metal debuggerによるAPIインスペクションや高度な依存性解析まで。
        まず、ランタイムプロファイリングから始めましょう。
         Xcode 14では、Instrumentsは、Metal System Traceテンプレートを使用して高速なリソースロードをプロファイリングできます。
         Instrumentsは、Metalアプリで最高のパフォーマンスを実現するための強力な解析およびプロファイリングツールです。
         Metal System Traceテンプレートを使用すると、ロードオペレーションがいつエンコードされ実行されるかを確認することができます。
         アプリがCPUとGPUの両方で実行しているアクティビティとの相関関係を理解することができるようになります。
         InstrumentsでMetalアプリをプロファイルする方法については、以前のセッション「GPUカウンターでMetalアプリとゲームを最適化する」と「Apple GPU用にハイエンドゲームを最適化する」をご覧ください。
        " さて、話をデバッグに移します。
         Xcode 14のMetalデバッガーを使用すると、新しい高速リソースロードAPIの使用を分析できるようになりました。
         フレームキャプチャを取ると、すべての高速リソースロードAPIの呼び出しを検査することができます。
         作成されたIOコマンドバッファから、発行されたロード操作に至るまで。
         新しい依存関係ビューアーを使って、高速リソースロードの依存関係を視覚的に検査することができるようになりました。
         Dependency viewerは、IOコマンドバッファとMetalパス間のリソース依存性の詳細な概要を提供します。
         ここから、新しい同期エッジやグラフフィルタリングなど、新しいDependencyビューアのすべての機能を使用して、リソースロードの依存関係を深く掘り下げ、最適化することができます。
         Xcode 14の新しいDependencyビューアについて詳しく知りたい方は、今年の「Go bindless with Metal 3」セッションをご覧ください。
         では、実際に高速なリソースローディングを見てみましょう。
         これは、新しい高速リソースローディングAPIを使用して、タイルサイズ16キロバイトのスパーステクスチャを使用してテクスチャデータをストリーミングするテストシーンです。
         この映像は、M1 Proチップを搭載したMacBook Proを使用しています。
         ストリーミングシステムは、GPUのスパーステクスチャアクセスカウンタを照会して、サンプリングしたがロードされていないタイルと、アプリが使用していないロード済みタイルの2つを識別します。
         アプリはこの情報を使って、必要なタイルのロードのリストと、不要なタイルのエヴィクションのリストをエンコードします。
         このようにして、作業セットには、アプリが使用する可能性が高いタイルだけが含まれるようになります。
         プレイヤーがシーンの別の場所に移動することにした場合、アプリはまったく新しい高解像度テクスチャのセットをストリームインする必要があります。
         ストリーミングシステムが十分に高速であれば、プレイヤーはこのストリーミングの発生に気づかないでしょう。
         シーンを一時停止すると、画像の違いをより明確に観察することができます。
         左側は、pread APIを使用してシングルスレッドでスパースタイルをロードしています。
         右側は、高速リソース読み込みAPIを使用して疎なタイルを読み込んでいます。
         プレイヤーがシーンに入った時点では、ほとんどのテクスチャが完全にロードされていません。
         ロードが完了すると、最終的な高解像度バージョンのテクスチャが表示されます。
         このシーンの最初に戻ってスロー再生すると、高速リソース ローディングがもたらす改善に気付きやすくなります。
         このレンダリングでは、違いを強調するために、アプリがまだ読み込んでいないタイルに赤い色調のマークを付けています。
         最初は、アプリがタイルのほとんどを読み込んでいないことがわかります。
         しかし、プレイヤーがシーンに入ると、高速リソース ローディングにより高解像度タイルのロードが改善され、シングルスレッド プレッド バージョンと比較して遅延が最小限に抑えられます。
         Metal 3の高速リソースローディングは、アプリが最新のストレージ技術を活用できるよう、強力で効率的なアセットストリーミングシステムを構築するために役立ちます。
         より高画質な画像を含むアセットをジャストインタイムでストリーミングすることにより、ロード時間を短縮するために使用します。
         Metalの共有イベントを使用して、GPUがシーンをレンダリングしている間に非同期にアセットをロードします。
         アプリが急ぎで必要とするアセットには、優先順位の高いコマンドキューを作成して待ち時間を最小化します。
         そして、ロードコマンドを早めに送信してストレージシステムを忙しくさせ ておくことを忘れないでください。
         不要なコマンドはいつでもキャンセルできます。
         Metal 3 の高速リソースロードは、最新のストレージハードウェアのパワーを利用して高スループットのアセットロードを実現する新しい方法を紹介します。
         これらの機能をどのように使って、あなたのアプリのビジュアル品質と応答性を向上させるか、楽しみに待っています。
         ご視聴ありがとうございました。

        """
    }
}

