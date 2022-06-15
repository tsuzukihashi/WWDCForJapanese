import Foundation

struct DiveIntoAppIntents: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Dive into App Intents"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6525/6525_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10032/")!
    }

    var english: String {
        """
        Hi, folks.
         My name is Michael Gorbach from Shortcuts Engineering.
         Thanks for tuning in for this deep dive into App Intents, our new framework for exposing your app's functionality to the system.
         Here's the plan for our dive.
         After a quick introduction, I'll talk about intents and their parameters, and how to define entities.
         I'll go over some powerful finding and filtering features you can build, and how your intents can interact with the user.
         Lastly, I'll cover App Intents architecture and lifecycle.
         Let's start at the beginning.
         In iOS 10, we introduced the SiriKit Intents framework, which lets you hook up your app's functionality to Siri domains like messaging, workouts, and payments.
         Now we're introducing a new framework called App Intents.
         It has three key components.
         Intents are actions built into your app that can be used throughout the system.
         Intents use entities to represent your app's concepts.
         App Shortcuts wrap your intents to make them automatic and discoverable.
         Let's talk about a couple of the ways that App Intents can make your app's functionality available in more places, and benefit your customers.
         With App Shortcuts, everyone can use your app's features with their voice through Siri, without needing to set anything up first.
         The same adoption also makes your intents appear in Spotlight when people search for your app and when your app's suggested.
         This will put your work front and center.
         Using App Intents, you can also build Focus Filters, letting customers customize your app for a specific Focus.
         For example, they might set up their Calendar app to only show their work calendar while they're actually at work.
         Check out this session to learn more about how to adopt Focus Filters.
         With App Shortcuts, your intents show up in the Shortcuts app automatically, without needing to be added manually.
         Integrating your actions into Shortcuts is incredibly valuable for customers because they can run shortcuts, and take advantage of your app's features, from so many places throughout the system.
         They can run shortcuts with a single tap on the Home Screen, from the menu bar on macOS, and in many other ways.
         They can even set shortcuts up to run automatically with automations.
         Supporting shortcuts multiplies the power and capability of your app by connecting it to the entire Shortcuts ecosystem, harnessing the power of an array of apps from Apple and other developers.
         That's because a shortcut can combine actions from multiple apps, letting users invent entirely new features and capabilities without you needing to do any work.
         If you want to learn how to make your actions work well with others and fit seamlessly into this ecosystem, check out our design talk.
         Our goal in building App Intents was to make it a joy to develop for.
         App Intents is concise.
         Writing a simple intent can take only a few lines of code, but the API also scales to deeper and more customizable actions.
         App Intents is modern.
         We've gone all in on Swift, leveraging result builders, property wrappers, protocol-oriented programming, and generics.
         These APIs just couldn't exist without cutting-edge language features.
         Adopting App Intents is also easy, because it doesn't require re-architecting your products and targets or creating a framework.
         It doesn't require an extension and can be adopted right in your app.
         And App Intents code is maintainable.
         Like SwiftUI, App Intents uses your code as the fundamental source of truth, avoiding the need for separate editors or definition files.
         This lets you rapidly build and iterate on your adoption, and simplifies maintenance because everything lives in one place.
         With that said, let's explore these new APIs, starting with the intent, the central building block of our new framework.
         An app intent -- or "intent" for short -- is a single, isolated unit of functionality that your app exposes to the system.
         For example, an intent could make a new calendar event, open a particular screen, or place an order.
         An intent can be run by the user on request -- like by running a shortcut or asking Siri -- or automatically -- like using Focus filters or a Shortcuts automation.
         When an intent is run, it will either return a result or throw an error.
         An intent includes three key pieces: metadata, or information about the intent, including a localized title; parameters, which are inputs that the intent can use when it's run; and a perform method, which does the actual work when the intent is executed.
         Our starting point today is this Library app.
         Since I'm a huge bookworm, it's all about tracking books I've read, want to read, or am currently reading.
         Each category is shown in separate tab of the app that I call a Shelf.
         My users visit the Currently Reading shelf all the time, so I'm going expose an app intent to make opening it quicker and more convenient.
         I'll create an OpenCurrentlyReading intent here by defining a Swift struct that conforms to the AppIntent protocol.
         I need to implement only one method, called perform.
         In my app, I've already got a navigator that can open tabs, so implementing the intent for me is only a few lines of code.
         I'll annotate the perform method with @MainActor, since my Navigator expects the main thread.
         My intent also needs a title.
         Like all the other strings I'll be showing you today, this will get localized automatically if I add the key to my strings files.
         This is all I need to do to get a basic app intent working.
         Now that it's defined in my code, it will automatically appear in the Shortcuts editor, where my user can add it to a shortcut.
         Just exposing this intent provides huge leverage, because once customers turn this intent into a shortcut, it can be used from a ton of places in the system, including all of these.
         To make my new intent easy to use and discover, I'll also add support for App Shortcuts.
         With a little bit of code, I can make my intent show up automatically in Spotlight and the Shortcuts app, and I can define a phrase that people can say to Siri to use this intent with their voice.
         Check out the "Implement App Shortcuts with App Intents" session to get all the details.
         So far, I've exposed an intent to open the Currently Reading shelf.
         Next, let's generalize it, adding a parameter so it can open any of the shelves.
         I have an enum that represents shelves.
         In order for it to be used as an intent parameter, I need to conform it to the AppEnum protocol.
         AppEnum requires a String raw value, so I'll add that first.
         It also requires that I provide localizable, human-readable titles for each of my enum cases.
         These must be provided as a dictionary literal, since the compiler will read this code at build time.
         Finally, I'll add a typeDisplayName: a user-visible, localizable name for this enum type as a whole.
         I'll use "Shelf.
        " In an intent, each parameter is declared using an @Parameter property wrapper, which is initialized with information about the parameter, like the title.
         Here, I define a new shelf parameter, which I read in my perform method.
         Parameters support all of these types, including numbers, strings, files, and more, as well as entities and enums from your app.
         Here's how this intent looks in the Shortcuts editor.
         Note that the shelf parameter appears in a table row.
         I can make the UI more streamlined, and make it fit better into Shortcuts, by using the ParameterSummary API.
         The Parameter Summary is a sentence that represents your intent and its parameters in the editor, like "Open .
        " For best results in Shortcuts, you should always provide a Parameter Summary for every intent you create.
         You can also define which parameters show up below the fold and which are hidden.
         These APIs can do some pretty cool stuff, like varying the summary based on the actual values of any parameter of your intent, using the When and Otherwise APIs, or the Switch, Case, and Default APIs.
         To add a parameter summary, I implement this static property.
         Here I'll return the string "Open", and interpolate the shelf parameter.
         The last thing I need to do to get Open Shelf working is make sure that the intent opens the Library app when it's run, like this.
         Opening the app by is controlled by the static property, openAppWhenRun.
         It defaults to false, which is great for most intents.
         But for intents that open something in the UI like this one, I'll need to set it to true.
         I just created an intent to open shelves.
         This is super simple because the set of shelves is fixed.
         But what if I wanted to build an intent that opens Books, the set of which is dynamic, not fixed? For that, I'll need entities.
         An entity is a concept that your app exposes to App Intents.
         You should use an entity instead of an enum when the values are dynamic, or user-defined, like a note in Notes or a photo or album in Photos.
         To provide instances of entities, your app can implement queries, and return entities as results from intents.
         I'll start by making an intent to open a book in the app.
         In the Shortcuts editor, it should look like this.
         When people tap on the Book parameter, they'll get a picker to choose a book, including a set of suggested entities that my app has provided.
         They can also find any book in their library with this search field at the top of the picker.
         Before I build the intent itself, I'll need to create a book entity and the corresponding query.
         An entity contains at least three things: an identifier, a display representation, and an entity type name.
         To add an entity, start by conforming a struct to the AppEntity protocol.
         Here, I'll define a new struct for the BookEntity, but I could also conform an existing type from my model.
         You provide an identifier by conforming your entity to the Identifiable protocol.
         App Intents uses this identifier to refer to your entity as it's passed between your app and other parts of the system.
         The identifier should be stable and persistent, since it might be saved in a shortcut created by your customers.
         The display representation is used to show this entity to the user.
         This can be as simple as a string of text, like a book title.
         You could also provide a subtitle and an image.
         The typeDisplayName is a human-readable string representing the type of an entity.
         In this example, it's "Book.
        " Now, to round out the book entity, I need to add a query.
         A query gives the system an interface for retrieving entities from your app.
         Queries can look up entities in a few ways.
         All queries need to be able to look up entities based on an identifier.
         String queries support search.
         And later, you'll run into property queries, which are more flexible.
         All queries can also provide suggested entities, which allow the users to pick from a list.
         Every entity should be associated with a query so the system can look up instances of that entity.
         You provide a query by making a Swift struct that conforms to the EntityQuery protocol.
         The basic query has only one required method, which you implement to resolve entities given an array of identifiers.
         I've implemented this by going to my model database and finding any books matching those identifiers.
         Now, I need to hook up the query to the entity.
         I do this by implementing the defaultQuery static property on the BookEntity type and returning an instance of my BookQuery.
         When the user picks a book, its identifier will be saved into the shortcut.
         When the shortcut is run, App Intents will pass the identifier to my query to retrieve the BookEntity instance.
         Now that the BookEntity type conforms to the AppEntity protocol, I can use it as a parameter in my OpenBook intent.
         The perform method uses my Navigator to navigate to the book.
        In order to support the book picker, my query also needs to provide suggested results.
         To do that, I need to implement one more method on query, returning all the books added to my Library app.
         Shortcuts will fill the picker with these results.
         Notice that the Shortcuts UI has a search field on top.
         My app could have a lot of book entities, so I should really run the search in my app process, against my database directly.
         The StringQuery API lets me do that.
         Adopting the StringQuery subprotocol gives me one more method to implement, called entities (matching string:), to return results given a string.
         Here, I've implemented it as a simple case-insensitive match against the title of the book, but I could have done fancier stuff like searching through the author or series name, for example.
         If I have a huge list of books, and a smaller list of favorites, I could return just the favorites in suggestedEntities, and rely on entities (matching string:) to allow my users to search across the longer list.
         Now I've exposed a way to open books in my app, and built a book entity and book query in the process.
         I can use the same entity and query to create more intents.
         My next task is to build an intent to add books to the library.
         Customers can quickly add books while browsing online using a share sheet shortcut, or they can tell Siri on HomePod to add a book without even looking at a screen.
         Building intents like this that manipulate your model directly without showing your UI can really empower your users.
         Here's the implementation of my AddBook intent, taking as parameters the title of the book and an optional name of the author.
         It also includes an optional note to record which friend recommended the book.
         The perform method will add the book to the library by looking it up with an API call using async/await.
         It will throw an error if it can't find a match.
         To localize this error, I conform my error type to the CustomLocalizedString ResourceConvertible protocol.
         I'll return a localized string key from this property, and add the key to my strings files.
         This Add Book intent is incredibly useful as is, with Siri, widgets, and more.
         But it gets even more flexible if it can be combined with other intents.
         With a little bit of work, I can allow combining my Add Book intent with the Open Book intent I built earlier, passing the result from one to the other.
         To do so, I'll have the Add Book intent return a value as part of its result.
         Notice that my perform method's return type has picked up a new protocol to represent the value I'm returning.
         Now, users can connect the result value of this intent to other intents that take a book entity as a parameter.
         The Add Book intent and the Open Book intent pair quite naturally together, so you can make a shortcut that adds a book and then immediately opens it in the library.
         It's a common pattern to return a result from an intent and open it in the app.
         App intents have a built-in way to express this called the openIntent.
         If I add an openIntent, customers will get a new switch in Shortcuts called "Open When Run.
        " If they turn the switch off, they'll be able to use this intent as part of a shortcut in the background without interruption.
         If they leave the switch on, the newly added book will be immediately opened in my Library app.
         Adopting openIntent is as easy as creating an instance of the Open Book intent and returning it as part of the result.
         When this intent is run, if the Open When Run switch is on, the Open Book intent will automatically be performed after the Add Book intent finishes.
         There's a lot more you can do with entities and queries.
         With the next set of APIs, AppIntents opens up some powerful abilities you never had before with the SiriKit Intents framework.
         Let's take a look at how you can expose more information from your entities, and allow customers to find and filter based on that.
         So far, I've added all the basic requirements to my book entity.
         But to let people integrate books more deeply into their shortcuts, I'm going to need to expose a bit more about my books.
         Entities support properties, which hold additional information on the entity that you want to expose to users.
         In this case, I'll add the book's author, publishing date, read date, and who recommended it, so that people can use those properties in their shortcuts.
         I add properties to my BookEntity using a property wrapper called @Property.
         Properties support all the same types that parameters do, and each one takes a localized title.
         With these new properties, my customers can now use magic variables in Shortcuts to pull out each new piece of information when working with a book entity When using the earlier Add Book intent, they can use the author or publishing date of a newly added book in their shortcuts.
        When you combine properties with queries, your app automatically gets these incredibly powerful Find and Filter actions in Shortcuts, with this flexible predicate editor UI.
         Now, my customers will be able to find and filter books based on date read, title, author, and more.
         It's a piece of cake to find all the books by Delia Owens, for example.
         Using the Sort by and Limit options, you can support even more advanced queries, like find the three most recently published books by Delia Owens.
         A customer can use these building blocks to do some pretty cool stuff, like finding the three most common authors in their collection.
         To enable all this, I'll need to adopt another kind of query called a property query.
         Property queries find entities not based on a string, or an identifier, but on the properties within the entity.
         There are three steps to implementing property queries.
         First, you declare query properties, which specify how your entity can be searched using its properties.
         Then, you add sorting options, which define how query results can be sorted.
         And finally, you implement entities(matching:) to run the search.
         The query properties declare every way AppIntents can search on the entity associated with this query.
         Each one lists a property of my entity, and the comparison operators -- like contains, equal to, or less than -- that are available for it.
         Here, I list "less than" and "greater than" comparators for my date properties, and "contains" and "equal to" for my title property.
         Query properties map each combination of property and comparator into a type of your choice, called the comparator mapping type.
         Here, I am using CoreData, so I'll use an NSPredicate.
         If I was using a custom database or a REST API, I could design my own comparator type and use that instead.
         Here's the code to set up the query properties for my books.
         I conform BooksQuery to the EntityPropertyQuery protocol.
         Then I implement static var properties using the QueryProperties result builder.
         Each entry specifies a keyPath of a Property that can be queried, and within it, each comparator that is applicable to that property.
         For each comparator, I provide an NSPredicate, because I've chosen NSPredicate as my comparator mapping type.
         When the system asks my app to return results for the query, it will provide back the NSPredicates that I'm constructing here.
         There's a similar definition for sorting.
         This is a list of all the properties my model can sort books by.
         In this case, I allow sorting by title, date read, and date published.
         Finally, I implement entities(matching:), which queries my database and returns matching entities.
         This method takes an array of the comparator mapping type I used in the previously defined query parameters -- in this case, NSPredicate.
         These predicates are describing what criteria on the properties of my entity I want to query by.
         It also takes a mode, indicating whether to combine the predicates with "and" or with "or," key paths to sort by, and an optional limit for the number of results.
         My implementation uses these parameters to perform a query against my CoreData database.
         What can customers do with this property query? They can pick a random book from their library to read.
         They can find all their books published in the early part of the twentieth century.
         They can leverage the Shortcuts ecosystem and make my app more useful by connecting it to others.
         For example, they can use a spreadsheet app to export all the books they read this year to a CSV file.
         Or, they can use a graphing app to make a chart of how many books they've read every year over the last 10.
         And that's just the beginning.
         This kind of deep App Intents adoption really lets customers use your app to do what they need it to do, making it a critical part of their workflow.
         Each of these integrations -- like making graphs, for example -- is a feature you don't have to build.
         When your intents are performed, your app may need to interact with the user to show or speak a result, or to resolve ambiguity, whether it's a Siri request or a shortcut.
         App Intents supports a number of these interactions: dialog for giving text and voice feedback to your users when an intent has completed, and snippets for giving visual feedback.
         Request value and disambiguation for asking the user to clarify values for intent parameters, and confirmation for verifying parameter values or checking with the user on intents that are transactional or destructive.
         Dialog provides a spoken or textual response to the person running an intent.
         It's really important to provide dialog for intents to work well in a voice experience.
         In my Add Book intent from earlier, I'll add a needsValueDialog that's spoken when asking for a book title and a result dialog returned from my perform method.
         These will be read or shown by Shortcuts or Siri across our many platforms.
         You can think of snippets as the visual equivalent of dialog, letting you add a visual representation to the result of your intent.
         To use a snippet, just add the SwiftUI view of your choice as a trailing closure to your intent result.
         Like with a widget, your SwiftUI view will be archived and sent over to Shortcuts or Siri.
         App Intents also supports asking the user for a value by throwing requestValue.
         For example, this comes in handy when you need a value for a parameter that is sometimes optional.
         Here, requestValue helps me when my string search returns more than one book.
         In this case, I prompt and ask for an author to narrow the book search down.
         requestValue gives me an error I can throw, which will prompt the user, and rerun the action with the updated author name.
         Disambiguation, meanwhile, is great when you need the user to choose between a set of values for a parameter.
         This gives me an even better way to handle multiple possible results in my Add Book action.
         Here, I get a list of author names from the generated books, and request disambiguation with those possible values.
         The user will be asked to pick between them, and I'll get the result back.
         Lastly, App Intents supports two different kinds of confirmation.
         The first kind is confirmation of a parameter value.
         You might use this when you have a guess at what that value should be but you want to confirm, just to make sure.
         When adding a book, sometimes the web service I call to look up books by title returns a couple matches, but one of them is by far the more popular.
         In these cases, I'm going to assume that the user meant to add that popular book, but I'll add confirmation to make sure I got it right.
         To do that, I'll call requestConfirmation on the title parameter.
         The second kind is a confirmation of the result of an intent.
         This is great for placing orders, for example.
         If I wanted to monetize my Library app and add ordering through a bookstore, I'd want to make sure that I have the order right.
         To do this, I could call requestConfirmation on my intent, passing in the order to be placed.
         I'll specify a snippet here too, showing a preview of the order.
         I prefix the call with "try" because requestConfirmation will throw an error if the user cancels instead of confirming.
         Before I leave you, there are a couple aspects of the App Intents architecture I want to cover, which you should know as you adopt the framework.
         There are actually two ways to build your App Intents: within your app or in a separate extension.
         Of these, implementing intents directly in your app is the simplest.
         This is great because you don't need a framework or to duplicate your code, and you don't need to coordinate across processes.
         Using your app also gives some higher memory limits, and it gives you the ability to do some kinds of work that are harder from an extension, like playing audio.
         Your app can be run in the foreground if you implement openAppWhenRun on your intent to return true.
         Otherwise, it will be run in the background.
         When running in the background, your app will launch in a special mode without scenes being brought up to maximize performance.
         In fact, if you implement background app intents in your app, we strongly encourage you to also implement scene support.
         Or, you can build your app intents in an extension.
         This has a couple advantages.
         It's lighter weight, because the extension process only handles app intents and doesn't require spinning up your app.
         If you are handling Focus intents, using an extension also means that you'll immediately get intents performed on your extension when Focus changes, without the requirement that your app is running in the foreground first.
         An extension is a bit more work, since you'll need to add a new target, move some code into a framework, and handle coordination between your app and the extension.
         To create an App Intents extension, go to File > New Target in Xcode and choose App Intents Extension.
         With App Intents, your code is the only source of truth.
         App Intents achieves this elegant developer experience by statically extracting information about your intents, entities, queries, and parameters at build time.
         Xcode will generate a metadata file inside your app or extension bundle during your build process, containing information received from the Swift compiler as it runs on your code.
         To make sure all of this works, keep your App Intents types directly in the target or extension, not in a framework.
         Similarly, your localized strings should be found in a strings file within the same bundle where your App Intents types live.
         For those of you who have existing apps with SiriKit Intents that you want to upgrade, if you adopt intents to integrate with widgets, or domains like messaging or media, you should keep using the SiriKit Intents framework.
         But if you add custom intents for Siri and Shortcuts, you should go ahead and upgrade to App Intents.
         You can start the upgrade process by clicking the Convert to App Intent button in your SiriKit Intents definition file.
         Integrating your app into Shortcuts with App Intents is a great way to maximize your leverage as a developer, because by doing a small amount of work to adopt App Intents, you create a large amount of value for customers.
         Thank you for joining! I really hope that you'll try out App Intents today and give us your feedback.
         I'm excited about how this new framework can help you surprise, delight, and empower folks using your apps! Happy reading and hope your WWDC is epic!
        """
    }

    var japanese: String {
        """
        皆さん、こんにちは。
         Shortcuts Engineering の Michael Gorbach です。
         アプリの機能をシステムに公開するための新しいフレームワーク、App Intentsのディープダイブにご興味をお持ちいただきありがとうございます。
         今回の企画は以下の通りです。
         簡単なイントロダクションの後、インテントとそのパラメータ、そしてエンティティの定義方法について説明します。
         また、強力な検索機能とフィルタリング機能を構築し、インテントがどのようにユーザーと対話するのかについて説明します。
         最後に、App Intentsのアーキテクチャとライフサイクルについて説明します。
         まず、はじめに。
         iOS 10 では、SiriKit Intents フレームワークを導入し、メッセージング、ワークアウト、支払いなどの Siri の領域にあなたのアプリの機能をフックアップすることができます。
         そして今、私たちはApp Intentsという新しいフレームワークを導入しています。
         このフレームワークには、3つの主要なコンポーネントがあります。
         インテントは、アプリに組み込まれたアクションで、システム全体で使用することができます。
         インテントは、アプリのコンセプトを表すエンティティを使用します。
         App Shortcutsは、インテントをラップして、自動的かつ発見しやすいようにします。
         アプリの機能をより多くの場所で利用できるようにし、顧客に利益をもたらす、アプリインテントのいくつかの方法について説明します。
         App Shortcutsを使えば、最初に何も設定しなくても、誰もがSiriを通じて音声であなたのアプリの機能を使えるようになります。
         同じ採用により、人々があなたのアプリケーションを検索した時や、あなたのアプリケーションが提案された時に、あなたのインテントがSpotlightに表示されるようにもなります。
         これによって、あなたの作品が最前面に置かれることになります。
         アプリインテントを使用すると、フォーカスフィルタを構築して、顧客が特定のフォーカス用にアプリをカスタマイズすることもできます。
         たとえば、カレンダーアプリを設定して、実際に職場にいる間だけ仕事のカレンダーを表示させることができます。
         このセッションでは、フォーカスフィルタの採用方法について詳しく説明します。
         アプリのショートカットを使用すると、手動で追加しなくても、インテントがショートカットアプリに自動的に表示されます。
         アクションを Shortcuts に統合すると、システム全体の多くの場所からショートカットを実行したり、アプリの機能を利用したりできるため、顧客にとって非常に有益です。
         ホーム画面でのシングルタップ、macOSのメニューバーなど、さまざまな方法でショートカットを実行できます。
         オートメーションを使って、ショートカットを自動的に実行するように設定することもできます。
         ショートカットをサポートすることで、あなたのアプリケーションは、Appleやほかのデベロッパのさまざまなアプリケーションのパワーを活用しながら、Shortcutsエコシステム全体とつながって、そのパワーと能力を倍増させることができます。
         ショートカットは、複数のアプリケーションのアクションを組み合わせることができるので、あなたが何もしなくても、ユーザーはまったく新しい機能や性能を生み出すことができます。
         自分のアクションを他のアプリケーションとうまく連携させ、このエコシステムにシームレスに適合させる方法については、私たちのデザイントークをご覧ください。
         App Intentsを構築する上で私たちが目指したのは、開発する喜びを感じられるようにすることでした。
         App Intentsは簡潔です。
         シンプルなインテントを書くには、数行のコードしか必要ありませんが、APIは、より深く、よりカスタマイズ可能なアクションに拡張することもできます。
         App Intentsは、モダンです。
         私たちは、結果ビルダー、プロパティラッパー、プロトコル指向プログラミング、そしてジェネリックスを活用し、Swift に全力を注いできました。
         これらの API は、最先端の言語機能なしには存在し得ません。
         App Intents を採用することは、製品やターゲットを再設計したり、フレームワークを作成したりする必要がないため、簡単でもあります。
         拡張機能を必要とせず、あなたのアプリですぐに採用できます。
         そして、App Intentsのコードは保守しやすい。
         SwiftUI のように、App Intents はあなたのコードを基本的な真実のソースとして使用し、個別のエディターや定義ファイルの必要性を回避しています。
         これは、あなたの採用を迅速に構築し、反復することができ、すべてが1つの場所に住んでいるので、メンテナンスを簡素化します。
         それでは、新しいフレームワークの中心的な構成要素であるインテントから、これらの新しいAPIを探ってみましょう。
         アプリのインテント（略して「インテント」）は、アプリがシステムに公開する、単一で分離された機能単位です。
         例えば、インテントは、新しいカレンダーイベントを作成したり、特定の画面を開いたり、注文をしたりすることができます。
         インテントは、ショートカットの実行やSiriへの問い合わせなど、ユーザーの要求に応じて実行することも、FocusフィルタやShortcutsオートメーションの使用など、自動的に実行することも可能です。
         インテントが実行されると、結果が返されるか、エラーが投げられるかのどちらかです。
         インテントには、ローカライズされたタイトルを含むインテントに関する情報であるメタデータ、インテントが実行されるときに使用できる入力であるパラメータ、インテントが実行されるときに実際の作業を行う実行メソッドの3つの主要な要素が含まれています。
         今日の出発点は、このLibraryアプリです。
         私は大の読書家なので、読んだ本、読みたい本、現在読んでいる本を追跡するためのものです。
         各カテゴリはアプリの別のタブに表示され、私はそれを「棚」と呼んでいます。
         私のユーザーは常に「現在読んでいる本」の棚を訪れるので、それを素早く便利に開くためのアプリを公開するつもりです。
         ここでは、AppIntentプロトコルに準拠したSwift構造体を定義して、OpenCurrentlyReadingインテントを作成することにします。
         私は、perform という 1 つのメソッドだけを実装する必要があります。
         私のアプリでは、タブを開くことができるナビゲーターを既に持っているので、私のためのインテントを実装するのは、ほんの数行のコードです。
         私のNavigatorはメインスレッドを想定しているので、performメソッドに@MainActorのアノテーションを付けます。
         私のインテントにはタイトルも必要です。
         今日お見せする他の文字列と同じように、文字列ファイルにキーを追加すれば、自動的にローカライズされるでしょう。
         基本的なアプリのインテントを動作させるために必要なことは、これだけです。
         このインテントをコードで定義すると、ショートカット・エディタに自動的に表示され、ユーザーはショートカットにこのインテントを追加できるようになります。
         このインテントを公開するだけで、大きな効果が得られます。いったん顧客がこのインテントをショートカットにすると、これらのすべての場所を含め、システム内の多くの場所から使用できるようになるからです。
         新しいインテントを使いやすく、発見しやすくするために、App Shortcutsのサポートも追加します。
         ちょっとしたコードで、SpotlightとShortcutsアプリケーションに私のインテントを自動的に表示させ、Siriに言ってこのインテントを音声で使えるようにするフレーズを定義することができます。
         詳しくは、「アプリのインテントを使ったショートカットの実装」セッションをご覧ください。
         ここまでで、「現在読んでいる本」の棚を開くインテントを公開しました。
         次に、これを一般化し、パラメータを追加して、どの棚も開くことができるようにしましょう。
         棚を表すenumがあります。
         これをインテント・パラメータとして使うには、AppEnumプロトコルに準拠させる必要があります。
         AppEnumはStringの生の値を必要とするので、まずそれを追加します。
         また、enumの各ケースについて、ローカライズ可能で人間が読めるタイトルを提供する必要があります。
         コンパイラはビルド時にこのコードを読むので、これらは辞書リテラルとして提供されなければならない。
         最後に、typeDisplayNameを追加する。これは、このenum型全体に対して、ユーザから見える、ローカライズ可能な名前である。
         ここでは "Shelf.
        " インテントでは、各パラメーターは @Parameter プロパティラッパーで宣言され、タイトルなどのパラメーターに関する情報で初期化されます。
         ここでは、新しい Shelf パラメータを定義し、perform メソッドでそれを読み込んでいます。
         パラメータは、数値、文字列、ファイルなど、すべての型をサポートし、アプリのエンティティや列挙型もサポートします。
         このインテントをショートカット・エディターで見ると、以下のようになります。
         シェルフパラメータがテーブルの行に表示されることに注意してください。
         ParameterSummary APIを使用することで、UIをより合理化し、Shortcutsにうまくフィットさせることができますね。
         ParameterSummaryは、インテントとそのパラメータをエディタで表現する文章で、例えば、"Open .
        " Shortcutsで最良の結果を得るためには、作成した全てのインテントに対して、常にParameter Summaryを提供する必要があります。
         また、どのパラメータを下に表示し、どれを非表示にするかを定義することもできます。
         これらの API は、When および Otherwise API、または Switch、Case、および Default API を使用して、インテントの任意のパラメータの実際の値に基づいてサマリーを変更するなど、非常にクールなことを行うことができます。
         パラメータのサマリーを追加するために、この静的プロパティを実装します。
         ここでは、文字列 "Open" を返し、shelf パラメータを補間します。
         Open Shelfを動作させるために最後に必要なことは、このようにインテントが実行されたときにLibraryアプリを開くようにすることです。
         アプリを開くかどうかは、openAppWhenRunという静的プロパティで制御します。
         デフォルトはfalseで、これはほとんどのインテントに適しています。
         しかし、このようにUIで何かを開くようなインテントでは、これをtrueに設定する必要があります。
         棚を開くインテントを作成しました。
         これは、棚のセットが固定されているため、非常にシンプルです。
         しかし、「本」を開くインテントを作成したい場合はどうでしょうか。「本」のセットは固定ではなく、動的なものです。そのためには、エンティティが必要です。
         エンティティは、アプリがApp Intentsに公開する概念です。
         NotesのノートやPhotosの写真やアルバムのように、値が動的、またはユーザー定義の場合は、enumの代わりにentityを使用する必要があります。
         エンティティのインスタンスを提供するために、アプリはクエリを実装し、インテントからの結果としてエンティティを返すことができます。
         まず、アプリで本を開くためのインテントを作成します。
         Shortcutsエディタでは、このように表示されるはずです。
         Bookパラメータをタップすると、本を選ぶためのピッカーが表示され、私のアプリが提供する推奨エンティティのセットも表示されます。
         また、ピッカーの上部にある検索フィールドで、自分のライブラリから任意の本を探すこともできます。
         インテントそのものを作成する前に、本のエンティティとそれに対応するクエリを作成する必要があります。
         エンティティには、少なくとも、識別子、表示表現、エンティティタイプ名の3つが含まれます。
         エンティティを追加するには、構造体をAppEntityプロトコルに準拠させることから始めます。
         ここでは、BookEntity 用に新しい構造体を定義しますが、モデルから既存の型を適合させることもできます。
         Identifiableプロトコルにエンティティを適合させることで、識別子を提供します。
         App Intentsは、この識別子を使用して、アプリとシステムの他の部分との間で渡されるエンティティを参照します。
         この識別子は、顧客によって作成されたショートカットに保存される可能性があるため、安定かつ永続的である必要があります。
         表示表現は、このエンティティをユーザーに表示するために使用します。
         これは、本のタイトルのような単純なテキスト文字列でもかまいません。
         また、サブタイトルや画像を提供することもできます。
         typeDisplayNameは、エンティティの種類を表す、人間が読める文字列です。
         この例では、"Book "です。
        " さて、book エンティティを完成させるために、クエリを追加する必要があります。
         クエリは、アプリからエンティティを取得するためのインターフェイスをシステムに提供します。
         クエリでは、いくつかの方法でエンティティを検索することができます。
         すべてのクエリで、識別子をもとにしたエンティティの検索が可能であることが必要です。
         文字列のクエリは、検索をサポートします。
         さらに、より柔軟なプロパティクエリもあります。
         また、すべてのクエリで、ユーザが一覧から選択できるようにするための提案エンティティを提供することができます。
         すべてのエンティティはクエリに関連付けられ、システムはそのエンティティのインスタンスを検索できるようにする必要がある。
         EntityQuery プロトコルに準拠した Swift の構造体を作成することで、クエリを提供します。
         基本的なクエリは、識別子の配列が与えられたエンティティを解決するために実装する、1つの必須のメソッドだけを持っています。
         私は、モデルデータベースに行き、それらの識別子に一致するすべての本を見つけることによって、これを実装しました。
         さて、このクエリをエンティティにフックする必要があります。
         これは、BookEntity 型の defaultQuery 静的プロパティを実装し、BookQuery のインスタンスを返すことで実現します。
         ユーザが本を選ぶと、その識別子がショートカットに保存されます。
         ショートカットを実行すると、App Intents はその識別子をクエリに渡し、BookEntity インスタンスを取得します。
         BookEntity タイプが AppEntity プロトコルに準拠するようになったので、OpenBook インテントのパラメータとして使用できるようになりました。
         perform メソッドでは、Navigator を使用して書籍にナビゲートします。
        ブックピッカーをサポートするために、私のクエリは、提案された結果も提供する必要があります。
         そのためには、Libraryアプリに追加されたすべての書籍を返す、もう1つのメソッドをqueryに実装する必要があります。
         Shortcutsは、これらの結果をピッカーに入力します。
         ShortcutsのUIには、上部に検索フィールドがあることに注目してください。
         私のアプリは多くの本の実体を持つ可能性があるので、本当はアプリのプロセスで、直接データベースに対して検索を実行するべきです。
         StringQuery APIを使えば、それが可能になります。
         StringQueryサブプロトコルを採用することで、もう一つ実装できるメソッドがある。文字列を指定して結果を返す、entities (matching string:) と呼ばれるメソッドだ。
         ここでは本のタイトルに対して大文字小文字を区別しない単純なマッチングを実装しているが、例えば著者名やシリーズ名から検索するような、よりファンシーなことも可能だ。
         巨大な本のリストと、小さなお気に入りのリストがある場合、suggestedEntitiesでお気に入りだけを返し、ユーザーが長いリストを検索できるように、エンティティ（マッチング文字列：）に依存することができます。
         今、私はアプリで本を開く方法を公開し、その過程で本のエンティティと本のクエリを作成しました。
         同じエンティティやクエリを使用して、さらに多くのインテントを作成することができます。
         次のタスクは、本をライブラリに追加するインテントを作成することです。
         お客様はシェアシートのショートカットを使ってオンラインで閲覧しながら素早く本を追加したり、HomePodのSiriに画面を見ずに「本を追加して」と伝えたりすることができます。
         このように、UIを表示せずにモデルを直接操作するインテントを構築することで、ユーザーの能力を高めることができます。
         以下は私のAddBookインテントの実装です。本のタイトルと、オプションで著者名をパラメータとして受け取ります。
         また、オプションでメモを追加し、どの友人がその本を勧めたかを記録します。
         performメソッドは、async/awaitを使ったAPIコールで本を検索してライブラリに追加します。
         一致するものが見つからない場合は、エラーを投げます。
         このエラーをローカライズするために、エラータイプをCustomLocalizedString ResourceConvertibleプロトコルに準拠させる。
         このプロパティからローカライズされた文字列キーを返し、そのキーを文字列ファイルに追加します。
         このAdd Bookインテントは、そのままでもSiriやウィジェットなど、非常に便利です。
         しかし、他のインテントと組み合わせることができれば、さらに柔軟性が高まります。
         少し手を加えるだけで、Add Bookインテントを、先ほど作成したOpen Bookインテントと組み合わせて、一方から他方へ結果を渡すことができるようになります。
         そのためには、Add Book インテントに結果の一部として値を返させるようにします。
         perform メソッドの戻り値の型に、値を表す新しいプロトコルが追加されたことに注目してください。
         これで、ユーザーはこのインテントの結果値を、本の実体をパラメータとして受け取る他のインテントに接続することができます。
         Add BookインテントとOpen Bookインテントはごく自然にペアになっているので、本を追加してすぐにライブラリで開くというショートカットを作ることができます。
         インテントから結果を返して、それをアプリで開くというのはよくあるパターンです。
         アプリのインテントには、openIntentと呼ばれるこれを表現する方法が組み込まれています。
         openIntentを追加すると、顧客はShortcutsに "Open When Run "という新しいスイッチを手に入れることになります。
        " このスイッチをオフにすると、このインテントをバックグラウンドでショートカットの一部として中断なく使用できるようになります。
         スイッチをオンにしたままにしておくと、新しく追加された本がすぐにライブラリアプリで開かれます。
         openIntentの採用は、Open Bookインテントのインスタンスを作成し、結果の一部として返すだけと簡単です。
         このインテントを実行するとき、Open When Runスイッチがオンになっていれば、Add Bookインテントが終了した後に、Open Bookインテントが自動的に実行されます。
         エンティティやクエリでできることは、まだまだたくさんあります。
         次のAPIセットでは、AppIntentsが、SiriKit Intentsフレームワークでは実現できなかった強力な能力を開放します。
         エンティティからより多くの情報を公開し、それを元に顧客が検索やフィルタリングを行えるようにする方法を見ていきましょう。
         これまで、私は本のエンティティに基本的な要件をすべて追加しました。
         しかし、人々が本をより深くショートカットに統合できるようにするために、本についてもう少し公開する必要があります。
         エンティティはプロパティをサポートしており、ユーザに公開したいエンティティに関する追加情報を保持します。
         この場合、本の著者、出版日、読了日、および推薦者を追加して、ショートカットでこれらのプロパティを使用できるようにします。
         BookEntityにプロパティを追加するには、@Propertyというプロパティラッパーを使用します。
         プロパティは、パラメータと同じタイプをすべてサポートし、各プロパティにはローカライズされたタイトルが付けられます。
         これらの新しいプロパティを使用すると、私の顧客は、本の実体を扱うときに、ショートカットでマジック変数を使用して、それぞれの新しい情報を引き出すことができるようになります 先の本の追加インテントを使用すると、ショートカットで、新しく追加した本の著者や出版日を使用することができます。
        プロパティとクエリを組み合わせると、アプリは自動的に、この柔軟な述語エディタUIを備えた、非常に強力な検索とフィルタアクションをショートカットで得ることができます。
         これで、私の顧客は、読んだ日付、タイトル、著者などに基づいて本を検索し、フィルタリングすることができるようになります。
         例えば、Delia Owensのすべての本を見つけるのは簡単です。
         並べ替えや制限のオプションを使えば、Delia Owensの最近出版された3冊の本を探すといった、より高度なクエリも可能です。
         顧客は、これらの構成要素を使用して、コレクションの中で最も一般的な3人の著者を見つけるような、非常にクールなことを行うことができます。
         これらを可能にするには、プロパティクエリという別の種類のクエリを採用する必要があります。
         プロパティクエリは、文字列や識別子に基づいてではなく、エンティティ内のプロパティに基づいてエンティティを検索します。
         プロパティクエリを実装するには、3つのステップがあります。
         まず、クエリプロパティを宣言します。これは、そのプロパティを用いてエンティティを検索する方法を指定するものです。
         そして、ソートオプションを追加します。これは、クエリの結果をどのようにソートするかを定義します。
         そして最後に、検索を実行するための entities(matching:) を実装します。
         クエリのプロパティは、AppIntentsがこのクエリに関連するエンティティを検索するためのあらゆる方法を宣言しています。
         それぞれ、エンティティのプロパティと、そのプロパティで利用可能な比較演算子（contains, equal to, less thanなど）をリストアップしている。
         ここでは、日付プロパティに対して "less than" と "greater than" の比較演算子を、タイトルプロパティに対して "contains" と "equal to" の比較演算子をリストアップしています。
         クエリー・プロパティは、プロパティとコンパレータの各組み合わせをコンパレータ・マッピング型と呼ばれる任意の型にマッピングする。
         ここでは、CoreDataを使用しているので、NSPredicateを使用します。
         もし、カスタムデータベースやREST APIを使っているのであれば、独自のコンパレータ型を設計して、それを代わりに使うことができる。
         以下は、私の本のクエリプロパティを設定するコードです。
         BooksQuery を EntityPropertyQuery プロトコルに適合させている。
         そして、QueryProperties 結果ビルダーを使って、静的 var プロパティを実装しています。
         各エントリでは、クエリ可能なプロパティのキーパスを指定し、その中で、そのプロパティに適用可能な各比較演算子を指定します。
         各比較子について、私はNSPredicateを提供します。なぜなら、私はNSPredicateを私の比較子マッピングタイプとして選択したからです。
         システムが私のアプリにクエリの結果を返すように要求すると、私がここで構築しているNSPredicateを返してきます。
         ソートについても同じような定義がある。
         これは、私のモデルが本を並べ替えることができるすべてのプロパティのリストである。
         この場合、タイトル、読んだ日付、出版された日付でソートすることができる。
         最後に、データベースに照会して一致するエンティティを返す entities(matching:) を実装しています。
         このメソッドは、先に定義したクエリーパラメーターで使ったコンパレーターマッピングタイプの配列、この場合は、NSPredicateを受け取ります。
         これらの述語は、私のエンティティのプロパティのどのような基準でクエリーを行いたいかを記述しています。
         また、"and "と "or "のどちらで述語を組み合わせるかを示すモード、ソートするキーパス、結果数の制限をオプションで受け取ります。
         私の実装では、これらのパラメータを使用して、CoreDataデータベースに対してクエリを実行します。
         このプロパティ・クエリで顧客は何ができるでしょうか？自分の図書館からランダムに本を選んで読むことができます。
         20世紀前半に出版されたすべての本を見つけることができます。
         Shortcutsのエコシステムを活用し、私のアプリを他のアプリと連携させ、より便利にすることができます。
         例えば、表計算アプリを使って、今年読んだ本をすべてCSVファイルに書き出すことができます。
         また、グラフアプリを使って、過去10年間に読んだ本の冊数をグラフ化することもできます。
         これはほんの始まりに過ぎません。
         このようなApp Intentsの深い導入により、顧客はアプリを使用して必要なことを行うことができ、ワークフローの重要な一部となります。
         これらの統合機能（たとえばグラフの作成など）は、それぞれあなたが構築する必要のない機能です。
         インテントが実行されるとき、アプリは、結果を表示したり話したり、Siriのリクエストやショートカットなど、あいまいさを解消するためにユーザーと対話する必要がある場合があります。
         App Intentsは、こうしたインタラクションを数多くサポートしています。インテントが完了したときにユーザーにテキストと音声のフィードバックを与えるためのダイアログや、視覚的なフィードバックを与えるためのスニペットです。
         インテント・パラメータの値を明確にするようユーザーに求めるためのリクエスト値や曖昧さ解消、トランザクションや破壊的なインテントについてパラメータ値を確認したりユーザーに確認したりするための確認などです。
         ダイアログは、インテントを実行する人に音声またはテキストによる応答を提供します。
         インテントを音声体験でうまく機能させるためには、ダイアログを提供することが本当に重要です。
         先ほどの Add Book インテントでは、本のタイトルを尋ねるときに話す needsValueDialog と、perform メソッドから返される結果ダイアログを追加しています。
         これらは、多くのプラットフォームでShortcutsやSiriによって読み上げられたり、表示されたりします。
         スニペットはダイアログの視覚的な表現と考えることができ、意図した結果に視覚的な表現を追加することができます。
         スニペットを使うには、インテントの結果に末尾のクロージャとして、選択したSwiftUIビューを追加するだけです。
         ウィジェットのように、SwiftUI ビューはアーカイブされ、ショートカットや Siri に送信されます。
         App Intents は、requestValue を投げてユーザーに値を要求することもサポートしています。
         たとえば、時々オプションであるパラメーターの値が必要なとき、これは便利です。
         ここでは、文字列検索で複数の本が返ってきたときにrequestValueが役に立ちます。
         この場合、本の検索を絞り込むために、著者を尋ねるようにしています。
         requestValueは私に投げられるエラーを提供し、それはユーザーに促し、更新された著者名でアクションを再実行します。
         一方、曖昧さ回避は、ユーザーがパラメータの値のセットから選択する必要がある場合に便利です。
         これにより、Add Bookアクションで複数の可能性のある結果を処理するための、より良い方法を得ることができます。
         ここでは、生成された書籍から著者名のリストを取得し、これらの可能性のある値で曖昧さ回避を要求します。
         ユーザーは、それらのどちらかを選ぶように求められ、私はその結果を返します。
         最後に、App Intentsは、2種類の確認をサポートしている。
         最初の種類は、パラメータ値の確認だ。
         これは、その値がどうあるべきかを推測しているが、念のため確認したいときに使うかもしれない。
         本を追加するときに、本のタイトルで検索するために呼び出したウェブサービスがいくつかのマッチを返すことがありますが、そのうちのひとつが圧倒的に人気があります。
         このような場合、ユーザーは人気のある本を追加しようとしたのだと仮定しますが、念のため確認を追加しておきます。
         そのために、title パラメータに対して requestConfirmation を呼び出すことにします。
         2つ目の種類は、インテントの結果を確認するものです。
         これは、たとえば注文をするときに便利です。
         図書館アプリを収益化し、書店での注文を追加する場合、注文が正しいかどうかを確認したいと思います。
         そのためには、インテントでrequestConfirmationを呼び出し、注文を渡します。
         ここでもスニペットを指定して、注文のプレビューを表示します。
         requestConfirmationはユーザーが確認せずにキャンセルするとエラーを投げるので、呼び出しの前に "try "を付けています。
         その前に、App Intents のアーキテクチャについて、いくつかの点を説明します。
         App Intents を構築するには、実は 2 つの方法があります: アプリ内または別の拡張機能内です。
         このうち、アプリ内に直接インテントを実装する方法が最もシンプルです。
         これは、フレームワークやコードの重複を必要とせず、プロセス間で調整する必要もないため、素晴らしいことです。
         また、アプリを使用することで、より高いメモリ制限と、オーディオの再生など、拡張機能では困難な作業を行うことができます。
         インテントにopenAppWhenRunを実装してtrueを返すようにすれば、アプリはフォアグラウンドで実行されるようになります。
         そうでない場合は、バックグラウンドで実行されます。
         バックグラウンドで実行する場合、パフォーマンスを最大化するために、アプリはシーンを表示せずに特別なモードで起動します。
         実際、アプリにバックグラウンドアプリインテントを実装する場合、シーンサポートも実装することを強くお勧めします。
         または、拡張機能でアプリインテントを構築することもできます。
         これには、いくつかの利点があります。
         拡張プロセスではアプリ・インテントのみを処理し、アプリをスピンアップする必要がないため、軽量化されます。
         Focus インテントを処理する場合、拡張機能を使用すると、Focus が変更されたときに、アプリをフォアグラウンドで実行する必要がなく、拡張機能ですぐにインテントを実行できるようになります。
         拡張機能は、新しいターゲットを追加し、コードをフレームワークに移動し、アプリと拡張機能の間の調整を処理する必要があるため、少し手間がかかります。
         App Intents拡張機能を作成するには、XcodeでFile > New Targetと進み、App Intents拡張機能を選択します。
         App Intentsでは、あなたのコードが唯一の真実の源となります。
         App Intents は、ビルド時にインテント、エンティティ、クエリ、およびパラメータに関する情報を静的に抽出することで、このエレガントな開発者体験を実現します。
         Xcode は、ビルドプロセス中に、アプリまたは拡張バンドル内にメタデータファイルを生成し、あなたのコード上で実行するときに Swift コンパイラから受け取った情報を含んでいます。
         このすべてが動作することを確認するために、フレームワークではなく、ターゲットまたは拡張機能で直接、App Intents の型を維持します。
         同様に、ローカライズされた文字列は、App Intents タイプがあるのと同じバンドル内の文字列ファイルにあるべきです。
         SiriKit Intents を持つ既存のアプリをアップグレードする場合、ウィジェットやメッセージング、メディアなどの領域と統合するための Intents を採用する場合は、SiriKit Intents フレームワークを使い続ける必要があります。
         しかし、Siriとショートカットのカスタムインテントを追加する場合は、App Intentsにアップグレードしてください。
         アップグレードプロセスは、SiriKit Intents定義ファイルの「Convert to App Intent」ボタンをクリックすることで開始することができます。
         アプリをApp IntentsでShortcutsに統合することは、App Intentsを採用するためのわずかな作業で、顧客にとって大きな価値を生み出すことができるため、開発者としての力を最大限に発揮できる方法です。
         ご参加ありがとうございました。ぜひ今日からApp Intentsを試していただき、フィードバックをいただければと思います。
         この新しいフレームワークが、あなたのアプリを使う人たちを驚かせたり、喜ばせたり、力を与えたりするのに役立つと思うとワクワクします。そして、あなたのWWDCが素晴らしいものになることを願っています。
        """
    }
}
