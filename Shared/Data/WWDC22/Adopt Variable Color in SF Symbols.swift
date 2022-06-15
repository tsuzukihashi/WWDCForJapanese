import Foundation

struct AdoptVariableColorInSFSymbols: ArticleProtocol {
    var id: String {
        "Adopt Variable Color in SF Symbols"
    }

    var title: String {
        "Adopt Variable Color in SF Symbols"
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10158/")!
    }

    var english: String {
        """
        Hi, there! I'm Paul, and I work on the SF Symbols app.
        Today, we're going to talk about a brand-new feature of SF Symbols: Variable Color.
        We'll be going over how to bring symbols with Variable Color into your projects, and how the SF Symbols app can help you with every step along the way.
        First, we'll take a look at Variable Color in system-provided SF Symbols.
        We'll go over how it works and when to use it.
        Then, we'll go over how to bring Variable Color into your own custom symbols.
        Before we get started, if this is your first time using SF Symbols, or if you just want a refresher, I recommend you watch last year's session, "Explore the SF Symbols 3 app," to find out more about how to find and organize symbols for your projects.
        And if you haven't yet, check out Thalia's talk, "What's new in SF Symbols 4," for an overview of the visual design of SF Symbols and the different rendering modes we'll be showing today.
        Now, let's talk about Variable Color.
        Variable Color is a new feature of SF Symbols that allows you to affect the appearance of a symbol using a percentage value.
        By changing this percentage value, you can easily create symbols that reflect values that can change over time, like signal strength or progress.
        I think the best way to see how Variable Color works is to jump into the SF Symbols app and let the system speak for itself.
        This year in the SF Symbols app, we added a new preview area here in the rendering inspector that allows you to see a symbol in every rendering mode at a glance.
        You can also click on the different representations to switch between rendering modes.
        There's also a new Automatic option here in the picker.
        This option allows each symbol to choose its own preferred rendering mode, which you can see selected in the preview area here.
        For example, this square. and. arrow.
        up symbol prefers Monochrome, while these iPhone symbols prefer Hierarchical.
        Below the color controls, you'll find a new set of controls for Variable Color.
        And there's a new category for symbols that support Variable Color, which is a great place to start experimenting.
        Let's select this speaker symbol, switch to Multicolor, and switch to the gallery view to get a closer look.
        I'll start by clicking this button to turn Variable Color on, and pull the slider all the way down to decrease the percentage we're using.
        You can see pieces of the symbol dimming as the percentage value decreases.
        And as I pull the slider back up, those pieces of the symbol regain all of their color.
        If you keep an eye on the preview area, you can see this happening in all four rendering modes.
        And if I switch back to grid view, you can see all of the symbols in the Variable category are reacting to the changes.
        So what did we just learn about Variable Color? First off, Variable Color can be used with every single rendering mode available for SF Symbols.
        Every system symbol that supports Variable Color supports it in Monochrome, Hierarchical, Palette, and Multicolor modes.
        Second, there are no rules for how many parts of a symbol can be affected by Variable Color.
        Some symbols only have one layer that's affected; some have dozens.
        Regardless, because Variable Color is controlled using percentages, you don't need to worry about this.
        Just pass in a percentage and you're good to go.
        So how does the system interpret those percentages? How do we know when a particular layer is going to have Variable Color applied? Well, like the rest of SF Symbols, we designed Variable Color to make your apps feel right at home on Apple platforms.
        And that means that we took inspiration from the behavior of system-level indicators that you might be familiar with.
        Let's look at this microphone symbol as an example.
        The four dots on the left side of the microphone are each in a separate layer that participates in Variable Color.
        So, each dot will activate when the percentage value crosses a certain threshold.
        Those thresholds are spaced out evenly between zero and 100 percent.
        Zero percent is a special case where no layers will be active.
        Any value greater than zero percent will activate the first dot.
        At 26 percent and greater, the second dot will also be activated.
        Fifty-one percent and greater will activate the third dot.
        And 76 up through 100 percent will activate all four dots.
        So, Variable Color symbols will only appear visually empty at exactly zero percent.
        You can see this behavior in system-level indicators like Wi-Fi strength and battery level.
        Variable Color symbols will start appearing visually full at a value less than 100 percent.
        You can see this behavior in system-level indicators like brightness and volume.
        Now, this next symbol has three layers that use Variable Color, which means that the thresholds between layers might fall at awkward values like 33.3333 and 66.6667 percent.
        We didn't want rounding errors to make symbols appear in unexpected ways, and we didn't want you to have to worry about how many significant digits you typed into your code.
        So, thresholds between layers are rounded to the nearest percentage point, and we don't activate the next layer until you're one full percentage point above that rounded value.
        So, for the first threshold, 33.3 percent rounds down to 33 percent, so the second layer activates one percentage point higher at 34 percent.
        The final threshold rounds from 66.7 percent up to 67 percent, so the last layer activates at one percentage point higher than that, at 68 percent.
        Of course, system-provided symbols are only one half of the story.
        With the SF Symbols app, you can make and annotate your own custom symbols, and even better, you can make your custom symbols just as flexible and just as powerful as symbols provided by the system.
        What do I mean by flexible and powerful? Well, system-provided SF Symbols are available in nine different weights, and each one of those nine weights is available at three different scales.
        Each one of those 27 variants is available in four rendering modes with and without Variable Color.
        That's 216 possible configurations.
        Luckily, that doesn't mean that you need to draw your custom symbols 216 times.
        Last year, to streamline the process of drawing symbols, we introduced variable templates.
        When using this kind of template, instead of drawing 27 different combinations of weights and scales, you only need to draw three, and the system can generate the other 24 for you automatically.
        After you've drawn your custom symbol, you can adopt different rendering modes through a process we call "annotation.
        " Last year, if you wanted your symbol to adopt the Hierarchical and Palette rendering modes, you broke your custom symbol into different layers and assigned each layer a hierarchy level.
        If you wanted your symbol to adopt the multicolor rendering mode, you broke your custom symbol into different layers again and assigned a color to each layer.
        This meant that, to support all the available rendering modes, you had to manage two separate layer structures.
        This year, we're streamlining that workflow with unified annotation.
        Unified annotation uses a single-layer structure for a symbol, and shares that structure across all rendering modes.
        So, instead of having to break your symbol into layers multiple times, you only need to do it once.
        You now also have control over how your symbol will look in Monochrome rendering mode, in addition to the previous control you had over Hierarchical, Palette, and Multicolor.
        And of course, unified annotation allows you to add Variable Color to your symbols.
        So let's work on annotating a custom symbol to get to know unified annotation.
        Last year, I was working on an app so my family could play card games together, even when we couldn't be in the same room.
        A few months after that, I discovered a new obsession: puzzle cubes! So this year, I want to make an app that's going to help me practice solving mine.
        I've got a custom puzzle cube symbol that I've made here on my desktop.
        I'll drag it into the app to make a new custom symbol.
        I based this symbol off of the system-provided cube symbol, and notice how I've left some of the details of the puzzle cube out.
        This helps the symbol come across clearly, even at small sizes and different weights.
        Now, remember this preview area from before? It's especially handy when annotating custom symbols.
        As I make changes to the annotation, I can see how my custom symbol looks in all the different rendering modes at a glance.
        And when I switch rendering modes by clicking here or picking a different option in the picker, the annotation controls in the list change accordingly.
        Monochrome looks pretty good, but let's add some depth in Hierarchical mode.
        I'll switch to that mode and pull the top and the side of the cube into new layers.
        You can see that these new layers automatically get switched to the less-prominent secondary and tertiary levels.
        This gives my symbol a little bit more depth and visual interest.
        And remember that the Hierarchical annotation that we create is also used to support Palette rendering mode.
        So I've just gotten two new rendering modes for the price of one.
        Now, let's switch over to Multicolor mode to give this symbol some color.
        Notice that when I switch to Multicolor mode, I still see the same layers that I separated out in Hierarchical mode.
        Remember, in unified annotation, changes made to the layer structure in one rendering mode will carry through to all the others.
        Let's make the front face red, the top face blue, and the side face yellow.
        All right, this looks pretty great.
        But the most important part of learning to solve a puzzle cube is practice, practice, and more practice.
        So, I would love to use my cube symbol as a timer, and have it fill up with color as I spend more time practicing.
        The solution for that is Variable Color.
        These separate pieces in the front face look like a great place to add some variable color for our timer.
        Let's separate out each of these pieces into a different layer.
        Notice the order that I'm arranging these in the layer list.
        The layers that I want to fill in first go on the bottom, and the layers I want to fill in last go on top.
        Then, we'll select all of these layers and click on this button, which will enable Variable Color on all of them.
        And that's it! Let's move the Variable Color slider around to see what happens.
        Remember to keep an eye on the preview area to see what's happening in all the different rendering modes.
        You can see that, as we change the percentage used in Variable Color, the front face adjusts its color in every rendering mode.
        That's the power of unified annotation.
        Because edits in one rendering mode can carry through to other rendering modes.
        In many cases, you only need to do work once or twice to get great results in all four rendering modes.
        And in situations where things are a bit trickier, the SF Symbols app still has you covered.
        Let's look at a more complicated symbol.
        Here's my cube symbol again, but this time, it's set inside of a circle, like many of the .
        circle.
        fill symbols in the system library.
        Now, I've already started annotating this symbol.
        You can see here that I've separated the circle and the parts of the cube into different layers.
        My symbol looks great in Multicolor and Hierarchical modes, but in Monochrome, there's not much contrast between the cube and the circle behind it.
        When all the paths in the symbol were in one layer, the cube paths created holes in the circle path, which looked great in Monochrome.
        But now that I've moved the circle onto its own layer, the cube paths no longer create holes.
        Instead, they create a solid cube on top of a solid circle.
        So we can't see it very well.
        Luckily, there's a new feature of unified annotation that can help us here.
        We can choose Erase to make a layer create a hole in the layers behind it.
        That's looking much better.
        Now, let's add Variable Color again.
        This time, I'll just select all of the pieces of the front face and choose Split into New Layers from the contextual menu.
        Then I'll use this button to turn on Variable Color again.
        And I'm done! And by the way, the paths are split up using the order that they appear in your symbol template, so if you pay attention to the order of your symbol's paths as you're drawing, you can save some time later.
        So that is unified annotation in a nutshell.
        It's a fast and powerful way to annotate your custom symbols.
        You create one layer structure that applies across all rendering modes.
        You can now control the appearance of your symbol in Monochrome rendering mode.
        You can add Variable Color to individual layers in your symbol.
        The z-order of the layers determines the order that they will fill in as the passed-in percentage increases, and the thresholds used for each layer are spaced evenly between zero and 100 percent.
        And because it's part of the layer structure, when a layer opts in to Variable Color, this setting is shared across all rendering modes.
        And there are two new layer options in unified annotation that make it easier to work with the new shared layer structure.
        Setting a layer to Erase will use that layer's shape to erase layers behind it.
        This is really useful in situations like Monochrome and Hierarchical symbols that have badges with a plus, a minus, or some other shape inside of them.
        And finally, setting a layer to Hidden will exclude it from a particular rendering mode.
        If you're in a situation where a layer truly can't be used across all the rendering modes, you can use this option to only apply that layer to certain modes.
        All of these new features are supported by a new template format, 4.0.
        When you're exporting a symbol from the SF Symbols app to import into Xcode, make sure that you export a 4.0 template to control Monochrome rendering and use Variable Color.
        If you already have custom symbols that you annotated last year, they will be automatically updated to use unified annotation.
        Your Hierarchical and Multicolor annotations will be brought in with no extra work required from you.
        And, if you need to support earlier platforms, the previous 3.0 and 2.0 formats are still available for use.
        Before we wrap up, there's one more thing I want to do.
        I've had a lot of fun learning about how to solve puzzle cubes, but the best part so far is that my daughter saw me solving them and wanted to learn too.
        So naturally, I also want her to be able to use my app to help her practice.
        Now, she's starting kindergarten this fall, so we're going to start her off a little slower.
        But this is where symbols with Variable Color truly shine.
        We could design our timer UI like this.
        Text and numbers are descriptive and helpful, but they could be intimidating for someone like her who's still learning or is unable to read the text.
        But seeing a puzzle cube that looks just like the one she's holding, and seeing it fill up with color as time passes, is friendly and intuitive.
        I don't even need to change my timer code; all I need to do is change the name of the symbol I'm using and keep passing in the same percentage values I used for my bigger cube symbol, and SF Symbols takes care of the rest.
        And that's the power of symbols.
        They allow us to convey ideas in a way that transcends language and text.
        They give us a way to make our apps more inclusive.
        And Variable Color in both system-provided symbols and your custom symbols gives us even more expressive power for concepts like progress, signal strength, and time.
        All of that from three drawings and one unified annotation.
        That's pretty amazing.
        And, I might add, it's way easier than solving a puzzle cube.
        """
    }

    var japanese: String {
        """
        こんにちは! SF Symbolsのアプリを担当しているポールです。
        今日はSF Symbolsの新機能についてお話します。今日はSFシンボルの新機能である「バリアブルカラー」について説明します。
        今日はSF Symbolsの新機能であるVariable Colorについて説明します。
        まず、システムが提供するSFシンボルにおけるバリアブルカラーについて見ていきます。
        どのように機能するのか、どのような場合に使用するのかを説明します。
        そして、あなた自身のカスタムシンボルにバリアブルカラーを導入する方法を説明します。
        もしあなたが初めてSFシンボルを使うなら、あるいは復習したいのなら、始める前に昨年のセッション「SFシンボル3アプリを探検しよう」を見て、あなたのプロジェクトのためにシンボルを見つけて整理する方法についてもっと知ることをお勧めします。
        また、まだの方はタリアの「SF Symbols 4の新機能」をご覧ください。SF Symbolsのビジュアルデザインと今日紹介するさまざまなレンダリングモードの概要がわかります。
        さて、次はバリアブルカラーについてです。
        Variable Color は SF Symbols の新機能で、シンボルの見た目をパーセント値で変化させることができます。
        このパーセント値を変更することで、信号強度や進捗状況など、時間の経過とともに変化する値を反映したシンボルを簡単に作成することができます。
        Variable Colorの仕組みは、SF Symbolsのアプリで実際に体験していただくのが一番わかりやすいと思います。
        今年のSF Symbolsアプリでは、レンダリングインスペクタに新しいプレビューエリアが追加され、あらゆるレンダリングモードでのシンボルを一目で確認することができるようになりました。
        また、それぞれの表現をクリックすると、レンダリングモードが切り替わります。
        ピッカーには、新しい「自動」オプションも用意されています。
        このオプションは、各シンボルに好みのレンダリングモードを選択させるもので、このプレビュー領域で選択されているのを確認することができます。
        たとえば、この正方形。と 矢印
        のシンボルはMonochromeを好み、これらのiPhoneのシンボルはHierarchicalを好みます。
        カラーコントロールの下には、「バリアブルカラー」の新しいコントロールセットがあります。
        そして、バリアブルカラーをサポートするシンボルの新しいカテゴリがあり、実験を始めるには最適な場所です。
        このスピーカーのシンボルを選択し、マルチカラーに切り替えて、ギャラリービューに切り替えて詳しく見てみましょう。
        まず、このボタンをクリックしてバリアブルカラーをオンにし、スライダーを下げきって使用する割合を減らしてみます。
        パーセントの値が小さくなるにつれて、シンボルの一部が薄暗くなっているのがわかります。
        そして、スライダーを引き上げると、シンボルの一部が元の色に戻ります。
        プレビューエリアを見ると、4つのレンダリングモードすべてでこの現象が起こっていることがわかります。
        また、グリッドビューに戻ると、「変数」カテゴリのすべてのシンボルが変化に反応しているのがわかります。
        さて、「バリアブルカラー」について学んだことは何だったでしょうか。まず、バリアブルカラーはSFシンボルで利用可能なすべてのレンダリングモードで使用することができます。
        バリアブルカラーをサポートするすべてのシステムシンボルは、モノクロ、ヒエラルキー、パレット、マルチカラーの各モードでサポートされています。
        第二に、シンボルのいくつの部分がバリアブルカラーの影響を受けるかについてのルールはありません。
        あるシンボルでは、影響を受けるレイヤーは1つだけですが、あるシンボルでは何十ものレイヤーがあります。
        しかし、Variable Colorはパーセンテージで制御されるため、この点については心配する必要はありません。
        パーセンテージを入力すればOKです。
        では、そのパーセンテージをシステムはどのように解釈しているのでしょうか？あるレイヤーにバリアブルカラーが適用されることを知るにはどうしたらいいのでしょうか？他のSF Symbolsと同様、Variable ColorはあなたのアプリがAppleのプラットフォームで快適に動作するように設計されています。
        つまり、皆さんがよくご存知のシステムレベルのインジケータの動作からヒントを得たのです。
        例えば、このマイクのシンボルです。
        マイクの左側にある4つのドットは、それぞれVariable Colorに参加する独立したレイヤーにあります。
        つまり、パーセンテージの値がある閾値を超えると、それぞれのドットが有効になるわけです。
        それらの閾値は、0パーセントから100パーセントの間で等間隔に配置されています。
        ゼロパーセントは特別なケースで、どのレイヤーもアクティブになりません。
        0パーセントより大きい値では、1つ目のドットがアクティブになります。
        26パーセント以上では、2番目のドットもアクティブになります。
        51パーセント以上では、3つ目のドットがアクティブになります。
        そして76から100パーセントまでは、4つのドットがすべてアクティブになります。
        つまり、可変カラーシンボルが視覚的に空に見えるのは、ちょうど0パーセントのときだけです。
        この動作は、Wi-Fi強度やバッテリー残量などのシステムレベルのインジケーターでも確認することができます。
        可変カラーシンボルは、100パーセント未満の値で視覚的にいっぱいに表示されるようになります。
        この動作は、明るさや音量などのシステムレベルのインジケーターで確認することができます。
        さて、次のシンボルには3つのレイヤーがあり、バリアブルカラーを使用しているため、レイヤー間のしきい値は33. 3333 と 66. 6667パーセントです。
        丸め誤差によってシンボルが予期せぬ形で表示されたり、コードに入力した有効数字が何桁になるかを気にする必要はありません。
        そこで、レイヤー間のしきい値は小数点以下を丸め、その丸められた値より1ポイント高くなるまで次のレイヤーを有効にしないようにしています。
        つまり、最初のしきい値は33.3パーセントで切り捨てられ、2番目のレイヤーは1パーセントポイント高い34パーセントでアクティブになります。
        最後の閾値は66.7パーセントから67パーセントに丸められ、最後のレイヤーはそれより1パーセント高い68パーセントで起動する。
        もちろん、システムが提供するシンボルは、物語の半分に過ぎない。
        SF Symbolsアプリでは、独自のシンボルを作成し、注釈を付けることができます。さらに、カスタムシンボルは、システムが提供するシンボルと同様に、柔軟で強力なものにすることができます。
        柔軟で強力とはどういう意味でしょうか？システムから提供されるSFシンボルには、9種類の重みがあり、それぞれ3種類のスケールで利用できます。
        また、27種類のバリエーションは、バリアブルカラーの有無にかかわらず、4種類のレンダリングモードで利用可能です。
        つまり、216通りのコンフィギュレーションが可能です。
        しかし、だからといって、カスタムシンボルを216回も描かなければならないわけではありません。
        昨年、シンボルの描画を効率化するために、バリアブルテンプレートを導入しました。
        このテンプレートを使うと、27種類の重さと目盛りの組み合わせを描く代わりに、3つだけ描けば、残りの24種類はシステムが自動的に生成してくれます。
        シンボルを描いた後は、「アノテーション」と呼ばれる処理によって、さまざまなレンダリングモードを採用することができます。
        " 昨年は、階層レンダリングモードとパレットレンダリングモードを採用したい場合、カスタムシンボルを異なるレイヤーに分割し、各レイヤーに階層レベルを割り当てました。
        マルチカラーレンダリングモードを採用したい場合は、カスタムシンボルを再び異なるレイヤーに分割し、各レイヤーに色を割り当てていました。
        つまり、すべてのレンダリングモードに対応するためには、2つのレイヤー構造を管理しなければならなかったのです。
        今年、私たちはユニファイドアノテーションによって、このワークフローを合理化します。
        ユニファイドアノテーションは、シンボルに単一のレイヤー構造を使用し、その構造をすべてのレンダリングモードで共有します。
        そのため、シンボルを何度もレイヤーに分割する必要がなく、一度の操作で済みます。
        また、階層化、パレット、マルチカラーに加え、モノクロレンダリングモードでのシンボルの表示もコントロールできるようになりました。
        もちろん、統一されたアノテーションによって、シンボルにバリアブルカラーを追加することができます。
        では、ユニファイドアノテーションを知るために、カスタムシンボルにアノテーションをつける作業をしてみましょう。
        昨年、私は家族が同じ部屋にいなくても一緒にカードゲームができるようなアプリを開発していました。
        その数ヵ月後、私は新たなこだわりを発見しました。それは、パズルキューブです! 今年は、パズルを解く練習になるようなアプリを作りたいですね。
        デスクトップにカスタムキューブのシンボルを作っておきました。
        それをアプリにドラッグして、新しいカスタムシンボルを作ります。
        このシンボルは、システムから提供されたキューブシンボルをもとに作成しました。
        これにより、小さなサイズや異なる重さの場合でも、シンボルが明確に伝わるようになりました。
        さて、先ほどのプレビューエリアを覚えていますか？カスタムシンボルに注釈をつけるときに、特に便利です。
        注釈を変更しながら、さまざまなレンダリングモードでカスタムシンボルがどのように見えるかを一目で確認できます。
        また、ここをクリックしたり、ピッカーで別のオプションを選んでレンダリングモードを切り替えると、それに応じてリスト内の注釈コントロールも変化します。
        モノクロもいい感じですが、ヒエラルキーモードでは深みを出してみましょう。
        このモードに切り替えて、立方体の上部と側面を新しいレイヤーに引き込みます。
        これらの新しいレイヤーは自動的に、より優先順位の低い2次と3次のレベルに切り替わることがわかります。
        これによって、私のシンボルにもう少し深みと視覚的な面白さが与えられました。
        また、作成した階層的注釈は、パレットレンダリングモードをサポートするために使用されることを忘れないでください。
        つまり、1つ分の値段で2つの新しいレンダリングモードが手に入ったことになります。
        では、マルチカラーモードに切り替えて、このシンボルに色をつけてみましょう。
        マルチカラーモードに切り替えても、階層モードで分離したのと同じレイヤーが表示されることに注意してください。
        ユニファイドアノテーションでは、あるレンダリングモードでレイヤー構造を変更すると、他のすべてのレイヤーに反映されることを覚えておいてください。
        前面を赤、上面を青、側面を黄色にしましょう。
        さて、これでかなりいい感じになりましたね。
        でも、パズルキューブを解けるようになるには、練習、練習、そしてもっと練習が大切です。
        そこで、キューブマークをタイマー代わりにして、練習時間が長くなるにつれて、キューブマークが色で埋め尽くされるようにしたいですね。
        そのためのソリューションが「バリアブルカラー」です。
        前面の分割されたパーツは、タイマーの色を変化させるのに最適な場所だと思います。
        これらのパーツをそれぞれ別のレイヤーに分離してみましょう。
        レイヤーリストの中で、これらのレイヤーを並べる順番に注目してください。
        最初に塗りつぶしたいレイヤーを下に、最後に塗りつぶしたいレイヤーを上に配置しています。
        そして、これらのレイヤーをすべて選択し、このボタンをクリックすると、すべてのレイヤーでバリアブルカラーが有効になります。
        これで完了です。可変カラースライダーを動かして、何が起こるか見てみましょう。
        プレビュー領域で、すべてのレンダリングモードで何が起こっているかを確認することを忘れないでください。
        可変カラー」で使用する割合を変更すると、すべてのレンダリングモードでフロントフェイスのカラーが調整されることがわかります。
        これが、ユニファイドアノテーションの威力です。
        あるレンダリングモードでの編集が、他のレンダリングモードに引き継がれるからです。
        多くの場合、1、2回の作業で、4つのレンダリングモードすべてで素晴らしい結果を得ることができます。
        しかし、SFシンボルアプリは、そんな複雑な状況にも対応します。
        もう少し複雑なシンボルを見てみましょう。
        またもや立方体のシンボルですが、今回は多くの.NETのシンボルと同じように、円の中にセットされています。
        円。
        fill シンボルと同じです。
        さて、私はすでにこのシンボルに注釈をつけ始めています。
        円と立方体の部分を異なるレイヤーに分離したのがわかると思います。
        このシンボルは Multicolor と Hierarchical モードではきれいに見えますが、Monochrome モードでは立方体とその後ろの円との間にあまりコントラストがないのがわかります。
        シンボルのすべてのパスが1つのレイヤーにあったときは、立方体のパスが円のパスの中に穴を作り、モノクロームではそれがきれいに見えました。
        しかし、円を独立したレイヤーに移動したことで、立方体のパスは穴を作らなくなりました。
        代わりに、立方体のパスは、立方体の円の上に立方体を作成します。
        そのため、あまりよく見えません。
        幸いなことに、統一された注釈の新機能が、ここで役に立ちます。
        消去」を選択すると、レイヤーがその背後にあるレイヤーに穴を開けるようにすることができます。
        これでだいぶ見栄えがよくなりましたね。
        さて、もう一度「バリアブルカラー」を追加してみましょう。
        今回は、前面のパーツをすべて選択し、コンテキストメニューから「新しいレイヤーに分割」を選びます。
        そして、このボタンを使って、再び「バリアブルカラー」をオンにします。
        これで完成です。ちなみに、パスはシンボルテンプレートに表示されている順番で分割されるので、シンボルのパスの順番に注意しながら描けば、後で時間を節約することができます。
        これがユニファイド・アノテーションの簡単な説明です。
        これは、カスタムシンボルに注釈を付けるための高速で強力な方法です。
        すべてのレンダリングモードに適用される1つのレイヤー構造を作成します。
        モノクロレンダリングモードでのシンボルの外観を制御できるようになりました。
        シンボル内の個々のレイヤーに可変カラーを追加できます。
        レイヤーのZオーダーは、通過したパーセンテージが増えるにつれて塗りつぶされる順番を決定し、各レイヤーに使用される閾値はゼロから100パーセントの間で等間隔に配置されます。
        また、レイヤー構造の一部であるため、レイヤーが可変カラーをオプトインすると、この設定はすべてのレンダリングモードで共有されます。
        さらに、新しい共有レイヤー構造での作業を容易にするために、統一された注釈に2つの新しいレイヤーオプションがあります。
        レイヤーを「消去」に設定すると、そのレイヤーの形状を使用して、その背後にあるレイヤーを消去します。
        これは、モノクロや階層シンボルのように、バッジの中にプラスやマイナスなどのシェイプがある場合に非常に便利です。
        そして最後に、レイヤーを「非表示」に設定すると、特定のレンダリングモードから除外されます。
        レイヤーをすべてのレンダリングモードで使用できない場合、このオプションを使用して、そのレイヤーを特定のモードでのみ適用することができます。
        これらの新機能はすべて、新しいテンプレートフォーマットである4.0によってサポートされています。
        Xcode にインポートするために SF Symbols アプリからシンボルをエクスポートする場合、Monochrome レンダリングを制御して Variable Color を使用するために 4.0 のテンプレートをエクスポートすることを確認してください。
        昨年アノテーションしたカスタムシンボルが既にある場合、それらは統一されたアノテーションを使用するように自動的に更新されます。
        階層的アノテーションやマルチカラーアノテーションは、追加作業なしで導入されます。
        また、以前のプラットフォームをサポートする必要がある場合は、以前の3.0と2.0のフォーマットも引き続き使用可能です。
        最後に、もう1つだけお願いがあります。
        私はパズルキューブの解き方について楽しく学んできましたが、これまでで一番良かったのは、私が解いているのを見て、娘が自分も学びたいと言ったことです。
        だから当然、娘にも私のアプリを使って練習させたいと思っています。
        娘はこの秋から幼稚園に通い始めるので、最初は少しゆっくりめにスタートする予定です。
        しかし、ここがバリアブルカラーを使ったシンボルの真骨頂です。
        タイマーのUIを、こんな風にデザインしてみましょう。
        文字や数字は説明的で便利ですが、学習中の人や文字が読めない人にとっては、威圧的な印象を与えるかもしれません。
        でも、彼女が持っているのと同じ形のパズルキューブが、時間の経過とともに色を増していく様子は、親しみやすく、直感的に理解できます。
        タイマーのコードを変える必要もなく、使っているシンボルの名前を変えて、大きなキューブのシンボルに使ったのと同じパーセント値を渡し続けるだけで、あとはSFシンボルがやってくれる。
        それがシンボルの力です。
        そして、これこそがシンボルの力です。シンボルによって、私たちは言語や文章を超えた方法でアイデアを伝えることができるのです。
        そして、アプリをより包括的なものにするための手段でもあります。
        さらに、システムが提供するシンボルとカスタムシンボルによるバリアブルカラーは、進捗、信号強度、時間といった概念をさらに強力に表現します。
        これらすべてを、3枚の図面と1つの統一された注釈で実現しました。
        これはとても素晴らしいことです。
        しかも、キューブパズルを解くよりずっと簡単なんですよ。
        """
    }
}
