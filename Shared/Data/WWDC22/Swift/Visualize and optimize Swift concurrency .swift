import Foundation

struct VisualizeAndOptimizeSwiftConcurrency: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Visualize and optimize Swift concurrency"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6704/6704_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/110350/")!
    }

    var english: String {
        """
        Welcome to Visualize and Optimize Swift Concurrency.
         My name is Mike, and I work on the Swift runtime library.
         Hi, I'm Harjas, and I work on Instruments.
         Together, we're going to discuss ways to better understand your Swift Concurrency code and make it go faster, including a new visualization tool available in Instruments 14.
         Let's start off with a really quick recap of the various parts of Swift Concurrency and how they work together, to make sure you're up to speed.
         After that, we'll demo the new concurrency instrument.
         We'll show you how we use it to solve some real performance issues with an app using Swift Concurrency.
         Finally, we'll discuss the potential problems of thread pool exhaustion and continuation misuse and how to avoid them.
         Last year, we introduced Swift Concurrency.
         This was a new language feature that includes async/await, structured concurrency, and Actors.
         We've been pleased to see a great deal of adoption of these features since then, both inside and outside Apple.
         Swift concurrency adds several new features to the language which work together to make concurrent programming easier and safer.
         Async/await are basic syntactic building blocks for concurrent code.
         They allow you to create and call functions that can suspend their work in the middle of execution, then resume that work later, without blocking an execution thread.
        Tasks are the basic unit of work in concurrent code.
         Tasks execute concurrent code and manage its state and associated data.
         They contain local variables, handle cancellation, and begin and suspend execution of async code.
         Structured concurrency makes it easy to spawn child tasks to run in parallel and wait for them to complete.
         The language provides syntax which keeps the work grouped together and ensures that tasks are awaited or automatically canceled if not used.
         Actors coordinate multiple tasks that need to access shared data.
         They isolate data from the outside, and allow only one task at a time to manipulate their internal state, avoiding data races from concurrent mutation.
         New in Instruments 14, we're introducing a set of instruments that can capture and visualize all of this activity in your app, helping you to understand what your app is doing, locate problems, and improve performance.
         For a more in-depth discussion of the fundamentals of Swift Concurrency, we have several videos about these features linked in the Related Videos section.
        Let's take a look at optimizing an app using Swift Concurrency code.
         Swift concurrency makes it easy to to write correct concurrent and parallel code.
         However, it's still possible to write code that misuses concurrency constructs.
         It's also possible to use them correctly but in a way that doesn't get the performance benefits you were aiming for.
        There are a few common problems that can arise when writing code using Swift concurrency that can cause poor performance or bugs.
         Main Actor blocking can cause your app to hang.
         Actor contention and thread pool exhaustion hurt performance by reducing parallel execution.
         Continuation misuse causes leaks or crashes.
         The new Swift Concurrency instrument can help you discover and fix these problems.
         Let's take a look at each of these, starting with main Actor blocking.
         Main Actor blocking occurs when a long-running task runs on the main Actor.
         The main Actor is a special Actor which executes all of its work on the main thread.
         UI work must be done on the main thread, and the main Actor allows you to integrate UI code into Swift Concurrency.
         However, because the main thread is so important for UI, it needs to be available and can't be occupied by a long-running unit of work.
         When this happens, your app appears to lock up and becomes unresponsive.
         Code running on the main Actor must finish quickly, and either complete its work or move computation off of the main Actor and into the background.
         Work can be moved into the background by putting it in a normal Actor or in a detached task.
         Small units of work can be executed on the main Actor to update UI or perform other tasks that must be done on the main thread.
         Let's see a demo of this in action.
         Thanks, Mike.
         Here we have our File Squeezer application.
         We built this application to be able to quickly compress all the files in a folder.
         It seems to work alright for small files.
         However, when I use larger files, it takes much longer than expected and the UI is completely frozen and does not respond to any interactions.
         This behavior is very off-putting to users and may make them think that the application has crashed or will never finish.
         We should strive to ensure that our UI is always responsive for the best user experience.
         To investigate this performance problem, we can use the new Swift Concurrency template in Instruments.
         The Swift Tasks and Swift Actors instruments provide a full suite of tools to help you visualize and optimize your concurrency code.
         When you're just starting to investigate a performance problem you should first take a look at the top-level statistics provided to you by the Swift Tasks instrument.
         The first of these is Running Tasks, which show you how many tasks are executing simultaneously.
         Next, we have Alive Tasks, which show how many tasks are present at a given point in time.
         And finally, Total Tasks; graph the total number of tasks that have been created up until that point in time.
         When you're attempting to reduce your application memory footprint, you should take a close look at the Alive and Total Tasks statistics.
         The combination of all of these statistics give you a good picture of how well your code is parallelizing and how many resources you are consuming.
         One of the many detail views for this instrument is the Task Forest; shown in the bottom half of this window, it provides a graphical representation of the parent-child relationships between Tasks in structured concurrency code.
         Next, we have our Task Summary view.
         This shows how much time each Task spends in different states.
         We have super-charged the view by allowing you to right-click on a Task to be able to pin a Track containing all the information about the selected Task to the timeline.
         This allows you to quickly find and learn about Tasks of interest that may be running for a very long time or stuck waiting to get access to an Actor.
         Once you pin a Swift Task to the timeline, you get four key features.
         First, is the track that shows you what state your Swift Task is in.
         Second, is the Task creation backtrace in the extended detail view.
         Third, is the narrative view that provides more context about the state a Swift Task is in.
         Such as, if it's waiting on a Task, it will inform you which Task you are waiting on.
         Lastly, you have access to the same pin action in the narrative view as you did in the summary view.
         So, you can pin a child Task, a thread, or even a Swift Actor to the timeline.
         This narrative view will be instrumental in finding how a Swift Task is related to your other concurrency primitives and the CPU.
         Now that we have seen a brief overview of some of the features in the new instrument, let's profile our application and optimize our code.
         We can do this by pulling up our project in Xcode and pressing Command-I.
         This will compile our application, open up instruments, and pre-select the target to the File Squeezer application.
         From here you can pick the Swift Concurrency option in the template picker and start recording.
        Once again, I'll drop the large files onto the app.
        Again, we see that the app starts spinning and the UI is not responsive.
         We will let this run for a few more seconds so that Instruments can capture all the information about our application.
        Now that we have a trace, we can start investigating.
         I'm going to fullscreen this trace to better see all the information.
        We can use option-drag to zoom in on our area of interest.
        In the process track, Instruments shows us exactly where this UI hang was occurring.
         This can be useful for cases when it is not clear when the hang occurred or how long it lasted.
         As I mentioned earlier, a good place to start is the top-level Swift Task statistics.
         What catches my eye right away is the Running Tasks count.
         For most of the time, only one Task is running.
         This tells us part of the problem is that all of our work is being forced to serialize.
         We can use the Task State summary to find our longest running Task and use the pin action to pin it to the timeline.
        The narrative view for this Task tells us that it ran on a background thread for a short amount of time, and then ran on the Main Thread for a long time.
         To further investigate, we can pin the Main Thread to the timeline.
        The Main Thread is being blocked by several long running Tasks.
         This demonstrates the issue of Main Actor blocking that Mike spoke about.
         So the questions we have to ask ourselves are, "What is this Task doing?" and "Where did this Task come from?" We can switch back to the narrative view to answer both of these questions.
         The creation backtrace in the extended detail view shows that the task was created in the compressAllFiles function.
         The narrative shows that the Task is executing closure number one in compressAllFiles.
         By right-clicking on this symbol, we can open this in the source viewer.
        Closure number one inside this function is calling our compression work.
         Now that we know where this Task was created and what it is doing, we can open our code in Xcode and adapt it so that we don't run these heavy computations on the Main Thread.
         The compress file function is located within the CompressionState class.
         The entire CompressionState class is annotated to run on the @MainActor.
         This explains why the Task also ran on the Main Thread.
         We need this entire class to be on the MainActor because the @Published property here must only be updated from the Main Thread, otherwise, we could run into runtime issues.
         So, instead we could try to convert this class into its own Actor.
         However, the compiler will tell us that we can't do this because essentially we would be saying that this shared mutable state needs to be protected by two different Actors.
         But that does give us a hint for what the real solution is.
         We have two different pieces of mutable state here within this class.
         One piece of state, the 'files' property, needs to be isolated to the MainActor because it is observed by SwiftUI.
         But access to the other piece of state, the logs, needs to be protected from concurrent access, but which thread accesses logs at any given point doesn't matter.
         Thus, it doesn't actually need to be on the Main Actor.
         We still want to protect it from concurrent access, though, so we wrap it in its own Actor.
         All we need now is add a way for Tasks to hop between the two as needed.
         We can create a new Actor and call it ParallelCompressor.
        We can then copy the log state into the new Actor, and add some extra setup code.
        From here, we need to make these Actors communicate with each other.
         First, let's remove the code that referred to the logs variable from the CompressionState class, and add it to our ParallelCompressor Actor.
        Then finally, we need to update CompressionState to invoke compressFile on the ParallelCompressor.
        With these changes, let's test our application again.
         Once again, I'll drop the large files onto our application.
        The UI is no longer hung, which is a great improvement, but we aren't getting the speed that we would expect.
         We really want to take full advantage of all the cores in the machine to do this work as fast as possible.
         Mike, what else should we be watching out for? Mike: We've solved our hang by moving work off of the Main Actor, but we're still not getting the performance we want.
         To see why, we need to take a closer look at Actors.
         Actors make it safe for multiple tasks to manipulate shared state.
         However, they do this by serializing access to that shared state.
         Only one task at a time is allowed to occupy the Actor, and other tasks that need to use that Actor will wait.
         Swift concurrency allows for parallel computation using unstructured tasks, task groups, and async let.
         Ideally, these constructs are able to use many CPU cores simultaneously.
         When using Actors from such code, beware of performing large amounts of work on an Actor that's shared among these tasks.
         When multiple tasks attempt to use the same Actor simultaneously, the Actor serializes execution of those tasks.
         Because of this, we lose the performance benefits of parallel computation.
        This is because each task must wait for the Actor to become available.
         To fix this, we need make sure that tasks only run on the Actor when they really need exclusive access to the Actor's data.
         Everything else should run off of the Actor.
         We divide the task into chunks.
         Some chunks must run on the Actor, and the others don't.
         The non-Actor isolated chunks can be executed in parallel, which means the computer can finish the work much faster.
         Let's see a demo of this in action.
         Harjas: Thanks, Mike.
         Let's take a look at the trace of our updated "File Squeezer" application and keep in mind what Mike has just taught us.
         The Task Summary view shows us that our concurrency code is spending an alarming amount of time in the Enqueued state.
         This means we have a lot of Tasks waiting to get exclusive access to an Actor.
         Let's pin one of these Tasks to learn why.
        This Task spends quite a while waiting to get onto the ParallelCompressor Actor before it runs the compression work.
         Let's go ahead and pin the Actor to our timeline.
        Here we have some top-level data for the ParallelCompressor Actor.
         This Actor Queue seems to be getting blocked by some long running Tasks.
         Tasks should really only stay on an Actor for as long as needed.
         Let's go back to the Task narrative.
        After the enqueue on ParallelCompressor, the Task runs in closure number one in compressAllFiles.
         So let's start our investigation there.
         The source code shows us that this closure is primarily running our compression work.
         Since the compressFile function is part of the ParallelCompressor Actor, the entire execution of this function happens on the Actor; blocking all other compression work.
         To resolve this issue, we need to pull the compressFile function out of Actor-isolation and into a detached task.
        By doing this, we can have the detached task only on an Actor for as long as needed to update the relevant mutable state.
         So now the compress function can be executed freely, on any thread in the thread pool, until it needs to access Actor-protected state.
         For example, when it needs to access the 'files' property, it'll move onto the Main Actor.
         But as soon as it's done there, it moves into the "sea of concurrency" again, until it needs to access the logs property, for which it moves on to the ParallelCompressor Actor.
         But again, as soon as it's done there, it leaves the Actor again to be executed on the thread pool.
         But of course, we don't have just one task doing compression work; we have many.
         And by not being constrained to an Actor, they can all be executed concurrently, only limited by the number of threads.
        Of course, each Actor can only execute one task at a time, but most of the time, our Tasks don't need to be on an Actor.
         So like Mike explained, this allows our compression tasks to executed in parallel and utilize all available CPU cores.
         So let's make this change now.
        We can mark the compressFile function as nonisolated.
        This does result in a few compiler errors.
         By marking it as nonisolated, we told the Swift compiler that we don't need access to the shared state of this Actor.
         But that isn't entirely true.
         This log function is Actor-isolated and it needs access to the shared mutable state.
         In order to fix this, we need to make this function async and then mark all of our log invocations with the await keyword.
        Now we need to update our task creation to create a detached task.
        We do this to ensure the Task does not inherit the Actor-context that it was created in.
         For detached tasks, we need to explicitly capture self.
        Let's test our application again.
        The app is able to compress all the files simultaneously and the UI remains responsive.
         To verify our improvements, we can check the Swift Actors instrument.
         Looking at the ParallelCompressor Actor, most of the work executed on the Actor is only for a short amount of time and the queue size never gets out of hand.
         To recap, we used the Instrument to Isolate the cause of a UI hang, we restructured our concurrency code for better parallelism, and verified performance improvements using data.
         Now Mike is gonna tell us about some other potential performance issues.
         Mike: There are two common problems I'd like to cover beyond what we've seen in the demo.
         First, let's talk about thread pool exhaustion.
         Thread pool exhaustion can hurt performance or even deadlock an application.
         Swift concurrency requires tasks to make forward progress when they're running.
         When a task waits for something, it normally does so by suspending.
         However, it's possible for code within a task to perform a blocking call, such as blocking file or network IO, or acquiring locks, without suspending.
         This breaks the requirement for tasks to make forward progress.
         When this happens, the task continues to occupy the thread where it's executing, but it isn't actually using a CPU core.
         Because the pool of threads is limited and some of them are blocked, the concurrency runtime is unable to fully use all CPU cores.
         This reduces the amount of parallel computation that can be done and the maximum performance of your app.
         In extreme cases, when the entire thread pool is occupied by blocked tasks, and they're waiting on something that requires a new task to run on the thread pool, the concurrency runtime can deadlock.
         Be sure to avoid blocking calls in tasks.
         File and network IO must be performed using async APIs.
         Avoid waiting on condition variables or semaphores.
         Fine-grained, briefly-held locks are acceptable if necessary, but avoid locks that have a lot of contention or are held for long periods of time.
         If you have code that needs to do these things, move that code outside of the concurrency thread pool– for example, by running it on a Dispatch queue– and bridge it to the concurrency world using continuations.
         Whenever possible, use async APIs for blocking operations to keep the system operating smoothly.
         When you're using continuations, you must be careful to use them correctly.
         Continuations are the bridge between Swift concurrency and other forms of async code.
         A continuation suspends the current task and provides a callback which resumes the task when called.
         This can then be used with callback-based async APIs.
         From the perspective of Swift concurrency, the task suspends, and then it resumes when the continuation is resumed.
         From the perspective of the callback-based async API, the work begins, and then the callback is called when the work completes.
         The Swift Concurrency instrument knows about continuations and will mark the time interval accordingly, showing you that the task was waiting on a continuation to be called.
         Continuation callbacks have a special requirement: they must be called exactly once, no more, no less.
         This is a common requirement in callback-based APIs, but it tends to be an informal one and is not enforced by the language, and oversights are common.
         Swift concurrency makes this a hard requirement.
         If the callback is called twice, the program will crash or misbehave.
         If the callback is never called, the task will leak.
         In this code snippet we use withCheckedContinuation to get a continuation.
         We then invoke a callback-based API.
         In the callback, we resume the continuation.
         This meets the requirement of calling it exactly once.
         It's important to be careful when the code is more complex.
         On the left, we've modified the callback to only resume the continuation on success.
         This is a bug.
         On failure, the continuation will not be resumed, and the task will be suspended forever.
         On the right, we're resuming the continuation twice.
         This is also a bug, and the app will misbehave or crash.
         Both of these snippets violate the requirement to resume the continuation exactly once.
         Two kinds of continuations are available: checked and unsafe.
         Always use the withCheckedContinuation API for continuations unless performance is absolutely critical.
         Checked continuations automatically detect misuse and flag an error.
         When a checked continuation is called twice, the continuation traps.
         When the continuation is never called at all, a message is printed to the console when the continuation is destroyed warning you that the continuation leaked.
         The Swift Concurrency instrument will show the corresponding task stuck indefinitely in the continuation state.
         There is much more to look into for the new Swift Concurrency template in Instruments.
         You can get graphic visualization of structured concurrency, view task creation calltrees, and inspect the exact assembly instructions to get a full picture of the Swift Concurrency runtime.
         To learn more about how Swift Concurrency works under the hood, watch last year's session on "Swift Concurrency: Behind the Scenes.
        " And to learn more about data races, watch "Eliminate data races using Swift Concurrency."
         Thanks for watching! And have fun debugging your concurrency code.

        """
    }

    var japanese: String {
        """
        Visualize and Optimize Swift Concurrency へようこそ。
         私はマイクです。Swift ランタイムライブラリを担当しています。
         私はHarjasで、Instrumentsを担当しています。
         今回は、Swiftの同時実行コードをより理解し、高速化する方法について、Instruments 14の新しい可視化ツールも含めてご紹介します。
         まず、Swift Concurrency のさまざまな部分と、それらがどのように連携しているかを簡単に説明し、スピードアップを図ることから始めます。
         その後、新しいコンカレンシーインストルメントをデモします。
         Swift Concurrency を使用したアプリの実際のパフォーマンスの問題を解決するために、どのようにそれを使用するかをお見せします。
         最後に、スレッドプールの枯渇と継続の誤用という潜在的な問題と、それらを回避する方法について説明します。
         昨年、私たちは Swift Concurrency を導入しました。
         これは、async/await、構造化された同時実行、および Actor を含む、新しい言語機能でした。
         それ以来、Apple の内部と外部の両方で、これらの機能が大いに採用されていることを嬉しく思っています。
         Swift の並行処理は、並行プログラミングをより簡単かつ安全にするために一緒に働く、いくつかの新しい機能を言語に追加します。
         Async/awaitは、同時実行コードのための基本的な構文ブロックです。
         これらは、実行スレッドをブロックすることなく、実行の途中で作業を中断し、後でその作業を再開することができる関数を作成し、呼び出すことを可能にします。
        タスクは、並行処理コードの作業の基本単位です。
         タスクは、並行コードを実行し、その状態と関連データを管理します。
         タスクはローカル変数を含み、キャンセルを処理し、非同期コードの実行を開始および中断します。
         構造化された並行処理により、並行して実行する子タスクを簡単に生成し、そのタスクが完了するのを待つことができます。
         この言語は、作業をグループ化し、タスクを待機させるか、使用しない場合は自動的にキャンセルする構文を提供する。
         アクターは、共有データにアクセスする必要がある複数のタスクを調整します。
         アクタは、データを外部から分離し、一度に1つのタスクのみが内部状態を操作できるようにし、同時実行中の変異によるデータ競合を回避します。
         Instruments 14の新機能として、アプリ内のすべてのアクティビティをキャプチャして視覚化し、アプリの動作の理解、問題の特定、パフォーマンスの向上に役立てることができるインストゥルメント セットが導入されました。
         Swift の並行処理の基礎についてのより詳細な議論については、関連ビデオ セクションにリンクされているこれらの機能に関するいくつかのビデオがあります。
        Swift の並行処理コードを使用してアプリを最適化することについて見てみましょう。
         Swift の並行処理では、正しい並行処理と並列コードを書くことが簡単になります。
         しかし、並行処理構造を誤って使用するコードを書くことはまだ可能です。
         また、正しく使用しても、狙っていた性能上の利点が得られないような方法で使用することも可能です。
        Swift の並行処理を使用してコードを書くときに発生する可能性のある、パフォーマンスの低下やバグを引き起こす可能性のある、いくつかの一般的な問題があります。
         主なアクターブロッキングは、アプリがハングする原因になります。
         アクターの競合とスレッドプールの枯渇は、並列実行を減らすことによってパフォーマンスを低下させます。
         継続の誤用は、リークやクラッシュを引き起こします。
         新しい Swift Concurrency 測定器は、これらの問題を発見し修正するのに役立ちます。
         メインアクターブロッキングから始めて、これらの各々を見てみましょう。
         メインアクターブロッキングは、長時間実行されるタスクがメインアクター上で実行されるときに発生します。
         メインアクターは、すべての作業をメインスレッドで実行する特別なアクターです。
         UI の作業はメインスレッドで行う必要があり、メインアクターによって UI コードを Swift Concurrency に統合することができます。
         しかし、メインスレッドは UI にとって非常に重要なので、利用可能である必要があり、長時間実行する作業単位によって占拠されることはできません。
         これが起こると、アプリがロックしているように見え、応答しなくなります。
         メイン・アクターで実行されているコードは、すばやく終了し、作業を完了するか、メイン・アクターからバックグラウンドに計算を移動する必要があります。
         作業をバックグラウンドに移すには、通常のActorに入れるか、デタッチドタスクに入れればよいのです。
         小さな作業単位をメインActor上で実行し、UIの更新やメインスレッドで行わなければならない他のタスクを実行することができます。
         では、実際にデモを見てみましょう。
         Mikeさん、ありがとうございます。
         ここでは、File Squeezerアプリケーションを紹介します。
         このアプリケーションは、フォルダー内のすべてのファイルをすばやく圧縮できるように作成しました。
         小さなファイルであれば、問題なく動作するようです。
         しかし、大きなファイルを使用すると、予想以上に時間がかかり、UIが完全にフリーズして、どのようなインタラクションにも反応しなくなります。
         このような動作はユーザーにとって非常に不快であり、アプリケーションがクラッシュした、あるいは永遠に終わらないのではないかと思わせる可能性があります。
         最高のユーザーエクスペリエンスを得るためには、UIが常に応答するように努力する必要があります。
         このパフォーマンスの問題を調査するために、Instruments の新しい Swift Concurrency テンプレートを使用することができます。
         Swift Tasks と Swift Actors のツールは、並行処理コードを視覚化して最適化するのに役立つツールの完全なスイートを提供します。
         パフォーマンスの問題を調査し始めたばかりのときは、最初に Swift Tasks のツールによって提供されるトップレベルの統計を見てみるべきです。
         これらの最初のものは、同時に実行されているタスクの数を示す、実行中のタスク（Running Tasks）です。
         次に、アライブタスクがあり、ある時点でどれだけのタスクが存在するかを示します。
         そして最後に、「総タスク数」。これは、その時点までに作成されたタスクの総数をグラフ化したものです。
         アプリケーションのメモリフットプリントを削減しようとする場合、アライブタスクとトータルタスクの統計値をよく見る必要があります。
         これらの統計情報をすべて組み合わせると、コードがどの程度並列化されているか、どの程度のリソースを消費しているかがよくわかります。
         この装置の多くの詳細ビューの1つは、タスクフォレストです。このウィンドウの下半分に表示され、構造化された並行処理コードのタスク間の親子関係をグラフィカルに表現しています。
         次に、タスクサマリービューです。
         これは、各タスクが異なる状態でどれだけの時間を費やしたかを表示します。
         タスクの上で右クリックすると、選択したタスクに関するすべての情報を含むトラックをタイムラインにピン留めすることができ、このビューは非常に便利です。
         これにより、非常に長い時間実行されていたり、アクターへのアクセス待ちで止まっている可能性のある興味のあるタスクを素早く見つけ、知ることができます。
         Swift のタスクをタイムラインに固定すると、4つの重要な機能を得ることができます。
         まず、Swift タスクがどのような状態であるかを示すトラックです。
         2つ目は、拡張された詳細ビューでのタスク作成のバックトレースです。
         3つ目は、Swiftタスクが置かれている状態について、より多くのコンテキストを提供するナラティブビューです。
         例えば、タスクで待機している場合、どのタスクで待機しているのかを通知します。
         最後に、サマリービューで行ったのと同じように、ナラティブビューでピンアクションにアクセスすることができます。
         つまり、子タスク、スレッド、あるいは Swift のアクターをタイムラインにピン留めすることができます。
         このナラティブビューは、Swiftタスクが他の並行処理プリミティブとCPUにどのように関連しているかを見つけるのに役立ちます。
         さて、新しいインストルメントの機能のいくつかの簡単な概要を見てきましたが、アプリケーションをプロファイリングして、コードを最適化することにしましょう。
         これを行うには、Xcode でプロジェクトをプルアップし、Command-I キーを押します。
         これにより、アプリケーションがコンパイルされ、計測器が開かれ、File Squeezer アプリケーションのターゲットが事前に選択されます。
         ここから、テンプレートピッカーで Swift Concurrency オプションを選び、レコーディングを開始することができます。
        もう一度、大きなファイルをアプリにドロップしてみます。
        ここでも、アプリが回転を始め、UI が応答しないことがわかります。
         さらに数秒間実行し、アプリケーションに関するすべての情報を取得します。
        トレースができたので、調査を開始します。
         すべての情報を見るために、このトレースをフルスクリーン表示します。
        option-dragで興味のある部分を拡大することができます。
        プロセス トラックでは、UI ハングが発生した場所を正確に示しています。
         これは、ハングアップがいつ発生したか、どのくらい続いたかが明確でない場合に便利です。
         先に述べたように、手始めはトップレベルの Swift タスク統計から始めるのが良いでしょう。
         すぐに私の目を引くのは、実行中のタスクの数です。
         ほとんどの時間、1つのタスクだけが実行されています。
         これは、問題の一部が、すべての作業がシリアライズすることを余儀なくされていることを物語っています。
         タスクの状態のサマリーから、最も長く実行されているタスクを見つけ、ピンアクションを使用してタイムラインに固定することができます。
        このタスクのナラティブビューでは、バックグラウンドスレッドで短時間実行され、その後、メインスレッドで長時間実行されたことがわかります。
         さらに調べるために、Main Thread をタイムラインに固定することができます。
        Main Threadは、複数の長時間実行タスクによってブロックされています。
         これは、Mikeが話したMain Actorのブロックの問題を実証しています。
         つまり、「このタスクは何をしているのか」「このタスクはどこから来たのか」ということを自問自答しなければなりません。この2つの質問に答えるために、ナラティブ・ビューに戻ることができます。
         拡張詳細ビューの作成バックトレースは、タスクが compressAllFiles 関数で作成されたことを示しています。
         ナラティブビューでは、タスクがcompressAllFilesの1番目のクロージャを実行していることがわかります。
         このシンボルを右クリックすることで、ソースビューアで開くことができます。
        この関数内の1番目のクロージャは、圧縮作業を呼び出しています。
         このタスクがどこで作成され、何をしているかがわかったので、Xcodeでコードを開き、これらの重い計算をMain Threadで実行しないように適応させることができます。
         compress file関数は、CompressionStateクラス内にあります。
         CompressionStateクラス全体は、@MainActor上で実行されるようにアノテーションされています。
         これは、TaskもMain Threadで実行される理由を説明しています。
         なぜなら、このクラスの@PublishedプロパティはMain Threadからのみ更新されなければならず、そうでなければランタイムの問題に遭遇する可能性があるからです。
         そこで、代わりにこのクラスを独自のActorに変換しようとすることができます。
         なぜなら、本質的に、この共有されたミュータブルな状態を2つの異なるActorで保護する必要があると言うことになるからです。
         しかし、これが本当の解決策を示すヒントとなります。
         このクラスには、2つの異なるミュータブル状態があります。
         状態の1つのピース、'files'プロパティは、SwiftUIによって観察されるため、MainActorに分離される必要があります。
         しかし、状態の他の部分、ログへのアクセスは、同時アクセスから保護される必要がありますが、任意の時点でどのスレッドがログにアクセスするかは重要ではありません。
         したがって、実際にはメインアクターである必要はありません。
         しかし、同時アクセスから保護したいので、独自のアクターでラップします。
         あとは、必要に応じてタスクがこの2つの間を行き来する方法を追加すればよいのです。
         新しいActorを作成し、ParallelCompressorと呼びます。
        そして、ログの状態を新しいActorにコピーし、追加の設定コードを追加します。
        ここからは、これらのActorが互いに通信するようにする必要があります。
         まず、CompressionStateクラスからlogs変数を参照していたコードを削除し、それをParallelCompressor Actorに追加しましょう。
        そして最後に、CompressionStateを更新して、ParallelCompressorでcompressFileを呼び出すようにします。
        これらの変更により、アプリケーションを再度テストしてみましょう。
         もう一度、大きなファイルをアプリケーションにドロップしてみます。
        UI がハングアップしなくなったのは素晴らしい改善ですが、期待したほどの速度は得られていません。
         マシンのすべてのコアをフルに活用して、この作業を可能な限り高速に行いたいのです。
         マイク、他に気をつけるべきことはありますか？マイク：メインアクターから作業を移すことでハングアップを解決しましたが、まだ期待する性能は得られていません。
         その理由を知るには、アクターを詳しく見てみる必要があります。
         アクターは、複数のタスクが共有の状態を安全に操作できるようにします。
         しかし、そのためには、共有状態へのアクセスをシリアライズする必要があります。
         一度に 1 つのタスクだけが Actor を占有することができ、その Actor を使用する必要がある他のタスクは待機します。
         Swift の並行処理では、非構造化タスク、タスクグループ、および非同期レットを使用して並列計算を行うことができます。
         理想的には、これらの構成は、同時に多くの CPU コアを使用することができます。
         このようなコードから Actor を使用する場合、これらのタスク間で共有されている Actor で大量の作業を実行することに注意してください。
         複数のタスクが同じ Actor を同時に使用しようとすると、Actor はそれらのタスクの実行をシリアライズします。
         このため、並列計算の性能上の利点が失われます。
        これは、各タスクが Actor を利用できるようになるまで待つ必要があるためです。
         この問題を解決するには、タスクがActor上で実行されるのは、Actorのデータへの排他的なアクセスが本当に必要な場合だけであることを確認する必要があります。
         それ以外のものは、Actorの外で実行されるべきです。
         タスクをチャンクに分割します。
         あるチャンクはActor上で実行されなければならず、他のチャンクはそうではありません。
         アクターから切り離されたチャンクは並列に実行できるので、コンピュータはずっと速く仕事を終えることができます。
         では、実際にデモを見てみましょう。
         ハルヤス ありがとう、マイク。
         今Mikeが教えてくれたことを思い出しながら、更新された「File Squeezer」アプリケーションのトレースを見てみましょう。
         タスクサマリービューを見ると、コンカレンシーコードがEnqueuedの状態で驚くほど多くの時間を費やしていることがわかります。
         これは、アクターへの排他的なアクセスを待っているタスクがたくさんあることを意味します。
         その理由を知るために、これらのタスクの1つをピン留めしてみましょう。
        このタスクは、圧縮作業を実行する前に、ParallelCompressor Actor にアクセスするのをかなり長い時間待っています。
         このActorをタイムラインに固定しましょう。
        ParallelCompressor Actorのトップレベルのデータがあります。
         この Actor Queue は、長時間実行されるタスクによってブロックされているようです。
         タスクは、本当に必要な間だけアクター上にあるべきです。
         タスクの説明に戻りましょう。
        ParallelCompressorでエンキューされた後、タスクはcompressAllFilesのクロージャーの1番で実行されます。
         そこで、そこから調査を始めてみましょう。
         ソースコードから、このクロージャが主に圧縮作業を実行していることがわかります。
         compressFile関数はParallelCompressor Actorの一部なので、この関数の実行はすべてActor上で行われ、他のすべての圧縮作業がブロックされています。
         この問題を解決するには、compressFile関数をActorから分離して、デタッチドタスクに引き込む必要があります。
        こうすることで、デタッチドタスクは、ミュータブルな状態を更新するのに必要な時間だけ、Actor上に置くことができるようになります。
         圧縮関数は、アクターで保護された状態にアクセスする必要があるまで、スレッドプールの任意のスレッドで自由に実行できるようになりました。
         たとえば、「files」プロパティにアクセスする必要があるときは、メインアクターに移動します。
         しかし、それが終わるとすぐに、再び「並行処理の海」に入り、logsプロパティにアクセスする必要が出てきて、ParallelCompressorアクタに移ります。
         しかし、ここでも、それが終わるとすぐに、スレッドプールで実行されるために再びActorを離れます。
         しかし、もちろん、圧縮作業を行うタスクは1つだけでなく、たくさんあります。
         しかもActorに縛られないので、スレッドの数だけ同時実行が可能です。
        もちろん、各Actorは一度に1つのタスクしか実行できませんが、ほとんどの場合、タスクはActor上にある必要はありません。
         マイクが説明したように、これにより圧縮タスクが並列に実行され、利用可能なすべてのCPUコアを利用できるようになります。
         では、この変更を行ってみましょう。
        compressFile関数をnonisolatedとマークすることができます。
        この場合、いくつかのコンパイラーエラーが発生します。
         非分離型とマークすることで、私たちは Swift コンパイラに、この Actor の共有状態にアクセスする必要がないことを伝えました。
         しかし、それは完全に正しいわけではありません。
         このログ関数は Actor-isolated で、共有されたミュータブル状態にアクセスする必要があります。
         これを解決するためには、この関数を非同期にし、awaitキーワードでログを呼び出すことをすべてマークする必要があります。
        次に、タスクの作成を更新して、デタッチドタスクを作成する必要があります。
        これは、タスクが、作成されたActor-contextを継承しないようにするためです。
         デタッチドタスクの場合、明示的に self をキャプチャする必要があります。
        もう一度、アプリケーションをテストしてみましょう。
        このアプリは、すべてのファイルを同時に圧縮することができ、UI は応答性を維持しています。
         改良を確認するために、Swift のアクターインストルメントをチェックすることができます。
         ParallelCompressor Actor を見ると、Actor 上で実行される作業のほとんどは短時間だけで、キューのサイズが手に負えなくなることはありません。
         要約すると、UIハングの原因を特定するためにInstrumentを使用し、並行処理を改善するために並行処理コードを再構築し、データを使用してパフォーマンスの改善を確認しました。
         次にMikeから、パフォーマンスに関するその他の潜在的な問題について教えてもらいましょう。
         Mike：デモで見てきたこと以外にも、よくある問題が2つあります。
         まず、スレッドプールの枯渇についてです。
         スレッドプールの枯渇は、パフォーマンスを低下させ、アプリケーションをデッドロックさせることさえあります。
         Swift の並行処理では、タスクが実行されているときに前進することが必要です。
         タスクが何かを待つとき、それは通常、中断することによって行われます。
         しかし、タスク内のコードが、ファイルやネットワークIOをブロックしたり、ロックを取得したりといったブロッキングコールを、サスペンドせずに実行することは可能です。
         この場合、タスクが前進するための要件が破られます。
         この場合、タスクは実行中のスレッドを占有し続けますが、実際にはCPUコアを使用していないことになります。
         スレッドのプールは限られており、そのうちのいくつかはブロックされているため、並行処理ランタイムはすべてのCPUコアを完全に使用することができません。
         このため、実行可能な並列計算の量が減り、アプリの最大性能が低下します。
         極端な話、スレッドプール全体がブロックされたタスクによって占拠され、それらがスレッドプールで新しいタスクの実行を必要とする何かを待っている場合、同時実行ランタイムはデッドロックに陥る可能性があります。
         タスクの中でブロッキングコールをしないように注意してください。
         ファイルおよびネットワークIOは、非同期APIを使用して実行する必要があります。
         条件変数やセマフォでの待ち受けは避けること。
         必要であれば、きめ細かく短時間保持するロックも許容されますが、競合が多いロックや長時間保持されるロックは避けてください。
         このようなことをする必要があるコードがある場合は、そのコードを同時実行スレッドプールの外（たとえばDispatchキューで実行する）に移動し、連続性を使って同時実行の世界に橋渡ししてください。
         可能な限り、ブロック操作には非同期APIを使用して、システムを円滑に動作させる。
         継続を使用するときは、正しく使用するように注意する必要があります。
         継続は Swift の並行処理と他の形式の非同期コードの間の橋渡しです。
         継続は、現在のタスクを一時停止し、呼び出されたときにタスクを再開するコールバックを提供します。
         これはコールバックベースの非同期APIで使用することができます。
         Swiftの並行処理の観点から、タスクは一時停止し、継続が再開されたときに再開されます。
         コールバックベースの非同期APIの観点からは、作業が始まり、作業が完了したときにコールバックが呼び出されます。
         Swift Concurrency instrument は継続について知っており、タスクが呼び出される継続を待っていたことを示すために、それに応じて時間間隔をマークします。
         継続コールバックには特別な要件があります: それは正確に一度だけ呼び出されなければならず、それ以上でも以下でもありません。
         これはコールバックベースのAPIでは一般的な要件ですが、非公式なものになりがちで、言語によって強制されないので、見落としがよくあります。
         Swiftの並行処理では、これは難しい要件になります。
         コールバックが2回呼び出された場合、プログラムはクラッシュするか、動作不良になります。
         コールバックが決して呼び出されない場合、タスクはリークします。
         このコードでは、継続を取得するために withCheckedContinuation を使用しています。
         そして、コールバックベースのAPIを呼び出している。
         コールバックでは、継続をレジュームしています。
         これは、コールバックを一度だけ呼び出すという条件を満たしています。
         コードが複雑になると注意が必要です。
         左側では、成功したときだけ継続を再開するようにコールバックを修正しています。
         これはバグです。
         失敗すると、継続は再開されず、タスクは永久に中断されます。
         右側では、継続を2回再開しています。
         これもバグで、アプリが誤動作するかクラッシュします。
         これらのスニペットは両方とも、継続を正確に一度だけ再開するという要件に違反しています。
         継続にはcheckedとunsafeの2種類があります。
         パフォーマンスが絶対的に重要でない限り、継続には常に withCheckedContinuation API を使ってください。
         チェックされた継続は、自動的に誤用を検出し、エラーフラグを立てます。
         チェックされた継続が2回呼ばれると、継続はトラップされます。
         継続が全く呼ばれない場合、継続が破棄されるときに、継続が漏れたことを警告するメッセージがコンソールに出力されます。
         Swift Concurrency instrument は、対応するタスクが継続の状態で無期限に立ち往生していることを表示します。
         Instruments の新しい Swift Concurrency テンプレートには、まだまだ調べるべきことがたくさんあります。
         構造化された同時実行のグラフィックな視覚化、タスク作成のコールツリーの表示、Swift Concurrency ランタイムの全体像を把握するための正確なアセンブリ命令の検査が可能です。
         Swift Concurrency がボンネットの中でどのように動作するかの詳細については、昨年の「Swift Concurrency」のセッションをご覧ください。舞台裏" をご覧ください。
        " また、データレースについて詳しく知りたい方は、"Eliminate data races using Swift Concurrency "をご覧ください。
         ご視聴ありがとうございました。そして、あなたの同時実行コードのデバッグを楽しんでください。

        """
    }
}

