import Foundation

struct GetTheMostOutOfXcodeCloud: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Get the most out of Xcode Cloud"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6729/6729_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/110374/")!
    }

    var english: String {
        """
        Hi, my name is Adam, and I'm a Manager with the Developer Experience Team.
         And I'm Sasan, an Engineer with the Xcode Cloud Team.
         In this session, we're gonna show you how to get the most out of Xcode Cloud by reviewing an existing workflow and highlighting the brand-new Xcode Cloud Usage dashboard.
         Then, we'll take a look at how we can use what we've learned from viewing our existing projects usage, to optimize it further, and begin developing a new Watch OS App version of our project Before we get to that, let's do a quick overview of Xcode Cloud.
         At WWDC 2021, we announced Xcode Cloud, a continuous integration and delivery service built into Xcode and designed expressly for Apple developers.
         Xcode Cloud lets you adopt continuous integration and delivery, a standard software development practice that helps you develop and maintain your code, and deliver apps to testers and users.
         Xcode Cloud accelerates the development and delivery of high-quality apps by bringing together cloud-based tools that help you build apps, run automated tests in parallel, deliver apps to testers, and view.
         and manage user feedback, all while protecting user privacy.
         If you'd like to learn more about setting up Xcode Cloud for the first time, check out "Meet Xcode Cloud" from WWDC 2021, where Holly and Geoff go into more detail in setting up your first workflow.
         Now, let's take a look at an existing workflow and build for our Food Truck app in Xcode Cloud.
         This is the Xcode Cloud dashboard in App Store Connect, it gives us an overview of a recent build of our Food Truck project.
         We recently made the decision to add a companion watchOS app, so a food truck operator can accept incoming orders from their watch quickly, without having to reach for their phone every time a new order comes in.
         Before we get started building the new watchOS app in Xcode Cloud, we'd like to make sure our current workflows and project are fully optimized, getting us the build and test results we want, as quickly as possible.
         We think there may be some ways in which we can save some time and resources here.
        To better understand where we might be able to start making some of these optimizations, let's take a closer look at the build details overview.
         First, we notice that we started the build at 9:15 a.
        m.
         and that it took 14 minutes to complete and present us with results.
         We also see there is a time associated with usage, which in this case is 32 minutes.
         This is the total time it took for all the actions in our 14 minute build to complete.
         Next to the usage, you'll see an option to view the distribution of actions for this build.
        Each action is broken out, along with its respective usage, with the 32-minute total indicated at the bottom.
         This Usage distribution gives us an idea of some places we could possibly make some optimizations.
         But before we get to that, let's take a moment to look more closely at how Xcode Cloud performs these actions, and the difference between a build duration and usage.
        Each build is broken out into a series of actions depending on the setup of your workflow.
         You'll see how Xcode Cloud breaks each action out into multiple parallel actions like Analyze, Archive, Build, and Test.
         Because these actions are performed in parallel, the duration of the build is equal to the longest running action; in this case, the tests we've configured in our workflow that took 14 minutes to complete.
         Now, when calculating usage, each one of these actions, when observed in sequence, give us the total compute usage of the build–in this case, 32 minutes.
         And that's how Xcode Cloud calculates the build duration, and usage for a given build.
        Now, let's take a look at the Xcode Cloud Usage dashboard in App Store Connect! At the top is the usage overview, since the beginning of our monthly cycle for the Truck to Table Team, including a total percentage used.
         Additionally, we see total usage expressed in minutes, along with the remaining compute available on our team's current cycle.
        Beneath this, we see an area dedicated to usage trends for our team, broken out by builds created and overall usage, along with percentage increases or decreases during the last 30 days.
         If we'd like to see the usage over a different time period, we can do so by changing the time period in the top, right-hand corner of the trends section.
        A little further down the page, we see the total usage of each one of our products currently using Xcode Cloud, again, during the time period that we selected above.
         All right, let's select Food Truck so we can see its total usage breakdown.
        Here we start by seeing the same trends from our team view, but now specific to our Food Truck project.
         A little further down the page, we see the usage stats for each one of our workflows.
         At a quick glance, I can see from the Release workflow this is going to be an excellent place to start making a couple of optimizations.
         Now, I'm gonna hand it over to Sasan who, after observing some of the build details and compute usage, is gonna show us a couple of ways we can optimize our project.
         Show them how it's done, Sasan.
         Sasan: Thanks, Adam.
         Let's use the Food Truck project to cover some of the best practices when using Xcode Cloud.
         This should allow us to start iterating quickly on our new watchOS app.
         Workflows define when to start a build through the use of Start Conditions.
         It is important to configure your Start Conditions so that builds only start for changes that are intended for the Workflow.
         Let's see how we can apply this practice to the Release workflow of the Food Truck project.
         But first, I recommend checking out "Explore Xcode Cloud Workflows" for more detailed information.
        I have the same build that Adam showed us earlier open in Xcode.
         To start, let me open the Release workflow in the editor window.
        I right-click on the Workflow in the Navigation Panel and select Edit Workflow.
        In the editor window, I can see all of the configurable sections that make up a Workflow, including a section for Start Conditions.
         We've discovered that sometimes the scheduled build doesn't contain any new changes.
         To address that, let's add a new start condition for branch changes to replace the existing scheduled start condition.
         This will ensure that we don't build duplicate commits.
         I on the Plus button and select Branch Changes.
        Now to delete the scheduled start condition, I will select it and click on the trash icon.
        The Branch Changes Start Condition will run whenever a new commit is pushed to a remote branch.
         By default, the Source Branch is configured to be Any Branch.
         This means that any change made to any branch of your repo will cause this workflow to start a build.
         Since our release workflow is configured to be thorough, I want to restrict this to ensure we only start builds for our release branches.
        I click on Custom Branches, and I can immediately see that I need to specify the custom branch.
        I click on the Plus button and enter the branch name.
        The editor will allow me to choose from either the exact branch name or a prefix.
         In this case, we know we have multiple release branches so I'll select branches beginning with "release".
        Next, I want to specify which files and folders from the release branch can start a build.
         My goal is to not start builds when the docs folder is modified.
         This folder contains only our development documentation so it's safe to skip.
         For the Files and Folders option, I select Custom Conditions.
        I select the Start a Build dropdown and select Don't start a build.
        I click on the Plus button to add a new condition.
        I will specify which folder to exclude by selecting Any Folder and selecting Choose.
        Finally, this will open a file picker.
         Now I can select the docs folder and click Open.
        To finish up, I'll click Save to persist my changes.
        I have now configured the Start Condition to be more selective when starting by restricting to only branches with the release prefix and to ignore changes to the docs folder.
         Workflows also define how to run your builds through the use of pre-defined Actions.
         Actions allow you to analyze, archive, build, and test your changes.
         One important component of the test action is the selection of test destinations.
         To make sure that results are delivered fast, each destination will run in parallel once the test products are built.
        I want to make sure that I'm selecting a concise set of simulator destinations for my tests.
         In addition to speeding up my builds, this also helps reduce noise from the tests that might fail on similar devices.
        Xcode Cloud provides an alias for recommended destinations.
         These are curated lists of simulators that represent a cross section of screen sizes.
        Let's visit the Release workflow again to see how we can select a reasonable set of simulator destinations for the iOS test action.
         After selecting the Test iOS action, we can see there are a wide range of selected test destinations.
         To remove test destinations, I'll select each one and click the Minus button.
         Then I'll click on the dropdown menu of the last item and select Recommended iPhones.
        Again, I'll click Save to persist my changes.
        I now have a set of test destinations that will help provide a clear signal if we introduce a regression.
        As we discussed earlier, Xcode Cloud will run your workflow when you push new changes to your repository.
         Sometimes, you may want to skip building in CI depending on the type of change being committed.
         We've added in the ability to do just that.
         Let's take a look in Xcode.
        To skip your commit in Xcode Cloud, simply append "ci skip" to the end of the commit message.
         Now, when you push to remote, Xcode Cloud will know to ignore this event.
        Make sure you're using the exact format of the ci skip tag shown here.
        For each action, custom scripts are executed at multiple points.
         Tidying up unused dependencies and resiliently retrying API requests that are known to be unreliable will ensure builds complete fast and consistently.
         For more information on custom scripts and other advanced customizations, check out "Customize your advanced Xcode Cloud workflows".
        For testing, you should ensure that flakey and unreliable tests are corrected quickly.
         When a flakey test fails, the instinct is to immediately retry the build.
         Depending on the reliability of your test suite, this can result in many retried builds.
         Make sure to spend more time writing reliable tests.
        For more information on how to do that effectively, check out our other session "Author fast and reliable tests for Xcode Cloud".
         So far we've discussed some best practices and applied them to the Food Truck project.
         Let's see what sort of impact those changes had by comparing the build from earlier with one from our updated workflow.
         This is a build that was started after applying the best practices.
         Compared to the previous build that Adam showed us, the duration decreased by a minute but the usage reduced by four minutes.
         It looks like we've made some good improvements overall.
        Let's return to the usage dashboard to better understand the impact.
        Since it might be difficult to see the impact from a single build right away, we've applied the best practices to another one of our workflows, the Integration Workflow.
         We've been running builds for a while with best practices applied.
         We can tell that our changes were effective because usage is trending downward.
        This means we're now capable of adding more workflows and starting more builds to start development of the watchOS app.
        Using the usage dashboard, you can continue to apply the same best practices to your existing projects and workflows to get the most out of Xcode Cloud.
         For more information on how to manage Xcode Cloud for large teams, check out Deep Dive into Xcode Cloud for teams.
         We hope you enjoyed our session.
         Adam: Thank you for watching.
        """
    }

    var japanese: String {
        """
        こんにちは、私の名前はアダムで、デベロッパーエクスペリエンスチームのマネージャーをしています。
         そして、私はXcode CloudチームのエンジニアであるSasanです。
         このセッションでは、既存のワークフローを確認し、全く新しい Xcode Cloud Usage ダッシュボードを強調することで、Xcode Cloud を最大限に活用する方法をお見せしたいと思います。
         そして、既存のプロジェクトの使用状況を確認して学んだことを使用して、さらに最適化し、新しいWatch OS Appバージョンのプロジェクトの開発を開始する方法を見ていきます。 その前に、Xcode Cloudの概要を簡単に説明しましょう。
         WWDC 2021で、私たちはXcodeに組み込まれ、Appleの開発者のために特別に設計された継続的インテグレーションとデリバリーのサービスであるXcode Cloudを発表しました。
         Xcode Cloudを使用すると、コードの開発と保守、テスターやユーザーへのアプリの配信を支援する標準的なソフトウェア開発プラクティスである継続的インテグレーションとデリバリーを採用することができます。
         Xcode Cloud は、アプリの構築、自動テストの並行実行、テスターへのアプリの配信、および表示を支援するクラウドベースのツールをまとめることにより、高品質のアプリの開発と配信を加速させます。
         また、ユーザーのフィードバックを管理し、ユーザーのプライバシーを保護することができます。
         Xcode Cloudの最初の設定について詳しく知りたい方は、WWDC 2021の「Meet Xcode Cloud」で、HollyとGeoffが最初のワークフローの設定について詳しく説明していますので、ご覧になってください。
         では、Xcode Cloudで私たちのフードトラックアプリのための既存のワークフローとビルドを見てみましょう。
         これは、App Store Connect の Xcode Cloud ダッシュボードで、私たちの Food Truck プロジェクトの最近のビルドの概要を示しています。
         私たちは最近、コンパニオン watchOS アプリを追加することを決定しました。これにより、フードトラックのオペレータは、新しい注文が入るたびに携帯電話に手を伸ばすことなく、腕時計から素早く注文を受けることができるようになりました。
         Xcode Cloud で新しい watchOS アプリの構築を始める前に、現在のワークフローとプロジェクトが完全に最適化され、望む構築とテスト結果をできるだけ早く得られることを確認したいと思います。
         ここで、いくつかの時間とリソースを節約できる方法があると思います。
        どこで最適化を始めればよいかを理解するために、ビルドの詳細の概要を詳しく見てみましょう。
         まず、ビルドを午前9時15分に開始したことに気づきます。
        m.
         そして、ビルドが完了し結果が表示されるまでに14分かかっていることがわかります。
         また、使用時間（この場合は32分）が表示されています。
         これは、14分間のビルドのすべてのアクションが完了するまでにかかった合計時間です。
         使用量の横には、このビルドのアクションの分布を表示するオプションがあります。
        各アクションは、それぞれの使用量とともに分割され、32分の合計が一番下に表示されます。
         この使用量の分布から、いくつかの最適化が可能な場所を知ることができます。
         しかし、その前に、Xcode Cloud がこれらのアクションをどのように実行するか、また、ビルド期間と使用量の違いをもう少し詳しく見てみましょう。
        各ビルドは、ワークフローのセットアップに応じて、一連のアクションに分割されます。
         Xcode Cloud が各アクションを Analyze、Archive、Build、Test などの複数の並列アクションにどのように分割しているかがわかると思います。
         これらのアクションは並行して実行されるため、ビルドの期間は最も長く実行されたアクションと同じになります。この場合、ワークフローで設定した、完了までに 14 分かかるテストです。
         使用量を計算する場合、これらのアクションを順番に観察すると、ビルドの総計算量（この場合、32分）が得られます。
         これが、Xcode Cloud がビルド期間と特定のビルドの使用量を計算する方法です。
        さて、App Store Connect の Xcode Cloud Usage ダッシュボードを見てみましょう。上部には、Truck to Table チームの毎月のサイクルの最初からの使用概要があり、合計使用率が表示されます。
         さらに、分単位の総使用量と、チームの現在のサイクルで利用可能な残りの計算量も表示されます。
        その下には、チームの使用傾向を示すエリアがあり、作成されたビルドと全体の使用量、過去 30 日間の増加または減少の割合で表示されます。
         別の期間の使用状況を確認したい場合は、トレンドセクションの右上隅にある期間を変更することができます。
        ページの少し下に、現在 Xcode Cloud を使用している各製品の、上記で選択した期間での使用量の合計が表示されます。
         それでは、Food Truckを選択して、その合計使用量の内訳を確認しましょう。
        ここでは、チームビューと同じ傾向を見ることから始めますが、今度はFood Truckプロジェクトに特化しています。
         さらにページを進めると、各ワークフローの使用状況も表示されます。
         ざっと見たところ、リリースワークフローから、いくつかの最適化を始めるのに最適な場所であることがわかります。
         では、Sasanにバトンタッチします。ビルドの詳細と計算機の使用状況を観察した後、プロジェクトを最適化する方法をいくつか紹介してくれることでしょう。
         どうやるのか、見せてあげてください、Sasan。
         Sasan: ありがとう、アダム。
         Food Truck プロジェクトを使用して、Xcode Cloud を使用する際のベスト プラクティスをいくつか紹介しましょう。
         これにより、新しい watchOS アプリの反復作業を迅速に開始することができるはずです。
         ワークフローは、Start Conditions を使用して、ビルドを開始するタイミングを定義します。
         Workflow が意図する変更に対してのみビルドを開始するように、Start Conditions を設定することが重要です。
         では、この方法を Food Truck プロジェクトの Release ワークフローに適用してみましょう。
         しかしその前に、より詳細な情報を得るために「Explore Xcode Cloud Workflows」をチェックアウトすることをお勧めします。
        Adamが以前に見せてくれたのと同じビルドをXcodeで開いています。
         まず始めに、エディタウィンドウでReleaseワークフローを開いてみます。
        ナビゲーションパネルでワークフローを右クリックし、「Edit Workflow（ワークフローを編集）」を選択します。
        エディタウィンドウには、開始条件のセクションを含む、ワークフローを構成するすべての設定可能なセクションが表示されます。
         スケジュールされたビルドに新しい変更が含まれていない場合があることがわかりました。
         そこで、既存のスケジュールされた開始条件を置き換えるために、ブランチ変更のための新しい開始条件を追加してみましょう。
         こうすることで、重複したコミットをビルドすることがなくなります。
         プラスボタンを押し、ブランチチェンジを選択します。
        ここでスケジュールされた開始条件を削除するため、それを選択してゴミ箱アイコンをクリックします。
        ブランチチェンジ開始条件は、リモートブランチに新しいコミットがプッシュされるたびに実行されます。
         デフォルトでは、ソースブランチは Any Branch に設定されています。
         つまり、レポのどのブランチでも、変更があればこのワークフローでビルドが開始されます。
         リリースワークフローは徹底するように設定されているので、これを制限して、リリースブランチに対してのみビルドを開始するようにしたいと思います。
        カスタムブランチをクリックすると、カスタムブランチを指定する必要があることがすぐにわかります。
        プラスボタンをクリックし、ブランチ名を入力します。
        エディタでは、正確なブランチ名と接頭辞のどちらかを選択することができます。
         この場合、複数のリリースブランチがあることがわかっているので、「release」で始まるブランチを選択します。
        次に、リリースブランチのファイルやフォルダーのうち、ビルドを開始できるものを指定します。
         私の目標は、docs フォルダが変更されたときにビルドを開始しないようにすることです。
         このフォルダには開発用のドキュメントしか入っていないので、飛ばしても大丈夫です。
         Files and Foldersのオプションで、Custom Conditionsを選択します。
        Start a Buildのドロップダウンを選択し、Don't start a buildを選択します。
        プラスボタンをクリックして、新しい条件を追加します。
        Any Folderを選択し、Chooseを選択して、除外するフォルダを指定します。
        最後に、ファイルピッカーが表示されます。
         これで、docsフォルダを選択して、Openをクリックすることができます。
        最後に、[保存]をクリックして変更を保存します。
        これで、開始条件をより選択的に設定し、release接頭辞を持つブランチのみに制限し、docsフォルダーの変更を無視するようになりました。
         ワークフローは、定義済みのアクションを使用してビルドを実行する方法を定義します。
         アクションによって、変更点の分析、アーカイブ、ビルド、テストを行うことができます。
         テストアクションの重要なコンポーネントの1つは、テスト先の選択です。
         結果を迅速に提供するために、テスト製品がビルドされると、各デスティネーションは並行して実行されます。
        私は、シミュレータのテスト先を簡潔に選択することを心がけたいと思います。
         ビルドのスピードアップに加え、これは類似のデバイスで失敗する可能性のあるテストからのノイズを減らすのにも役立ちます。
        Xcode Cloud は、推奨される宛先のエイリアスを提供します。
         これは、スクリーン サイズの断面図を表すシミュレータの精選されたリストです。
        リリース ワークフローをもう一度見て、iOS テスト アクションのシミュレータ送信先の妥当なセットをどのように選択するかを見てみましょう。
         Test iOSアクションを選択した後、選択されたテスト先が多岐にわたっていることがわかります。
         テスト先を削除するために、それぞれのテスト先を選択し、マイナスボタンをクリックします。
         そして、最後のアイテムのドロップダウンメニューをクリックし、「Recommended iPhones」を選択します。
        もう一度、「保存」をクリックして、変更内容を保存します。
        これで、リグレッションが発生した場合に明確なシグナルを提供するのに役立つ、一連のテスト先ができました。
        先ほど説明したように、Xcode Cloud は、リポジトリに新しい変更をプッシュすると、ワークフローを実行します。
         コミットされる変更の種類によっては、CI でのビルドをスキップしたい場合もあります。
         私たちは、まさにそれを行うための機能を追加しました。
         Xcode で見てみましょう。
        Xcode Cloudでコミットをスキップするには、コミットメッセージの末尾に「ci skip」を追加するだけです。
         これで、リモートにプッシュするときに、Xcode Cloud はこのイベントを無視することがわかります。
        ここに示されている ci skip タグの正確なフォーマットを使用していることを確認してください。
        各アクションについて、カスタム スクリプトが複数のポイントで実行されます。
         使用されていない依存関係を整理し、信頼性が低いことが分かっている API 要求を弾力的に再試行することにより、ビルドが高速かつ一貫して完了することを保証します。
         カスタムスクリプトおよびその他の高度なカスタマイズの詳細については、「Customize your advanced Xcode Cloud workflows」を確認してください。
        テストについては、flakey および信頼性の低いテストが迅速に修正されるようにする必要があります。
         薄っぺらいテストが失敗すると、直感的にすぐにビルドを再試行することができます。
         テストスイートの信頼性にもよりますが、これでは何度もビルドをやり直すことになります。
         信頼性の高いテストを書くために、より多くの時間を費やすようにしましょう。
        それを効果的に行う方法の詳細については、私たちの別のセッション「Author fast and reliable tests for Xcode Cloud」をご覧ください。
         ここまでは、いくつかのベストプラクティスについて説明し、Food Truckプロジェクトに適用しました。
         これらの変更がどのような影響を及ぼすか、先ほどのビルドと更新したワークフローによるビルドを比較してみましょう。
         これは、ベストプラクティスを適用した後に開始されたビルドです。
         Adamが示した以前のビルドと比較すると、時間は1分短縮されましたが、使用量は4分減少しています。
         全体的に良い改善がなされたようです。
        使用状況ダッシュボードに戻り、その影響をよりよく理解しましょう。
        1つのビルドからすぐに影響を見るのは難しいかもしれないので、別のワークフローの1つである統合ワークフローにベストプラクティスを適用してみました。
         ベストプラクティスを適用したビルドをしばらく実行してみました。
         使用量が減少傾向にあることから、この変更が効果的であったことが分かります。
        これは、watchOSアプリの開発を開始するために、より多くのワークフローを追加し、より多くのビルドを開始することができるようになったことを意味します。
        使用状況ダッシュボードを使用して、既存のプロジェクトやワークフローに同じベストプラクティスを適用し続けることで、Xcode Cloud を最大限に活用することができます。
         大規模なチームのために Xcode Cloud を管理する方法の詳細については、Deep Dive into Xcode Cloud for teams を参照してください。
         私たちのセッションを楽しんでいただけたら幸いです。
         アダム：ご視聴ありがとうございました。
        """
    }
}

