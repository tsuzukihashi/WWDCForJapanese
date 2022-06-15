import Foundation

struct DeliverReliableStreamsWithHLSContentSteering: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Deliver reliable streams with HLS Content Steering"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6642/6642_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10144/")!
    }

    var english: String {
        """
        Zheng Naiwei: Hello and welcome to WWDC.
         My name is Zheng Naiwei from Apple's AVFoundation Team.
         In this session we are going to talk about how to improve streaming delivery reliability with new features we added to HLS Content Steering.
        We will cover three topics today.
         If you haven't heard of Content Steering, don't worry.
         It's a piece of HLS technology that can dynamically steer streaming traffic, to improve streaming service quality.
         I will give you a short review to help you get on track.
        Then I will present the new Pathway cloning feature, which can bring dynamic steering ability beyond limits, to further improve the reliability of your streaming service.
        Finally, I will use concrete examples to guide you through how to influence server-side logic for steering traffic.
         Let's wait no more and get started.
        Back in the time we don't have Content Steering, variant selection in case of error fallback wasn't standardized in the HLS specification.
         And different client implementations can behave differently in choosing the next fallback variant.
         But a typical way to do this is to follow the variant ordering in the multivariant playlist.
        If a streaming provider wants to specify a set of fallback CDNs, they need to list every variant from every CDN and properly order them in the multivariant playlist.
         This way, in case the client player encountered a failure in the first variant, it can move on to the next variant in the playlist with the failed variant penalized from selection.
         In this case, we see that the client player had trouble with the 6 Mbps variant from CDN1 and thus moved on to the next 3 Mbps variant from CDN1, following the order in the multivariant playlist.
         If unfortunately the 3 Mbps variant from CDN1 also failed, the client player would be left with no variants from CDN1, and move on to the 6 Mbps variant from CDN2.
         It can do this on and on until no variant to fallback to.
         However, even though the playlist authoring server can control the ordering of the fallback variants, such control only happens at the point of client requesting the multivariant playlist, and once the playlist was handed out, there's no way to change the fallback ordering.
         This is where Content Steering comes into the picture.
         With Content Steering, the streaming provider can now group variants into Pathways with different CDN hosts.
        The error fallback behavior is now standardized for Content Steering.
         Pathways are ordered by preference.
         In this example, the CDN1 Pathway at the top is most preferred, following CDN2 and CDN3.
         The streaming provider also hosts a Steering Server, generating Steering Manifests for each client player.
         A Steering Manifest defines rules of Pathway priorities, so the player can follow the rules in selecting and fallback between variant streams.
        Let's say for example the streaming provider is trying to offload some of the traffic from CDN1 to CND2.
         It would generate a Steering Manifest with the new Pathway priority rules, and when a client player playing from CDN1 requests for a Steering Manifest update, the Steering Server can send the prepared Steering Manifest with the rule changes to the client.
         The client will parse and see the new Pathway Priority rules, and apply it to its playback session.
         In this case the rule change switched preference order between Pathway CDN1 and CDN2 so that the client player will switch and play from CDN2 immediately.
         Then, in case of failures, the client will first exhaust fallback variants within the current Pathway, and fallback to the most preferred Pathway according to its current Pathway Priority.
         In this case, if all variants from CDN2 were errored out, the client player can start to choose from variants from CDN1, which is the next preferred Pathway.
         When we apply Content Steering to the global scale, it can solve bigger regional load balancing problems.
         Let's say our streaming service provider operates all around the world, with two main CDN providers.
         To assign these CDNs to client players globally, the Steering Server prepared two different Steering Manifests, one prefers CDN1, and the other prefers CDN2.
         Then it distributes these Steering Manifests based on the client player's region so that the North and South America utilizes CDN1 and the rest of the world utilizes CDN2.
         At the top of the world map we show a horizontal stacked bar representing the distribution of traffic between CDN1 and CDN2.
         As of right now, both CDNs are serving half of the worldwide traffic.
        However, over time the streaming service provider observed a significant increase of traffic towards CDN2 because of global daylight shift.
         At the same time, the traffics toward CDN1 is decreasing.
        So the streaming provider decided to steer the Europe region to use CDN1.
         It does so by preparing a Steering Manifest that prefers CDN1, and sends it to clients from the Europe region.
         Now those client players in that region will steer traffic to CDN1, offloading from CDN2.
         And the global traffic became more balanced.
         Now let's take a look at an HLS multivariant playlist with Content Steering support.
         First we see the EXT-X-CONTENT-STEERING tag that indicates this multivariant playlist uses Content Steering.
         Then we have a SERVER-URI attribute specifying where the client should request Steering Manifest updates from.
        Then the next PATHWAY-ID attribute specifies the initial pathway to choose for playback at startup.
         Then we can see that each variant stream were given an PATHWAY-ID attribute to group them into Pathways.
         Each Pathway should have the same set of variant streams, with only difference being their URIs and media group names.
         In this example, we have two Pathways, namely CDN1 and CDN2.
         Both contains two variant streams, one 6 Mbps high resolution video and one 3 Mbps lower resolution video.
         With the only difference being their URI hostname.
         There are also two distinct audio groups for each Pathway where they have different URI hostnames.
         Here is an example Steering Manifest, which is a JSON document.
         The PATHWAY-PRIORITY field is a list of Pathway IDs in the preference order.
         So in this case, the receiving client player would prefer CDN1 over CDN2.
         This is the Steering Manifest the Steering Server would provide to the European clients, to let them prefer CDN1.
         By altering the PATHWAY-PRIORITY field in a Steering Manifest, a Steering Server can control the steering policy for every client.
         That's it for a quick overview of Content Steering.
         If you want a more in-depth explanation, feel free to check out my WWDC21 talk, Improve global streaming availability with HLS Content Steering.
         However, our journey for supporting a more scalable and more reliable streaming service doesn't stop here.
         Nowadays companies can access more versatile cloud infrastructures and tools to achieve things unimaginable in the past, and we have to catch up in the leap in technology.
         Let's say our streaming service provider has grown larger this year, and they are experimenting with a new way to satisfy the dynamic traffic demands of its growing user base.
         They are doing it by dynamically spawning fleets of CDN servers in real-time to alleviate temporal traffics stresses.
         For example, it can spawn a new fleet of CDN3 and want to advertise it to existing clients.
         However the challenge here is that the dynamically spawned CDN info is not included in the multivariant playlists when existing client requested it, because it just didn't exist.
         So what can we do to tell our client players of the emergence of a new CDN? This is where our new Pathway Cloning feature comes in handy.
         It's a new feature with backward compatibility with Content Steering 1.
        2 introduced in WWDC21.
         With Pathway Cloning, the Steering Server can announce new CDNs to existing clients using a compact manifest definition.
         By assuming Pathways are structure-identical, new Pathways can be created by copying and modifying existing Pathways.
         Let's take a look at the structure of a Pathway.
         A Pathway consists of one or many variant streams.
         Each variant stream can only be in one and only one Pathway.
         If not specified the PATHWAY-ID attribute, it implicitly belongs to the default “dot” Pathway.
         Each variant stream may refer to zero or one media group for each media type, out of audio, subtitle, and closed-caption.
         Each media group may be referenced by multiple variant streams, even from different Pathways.
         When we clone a new Pathway out of an existing one, we should not only clone its variant streams, but also the referenced media groups, if any.
        Then, to make it a new Pathway, we need to modify the URIs of the variant and rendition streams of the newly cloned Pathway.
         Let's take the 6 Mbps variant stream from the cloned Pathway for example.
        Let's say this particular variant stream has the URI as shown.
         To modify it to become the URI for the new Pathway, the most flexible way is to replace the full URI line in whole.
         This means we need to store a full set of URIs in the Steering Manifest for each cloned Pathway.
         However, in practice we can usually do better than that.
         It is common in the industry to deploy streaming assets across multiple CDNs retaining the same URI path structure.
         And assets served from the same URI share the same URI hostname and query parameters.
        If it's the case, we only need to store the replacement of host and query parameters in the manifest, and replace the components of all cloned URIs and we got the new Pathway.
        Let's take a look at how we can define the Pathway Clone in a Manifest object.
         We added the PATHWAY-CLONES field with an array of Pathway Clone objects.
         Each Pathway Clone object defines a new Pathway cloned from an existing Pathway.
         In this example, we have one Pathway Clone object.
         The BASE-ID field specifies CDN1 to be the original Pathway to clone from.
         The ID field specifies the new Pathway ID to be CDN3.
         Next, we have the URI-REPLACEMENT field with an object of URI replacement rules.
        In this example, we are using the HOST and query parameters replacement rules, which should replace the host part, and insert or replace query parameters of the stream URIs respectively.
         In this case, we are replacing the host part to be cdn3.
        example.
        com, and adding or setting query parameter “foo” with value xyz, and query parameter “bar” with value 123.
        Let's try to apply the host and parameter URI replacement on our previous example URI.
         First we have the resolved variant stream URI based on the multivariant playlist's URI.
        In the Steering Manifest we used HOST URI replacement rule.
         So for the host part of the URI, we replace it with cdn3.
        example.
        com, and got the new host part for the new URI.
        Then we retain the URI path component from the cloned URI.
        Finally, we apply the URI query parameter replacement rule.
         Here we replace the “foo” parameter because it exists on the original URI.
         Then we append the “bar” parameter because it's a new parameter.
         Then we have the replaced query parameter part of the new URI.
         The final result URI would be the URI for the 6 Mbps variant stream from the new Pathway CDN3.
        We apply the same URI replacement rule to the rest of the variants and renditions in the cloned Pathway.
         For the 3 Mbps variant stream, we have the original URI, and apply the host and parameter replacement rule to get the new URI.
         We do the same for the audio and subtitle renditions.
         After we apply the URI replacement rule to all cloned variants and renditions, we have a new Pathway that serves from the new CDN host.
        Let's take another example and let's say the streaming provider wants to serve their highest bandwidth video and audio streams from a specially tuned, fastest CDN host, different from the rest of the lower bitrate streams.
         This is where per-stable-ID URI replacement rule comes in handy.
         In HLS, STABLE-VARIANT-ID and STABLE-RENDITION-ID attributes were introduced to identify variant and rendition streams.
         By setting them in the multivariant playlist, we can later reference each variant or rendition stream, by their stable ID in the Pathway Clone object, in the Steering Manifest, and assign per-stream URI replacement rules.
        To define these particular special URI replacement rules, we need to assign stable IDs to all the variant and rendition streams in the multivariant playlist.
         For example we assign STABLE-RENDITION-ID "audio-en-ac3" to the AC3 English audio, and STABLE-VARIANT-ID "video-4k-dv" to the 25 Mbps 4K variant stream.
         Then, in the Steering Manifest, we can add the two flexible replacement rules by referencing their stable IDs.
         For variant streams, we added "PER-VARIANT-URIS" field to the "URI-REPLACEMENT" object, with a dictionary of STABLE-VARIANT-ID to URI records.
         Here we specify to replace the URI of the variant stream with STABLE-VARIANT-ID "video-4k-dv" with the following URI.
         For the rendition stream, we added "PER-RENDITION-URIS" field to the "URI-REPLACEMENT" object, with a dictionary of STABLE-RENDITION-ID to URI records.
         Here we specify to replace the URI of rendition stream with STABLE-RENDITION-ID "audio-en-ac3" with the following URI.
        Here we see that after applying the URI replacement, all streams are serving from the new cdn3.
        exmaple.
        com host except the 4K video variant and AC3 English audio rendition, where they have special URI replacement rules pointing them to the faster.
        example.
        com host, and with different URI path and query components.
        With Pathway Cloning, when the streaming provider dynamically spawn new CDN fleet, in this example, CDN3, the steering server can add CDN3 as a Pathway Clone for existing clients in their Steering Manifest.
         It can also choose a region, for example Europe, to prioritize CDN3 as the primary Pathway.
         When clients in Europe got the Steering Manifest update, they will steer their traffics toward CDN3.
         For the final part of this talk, let's switch our focus to the details of Steering Server, to explain how to implement the server logic, with concrete examples, to steer client player traffics for load balancing.
        One way to manage and orchestrate a swamp of client players and apply partitioned rules is to put every client into a bucket, and apply the rules at the buckets level.
         It's simple to implement the bucketing at the Steering Server without maintaining any client session states.
         When a client player requests for the initial Steering Manifest, it makes an HTTP GET request at the Steering Server URI.
         The server then generates a uniform random number out of 12 possible buckets.
         When returning the Steering Manifest, the server adds the bucket number, in this case, 7, to the RELOAD-URI attribute, which will be the Steering Manifest URI for the next request from the client player.
         So that the next time the client player request for Steering Manifest, it will carry the bucket number in its request parameter, and the server can extract it and apply steering rules based on the bucket number.
        Now let's take a look at a simple bipartition steering rule.
         In this case, we want to steer 50% traffic to prefer CDN1 and the other 50% of the traffic to prefer CDN2.
         We can write such rule in terms of the bucket number.
         If the client player's bucket number falls in the first 6 buckets, we return Steering Manifest with PATHWAY-PRIORITY prefers CDN1, and otherwise return that with PATHWAY-PRIORITY prefers CDN2.
         Since clients are assigned to buckets uniformly, dividing the 12 buckets into 6 buckets can bipartition the traffics evenly.
        Now let's say a new Pathway called CDN3 is dynamically spawned.
         The Steering Server can advertise it using Pathway cloning to clients that don’t know it from their multivariant playlists.
         One common question when constructing a Steering Manifest with Pathway Cloning, is to determine the set of Pathways that need to be included in the PATHWAY-CLONES array.
         The rule is to clone Pathways that are not in the client's multivariant playlist.
         However, without maintaining any server side states about the client session, how can the Steering Server know the set of Pathways in the client's multivariant playlist? One way to do it is to include the set of Pathways in the initial steering server URI as a query parameter, during the generation of the multivariant playlist.
         In this case, the multivariant playlist contains two pathways, CDN1 and CDN2.
         Therefore, it includes them in the SERVER-URI attribute as a query parameter.
         Then the client player would send request to the URI, carrying the parameters to the steering server.
         Then the steering server can extract the parameter as the set of Pathways in the client's multivariant playlist.
         Then it can calculate the set of Pathways to be cloned, by subtracting the set of available Pathways with the set of Pathways in the client's multivariant playlist.
         In this case, the available Pathways are CDN1, 2, and 3, and the Pathways in the client's multivariant playlist are CDN1 and CDN2, therefore, the Pathway that needs to be included in the PATHWAY-CLONES array is CDN3.
        Let's also take a look how the Steering Server can change its steering rules when there are three available Pathways.
         In this case, the server wants to partition the client traffics evenly across CDN1, 2, and 3.
         We write this rule by returning PATHWAY-PRIORITY that prefers CDN1 if the client's bucket number falls in the first third of the 12 buckets, returning PATHWAY-PRIORITY that prefers CDN2 if the client's bucket number falls in the second third range, and otherwise returning PATHWAY-PRIORITY that prefers CDN3.
         This way each Pathway would serve a third of the client traffics.
         With everything we covered, you are now fully equipped to build your Steering Server with your own dynamic steering rules.
         Doing so can further improve the reliability of your streaming service.
        That's it for our updates in Content Steering this year.
         If you haven't done it yet, try adopting Content Steering as your HLS CDN fallback mechanism as it's more versatile and provides dynamic traffic steering.
         Please also take advantage of the new Pathway Cloning feature to improve your service's reliability.
         As usual, check out the latest IETF HLS specification for more technical details.
         And remember to utilize our HTTP Live Streaming Tools to validate your playlists as you make changes.
         Finally, if you have more questions or suggestion, feel free to reach out at hls-interest@ietf.
        org.
         Thank you for joining, and have a great day.

        """
    }

    var japanese: String {
        """
        鄭乃偉：こんにちは、WWDCへようこそ。
         AppleのAVFoundationチームのZheng Naiweiと申します。
         このセッションでは、私たちがHLS Content Steeringに追加した新しい機能を使って、ストリーミング配信の信頼性を向上させる方法についてお話したいと思います。
        今日は3つのトピックを取り上げます。
         もしあなたがコンテンツステアリングについて聞いたことがなくても、心配は要りません。
         これは、ストリーミングサービスの品質を向上させるために、ストリーミングトラフィックを動的に制御することができる HLS テクノロジーの一部です。
         この技術について簡単に説明し、軌道に乗れるようにします。
        次に、ダイナミックステアリングの能力を限界以上に高め、ストリーミングサービスの信頼性をさらに向上させることができる、新しい経路クローン機能を紹介します。
        最後に、トラフィックをステアリングするためのサーバーサイドのロジックにどのように影響を与えるか、具体的な例を用いて説明します。
         もう待たずに始めましょう。
        Content Steering がなかった時代、エラーフォールバックの際のバリアント選択は、HLS 仕様で標準化されていませんでした。
         そして、クライアントの実装によって、次のフォールバックの variant を選択する際の動作が異なることがあります。
         しかし、典型的な方法は、multivariant プレイリストの variant の順序に従うことです。
        ストリーミングプロバイダがフォールバック CDN のセットを指定したい場合、すべての CDN からすべての variant をリストアップして、multivariant プレイリストの中で適切に順番をつける必要があります。
         この方法では、クライアント プレーヤーが最初のバリアントで障害に遭遇した場合、プレイリスト内の次のバリアントに移動することができ、障害となったバリアントは選択から除外されます。
         この場合、クライアント・プレーヤーはCDN1の6Mbpsのバリアントで問題が発生したため、多変量プレイリストの順序に従って、CDN1の次の3Mbpsのバリアントに移動したことが分かります。
         不幸にも CDN1 からの 3 Mbps バリアントも失敗した場合、クライアント プレーヤーは CDN1 からのバリアントがない状態になり、CDN2 からの 6 Mbps バリアントに移行することになります。
         これは、フォールバックするバリアントがなくなるまで何度でも繰り返すことができます。
         しかし、プレイリスト オーサリング サーバがフォールバック バリアントの順序を制御できるとしても、その制御はクライアントがマルチバリアント プレイリストを要求する時点でのみ行われ、いったんプレイリストが配布されるとフォールバック順序を変更する方法はありません。
         そこで登場するのが「Content Steering」です。
         Content Steeringにより、ストリーミングプロバイダーは、異なるCDNホストを持つパスウェイにバリアントをグループ化することができるようになりました。
        エラーフォールバックの動作は、Content Steering で標準化されました。
         パスウェイは優先順位で並べられます。
         この例では、一番上の CDN1 パスウェイが最も優先され、CDN2 と CDN3 がそれに続きます。
         ストリーミングプロバイダーは、ステアリングサーバーをホストし、各クライアントプレーヤーのためにステアリングマニフェストを生成します。
         Steering Manifestは、Pathwayの優先順位のルールを定義するため、プレーヤーはそのルールに従ってバリアントストリームを選択し、フォールバックすることができます。
        例えば、ストリーミングプロバイダーがCDN1からCND2へトラフィックの一部をオフロードしようとしているとしましょう。
         CDN1 から再生しているクライアントプレーヤーが Steering Manifest の更新を要求すると、Steering Server はルールの変更を含む準備された Steering Manifest をクライアントに送ります。
         クライアントは新しい Pathway Priority ルールを解析して確認し、再生セッションにそれを適用します。
         この場合、ルールの変更により経路 CDN1 と CDN2 の優先順位が入れ替わり、クライアントプレーヤーは CDN2 からすぐに切り替えて再生するようになります。
         次に、障害が発生した場合、クライアントはまず現在のPathway内のフォールバックバリアントを使い果たし、現在のPathway Priorityに従って最も優先されるPathwayにフォールバックします。
         この場合、CDN2 からのすべてのバリアントがエラーになった場合、クライアントプレーヤーは次に優先される Pathway である CDN1 からのバリアントから選択し始めることができます。
         Content Steering をグローバルに適用すると、地域的なロードバランシングの大きな問題を解決することができます。
         私たちのストリーミングサービスプロバイダーが、2つの主要なCDNプロバイダーとともに世界中で運営されているとしましょう。
         これらのCDNを世界中のクライアント・プレイヤーに割り当てるために、ステアリング・サーバーは2つの異なるステアリング・マニフェストを用意し、一方はCDN1を好み、もう一方はCDN2を好みます。
         そして、クライアントプレーヤーの地域に基づいてこれらの Steering Manifests を配布し、北南米では CDN1 を、それ以外の地域では CDN2 を利用するようにします。
         世界地図の上部には、CDN1とCDN2間のトラフィック配分を表す水平方向の積み上げ棒が表示されています。
         現時点では、両CDNは全世界のトラフィックの半分を配信しています。
        しかし，時間とともに，ストリーミング・サービス・プロバイダーは，世界的なデイライト・シフトにより，CDN2へのトラフィックが大幅に増加することを観察しました。
         同時に、CDN1へのトラフィックは減少しています。
        そこで、ストリーミング・サービス・プロバイダーは、ヨーロッパ地域がCDN1を使用するように誘導することを決定しました。
         CDN1を優先するSteering Manifestを作成し、ヨーロッパ地域のクライアントに送信することで、これを実現します。
         その地域のクライアント・プレイヤーは、CDN2からオフロードしてCDN1へトラフィックを誘導するようになります。
         そして、グローバルなトラフィックはよりバランスよくなりました。
         次に、コンテンツ ステアリングをサポートする HLS のマルチバリアント プレイリストを見てみましょう。
         まず、EXT-X-CONTENT-STEERING タグは、このマルチバリアント・プレイリストが Content Steering を使用していることを表しています。
         次に、SERVER-URI 属性があり、クライアントが Steering Manifest の更新を要求する場所を指定します。
        次の PATHWAY-ID 属性は、起動時に再生のために選択する初期経路を指定します。
         次に、各バリアントストリームを Pathway にグループ化するために PATHWAY-ID 属性が与えられていることがわかります。
         それぞれの Pathway は、URI とメディアグループ名の違いだけで、同じバリアントストリームのセットを持っているはずです。
         この例では、CDN1とCDN2という2つのPathwayがあります。
         両方とも2つのバリアントストリーム、1つは6Mbpsの高解像度ビデオ、もう1つは3Mbpsの低解像度ビデオを持っています。
         唯一の違いは、URIのホスト名です。
         また、各経路には、異なる URI ホスト名を持つ 2 つのオーディオ グループがあります。
         以下は、JSONドキュメントであるSteering Manifestの例です。
         PATHWAY-PRIORITY フィールドは、Pathway ID を優先順位で並べたリストです。
         つまり、この場合、受信側のクライアントプレーヤーは CDN2 よりも CDN1 を優先します。
         これは、ステアリングサーバーがヨーロッパのクライアントに提供するステアリングマニフェストで、CDN1 を優先するようにします。
         ステアリングマニフェストの PATHWAY-PRIORITY フィールドを変更することで、ステアリングサーバーはすべてのクライアントのステアリングポリシーを制御することができます。
         コンテンツステアリングの概要は以上です。
         より詳細な説明が必要な場合は、私の WWDC21 での講演、Improve global streaming availability with HLS Content Steering をご覧ください。
         しかし、よりスケーラブルでより信頼性の高いストリーミングサービスをサポートするための私たちの旅は、ここで終わりではありません。
         現在、企業はより汎用性の高いクラウドインフラやツールにアクセスし、過去には想像もできなかったことを実現できるようになっており、私たちは技術の飛躍に追いつかなければなりません。
         例えば、私たちのストリーミング・サービス・プロバイダーが今年、規模を拡大し、増大するユーザーベースのダイナミックなトラフィック要求を満たすための新しい方法を試行しているとしましょう。
         このプロバイダーは、一時的なトラフィックのストレスを軽減するために、リアルタイムでCDNサーバーを動的に起動させるという方法を取っています。
         例えば、CDN3の新しいフリートが生まれ、既存のクライアントにそれを宣伝することができます。
         しかし、ここでの課題は、既存のクライアントが要求したときに、動的に生成されたCDN情報が多変量プレイリストに含まれないということです。
         では、新しいCDNの出現をクライアントのプレイヤーに伝えるにはどうすればいいのでしょうか？そこで便利なのが、新機能「パスウェイ・クローニング」です。
         これは、Content Steering 1.2との後方互換性を持った新機能です。
        2をWWDC21で紹介しました。
         パスウェイクローニングを使えば、ステアリングサーバーはコンパクトなマニフェスト定義を使って、既存のクライアントに新しいCDNをアナウンスすることができます。
         パスウェイの構造が同一であると仮定して、既存のパスウェイをコピーして修正することで、新しいパスウェイを作成することができます。
         パスウェイの構造を見てみましょう。
         パスウェイは1つまたは複数のバリアントストリームから構成されます。
         各バリアントストリームは1つのPathwayにのみ存在することができます。
         PATHWAY-ID属性が指定されていない場合、それは暗黙のうちにデフォルトの「dot」Pathwayに属します。
         各バリアントストリームは、オーディオ、サブタイトル、クローズドキャプションのうち、各メディアタイプについてゼロまたは1つのメディアグループを参照することができます。
         各メディアグループは、異なるPathwayからのものであっても、複数のバリアントストリームによって参照されることがあります。
         既存のPathwayから新しいPathwayをクローンするとき、そのバリアントストリームだけでなく、もしあれば、参照されるメディアグループもクローンする必要があります。
        それから、それを新しいPathwayにするために、新しくクローンされたPathwayのバリアントストリームとレンディションストリームのURIを修正する必要があります。
         クローン化されたPathwayの6Mbpsバリアントストリームを例にとってみましょう。
        この特定のバリアントストリームは、図のようなURIを持っているとします。
         これを新しいPathwayのURIになるように変更するには、最も柔軟な方法は、URIの全行を丸ごと置き換えることです。
         これは、クローンされた各PathwayのSteering ManifestにURIのフルセットを保存する必要があることを意味します。
         しかし、実際にはそれよりもうまくいくことがほとんどです。
         業界では、同じURIパス構造を保持する複数のCDNにストリーミングアセットを展開することが一般的です。
         また、同じURIから提供されるアセットは、同じURIホスト名とクエリパラメータを共有します。
        この場合、マニフェストにホストとクエリ パラメータの置換を格納し、すべてのクローン URI のコンポーネントを置換するだけで、新しいパスウェイを取得できます。
        マニフェスト オブジェクトでパスウェイ・クローンを定義する方法を見てみましょう。
         PATHWAY-CLONESフィールドに、Pathway Cloneオブジェクトの配列を追加しました。
         各Pathway Cloneオブジェクトは、既存のPathwayからクローンされた新しいPathwayを定義しています。
         この例では、Pathway Cloneオブジェクトを1つ持っています。
         BASE-ID フィールドにはクローン元の Pathway として CDN1 が指定されています。
         IDフィールドは、新しいPathway IDをCDN3と指定しています。
         次に、URI-REPLACEMENTフィールドには、URI置換ルールのオブジェクトがあります。
        この例では、HOSTとquery parametersの置換ルールを使用しており、それぞれストリームURIのホスト部分を置換し、query parametersを挿入または置換する必要があります。
         この例では，ホスト部分をcdn3に置き換えています．
        example.
        comとし、クエリーパラメーター "foo "に値xyz、クエリーパラメーター "bar "に値123を追加・設定している。
        先ほどの例の URI に対して、ホストとパラメータの URI の置換を適用してみましょう。
         まず、多変量プレイリストの URI に基づいて解決された variant ストリームの URI があります。
        Steering Manifest では、HOST URI replacement rule を使用しました。
         そこで、URI のホスト部分について、それを cdn3 に置き換えています。
        example.
        com に置き換え、新しい URI のホスト部分を取得しました。
        次に、クローンURIからURIパスコンポーネントを保持します。
        最後に、URIクエリパラメータの置換ルールを適用します。
         ここでは、「foo」パラメータが元のURIに存在するので、これを置き換える。
         次に、「bar」パラメータを追加します。これは新しいパラメータだからです。
         そして、置換されたクエリパラメータを新しいURIの一部とします。
         最終的な結果URIは、新しいPathway CDN3からの6 MbpsバリアントストリームのURIとなります。
        同じ URI の置き換えルールをクローンされた Pathway の残りの variant と renditions に適用します。
         3 Mbpsのバリエーションストリームについては、元のURIがあり、ホストとパラメータの置換ルールを適用して、新しいURIを取得します。
         オーディオと字幕のレンディションについても、同じようにします。
         URI の置換ルールをすべてのクローン化されたバリアントとレンディションに適用すると、新しい CDN ホストから提供する新しいパスウェイができあがります。
        別の例として、ストリーミングプロバイダーが、特別に調整された最速のCDNホストから、残りの低ビットレートのストリームとは異なる最高帯域幅のビデオとオーディオのストリームを提供したいとしましょう。
         ここで、安定した ID ごとの URI 置換ルールが役に立ちます。
         HLS では、バリアントストリームとレンディションストリームを識別するために、STABLE-VARIANT-ID 属性と STABLE-RENDITION-ID 属性が導入されました。
         多変量プレイリストにこれらを設定することで、パスウェイクローンオブジェクトやステアリングマニフェストの中で、安定したIDによって各変量またはレンディションストリームを参照し、ストリームごとのURI置き換えルールを割り当てることができます。
        これらの特別な URI 交換ルールを定義するために、多変量プレイリスト内のすべての variant および rendition ストリームに安定した ID を割り当てる必要があります。
         たとえば、AC3 英語オーディオに STABLE-RENDITION-ID "audio-en-ac3" を割り当て、25 Mbps 4K バリアントストリームに STABLE-VARIANT-ID "video-4k-dv" を割り当てることにします。
         そして、Steering Manifestで、その安定IDを参照して、2つの柔軟な置換ルールを追加することができます。
         バリアントストリームについては、「URI-REPLACEMENT」オブジェクトに「PER-VARIANT-URIS」フィールドを追加し、URIレコードにSTABLE-VARIANT-IDの辞書を設定しました。
         ここでは、STABLE-VARIANT-ID "video-4k-dv" のバリアントストリームのURIを、以下のURIに置き換えることを指定します。
         レンディションストリームについては、URIレコードにSTABLE-RENDITION-IDを辞書とする "URI-REPLACEMENT "オブジェクトに "PER-RENDITION-URIS "フィールドを追加しました。
         ここでは、STABLE-RENDITION-IDが「audio-en-ac3」であるレンディションストリームのURIを、以下のURIに置き換えることを指定します。
        ここでは、URIの置換を適用した後、すべてのストリームが新しいcdn3から提供されていることがわかります。
        exmaple.
        com ホストから提供されています。ただし、4K ビデオ バリアントと AC3 英語オーディオ レンディションは、より高速な URI を指す特別な URI 置換ルールを備えています。
        example.
        comのホストを指し示す特別なURI置換ルールがあり、異なるURIパスとクエリコンポーネントがあります。
        Pathway Cloningでは、ストリーミングプロバイダーが新しいCDNフリート（この例ではCDN3）を動的に生成するとき、ステアリングサーバーはSteering Manifestで既存のクライアント用にCDN3をPathway Cloneとして追加することが可能です。
         また、CDN3 をプライマリ経路として優先させるために、たとえばヨーロッパなどの地域を選択することもできます。
         ヨーロッパのクライアントがSteering Manifestの更新を受けると、CDN3にトラフィックを誘導するようになります。
         本講演の最後では、Steering Server の詳細に焦点を移し、クライアント プレーヤーのトラフィックを負荷分散のために誘導するサーバー ロジックの実装方法について、具体例を交えて説明します。
        クライアントプレイヤーの沼を管理・編成し、パーティショニングルールを適用する方法の1つは、すべてのクライアントをバケットに入れ、バケットレベルでルールを適用することです。
         クライアントのセッション状態を維持することなく、Steering Server でバケット化を実装するのは簡単です。
         クライアントプレーヤーが最初のステアリングマニフェストを要求するとき、ステアリングサーバーの URI で HTTP GET リクエストを作成します。
         サーバーは12のバケツから一様な乱数を生成します。
         ステアリングマニフェストを返す際、サーバーはバケット番号（この場合は7）をRELOAD-URI属性に追加し、これがクライアントプレーヤーからの次のリクエストに対するステアリングマニフェストURIとなります。
         これにより、クライアントプレイヤーが次にステアリングマニフェストをリクエストする際、リクエストパラメータにバケット番号が含まれ、サーバーはそれを抽出し、バケット番号に基づいたステアリングルールを適用することができます。
        では、簡単な2分割のステアリングルールを見てみましょう。
         この場合、50%のトラフィックをCDN1が好むように、残りの50%のトラフィックをCDN2が好むようにステアリングしたいのです。
         このようなルールは、バケット番号の観点から書くことができます。
         クライアントプレーヤーのバケット番号が最初の 6 つのバケットに該当する場合、Steering Manifest with PATHWAY-PRIORITY prefers CDN1 を返し、それ以外の場合は PATHWAY-PRIORITY prefers CDN2 を返すようにします。
         クライアントはバケットに一様に割り当てられるので、12バケットを6バケットに分割することで、トラフィックを均等に二分割することができます。
        ここで、CDN3 という新しい Pathway が動的に生成されたとしましょう。
         Steering Server は、多変量プレイリストからそれを知らないクライアントに対して、Pathway cloning を使ってそれを宣伝することができます。
         Pathway Cloning を使って Steering Manifest を構築する際によくある質問は、PATHWAY-CLONES 配列に含まれる必要のある Pathway のセットを決定することです。
         ルールとしては、クライアントの多変量プレイリストにないPathwayをクローンすることです。
         しかし、クライアントセッションに関するサーバーサイドの状態を維持せずに、Steering Serverはどのようにしてクライアントの多変量プレイリストに含まれるPathwayのセットを知ることができるのでしょうか。1つの方法として、多変量プレイリストの生成時に、最初のステアリングサーバーURIにパスウェイのセットをクエリパラメーターとして含めることができます。
         この場合、多変量プレイリストには、CDN1 と CDN2 という 2 つのパスウェイが含まれます。
         そのため、SERVER-URI属性にクエリパラメータとしてそれらを含める。
         そして、クライアントプレーヤーは、そのURIにリクエストを送信し、パラメータをステアリングサーバーに運ぶことになる。
         そして、ステアリングサーバーは、クライアントの多変量プレイリストに含まれるパスウェイのセットとして、そのパラメータを抽出することができる。
         そして、クライアントの多変量プレイリストのパスウェイ集合から利用可能なパスウェイ集合を差し引くことで、クローン化するパスウェイ集合を計算することができる。
         この場合、利用可能なPathwayはCDN1、2、3であり、クライアントの多変量プレイリストのPathwayはCDN1とCDN2なので、PATHWAY-CLONES配列に含める必要があるPathwayはCDN3である。
        また、利用可能な Pathway が 3 つある場合に、Steering Server がステアリングルールをどのように変更できるかを見てみましょう。
         この場合、サーバーはクライアントのトラフィックを CDN1、2、3 の間で均等に分割したいと考えています。
         このルールは、クライアントのバケット番号が 12 のバケットのうち最初の 3 分の 1 に該当する場合は CDN1 を優先する PATHWAY-PRIORITY を返し、クライアントのバケット番号が 2/3 の範囲にある場合は CDN2 を優先する PATHWAY-PRIORITY を返し、それ以外は CDN3 を優先する PATHWAY-PRIORITY を返して書くことになります。
         このように、各Pathwayはクライアントのトラフィックの3分の1を提供することになります。
         ここまでで、独自のダイナミックステアリングルールを持つステアリングサーバーを構築するための準備が整いました。
         そうすることで、ストリーミングサービスの信頼性をさらに向上させることができます。
        今年のコンテンツステアリングの更新は以上です。
         まだの方は、Content Steering を HLS CDN のフォールバックメカニズムとして採用してみてください。より汎用性が高く、動的なトラフィックステアリングを提供します。
         また、サービスの信頼性を向上させるために、新しいパスウェイクローニング機能をご活用ください。
         例によって、より技術的な詳細については、最新の IETF HLS 仕様をご確認ください。
         また、プレイリストを変更する際には、HTTP Live Streaming Tools を利用してプレイリストを検証することを忘れないようにしてください。
         最後に、ご質問やご提案がありましたら、お気軽に hls-interest@ietf.org までご連絡ください。
        orgまでご連絡ください。
         ご参加ありがとうございました。
        
        """
    }
}
