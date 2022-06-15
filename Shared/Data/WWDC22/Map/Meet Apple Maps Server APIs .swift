import Foundation

struct MeetAppleMapsServerAPIsArticle: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Meet Apple Maps Server APIs"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6495/6495_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10006/")!
    }

    var english: String {
        """
        Hi, everyone! My name is Ankur Soni.
        I'm an engineering manager on the Maps Services team here at Apple.
        Today, we're going to look at some exciting new capabilities coming to the Maps developer ecosystem.
        So let's get started.
        Our Maps app offers various end-user experiences to Apple customers around the globe.
        We empower developers to create beautiful geolocation experiences for their apps and websites through our MapKit and MapKit JS offerings.
        However, our Apple Maps developer offering has always been very client-centric.
        We have listened carefully to all your great feedback.
        You wanted a way to augment your own data on MapKit without compromising on performance or power.
        So to round out our ecosystem, we are excited to introduce the Apple Maps Server APIs.
        We are introducing four new server APIs: Geocoding, Reverse Geocoding, Search, Estimated Time of Arrival -- or ETA.
        These APIs will help you tackle a variety of use cases while integrating Maps into your applications.
        With Geocoding APIs, you can convert an address to geographic coordinates latitude and longitude.
        Similarly, with Reverse Geocoding, you can do the opposite -- go from geographic coordinates to an address.
        With Search API, you can give your users the capability to enter a search string to discover places like businesses, points of interest, and more.
        Maybe you want to overlay some of your own data and present it to the user.
        With ETA API, you can help your customers get a sense of how far your business is from them or do some computations to find the closest store.
        The possibilities are endless! We think you'll love server APIs for three important reasons.
        You can now deliver a seamless experience by leveraging MapKit, MapKit JS, and the new Apple Maps Server APIs.
        This will simplify your application architecture giving you a full Apple Maps stack.
        This will make your life much easier.
        For sure, it helped me.
        But hey, I'm biased! The next benefit is the reduction in network calls.
        Many times, we find ourselves in a situation where we are making repetitive and redundant requests from our users' devices like an iPhone, iPad, websites, etcetera.
        Maybe you are looking up the same address over and over again from your app running on different user devices.
        This causes a lot of network calls and wasted bandwidth.
        Delegating this common operation to your server and doing it only once in the back end using server APIs will help your application consume less bandwidth.
        A nice side effect of this is that now your application is power efficient too, since some processing is now delegated to your server using Apple Maps Server APIs.
        Now let's take some of these APIs for a spin.
        Let's say we are building these contact cards for your store locator application.
        Here we see three stores with their addresses and distance from the customer location.
        In this example, we'll assume that the customer has provided their location.
        For now, let's focus on building one of these contact cards.
        We'll assume that these addresses are on a server which stores and serves the locations of comic bookstores.
        There are many ways to build this, but for a second, let's assume we don't have these new server APIs.
        What would a basic architecture look like? How would your client application get this data? In this diagram, our application is making a call to the server to get the list of store addresses.
        The back-end server returns a list of store addresses to your client device.
        Since we don't have the server APIs in this example, now our client application has to perform various actions on the address to build the contact card.
        To perform a single task, a client may have to make multiple calls to various back-end services.
        Here you can see that the client app is making a call directly to the Apple Maps Server, either by using MapKit or MapKit JS.
        This chattiness between a client and a back end can adversely impact the performance and scale of the application.
        Over a cellular network with typically high latency, using individual requests in this manner is inefficient and could result in broken connectivity or incomplete requests.
        While each request may be done in parallel, the application must send, wait, and process data for each request all on separate connections increasing the chance of failure.
        Finally, you'll have to merge all the responses on the client.
        And while all these calls happen, you are showing a spinner to the user.
        Plus, the client device is using more bandwidth and power for these extra calls.
        That is not a good user experience.
        Now, let's look at a model architecture with access to Apple Maps Server APIs.
        You can start using your back-end server as a gateway to reduce chattiness between the client and the services.
        Just like before, here we request a list of stores to be displayed from your client.
        Next, we make a request from the server to do geocoding.
        We then receive responses for each API from the Apple Maps Server.
        The comic book server combines the responses from each service and sends the response to the application.
        This pattern can reduce the number of requests that the application makes to back-end services, and improve application performance over high-latency networks.
        In summary, your client makes one call to your server to get the list of stores.
        Your server then does the heavy lifting to make appropriate API calls to compose a response most suited for your user.
        So let's go back to our case study example here.
        We'll use Geocoding and ETA API to get the distance to the store.
        We can use the Geocode API to find the latitude and longitude for the store addresses, which we'll later use for ETA calculations.
        In this example, first, we are going to take the address for the comic book store and URL encode it.
        Next, we'll use the Geocode API and pass this URL-encoded address as a query parameter.
        We'll skip over the authentication details for now and come back to it in a few slides.
        In the response, you can see the latitude and longitude for the address returned.
        We'll repeat the same process to find the latitude and longitude for the customer's address.
        This will be later used for ETA calculations.
        As you can see, there are more fields in the response.
        I'll link the detailed documentation in the Resources section below.
        Now, we can set the origin and destination on the ETA API with the data we got from the Geocode API.
        As I mentioned before, we have the origin latitude, longitude and the destination latitude, longitude.
        We can specify up to 10 destinations here if needed.
        We'll feed that in the ETA API as origin and as destination query parameters which are URL encoded.
        The response to the API is a list of ETAs, one for each destination provided.
        In this case, we only have one since we provided one destination.
        Here for our example, we are interested in distanceMeters to calculate the distance to the store.
        With this, we have all the pieces we need: the store address and the distance for the user to reach your store.
        You can also choose to augment or overlay this data with your own store information, like store hours.
        In this way, you can leverage different server APIs to build your applications.
        For other APIs, please refer to documentation linked below this talk.
        One critical piece we haven't talked about is authentication.
        All the Apple Maps Server APIs are authenticated.
        If you are using MapKit JS, you are already halfway there.
        Apple Maps Server APIs use the same mechanism as MapKit JS to authenticate.
        First, you'll download your private key from your developer account.
        You'll then use this private key to generate a Maps auth token in JWT format.
        There is a detailed doc about how to generate one linked below.
        You can then exchange this Maps auth token using the token API to get Maps access token.
        We'll authenticate the Maps auth token on the back end and send back Maps access token.
        This is in JWT format and will be used for all API interactions.
        This access token needs to be refreshed every 30 minutes by repeating the highlighted process here.
        Now that we saw how the authentication flow looks like, here is a simple example of how to use the token API to fetch the access token.
        We are using the token API here.
        We are passing the Maps auth token as a header.
        You'll get back a Maps access token that can be used to access the API.
        This will be in JWT format and will have standard fields like expiry, issuedAt, etcetera.
        As a convenience, the expiresInSeconds field shows for how long the token is valid for.
        In this case, it's 30 minutes.
        Keep in mind Maps auth token is not the same as Maps access token.
        You exchange the Maps auth token to get a 30-minute long Maps access token to access the server APIs.
        Let's take a quick look at how the API interaction with Maps access token looks like.
        We'll pass the Maps access token along with server API call.
        It is added as a header to the API call, just like we saw a few slides ago.
        The Apple Maps Server will validate the Maps access token.
        Once the validation is successful, the Apple Maps Server will respond with an API response.
        Now that I have covered APIs and authentication, let me talk about usage limits.
        With great power comes great responsibility, so use your quota wisely.
        There is a daily cap on how many API calls you can make, and it's big! You'll get a quota of 25,000 service calls per day in total.
        Keep in mind, calling services via MapKit JS and server APIs use the same quota.
        If you need more, please reach out to us.
        So, how do you keep track of all this? You can view your usage stats at the Maps developer dashboard.
        Anybody using MapKit JS? This will look very familiar to you.
        The server API usage is categorized as Services, which you can see highlighted here.
        When the daily quota is exceeded, which means more than 25,000 server API calls, we'll start rejecting new service calls and respond with HTTP status 429, which means too many requests.
        You should make sure that the app experience degrades gracefully in such scenarios.
        In rare scenarios, when your service makes an unusual amount of requests -- maybe it's due to some bug in your code or infrastructure -- it's possible to get HTTP status 429 as well.
        When you receive HTTP 429, it is important not to simply loop repeatedly in making requests.
        A better approach is to retry with increasing delays in between attempts.
        This approach is known as exponential backoff.
        So, what did we learn today? We are releasing four new server APIs.
        These APIs are Geocoding, Reverse Geocoding, Search, and ETA.
        Using these APIs in conjunction with MapKit and MapKit JS will help you better architect your apps using the Apple Maps stack.
        You can optimize redundant and repetitive calls by delegating those tasks to your back-end server using Apple Maps Server APIs.
        Daily quota for these APIs is 25,000 and is shared with your MapKit JS service usage.
        And that's the new Apple Maps Server APIs for you.
        Be sure to check out the other sessions mentioned here and detailed documentation linked below.
        We look forward to seeing how you take advantage of them.
        Thank you!

        """
    }

    var japanese: String {
        """
        みなさん、こんにちは。私はアンクール・ソニです。
        Apple の Maps Services チームのエンジニアリング・マネージャーです。
        今日は、マップのデベロッパーエコシステムに登場するエキサイティングな新機能を見ていきましょう。
        では、始めましょう。
        Appleのマップアプリは、世界中のAppleユーザーにさまざまなエンドユーザーエクスペリエンスを提供しています。
        私たちは、MapKit と MapKit JS を通じて、デベロッパーがアプリとウェブサイトのために美しいジオロケーション・エクスペリエンスを作成できるよう支援しています。
        しかし、私たちのApple Mapsデベロッパー向けサービスは、常にクライアント中心で行われてきました。
        私たちは、皆様からの素晴らしいフィードバックに注意深く耳を傾けてきました。
        パフォーマンスやパワーを犠牲にすることなく、MapKit上で独自のデータを補強する方法を求めていたのです。
        そこで、私たちのエコシステムを完成させるために、Apple Maps Server APIsを導入することになりました。
        私たちは4つの新しいサーバAPIを導入します。ジオコーディング、リバースジオコーディング、検索、ETA（Estimated Time of Arrival：到着予定時刻）です。
        これらのAPIは、あなたのアプリケーションにマップを統合する際に、様々なユースケースに取り組むのに役立ちます。
        ジオコーディングAPIを使用すると、住所を地理座標の緯度と経度に変換することができます。
        同様に、Reverse Geocodingを使用すると、その逆、つまり地理座標から住所への変換を行うことができます。
        Search APIを使えば、ユーザーが検索文字列を入力して、ビジネスや観光スポットなどの場所を発見できるようになります。
        もしかしたら、あなた自身のデータをオーバーレイして、ユーザーに見せたいかもしれません。
        ETA APIを使えば、あなたの顧客があなたのビジネスからどれくらい離れているかを感じたり、最も近い店舗を見つけるためにいくつかの計算をするのを助けることができます。
        可能性は無限大です。サーバーAPIは、3つの重要な理由から、きっと気に入っていただけると思います。
        MapKit、MapKit JS、そして新しいApple Maps Server APIを活用することで、シームレスなエクスペリエンスを提供することができるようになりました。
        これにより、アプリケーションのアーキテクチャが簡素化され、Apple Mapsのフルスタックを利用できるようになります。
        これは、あなたの人生をはるかに容易にするでしょう。
        確かに、それは私を助けました。
        でも、私は偏見を持っています。次の利点は、ネットワークコールの削減です。
        iPhone、iPad、ウェブサイトなど、ユーザーのデバイスから繰り返し冗長な要求がなされる状況に陥ることはよくあります。
        もしかしたら、異なるユーザー端末で動作するアプリから、何度も同じアドレスを調べているかもしれません。
        これは、多くのネットワークコールと無駄な帯域幅を引き起こします。
        この一般的な操作をサーバーに委ね、サーバーAPIを使ってバックエンドで一度だけ行うようにすれば、アプリケーションが消費する帯域幅を少なくすることができます。
        さらに、Apple Maps Server APIを使用して一部の処理をサーバーに委ねることで、アプリケーションの電力効率も向上します。
        では、これらのAPIのいくつかを使ってみましょう。
        例えば、店舗検索アプリケーション用に連絡先カードを作成するとします。
        ここでは、3つの店舗とその住所、および顧客所在地からの距離を示しています。
        この例では、顧客が自分の場所を提供したと仮定します。
        ここでは、これらの連絡先カードのうちの1つを作成することに集中しましょう。
        ここでは、これらの住所は、コミック書店の所在地を保存して提供するサーバー上にあると仮定します。
        これを構築する方法はたくさんありますが、ちょっとだけ、これらの新しいサーバーAPIがないと仮定してみましょう。
        基本的なアーキテクチャはどのようなものになるでしょうか。クライアントアプリケーションは、どのようにしてこのデータを取得するのでしょうか？この図では、アプリケーションがサーバーを呼び出して、店舗の住所のリストを取得しています。
        バックエンドのサーバーは、店舗アドレスのリストをクライアントデバイスに返します。
        この例ではサーバーのAPIがないので、今度はクライアントアプリケーションが住所に対してさまざまなアクションを実行して連絡先カードを作成する必要があります。
        ひとつのタスクを実行するために、クライアントはさまざまなバックエンド・サービスを複数回呼び出さなければならないかもしれません。
        ここでは、クライアントアプリが MapKit または MapKit JS を使って、Apple Maps Server に直接コールしていることがわかります。
        クライアントとバックエンドの間のこのようなおしゃべりは、アプリケーションのパフォーマンスとスケールに悪影響を及ぼします。
        一般的にレイテンシーの高い携帯電話ネットワーク上では、この方法で個々のリクエストを使用することは非効率的であり、接続の中断や不完全なリクエストにつながる可能性があります。
        各リクエストは並行して実行されるかもしれませんが、アプリケーションは各リクエストのデータを別々の接続で送信、待機、処理しなければならず、障害の可能性が高くなります。
        最後に、クライアント側ですべてのレスポンスをマージする必要があります。
        そして、これらの呼び出しが行われている間、ユーザーにはスピナーが表示されます。
        さらに、クライアントデバイスは、これらの余分な呼び出しのために、より多くの帯域幅と電力を使用することになります。
        これは良いユーザーエクスペリエンスとは言えません。
        さて、Apple Maps Server APIにアクセスするモデル・アーキテクチャを見てみましょう。
        クライアントとサービス間のチャットを減らすために、バックエンドサーバをゲートウェイとして使い始めることができます。
        先ほどと同じように、ここではクライアントから表示する店舗のリストをリクエストします。
        次に、サーバーからジオコーディングを行うためのリクエストを行います。
        そして、Apple Maps Serverから各APIのレスポンスを受け取ります。
        コミックサーバーは、各サービスからのレスポンスを組み合わせて、アプリケーションに送信します。
        このパターンは、アプリケーションがバックエンド・サービスに行うリクエストの数を減らし、遅延の大きいネットワーク上でアプリケーションのパフォーマンスを向上させることができます。
        要約すると、クライアントはサーバーに1回だけ電話をかけて、ストアのリストを取得します。
        その後、サーバーは適切なAPIコールを行い、ユーザーに最も適したレスポンスを作成するための重い作業を行います。
        さて、ここでケーススタディの例に戻ってみましょう。
        店舗までの距離を取得するために、GeocodingとETA APIを使用することにします。
        Geocode APIを使って店舗の住所の緯度と経度を求め、後でETAの計算に使うことができるのです。
        この例では、まず漫画喫茶の住所を取得し、URLエンコードします。
        次に、Geocode APIを使用して、このURLエンコードされた住所をクエリパラメータとして渡します。
        認証の詳細については省略し、いくつかのスライドで説明します。
        レスポンスの中で、返された住所の緯度と経度を見ることができます。
        同じプロセスを繰り返して、顧客の住所の緯度と経度を求めます。
        これは後でETAの計算に使用されます。
        ご覧のように、レスポンスにはもっと多くのフィールドがあります。
        以下のリソースセクションに詳細なドキュメントをリンクしておきます。
        さて、Geocode APIで取得したデータを使って、ETA APIで出発地と目的地を設定することができます。
        先ほども書きましたが、出発地の緯度・経度、目的地の緯度・経度を用意します。
        必要に応じて、ここで目的地を10件まで指定することができます。
        これをETA APIのクエリパラメータとして、URLエンコードしたものを送り込みます。
        APIへの応答はETAのリストであり、指定された目的地ごとに1つずつある。
        この場合、目的地は1つなので、1つだけです。
        この例では、店舗までの距離を計算するためにdistanceMetersに注目しています。
        これで、店舗の住所と、ユーザーが店舗に到達するまでの距離という、必要なものがすべて揃いました。
        また、このデータに、営業時間などの独自の店舗情報を追加したり、重ね合わせたりすることもできます。
        このように、さまざまなサーバーAPIを活用して、アプリケーションを構築することができます。
        他のAPIについては、この講演の下にリンクされているドキュメントを参照してください。
        もう一つ重要なのは、認証についてです。
        Apple Maps Server APIはすべて認証されています。
        もしあなたがMapKit JSを使っているのなら、すでにその半分を利用していることになります。
        Apple Maps Server APIは、MapKit JSと同じ仕組みで認証を行います。
        まず、デベロッパーアカウントから秘密鍵をダウンロードします。
        次に、この秘密鍵を使ってJWT形式のMaps authトークンを生成します。
        生成方法については、以下のリンクに詳細なドキュメントがあります。
        このMaps認証トークンをトークンAPIで交換し、Mapsアクセストークンを取得することができます。
        バックエンドでMaps認証トークンを認証し、Mapsアクセストークンを送り返す。
        これは JWT 形式で、すべての API インタラクションに使用されます。
        このアクセストークンは30分ごとに更新する必要があり、ここでハイライトした処理を繰り返します。
        さて、認証フローがどのように見えるかを見てきましたが、ここではトークンAPIを使用してアクセストークンを取得する方法を簡単に説明します。
        ここでは、トークンAPIを使用しています。
        ヘッダーとしてMapsの認証トークンを渡しています。
        APIにアクセスするために使用できるMapsアクセストークンが戻ってきます。
        これはJWT形式で、expiry、issuedAtなどの標準的なフィールドを持っています。
        便利なことに、expiresInSecondsフィールドは、トークンがどのくらいの期間有効かを示しています。
        この場合、30分です。
        Maps auth tokenはMapsアクセストークンと同じではないことに注意してください。
        サーバーAPIにアクセスするためには、Maps auth トークンを交換して、30分間有効なMapsアクセストークンを取得する必要があります。
        Mapsアクセストークンを使ったAPIのやり取りがどのようなものか、簡単に見てみましょう。
        サーバーAPIの呼び出しと一緒に、Mapsアクセストークンを渡します。
        これは、数枚前のスライドで見たのと同じように、APIコールのヘッダーとして追加されます。
        Apple Mapsサーバーは、Mapsアクセストークンを検証する。
        検証が成功すると、Apple Maps ServerはAPIレスポンスで応答する。
        さて、APIと認証について説明しましたが、次に使用制限について説明します。
        大きな力には大きな責任が伴いますので、賢く使用量を制限してください。
        APIを呼び出す回数には1日あたりの上限があり、それはとても大きなものです。1日あたり25,000のサービスコールが上限です。
        MapKit JSとサーバーAPIを経由してサービスを呼び出すと、同じクォータを使用することに留意してください。
        それ以上必要な場合は、私たちに連絡してください。
        では、どのようにこれらを把握するのでしょうか？Map開発者ダッシュボードで使用状況の統計を見ることができます。
        MapKit JSを使っている人はいますか？これはあなたにとって非常に見慣れたものになるでしょう。
        サーバーAPIの使用は、ここにハイライトされているように、サービスに分類されています。
        1日のクォータを超えた場合、つまりサーバーAPIの呼び出しが25,000回を超えた場合、新しいサービスの呼び出しを拒否するようになり、HTTPステータス429（要求が多すぎることを意味する）で応答するようになります。
        このようなシナリオでは、アプリのエクスペリエンスが優雅に低下することを確認する必要があります。
        まれに、サービスが異常な量のリクエストを行う場合（コードやインフラのバグが原因かもしれません）、HTTPステータス429を受け取ることもありえます。
        HTTP 429 を受け取った場合、単純にリクエストを繰り返しループさせないことが重要です。
        より良い方法は、再試行の間隔を徐々に長くしていくことです。
        この方法は、指数関数的バックオフとして知られています。
        さて、今日は何を学んだのでしょうか？私たちは、4つの新しいサーバーAPIをリリースします。
        これらのAPIは、ジオコーディング、リバースジオコーディング、サーチ、そしてETAです。
        これらのAPIをMapKitとMapKit JSと一緒に使うことで、Apple Mapsスタックを使ったアプリをよりよくアーキテクトすることができるようになります。
        Apple Maps Server APIを使用してバックエンドサーバーにこれらのタスクを委任することで、冗長で繰り返しの多い呼び出しを最適化できます。
        これらのAPIの1日の割り当て数は25,000で、MapKit JSのサービス使用量と共有されます。
        以上が、新しいApple Maps Server APIsの説明です。
        ここで紹介した他のセッションや、以下のリンク先の詳細なドキュメントをぜひご覧ください。
        どのように活用されるか楽しみです。
        ありがとうございました。
        """
    }
}

