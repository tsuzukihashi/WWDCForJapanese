import Foundation

struct MeetFocusFilters: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Meet Focus filters"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6617/6617_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10121/")!
    }

    var english: String {
        """
        Hello, I am Teja, an engineer on the iOS System Experience team, and in this session, you'll get to meet Focus filters.
         Focus was introduced in iOS 15, macOS Monterey and watchOS 8.
         It is a way for people to concentrate on what's important by configuring system behavior for a period of time.
         Focus is enabled by simply going into Control Center and selecting from either a system Focus or a custom Focus.
         During the time that a Focus is enabled, notification behavior can be customized.
         For example, during Work Focus, someone may want to only allow notifications from their coworkers or only allow notifications for a select few apps that are relevant to work.
         For each Focus, system behavior can be configured and scheduled in Settings.
         iOS 16 and macOS Ventura enhance the Focus feature with Focus filters.
         I'll start by introducing you to Focus filters and how they behave.
         Then, I'll go over how to define a Focus filter in your app.
         After that, I'll cover what it means to act on a Focus filter.
         And finally, I'll cover how your app can provide additional context back to the system.
         Focus filters are a way for someone to customize app behavior based on the currently enabled Focus.
         There are some great examples of system apps that have adopted Focus filters.
         The Calendar app allows people to filter which calendars should be visible by default when a Focus is enabled.
         This is what my calendar normally looks like.
         And as you can see, I have a mix of work and personal calendar events.
         I can configure a Focus filter for Calendar, during the Personal Focus, to only show my personal calendar.
         After setting up the Focus filter, this is what my calendar looks like.
         Calendar has indicated that this is filtered by Focus and provided a way to toggle the filtering.
         Now I won't be overwhelmed with my work calendar when trying to enjoy some personal time.
         The Mail app's inbox can be filtered to show only relevant mailboxes during a Focus.
         Mail notifications are also filtered to show only the relevant notifications prominently.
         This means that I can set up Mail to only deliver work-related Mail notifications during the Work Focus and prevent personal mail notifications from interrupting me.
         There are many reasons why your app may want to implement Focus filters.
         Perhaps your app manages multiple accounts, and it's appropriate to associate a Focus with a particular account.
         Apps with large amount of data may need to filter content for the Focus.
         If you would like to help your users avoid getting distracted while focused, you can do this by reducing badge counts, in-app alerts, and notifications to what is salient for the enabled Focus.
         Regarding appearance, your app may want to surface a theme or a layout based on the enabled Focus.
         Fundamentally, if your app can surface different content based on context, you may be able to employ Focus filters to enhance user experience.
         Let me explain how Focus filters work.
         Your app defines what can be customized by a user per Focus, and this is done using an AppIntent.
         The system will expose what can be configured per Focus.
         UI to configure properties defined by your AppIntent will be exposed in Focus settings as a Focus filter.
         Users can configure your app to behave a certain way by navigating to Focus settings and configuring Focus filters for your app.
         Now, I'm going to go over how you can incorporate Focus filters into your codebase.
         There are a few parts to defining your Focus filter.
         The first is implementing SetFocusFilterIntent.
         This indicates to the system that your app is interested in having custom settings per Focus.
         The second step is defining your app's parameters.
         These will represent what can be configured within your app by the user.
         The final step is to set the display representation, so your Focus filter appears in system settings with the correct content.
         This way, users are aware of what is configured.
         I'll dive into some code.
         The first thing you need to do is import AppIntents and define a struct that implements SetFocusFilterIntent.
         This is your Focus filter.
         Setting the title and description will help users discover what your Focus is all about.
         Focus filters appear in a grid view in Settings.
         Before your Focus filter has been configured, it will be surfaced to the user with this look.
         The icon here is your app's icon, the primary text is your app's name, and the secondary text will match the title variable that you set in your Focus filter.
         When the user taps in to configure your filter, the same content is displayed.
         This time, the system also includes the description string that you've provided, for additional context.
         Both the title and description strings are static, and they are read by the system at the time that your app is installed.
         When defining your Focus filter, you'll have to specify what a person can customize by providing a series of properties that are decorated as parameters.
         When specifying a parameter, you must give it a name and a data type.
         Parameters can be of a standard data type such as Bool, string, float, etcetera.
         If you have a custom data type that you would like to have configured, you can make it an entity, which will allow you to decorate it as a parameter.
         To learn more about entities and App Intents, watch the "Dive into App Intents" session.
         When defining your Focus filter, you will only specify the data type and name for each parameter.
         It is up to users to configure the value of the parameter that would apply during each Focus.
         Parameters can be marked as optional, which means that they do not have to be configured.
         Parameters that are not optional should provide default values.
         In code, you specify a parameter -- or an optional parameter -- by defining a variable of the type you want in your Focus filter and decorating it as a parameter.
         Here, I've created a required Bool parameter that represents whether my Focus filter should always use Dark Mode.
         I've set its default to false.
         I've also created an optional string parameter that represents a user's status message during this Focus.
         Lastly, I've included an optional account parameter that is an entity defined by my app; it contains information about a particular account.
         The title, which is set on all three of these parameters, is displayed in Settings to describe the parameter to the user.
         In Focus settings, once a user configures your app's Focus filter, it'll be presented in a similar grid to what I showed earlier.
         But this time, because the filter has already been configured, the content is dynamic in order to reflect what has been configured.
         The icon here is still your app's icon.
         The primary text and the secondary text can be customized using the display representation property on your FocusFilterIntent.
         The primary text should represent what parameters have been configured, such as Select Account, Set Status, etcetera.
         The secondary text should represent what the parameters have been configured to, such as Work Account or Working.
         In my code, I set the display representation to be generated dynamically.
         Since account and status are optional parameters, they only get included in the dynamic primary and secondary texts if they are actually set.
         Since alwaysUseDarkMode is a required parameter, it is always included in the primary and secondary texts.
         OK, you have now defined your Focus filter, so users can go into Focus settings and customize certain values for a particular Focus.
         But how can your app know what someone has customized? And how can your app update itself accordingly? It has to act on a change from the system.
         When a Focus change occurs and the system has determined that it's important for your app to know about this change, it will deliver this information to you in one of two ways.
         If the app is running, you will receive a call to the perform method in your FocusFilterIntent, if you've implemented it.
         If the app is not running, you can implement an extension that will get spun up.
         Again, if you've implemented perform in your FocusFilterIntent, that will get called in your extension.
         Since perform can get called on either your app or your extension, not every app needs an extension.
         Typically, if your app is only updating its own view in response to a Focus transition, then implementing perform just in the app would suffice.
         If your app's widget, notifications or badges would need to change based on the Focus transition, then you may want to consider implementing an extension.
         Basically, if your app would want to update anything outside its own views, you would need to implement the extension.
         For the rest of this session, I may refer to "your app" but that can mean either your app or your extension depending on this context.
         To respond to a Focus filter, implement the perform function, access the populated values for parameters provided via Settings, and then use these values to update your app's views and behavior.
         Your implementation of perform is called when the system determines that your app needs to respond to a Focus transition.
         Perform is also called when the system determines that the previously delivered values are no longer relevant.
         In this case, your Focus filter parameters are configured with the default values.
         When perform is called on your app's Focus filter, the values of all the parameters will be filled out to match what was configured in Settings.
         The values of the named parameters can be read by calling self.
        "name of the parameter.
        " In this example, at the end of perform, I update my app with the data I received.
         Sometimes, you may need to query the current Focus filter parameters.
         In my case, since my filter is called ExampleChatAppFocusFilter, I access ExampleChatAppFocus Filter.
        current.
        Now that your app is able to act on a Focus filter, the next step is to take the user experience further by providing additional context about how your app behavior has changed back to the system.
        By providing additional context, you can influence your app behavior outside your app's views.
         Examples of this include notifications filtering and setting your app's notification badge count.
         One way you can give the system information is via the App Context object.
         This is an object that can be returned as part of the result of the perform function.
         Or you can return the App Context at any time in your Focus filter and force the system to get the updated value by calling invalidate.
         When a Focus filter is active, your app may have additional context to determine if a particular notification should not interrupt the user.
         To pass along this information, your app must set the filterPredicate property in the AppContext.
         This filter predicate works in conjunction with a new string property called filterCriteria on the UNNotification.
         If the filter criteria on the notification does not match the filter predicate, the notification is silenced.
         To set the filter predicate from your FocusFilterIntent, include it in your App Context.
         Say the device has the Personal Focus enabled and the user has set it up so that only the personal account is selected; in this case, I set up the filter predicate to be the personal account's identifier.
         If the incoming notification is not from the personal account, it should not interrupt the user.
         Here, when I'm configuring this notification, I set the filterCriteria to be the work account's identifier.
         This is because I know this notification is being sent to the work account, and I expect that this notification would be silenced because the account identifier does not match the predicate that I had just set, which only matched with the personal account's identifier.
         This example is for a local notification but filter criteria can also be set on the JSON payload of a remote notification.
         Another way to provide the system additional context is by updating your app's badge count to reflect what is important during the currently-enabled Focus.
         This prevents distractions for your users.
         There is a new API in UserNotifications for this purpose.
         On UNUserNotificationCenter, you simply call setBadgeCount with an unsigned integer that represents the new badge value.
         Now, you know how to provide additional context to filter notifications or set the badge count.
         Remember, the goal of this feature is to surface what is most relevant to a user when they are focused.
         Sometimes this requires minimizing unrelated content to prevent distraction when a Focus is enabled.
         For next steps, I encourage you to start considering what parts of your app would benefit from a Focus filter, determine which properties can be configured, set up your app and your extension to process this, and then take it a step further by assessing whether to provide additional context.
         That's it for Focus filters! Thank you for joining in on this session and have a great rest of WWDC.

        """
    }

    var japanese: String {
        """
        こんにちは、iOSシステムエクスペリエンスチームのエンジニア、テジャです！このセッションでは、Focusフィルターに触れていただきます。
         Focusは、iOS 15、macOS Monterey、watchOS 8で導入されました。
         一定期間、システムの動作を設定することで、重要なことに集中できるようにするものです。
         フォーカスは、コントロールセンターで、システムフォーカスかカスタムフォーカスのどちらかを選択するだけで有効になります。
         フォーカスが有効になっている間、通知の動作をカスタマイズすることができます。
         たとえば、仕事用のフォーカスでは、同僚からの通知だけを許可したり、仕事に関連する一部のアプリケーションの通知だけを許可したりすることができます。
         それぞれのフォーカスについて、システムの動作は「設定」で設定し、スケジュールすることができます。
         iOS 16とmacOS Venturaでは、FocusフィルターによってFocus機能が強化されています。
         まず、Focusフィルターとその動作について紹介します。
         次に、アプリにフォーカスフィルタを定義する方法について説明します。
         その後、フォーカスフィルタに作用させるとはどういうことかについて説明します。
         そして最後に、アプリからシステムに対して追加のコンテキストを提供する方法について説明します。
         フォーカスフィルタは、現在有効になっているフォーカスに基づいて、アプリの動作をカスタマイズするための方法です。
         フォーカス フィルタを採用したシステム アプリには、素晴らしい例がいくつかあります。
         カレンダーアプリでは、フォーカスが有効なときにデフォルトで表示されるカレンダーをフィルタリングできます。
         私のカレンダーは通常このような感じです。
         見てのとおり、仕事とプライベートのカレンダーイベントが混在しています。
         個人用フォーカスで、カレンダーにフォーカスフィルタを設定して、個人用カレンダーだけを表示することができます。
         フォーカスフィルタを設定すると、私のカレンダーはこのようになります。
         カレンダーは、これが「フォーカス」によるフィルタリングであることを示し、フィルタリングを切り替える方法を提供してくれています。
         これで、プライベートな時間を楽しもうとするときに、仕事のカレンダーに振り回されることがなくなりました。
         メールアプリの受信箱は、Focus中に関連するメールボックスだけを表示するようにフィルタリングできます。
         メール通知もフィルタリングされ、関連する通知だけが目立つように表示されます。
         つまり、仕事のフォーカス中は仕事に関連するメール通知だけを配信し、個人的なメール通知に邪魔されないように設定することができるんです。
         アプリに「フォーカス」フィルタを実装したい理由はたくさんあります。
         アプリが複数のアカウントを管理しており、フォーカスを特定のアカウントに関連付けることが適切な場合があります。
         大量のデータを扱うアプリでは、Focus 用にコンテンツをフィルタリングする必要があるかもしれません。
         ユーザーが集中中に気が散らないようにするには、バッジの数、アプリ内のアラート、通知を、有効なフォーカスのために重要なものだけに減らすとよいでしょう。
         外観については、アプリは有効なフォーカスに基づいたテーマやレイアウトを表示することができます。
         基本的に、アプリがコンテキストに基づいて異なるコンテンツを表示できる場合、ユーザー エクスペリエンスを向上させるためにフォーカス フィルタを使用することができます。
         フォーカス フィルタの仕組みについて説明します。
         アプリは、フォーカスごとにユーザーがカスタマイズできる内容を定義し、これはAppIntentを使って行われます。
         システムは、Focusごとに設定可能なものを公開する。
         AppIntent で定義されたプロパティを設定する UI は、Focus フィルタとして Focus 設定に公開されます。
         ユーザーは、Focus settings に移動して、アプリに Focus フィルターを設定することで、アプリが特定の動作をするように設定することができます。
         では、Focus Filter をどのようにコードベースに組み込むかを説明します。
         フォーカス・フィルタを定義するには、いくつかのパートがあります。
         まず、SetFocusFilterIntent を実装します。
         これは、あなたのアプリがフォーカスごとのカスタム設定に興味があることをシステムに示すものです。
         2 番目のステップは、アプリのパラメータを定義することです。
         これは、ユーザーがアプリ内で設定できる内容を表します。
         最後のステップは、表示方法を設定することで、システム設定にフォーカスフィルタが正しい内容で表示されるようにします。
         こうすることで、ユーザーは何が設定されているのかを知ることができます。
         それでは、コードを見ていきましょう。
         まず、AppIntents をインポートして、SetFocusFilterIntent を実装した構造体を定義する必要があります。
         これがあなたのFocusフィルターです。
         タイトルと説明を設定することで、ユーザーがあなたのFocusが何であるかを発見するのに役立ちます。
         フォーカス フィルタは、「設定」のグリッド ビューに表示されます。
         フォーカスフィルタが設定される前に、このような外観でユーザに表示されます。
         このアイコンはアプリのアイコンで、主テキストはアプリ名、副テキストはフォーカスフィルターに設定したタイトル変数と一致します。
         ユーザーがフィルターを設定するためにタップすると、同じ内容が表示されます。
         このとき、追加のコンテキストとして、ユーザーが指定した説明の文字列も含まれます。
         タイトルと説明の文字列は両方とも静的で、アプリがインストールされた時点でシステムに読み込まれます。
         Focus フィルタを定義する際には、パラメータとして装飾された一連のプロパティを提供することで、人がカスタマイズできる内容を指定する必要があります。
         パラメータを指定するときは、名前とデータ型を指定する必要があります。
         パラメータは、Bool、string、floatなどの標準的なデータ型にすることができます。
         もし、設定したいカスタムデータ型がある場合は、それをエンティティにすることで、パラメータとして装飾することができます。
         エンティティおよびApp Intentsの詳細については、「Dive into App Intents」セッションを参照してください。
         Focus フィルタを定義する場合、各パラメータのデータ型と名前のみを指定します。
         各フォーカス中に適用されるパラメータの値を設定するのは、ユーザー次第です。
         パラメータはオプションとしてマークすることができ、これは設定する必要がないことを意味します。
         オプションでないパラメータは、デフォルト値を指定する必要がある。
         コードでパラメータ（オプションのパラメータ）を指定するには、Focus フィルタに必要な型の変数を定義して、それをパラメータとして飾ります。
         ここでは、フォーカス・フィルターが常にダークモードを使用するかどうかを表す必須パラメータとして、Boolを作成した。
         デフォルトでは false に設定されています。
         また、オプションの文字列パラメータを作成し、フォーカス中のユーザーのステータス・メッセージを表しています。
         最後に、アプリが定義するエンティティである account パラメータをオプションで用意しました。
         これらの3つのパラメータに設定されているタイトルは、ユーザーにパラメータを説明するために設定に表示されます。
         Focus settingsでは、ユーザーがアプリのFocusフィルタを設定すると、先ほど示したものと同様のグリッドで表示されます。
         しかし今回は、すでにフィルターが設定されているため、設定された内容を反映した動的な内容になっています。
         ここで表示されるアイコンは、アプリのアイコンのままです。
         主テキストと副テキストは、FocusFilterIntentのdisplay representationプロパティを使ってカスタマイズすることができます。
         主テキストは、「アカウントの選択」、「ステータスの設定」など、設定されているパラメータを表します。
         二番目のテキストは、Work Account や Working など、パラメータがどのように設定されているかを表します。
         私のコードでは、表示表現は動的に生成されるように設定しています。
         accountとstatusはオプションのパラメータなので、実際に設定された場合のみ、動的な主テキストと副テキストに含まれることになります。
         alwaysUseDarkModeは必須パラメータなので、常にプライマリおよびセカンダリテキストに含まれることになります。
         これで、フォーカス・フィルタの定義が完了し、ユーザーはフォーカス設定に移動して、特定のフォーカスに対する特定の値をカスタマイズできるようになりました。
         しかし、誰かがカスタマイズした値をアプリが知るにはどうしたらよいでしょうか。また、それに応じてアプリを更新するにはどうすればよいでしょうか。それは、システムからの変更に対応する必要があります。
         フォーカスの変更が発生し、その変更についてアプリが知ることが重要であるとシステムが判断した場合、2 つの方法のいずれかでその情報をユーザーに提供します。
         アプリが実行中の場合、FocusFilterIntent の perform メソッドを実装していれば、その呼び出しを受け取ります。
         アプリが実行中でない場合は、拡張機能を実装して、その拡張機能がスピンアップされるようにします。
         この場合も、FocusFilterIntentにperformを実装しておけば、拡張機能で呼び出されることになります。
         performはアプリでも拡張機能でも呼び出せるので、すべてのアプリに拡張機能が必要なわけではありません。
         通常、アプリがFocusの遷移に対応して自身のビューを更新するだけであれば、アプリだけでperformを実装すれば十分でしょう。
         アプリのウィジェット、通知、バッジが Focus の遷移に基づいて変更される必要がある場合は、エクステンションの実装を検討する必要があるかもしれません。
         基本的に、アプリが自分のビュー以外のものを更新したい場合は、エクステンションを実装する必要があります。
         このセッションの残りの部分では、「あなたのアプリ」と呼ぶことがありますが、この文脈に応じて、あなたのアプリまたはエクステンションのいずれかを意味することができます。
         Focusフィルタに対応するには、perform関数を実装し、Settings経由で提供されたパラメータの値にアクセスし、その値を使ってアプリのビューと動作を更新します。
         perform の実装は、アプリが Focus の遷移に応答する必要があるとシステムが判断したときに呼び出されます。
         また、以前に配信された値がもはや適切でないとシステムが判断した場合にも、perform が呼び出されます。
         この場合、Focusフィルタパラメータはデフォルト値で設定されます。
         アプリのフォーカスフィルタに対してperformが呼び出されると、すべてのパラメータの値が、Settingsで設定されたものと一致するように入力されます。
         名前付きパラメータの値を読み取るには、self.
        "パラメータの名前
        " この例では、performの終了時に、受け取ったデータでアプリを更新しています。
         時には、現在のFocusフィルターのパラメータを問い合わせる必要があるかもしれない。
         私の場合、ExampleChatAppFocusFilter という名前のフィルタなので、ExampleChatAppFocus Filter にアクセスします。
        にアクセスします。
        アプリが Focus フィルタで動作できるようになったので、次のステップでは、アプリの動作がどのように変化したかについて追加のコンテキストをシステムに提供することで、ユーザー体験をさらに向上させることができます。
        追加のコンテキストを提供することで、アプリのビューの外側で、アプリの動作に影響を与えることができます。
         この例として、通知のフィルタリングやアプリの通知バッジ数の設定などがあります。
         システムに情報を提供する方法の1つは、App Contextオブジェクトを使用することです。
         これは、perform関数の結果の一部として返すことができるオブジェクトです。
         また、フォーカス フィルタの中でいつでも App Context を返すことができ、invalidate を呼び出して更新された値をシステムに取得させることができます。
         フォーカスフィルタが有効な場合、アプリには、特定の通知がユーザーの邪魔をしないようにすべきかどうかを判断するための追加のコンテキストがある場合があります。
         この情報を渡すために、アプリはAppContextにfilterPredicateプロパティを設定する必要があります。
         このフィルタ述語は、UNNotification上のfilterCriteriaという新しい文字列プロパティと連動して動作します。
         通知上のフィルタ基準がフィルタ述語に一致しない場合、通知は停止されます。
         FocusFilterIntent からフィルタ述語を設定するには、App Context にそれを含めます。
         デバイスがPersonal Focusを有効にしていて、ユーザーが個人アカウントのみを選択するように設定したとします。この場合、フィルターの述語を個人アカウントの識別子に設定しました。
         個人アカウントからの着信でない場合、ユーザーの邪魔をしないようにします。
         ここで、この通知を設定するとき、filterCriteriaを仕事用アカウントの識別子に設定しています。
         これは、この通知が仕事用のアカウントに送られることを知っているからで、アカウント識別子が、先ほど設定した個人アカウントの識別子としかマッチしない述語とマッチしないため、この通知が沈黙すると予想しています。
         この例は、ローカル通知のためのものですが、フィルタ基準は、リモート通知のJSONペイロードに設定することもできます。
         システムに追加のコンテキストを提供するもう1つの方法は、現在有効なFocus中に重要なものを反映するために、アプリのバッジ数を更新することです。
         これにより、ユーザーの注意力が散漫になるのを防ぐことができます。
         この目的のために、UserNotifications に新しい API が用意されています。
         UNUserNotificationCenter では、新しいバッジの値を表す符号なし整数値で setBadgeCount を呼び出すだけです。
         これで、通知のフィルタリングやバッジカウントの設定に追加のコンテキストを提供する方法 がわかりました。
         この機能の目標は、ユーザーが集中しているときに、最も関連性の高いものを表示することです。
         このため、フォーカスが有効なときに気が散らないように、関係のないコンテンツを最小限にする必要がある場合もあります。
         次のステップとして、アプリのどの部分に Focus フィルターが役立つかを検討し、どのプロパティが設定可能かを判断し、アプリと拡張機能を設定してこれを処理し、さらに一歩進んで追加のコンテキストを提供するかどうかを判断することをお勧めします。
         フォーカスフィルタについては以上です。このセッションに参加していただき、ありがとうございました！WWDCを楽しんでください。

        """
    }
}

