import Foundation

struct ImplementAppShortcutsWithAppIntents: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Implement App Shortcuts with App Intents"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6671/6671_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10170/")!
    }

    var english: String {
        """
        Hi, my name is Michael Sumner.
         I'm a software engineer working on Siri and App Intents.
         In this session, I want to talk to you about creating app shortcuts for your app, using the new App Intents framework.
         I'll start with an overview of what App Shortcuts are and how they relate to App Intents.
         Then, I'll walk through creating an app shortcut in Swift, and adding a parameter.
         Finally, I'll cover how to make your app shortcut discoverable, so users can benefit from your hard work.
         Let's get started with the App Intents framework and App Shortcuts.
         People use shortcuts to create multistep workflows with your apps that can be used from the Shortcuts app and from Siri.
         Until now, someone first had to set up a shortcut via an Add to Siri button or the Shortcuts app before they could use your intent.
         We're excited to introduce App Shortcuts, which require zero user setup.
         This makes it easier than ever for people to benefit from your shortcuts.
         By integrating with App Shortcuts, intents from your app will be available as soon as your app is installed.
         This makes it easy for someone to discover and use your app's functionality.
         They no longer need to head to the Shortcuts app or use an Add to Siri button to set anything up.
         App Shortcuts, like user-built shortcuts, can be run from the Shortcuts app, Spotlight, and Siri.
         This gives people multiple ways to discover and interact with your application from various places in the system.
         For example, when searching in Spotlight, your app shortcut will be displayed right in the search results for easy access.
         By implementing App Shortcuts, your users will be able to interact with your app in quick, lightweight interactions that make it easier for them to complete their task and be on their way.
         My team is working on an app -- Meditation -- that helps users meditate by guiding them through a set of audio prompts and sounds to help them focus on what matters.
         Today, to start a meditation, users have to launch the app, log in, and find the meditation session that they want to run.
         By integrating with App Shortcuts, my users can quickly access these features from anywhere just by asking Siri.
         And by making it faster to start a session, users can integrate meditation into their daily routine, either in the morning before work or in the evening to help wind down after a long day.
         Alright, let's dive right in to the code needed to create an App Intent and turn it into an app shortcut.
         Unlike previous shortcuts, App Shortcuts are built with the new App Intents framework.
         App Intents is a new, Swift-only framework built from the ground up to make it faster and easier to build great intents.
         With App Intents, everything is defined right in your Swift source code, instead of a separate metadata file.
         This removes any code generation steps and allows you to stay focused without switching contexts between the source editor and the metadata editor.
         They're also easier to code review and solve merge conflicts.
         To build App Shortcuts, you'll need to write an AppShortcutsProvider that lists the phrases and other metadata needed to turn your App Intent into a full-fledged shortcut.
         And note that because these are set up without any user interaction, you'll need to include your application's name in the trigger phrase.
         Intents are defined as Swift structs, that implement the AppIntent protocol.
         A basic intent has just two requirements -- a title, which is used to display your intent in the Shortcuts app, and a method called perform.
         The perform method is where you run your intent's logic and return a result.
         Additionally, you can trigger prompts for the user and await their response.
         In this intent, I'll start the default meditation session using my app's MeditationService.
         Because the perform method is async, I can run asynchronous code to start my session.
         Once the session has started, I'll return a dialog that is shown to the user.
         And if your app is localized, you'll want to localize this string in all of your locales.
         So far, with what I've built, the StartMeditationIntent will appear in the Shortcuts app when authoring a shortcut.
         A motivated user can take this intent and create a shortcut that will kick off a session.
         In this shortcut, I've also added a second intent to enable a Focus.
         By default, my App Intent is rendered using the title I specified in my source code.
         To customize the rendering for your action, be sure to add a parameter summary to your App Intent.
         Parameter summaries allow you to customize the look of your intent, as well as show values inline.
         However, this intent works great as a shortcut all by itself.
         Ideally, someone would be able to run my intent without first having to author a shortcut at all.
         By creating an app shortcut, I can perform this setup step on behalf of the user, so they can start using my intent as soon as the app is installed.
         Now that I've written an intent, I'll create an app shortcut for it.
         Similar to an intent, App Shortcuts are defined in Swift code, by implementing the AppShortcutsProvider protocol.
         To implement the protocol, I'll simply create a single getter that returns all the app shortcuts I want to set up for the user.
         Note that in total, your app can have a maximum of 10 app shortcuts.
         However, most apps only need a few.
         So I'll create a single AppShortcut for my StartMeditationIntent.
         To get started, I'll pass an instance of my intent.
         If my intent's initializer took parameters, I could specify values here.
         Second, I'll create an array of spoken phrases that will invoke my AppShortcut from Siri.
         You'll notice that rather than writing my application's name directly in the string, I used a special .
        applicationName token.
         This allows Siri to insert not only my application's main name, but also any app name synonyms that I've configured.
         Because users may say different phrases to start meditation, I'll provide a few more alternative phrases here.
         If your app is localized, you'll need to localize these phrases as well.
        Great.
         So now when someone wants to mediate, they just stay to Siri, "Start a meditation.
        " Siri will call the StartMeditationIntent and speak the dialog that I returned.
         Also, if someone searches for my app in Spotlight, they'll see the first App Shortcut I've listed in my code.
         When the user taps the result, the shortcut will immediately run without launching the application.
         It's important to note that if your intent does trigger an app launch, it won't be shown in Spotlight.
         So, with just a very small amount of code, I've now made it much, much simpler for my users to meditate with my app.
         But right now, Siri shows a default view whenever running my intent.
         This is OK, but I'd really like to show the user more information when they run my app shortcut.
         To do this, I'll need to implement a custom view that Siri can show whenever my intent is run.
         Views in the App Intents framework are built using SwiftUI and leverage the same view technology as widgets.
         This means you, as a developer, don't need to build a separate UI extension for your custom view.
         Instead, you can simply return the view when running your intent.
         It's important to think about the specific constraints this brings for your views.
         Just like widgets, custom App Intent views can't include things like interactivity or animations.
         Make sure to take this into account when designing your UI.
         App Intents supports showing custom UI at three phases: value confirmation, intent confirmation, and after the intent is finished.
         For my app, I'm going to return a custom view at the end of running my intent.
         If you're using these other prompts, be sure to think about how you can integrate custom UI at those steps too.
         Finally, as I mentioned, displaying custom UI is easy.
         You simply need to return your view from your intent.
         Alright, time to jump into some code.
         Adding a custom view is easy.
         As I mentioned, I'll just return the view alongside my dialog.
         The App Intents framework will take care of presenting my view inside the Siri snippet.
         Keep in mind that your views are going to be shown alongside other Siri views, like the snippet title or confirmation buttons.
         So you'll want your snippet's design to feel at home inside of Siri.
         Up next, let's check out how I can extend an app shortcut to include parameters.
         In my previous implementation, I chose to start the default meditation session.
         But my app includes many great session types, and users will want to start a particular session they have in mind.
         Ideally, my user would be able to specify the session they want to start when running my intent.
         To support these use cases, I'll need to extend my intent by adding a parameter that captures the session the user wants to run.
         To add a parameter, I first need to define the parameter's type.
         I'll create a MeditationSession struct that has the relevant information for a session.
         I'll include a name, and I'll give it an identifier field, which can be a UUID.
         To use this struct as a parameter for my intent, I also need to implement the AppEntity protocol.
         Implementing the AppEntity protocol tells the App Intents framework about my type and lets me specify additional information, like how the entity is displayed.
         The entity protocol requires that my type has an identifier, which I've already provided.
         I could use other types as well, like integers or strings.
         I also need to provide some information on how to display my entity.
         This will be used in the Shortcuts app and other places where my entity is shown.
         Finally, I need to wire up a default query.
         I'll call my query the MeditationSessionQuery, and I'll implement it next.
         In order to work with my entity, the App Intents framework needs to be able to look up my entities based on their identifier.
         To make this possible, the EntityQuery protocol defines just one requirement: a function that takes identifiers and returns matching entities.
         I'll implement this function by looking up the sessions in my SessionManager.
         Next, I'll update my StartMeditationIntent to add a parameter.
         Parameters are straightforward; they are just a normal property on my struct.
         But to tell App Intents about my parameter, I also need to add the @Parameter property wrapper.
         This property wrapper lets App Intents know that the session property is part of my intent.
         I can also specify additional metadata in the Parameter property wrapper, like the display name.
         Now that I've added a parameter to my intent, I need to ask the user which session they'd like to run.
         The App Intents framework has robust support for asking users follow-up questions to gather values for my intent's parameters.
         These prompts will be displayed anywhere my intent is run.
         When run from Siri, Siri will speak out the questions, and ask the user to speak the answer.
         In Spotlight and the Shortcuts app, the user will be presented with the same prompt in a touch-driven UI.
         App Intents supports three types of value prompts.
         Disambiguations asks the user to select from a fixed list.
         Disambiguations are great to present the user when you have small fixed set of options for a parameter in your intent.
         Value prompts allow you to ask the user for an open-ended value.
         These are great for types like strings or integers, which can take any value.
         Finally, confirmation asks the user to verify a particular value and can be helpful if you want to double-check with the user that you understand their intent.
         Prompting for values is a great way to make intents more flexible and allows you to gather more information from the user.
         But they also slow down the conversation, and can frustrate users if you use them too often.
         For more insight into designing great intents, check out the session titled "Design App Shortcuts" from Lynn.
         All right, now that I've added the session parameter to the StartMeditationIntent, I'll go ahead and add logic to my perform method to prompt for this value.
         In my app, I have a small fixed number of sessions the user can run.
         If the session isn't already specified, I'll retrieve the list from my SessionManager and present a disambiguation to the user.
         Using the display representation for each of my sessions, App Intents will format sessions into list items and display them to the user.
         When the user picks one, the selected item will be returned to me.
         I'll pass the selected session to my MeditationService, which will start the session.
         I can then return a dialog to let the user know that the intent has started.
         Since the user provided a session, it's a good idea to put the name of the session in the dialog so the user knows we understood their request.
         Great, so now when my users say, "Start a Meditation," my app can prompt the user for the particular session they want to run.
         However, as I mentioned before, users prefer Siri interactions that are quick and to the point.
         Ideally, I'd be able to let my users tell Siri the session they'd like to run in the initial phrase, rather than in a follow-up question.
         Well, I have good news.
         App Shortcuts has support for extending trigger phrases with predefined parameters.
         By implementing parameterized phrases, my app can support utterances like "Start a calming meditation" or "Start a walking meditation.
        " Parameters are great when you have a fixed set of well-known parameter values that you can specify to Siri ahead of time.
         For my app, I'll use my session names.
         Parameters are not meant for open-ended values.
         For example, it's not possible to gather an arbitrary string from the user in the initial utterance.
         So, my app couldn't support a phrase like "Search my diary for X," where X could be any input from the user.
         Instead, parameter values are specified ahead of time, when your app is running.
         Let's implement some parameterized phrases.
         To implement parameterized phrases in my app, I need to make a few changes.
         First, I'll update the query for my SessionEntity to implement the suggestedResults() method to return the list of entities for my parameterized shortcut.
         Second, I'll need to notify the App Intents framework when the list of available SessionEntities has changed.
         This allows the App Intents framework to create new shortcut phrases for use in Siri.
         I'll do this by updating my app's model layer to notify the App Intents framework whenever my session list changes.
         Finally, I'll add some new phrases to my App Shortcut that reference the session parameter on my StartMeditationIntent.
         So first, I'll update the MeditationSessionQuery by implementing the suggestedEntities function.
         The App Intents framework uses the sessions returned from this function to create parameterized shortcuts.
         It's important to note that while this method is optional, if I don't implement this method, I won't get any parameterized shortcuts at all.
         Second, I'll need to update my app's model layer to notify the App Intents framework whenever my list of sessions changes.
         In my app, I infrequently publish new session types that I fetch from the server in the background.
         I'll update my SessionModel to call the updateAppShortcutParameters() method any time I receive new sessions.
         This method is provided by the App Intents framework; you don't need to implement it yourself.
         When called, App Intents will invoke your entity's query to gather the list of parameters for your shortcut phrases.
         Finally, I'll add new phrases for my App Shortcut that include the session keypath on my intent.
         The App Intents framework will combine this phrase with all of the sessions returned from my query.
         The text used for each value is pulled from the title property on the SessionEntity's display representation.
         Just like before, I'll want to include a few different ways that users might phrase my App Shortcut.
         This ensures a smoother experience if the user doesn't remember your preferred phrase.
         All right, I now have a great, full-featured App Shortcut, and I can't wait for my users to give it a try.
         But in order for that to happen, I need to do some work to help users discover my new Shortcut.
         The first thing I want to talk about is picking great phrases.
         Great phrases for App Shortcuts are short and memorable.
         Users will have a lot of apps on their phone that support App Shortcuts; and in practice, users can have a hard time remembering exactly how to phrase their shortcuts.
         So where possible, keep your phrases short and to the point.
         Along these lines, if your app name can be used as a noun or verb, consider using it that way in your phrase.
         In my app, I've used Meditation like a noun, so that the phrase can be short and memorable.
         Finally, app name synonyms can help your users immensely.
         If users call your app something other than your app's display name, you'll want to consider adding an app name synonym for it.
         iOS 11 added support for app name synonyms.
         If you haven't created one, now may be a great time to do so.
         The next thing I want to talk about is the Siri Tip and the Shortcuts link.
         Because App Shortcuts don't require any user setup, discoverability is vital for users to find and use your App Shortcuts.
         With App Shortcuts, users no longer need the Add to Siri button to add your Shortcut.
         It's already added! However, we don't want to lose the discoverability benefits that the Add to Siri button provided.
         With that in mind, we've created a new Siri Tip view.
         This view works great anywhere you may have used the Add To Siri button in the past.
         The Tip view is available in both SwiftUI and UIKit.
         And we've provided a number of styles so that the Tip looks great in any application.
         Siri Tips are best placed contextually, when they're relevant to the content onscreen.
         If a user just placed an order in your app, consider showing a Tip for your Shortcut that provides the order status.
         Siri Tips should be placed thoughtfully, when you feel a user is likely to engage with your App Shortcut in the near future.
         The Siri Tip also supports dismissal.
         The view includes a dismiss button and will trigger a custom closure in your code when tapped.
         You'll want to remove the view from your layout, and consider not showing it again until you feel it's relevant.
         Finally, we've also included a new ShortcutsLink that will launch to a list of Shortcuts from your app.
         This new element is great if your app has a lot of App Shortcuts and you want to let users explore all of them.
         Now, the great thing about App Shortcuts is they're available as soon as your app is installed.
         Even before the app is first launched, users can see and run your Shortcuts from Spotlight, Siri, and the Shortcuts app.
         You may need to take this into account when building your App Shortcut.
         For example, if your app requires a log-in flow, the user may not have logged in before running your intent.
         Your intent should fail gracefully with an error message explaining to the user that they need to log in.
         Second, parameterized phrases for your App Shortcuts won't be available until your app has been launched and notified the App Intents framework that you have new parameter values.
         If your App Shortcut doesn't contain any non-parameterized phrases, the user won't see your App Shortcut at all until they first launch your app.
         You may consider adding a few non-parameterized phrases to avoid this issue.
         Additionally, Siri has added support for phrases like, "What can I do here?" and "What can I do with Meditation?" Siri will automatically gather and recommend any App Shortcut phrases and present them on your behalf.
         Your app doesn't need to do anything additional for this functionality to work.
         Finally, in both Siri and the Shortcuts app, the order your App Shortcuts are displayed is determined by the order that you list your App Shortcuts in your source code.
         You'll want to consider putting your best and most useful App Shortcuts first, so that they get the most attention.
         Similarly, the first phrase you list in the phrase array will be considered the primary phrase for that App Shortcut.
         The primary phrase is used as the label on the Shortcut tile, and it's shown when the user asks Siri for help with your app.
         OK, we covered a lot about App Intents framework and App Shortcuts.
         I want to leave you with two key thoughts.
         First, App Shortcuts make it easy for users to use your app from anywhere in the system, so think about the best use cases in your app that fit this more lightweight model.
         Second, once you've implemented an App Shortcut, users will not know about it unless you tell them! Think hard about how to make your App Shortcut discoverable.
         Consider places in your app where you can show the Siri Tip, as well as off-product locations, like a website or a sign in your store.
         We can't wait to see all the great App Shortcuts that you create with the new App Intents framework.
         To dig deeper into design, as well as the App Intents framework, be sure to check out other talks this week.
         Thanks, and have a great WWDC.
        """
    }

    var japanese: String {
        """
        こんにちは、マイケル・サムナーです。
         SiriとApp Intentsに取り組んでいるソフトウェアエンジニアです。
         このセッションでは、新しいApp Intentsフレームワークを使って、あなたのアプリにアプリショートカットを作ることについてお話したいと思います。
         まず、App Shortcutsとは何か、そしてApp Intentsとどのような関係があるのかについて概要を説明します。
         そして、Swift でアプリショートカットを作成し、パラメータを追加する方法を説明します。
         最後に、アプリショートカットを発見可能にする方法を説明し、ユーザーがあなたのハードワークから利益を得ることができるようにします。
         App Intents フレームワークとアプリショートカットから始めましょう。
         ショートカットは、ショートカットアプリやSiriから利用できる、アプリによるマルチステップワークフローを作成するために使用されます。
         これまでは、インテントを使用する前に、Siriに追加ボタンまたはショートカットアプリケーションでショートカットを設定する必要がありました。
         今回ご紹介するアプリショートカットは、ユーザーによる設定を一切必要としません。
         これにより、あなたのショートカットを利用する人が、これまで以上に簡単になります。
         App Shortcutsと統合することで、あなたのアプリのインテントが、あなたのアプリがインストールされるとすぐに利用できるようになります。
         これにより、アプリの機能を発見して使用することが容易になります。
         ユーザーは、Shortcutsアプリケーションにアクセスしたり、Siriに追加ボタンを使って何かを設定したりする必要はもうありません。
         アプリのショートカットは、ユーザーが作ったショートカットと同じように、ショートカットアプリケーション、Spotlight、Siriから実行することができます。
         これによって、システムのさまざまな場所からアプリケーションを発見し、操作するための複数の方法が提供されます。
         例えば、Spotlightで検索すると、あなたのアプリケーションのショートカットが検索結果の右側に表示され、簡単にアクセスできるようになります。
         アプリショートカットを実装することで、ユーザーはアプリをすばやく軽快に操作できるようになり、タスクを完了させて帰ることが容易になります。
         私のチームは、ユーザーが重要なことに集中できるように、一連の音声プロンプトとサウンドでガイドすることによって、瞑想を支援するアプリ「Meditation」に取り組んでいます。
         現在、瞑想を始めるには、ユーザーはアプリを起動し、ログインして、実行したい瞑想セッションを見つけなければなりません。
         App Shortcutsと連携することで、ユーザーはSiriに尋ねるだけで、どこからでもこれらの機能に素早くアクセスできるようになります。
         また、瞑想の開始時間を短縮することで、朝の出勤前や夜の疲れを癒すなど、毎日の生活に瞑想を取り入れることができるようになりました。
         さて、App Intentを作成し、それをアプリのショートカットにするために必要なコードに、さっそく飛び込んでみましょう。
         以前のショートカットとは異なり、アプリショートカットは新しい App Intents フレームワークで構築されています。
         App Intents は、優れたインテントをより速く簡単に構築するために、ゼロから構築された Swift 専用の新しいフレームワークです。
         App Intents では、すべてが、個別のメタデータファイルではなく、Swift ソースコードで直接定義されます。
         これにより、コード生成の手順がなくなり、ソースエディタとメタデータエディタの間でコンテキストを切り替えることなく、集中力を維持することができます。
         また、コードレビューやマージコンフリクトの解決もより簡単になります。
         App Shortcuts を構築するには、App Intent を本格的なショートカットにするために必要なフレーズやその他のメタデータをリストアップする AppShortcutsProvider を書く必要があります。
         そして、これらはユーザーの操作なしで設定されるため、トリガーフレーズにアプリケーションの名前を含める必要があることに注意してください。
         インテントは、AppIntent プロトコルを実装した Swift の構造体として定義されています。
         基本的なインテントには、2つの要件があります - Shortcuts アプリでインテントを表示するために使用されるタイトルと、perform と呼ばれるメソッドです。
         perform メソッドは、インテントのロジックを実行し、結果を返す場所です。
         さらに、ユーザーに対してプロンプトを表示し、その応答を待つこともできます。
         今回のインテントでは、アプリのMeditationServiceを使って、デフォルトの瞑想セッションを開始します。
         performメソッドは非同期なので、非同期コードを実行してセッションを開始することができます。
         セッションが開始されたら、ユーザーに表示されるダイアログを返します。
         そして、もしあなたのアプリがローカライズされているなら、この文字列をすべてのロケールにローカライズしたいと思うでしょう。
         ここまでで、私が作ったものでは、StartMeditationIntentは、ショートカットアプリでショートカットを作成する際に表示されます。
         やる気のあるユーザーは、このインテントを使用して、セッションを開始するショートカットを作成することができます。
         このショートカットでは、フォーカスを有効にするための2つ目のインテントも追加しています。
         デフォルトでは、App Intent は、ソースコードで指定したタイトルを使用してレンダリングされます。
         アクションのレンダリングをカスタマイズするには、App Intent にパラメータ サマリーを追加してください。
         パラメータ・サマリーを使用すると、インラインで値を表示するだけでなく、インテントの外観をカスタマイズすることができます。
         しかし、このインテントは、それ自体でショートカットとして素晴らしい働きをします。
         理想は、誰かが最初にショートカットをまったく作成することなく、私のインテントを実行できるようにすることです。
         アプリのショートカットを作成することで、ユーザーに代わってこの設定ステップを実行し、アプリがインストールされるとすぐに私のインテントを使い始めることができます。
        インテントを書いたので、そのためのアプリショートカットを作成します。
        インテントと同様に、アプリショートカットは、AppShortcutsProvider プロトコルを実装することで、Swift コードで定義されます。
        プロトコルを実装するために、私は単純に、ユーザーのために設定したいすべてのアプリショートカットを返す単一のゲッターを作成します。
        なお、アプリは合計で最大10個のアプリショートカットを持つことができます。
        しかし、ほとんどのアプリは数個しか必要としません。
        そこで、StartMeditationIntentに1つのAppShortcutを作成することにします。
        まず、自分のインテントのインスタンスを渡します。
        もし、インテントのイニシャライザーにパラメータがあれば、ここで値を指定することができます。
        次に、SiriからAppShortcutを呼び出すための音声フレーズの配列を作成します。
        アプリケーションの名前を直接文字列に書くのではなく、特別な.applicationNameトークンを使っていることにお気づきでしょうか。
        applicationNameトークンを使用しています。
        これにより、Siriは、アプリケーションのメインネームだけでなく、設定したアプリケーション名の同義語も挿入できるようになります。
        ユーザーは、瞑想を始めるためにさまざまなフレーズを言うかもしれないので、ここではさらにいくつかの代替フレーズを提供することにします。
        あなたのアプリがローカライズされている場合は、これらのフレーズもローカライズする必要があります。
        なるほど。
        これで、瞑想をしたい人はSiriに「瞑想を始めてください」と言うだけでいいんですね。
        " SiriはStartMeditationIntentを呼び出して、私が返したダイアログを話します。
        また、誰かがSpotlightで私のアプリを検索すると、私のコードに記載した最初のApp Shortcutが表示されます。
        ユーザーがその結果をタップすると、アプリケーションを起動することなく、すぐにショートカットが実行されます。
        注意すべきは、もしあなたの意図がアプリの起動を引き起こしたとしても、Spotlightには表示されないということです。
        このように、ほんの少しのコードで、ユーザーが私のアプリで瞑想することを、とてもとても簡単にできるようになりました。
        しかし、現在、Siriは、私のインテントを実行するたびに、デフォルトのビューを表示します。
        これはこれでいいのですが、アプリのショートカットを実行したときに、ユーザーにもっと情報を表示させたいと思います。
        そのためには、カスタムビューを実装して、インテントを実行したときにSiriが表示できるようにする必要があります。
        App Intents フレームワークのビューは SwiftUI を使って構築され、ウィジェットと同じビューテクノロジーを利用します。
        これは、開発者として、カスタムビューのために個別の UI 拡張を構築する必要がないことを意味します。
        代わりに、インテントを実行するときに、単にビューを返すことができます。
        これがビューにもたらす特定の制約について考えることは、重要です。
        ウィジェットのように、カスタムApp Intentビューは、インタラクティブ性やアニメーションのようなものを含むことができません。
        UIを設計するときは、このことを考慮に入れてください。
        App Intents は、値の確認、インテントの確認、インテント終了後の3つのフェーズでカスタム UI を表示することをサポートしています。
        今回のアプリでは、インテントの実行終了時にカスタムビューを返します。
        これらの他のプロンプトを使用している場合は、それらの段階でもカスタムUIを統合する方法を考えておいてください。
        最後に、先ほど述べたように、カスタムUIを表示するのは簡単です。
        インテントからビューを返せばいいだけです。
        さて、そろそろコードに飛び込む時間です。
        カスタムビューを追加するのは簡単です。
        先ほど述べたように、ダイアログと一緒にビューを返すだけです。
        ビューをSiriのスニペットの中に表示するのは、App Intentsフレームワークが担当します。
        ビューは、スニペットのタイトルや確認ボタンなど、他のSiriのビューと一緒に表示されることに注意してください。
        そのため、Siriの中で違和感のないスニペットのデザインが必要です。
        次に、アプリのショートカットを拡張して、パラメータを含める方法を確認します。
        前回の実装では、デフォルトの瞑想セッションを開始することを選択しました。
        しかし、私のアプリには多くの素晴らしいセッションの種類があり、ユーザーは自分の思い描く特定のセッションを始めたいと思うでしょう。
        理想的には、私のインテントを実行するときに、ユーザーが開始したいセッションを指定できるようにすることです。
        このようなユースケースをサポートするには、インテントを拡張して、ユーザーが実行したいセッションをキャプチャするパラメータを追加する必要があります。
        パラメータを追加するには、まず、パラメータのタイプを定義する必要があります。
        セッションの関連情報を持つ MeditationSession 構造体を作成します。
        名前と、識別子フィールド（UUID）を指定します。
        この構造体をインテントのパラメータとして使用するには、AppEntityプロトコルを実装する必要があります。
        AppEntity プロトコルを実装すると、App Intents フレームワークに私のタイプを伝え、エンティティの表示方法などの追加情報を指定できるようになります。
        エンティティプロトコルは、私の型が識別子を持つことを要求します。
        整数や文字列など、他の型も使うことができる。
        さらに、エンティティの表示方法に関する情報も提供する必要がある。
        これは、Shortcutsアプリなど、私のエンティティを表示する場所で使用されます。
        最後に、デフォルトのクエリを作成します。
        このクエリをMeditationSessionQueryと呼び、次にこれを実装します。
        私の実体を扱うために、App Intentsフレームワークは、その識別子に基づいて私の実体を検索することができる必要があります。
         これを可能にするために、EntityQueryプロトコルは、識別子を受け取り、一致するエンティティを返す関数という、たった一つの要件を定義しています。
         この関数を実装するには、SessionManagerでセッションを検索します。
         次に、StartMeditationIntentを更新して、パラメータを追加します。
         パラメータは簡単で、構造体の通常のプロパティになります。
         しかし、App Intentsにパラメータを伝えるために、@Parameterプロパティラッパーを追加する必要があります。
         このプロパティラッパーは、セッションプロパティが私のインテントの一部であることをApp Intentsに知らせます。
         また、Parameter プロパティラッパーには、表示名などの追加のメタデータを指定することもできます。
         インテントにパラメータを追加したので、どのセッションを実行したいか、ユーザーに尋ねる必要があります。
         App Intentsフレームワークは、インテントのパラメータ値を収集するために、ユーザーにフォローアップの質問をするための強力なサポートを持っています。
         これらのプロンプトは、私のインテントが実行される場所に表示されます。
         Siriから実行する場合は、Siriが質問を読み上げ、その答えをユーザーに尋ねます。
         Spotlightとショートカットアプリでは、同じプロンプトがタッチ操作のUIで表示されます。
         App Intentsは、3種類の値のプロンプトをサポートしています。
         Disambiguationsは、固定されたリストから選択するようユーザーに要求します。
         Disambiguationsは、インテントのパラメータに少数の固定オプションがある場合に、ユーザーに提示するのに適しています。
         値のプロンプトでは、ユーザーに自由形式の値を要求することができます。
         これは、文字列や整数のように、任意の値を取ることができる型に最適です。
         最後に、確認では、特定の値を確認するようユーザーに求めます。これは、ユーザーの意図を理解しているかどうかをユーザーに再確認する場合に役立ちます。
         値を求めるプロンプトは、インテントをより柔軟にし、ユーザーからより多くの情報を収集できるようにする素晴らしい方法です。
         しかし、あまりに頻繁に使用すると、会話のスピードが遅くなり、ユーザーをイライラさせる可能性もあります。
         優れたインテントの設計に関するより深い洞察については、Lynnによる「Design App Shortcuts」と題されたセッションをチェックしてみてください。
         さて、StartMeditationIntentにsessionパラメータを追加したので、この値を要求するロジックをperformメソッドに追加していきます。
         私のアプリでは、ユーザーが実行できるセッションの数は少量に限定しています。
         セッションがまだ指定されていない場合は、SessionManagerからリストを取得し、ユーザーに曖昧さを解消するように提示します。
         各セッションの表示表現を使用して、App Intentsはセッションをリスト項目にフォーマットして、ユーザーに表示します。
         ユーザーが1つを選ぶと、選択された項目が私に返されます。
         選択されたセッションをMeditationServiceに渡すと、MeditationServiceがセッションを開始します。
         そして、インテントが開始されたことをユーザーに知らせるために、ダイアログを返します。
         ユーザーがセッションを提供したので、ダイアログにセッションの名前を入れておくと、ユーザーは私たちが彼らの要求を理解したことを知ることができます。
         これで、ユーザーが「Start a Meditation」と言ったときに、アプリがユーザーに実行したい特定のセッションを求めることができるようになりましたね。
         しかし、先ほども述べたように、ユーザーはSiriとの対話は素早く、要点がまとまっているものを好みます。
         理想を言えば、次の質問ではなく、最初のフレーズで実行したいセッションをSiriに伝えられるようにしたいですね。
         そこで、いいお知らせがあります。
         App Shortcutsは、あらかじめ定義されたパラメータでトリガーフレーズを拡張することをサポートしています。
         パラメータ化されたフレーズを実装することで、"Start a calming meditation" や "Start a walking meditation" といった発話をサポートすることができるようになりました。
        " パラメータは、よく知られたパラメータをあらかじめSiriに指定しておくと、とても便利です。
         私のアプリでは、セッション名を使っています。
         パラメータは、自由な値を指定するためのものではありません。
         例えば、最初の発話でユーザーから任意の文字列を集めることはできません。
         つまり、私のアプリは、「私の日記をXで検索してください」というようなフレーズに対応することができず、Xはユーザーからの任意の入力になります。
         Xはユーザーからの任意の入力です。その代わりに、アプリの実行時にパラメータ値を事前に指定します。
         それでは、パラメタライズド・フレーズを実装してみましょう。
         このアプリにパラメタライズド・フレーズを実装するには、いくつかの変更を加える必要があります。
         まず、SessionEntity のクエリを更新して suggestedResults() メソッドを実装し、パラメータ化されたショートカットのエンティティリストを返します。
         次に、利用可能なSessionEntitiesのリストが変更されたときに、App Intentsフレームワークに通知する必要があります。
         これにより、App Intentsフレームワークは、Siriで使用する新しいショートカットフレーズを作成することができます。
         アプリのモデルレイヤーを更新して、セッションリストが変更されるたびにApp Intentsフレームワークに通知することでこれを実現します。
         最後に、StartMeditationIntentのセッションパラメータを参照する新しいフレーズを、アプリのショートカットに追加します。
         まず、MeditationSessionQueryを更新して、suggestedEntities関数を実装します。
         App Intentsフレームワークは、この関数から返されたセッションを使用して、パラメータ化されたショートカットを作成します。
         このメソッドはオプションですが、このメソッドを実装しない場合、パラメータ化されたショートカットを全く取得できないことに注意してください。
         次に、セッションのリストが変更されたときに App Intents フレームワークに通知するために、アプリのモデルレイヤーを更新する必要があります。
         私のアプリでは、バックグラウンドでサーバから取得した新しいセッションタイプを頻繁に発行しています。
         私は、新しいセッションを受信するたびに updateAppShortcutParameters() メソッドを呼び出すために、SessionModel を更新します。
         このメソッドは、App Intentsフレームワークによって提供されます。
         呼び出されると、App Intentsはエンティティのクエリを呼び出して、ショートカット・フレーズのパラメータ・リストを収集します。
         最後に、自分のインテントにセッションキーパスを含むApp Shortcut用の新しいフレーズを追加します。
         App Intentsフレームワークは、このフレーズと、私のクエリから返されたすべてのセッションを組み合わせます。
         各値に使用されるテキストは、SessionEntity の表示表現の title プロパティから取得されます。
         前と同じように、私はユーザーが私のApp Shortcutを表現する可能性のあるいくつかの異なる方法を含めることにします。
         これにより、ユーザーがあなたの好みのフレーズを覚えていない場合、よりスムーズなエクスペリエンスが保証されます。
         さて、これで素晴らしいフル機能のApp Shortcutが完成し、ユーザーに試してもらうのが待ち遠しくなりました。
         しかし、そのためには、ユーザーに新しいShortcutを発見してもらうために、いくつかの作業を行う必要があります。
         最初にお話ししたいのは、優れたフレーズを選ぶことです。
         アプリのショートカットに最適なフレーズは、短くて覚えやすいものです。
         ユーザーは、アプリショートカットに対応した多くのアプリを携帯電話に入れており、実際には、ユーザーはショートカットのフレーズを正確に覚えておくことが難しい場合があります。
         そのため、可能な限り、フレーズは短く、要点を押さえてください。
         また、アプリ名が名詞または動詞として使用できる場合は、そのようにフレーズで使用することを検討してください。
         私のアプリでは、Meditationを名詞のように使うことで、フレーズを短く、印象的にすることができます。
         最後に、アプリ名の同義語は、ユーザーにとって非常に便利です。
         ユーザーがアプリの表示名以外のものを呼ぶ場合は、アプリ名の同義語を追加することを検討するとよいでしょう。
         iOS 11では、アプリ名シノニムのサポートが追加されました。
         まだ作成されていない場合は、今が作成する絶好の機会です。
         次に、Siri TipとShortcutsのリンクについてです。
         App Shortcutsは、ユーザーの設定を必要としないため、ユーザーがApp Shortcutsを見つけて使用するためには、発見力が重要です。
         App Shortcutsを使うと、ユーザーは、Siriに追加ボタンを押す必要がなくなります。
         すでに追加されているのです。しかし、Siriに追加ボタンが提供していた発見しやすい利点は失いたくありません。
         そこで、新しいSiri Tipビューを作成しました。
         このビューは、過去にAdd To Siriボタンを使用したことがある場所であれば、どこでも使用できます。
         TipビューはSwiftUIとUIKitの両方で利用できます。
         また、ヒントがどのアプリケーションでも美しく見えるように、いくつかのスタイルを用意しています。
         Siriのヒントは、画面上のコンテンツに関連するとき、文脈的に配置するのが最適です。
         例えば、ユーザーがあなたのアプリケーションで注文したばかりの場合、注文状況を示すショートカットのヒントを表示することを検討してください。
         Siriチップは、ユーザーが近い将来にアプリのショートカットにアクセスする可能性が高いと思われるときに、慎重に配置する必要があります。
         Siri Tipは、削除にも対応しています。
         ビューには解散ボタンがあり、タップされると、コード内のカスタムクロージャーがトリガーされます。
         レイアウトからビューを削除し、関連性があると感じるまで、再び表示しないことを検討してください。
         最後に、アプリからショートカットのリストを起動する新しいShortcutsLinkも含まれています。
         この新しい要素は、アプリにたくさんのアプリショートカットがあり、ユーザーにすべてのショートカットを探させたい場合に便利です。
         App Shortcutsの素晴らしいところは、アプリがインストールされるとすぐに利用できることです。
         アプリを最初に起動する前でも、ユーザーはSpotlight、Siri、およびショートカットアプリからショートカットを確認し、実行することができます。
         アプリのショートカットを作成する際に、このことを考慮する必要があるかもしれません。
         たとえば、アプリにログインフローが必要な場合、ユーザーはインテントを実行する前にログインしていない可能性があります。
         この場合、ログインが必要であることをユーザーに説明するエラーメッセージとともに、インテントが優雅に失敗する必要があります。
         次に、App Shortcuts のパラメータ化されたフレーズは、アプリが起動され、新しいパラメータ値を持っていることを App Intents フレームワークに通知するまで、利用することができません。
         App Shortcutにパラメータ化されていないフレーズが含まれていない場合、ユーザーは、アプリを最初に起動するまで、App Shortcutを全く見ることができません。
         この問題を回避するために、いくつかの非パラメーター化フレーズを追加することを検討してください。
         さらに、Siriは、"What can I do here?" や "What can I do with Meditation?" などのフレーズをサポートするようになりました。Siriは、あなたに代わって、App Shortcutのフレーズを自動的に収集し、おすすめします。
         この機能を動作させるために、アプリが追加で何かを行う必要はありません。
         最後に、SiriとShortcutsアプリケーションの両方で、App Shortcutsの表示順は、ソースコードにApp Shortcutsをリストした順番で決まります。
         最も優れた、最も便利なApp Shortcutsを最初に配置し、最も注目されるようにすることを検討してください。
         同様に、フレーズ配列にリストされた最初のフレーズは、その App Shortcut の主フレーズとみなされます。
         プライマリーフレーズはショートカットタイルのラベルとして使用され、ユーザーがSiriにアプリのヘルプを求めるときに表示されます。
         さて、App IntentsフレームワークとApp Shortcutsについて多くを学びました。
         ここで、2つの重要な考えを残しておきたいと思います。
         まず、App Shortcutsは、ユーザーがシステム内のどこからでもアプリを簡単に使用できるようにします。したがって、このより軽量なモデルに適合するアプリの最適な使用例を考えてください。
         第二に、アプリショートカットを一度実装すると、あなたが伝えない限り、ユーザーはそれを知ることができません！アプリショートカットを実装する方法をよく考えてください。どうすればApp Shortcutを発見してもらえるか、よく考えてみてください。
         Siriチップを表示する場所は、アプリの中だけでなく、ウェブサイトやお店の看板など、製品以外の場所も考えてみてください。
         新しいApp Intentsフレームワークを使用して作成された素晴らしいApp Shortcutsを見るのが楽しみです。
         デザインとApp Intentsフレームワークについてより深く知りたい方は、今週の他の講演をぜひご覧ください。
         ありがとうございました、そして素晴らしいWWDCを
        """
    }
}

