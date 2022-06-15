import Foundation

struct DiscoverMetal3Article: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Discover Metal 3"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6559/6559_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10066/")!
    }

    var english: String {
        """
        Tarun Belagodu: Hello and welcome to Metal 3.
         My name is Tarun Belagodu and I'll be sharing the latest in Metal's evolution.
         First, let's start with the basics.
         Metal is Apple's low-overhead graphics and compute API.
         It's designed to be the fastest and most efficient way to drive the incredibly powerful GPUs behind Apple products.
         It offers multi-threaded and direct control over the commands sent to the GPU, a rich shading language that supports explicit shader compilation, and deeply integrated tools to help debug and profile complex applications and games.
        Since its introduction, Metal has added many advanced graphics and compute features, with a focus on GPU-driven rendering, machine learning, and ray tracing.
         Apple silicon paves the way for incredible graphics performance and efficiency on every new Mac.
         And Metal unlocks these capabilities.
         This year, Metal is making a leap to the next level with Metal 3.
        Metal 3 is a powerful set of new features that enable even higher performance and rendering quality to help your apps and games run faster and look amazing.
         Let's start with fast resource loading.
        Modern games and apps have demanding asset loading requirements, and streaming many small asset requests quickly from files to your Metal resources is often the key to high quality visuals.
         But existing storage APIs are designed for large, bulk requests.
        Metal 3's fast resource loading lets you request many small loads using the same explicit, multi-threaded command model as graphics and compute.
         Each request is a command, and many commands can be queued for asynchronous submission.
         It loads directly into your Metal buffers and textures without additional steps, saving you both development effort and transfer time.
         Fast resource loading also makes it easy to coordinate between GPU operations and loading operations, using the Metal synchronization primitives that you already know.
         Texture streaming systems really benefit from fast resource loading.
         Let's look at an example.
        Metal Sparse Textures allow applications to stream textures at a tile granularity.
         The texture streaming system built on Metal sparse textures consists of four steps: First, decide what to load based on feedback from the previous frame.
         Second, load tiles from file storage.
         Third, copy from your staging area to your sparse textures.
         And finally, draw your frame.
        The longer it takes to load and copy means the more time your app draws with lower quality.
        Fast resource loading minimizes loading overhead and ensures the storage hardware has enough requests in its queues to maximize throughput.
         This provides faster and more consistent performance so that more time is spent drawing at high quality.
        Fast resource loading will greatly simplify the code you need to write to achieve high quality asset streaming.
         To learn more about fast resource loading, check out the "Load resources faster with Metal 3" session.
        Next, let me tell you how the new offline compilation workflow will help you reduce load times and stutters in your apps.
         Shader binaries are GPU-specific machine code that are traditionally generated while the app is running as part of the Metal pipeline creation process.
         Generating these binaries is an expensive operation that is usually hidden behind a loading screen during app launch.
         However, sometimes they need to happen in-frame, which in turn causes frame rate stutters.
         These binaries are cached by Metal so that you don't pay the cost often, but their cost is still observed on the app's first launch or whenever the binary is first needed.
         With offline compilation, you can eliminate shader binary generation at run time.
        By moving binary generation to project build time, you can dramatically reduce the time spent creating Metal pipelines at load time, and reduce stutters in your app when those pipelines are created just-in-time.
         Let's take a closer look at what it means to reduce stutters.
        Here's an example of a game that needs to create a Metal pipeline state object during encoding.
         Since this is a pipeline that Metal hasn't seen before, it generates the needed shader binary.
         This is a long operation that interrupts encoding the rest of the frame, and causes the app to miss its frame rate target.
         This only happens once, but it's enough for your users to notice a frame stutter.
         In contrast, offline compilation means the shader binary can be generated at build-time so that every pipeline state creation is fast, and execution is smooth.
         Offline compilation can have a dramatic effect on your app loading times too.
         Let's look at an example.
        Most apps create the majority of Metal pipeline state objects in a dedicated loading phase.
         And shader binaries are generated on first load.
         This can be a long wait for your users if your app creates many such pipelines.
         With offline compilation, shader binary generation can again be moved to project build time, resulting in smaller load times and getting users into your app more quickly.
        Offline compilation is a game changer for apps with many complex pipelines.
         To learn more about offline compilation and other improvements, check out the "Target and optimize GPU binaries with Metal 3" session.
        Now, let's move on to MetalFX, which provides platform-optimized graphics effects for Metal applications.
         MetalFX Upscaling helps render high-quality graphics in less time through high-performance upscaling and anti-aliasing.
         You can choose a combination of temporal or spatial algorithms to help boost performance.
         Here's why it matters.
         While Retina resolution provides crisp detail that you want your apps and games to take advantage of, generating all those pixels can also affect performance.
         With MetalFX Upscaling, you can generate pixels at a lower resolution and then let the framework generate a high-quality, high-resolution image at a lower cost for a much higher frame rate.
         MetalFX is a powerful framework that makes high-performance, high-quality upscaling a reality.
         To learn more about MetalFX Upscaling, check out the "Boost performance with MetalFX Upscaling" session.
         Next up is Metal's new flexible geometry pipeline: Mesh Shaders.
         The traditional programmable graphics pipeline lets you transform vertices in a shader, that are then assembled into primitives for rasterization by fixed-function hardware.
         That's enough for most applications, but some use cases like culling require access to the entire primitive.
         Each vertex is also read, transformed, and output independently.
         So you can't add vertices or primitives in the middle of your draw.
         Advanced geometry processing requires more flexibility.
         And traditionally that meant pre-processing your geometry in a compute pass.
         But that requires storing a variable amount of intermediate geometry to device memory, which might be hard for you to budget for.
         Metal mesh shaders introduce an alternative geometry processing pipeline, It replaces the traditional vertex stage with a flexible 2-stage model and enables hierarchical processing of your geometry.
         The first stage analyzes whole objects to decide whether to expand, contract, or refine geometry in the second stage.
         It achieves this by providing compute capabilities in the render pass, without the need for intermediate device memory storage.
         Mesh shaders are a great fit for apps that perform GPU-driven culling, LOD selection, and procedural geometry generation.
         Let's take a closer look.
         In this example, a compute pass evaluates the surface and then generates its geometry.
         That geometry and its draw commands are then written to device memory for consumption by a later render pass.
         With high expansion factors and indirect draw calls, it can be hard to predict the amount of memory needed.
        Mesh shaders improve efficiency by running two compute-like stages inline in the render pipeline.
        The Object stage evaluates the input to decide how many meshes need to be generated.
        And the Mesh stage then generates the actual geometry.
         These meshes are sent directly to the rasterizer, bypassing the roundtrip to device memory, and the need for vertex processing.
        Mesh shaders will let you build efficient procedural geometry, culling, and LODing systems for your apps.
         To learn more about mesh shaders, check out the "Transform your geometry with Metal mesh shaders" session.
        Metal 3 also brings significant speedup to the ray tracing pipeline.
         Everything from acceleration structure builds, intersection and shading have been optimized.
         Metal also adds support for GPU-driven ray tracing pipelines to further optimize your app.
         Let's compare Metal 3's ray tracing to what was previously available.
        Metal 3 ray tracing saves a significant amount of CPU and GPU time.
         First, acceleration structures build in less time, giving you more GPU time to draw and trace rays.
         Second, CPU operations such as culling can move to the GPU thanks to the new Indirect Command Buffer support for Ray Tracing.
         Finally, Metal 3 ray tracing supports direct access to primitive data to streamline and optimize intersection and shading.
         Metal 3 ray tracing continues to become better and more powerful than before.
         To learn more about ray tracing, head over to the "Maximize your Metal ray tracing performance" session.
         Now, I'll show you how Metal 3 accelerates machine learning inference and training.
         Metal 3 has major improvements to accelerate machine learning, with additional support for accelerating network training on the Mac, and significant optimizations for ML inference optimizations in graphics and media processing applications.
         TensorFlow is a popular framework for machine learning that is GPU-accelerated on the Mac.
         The recently released Mac Studio provides up to a 16 times speedup on M1 Ultra versus training on the CPU, across a variety of networks.
         And Metal 3 also accelerates many new TensorFlow operations.
         That means less synchronization with the CPU for even more scalable performance.
         PyTorch is another very popular ML framework for network training that recently gained GPU acceleration using Metal.
         And on Mac Studio with an M1 Ultra you can achieve significant training speedups compared to the CPU.
         For example, you can train the BERT model up to 6.
        5 times faster and train ResNet50 up to 8.
        5 times faster.
         Metal optimizes ML inference across Apple silicon to maximize performance.
         This is especially useful for Metal-based high performance video and image processing applications, like BlackMagic Design's DaVinci Resolve.
         DaVinci Resolve is a color-grading-focussed video production platform that uses Metal and machine learning extensively in their workflows.
         And the results are incredible.
         With Metal's support for accelerated machine learning, BlackMagic Design achieved dramatic performance improvements to their editing and color grading workflows and their ML-based tools.
         To learn more about updates to machine learning, head over to the "Accelerate machine learning with Metal" session.
         Now let me tell you what hardware supports the Metal 3 features that I just described.
         Metal 3 is supported on all modern iOS, iPadOS, and macOS devices, including iPhone and iPad with A13 Bionic or M1 chips or newer, and all Apple silicon Mac systems and Mac systems with recent AMD and Intel GPUs.
        And to find out whether a given device supports Metal 3, use the supportsFamily query on the Metal device.
        Metal 3 is much more than features; it also includes a comprehensive set of advanced developer tools.
         Let me show you a few now.
         The Metal Dependency Viewer in Xcode 14 makes it even easier to visualize your entire renderer or zoom into a single pass.
         And to make it easier to adopt GPU-driven pipelines or synchronize with fast resource loading for example, the Dependency Viewer now includes synchronization edges to help you analyze and validate your dependencies.
         The improved Acceleration Structure Viewer in Xcode 14 helps you get the most out of Metal 3's optimized ray tracing.
         First, you can now highlight individual primitives in the scene.
        And selecting a primitive shows its associated primitive data in the outline on the left.
        Last, if your scene has motion information, the Acceleration Structure Viewer can now visualize different points in time.
        And that's just a quick look at a few of the Developer Tools updates in Xcode 14.
         There are a host of other new features such as Dylib support, a new resource list, file navigation in the Shader editor, custom Buffer Viewer layouts and many more.
         To learn more about tools and how to get the most out of advancements in Metal 3, be sure to check out these other sessions, which will help you build advanced graphics, games and pro apps.
        Today, I introduced you to Metal 3's advanced features for improving performance and quality: fast resource loading for higher-quality texture streaming; Offline compilation for shorter load times and less stuttering; MetalFX Upscaling to render at high resolution in less time; Mesh shaders for advanced geometry processing; faster acceleration structure builds, intersections, and shading for ray tracing; and more accelerated machine learning.
         Finally, I showed you some of advanced tools that help you use advanced features such as GPU-driven pipelines and ray tracing.
        To learn more with new code samples and documentation, head over to developer.
        apple.
        com/Metal.
        Thank you for joining.

        """
    }

    var japanese: String {
        """
        タルン・ベラゴドゥ こんにちは、「Metal 3」へようこそ。
         私はTarun Belagoduと申します。今回はMetalの進化した最新作をご紹介します。
         まず、基本的なことから説明します。
         MetalはAppleの低オーバーヘッドのグラフィックスとコンピュートAPIです。
         Apple製品の背後にある非常に強力なGPUを駆動するための、最速かつ最も効率的な方法として設計されています。
         GPU に送信されるコマンドをマルチスレッドで直接制御し、明示的なシェーダのコンパイルをサポートする豊富なシェーディング言語、複雑なアプリケーションやゲームのデバッグやプロファイル作成を支援する深く統合されたツールを提供します。
        導入以来、Metalは、GPU駆動型レンダリング、機械学習、レイトレーシングに重点を置き、多くの高度なグラフィックスおよびコンピュート機能を追加してきました。
         Appleのシリコンは、すべての新しいMacで驚異的なグラフィックス性能と効率性を実現する道を開いています。
         そしてMetalは、これらの機能を解放します。
         今年、MetalはMetal 3で次のレベルへと飛躍します。
        Metal 3は、より高いパフォーマンスとレンダリング品質を実現するパワフルな新機能のセットで、アプリケーションやゲームをより速く、より美しく動作させるのに役立ちます。
         まず、高速なリソースロードから始めましょう。
        最近のゲームやアプリでは、アセットのロード要件が厳しく、ファイルからMetalリソースに多数の小さなアセットリクエストを迅速にストリーミングすることが、高品質のビジュアルを実現する鍵となることが多いのです。
         しかし、既存のストレージAPIは、大規模な一括要求用に設計されています。
        Metal 3 の高速リソースロードでは、グラフィックスやコンピュートと同じ明示的なマルチスレッドコマンドモデルを使用して、多数の小さなロードを要求することができます。
         各リクエストはコマンドであり、多くのコマンドを非同期送信のためにキューに入れることができます。
         追加のステップなしに直接Metalバッファとテクスチャにロードされるので、開発の労力と転送時間の両方を節約できます。
         また、高速なリソースロードにより、既にご存知のMetalの同期プリミティブを使用して、GPU操作とロード操作の間の調整が容易になります。
         テクスチャストリーミングシステムは、高速リソースローディングの恩恵を本当に受けています。
         例を見てみましょう。
        Metal Sparse Texturesでは、アプリケーションはタイル粒度でテクスチャをストリーミングすることができます。
         Metalスパーステクスチャをベースに構築されたテクスチャストリーミングシステムは、4つのステップで構成されています。まず、前のフレームからのフィードバックに基づいてロードするものを決定します。
         2つ目は、ファイルストレージからタイルをロードします。
         3つ目は、ステージングエリアからスパーステクスチャにコピーします。
         そして最後に、フレームを描画します。
        ロードとコピーに時間がかかると、アプリが低品質で描画する時間が長くなります。
        リソースの高速ロードは、ロードのオーバーヘッドを最小限に抑え、ストレージハードウェアのキューに十分な要求があるようにして、スループットを最大にします。
         これにより、より速く、より安定したパフォーマンスを実現し、より多くの時間を高品質な描画に費やすことができます。
        高速リソース ローディングにより、高品質のアセット ストリーミングを実現するために記述する必要があるコードが大幅に簡素化されます。
         高速リソースローディングについて詳しく知りたい方は、「Metal 3 でリソースを高速にロードする」セッションをご覧ください。
        次に、新しいオフラインコンパイルワークフローが、どのようにアプリのロード時間やスタッタを減らすのに役立つかについて説明します。
         シェーダバイナリはGPU固有のマシンコードで、従来はMetalパイプライン作成プロセスの一部として、アプリの実行中に生成されていました。
         これらのバイナリの生成は高価な処理であり、通常はアプリの起動時にローディング画面の背後に隠されています。
         しかし、時にはフレーム内で生成する必要があり、その結果、フレームレートの停滞が発生します。
         これらのバイナリはMetalによってキャッシュされるため、頻繁にコストがかかるわけではありませんが、アプリの初回起動時やバイナリが初めて必要になったときに、そのコストが発生することに変わりはありません。
         オフラインコンパイルでは、実行時のシェーダバイナリ生成を省略することができます。
        バイナリ生成をプロジェクトのビルド時に移行することで、ロード時にMetalパイプラインを作成する時間を大幅に削減し、それらのパイプラインがジャストインタイムに作成されるアプリのスタッタを削減することができます。
         ここで、スタッタを減らすとはどういうことか、もう少し詳しく見てみましょう。
        エンコード時にMetalパイプラインの状態オブジェクトを作成する必要があるゲームの例を示します。
         これはMetalが見たことのないパイプラインであるため、必要なシェーダバイナリを生成します。
         この操作は長いため、フレームの残りの部分のエンコーディングが中断され、アプリのフレームレート目標が達成されなくなります。
         これは一度だけ起こることですが、ユーザーがフレームの淀みに気づくには十分なことです。
         一方、オフラインコンパイルでは、ビルド時にシェーダバイナリを生成できるため、すべてのパイプラインステートの作成が高速になり、実行がスムーズになります。
         オフラインコンパイルは、アプリのロード時間にも劇的な効果をもたらします。
         例を見てみましょう。
        ほとんどのアプリは、専用のローディングフェーズで Metal pipeline state オブジェクトの大部分を作成します。
         そして、シェーダーバイナリーは最初のロード時に生成されます。
         あなたのアプリがそのようなパイプラインを多数作成する場合、これはユーザーにとって長い待ち時間になる可能性があります。
         オフラインコンパイルにより、シェーダバイナリの生成は再びプロジェクトのビルド時に移動することができ、ロード時間が短縮され、ユーザがより迅速にアプリにアクセスできるようになります。
        オフライン・コンパイルは、多くの複雑なパイプラインを持つアプリにとって画期的なものです。
         オフラインコンパイルとその他の改善点について詳しくは、「Metal 3でGPUバイナリをターゲットして最適化する」セッションをご覧ください。
        それでは、MetalFXに移りましょう。MetalFXは、Metalアプリケーション向けに、プラットフォームに最適化されたグラフィックス効果を提供します。
         MetalFX Upscalingは、高性能なアップスケーリングとアンチエイリアシングにより、高品質なグラフィックスを短時間でレンダリングすることができます。
         パフォーマンスを向上させるために、時間的または空間的アルゴリズムの組み合わせを選択することができます。
         なぜそれが重要なのか、その理由はここにあります。
         Retinaの解像度は、アプリケーションやゲームで活用したい鮮明なディテールを提供しますが、これらのピクセルをすべて生成すると、パフォーマンスにも影響が及びます。
         MetalFX Upscalingを使用すると、低い解像度でピクセルを生成し、フレームワークが高品質の高解像度画像を低コストで生成し、はるかに高いフレームレートを実現することができます。
         MetalFXは、高性能、高品質のアップスケーリングを実現する強力なフレームワークです。
         MetalFX Upscalingの詳細については、"Boost performance with MetalFX Upscaling "セッションをご覧ください。
         次は、Metalの新しい柔軟なジオメトリパイプラインです。メッシュシェーダです。
         従来のプログラマブルグラフィックスパイプラインでは、シェーダで頂点を変換し、それをプリミティブに組み立てて、固定機能ハードウェアでラスタライズしていました。
         ほとんどのアプリケーションではこれで十分ですが、カリングなどの一部のユースケースではプリミティブ全体にアクセスする必要があります。
         また、各頂点は独立して読み込み、変換し、出力されます。
         そのため、描画の途中で頂点やプリミティブを追加することはできません。
         高度なジオメトリ処理には、より柔軟性が求められます。
         従来は、計算パスでジオメトリをプリプロセスしていました。
         しかし、そのためには、可変量の中間ジオメトリをデバイスメモリに保存する必要があり、その予算を確保するのは難しいかもしれません。
         Metal メッシュシェーダは、従来の頂点ステージを柔軟な2ステージモデルに置き換え、ジオメトリの階層的な処理を可能にする、別のジオメトリ処理パイプラインを導入しています。
         第1ステージでは、オブジェクト全体を解析し、第2ステージでジオメトリを拡張、収縮、または改良するかどうかを決定します。
         これは、中間デバイスのメモリストレージを必要とせず、レンダーパスで計算機能を提供することで実現されています。
         メッシュシェーダは、GPU 駆動のカリング、LOD 選択、およびプロシージャ ルジオメトリ生成を行うアプリケーションに非常に適しています。
         もっと詳しく見てみましょう。
         この例では、計算パスがサーフェスを評価し、そのジオメトリを生成します。
         このジオメトリと描画コマンドはデバイスメモリに書き込まれ、後のレンダーパスで使用されます。
         高い膨張係数と間接的な描画呼び出しにより、必要なメモリ量を予測することは困難です。
        メッシュシェーダは、レンダリングパイプラインで 2 つの計算のようなステージをインラ インで実行することにより、効率を向上させています。
        オブジェクトステージは、入力を評価して、生成する必要があるメッシュの数を決定します。
        そして、メッシュステージが実際のジオメトリを生成します。
         これらのメッシュはラスタライザに直接送られ、デバイスメモリへのラウンドトリップや頂点処理の必要性を回避します。
        メッシュシェーダは、あなたのアプリケーションに効率的なプロシージャル・ジオメトリ、カリング、LODシステムを構築することを可能にします。
         メッシュシェーダの詳細については、「Transform your geometry with Metal mesh shaders」セッションをご覧ください。
        また、Metal 3では、レイトレーシングのパイプラインが大幅に高速化されました。
         アクセラレーション構造の構築、交差、シェーディングなど、すべてが最適化されています。
         また、MetalはGPU駆動のレイトレーシングパイプラインのサポートを追加し、アプリをさらに最適化します。
         Metal 3のレイトレーシングを以前のものと比較してみましょう。
        Metal 3のレイトレーシングは、CPUとGPUの時間を大幅に節約します。
         まず、アクセラレーション構造がより短時間で構築されるため、レイの描画とトレースに必要なGPU時間が増えます。
         第二に、レイトレーシングの新しい間接コマンドバッファのサポートにより、カリングなどのCPUオペレーションをGPUに移行することができます。
         最後に、Metal 3 レイトレーシングは、プリミティブデータへの直接アクセスをサポートし、交差とシェーディングを合理化・最適化します。
         Metal 3レイトレーシングは、以前にも増して、より良く、より強力になり続けています。
         レイトレーシングについてもっと知りたい方は、「Metalのレイトレーシング性能を最大化する」セッションにお越しください。
         次に、Metal 3による機械学習の推論とトレーニングの高速化について紹介します。
         Metal 3では、機械学習を高速化するための大きな改善が行われ、Macでのネットワークトレーニングの高速化のサポートが追加されたほか、グラフィックスやメディア処理アプリケーションにおけるML推論の最適化のための大幅な最適化が行われています。
         TensorFlowは、MacでGPUアクセラレーションが可能な機械学習のフレームワークとして人気があります。
         最近リリースされたMac Studioでは、さまざまなネットワークにおいて、CPUでのトレーニングと比較して、M1 Ultraで最大16倍のスピードアップを実現しています。
         また、Metal 3では、多くの新しいTensorFlowオペレーションが高速化されています。
         つまり、CPUとの同期が少なくなり、さらにスケーラブルなパフォーマンスを実現できるようになったのです。
         PyTorchは、ネットワークトレーニング用のMLフレームワークとして非常に有名ですが、最近Metalを使用してGPUアクセラレーションを実現しました。
         そして、M1 Ultraを搭載したMac Studioでは、CPUに比べてトレーニングが大幅に高速化されます。
         例えば、BERTモデルを最大6.5倍高速にトレーニングできます。
        5倍、ResNet50のトレーニングは8.
        5倍速くなります。
         Metalは、Appleのシリコン全体でML推論を最適化し、パフォーマンスを最大化します。
         これは、BlackMagic DesignのDaVinci Resolveのような、Metalベースの高性能ビデオおよび画像処理アプリケーションに特に有効です。
         DaVinci Resolveは、カラーグレーディングに特化したビデオ制作プラットフォームで、ワークフローにおいてMetalと機械学習を広範囲に使用しています。
         そして、その結果は驚くべきものです。
         BlackMagic Designは、Metalの加速された機械学習のサポートにより、編集とカラーグレーディングのワークフローとMLベースのツールで劇的なパフォーマンスの向上を達成しました。
         機械学習のアップデートについて詳しく知りたい方は、「Accelerate machine learning with Metal」セッションにお越しください。
         さて、先ほど説明したMetal 3の機能をサポートしているハードウェアについて説明します。
         Metal 3は、A13 BionicまたはM1チップ以降のiPhoneとiPad、および最近のAMDとIntelのGPUを搭載したすべてのAppleシリコンMacシステムとMacシステムを含む、すべての最新のiOS、iPadOS、macOSデバイスでサポートされているそうです。
        また、あるデバイスがMetal 3をサポートしているかどうかを調べるには、MetalデバイスのsupportsFamilyクエリを使用します。
        Metal 3は機能だけでなく、先進的な開発ツールの包括的なセットも含んでいます。
         今、そのいくつかをお見せしましょう。
         Xcode 14のMetal Dependency Viewerでは、レンダラー全体を視覚化したり、単一のパスにズームインしたりすることがより簡単になりました。
         また、例えばGPU駆動パイプラインの採用や高速なリソースロードとの同期を容易にするために、Dependency Viewerには同期エッジが含まれ、依存関係の解析と検証に役立つようになりました。
         Xcode 14で改良されたAcceleration Structure Viewerは、Metal 3の最適化されたレイトレーシングを最大限に活用するのに役立ちます。
         まず、シーン内の個々のプリミティブをハイライト表示できるようになりました。
        また、プリミティブを選択すると、その関連するプリミティブデータが左のアウトラインに表示されます。
        最後に、シーンにモーション情報がある場合、アクセラレーション構造ビューアでは、異なる時間のポイントを視覚化できるようになりました。
        以上、Xcode 14のデベロッパーツールの更新を簡単にご紹介しました。
         他にも、Dylibのサポート、新しいリソースリスト、Shaderエディタでのファイルナビゲーション、カスタムBuffer Viewerレイアウトなど、多数の新機能があります。
         ツールやMetal 3の進化を最大限に活用する方法についてもっと知りたい方は、ぜひ他のセッションもご覧ください。高度なグラフィックス、ゲーム、プロフェッショナルアプリを構築するのに役立つはずです。
        本日は、パフォーマンスと品質を向上させるMetal 3の先進的な機能を紹介しました：より高品質なテクスチャストリーミングのための高速リソースロード、ロード時間の短縮とスタッタリングの低減のためのオフラインコンパイル、より短い時間で高解像度でのレンダリングを行うMetalFX Upscaling、高度なジオメトリ処理のためのMesh Shader、レイトレーシング用の高速な構造構築、交差、シェーディング、より加速した機械学習など。
         最後に、GPU駆動のパイプラインやレイトレーシングなどの高度な機能を利用するための高度なツールを紹介しました。
        新しいコードサンプルとドキュメントでさらに詳しく知りたい方は、developer.
        apple.
        com/Metalにアクセスしてください。
        ご参加ありがとうございました。

        """
    }
}

