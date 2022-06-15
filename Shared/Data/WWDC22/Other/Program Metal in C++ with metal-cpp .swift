import Foundation

struct ProgramMetalInCppWithMetalcpp: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Program Metal in C++ with metal-cpp"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6659/6659_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10160/")!
    }

    var english: String {
        """
        Hi, my name is Keyi Yu, and I'm an engineer from the Metal Ecosystem team.
         Today, it's my pleasure to introduce metal-cpp.
         We created metal-cpp for anyone who uses C++ and wants to build Metal applications for Apple platforms.
         Metal-cpp is a low-overhead library that connects your C++ applications to Metal.
         First, I'll start with an overview of what metal-cpp is and how it works, and then I'll cover some details about the lifecycles for Objective-C objects.
         C++ and Objective-C handle lifecycles a bit differently, and I'll show you how to handle those differences.
         Xcode and metal-cpp have some great utilities that can help you manage the object lifecycles in your apps.
         And finally, I'll show you how to integrate C++ code with Objective-C classes.
         So here's a look at metal-cpp and how it works.
         Metal is the foundation for accelerated graphics and compute on Apple platforms, enabling your apps and games to tap into the incredible power of the GPU.
         It was originally designed using the powerful features and the conventions offered by Objective-C.
         But if your code base is in C++, you may need something to bridge between your code and Metal's Objective-C code.
         Introducing metal-cpp! It serves as a hub between your C++ application and Objective-C Metal.
         With metal-cpp in your application, you can use Metal classes and functions in C++, and metal-cpp can help you call Objective-C functions in runtime.
         metal-cpp is a lightweight Metal C++ wrapper.
         I say it's lightweight, because it's implemented as a header-only library with inline function calls.
         It provides 100 percent coverage of the Metal API by implementing a one-to-one mapping of C++ calls to Objective-C APIs.
         To do this, metal-cpp wraps parts of the Foundation and CoreAnimation frameworks.
         It's open source under Apache 2 License, so you can modify the library and include it to your applications, easily.
         metal-cpp uses C to call directly into the Objective-C runtime.
         This is the exact same mechanism that the Objective-C compiler uses to execute Objective-C methods.
         So this wrapper introduces little overhead.
         Since metal-cpp implements a one-to-one mapping of C++ to Objective-C calls, it follows the same Cocoa memory-management rules.
         I will discuss this in more detail later.
         This one-to-one mapping also allows all of the developer tools to work seamlessly, including GPU Frame Capture and the Xcode debugger.
         These are the series of calls necessary to draw a triangle with metal-cpp.
         If you are familiar with C++, it's a good time to learn Metal, because you don't need to worry about language syntax.
         If you've already used Metal with Objective-C, in terms of function calls, there's very little difference between the Objective-C interface of Metal and metal-cpp.
         I am going to demonstrate how easy it is to use metal-cpp.
         First, I create a command buffer, which I will fill with commands for the GPU to execute.
         I can simply use the raw pointer in C++ as a mapping to ID in Objective-C.
         I can create a render command encoder and write render commands with a command buffer.
         The C++ function renderCommandEncoder and the Objective-C method renderCommandEncoder WithDescriptor are the same.
         The only differences are the name conventions of the languages.
         I then set a render pipeline state object which contains the vertex and fragment shaders and various other rendering states.
         Then I encode my draw call to render a single triangle.
         Then I indicate that I've finished encoding render commands.
         I present the drawable, so the triangle is displayed onscreen.
         Finally, I commit my command buffer.
         This tells the GPU that it can begin executing my commands.
         Obviously, metal-cpp and Objective-C Metal are almost the same.
         You don't need to worry about language syntax now with metal-cpp, you can directly look into the Metal documentation to learn the concepts and usage of Metal.
         You may have already played with this deferred lighting sample before.
         We now provide a new version of this deferred lighting sample which uses metal-cpp.
         We hope this can help you learn how to code with metal-cpp in practice.
         I'm also excited to introduce a series of incremental C++ samples that introduces the Metal API and shows you how to accomplish different tasks with it.
        So now that you know a little bit about metal-cpp, how do you actually use it? We published metal-cpp last year.
         Here's the webpage where you can find the downloads and instructions.
         Let me show you the steps you will need to take.
         After downloading metal-cpp, you should tell Xcode where to find it.
         Here, I put metal-cpp under the current project.
         Then, you need to set C++17 or higher as the C++ language dialect.
         Next, add three frameworks to the project: Foundation, QuartzCore, and Metal.
         Now there's only one thing left to do before using C++ interfaces of those frameworks.
         There are three headers in metal-cpp.
         Since metal-cpp is a header-only library, you need to generate their implementations before importing the header files.
         To do this, define three macros: NS_PRIVATE_IMPLEMENTATION, CA_PRIVATE_IMPLEMENTATION, AND MTL_PRIVATE_IMPLEMENTATION.
         If you are interested in what metal-cpp does with the macros under the hood, please check out header bridge files in the metal-cpp folder.
         You can use the headers separately or put them in a single header.
         You can import the header files whenever you need them.
         But remember, do not define the NS, CA, or MTL_PRIVATE_IMPLEMENTATION macros more than once.
         Otherwise, you may cause duplicate definition errors.
         To use metal-cpp effectively, you'll need to know Cocoa's memory management rules, how to use the great utilities that can help you manage object lifecycles, and how to design your application architecture when you interface with other frameworks.
         I'll start with object lifecycle management.
         During your application's operation, you typically need to allocate and release memory.
         You also need to manage command buffers, pipeline objects, and resources.
         To help manage this memory, Objective-C and Cocoa objects include a reference count.
         This is also present in metal-cpp.
         Reference counting helps you manage your memory.
         Using reference counting, all objects contain a retainCount property.
         Components in an app increase the count to keep objects they're interacting with alive and decrease it when they are done with them.
         When the retainCount hits zero, the runtime deallocates the object.
         There are two types of reference counting in Objective-C.
         One is called Manual Retain-Release -- MRR; the other is Automatic Reference Counting -- ARC.
         When compiling code with the ARC feature, the compiler takes the references you create and automatically inserts calls to the underlying memory-management mechanism.
         metal-cpp objects are manually retained and released.
         So you need to understand Cocoa's conventions to know when to retain and release objects.
         Unlike creating objects in C++, metal-cpp objects are neither created with new nor destroyed with delete.
         With Cocoa's conventions, you own any object you create with methods starting with the alloc, new, copy, mutableCopy, or create.
         You can take ownership of an object using retain.
         When you no longer need it, you must relinquish ownership of an object you own.
         You can release it immediately or release it afterwards.
         You must not relinquish ownership of an object you do not own as you risk a double free.
         Next, I'll walk through an example of these Cocoa conventions.
         In class A, a method uses alloc to create an object and init to initialize this object.
         Remember, never call init on an object twice.
         Class A takes the ownership and is responsible for deallocating it.
         Now the retain count for this object is one.
         Next, class B uses retain to get the object and takes ownership of this object.
         So far, I have two objects that share the ownership of this object represented by the orange cube.
         The retain count increases by one.
        Class A doesn't need this object anymore, so class A should manually call release for it.
         As a result, the retain count decreases by one.
         Now, only class B owns the object.
         OK, finally, class B wants to release this object too.
         Now the retain count is zero, so the runtime frees the object.
         Here's a situation where a method in class B returns an object.
         You still need this object in the rest of the programs.
         In other words, you want to relinquish ownership of an object in a method in class B, but you don't want it to be deallocated immediately.
         In this case, you should call autorelease in class B.
         The retain count is still one after you call autorelease, and thus, you can still use the object later.
         Here's the question: since class B does not own this object anymore, who is responsible for deallocating it? The Foundation Framework provides an important object, called the AutoreleasePool.
         The Autorelease API puts the object into an AutoreleasePool.
         Now, the AutoreleasePool takes the ownership of the object.
         The AutoreleasePool decrements the receiver's retain count when the AutoreleasePool is destroyed.
         You are not the only one who can create autoreleased objects.
         Metal creates several autoreleased objects as part of its operation.
         All methods that create temporary objects add them to AutoreleasePools by calling autorelease under the hood.
         It is the AutoreleasePool's responsibility to release them.
         In other words, with an AutoreleasePool, you can code in a more elegant way.
         You can have an AutoreleasePool for the main application.
         We also encourage you to create and manage additional AutoreleasePools at smaller scopes to reduce your program's working set.
         You also need AutoreleasePools for every thread you create.
         Here's an example showing how to use an AutoreleasePool and autoreleased objects.
         In this sample, an AutoreleasePool is created by alloc, which means you take the ownership and it should be manually released.
         Now we have an AutoreleasePool.
         As we discussed in the beginning, you should create a command buffer.
         It's not created with alloc or create, so you don't own it.
         Instead, it's an autoreleased object created by Metal.
         This command buffer will be put into the AutoreleasePool.
         It's the AutoreleasePool's responsibility to deallocate it.
         You can use it as you wish until you release the AutoreleasePool.
         Then you need to create a RenderPassDescriptor.
         This RenderPassDescriptor will be put into the AutoreleasePool as well.
         Same to RenderCommandEncoder.
         It's also an autoreleased object created by Metal.
         Don't forget this currentDrawable object.
         It will be put into the AutoreleasePool too.
         At the end of the piece of code, I use pPool->release to release the AutoreleasePool.
         Before being deallocated, the AutoreleasePool releases everything that it owns, in this case, it releases the CommandBuffer, RenderPassDescriptor, RenderCommandEncoder, and currentDrawable.
         Then the AutoreleasePool is released.
         So far, you got to know Cocoa's conventions, autoreleased objects, and AutoreleasePools.
         It's important to correctly manage object lifecycles to avoid memory leaks and zombie objects, and we have great tools to help you avoid and debug these issues.
         I'll focus on two utilities: NS::SharedPtr and NSZombie.
         NS::SharedPtr is a new utility that can help you manage the object lifecycle.
         You can find it under Foundation framework in the metal-cpp folder.
         Notice that it is not exactly the same as std:shared_ptr.
         So there's no dependency on the C++ standard library and no extra cost on storing the reference count.
         Here's what NS::SharedPtr is like.
         Transfer and retain functions clearly express the intent of consuming an object.
         Transfer creates a SharedPtr without increasing the pointee's referenceCount, effectively transferring ownership to the SharedPtr.
         The retain function sends a retain to the passed-in object.
         Use this function to keep alive objects that are in AutoreleasePools and to express that the pointer's owner has a vested interest in the pointee's lifecycle.
         You can access the underlying object as expected via get and via the operator->.
         SharedPtr copy, move, construction, and assignment work as expected, with copy increasing the retainCount.
         Moves are fast and do not affect the retain count in the general case.
         SharedPtrs always send exactly one release to the pointee on destruction.
         You can avoid this if you want by calling the detach function.
         Going back to the top, it's important to know the differences between creating a pointer by transferring or retaining it.
         So for TransferPtr, suppose I have an MRR object, with a reference count of 1.
         After I pass it to the TransferPtr function, the SharedPtr takes ownership of the object, but its retainCount doesn't change.
         When the pointer goes out of scope, the SharedPtr's destructor runs and calls release on the MRR object, which decrements the retainCount to 0.
         Another function is NS::RetainPtr.
         When you want to avoid deallocating an object because you want to use it later, you should use NS::RetainPtr.
         Suppose we have this MRR object; the retainCount is one.
         After we pass it to the RetainPtr function, the retainCount increases by one.
         After running out of the scope, this RetainPtr calls release for this MRR object.
         So the retainCount is one.
         In general, NS::TransferPtr takes the ownership of an object for you.
         But NS::RetainPtr helps you retain an object when you don't want it to be deallocated.
         When you pass an object to these two functions, NS::TransferPtr doesn't change the reference count but NS::RetainPtr increases reference count by one as it calls retain for you under the hood.
         The destructor of these two functions both call release for the passed-in object and, therefore, reference count decreases by one.
         If the reference count hits zero, the object will be freed in runtime.
         Here's an example of NS::TransferPtr.
         When I talked about the render pass, which drew a single triangle, I needed this render pipeline state.
         Here are the calls to create a render pipeline state object.
         These are the attributes that a render pipeline descriptor needs.
         According to Cocoa's conventions, since these calls starts with new and alloc, I own these objects.
         So I need to call release for these objects.
         With NS::SharedPtr, I don't need to call release for those MRR objects because NS::SharedPtrs takes the ownership of these objects.
         So here, I pass raw pointers to the TransferPtr function.
         After doing that, there's no need to call release as I did in the previous slide.
         If you are familiar with ARC, you may find that MRR used with NS::SharedPtr is similar to using ARC.
         You may encounter use-after-free bugs when handling memory manually.
         They occur when you are trying to use an object which has been already released.
         NSZombie is a good way to check for those bugs.
         When use-after-free bugs occur, it triggers a breakpoint and provides you with a stack trace.
         You can enable Zombies very easily with an environment variable.
         Just set NSZombieEnabled to YES.
         Or If you're using Xcode, you can enable Zombies in a scheme.
         Here's how it works.
         I want to create a new render pipeline state object with the same render pipeline settings.
         So in this newRenderPipelineState function, I reuse the pDesc object.
        After clicking on run, Xcode triggers a breakpoint and shows me the stack trace.
         That means I got something wrong.
         Hm, what's the problem? Maybe NSZombie can help here, so I enable NSZombie in scheme.
        When I run the program again, NSZombie triggers a breakpoint.
         I get something new in the console output: "message sent to deallocated instance.
        " Oh, I reused an object that I have already released.
         And it's the render pipeline descriptor.
         So I need to use this render pipeline descriptor before calling release.
         By doing that, I fix the problem.
         More tools and details are covered in this year's talk, "Profile and optimize your game's memory.
        " For example, you can learn how to track retainCount in allocations in instruments.
         Feel free to check out other tools on Apple platforms.
         You will find out that they can help you debug your game and improve performance.
         Now you know how to manage object lifecycles in metal-cpp.
         But you may still need to interface with other frameworks, like game controller and audio.
         These are still in Objective-C.
         How can you interface with those APIs and design an elegant application architecture? Say you wrote a ViewController in Objective-C, but you wrote a renderer in C++ with metal-cpp.
         You need to call renderer methods, like draw, from the ViewController.
         The challenge here is to nicely separate the two languages but have them work together.
         The solution is to create an adapter class which calls C++ from Objective-C files.
         By doing this, you can focus on Objective-C or C++ in files where you implement features.
         For example, I can create a RendererAdapter class in Objective-C.
         And down in the implementation, I add an Objective-C method so that I can call it directly from the ViewController.
         Inside of the interface, I declare a C++ pointer to a renderer object.
         Inside the body of the method, I directly call the renderer's C++ method.
         This method needs to pass the MTK::View as a C++ object into the draw method, so it casts the view as a C++ type by using the __bridge keyword.
         I'll talk more about this cast later.
         In contrast, you need to call MTKView which is written with Objective-C in Renderer which is written with C++.
         It's challenging as well.
         Similarly, the solution is to create an adapter class.
         With this class, in C++ files, you can call Objective-C methods using C++ interface.
         For example, I can create a ViewAdapter class.
         I write the interfaces in C++, so in the Renderer class, I can call those C++ view methods easily.
         While in the implementation, I call Objective-C methods from MTKView, including currentDrawable and depthStencilTexture.
         You may notice there're some __bridge keywords here.
         I use them to cast between metal-cpp objects and Objective-C objects.
         As you learned in the beginning, metal-cpp objects are manually retained and released, but objects created by Objective-C use automatic reference counting.
         You need to move objects from MRR to ARC and from ARC to MRR.
         Here are three types of bridge casting which can help you cast between Objective-C and C++.
         They can also help you transfer ownership _bridge casting casts between Objective-C and metal-cpp objects.
         There is no transfer of ownership between them.
         __bridge_retained casting casts an Objective-C pointer to a metal-cpp pointer and takes the ownership from ARC.
         __bridge_transfer casting moves a metal-cpp pointer to Objective-C and transfers the ownership to ARC.
         Going back to the problem, you need to cast between metal-cpp objects and Objective-C objects.
         If there's no transfer of ownership, you can use __bridge cast.
         If you want to cast from metal-cpp to Objective-C objects and transfer the ownership to Objective-C, you should use __bridge_transfer cast.
         If you want to cast from Objective-C to metal-cpp objects and take the ownership out of ARC, you should use __bridge_retained cast.
         Here's a case when I have to use MetalKit to leverage the asset loading code.
         That means in my C++ application, I need a texture as a metal-cpp object, but it is created by Objective-C methods.
         I need the ability to transfer ownership out of ARC so I can manually release it.
         And in this case, I need to pick __bridge_retained cast.
         I have this C++ function that loads a texture from the catalog and I want to return a metal-cpp texture.
         But inside, I'm calling some Objective-C functions in MetalKit.
         I need to define the options that a texture loader needs.
         Then I create a texture loader by calling an Objective-C method from MetalKit.
         With that loader, I can create a texture object and load a texture from the catalog.
         This method is also an Objective-C method from MetalKit.
         Now I have an Objective-C type texture, I need to cast it to the metal-cpp object and take it out of ARC.
         With these steps in mind, it's time to code, and I'll show you how casting works in practice.
         First step is to define the texture loader options that a texture loader needs.
         I can safely cast the metal-cpp storage mode and usage to the Objective-C type, as the metal-cpp type defines them to the same values.
         Here I create a texture loader.
         I have a device that is a metal-cpp object, and I need to pass it to the initWithDevice method.
         Because the metal-cpp object is an Objective-C object, I can cast it like a toll-free object.
         There is no transfer of ownership.
         Now I use the texture loader options and a texture loader to create a texture.
         And I want to return the loaded texture as a metal-cpp object.
         So I need to take it out of ARC and cast it to the corresponding pointer type.
         This is done with a __bridge_retained cast.
         After this, I can use this texture as any metal-cpp object.
         I am responsible for releasing it.
         In this section, I provided an adapter pattern which can help you handle two different languages in your program.
         I also showed how to interface with Objective-C and C++ with three types of casts.
         To summarize, metal-cpp is a lightweight and very efficient Metal C++ wrapper.
         I talked about how to manage object lifecycles when using metal-cpp, how to interface with Objective-C in an elegant manner, and how our developer tools can help you debug.
         Download metal-cpp and play with all the amazing samples now! See what you can create with Metal.
         We look forward to seeing your C++ applications running across all Apple platforms.
         Thanks for watching!

        """
    }

    var japanese: String {
        """
        こんにちは、Metal Ecosystemチームのエンジニア、Keyi Yuです。
         本日は、metal-cppを紹介させていただきます。
         私たちは、C++を使用していて、Appleプラットフォーム用のMetalアプリケーションを作りたいと思っている人のために、metal-cppを作りました。
         metal-cppは、あなたのC++アプリケーションをMetalに接続するための低オーバーヘッドのライブラリです。
         まず、metal-cppとは何か、どのように動作するかの概要から始め、Objective-Cオブジェクトのライフサイクルについての詳細を説明します。
         C++とObjective-Cではライフサイクルの扱いが少し異なるので、その違いをどのように処理するかを紹介します。
         Xcodeとmetal-cppには、アプリケーションのオブジェクト・ライフサイクルを管理するのに役立つ素晴らしいユーティリティがいくつかあります。
         そして最後に、C++のコードをObjective-Cのクラスと統合する方法について紹介します。
         ではここで、metal-cppとその仕組みについて見てみましょう。
         MetalはAppleのプラットフォーム上でグラフィックスと計算を加速するための基盤であり、あなたのアプリケーションやゲームがGPUの驚異的なパワーを活用できるようにするものです。
         Metalはもともと、Objective-Cが提供する強力な機能と規約を使用して設計されています。
         しかし、あなたのコードベースがC++である場合、あなたのコードとMetalのObjective-Cコードとの間の橋渡しをするものが必要かもしれません。
         そこで、metal-cppを紹介します。これは、C++アプリケーションとObjective-C Metalの間のハブとして機能します。
         metal-cppがあれば、C++でMetalのクラスと関数を使用でき、metal-cppは実行時にObjective-C関数の呼び出しを支援します。
         metal-cppは軽量のMetal C++ラッパーです。
         軽量と言ったのは、インライン関数呼び出しによるヘッダのみのライブラリとして実装されているからです。
         C++の呼び出しとObjective-CのAPIの一対一のマッピングを実装することにより、Metal APIを100%カバーします。
         これを実現するために、metal-cppはFoundationおよびCoreAnimationフレームワークの一部をラップしています。
         Apache 2ライセンスのオープンソースであるため、ライブラリを修正し、アプリケーションに簡単に取り込むことができます。
         metal-cppは、C言語を使ってObjective-Cのランタイムを直接呼び出します。
         これは、Objective-CコンパイラがObjective-Cのメソッドを実行するのと全く同じメカニズムである。
         そのため、このラッパーはほとんどオーバーヘッドを発生させません。
         metal-cppは、C++からObjective-Cへの1対1のマッピングを実装しているので、同じCocoaメモリ管理ルールに従います。
         これについては、後で詳しく説明します。
         この1対1のマッピングにより、GPU Frame CaptureやXcodeデバッガを含むすべての開発ツールをシームレスに動作させることも可能です。
         以上が、metal-cppで三角形を描くのに必要な一連の呼び出しです。
         C++に慣れている方は、言語の構文を気にする必要がないので、Metalを学ぶのに良い機会だと思います。
         すでにObjective-CでMetalを使ったことがあるなら、関数呼び出しという点では、MetalのObjective-Cインターフェースとmetal-cppの間にほとんど違いはありません。
         これから、metal-cppの使い方がいかに簡単かを実演します。
         まず、コマンドバッファを作り、そこにGPUが実行するコマンドを入れていきます。
         C++の生ポインタをObjective-CのIDへのマッピングとして使うだけでいいんです。
         レンダーコマンドエンコーダを作り、コマンドバッファでレンダーコマンドを書けばいいんです。
         C++の関数renderCommandEncoderとObjective-CのメソッドrenderCommandEncoder WithDescriptorは同じものです。
         異なるのは、言語の名称規則だけです。
         次に、頂点シェーダーとフラグメントシェーダー、その他のさまざまなレンダリングステートを含むレンダーパイプラインステートオブジェクトを設定します。
         そして、1つの三角形をレンダリングするための描画呼び出しをエンコードします。
         そして、レンダーコマンドのエンコードが終了したことを示します。
         drawable を表示すると、三角形が画面に表示されます。
         最後に、コマンドバッファをコミットします。
         これで GPU にコマンドの実行を開始できることが伝わります。
         明らかに、metal-cppとObjective-C Metalはほとんど同じです。
         metal-cppでは言語の構文を気にする必要はなく、直接Metalのドキュメントを見て、Metalの概念と使い方を学ぶことができます。
         この遅延照明のサンプルは既に遊んだことがあるかもしれません。
         今回、このディファードライティングサンプルにmetal-cppを使用した新バージョンを提供します。
         これが、metal-cppを使ったコードを実践的に学ぶのに役立つことを願っています。
         また、Metal APIを紹介し、それを使ってさまざまなタスクを達成する方法を示す、一連のインクリメンタルC++サンプルを紹介できることを嬉しく思います。
        さて、metal-cppについて少し分かったところで、実際にどのように使うのでしょうか？私たちは昨年、metal-cppを公開しました。
         こちらがそのウェブページで、ダウンロードと説明書をご覧いただけます。
         それでは、必要な手順を紹介します。
         metal-cppをダウンロードしたら、Xcodeにそれがどこにあるのかを教える必要があります。
         ここでは、現在のプロジェクトの下にmetal-cppを置きました。
         そして、C++言語の方言として、C++17以上を設定する必要がある。
         次に、プロジェクトに3つのフレームワークを追加する。Foundation、QuartzCore、そしてMetalです。
         これで、これらのフレームワークのC++インタフェースを使用する前にやるべきことが1つだけ残りました。
         metal-cppには3つのヘッダがあります。
         metal-cppはヘッダのみのライブラリですので、ヘッダファイルをインポートする前に、それらの実装を生成する必要があります。
         これを行うには、3つのマクロを定義します。ns_private_implementation、ca_private_implementation、およびmtl_private_implementationです。
         もし、metal-cppがボンネットの中のマクロで何をするのかに興味があれば、metal-cppフォルダーにあるヘッダーブリッジファイルをチェックしてみてください。
         ヘッダは別々に使用することもできますし、1つのヘッダにまとめることもできます。
         ヘッダーファイルは必要なときにいつでもインポートすることができます。
         しかし、NS、CA、MTL_PRIVATE_IMPLEMENTATIONマクロを2回以上定義しないことを忘れないでください。
         さもないと、重複定義エラーを引き起こす可能性があります。
         metal-cpp を効果的に使うには、Cocoa のメモリ管理ルール、オブジェクト・ライフサイクルの管理に役立つ優れたユーティリティの使い方、他のフレームワークと連携する際のアプリケーション・アーキテクチャの設計方法について知っておく必要があります。
         まず、オブジェクトのライフサイクル管理から説明します。
         アプリケーションの動作中、通常、メモリの割り当てと解放が必要です。
         また、コマンドバッファ、パイプラインオブジェクト、リソースの管理も必要です。
         このメモリを管理するために、Objective-CやCocoaのオブジェクトには参照カウントが含まれています。
         これは、metal-cppにも存在します。
         参照カウントは、メモリの管理に役立ちます。
         参照カウントを使用すると、すべてのオブジェクトにretainCountプロパティが含まれます。
         アプリ内のコンポーネントは、やり取りするオブジェクトを生かすためにこのカウントを増やし、そのオブジェクトを使い終わったら減らします。
         retainCountがゼロになると、ランタイムはオブジェクトの割り当てを解除する。
         Objective-Cの参照カウントには、2つのタイプがある。
         ひとつはManual Retain-Release -- MRRと呼ばれるもので、もうひとつはAutomatic Reference Counting -- ARCと呼ばれるものです。
         ARC機能を使ってコードをコンパイルする場合、コンパイラは作成した参照を取り込んで、基盤となるメモリ管理機構への呼び出しを自動的に挿入します。
         metal-cppのオブジェクトは、手動で保持と解放を行います。
         そのため、いつオブジェクトを保持し、解放するかを知るために、Cocoaの規約を理解する必要があります。
         C++でオブジェクトを作成するのとは異なり、metal-cppのオブジェクトはnewで作成されることもdeleteで破棄されることもありません。
         Cocoaの規約では、alloc、new、copy、mutableCopy、createで始まるメソッドで作成したオブジェクトは、あなたが所有することになります。
         オブジェクトの所有権は、retain を使って取得できます。
         必要がなくなったら、所有しているオブジェクトの所有権を放棄しなければなりません。
         すぐに解放しても、後で解放してもかまいません。
         ただし、自分が所有していないオブジェクトの所有権を放棄することは、二重解放の危険性があるため、絶対に避けてください。
         次に、これらのCocoaの規約の例を説明します。
         クラスAでは、あるメソッドがallocを使ってオブジェクトを作成し、initを使ってこのオブジェクトを初期化しています。
         覚えておいてほしいのは、1つのオブジェクトに対してinitを2回呼んではいけないということです。
         クラスAは、所有権を取得し、それを解放する責任を負います。
         これで、このオブジェクトのretainのカウントは1になりました。
         次に、クラスBがretainを使ってオブジェクトを取得し、このオブジェクトのオーナーシップを取得します。
         ここまでで、オレンジ色の立方体で表されるこのオブジェクトの所有権を共有する2つのオブジェクトができました。
         retainのカウントは1つ増えます。
        クラスAはこのオブジェクトをもう必要としないので、クラスAは手動でこのオブジェクトのreleaseを呼び出す必要があります。
         その結果、retainのカウントが1つ減ります。
         これで、クラスBだけがこのオブジェクトを所有することになります。
         OK、最後に、クラスBもこのオブジェクトを解放したいと思います。
         これでretainカウントは0になり、ランタイムはこのオブジェクトを解放します。
         ここで、クラスBのメソッドがオブジェクトを返すという状況を考えてみましょう。
         このオブジェクトは他のプログラムでもまだ必要です。
         つまり、クラスBのメソッドでオブジェクトの所有権を放棄したいが、すぐに解放されたくはない。
         この場合、クラスBでautoreleaseを呼び出す必要があります。
         autoreleaseを呼んだ後もretain countは1のままなので、後でそのオブジェクトを使うことができます。
         ここで問題です。クラスBはもうこのオブジェクトを所有していないので、誰がこのオブジェクトの割り当てを解除する責任があるのでしょうか？Foundation Framework は AutoreleasePool と呼ばれる重要なオブジェクトを提供します。
         Autorelease API は、オブジェクトを AutoreleasePool に入れます。
         ここで、AutoreleasePoolはオブジェクトの所有権を取得します。
         AutoreleasePoolは、AutoreleasePoolが破壊されると、Receiverのretain countをデクリメントする。
         オートリリースされたオブジェクトを作成できるのは、あなただけではありません。
         Metal は、その操作の一部として、いくつかのオートリリースされたオブジェクトを作成します。
         一時的なオブジェクトを作成するすべてのメソッドは、フードの下でautoreleaseを呼び出すことによってAutoreleasePoolsにそれらを追加します。
         それらを解放するのは、AutoreleasePoolの責任です。
         言い換えれば、AutoreleasePool を使えば、よりエレガントな方法でコーディングできる。
         メインのアプリケーションにAutoreleasePoolを持たせることができます。
         また、プログラムのワーキング・セットを減らすために、より小さなスコープで追加の AutoreleasePool を作成し管理することをお勧めします。
         また、作成するすべてのスレッドに AutoreleasePool が必要です。
         ここでは、AutoreleasePool とオートリリースオブジェクトの使い方を説明します。
         このサンプルでは、AutoreleasePoolはallocで作成される。つまり、所有権を持ち、手動でリリースする必要がある。
         さて、AutoreleasePoolができました。
         冒頭で説明したように、コマンドバッファを作成する必要があります。
         これはallocやcreateで作られたものではないので、所有権はありません。
         その代わり、Metalが作成するオートリリース・オブジェクトです。
         このコマンドバッファはAutoreleasePoolに入れられます。
         AutoreleasePoolの責任で、これをdeallocateします。
         AutoreleasePoolを解放するまでは、好きなように使うことができます。
         次に、RenderPassDescriptorを作成する必要があります。
         このRenderPassDescriptorもAutoreleasePoolに入れることになります。
         RenderCommandEncoderも同様です。
         これもMetalが作ったAutoreleasedオブジェクトだ。
         このcurrentDrawableオブジェクトを忘れてはいけない。
         これもAutoreleasePoolに入れられる。
         コードの最後に、pPool->releaseでAutoreleasePoolを解放しています。
         この場合、CommandBuffer、RenderPassDescriptor、RenderCommandEncoder、および currentDrawable が解放されます。
         そして、AutoreleasePoolが解放される。
         ここまでで、Cocoaの規約、オートリリースオブジェクト、AutoreleasePoolsを知ることができたと思います。
         メモリリークやゾンビオブジェクトを避けるためには、オブジェクトのライフサイクルを正しく管理することが重要で、これらの問題の回避やデバッグを支援する素晴らしいツールが用意されています。
         ここでは、2つのユーティリティに焦点を当てます。NS::SharedPtrとNSZombieです。
         NS::SharedPtr は、オブジェクトのライフサイクルを管理するのに役立つ新しいユーティリティです。
         Foundation framework の metal-cpp フォルダにあります。
         std:shared_ptr と全く同じではないことに注意してください。
         そのため、C++標準ライブラリに依存せず、参照カウントを保存するための余分なコストもかかりません。
         NS::SharedPtrがどんなものかは、こんな感じです。
         Transfer と retain 関数はオブジェクトを消費する意図を明確に表現しています。
         Transfer はポインティの referenceCount を増やさずに SharedPtr を作成し、効果的に所有権を SharedPtr に移します。
         retain 関数は渡されたオブジェクトに retain を送ります。
         この関数は AutoreleasePools にあるオブジェクトを保持し、ポインタのオーナがポインタのライフサイクルに対して利害関係があることを表現するために使用されます。
         基礎となるオブジェクトには、get や operator-> を介して期待通りにアクセスできます。
         SharedPtr のコピー，移動，構築，代入は期待通りに動作し，コピーでは retainCount が増加します．
         移動は高速で、一般的なケースでは retain count に影響を与えません。
         SharedPtr は破棄されるとき、常にポインティに正確に 1 つのリリースを送信します。
         もし望むなら、detach 関数を呼び出すことでこれを避けることができます。
         トップに戻って、ポインタを転送して作成する場合と保持する場合の違いを知っておくことが重要です。
         TransferPtr では、参照カウントが 1 の MRR オブジェクトがあるとします。
         TransferPtr 関数に渡した後、SharedPtr はそのオブジェクトの所有権を取得しますが、その retainCount は変わりません。
         ポインタがスコープ外に出たとき、SharedPtr のデストラクタが実行され、MRR オブジェクトの release を呼び、retainCount を 0 にデクリメントします。
         もう一つの機能は NS::RetainPtr です。
         オブジェクトを後で使いたいので、deallocate を避けたいとき、NS::RetainPtr を使うべきです。
         例えば、このMRRオブジェクトがあるとします。retainCountは1です。
         これをRetainPtr関数に渡すと、retainCountは1つ増えます。
         スコープの外に出た後、この RetainPtr はこの MRR オブジェクトのために release を呼びます。
         だからretainCountは1です。
         一般にNS::TransferPtrはオブジェクトの所有権をあなたに代わって取得します。
         しかし、NS::RetainPtr はオブジェクトを解放されたくない時に、そのオブジェクトを保持する手助けをします。
         この2つの関数にオブジェクトを渡すと、NS::TransferPtr は参照カウントを変更しませんが、NS::RetainPtr はあなたのためにフードの下で retain を呼び出すので参照カウントを1つ増やします。
         これら2つの関数のデストラクタは，どちらも渡されたオブジェクトのreleaseを呼び出すので，参照カウントは1つ減少します．
         参照カウントが0になると、そのオブジェクトは実行時に解放されます。
         NS::TransferPtrの例です。
         1つの三角形を描くレンダーパスの話をしたとき、このレンダーパイプラインの状態が必要でした。
         以下は、レンダーパイプラインステートオブジェクトを作成するための呼び出しです。
         これらは、レンダー・パイプライン・デスクリプタが必要とする属性です。
         Cocoaの規約では、これらの呼び出しはnewとallocで始まるので、これらのオブジェクトは私の所有物です。
         だから、これらのオブジェクトのためにreleaseを呼び出す必要がある。
         NS::SharedPtr を使えば、NS::SharedPtrs がこれらのオブジェクトの所有権を持つので、これらの MRR オブジェクトに対してリリースを呼び出す必要はありません。
         そこで、ここでは TransferPtr 関数に生のポインタを渡しています。
         そうすると、前のスライドでやったようにreleaseを呼び出す必要がなくなります。
         ARCに慣れている方は、NS::SharedPtrで使用するMRRはARCを使用するのと似ていると思うかもしれません。
         メモリを手動で扱う場合、use-after-free バグに遭遇することがあります。
         これは、すでに解放されたオブジェクトを使用しようとしたときに発生します。
         NSZombieは、このようなバグをチェックするための良い方法です。
         使用後解放バグが発生した場合、ブレークポイントをトリガーし、スタックトレースを提供します。
         環境変数で簡単にゾンビを有効にすることができます。
         NSZombieEnabledをYESに設定するだけです。
         または、Xcodeを使用している場合、スキームでZombiesを有効にすることができます。
         その方法は、次のとおりです。
         同じレンダーパイプラインの設定で、新しいレンダーパイプラインの状態オブジェクトを作りたいと思います。
         そこで、このnewRenderPipelineState関数で、pDescオブジェクトを再利用しています。
        実行をクリックすると、Xcodeはブレークポイントをトリガーし、スタックトレースを表示します。
         つまり、私は何か間違っていたのです。
         うーん、何が問題なんだろう？NSZombieが役に立つかもしれないので、schemeでNSZombieを有効にしてみた。
        プログラムを再び実行すると、NSZombieがブレークポイントをトリガーします。
         コンソール出力に新しいものが表示されました。"割り当て解除されたインスタンスにメッセージが送信されました。
        " ああ、すでに解放したオブジェクトを再利用したんだ。
         レンダーパイプライン記述子です。
         だから、release を呼び出す前に、このレンダー・パイプライン・デスクリプタを使う必要があるんだ。
         そうすることで、問題を解決することができます。
         その他のツールや詳細については、今年の講演「ゲームのメモリをプロファイルして最適化する」で説明します。
        " 例えば、インストゥルメントでのアロケーションでretainCountを追跡する方法を学ぶことができます。
         Appleプラットフォームの他のツールも自由にチェックしてみてください。
         ゲームのデバッグやパフォーマンスの向上に役立つことが分かるはずです。
         これで、metal-cppでオブジェクトのライフサイクルを管理する方法がわかったと思います。
         しかし、ゲームコントローラやオーディオのような他のフレームワークとのインターフェイスがまだ必要な場合があります。
         これらはまだObjective-Cのままです。
         これらのAPIとどのようにインターフェースし、エレガントなアプリケーションアーキテクチャを設計すればよいのでしょうか。例えば、Objective-CでViewControllerを書き、C++でmetal-cppを使用してレンダラーを書いたとします。
         ViewControllerからdrawのようなレンダラーのメソッドを呼び出す必要がある。
         ここでの課題は、2つの言語をうまく分離しつつ、一緒に動作させることだ。
         解決策は、Objective-CファイルからC++を呼び出すアダプタークラスを作成することだ。
         こうすることで、機能を実装するファイルではObjective-CまたはC++に集中することができる。
         例えば、Objective-CでRendererAdapterクラスを作成することができます。
         そして、実装の下にObjective-Cのメソッドを追加し、ViewControllerから直接呼び出せるようにする。
         インターフェイスの内部では、レンダラー・オブジェクトへの C++ ポインターを宣言している。
         メソッド本体では、レンダラーのC++メソッドを直接呼び出す。
         このメソッドは、MTK::ViewをC++オブジェクトとしてdrawメソッドに渡す必要があるため、__bridgeキーワードを使ってビューをC++型にキャストしています。
         このキャストについては、後で詳しく説明します。
         これに対して、C++で書かれたRendererで、Objective-Cで書かれたMTKViewを呼び出す必要があります。
         こちらも難易度が高いです。
         同様に、解決策としては、アダプタクラスを作成します。
         このクラスがあれば、C++のファイル内で、C++のインターフェイスを使って、Objective-Cのメソッドを呼び出すことができる。
         例えば、ViewAdapter クラスを作ることができる。
         C++でインターフェースを書くので、Rendererクラスで、それらのC++のビューメソッドを簡単に呼び出すことができます。
         実装では、MTKViewからcurrentDrawableやdepthStencilTextureなどのObjective-Cのメソッドを呼び出しています。
         ここで、いくつかの__bridgeキーワードがあることに気づくかもしれません。
         これはmetal-cppのオブジェクトとObjective-Cのオブジェクトをキャストするために使っています。
         最初に学んだように、メタルカップルのオブジェクトは手動で保持と解放を行いますが、Objective-Cで作成したオブジェクトは自動的な参照カウントを使用します。
         MRRからARCへ、ARCからMRRへオブジェクトを移動させる必要があります。
         ここでは、Objective-CとC++の間でキャストするのに役立つ3種類のブリッジキャスティングを紹介します。
         ブリッジキャストは、Objective-CとMetal-cppのオブジェクトの間でキャストします。
         これらの間で所有権の移転は行われません。
         ブリッジキャスト（_bridge_retained casting）は、Objective-C ポインタを metal-cpp ポインタにキャストし、ARC から所有権を取得します。
         bridge_transferキャストは、metal-cppポインタをObjective-Cに移動し、所有権をARCに移します。
         問題に戻ると、Metal-cppオブジェクトとObjective-Cオブジェクトの間でキャストをする必要があります。
         所有権の移動がない場合は、__bridge castを使用します。
         metal-cppからObjective-Cオブジェクトにキャストして、所有権をObjective-Cに移したい場合は、__bridge_transferキャストを使用します。
         Objective-Cからmetal-cppのオブジェクトにキャストして、ARCから所有権を取り出したい場合は、__bridge_retainedキャストを使用する必要があります。
         ここで、MetalKitを使用してアセット読み込みコードを活用しなければならないケースを紹介します。
         つまり、私のC++アプリケーションでは、Metal-cppオブジェクトとしてのテクスチャが必要ですが、それはObjective-Cのメソッドで作成されます。
         ARCから所有権を移し、手動で解放できるようにする必要があります。
         そしてこの場合、__bridge_retained castを選ぶ必要があります。
         カタログからテクスチャをロードするC++関数があり、Metal-cppテクスチャを返したいのです。
         しかし、内部ではMetalKitのObjective-C関数をいくつか呼び出しています。
         テクスチャローダーが必要とするオプションを定義する必要があります。
         次に、MetalKitからObjective-Cのメソッドを呼び出してテクスチャローダーを作成します。
         このローダーで、テクスチャオブジェクトを作成し、カタログからテクスチャをロードします。
         このメソッドもMetalKitのObjective-Cメソッドです。
         これでObjective-Cタイプのテクスチャができたので、それをmetal-cppオブジェクトにキャストしてARCから取り出す必要があります。
         これらの手順を踏まえて、いよいよコーディングに入りますが、実際にどのようにキャスティングが行われるかを紹介します。
         最初のステップは、テクスチャローダーが必要とするテクスチャローダーオプションを定義することです。
         metal-cppのストレージモードと使用法は、同じ値で定義されているので、安全にObjective-Cの型にキャストすることができます。
         ここでは、テクスチャローダを作成します。
         デバイスはmetal-cppオブジェクトで、initWithDeviceメソッドに渡す必要があります。
         metal-cppオブジェクトはObjective-Cのオブジェクトなので、トールフリー・オブジェクトのようにキャストすることができます。
         所有権の移動はありません。
         さて、テクスチャローダーのオプションとテクスチャローダーを使ってテクスチャを作成する。
         そして、読み込んだテクスチャをmetal-cppオブジェクトとして返したい。
         そこで、ARCから取り出して、対応するポインタ型にキャストする必要があります。
         これは、__bridge_retainedキャストで行われます。
         この後、このテクスチャを任意のMetal-cppオブジェクトとして使用することができます。
         私はそれを解放する責任があります。
         このセクションでは、プログラムの中で2つの異なる言語を扱うのに役立つアダプタパターンを提供しました。
         また、Objective-CとC++を3種類のキャストでインターフェースする方法を示しました。
         要約すると、metal-cppは軽量で非常に効率的なMetal C++のラッパーです。
         metal-cppを使用する際のオブジェクトライフサイクルの管理方法、Objective-Cとのエレガントなインターフェイス方法、そして我々の開発者ツールがデバッグを支援する方法についてお話しました。
         metal-cppをダウンロードして、今すぐすべての素晴らしいサンプルで遊んでみてください。Metalで何が作れるか見てみましょう。
         あなたのC++アプリケーションがすべてのAppleプラットフォームで動作するのを見るのを楽しみにしています。
         ご視聴ありがとうございました。

        """
    }
}

