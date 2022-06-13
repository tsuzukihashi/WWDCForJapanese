import Foundation

struct WhatsNewInSFSymbols4: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "What's new in SF Symbols 4"
    }

    var description: [String] {
        WWDCFormatter.convertString(item: self)
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10157/")!
    }
    var english: String {
        """
    Hi, my name is Thalia, and today we will learn what's new in SF Symbols.
     A symbol is one of the most effective single pieces of graphic communication.
     If you ever want to represent a feeling, an object, an action, or a concept, symbols are an excellent way to do so.
     Symbols are used frequently and consistently, becoming second nature to us.
     Without relying on them, we will find it very difficult to navigate our surroundings.
     As a result, they become an essential part of interface design, as symbols are an excellent way to aid in communication.
     A symbol can also bring many benefits by being a means of interaction, being space-efficient, enhancing the aesthetic appeal, and engaging us by being user-friendly.
     What is so great about a symbol is that it can transcend many languages.
     They can be universal.
     As a result, symbols can unite people in communicating shared ideas, helping engage with others on a deeper level than is possible with just words.
     At Apple, we care deeply about making the user interface and the overall experience better.
     That's why we created SF Symbols, an extensive library of iconography designed to integrate seamlessly with San Francisco, the system font, providing a powerful and flexible design resource for creating experiences on all Apple platforms.
     SF Symbols is designed with typography in mind.
     It has awesome features like different weights, scales, outlined and filled variants, encapsulated shapes, and alignments.
     To learn more about these features and when it's best to use them, check out last year's video from WWDC to get you up to speed.
     Today, we will take a look at the new repertoire and the new categories in "New symbols.
    " In "Rendering modes," we will review the benefits of adding colors to symbols, and we have a new configuration to help make the symbol's behavior automatic.
     We have a new exciting feature called "Variable Color.
    " Here we will explore the use of color to make a symbol more dynamic.
     And finally, we have a more efficient way of annotating symbols.
     We will learn more about it in "Unified annotations.
    " So let's get started.
     The SF Symbols library keeps growing each year, with newer categories and symbols to choose from.
     There are some great additions for Home, including lights, blinds, windows, and doors.
     We even have light switches and power outlets.
     There are new furniture and appliances.
     And new health symbols.
     And this year, our fitness figures are available for you to use.
     We have expanded the library's currency symbols.
     And we have many new objects to choose from.
     And, of course, we keep expanding our localized symbols, with new ones covering different scripts and right-to-left writing systems.
     There are over 700 new symbols to choose from, making SF Symbols a library of more than 4,000 unique symbols.
     That is amazing.
     With all these new additions, we wanted to help you navigate through all the symbols in the SF Symbols app, so we've added five new categories that we think will be super helpful: Camera & Photos, Accessibility, Privacy & Security, Home, and Fitness.
     And remember that in the app, you can always create your own collection with a selection of symbols that best suits your needs.
     Now, let's have a quick reminder about the different rendering modes.
     As you may know, in SF Symbols, there are four rendering modes to choose from, each one providing a greater control over how color is applied to a symbol.
     Monochrome is the most neutral of all the rendering modes.
     It gives a uniform and consistent look, and it is the rendering mode that most closely reflects the typographic nature of SF Symbols.
     Hierarchical is the rendering mode that provides a subtle emphasis while having a single color hue drive the overall aesthetic.
     We can apply depth by highlighting the most important shape of a symbol or differentiate the foreground and background elements.
     That way, we create a visual hierarchy by emphasizing the essential part or parts of a symbol.
     Palette uses two or more contrasting colors to give elements of a symbol more prominence and versatility, allowing for the symbols to be customized to integrate with the color palette of the environment.
     Palette helps the symbols have a contrasting and unique look without sacrificing the overall aesthetic.
     And Multicolor is the rendering mode that represents the intrinsic or native color of a symbol.
     This rendering mode uses a range of colors that can be applied to a symbol to describe the appearance of an object in the physical world, or it can use colors to emphasize the meaning that the symbol is trying to convey.
     You can use Multicolor when the symbols are very prominent in the UI, as it will help create a color narrative that will relate to the symbol forms.
     Until now, if you didn't explicitly specify a rendering mode, you would get Monochrome by default.
     But this year, we've made it easier to display symbols in a rendering mode that best highlights each symbol's unique characteristics.
     Symbols now feature a preferred rendering mode, which can vary between symbols.
     And we call this behavior Automatic Rendering.
     When selected, it provides the preferred rendering mode configuration for each symbol without having to specify it manually.
     For example, when Automatic is selected, the camera filters symbol will opt into Hierarchical, as it is the rendering mode that conveys a more precise visual representation by highlighting the opacities that reference the translucency of the physical camera lenses and filters.
     Here's another example.
     When Automatic is selected, the SharePlay symbol participates in the Hierarchical rendering mode.
     This behavior lets the person's shape stand prominently in the foreground while the waves play a secondary role in the background.
     Again, this emphasizes the symbol's concept, as the SharePlay feature is mainly a way to share and connect with friends and family.
     In most cases, Automatic will be the best way to go.
     But you always have to be aware of the context.
     For example, the AirPods Pro symbol will render as Hierarchical when Automatic is selected.
     But in this context, the symbol is very small and has low contrast when presented on this background.
     Remember that rendering modes can still be explicitly specified for a uniform appearance across symbols in a particular context.
     So in this case, Monochrome will be the best choice as it is more legible and has fewer details at small sizes.
     So always make sure to specify the most suitable rendering mode configuration.
     The different rendering modes apply color to symbols to present visual solutions for a wide range of circumstances.
     Color is a powerful tool, and we can explore it even further.
     Some symbols are more dynamic in nature.
     If we analyze their visual representation, we can notice two main characteristics: first, their paths or shapes convey varying levels of strength, and second, they rely on color to communicate their status changing over time.
     This year, we're expanding the use of color by introducing a new feature called Variable Color.
     We've arranged the symbol's vector paths into layers and organized those layers in sequential order, creating a new method of distributing color through these layers.
     This allows us to convey different levels of strength or communicate a sequence over time, which is dictated by the nature of the design of the symbol.
     One important thing to know is that, in Variable Color, some symbols have all paths participating in the sequence, but for other symbols, only some of the paths may opt-in.
     Let's look at a few examples.
     With Variable Color, we want the paths representing the iPhone to opt-out of the variable sequence, and we want to highlight the paths representing the radio waves.
     This will help differentiate the stages that describe the levels of strength of the radio signal of the phone.
     It's important to know that we define how we want to group the paths.
     For example, it wouldn't make much sense to highlight the waves from left to right in this case.
     So instead, we can group the paths following the sequence that best conveys the radio signal strength: we have the two smaller waves in one layer, and we have the two bigger waves in a different layer.
     And as mentioned, the phone does not participate in the variable sequence.
     This time, let's look at a symbol that we are very familiar with.
     In most cases, this symbol is paired with a built-in slider that syncs with the states represented in the symbol.
     The waves highlight their paths following a sequence dictated by the user controlling the slider, increasing or decreasing the volume level.
     Like in the iPhone example, we have a path that doesn't participate in the sequence, which is the shape illustrating the speaker, and we have paths that do participate in the sequence, which are the three waves that define the volume's strength: low volume, mid-volume, and high volume.
     These paths are organized into layers, and the selected layers opt-in to the Variable Color feature.
     We represent their strength with percentage values: 0% is entirely off, anything above 0% will highlight part of the symbol, and the whole symbol will be fully highlighted as the value approaches 100%.
     One important thing to know is that Variable Color is not meant to create depth; instead, it's meant to highlight a sequence of steps or stages that the symbol can represent.
     For example, let's imagine I need a symbol to represent people's capacity inside a room.
     This symbol looks great for that.
     Let's look at it in more detail.
     We don't want to highlight just one part of the symbol.
     Instead, we need to think of the symbol as a sequence or a range.
     My goal is to cover different states: the room is empty, the room has few people in it, the room is half-full, and the room is at full capacity.
     So now, when I opt into Variable Color, I can easily see the graphic representation of the different states I'm trying to convey.
     And there are no limits to how many paths can opt into the feature.
     There can be just one or many.
     You decide what is the design strategy that best suits your needs.
     If you want to represent the strength level of shapes that follow a sequence, like waves, rays, ellipsis, and layers, you can do so with Variable Color.
     Variable Color is opacity based and it's available in all rendering modes.

    This year, we have made annotations for custom symbols faster and easier to use by creating a unified layer structure across all rendering modes.
     I love baking, and I was thinking of designing an app with cupcake-only recipes.
     I wanted to create my own custom symbols, so I've designed a set that will cover my needs.
     This will be an excellent opportunity to show you how to annotate symbols with the unified layer structure approach and how to annotate symbols that participate in Variable Color.
     Let's use these two as an example.
     Before we start annotating, there are a few things to consider: we need to keep the hierarchy in mind and make sure we outline the z-order.
     The z-order refers to the order of the paths in a symbol along the z-axis.
     There are also two new concepts you need to be aware of: Draw and Erase.
     These are used to help define the way a layer renders.
     For example, here we have the paths of a symbol representing a square overlapping a circle.
     When selecting the layers containing the square, if we choose the Draw option, the layer will draw the paths contained in that layer.
     If we choose the Erase option, the layer will erase the path containing the layer, affecting how the symbol is rendered.
     Now, let's start annotating the cupcake.
     As a first step, we need to organize the paths in layers to create the desired hierarchy.
     If I analyze it closely, I can see four main shapes: the frosting, the cupcake base, the badge, and the plus.
     You can add as many paths as needed to a layer.
     So in this case, the frosting will be defined by a layer with three different paths, and the rest of the layers will be defined by just one path each.
     Organizing the shapes in this way allows us to have more flexibility when annotating one structure for all rendering modes.
     Now we have all the information we need in one place to customize the symbol as needed.

    Now we can start annotating all rendering modes.
     Let's look at Multicolor first.
     I already have the shapes set up, so I just need to choose the right colors.
     Red Velvet is my favorite flavor, so I'll choose white for the frosting and red for the cupcake base.
     Now I will follow the same logic that SF Symbols defines for the plus badges in Multicolor: green for the badge and white for the plus.
     Okay, this is looking great so far.
     Now, let's focus on the badge.
     This is where the unified annotation approach is more apparent.
     We already defined Multicolor.
     Now let's look at Hierarchical and Palette.
     Because of the use of hierarchy in this rendering modes, I would expect the badge to be Primary, which will render it white on a black background, like this one.
     Now I need the plus shape to erase part of the badge.
     This is where the Erase selection is helpful.
     I will be able to see the badge rendered as desired by erasing a part of a shape when the layers overlap.
     Finally, I just need the Monochrome annotation.
     Because there is no added complexity in this rendering mode, I will follow the same logic, making the plus shape erase part of the badge shape.
     I'm almost done now.
     I just need a few extra details.
     For Hierarchical and Palette, I just need to annotate the rest of the cupcake shape as Secondary.
     For Palette, I will choose a color to give a bit of contrast.
     And for Monochrome, I just need to make sure I have the remaining shapes opting into Draw.

    That's all I need.
     The cupcake is ready and customized for all rendering modes.

    Now let's look at the kitchen timer.
     The paths represent the time passing, and since this is a sequence, it's a great candidate to participate in Variable Color.
     We can use the same strategy to annotate this symbol, but instead of grouping the timer paths in one layer, we need to split them with each in its own layer.
     This is because we need to organize the shapes to allow us to recreate the sequence that will help us communicate the different states of the symbol.
     And remember that Variable Color works in all rendering modes.
     If you want to learn more about the new Variable Color feature and the SF Symbols app, check out Paul's talk "Adopt Variable Color in SF Symbols.
    ” You can find the new beta version of the SF Symbols app, where you can explore the new unified annotation approach and access the hundreds of new symbols and fantastic new features.
     Check out developer.
    apple.
    com/sf-symbols.
     From Automatic Rendering behavior to the Variable Color dynamic nature, SF Symbols are an extremely powerful tool to use when implementing symbols in your UIs.
     And this year, SF Symbols is even more powerful, with features that define a spectrum of expression.
     Thank you for joining today.
     I hope you enjoyed learning about what's new in SF Symbols.
    """
    }

    var japanese: String {
            """
            こんにちは、私の名前はタリアです。今日はSFシンボルの新機能を学びましょう。
             シンボルは、グラフィックコミュニケーションの最も効果的なピースの1つです。
             感情、物体、行動、コンセプトを表現したい場合、シンボルはそのための優れた方法です。
             シンボルは、頻繁に、一貫して使用され、私たちの第二の天性になります。
             シンボルに頼らなければ、私たちは周囲をナビゲートすることが非常に難しくなります。
             そのため、コミュニケーションツールとして、インターフェイスデザインに欠かせない存在となっています。
             また、シンボルには、インタラクションの手段、スペース効率、美観、ユーザーフレンドリーなど、多くの利点があります。
             シンボルの素晴らしいところは、多くの言語を超越することができる点です。
             普遍的であることです。
             その結果、シンボルは人々の心を一つにし、共通の考えを伝え、言葉だけでは得られない深いレベルでの関わりを持つことができるのです。
             Appleは、ユーザーインターフェイスと全体的なエクスペリエンスをより良いものにすることに、深く関わっています。
             システムフォントであるSan Franciscoとシームレスに統合できるように設計され、すべてのAppleのプラットフォームで体験を生み出すためのパワフルで柔軟なデザインリソースとなる、幅広い図像のライブラリであるSF Symbolsを作ったのは、このためです。
             SF Symbolsは、タイポグラフィを念頭に置いて設計されています。
             さまざまなウェイト、スケール、アウトラインとフィルドのバリエーション、カプセル化されたシェイプ、アラインメントなどの素晴らしい機能を備えています。
             これらの機能の詳細と、どのような場合に使用するのが最適かについては、昨年のWWDCのビデオでご確認ください。
             本日は、新しいレパートリーと新しいカテゴリーを「新しいシンボル」でご紹介します。
            " "レンダリングモード "では、シンボルに色を追加することの利点を確認し、シンボルの動作を自動化するための新しい設定を紹介します。
             "バリアブルカラー "と呼ばれるエキサイティングな新機能をご紹介します。
            " ここでは、シンボルをよりダイナミックにするための色の使い方を探ります。
             そして最後に、シンボルに注釈を付けるより効率的な方法があります。
             これについては、"Unified annotations "で詳しく説明します。
            " では、さっそく始めましょう。
             SFシンボルライブラリーは、年々新しいカテゴリーやシンボルを追加しています。
             家庭用では、照明、ブラインド、窓、ドアなどが追加されました。
             照明のスイッチやコンセントまであります。
             新しい家具や家電製品もあります。
             そして、新しい健康シンボルも。
             そして今年は、フィットネス・フィギュアが登場しました。
             ライブラリーの通貨記号も充実しました。
             そして、新しいオブジェクトもたくさんあります。
             もちろん、ローカライズされたシンボルも増え続け、さまざまなスクリプトや右から左への文字体系をカバーする新しいシンボルが加わりました。
             現在、700以上の新しいシンボルが追加され、SFシンボルは4,000以上のユニークなシンボルからなるライブラリーになりました。
             これはすごいことです。
             SF Symbolsアプリのすべてのシンボルをナビゲートするために、5つの新しいカテゴリーを追加しました。カメラと写真」「アクセシビリティ」「プライバシーとセキュリティ」「ホーム」「フィットネス」です。
             また、このアプリでは、いつでも自分のニーズに合ったシンボルを選んで、自分だけのコレクションを作ることができるんですよ。
             さて、ここでレンダリングモードについて簡単に説明します。
             SF Symbolsには4つのレンダリングモードがあり、それぞれシンボルへの色の適用をより細かくコントロールすることができます。
             モノクロはすべてのレンダリングモードの中で最もニュートラルなモードです。
             このモードは、SFシンボルのタイポグラフィの特徴を最もよく反映したレンダリングモードです。
             階層型は、1つの色相が全体の美観を牽引しながら、微妙な強調を行うレンダリングモードです。
             シンボルの最も重要な形状を強調したり、前景と背景の要素を区別することで、深みを与えることができます。
             このように、シンボルの本質的な部分や部品を強調することによって、視覚的な階層を作成することができます。
             パレットは、2色以上の対照的な色を使ってシンボルの要素をより目立たせ、多様性を持たせることで、シンボルを環境のカラーパレットと統合するようにカスタマイズすることができます。
             パレットは、全体の美観を犠牲にすることなく、シンボルが対照的でユニークな外観を持つのに役立ちます。
             そしてマルチカラーは、シンボルの固有色またはネイティブカラーを表現するレンダリングモードです。
             このレンダリングモードでは、物理世界のオブジェクトの外観を表現するためにシンボルに適用できる色の範囲を使用したり、シンボルが伝えようとしている意味を強調するために色を使用することができます。
             シンボルの形と関連する色の物語を作るのに役立つので、UIでシンボルが非常に目立つ場合にMulticolorを使用することができます。
             これまでは、レンダリングモードを明示的に指定しないと、デフォルトでMonochromeが表示されていました。
             しかし今年は、それぞれのシンボルの特徴を最もよく表すレンダリングモードで、シンボルを表示することが簡単にできるようになりました。
             シンボルには好みのレンダリングモードがあり、シンボルごとに異なる場合があります。
             この動作を「自動レンダリング」と呼びます。
             選択すると、手動で指定しなくても、各シンボルに優先レンダリングモード設定が提供されます。
             これは、物理的なカメラレンズとフィルタの半透明度を参照する不透明度を強調することによって、より正確な視覚的表現を伝えるレンダリングモードだからです。
             もう一つの例を挙げましょう。
             自動] を選択すると、SharePlay シンボルは [階層] レンダリング モードに参加します。
             この動作により、人物の形状は前景で目立つようになり、波は背景で副次的な役割を果たすようになります。
             これもシンボルのコンセプトを強調しています。シェアプレイ機能は、主に友人や家族と共有し、つながるためのものだからです。
             ほとんどの場合、Automaticが最適でしょう。
             しかし、常に文脈を意識する必要があります。
             例えば、AirPods Proのシンボルは、Automaticが選択された場合、Hierarchicalとしてレンダリングされます。
             しかし、このコンテキストでは、このシンボルは非常に小さく、この背景で表示するとコントラストが低くなります。
             レンダリングモードは、特定のコンテキストでシンボル全体の外観を統一するために明示的に指定することができることを忘れないでください。
             この場合、モノクロは小さいサイズでも読みやすく、細部も少ないので、最良の選択です。
             したがって、常に最も適したレンダリングモード設定を指定するようにしてください。
             さまざまなレンダリングモードでは、シンボルに色を適用して、さまざまな状況に対応する視覚的なソリューションを提示します。
             色は強力なツールであり、さらにそれを探求することができます。
             シンボルの中には、より動的な性質を持つものがあります。
             1つは、パスやシェイプによって強さのレベルが変化していること、もう1つは、時間の経過とともに変化する状態を色で表現していることです。
             今年は、「バリアブルカラー」という新機能を導入し、色の使い方を広げています。
             シンボルのベクターパスをレイヤーに配置し、そのレイヤーを順次整理していくことで、レイヤー間の色の配分を行うという新しい方法を生み出しました。
             これにより、シンボルのデザインの性質によって、異なるレベルの強さを伝えたり、時間の経過に伴う順序を伝えたりすることができます。
             重要なことは、バリアブルカラーでは、すべてのパスがシーケンスに参加するシンボルもありますが、他のシンボルでは、一部のパスだけがオプトインすることがあるということです。
             いくつかの例を見てみましょう。
             Variable Colorでは、iPhoneを表すパスは可変シーケンスからオプトアウトさせ、電波を表すパスは強調表示させたい。
             こうすることで、携帯電話の電波の強さのレベルを表す段階を区別することができます。
             重要なのは、パスをどのようにグループ化するかを定義していることです。
             例えば、この場合、左から右に向かって電波をハイライトするのはあまり意味がありません。
             その代わりに、電波の強さを最もよく伝える順序に従ってパスをグループ化することができます。2つの小さな波を1つのレイヤーに、2つの大きな波を別のレイヤーに配置しています。
             また、前述のように、携帯電話は可変シーケンスに参加しません。
             今回は、私たちになじみの深い記号を見てみましょう。
             ほとんどの場合、このシンボルは、シンボルで表される状態と同期する内蔵スライダーと対になっています。
             ユーザーがスライダーを操作し、音量を上げたり下げたりすることで、波がその軌道をハイライトしていきます。
             iPhoneの例と同様に、スピーカーの形状のようにシーケンスに関与しないパスと、ボリュームの強さを定義する3つの波（小音量、中音量、大音量）のようにシーケンスに関与するパスが存在します。
             これらのパスはレイヤーに整理され、選択されたレイヤーにはバリアブルカラー機能がオプトインされています。
             その強さをパーセント値で表現しています。0%は完全にオフ、0%を超えるとシンボルの一部が強調され、100%に近づくとシンボル全体が強調される。
             重要なことは、バリアブルカラーは奥行きを出すためのものではなく、シンボルが表現できる一連のステップや段階を強調するためのものだということです。
             例えば、部屋の中にいる人の定員を表す記号が必要だとします。
             この記号は、そのような場合に最適です。
             もっと詳しく見てみましょう。
             シンボルの一部分だけを強調するのはやめましょう。
             その代わり、記号を連続や範囲として考える必要があります。
            私の目標は、部屋が空いている状態、人が少ない状態、半分埋まっている状態、そして満席の状態といった、さまざまな状態をカバーすることです。
             そのため、Variable Colorを選択すると、私が伝えようとしているさまざまな状態のグラフィック表現を簡単に見ることができるようになりました。
             また、この機能を選択できるパスの数に制限はありません。
             1本でもいいし、何本でもいい。
             自分のニーズに最も適したデザイン戦略を決めるのはあなたです。
             波、光線、楕円、レイヤーなど、連続するシェイプの強度レベルを表現したい場合は、Variable Colorを使用するとよいでしょう。
             Variable Colorは不透明度ベースで、すべてのレンダリングモードで利用可能です。

            今年は、すべてのレンダリングモードで統一されたレイヤー構造を作ることで、カスタムシンボルの注釈をより速く、より使いやすくしました。
             私はお菓子作りが好きで、カップケーキだけのレシピを載せたアプリをデザインしようと考えていました。
             カスタムシンボルを自分で作りたかったので、ニーズをカバーするセットをデザインしました。
             これを機に、統一レイヤー構造によるシンボルへの注釈の付け方と、バリアブルカラーに参加するシンボルへの注釈の付け方を説明します。
             この2つを例にして説明しましょう。
             アノテーションを始める前に、いくつかの考慮すべき点があります。階層を念頭に置き、Zオーダーのアウトラインを確認する必要があります。
             z-orderとは、シンボル内のパスのz軸に沿った順序を指します。
             また、注意しなければならない新しい概念が2つあります。Draw と Erase です。
             これらはレイヤーのレンダリング方法を定義するために使用されます。
             例えば、ここでは正方形を表すシンボルのパスが円に重なっています。
             四角を含むレイヤーを選択する際、「描画」オプションを選択すると、そのレイヤーに含まれるパスが描画されます。
             消去] オプションを選ぶと、そのレイヤーに含まれるパスが消去され、シンボルのレンダリングに影響を及ぼします。
             それでは、カップケーキの注釈を始めましょう。
             最初のステップとして、レイヤー内のパスを整理して、望ましい階層を作る必要があります。
             よく分析すると、フロスティング、カップケーキの土台、バッジ、そしてプラスという4つの主要な形状が見えます。
             レイヤーには、必要な数だけパスを追加することができます。
             この場合、フロスティングは3種類のパスを持つレイヤーで定義し、残りのレイヤーはそれぞれ1種類のパスだけで定義することになります。
             このように形状を整理することで、1つの構造をすべてのレンダリングモードでアノテーションする際に、より柔軟性を持たせることができます。
             これで、必要に応じてシンボルをカスタマイズするために必要な情報がすべて揃いました。

            これで、すべてのレンダリングモードに注釈を入れられるようになりました。
             まず、マルチカラーについて見てみましょう。
             すでに形は決まっているので、あとは正しい色を選ぶだけです。
             レッドベルベットは私の好きな味なので、フロスティングには白を、カップケーキの土台には赤を選ぶことにします。
             あとは、SFシンボルがMulticolorのプラスバッジで定義しているのと同じ理屈で、バッジを緑、プラスを白にします。
             さて、ここまでは素晴らしい出来栄えです。
             さて、次はバッジに注目してみましょう。
             ここで、統一されたアノテーションアプローチがより明確になります。
             すでにMulticolorを定義しました。
             次に、HierarchicalとPaletteについて見てみましょう。
             このレンダリングモードでは階層を使用しているため、バッジはプライマリになると予想され、このように黒い背景に白いバッジがレンダリングされます。
             さて、バッジの一部を消去するために、プラス形状が必要です。
             ここで「消去」選択が役に立ちます。
             レイヤーが重なっているときに、シェイプの一部を消すことで、バッジが思い通りにレンダリングされるのを確認できるようになります。
             最後に、「モノクローム」アノテーションが必要なだけです。
             このレンダリングモードには複雑な要素はないので、同じロジックで、プラスシェイプがバッジシェイプの一部を消すようにします。
             これでほぼ完成です。
             あとは細部を少し追加するだけです。
             Hierarchical」と「Palette」については、カップケーキのシェイプの残りの部分を「Secondary」として注釈する必要があるだけです。
             パレットでは、少しコントラストをつけるために色を選択します。
             そしてモノクロームでは、残りのシェイプがドローにオプトインしていることを確認するだけです。

            これだけです。
             カップケーキは、すべてのレンダリングモード用にカスタマイズされ、準備が整いました。

            次に、キッチンタイマーを見てみましょう。
             パスは時間の経過を表し、これはシーケンスなので、Variable Color に参加するのに最適な候補です。
             このシンボルのアノテーションにも同じ戦略が使えますが、タイマーのパスを1つのレイヤーにまとめるのではなく、それぞれを独立したレイヤーに分割する必要があります。
             これは、シンボルの異なる状態を伝えるのに役立つシーケンスを再現するために、形状を整理する必要があるからです。
             また、可変カラーはすべてのレンダリングモードで動作することを忘れないでください。
             新しい Variable Color 機能と SF Symbols アプリについてもっと知りたい方は、Paul の講演 "Adopt Variable Color in SF Symbols" をご覧ください。
            SF Symbolsアプリの新しいベータ版が公開されています。新しい統一された注釈のアプローチを探求し、数百の新しいシンボルと素晴らしい新機能にアクセスすることができます。
             デベロッパーをチェックする。
            apple.
            com/sf-symbolsをご覧ください。
             自動レンダリングの動作から可変色のダイナミックな性質まで、SFシンボルはUIにシンボルを実装する際に非常に強力なツールになります。
             そして今年、SF Symbolsは、表現のスペクトルを定義する機能を備え、さらに強力になりました。
             本日はありがとうございました。
             SF Symbolsの新機能を楽しんでいただければ幸いです。
            """
    }
}
