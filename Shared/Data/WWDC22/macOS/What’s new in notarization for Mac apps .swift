import Foundation

struct WhatsNewInNotarizationForMacApps: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "What’s new in notarization for Mac apps"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6603/6603_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10109/")!
    }

    var english: String {
        """
        Hello, my name is Johnathan.
         macOS developers submit software to the notary service in order to help protect their customers from malicious software.
         Last year we introduced a faster and simpler way to submit apps for notarization with the notarytool CLI or command-line interface.
         This year we are excited to continue championing performance and flexibility with some major improvements for your interactions with the notary service.
         In this session, we'll be talking about three main topics.
         First, we'll go through important deadlines for the migration from using altool for notarization to using notarytool.
         Next, we'll discuss improvements to the Xcode integration with the upcoming Xcode 14, bringing the submission speed of notarytool to Xcode.
         And finally, we'll talk about a flexible new way to interact with the notary service, a REST API, letting you expand the places you can upload, check the status of, and review submissions.
        Last year we introduced notarytool, a replacement for altool for notarization.
         Later in this talk, I'll be discussing Xcode moving to our updated backend with Xcode 14.
         With migration paths in place for notarization via altool and Xcode 13, we're announcing the sunset date for notarization with these older methods to be fall of 2023.
         For help moving from altool to notarytool, please refer to last year’s presentation "Faster and simpler notarization for Mac apps.
        " To highlight some specifics, the notarytool CLI will continue to work past the fall 2023 deadline, including the one bundled in Xcode 13.
         As always, however, we do encourage you to update to receive the latest improvements and fixes.
         Uploads to the notary service using the Xcode 13 UI will stop working after that deadline.
         Stay tuned to hear about some performance improvements in Xcode 14, but largely you can expect your workflow to remain unchanged.
         Finally, notarization with all forms of altool will stop working in fall 2023.
         Again, please refer to last year's WWDC presentation for details on migrating to notarytool.
         Next, we'll touch on changes to notarization in Xcode 14.
         We've migrated the notarization support built into Xcode to use the same reliable backend as the notarytool CLI we introduced last year.
         Because of this, we're happy to bring the same roughly 4x performance increase we announced last year for notarytool to Xcode 14.
         The best part is that, besides updating, you don't need to change your project settings or workflows to receive this performance boost.
         For the final topic of this presentation, we're excited to announce a new service, a REST API for notary.
         This new service allows you to interact more flexibly with the notary service in even more places.
         To go over some important concepts, this new API is intended to allow for a more flexible interface to the notary service.
         As a JSON-based web service, integration should be fairly simple in most languages.
         This API allows you to upload submissions from any place with an internet connection, including continuous integration servers -- places where you might not be running macOS today.
         Additionally, other interactions with the notary service are also supported in this API, such as retrieving your submission history or past submission details.
         Our goal with introducing the REST API is to support submitting software for notarization from more platforms and to allow for easier interactions with notary in automated systems.
         This complements the current methods of submission, Xcode and notarytool, where those can't be run today, such as a Linux-based continuous integration.
         For example, imagine you want your deployment pipeline to submit your application to notary prior to distribution.
         With this new API and some basic scripts, you can easily automate the process.
         Before I dive in, one important topic is authentication.
         You can authenticate with the API using JSON Web Tokens, or JWTs, just like other App Store Connect APIs.
         For more details on authentication or the code I'm about to show, please visit the REST API documentation linked below.
         In these snippets, I'll assume you have a valid JWT passed into the functions as the token variable.
         Let's walk through an example of submitting files to notary in Python.
         This same basic flow is applicable in other programming languages.
         There are two major steps for uploading files to notary.
         The first step is to inform notary that you wish to upload a file.
         Included in this is some basic information about the file like name and SHA-256.
         The response contains information necessary to upload the file and an ID to track your submission through our pipeline.
         The second step actually uploads the file for notarization via Amazon S3.
         You'll need to grab your favorite S3 SDK.
         For this example, I'm going to be using the boto3 library.
         Here we use the temporary credentials returned in the previous call to authenticate and create a client.
         We then use the client to upload the file to the bucket and object specified in the first step's response.
         Once uploaded, the submission will proceed though the notarization pipeline.
         This process should complete in under 15 minutes for most submissions.
         After upload, you should confirm the notary service has successfully processed your submission prior to distribution.
         There are, broadly speaking, two approaches to this.
         The first, and the simplest, is checking the result through the same API.
         The other option is via the webhook support introduced with notarytool.
         First, let's look at the API approach.
         Checking the status of a submission to notary is pretty straightforward, You can make a request with the submission ID received during the upload process Part of the response is the current status of the submission, which will remain "In Progress" until notary is finished processing it.
         The status will then transition to the final state of your submission, such as Accepted or Invalid.
         Once the submission is complete, you can then use the API to retrieve the notarization log for this upload.
         Please refer to the Notary REST API documentation for more details on these endpoints.
         Next, we'll talk about the second approach to getting your status: a webhook.
         In the webhook workflow, the process is largely the same, but this time you'll provide a webhook URL in the initial request to upload.
         Details on the format can be found in the documentation for the notary REST API.
         As before, this will trigger the notary service to analyze your submission.
         As the automated analysis concludes, tickets are created, and the final status is saved.
         Once complete, the notary service will call out to the webhook URL provided.
         The contents of this call include the submission ID, the team ID, and a signature to verify it came from us.
         On receiving that notification, you can choose what to do next.
         For example, you might notify the original submitter or begin an automated distribution pipeline.
         Compared to waiting with notarytool, this allows you to decouple the system that uploads the file from the system that automates actions after notarization.
         We're excited to see this new REST API open the doors to more integrations with continuous integration systems and other tools to build software for macOS.
         To wrap up, as one more reminder, the deadline to migrate to using Xcode 14, notarytool, or the REST API directly is fall of 2023.
         Finally, if you haven't yet been able to use notarytool in your deployment pipelines, this is your chance to jumpstart your automation by trying the notary REST API today.
         You can find a link to the documentation below.
         Thank you, and I hope you enjoy the rest of WWDC22

        """
    }

    var japanese: String {
        """
        こんにちは、ジョナサンです。
         macOSの開発者は、悪意のあるソフトウェアから顧客を保護するために、公証サービスにソフトウェアを提出します。
         昨年、私たちはnotarytool CLI（コマンドラインインターフェース）を使って、より速く、よりシンプルにアプリを公証に出す方法を紹介しました。
         今年は、公証サービスとのインタラクションのためのいくつかの主要な改善で、パフォーマンスと柔軟性を支持し続けることに興奮しています。
         このセッションでは、3つの主要なトピックについてお話します。
         まず、公証にaltoolを使用することからnotarytoolを使用することへ移行するための重要な期限について説明します。
         次に、次期Xcode 14でのXcodeとの連携の改善について、notarytoolの提出速度をXcodeにもたらすことについて説明します。
         そして最後に、公証サービスと対話するための柔軟な新しい方法、REST APIについて、アップロード、ステータスの確認、および提出物のレビューができる場所を拡大できるようにします。
        昨年、私たちは公証のためのaltoolの代替となるnotarytoolを紹介しました。
         この講演の後半では、XcodeがXcode 14で私たちの更新されたバックエンドに移行することについて説明する予定です。
         altoolとXcode 13による公証のための移行パスが整備されたので、これらの古い方法による公証のサンセットデートを2023年の秋と発表しています。
         altool から notarytool への移行については、昨年発表した「Faster and simpler notarization for Mac apps」を参照してください。
        " いくつかの具体的な内容を強調すると、notarytool CLIは、Xcode 13にバンドルされているものを含め、2023年秋の期限を過ぎても動作し続けます。
         しかし、いつものように、我々はあなたが最新の改善と修正を受け取るために更新することをお勧めします。
         Xcode 13のUIを使用した公証サービスへのアップロードは、その期限を過ぎると動作しなくなります。
         Xcode 14でいくつかのパフォーマンスの改善について聞くために滞在し、しかし、大部分はあなたのワークフローが変更されないことを期待することができます。
         最後に、altoolのすべてのフォームを使用した公証は、2023年秋に動作を停止する予定です。
         繰り返しになりますが、notarytoolへの移行については、昨年のWWDCのプレゼンをご参照ください。
         次に、Xcode 14での公証の変更点について触れます。
         私たちは、Xcodeに組み込まれた公証のサポートを、昨年紹介したnotarytool CLIと同じ信頼性の高いバックエンドを使用するように移行しました。
         このため、私たちは、昨年発表したnotarytoolの約4倍の性能向上をXcode 14にもたらすことができることを嬉しく思っています。
         最も良い点は、アップデートする以外に、この性能向上を受けるために、プロジェクト設定やワークフローを変更する必要がないことです。
         このプレゼンテーションの最後のトピックとして、私たちは新しいサービス、notaryのREST APIを発表することができます。
         この新しいサービスにより、さらに多くの場所で、より柔軟に公証サービスを利用することができるようになります。
         いくつかの重要なコンセプトを説明すると、この新しいAPIは、公証人サービスに対してより柔軟なインターフェースを可能にすることを目的としています。
         JSONベースのウェブサービスとして、統合はほとんどの言語でかなり簡単にできるはずです。
         このAPIを使えば、インターネットに接続できる場所ならどこからでも、継続的インテグレーションサーバなど、今日macOSを動かしていないような場所からでも、提出物をアップロードできるようになります。
         さらに、このAPIでは、投稿履歴や過去の投稿の詳細を取得するなど、公証サービスとの他のやり取りもサポートされています。
         REST APIを導入した目的は、より多くのプラットフォームから公証のためのソフトウェア提出をサポートし、自動化されたシステムで公証人とより簡単にやり取りできるようにすることです。
         これは、現在の提出方法であるXcodeとnotarytoolを補完するもので、Linuxベースの継続的インテグレーションなど、現在それらが実行できない場所での利用を想定しています。
         例えば、デプロイメントパイプラインが、配布前にアプリケーションを notary に提出することを望むとします。
         この新しいAPIといくつかの基本的なスクリプトを使えば、簡単にそのプロセスを自動化することができる。
         本題に入る前に、重要なトピックのひとつに認証がある。
         他の App Store Connect API と同様に、JSON Web Tokens または JWT を使用して API で認証することができます。
         認証の詳細やこれから紹介するコードについては、以下のリンク先のREST APIのドキュメントをご覧ください。
         これらのスニペットでは、トークン変数として関数に渡された有効なJWTを持っていると仮定します。
         それでは、Pythonでファイルを公証人に提出する例を見てみましょう。
         この基本的な流れは、他のプログラミング言語でも同じように適用できます。
         公証人にファイルをアップロードするためには、大きく分けて2つのステップがあります。
         最初のステップは、ファイルをアップロードしたいことを公証人に知らせることです。
         このとき、ファイル名やSHA-256など、ファイルに関する基本的な情報が含まれます。
         この応答には、ファイルのアップロードに必要な情報と、パイプラインを通じてあなたの提出を追跡するためのIDが含まれています。
         2番目のステップでは、実際にAmazon S3経由で公証のためにファイルをアップロードします。
         お気に入りのS3 SDKを入手する必要があります。
         この例では、boto3ライブラリを使用する予定です。
         ここでは、前のコールで返された一時的な資格情報を使って、認証を行い、クライアントを作成します。
         次に、そのクライアントを使用して、最初のステップのレスポンスで指定されたバケットとオブジェクトにファイルをアップロードします。
         アップロードされると、公証パイプラインを経由して提出が行われます。
         このプロセスは、ほとんどの提出物で15分以内に完了するはずです。
         アップロード後、配信前に公証サービスが正常に処理されたことを確認する必要があります。
         これには、大きく分けて2つのアプローチがあります。
         まず、最もシンプルな方法は、同じAPIを通じて結果を確認する方法です。
         もう1つは、notarytoolで導入されたWebhookサポートを介してのオプションです。
         まず、APIのアプローチを見てみましょう。
         Notaryへの提出状況を確認するのは、とても簡単です。アップロード処理中に受け取った提出IDでリクエストを行うことができます。
         その後、「受理」「無効」など、最終的なステータスに移行します。
         提出が完了すると、APIを使用して、このアップロードの公証ログを取得することができます。
         これらのエンドポイントの詳細については、Notary REST APIのドキュメントを参照してください。
         次に、ステータスを取得するための2つ目のアプローチである、webhookについて説明します。
         webhookのワークフローでは、プロセスはほぼ同じですが、今回はアップロードの最初のリクエストでwebhookのURLを提供します。
         フォーマットの詳細は、notary REST APIのドキュメントに記載されています。
         以前と同様に、これは投稿を分析するためにnotaryサービスをトリガーします。
         自動分析が終了すると、チケットが作成され、最終的なステータスが保存されます。
         完了すると、notary サービスは提供された webhook URL にコールアウトします。
         この呼び出しの内容には、投稿ID、チームID、そして私たちからのものであることを確認するための署名が含まれます。
         この通知を受けたら、次に何をするか選ぶことができます。
         例えば、元の投稿者に通知したり、自動配信パイプラインを開始したりすることができます。
         notarytoolで待つことに比べ、ファイルをアップロードするシステムと、公証後のアクションを自動化するシステムを切り離すことができます。
         この新しいREST APIによって、継続的インテグレーションシステムや、macOS向けのソフトウェアを構築するための他のツールとの統合の扉が開かれることを期待しています。
         最後に、もう一つ注意点として、Xcode 14、notarytool、またはREST APIを直接使用するように移行する期限は2023年の秋までとします。
         最後に、もしあなたがまだデプロイメント・パイプラインでnotarytoolを使えていないなら、今すぐnotary REST APIを試して、自動化をスタートさせるチャンスです。
         ドキュメントへのリンクは以下にあります。
         WWDC22の残りを楽しんでください。

        """
    }
}

