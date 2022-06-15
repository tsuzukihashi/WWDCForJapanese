//
//  Hello Swift Charts.swift
//  WWDCForJapanese
//
//  Created by ryo tsuzukihashi on 2022/06/13.
//

import Foundation

struct HelloSwiftChartsArticle: ArticleProtocol {
    var id: String {
        "Hello Swift Charts"
    }

    var title: String {
        "Hello Swift Charts"
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10136/")!
    }

    var english: String {
        """
        Hello, I am Dominik and I am thrilled to introduce you to Swift Charts, Apple's new framework for making informative and delightful charts in SwiftUI.
         Data surrounds us and provides an unprecedented resource for understanding the world and making better decisions.
         Yet, data alone is of little use.
         To make data useful, we must make sense of it.
         A well-designed and accessible data visualization can clearly communicate complex data and turn data into understanding and knowledge.
         At Apple, we spent years studying the best practices for visualizations.
         We learned that charts work best when they show additional useful context around data like the trends and fluctuations of stock prices over some time range, your heart rate during the last workout, and when the day will cool off in the evening.
         And these are just some of the many examples across all our platforms where we use charts.
         Today, I'm excited to introduce you to a new framework so you can make informative and delightful charts in your apps.
         Say hello to Swift Charts.
         Swift Charts is a flexible framework for making Apple-designed charts.
         It uses the same declarative syntax as SwiftUI, so you already know the language of Swift Charts.
         So today, let's make some informative, accessible, and delightful visualizations with Swift Charts.
         In the team, we've been helping a pop-up pancake food truck track its sales with an app.
         The truck serves an international variety of sweet and savory pancakes like cachapa, injera, crêpe, jian bing, dosa, or American pancakes.
         The food truck served more than 4500 pancakes across these styles in the last 30 days.
         Cachapa were the most popular and the app already shows the most important information in the title.
         Let's add a chart to show a detailed breakdown for the six pancakes.
         To make this visualization in Swift Charts, we can use the same declarative syntax as SwiftUI.
         In Swift Charts, you build charts by composition.
         The main components of a bar chart are the bars, which are visual elements for each item in your data.
         Swift Charts calls these visual elements "marks.
        " Let's jump into Xcode to make this chart.
         We start with adding a chart.
         To make a bar, I add a BarMark inside the Chart.
         To show a bar for the number of cachapas, we have to set the name and the sales.
        We set the x-position of the bar to be derived from the value of the name of pancake -- in this case "Cachapa.
        " The first argument to the .
        value factory method is the description of the value, and the second is the value itself.
         And now we get a single bar in the preview.
         The height of each bar described by the y attribute should be set by the number of cachapas sold, which were 916.
         To indicate that we're not setting the position or height of the bar directly, we use .
        value.
         Swift Charts automatically creates not only the bar but also a label for the bars on the x-axis and a y-axis that shows what the length of a bar means.
         Let's add a second bar for injera, of which the truck sold 850.
        Now, it's cool to build individual marks and see them appear in the app.
         However, we usually want to create a chart driven by a collection such as an array of structs.
         I'll start by adding a struct for my pancake sales.
        It has a name -- which is a string -- and how many pancakes the truck sold -- which is an int.
         Because we want to use it to repeat, we make it identifiable.
        .....and define an ID-computed property that returns the name.
         Now we can create our data set as an array of pancakes.
         We could load this from an external data source but here we'll define it in the code.
         Besides cachapa and injera, we also add crêpe.
         We can make the bar chart data driven with ForEach.
         First, remove the second bar.
        And all we need to do now is to repeat the BarMark with a ForEach.
        I pick "element" as the name of the variable in the loop.
        Then we can use element.
        name for x.
        .....and element.
        sales for y.
        If ForEach is the only content in the chart, we can also put the data directly into the chart initializer.
        We can now add the remaining three entries for the jian bing, dosa, and american pancakes.
        As we add more entries to the array, we add new bar marks to the chart.
         Lastly, we see that the labels are becoming close to each other.
         By swapping x and y, we transpose the chart and give the labels for each bar more space.
         The Swift Charts framework automatically chooses an appropriate axis style to make your chart beautiful.
         And with that, we made our first data visualization in Swift Charts.
         And using the new variant feature in Xcode, we can see that this chart looks beautiful in Dark Mode, adapts to different font sizes, device sizes and orientations, and supports accessibility.
        To access the data in a visual representation, you need to be able to see.
         Swift Charts exposes the data in a visualization to VoiceOver so that everyone can explore the details of the popular pancakes.
        When I navigate the chart in VoiceOver, it speaks the name and number of pancakes sold.
        VoiceOver: Cachapa, 916.
        Injera, 850.
        Crêpes, 802.
        Jian Ping, 753.
        Dosa, 654.
        American, 618.
        Dominik: And of course, the chart supports the Audio Graphs feature Apple presented in 2021, including the sonifications.
        VoiceOver: Describe chart.
        Chart Details.
        Play Audio Graph.
        Complete.
        Dominik: We just used Swift Charts to add an informative and accessible chart to the food truck app.
        The chart shows how many pancakes the truck sold of each style.
        Besides the summaries for each style of pancake, the food truck also has per-day sales data.
        The truck can park in Cupertino and San Francisco.
        We want to help the food truck know where to park on different days of the week.
        To answer this question, let's visualize the data as a time series for our two cities.
        To see how easy it is to explore different designs, we will make three iterations of the chart.
        We will start by making a bar graph for Cupertino.
        Then, we will add the data for San Francisco and add a picker.
        And finally, we will combine the data into one multiseries line chart.
        Let's start with the bar chart showing the average number of pancakes sold per day of the week.
        The sales data has the weekday stored as a date and how many pancakes the truck sold as an integer.
        The data for Cupertino is in a variable, cupertinoData.
        As before, we start making a chart with a BarMark.
        We set the x-position of the bar to be derived from the day of the date.
        .....and the height to be derived from the sales.
        And this gives us a first iteration of a chart that shows the sales data per day of the week for Cupertino.
        For the second iteration, let's add the data for San Francisco.
        Using this chart, we want to help the pancake truck decide where to park during the week.
        The sales data for San Francisco is in the sfData variable.
        We want to toggle between the two cities and see the bar chart for each city.
        We start with adding a state variable, city.
        And then we add a SwiftUI picker for the city to the View.
        To toggle between the sales summaries for the two cities via the city variable, we add a switch statement for the data variable.
        And all we have to do now is to replace the data for Cupertino with the one that toggles between the two -- Cupertino and San Francisco.
        If I switch the toggle, the charts toggles between the two cities.
        Swift Charts works with SwiftUI animations, so if we specify that the transition should be animated with easeInOut, the bars animate as I toggle between the two cities and also only shows one location at a time.
        This gives our app the right look and feel.
        As our final iteration, we will show both series in a line chart.
        To make this line chart, we start with the bar chart from Cupertino from before.
        The data for Cupertino and San Francisco is in an array of series.
        Series structs have the city and sales data.
        Before we show both series, let's focus on the Cupertino data.
        In the chart, we can loop over the series data.
        Remember, the chart initializer acts just like a ForEach.
        Then we can replace the specific data for Cupertino with the sales data from the series.
        To distinguish the data for the two cities, I want the color of the bars to be derived from the city.
        For this, we set the foregroundStyle to be derived from the city in the series.
        To show what city a color represents, Swift Charts creates a legend below the chart.
        Now, I add the data for the second location.
        As you can see in the preview, Swift Charts automatically chooses a color for San Francisco, and it shows the bars for both cities in the chart.
        Charts show data for a particular context and a visualization may need to change as our data or questions change.
        Swift Charts makes it easy to quickly change your chart to explore different designs.
        The stacked bar chart is great for showing the total average sales per day; but what if I wanted to do a comparison between the two cities? Maybe a point or line chart would be better.
        We change the mark type from a BarMark to a PointMark to display the pancakes sold as points, or to a LineMark to show the data as a line chart.
        A line chart is a good fit for the sales data since it lets us compare the two cities in each day of the week.
        Charts can combine multiple marks.
        For example, I can add a PointMark.
        To make the series differentiable without color, we set the symbol to be derived from the city.
        Now each point indicates the city by its color and symbol.
        Because it is common to show points on a line, Swift Charts has a shorthand for this where we apply the symbol modifier to the LineMark.
        The style of the points adapts to the line.
        This chart is great.
        We can easily compare the sales trends throughout the week.
        We observe that the sales are especially high in San Francisco on Sundays.
        Swift Charts made it very easy for us to iterate through many designs in just a few minutes.
        So to wrap up, let's look at how Swift Charts makes it easy to iterate quickly and at the same time be flexible enough to seamlessly integrate charts into your app's unique style.
         In Swift Charts, you build charts by composition of marks with mark properties.
         In the Pancake app, we composed charts with three different marks and four mark properties.
         For example, we made a simple bar chart as a bar mark with x and y properties.
         We also changed the mark to quickly explore designs, like charts with points, or line charts where we used the line mark with x and y properties.
        We also saw that we can add properties, like Foreground Style, to show multiple series in a line chart.
         And a chart doesn't have to have just one mark.
         We combined points and lines, and showed the same value with two mark properties.
         Swift Charts supports even more marks and mark properties than we used today.
         It's also extensible and you can add custom marks.
         Marks and mark properties is what allows Swift Charts to express a wide range of chart designs with a small number of declarative building blocks.
         There are many ways in which you can combine these building block to create great data visualizations for your apps.
         Together with what you can already do in SwiftUI, the possibilities are truly endless.
         And as I've showed you today, you get support for Dark Mode, different device screen sizes, Dynamic Type, VoiceOver, and Audio Graphs for free.
         In addition, Swift Charts supports High-Contrast mode.
         And finally, Swift Charts works across locales and is multiplatform.
         The chart with the same code works across all Apple platforms.
         And the same customizations work everywhere so you can tailor the chart to each platform.
         Today, I showed you how Swift Charts uses SwiftUI's powerful compositional syntax so you can make more charts with less code.
         Swift Charts also provides a rich set of customization options, so you can style the chart to match your application.
         And now that you know how to chart new territory and make a chart, you can learn how to customize it in the docs and in our follow-up talk where you'll raise the bar.
        """
    }

    var japanese: String {
        """
        こんにちは、私はドミニクです。SwiftUIで有益で楽しいチャートを作るためのAppleの新しいフレームワークであるSwift Chartsを紹介できることに興奮しています。
         データは私たちを取り囲み、世界を理解し、より良い意思決定を行うための前例のないリソースを提供します。
         しかし、データだけではほとんど役に立ちません。
         データを有用にするために、私たちはそれを理解する必要があります。
         デザイン性に優れ、わかりやすいデータのビジュアライゼーションは、複雑なデータを明確に伝え、データを理解や知識に変えることができます。
         Appleでは、ビジュアライゼーションのベストプラクティスを何年もかけて研究しました。
         ある時間範囲における株価のトレンドと変動、最後のトレーニング中の心拍数、夕方になると涼しくなる時間帯など、データの周りに有用なコンテクストを追加表示すると、チャートが最も効果的に機能することを学びました。
         このように、私たちのプラットフォームでは、さまざまな場面でチャートを活用しています。
         今日、私は、あなたのアプリケーションで情報豊富で楽しいチャートを作ることができる、新しいフレームワークを紹介することに興奮しています。
         Swift Charts にご挨拶しましょう。
         Swift Charts は Apple がデザインしたチャートを作成するための柔軟なフレームワークです。
         SwiftUIと同じ宣言的な構文を使用しているので、Swift Chartsの言語はすでにご存知でしょう。
         ですから、今日は、Swift Charts を使って、情報量が多く、アクセスしやすく、楽しいビジュアライゼーションを作ってみましょう。
         チームでは、ポップアップパンケーキの屋台がアプリでその売上を追跡するのを助けてきました。
         このトラックは、カチャパ、インジェラ、クレープ、ジャンビン、ドーサ、またはアメリカのパンケーキのような、甘くて香ばしいパンケーキの国際的なバラエティーを提供しています。
         このフードトラックでは、過去30日間にこれらのスタイルで4500枚以上のパンケーキを提供しました。
         カチャパが最も人気があり、アプリではすでにタイトルに最も重要な情報が表示されています。
         6つのパンケーキの詳細な内訳を表示するためにチャートを追加してみましょう。
         Swift Chartsでこの視覚化を行うには、SwiftUIと同じ宣言的な構文を使用できます。
         Swift Chartsでは、構成によってチャートを構築します。
         棒グラフの主な構成要素は、データ内の各項目の視覚的な要素である棒です。
         Swift Charts では、これらの視覚的な要素を "マーク" と呼んでいます。
        " このチャートを作るためにXcodeに飛び込んでみましょう。
         まず、チャートを追加することから始めます。
         棒を作るために、Chartの中にBarMarkを追加します。
         カチャパの数の棒を表示するために、名前と売上を設定しなければならない。
        棒グラフの x 位置は、パンケーキの名前 -- この場合は "Cachapa" -- の値から得られるように設定する。
        " .valueファクトリーメソッドの第一引数には
        value factoryメソッドの第一引数は値の説明で、第二引数は値そのものです。
         そして、プレビューに1本のバーが表示されるようになりました。
         y属性で記述された各バーの高さは、カチャパの販売数である916個で設定されるはずです。
         バーの位置や高さを直接設定していないことを示すために、.
        値を使用します。
         Swift Charts は自動的にバーだけでなく、x軸上のバーのラベルとバーの長さが何を意味するのかを示すy軸も作成します。
         トラックが850個を販売したインジェラの2番目の棒を追加してみましょう。
        さて、個々のマークを作成して、それがアプリに表示されるのを見るのはクールなことです。
         しかし、通常は、構造体の配列のようなコレクションによって駆動されるチャートを作成したいと思います。
         まず、パンケーキの売上を表す構造体を追加してみます。
        この構造体には、名前（文字列）と、トラックが販売したパンケーキの枚数（int値）があります。
         この構造体は繰り返し使用したいので、識別できるようにします。
        そして、名前を返すID-computedプロパティを定義します。
         これで、データセットがパンケーキの配列として作成できました。
         これは外部のデータソースから読み込むこともできますが、ここではコードの中で定義することにします。
         カチャパとインジェラに加えて、クレープも追加します。
         ForEachを使って棒グラフをデータドリブンにすることができます。
         まず、2本目のバーを削除します。
        そして、あとはForEachでBarMarkを繰り返すだけです。
        ループ内の変数名として「element」を選んでいます。
        そうすると、element.
        の名前をx.
        ......と、element.
        をy.salesとします。
        もし、ForEachだけがチャートの中身なら、チャートのイニシャライザに直接データを入れることもできます。
        これで、ジャンビン、ドーサ、アメリカンパンケーキの残り3つのエントリーを追加することができます。
        配列にエントリーを追加すると、チャートに新しい棒グラフが追加されます。
         最後に、ラベルが互いに近くなっていることがわかります。
         x と y を入れ替えることで、チャートを転置し、それぞれのバーのラベルにもっとスペースを与えることができます。
         Swift Charts フレームワークは、チャートを美しくするために適切な軸のスタイルを自動的に選択します。
         そしてこれで、Swift Chartsで最初のデータの可視化を作りました。
         そして Xcode の新しいバリアント機能を使って、このチャートが Dark Mode で美しく見え、異なるフォントサイズ、デバイスのサイズと向きに適応し、アクセシビリティをサポートしていることを確認できます。
        視覚的な表現でデータにアクセスするには、見えるようにする必要があります。
         Swift Charts は視覚化されたデータを VoiceOver に公開し、誰もが人気のあるパンケーキの詳細を探索できるようにします。
        VoiceOverでチャートをナビゲートすると、パンケーキの名前と販売枚数を話してくれるんです。
        VoiceOverで カチャパ、916枚。
        インジェラ、850。
        クレープ、802。
        ジャンピン、753
        ドーサ、654.
        アメリカン、618
        ドミニク もちろん、このグラフはAppleが2021年に発表したAudio Graphsの機能にも対応しており、ソニフィケーションも含まれています。
        VoiceOverです。チャートを説明します。
        チャートの詳細。
        オーディオグラフを再生します。
        完了です。
        ドミニク Swift Charts を使って、屋台のアプリに情報量が多くアクセスしやすいチャートを追加したところです。
        このチャートは、トラックが各スタイルのパンケーキをどれだけ売ったかを示しています。
        パンケーキの各スタイルのサマリーの他に、フードトラックは1日あたりの売上データも持っています。
        トラックはクパチーノとサンフランシスコに駐車することができます。
        フードトラックはクパチーノとサンフランシスコに駐車できます。
        この質問に答えるために、データを2つの都市の時系列として可視化してみましょう。
        さまざまなデザインを簡単に探せることを確認するために、グラフを3回繰り返し作成します。
        まず、クパチーノ市の棒グラフを作成します。
        次に、サンフランシスコのデータを追加して、ピッカーを追加します。
        そして最後に、データを1つの多系統折れ線グラフにまとめます。
        まず、曜日ごとのパンケーキの平均販売数を示す棒グラフから始めましょう。
        販売データには、曜日が日付として、トラックが何枚のパンケーキを販売したかが整数値として格納されています。
        クパチーノのデータは、cupertinoDataという変数に入っています。
        前回と同様に、BarMarkでチャートを作り始めます。
        バーのx-positionは日付の日にちから導き出すように設定しました。
        ......そして、高さは売上高に由来するものです。
        これで、Cupertinoの曜日ごとの売上データを表示するチャートの最初の反復ができました。
        2回目の反復では、サンフランシスコのデータを追加してみましょう。
        このグラフを使って、パンケーキ・トラックが平日の駐車場所を決めるのに役立てたいと思います。
        サンフランシスコの売上データは、sfData変数にあります。
        2つの都市を切り替えて、それぞれの都市の棒グラフを見たいと思います。
        まず、状態変数であるcityを追加することから始めます。
        そして、都市のためのSwiftUIピッカーをビューに追加します。
        city変数を通して2つの都市の売上サマリーを切り替えるために、data変数にswitchステートメントを追加します。
        そして、今私たちがしなければならないことは、Cupertinoのデータを、2つの都市 -- CupertinoとSan Francisco -- を切り替えるものに置き換えることだけです。
        トグルを切り替えると、チャートは2つの都市の間でトグルします。
        Swift Charts は SwiftUI のアニメーションで動作するので、トランジションを easeInOut でアニメーション化するように指定すると、2つの都市を切り替えるときにバーがアニメーション化し、一度に1つの場所しか表示されなくなります。
        これにより、このアプリは正しいルック＆フィールになります。
        最後の反復として、両方の系列を折れ線グラフで表示することにします。
        この折れ線グラフを作成するために、先ほどのCupertinoの棒グラフから始めます。
        Cupertino と San Francisco のデータは、系列の配列に格納されています。
        シリーズ構造体には、都市と売上高のデータがあります。
        両方のシリーズを表示する前に、Cupertino のデータに焦点を当てましょう。
        チャートでは、シリーズ データをループ処理することができます。
        チャートのイニシャライザーは ForEach と同じように動作することを忘れないでください。
        そして、Cupertinoの特定のデータを、系列の売上データに置き換えることができます。
        2つの都市のデータを区別するために、バーの色を都市に由来するものにしたいと思います。
        そのために、foregroundStyleをシリーズの都市に由来するものに設定します。
        色がどの都市を表しているかを示すために、Swift Chartsはチャートの下に凡例を作成します。
        さて、2番目の場所のデータを追加します。
        プレビューでわかるように、Swift Chartsは自動的にサンフランシスコの色を選択し、チャートに両方の都市の棒グラフを表示します。
        グラフは特定のコンテキストのデータを表示し、データや質問が変わると視覚化も変わる必要があるかもしれません。
        Swift Charts では、異なるデザインを探求するためにチャートを簡単に素早く変更できます。
        積み上げられた棒グラフは1日あたりの平均的な売り上げの合計を表示するには素晴らしいですが、2つの都市間の比較を行いたい場合はどうでしょうか？点線や折れ線グラフの方がいいかもしれません。
        そこで、マークの種類をバーマークからポイントマークに変更し、販売されたパンケーキをポイントで表示したり、ラインマークに変更し、データを折れ線グラフで表示します。
        折れ線グラフは、曜日ごとに2つの都市を比較できるので、売上データには適しています。
        グラフは、複数のマークを組み合わせることができます。
        例えば、PointMarkを追加することができます。
        色なしでシリーズを区別できるようにするために、都市から派生した記号を設定します。
        これで、各ポイントはその色とシンボルで都市を示す。
        線上にポイントを表示することは一般的なので、Swift ChartsはLineMarkにsymbol修飾子を適用することで、このための略記法を用意しています。
        点のスタイルは線に適応します。
        このチャートは素晴らしいです。
        1週間を通しての売上傾向を簡単に比較することができます。
        サンフランシスコでは日曜日に特に売上が高いことがわかります。
        Swift Chartsのおかげで、ほんの数分で多くのデザインを反復するのがとても簡単になりました。
        それでは最後に、Swift Charts がどのように素早く反復することを容易にし、同時に、チャートをあなたのアプリ独自のスタイルにシームレスに統合するのに十分な柔軟性を持っているかを見てみましょう。
         Swift Charts では、マークとマークのプロパティを合成することでチャートを構築します。
         パンケーキのアプリでは、3種類のマークと4つのマークプロパティでチャートを構成しました。
         例えば、シンプルな棒グラフは、xとyのプロパティを持つ棒マークとして作りました。
         また、マークを変えて、点のあるグラフや、xとyのプロパティを持つ線分マークを使った折れ線グラフなど、素早くデザインを検討することができました。
        さらに、Foreground Styleなどのプロパティを追加することで、折れ線グラフに複数の系列を表示できることも確認しました。
         また、グラフのマークは1つだけである必要はありません。
         点と線を組み合わせ、2つのマークプロパティで同じ値を表示しました。
         Swift Chartsは今日使ったものよりもさらに多くのマークとマークプロパティをサポートしています。
         また、拡張性もあり、カスタムマークを追加することも可能です。
         マークとマークプロパティがあるからこそ、Swift Chartsは少ない宣言型の構成要素で幅広いチャートデザインを表現することができるのです。
         これらのビルディングブロックを組み合わせて、あなたのアプリのために素晴らしいデータの視覚化を作成する方法はたくさんあります。
         SwiftUI ですでにできることと合わせると、可能性は本当に無限大になります。
         そして今日お見せしたように、ダークモード、異なるデバイスのスクリーンサイズ、ダイナミックタイプ、VoiceOver、そしてオーディオグラフのサポートを無料で手に入れることができます。
         さらに、Swift Charts はハイコントラストモードをサポートしています。
         そして最後に、Swift Charts はロケールを超えて動作し、マルチプラットフォームです。
         同じコードのチャートは、すべての Apple プラットフォームで動作します。
         そして、同じカスタマイズはどこでも動作するので、それぞれのプラットフォームに合わせたチャートを作ることができます。
         今日は、Swift Charts が SwiftUI の強力な構文を使っているので、より少ないコードでより多くのチャートを作ることができることをお見せしました。
         Swift Charts は豊富なカスタマイズオプションのセットも提供するので、アプリケーションにマッチするようにチャートをスタイルすることができます。
         そして、新しい領域を開拓してチャートを作る方法を知ったので、ドキュメントと、バーを上げるフォローアップの講演で、それをカスタマイズする方法を学ぶことができます。

        """
    }

}
