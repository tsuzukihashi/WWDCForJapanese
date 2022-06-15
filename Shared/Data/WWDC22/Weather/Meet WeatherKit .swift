import Foundation

struct MeetWeatherKitArticle: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Meet WeatherKit"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6492/6492_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10003/")!
    }

    var english: String {
        """
        Welcome to "Meet WeatherKit" at WWDC22.
         My name is Novall, and I'm an engineer on the Weather team.
         We rely on weather data day in and day out, and where we get this information is important.
         From checking the weather on your Apple Watch so you know to bring an umbrella with you before you head out the door, to sustainable agriculture where predicting rain and frost can help farmers plan crop rotation, to staying safe and prepared for winter storm travel -- weather impacts everyone.
         Accurate weather data has become even more critical in today's world affected by our changing climate.
         And having access to accurate forecasts is important now more than ever, which is why we created WeatherKit.
         WeatherKit is powered by the all-new Apple Weather Service, a world-class global weather forecast.
         It uses high-resolution weather models and machine learning and prediction algorithms to give you hyperlocal weather forecasts around the globe.
         With Apple Weather Service, we have access to a lot of data, and all of this is available to you through WeatherKit.
         Accurate weather data requires location information.
         And keeping that data private is a shared responsibility.
         In keeping with our commitment to privacy, WeatherKit is designed to give hyperlocal forecasts without compromising user information.
         Location is used only to provide weather forecasts and is not associated with any personally identifying information and is never shared or sold.
         With WeatherKit, we've made it easy for you to protect user privacy.
         Today I will be diving into more detail about WeatherKit so you can get the most out of our new API.
         First, I'll cover the available data sets we offer through WeatherKit, backed by our own Apple Weather Service.
         Next, I'll show you how to request weather information using the WeatherKit framework and a REST API designed so you can get weather data on any platform.
         And finally, I'll cover some additional implementation requirements and best practices.
         Let me start with an overview of the available weather data sets.
         As I mentioned, you have access to a lot of data in WeatherKit.
         So let's talk about each data set.
         The current weather data set describes the "now" conditions at the requested location.
         It represents a single point in time and includes conditions like UV index, temperature, and wind.
         The minute forecast contains minute-by-minute precipitation conditions for the next hour, where available.
         This data set is useful for deciding whether or not to bring an umbrella with you as you walk out the door.
         The hourly forecast is a collection of forecasts starting on the current hour and provides data for up to 240 hours.
         Each hour in the hourly forecast includes conditions like humidity, visibility, pressure, and dew point.
         The daily forecast contains a forecast collection of 10 days.
         Each day in the daily forecast provides information about the entire day, like the high and low temperature, sunrise, and sunset.
         Weather alerts contains severe weather warnings issued for the requested location.
         This data set contains important information to keep your users safe, informed, and prepared.
         And finally, historical weather provides saved weather forecasts from the past, so you can see trends in weather data.
         You can access historical data by specifying a start and end date to the hourly and daily requests.
         This gives you access to a lot of data.
         We think there are a lot of important and impactful ways you can use historical weather.
         Now that you've seen all of the rich weather data available, I'll walk you through how to request this weather data with the WeatherKit APIs.
         Apple Weather data is available through both a native framework and a set of REST APIs.
         First, let me show you how easy it is to access weather data with our Swift framework.
         All it takes is a few lines of code.
         And with Swift Concurrency, requesting weather is simple.
         First, you'll import WeatherKit and CoreLocation.
         Then you'll create a weatherService object, as your entry point for the Weather Service.
         You'll create a CLLocation with coordinates for your location of interest.
         Here, I'm using my hometown of Syracuse, New York.
         Then you’ll call weather(for:) on the weatherService instance and pass in the location created above.
         When the call completes, you can access the relevant data you need for your app, like the current temperature and UV Index in this example.
         Now that I've shown you how easy it is to request weather data with Swift, let me take you through another example I'm using a travel app that I'm building in SwiftUI.
         You can grab the completed project from the link associated with this session.
         Since I'm really looking forward to traveling again, I've decided to create a flight planner app to plan my next trip.
         I've already created the logic for my flight itinerary, but when I tap on each of the flights in my trip, I want to show columns containing the condition, precipitation, wind, and temperature at each destination.
         First step is to enable WeatherKit.
         Register the App ID in the Developer Portal, then select the Capability and App Services t abs to enable WeatherKit.
         Then in Xcode, add the WeatherKit capability to the project.
         With that prep out of the way, let me walk through how I'll get the weather data for each of these locations.
         Here I have an Airport struct already set up that contains the latitude and longitude of my destination airports.
         I'll get the hourly forecast by calling weather(for:) on our shared weather service and then pass in our airport location.
        Because I just want a subset of data, I've also specified to include the hourly forecast in the request.
         Now, I'll build and run my app.
        Now I can see my custom view updated to display the conditions at each airport.
         The next thing I need to do while building this app is to display attribution for the data sources in my app.
        First, I'll get the attribution URL from the attribution.
        legalPageURL property.
         This is a link to the legal attribution page that contains copyright information about the weather data sources.
         I'll also need to get the URL for the combined Apple Weather mark.
        It's available in both light and dark variants, so I'll check the colorScheme environment value to find out if the SwiftUI view is currently displaying in light or dark appearance.
         Finally, I'll build and run again.
        Note that the Apple Weather mark and attribution link opens in an SFSafariViewController.
         That's all it takes to get the weather for our flight planner app, and there are so many ways you can use the WeatherKit API to add weather data to your apps.
         But that was only the native framework.
         The REST API provides the same rich weather data as the Swift framework and can be used on any platform.
         In this example, I'm showing how you can request weather alerts from the weatherkit.apple.com endpoint.
         First, you request an auth token.
         I'll discuss that more in a bit.
         Then, to get the weather object, you first create a URL indicating the desired weather data set for a given location.
         Be sure to set the appropriate language for a localized response.
         Then, provide the latitude and longitude of the location of interest.
         Indicate the desired data set.
         You may notice this parameter is plural so you can request several at once by separating each with a comma.
         And finally, the country code for the requested location.
         But note, the country code is only required if you're requesting the weather alerts data set.
         Next, you'll fetch the weather data using the URL and your auth token from above, converting the results to JSON.
         With that, you can access the weather alerts and their details.
         So again, another example of how easy it is for you to access weather data, only this time through REST.
         To go into more depth about the setup you need, let's revisit auth.
         For the WeatherKit REST API, there are a few additional steps to handle authentication.
         In the Developer Portal, you'll enable access for WeatherKit requests by creating an authentication key enabled for WeatherKit and an associated services ID.
         The private key can be created in the Keys section of the Developer Portal.
         WeatherKit requires tokens to validate authorization on each request.
         So on your server, you'll deploy a token service for creating a signed JSON web token using your private key.
         For those familiar with JSON web token authentication, this is a fairly standard authorization flow, but let me share some details in case this is your first time working with it.
         To generate a signed token you'll create the header containing the fields and values described in the developer documentation.
         Then create the payload containing the information specific to the WeatherKit REST API and your application, including items such as the issuer, subject, and expiration time.
         And finally, you'll sign the token for use with a subsequent call to the WeatherKit REST API.
         Going back to my weather alerts example, here's where you'll request the token from your signing service, and add the token to the Authorization header of your HTTP request for weather data.
         So that's the WeatherKit REST API.
         One of two great ways for you to access weather data from the Apple Weather Service.
         Lastly, I'll cover a few additional requirements for publishing on the App Store or before you go live on any platform using the REST API.
         Each of these requirements apply regardless of whether you're using the native Swift or REST APIs.
         The first requirement is attribution.
         As you saw in my demo, you'll get a link from our Attribution API which you'll need to display in your native or web app.
         The second requirement is an attribution logo.
         The WeatherKit API makes this easy and convenient by providing the image assets you need to display in your app.
         And finally, if you'll be displaying weather alerts, you'll also need to link to an event page provided in the response.
         So that's how easy it is to prepare your app for publication on the App Store or the web.
         So that's WeatherKit -- hyperlocal forecasts powered the Apple Weather Service accessible through our Swift framework and our REST API.
         Both open up a world of possibilities for you to use weather data in your apps, on any platform or device.
         We hope you enjoyed this session.
         Besides checking out the links associated with this session, read the docs and download the project.
         And of course, we'd love your feedback.
         We can't wait to see all of the creative and impactful ways you use WeatherKit.
         Thank you and have a great WWDC!

        """
    }

    var japanese: String {
        """
        WWDC22の "Meet WeatherKit "へようこそ。
         私はNovallといい、Weatherチームのエンジニアです。
         私たちは日々、気象データを頼りにしていますが、この情報をどこで入手するかが重要です。
         Apple Watchで天気をチェックして、出かける前に傘を持っていくことを確認したり、雨や霜を予測することで農家の輪作計画に役立てたり、冬の嵐に備えて安全に旅行したりと、天気はすべての人に影響を与えています。
         気候変動の影響を受ける現代社会では、正確な気象データがより重要となってきています。
         そして、正確な予報にアクセスできることはこれまで以上に重要であり、そのために私たちはWeatherKitを作りました。
         WeatherKitは、世界トップクラスのグローバルな天気予報である、まったく新しいApple Weather Serviceを搭載しています。
         高解像度の気象モデルと機械学習および予測アルゴリズムを使って、世界中のハイパーローカルな天気予報を提供します。
         Apple Weather Serviceによって、私たちはたくさんのデータにアクセスできるようになり、そのすべてがWeatherKitを通じて利用できるようになりました。
         正確な気象データには位置情報が必要です。
         そしてそのデータをプライベートに保つことは、私たちの共通の責任です。
         プライバシーに対する私たちのコミットメントに基づき、WeatherKit はユーザー情報を損なうことなくハイパーローカルな予報を提供するよう設計されています。
         位置情報は天気予報を提供するためにのみ使用され、個人を特定する情報とは関連付けられず、共有や販売されることはありません。
         WeatherKitでは、ユーザーのプライバシーを簡単に保護できるようにしました。
         今日は、私たちの新しい API を最大限に活用できるように、WeatherKit についてより詳しく掘り下げていきます。
         まず、Apple Weather Serviceに支えられたWeatherKitで利用可能なデータセットについて説明します。
         次に、WeatherKitフレームワークと、あらゆるプラットフォームで気象データを取得できるように設計されたREST APIを使って、気象情報を要求する方法を説明します。
         そして最後に、その他の実装要件とベストプラクティスについて説明します。
         まず、利用可能な気象データセットの概要から説明します。
         先ほど述べたように、WeatherKit では多くのデータにアクセスすることができます。
         そこで、各データセットについて説明します。
         現在の天気データセットは、要求された場所の「今」の状態を記述しています。
         これはある一点を表しており、紫外線指数、気温、風などの条件が含まれています。
         分予報には、今後1時間の分単位の降水状況が含まれます（可能な場合）。
         外出時に傘を持っていくかどうかの判断に役立ちます。
         時間予報は、現在の時間から始まり、最大240時間分のデータを提供する予報の集合体である。
         時間予報の各時間には、湿度、視程、気圧、露点などの条件が含まれています。
         日別予報は、10日分の予報を集めたものです。
         日ごとの予報では、最高気温、最低気温、日の出、日の入りなど、その日一日に関する情報を提供します。
         気象警報には、要求された場所に対して発行された厳しい気象警報が含まれています。
         このデータセットには、ユーザーの安全、情報、備えを維持するための重要な情報が含まれています。
         最後に、履歴天気は、過去に保存された天気予報を提供するため、天気データの傾向を確認することができます。
         1時間ごと、1日ごとのリクエストに開始日と終了日を指定することで、過去のデータにアクセスすることができます。
         これで、多くのデータにアクセスできるようになりました。
         このように、過去の気象データを利用することで、重要かつインパクトのある使い方ができると考えています。
         さて、利用可能な豊富な気象データをすべて見ていただいたので、この気象データをWeatherKit APIでリクエストする方法を説明します。
         Apple Weather のデータは、ネイティブ フレームワークと一連の REST API の両方を通じて利用できます。
         まず、Swift フレームワークで天気データにアクセスするのがいかに簡単かをお見せしましょう。
         必要なのは、数行のコードだけです。
         そして Swift Concurrency を使えば、天気をリクエストするのも簡単です。
         まず、WeatherKit と CoreLocation をインポートします。
         それから、Weather Service のエントリポイントとして、weatherService オブジェクトを作成します。
         CLLocationオブジェクトを作成し、関心のある場所の座標を指定します。
         ここでは、私の故郷であるニューヨーク州シラキュースを使っています。
         そして、weatherServiceインスタンスでweather(for:)を呼び出し、上で作成したロケーションを渡します。
         呼び出しが完了すると、アプリに必要な関連データにアクセスできます。この例では、現在の気温やUVインデックスが表示されています。
         Swift で気象データを要求するのがいかに簡単かをお見せしたところで、SwiftUI で構築している旅行アプリを使った別の例をお見せしましょう。
         このセッションに関連するリンクから、完成したプロジェクトを手に入れることができます。
         私は再び旅行することを本当に楽しみにしているので、次の旅行を計画するためにフライトプランナーアプリを作成することにしました。
         フライトの旅程のロジックはすでに作ってあるのですが、旅の中の各フライトをタップしたときに、各目的地のコンディション、降水量、風、気温を含むカラムを表示したいのです。
         まずは、WeatherKitを有効にします。
         開発者ポータルでApp IDを登録し、Capability and App Services t absを選択して、WeatherKitを有効にします。
         そして、Xcodeで、プロジェクトにWeatherKitのケイパビリティを追加します。
         それでは、それぞれの場所の天気データをどのように取得するかを説明します。
         ここでは、目的地の空港の緯度と経度を含むAirport構造体がすでにセットアップされています。
         共有気象サービスのweather(for:)を呼び出して毎時の天気予報を取得し、空港の位置を渡します。
        私はデータのサブセットが欲しいだけなので、リクエストに毎時の予報を含めるように指定しました。
         さて、アプリをビルドして実行します。
        これで、カスタムビューが更新され、各空港の状況が表示されるのがわかります。
         次に、このアプリを構築する際に必要なことは、アプリ内のデータソースのアトリビューションを表示することです。
        まず、attribution.legalPageURLプロパティからattribution URLを取得します。
        legalPageURLプロパティから取得します。
         これは、気象データ ソースの著作権情報を含む法的帰属ページへのリンクです。
         Apple Weatherのマークを組み合わせたURLも取得する必要がありますね。
        これはライトとダークの両方のバリエーションがあるので、SwiftUIビューが現在ライトまたはダークの外観で表示されているかどうかを見つけるためにcolorScheme環境値をチェックします。
         最後に、もう一度ビルドして実行してみます。
        Apple Weatherマークとアトリビュートリンクは、SFSafariViewControllerで開くことに注意してください。
         これだけで、フライトプランナーアプリの天気を取得することができます。WeatherKit API を使用して、アプリに天気データを追加する方法は非常に多くあります。
         しかし、これはネイティブ フレームワークだけでした。
         REST API は Swift フレームワークと同じ豊富な気象データを提供し、あらゆるプラットフォームで使用できます。
         この例では、weatherkit.apple.com のエンドポイントから天気予報を要求する方法を示しています。
         最初に、認証トークンを要求します。
         これについては後ほど詳しく説明します。
         次に、天気オブジェクトを取得するために、まず指定した場所の天気データセットを示す URL を作成します。
         ローカライズされたレスポンスのために適切な言語を設定することを忘れないでください。
         次に、関心のある場所の緯度と経度を指定します。
         希望するデータセットを指定します。
         このパラメータは複数あるので、コンマで区切ることで一度に複数のデータセットをリクエストすることができます。
         最後に、希望する場所の国番号。
         ただし、国番号は天気予報のデータセットを要求する場合のみ必要です。
         次に、上記のURLと認証トークンを使用して天気データを取得し、その結果をJSONに変換します。
         これで、天気予報とその詳細情報にアクセスできるようになります。
         このように、RESTを使用することで、天気データに簡単にアクセスできることがわかります。
         必要な設定についてより深く掘り下げるために、認証について再考してみましょう。
         WeatherKit REST API では、認証を処理するためにいくつかの追加手順があります。
         Developer Portal では、WeatherKit 用に有効な認証キーと関連するサービス ID を作成することで、WeatherKit リクエストに対するアクセスを有効にすることになります。
         秘密鍵は、Developer Portal の Keys セクションで作成することができます。
         WeatherKit は各リクエストで認証を検証するためにトークンを必要とします。
         そこで、サーバ上に、秘密鍵を使って署名付き JSON ウェブ トークンを作成するためのトークン サービスをデプロイすることになります。
         JSON ウェブ トークン認証に慣れている方にとっては、これはごく標準的な認証フローですが、初めて扱う方のために詳細を説明します。
         署名付きトークンを生成するには、開発者向けドキュメントに記載されているフィールドと値を含むヘッダーを作成します。
         次に、WeatherKit REST API とあなたのアプリケーションに固有の情報（発行者、サブジェクト、有効期限など）を含むペイロードを作成します。
         そして最後に、次回以降の WeatherKit REST API の呼び出しで使用するために、トークンに署名を行います。
         天気予報の例に戻ると、ここで署名サービスからトークンを要求し、天気データの HTTP 要求の Authorization ヘッダーにトークンを追加することになります。
         これが WeatherKit REST API です。
         Apple Weather Serviceの気象データにアクセスするための2つの素晴らしい方法のうちの1つです。
         最後に、App Store で公開する場合、または REST API を使用して任意のプラットフォームで公開する前に必要な追加要件をいくつか説明します。
         これらの各要件は、ネイティブの Swift API と REST API のどちらを使用しているかに関係なく適用されます。
         最初の要件は、帰属表示です。
         私のデモで見たように、あなたはアトリビューション API からリンクを取得し、ネイティブまたはウェブアプリで表示する必要があります。
         2つ目の要件は、アトリビューション・ロゴです。
         WeatherKit APIは、アプリで表示するために必要な画像アセットを提供することで、これを簡単かつ便利にしています。
         そして最後に、天気予報のアラートを表示する場合は、レスポンスで提供されるイベント・ページへのリンクも必要です。
         このように、App StoreやWebで公開するためのアプリを簡単に準備することができます。
         これがWeatherKitです。Apple Weather Serviceが提供するハイパーローカルな天気予報に、SwiftフレームワークとREST APIを通じてアクセスすることができます。
         この 2 つは、あらゆるプラットフォームやデバイスのアプリで気象データを利用するための可能性を開くものです。
         このセッションを楽しんでいただければ幸いです。
         このセッションに関連するリンクをチェックするほかに、ドキュメントを読み、プロジェクトをダウンロードしてください。
         そしてもちろん、フィードバックもお待ちしています。
         皆様のクリエイティブでインパクトのあるWeatherKitの使い方を拝見するのが楽しみです。
         それでは、良いWWDCをお過ごしください。

        """
    }
}

