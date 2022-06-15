import Foundation

struct AddAccessibilityToYourUnityGames: ArticleProtocol {
    var id: String {
        "Add accessibility to your Unity games"
    }

    var title: String {
        "Add accessibility to your Unity games"
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10151/")!
    }

    var english: String {
        """
        Hello everyone, my name is Eric, and I'm excited to tell you how to add accessibility to your Unity games.
        Accessibility is about allowing everyone to use our products.
         And today marks a huge leap forward for accessible gaming with the Apple Accessibility plug-in for Unity developers.
         We will focus on three Apple technologies for making your games accessible.
        VoiceOver is a screen reader which helps users who are blind or low vision.
         It reads items on the screen and provides custom gestures for users to interact with controls.
        Switch control, which allows someone with low motor control to use an external switch for device interaction.
         And dynamic type, which allows people to set the text size according to their reading ability.
        To get started, clone the repository and build all Apple's plug-ins using the build script in the root of the repository.
         This will produce a Build folder that is ready for integration into your Unity projects.
         Finally, add the Accessibility plug-in to your own project using the Unity Package Manager.
         For more details, look at the documentation in the repository and watch the video about all of Apple's Unity plug-ins, called "Plug-in and play: Add Apple frameworks to your Unity game projects" Now that you have the plug-in, I will guide you through three areas.
         First is accessibility elements.
         This allows you to add support to assistive technologies like VoiceOver or Switch Control for your games.
         Next is Dynamic Type.
         We create this easy-to-use utility that helps you scale text according to user preferences.
         And UI Accommodations.
         These are utilities that helps you read other user preferences.
         Let's start with accessibility elements.
        I built a simple card game to help illustrate this concept.
         You might see that you should tap the "flip" button to draw two random cards.
         However, VoiceOver would not read the text on screen and an external switch would not tap the button since these are just pixels on a screen right now.
         We need to help the system understand what can be interacted with.
         Accessibility elements define the things that assistive technologies can interact with.
        The text, cards, and the button on screen should be accessibility elements.
         And we can describe each element with a label.
         VoiceOver will read each label so the user can understand what's on the screen.
        And if the game supports multiple languages, we should localize these labels as well.
        Now VoiceOver can describe what is on the screen, but it doesn't recognize that there's a button that can be tapped.
         We can use another property called "traits" to inform the system of the element's type.
         We should add the "Button" trait here.
         Now, VoiceOver will read "Flip button," and an external switch can control this button.
        We can also add "Static Text" trait on our text elements.
         The "Static Text" trait is usually given to labels and text areas so that VoiceOver can provide a better text interaction experience.
        And there are many more traits beyond "Button" and "Static Text" that you can explore.
        So what trait should we use for the cards? Well, we don't need to use traits on every accessibility element.
         Our cards don't need any traits.
         However, there's still a part of each card that VoiceOver is not aware of: the face value.
         There's another property that we can use for this called "Value.
        " Once we add a "Value" for each card, VoiceOver will now read "Card 1 with value 3 of clubs, card 2 with value Ace of clubs.
        " And that's it.
         Now that you understand the basics, let's open Unity to see how to add them to our project.
        Here I am in a Unity Editor for this game.
         I have already added the Apple Accessibility plugin to this project.
        First we have the usual scene objects like camera, direct light, and a UI Canvas.
         Under the canvas, we have two text elements and a button.
         After that, we have two game objects for cards.
        Each is composed of two mesh components, each rendering the front and back texture for the card on each side.
         Let's start by defining our accessibility elements.
         To do this, we need the Accessibility Node component from this plugin.
        Select all the objects in the hierarchy that should be accessible.
        And add the Accessibility Node component to make them accessibility elements.
        Next, we add labels.
         Select the card object, go to "Accessibility Node" component on the right, and find the "Label" field.
        And make sure the label field checkbox is checked to provide a custom label.
        Then type "Card 1.
        " And the same for Card 2.
        Text and buttons need labels too, but we don't have to provide an explicit accessibility labels for them if we are using the standard controls from Unity UI.
         The plug-in already has default implementations for those.
        Next, we need to add a trait to our button.
        Select the flip button and change the "Traits" from "None" to "Button.
        " Select the two text elements.
        ..And change "Traits" to "static text.
        " Great.
         Lastly, we need to set an accessibility Value for the card faces.
         Since the cards are randomly drawn, I need to add a script to set the Value dynamically.
        Select the two cards and add a new script called AccessibleCard.
        First, in one of my other C Sharp files, I already have an enum for all the card faces called Playing Card.
         In my new AccessibleCard mono behavior script, we have a variable for the card type and a boolean for whether the card is facing up or down.
        So now let's add accessibilityValue to these cards.
         First, we get the accessibilityNode component attached to this gameObject.
        Next, set the accessibilityValue delegate to a function that returns the card face value dynamically.
        Inside this function, if the card is covered, we return the "covered" for the accessibilityValue.
         Or if not covered, we will enumerate all card faces and return a description for each, like "Ace of Spades.
        " And that's it.
         Now let's build our project and see it in action.
         Here's our game.
         Let's turn on VoiceOver.
        Automated voice: VoiceOver on.
         Eric's Game.
         Card 2, covered.
         Eric: I could swipe right to move to the next element.
         Automated voice: Card 1, covered.
        Eric's card game.
        Flip the cards.
        Flip.
         Button.
         Eric: You see that all five objects are now accessible through VoiceOver, which is awesome.
         To tap the button when VoiceOver is on, do a double-tap.
         Automated voice: Flip.
         Eric: Let's check the cards again.
        Automated voice: Card 1, Two of Clubs.
        Card 2, Ace of Clubs.
         Eric: VoiceOver now reads the updated card faces correctly.
         Cool.
         So we just made our game accessible to millions of VoiceOver users who can now fall in love with it.
         And people who use external switch control can also play our game.
         So that was accessibility elements.
         Next, let's talk about Dynamic Type.
        Games can be difficult to play for many people because text is too small to read.
         On iOS and tvOS, everyone can choose the right text size for their reading ability in Settings.
        With the Accessibility Plugin, you can read this setting to make sure the text in your game is displayed at the expected size.
        Let's take a look at our game example to see how we can use Dynamic Type.
        Create a mono behavior script called DynamicTextSize.
        cs.
         In the start function, first store the default text size into a variable.
        Then inside the OnEnable function, subscribe to setting changed event using AccessibilitySettings.
         onPreferredTextSizesChanged.
         This allows us to update the UI as soon as the user changes the text setting.
        Next, inside the settingsChanged function, first read the PreferredContentSizeMultiplier.
         Then multiply by your original text size and assign it back to the text element.
        Inside Unity Editor, select all game objects that have a Text element.
         And add the DynamicTextSize component that we just created.
        Now our game is all set for Dynamic type support.
         Before we see the result in action, first I am going to show you a trick to quickly test Dynamic Type in your games.
         Open Settings, and find Control Center.
        Scroll down until you see Text Size, and add it to Control Center.
        Now we can adjust text sizes quickly by opening Control Center and change the text size options.
        Great–as I change the text size, our game adjusts font sizes in real time.
        The text percentage value shown in Control Center is exactly what we are reading from that multiplier.
         You can also adopt this setting on non-text objects.
         For example, I can swap the card face assets to Large Print when the size is increased.
        First I create a script called DynamicCardFaces.
         Then same thing as before, subscribe to the TextSizeChanged event.
        Instead of reading a multiplier, I read an enum of text size category that is mapped to the ticks on the Control Center slider.
         I could swap the asset whenever someone selects a larger text size.
        And I simply choose between a regular material and a large print material.
         Now if we select a really large size...
        Users would see a large print version of the cards, which are great card faces that are much easier to read for people with low vision.
        Lastly, I want to talk to you about UI accommodation settings that you can access with this plug-in.
        The first setting is Reduce Transparency.
         When this setting is on, the background is turned opaque, instead of a blur or transparent effect.
         It can help improve legibility when those effects makes text hard to read.
         To check this preference, call AccessibilitySettings.
         IsReduceTransparencyEnabled.
        Next, the Increase Contrast setting.
         Notice how the switches have a darker grey that helps them stand out, making controls easier to recognize across the entire device.
        You can increase contrast for your own UI when this is enabled by checking this setting using AccessibilitySettings.
         IsIncreaseContrastEnabled.
        Next, the Reduce Motion setting.
         Some people are sensitive to motion like we have in this card flip animation.
        We should remove that animation when Reduce Motion is enabled.
        Let's look at the code to do this.
        In our CardController script, we have this Flip function.
         First we check if user's reduce motion setting is on.
         If not on, we should flip the card by invoking an animation through Coroutine.
         Otherwise we just set the rotation, and no animations.
         And that's it.
         Now people who are sensitive to motion would enjoy our game.
         To recap, get started with the Apple Accessibility plugin by cloning the GitHub repository linked in this session's resources.
        Add accessibility elements so that people can use VoiceOver and Switch Control with your games.
        Adapt your text size with Dynamic Type.
        And check for UI accommodations so everyone can have a great experience with your game.
        Thank you so much for joining me.
         We look forward to seeing how you make games available for everyone with a great accessibility experience.
        """
    }

    var japanese: String {
        """
        皆さんこんにちは。私はEricです。今回は、Unityゲームにアクセシビリティを追加する方法についてお話します。
        アクセシビリティとは、すべての人が私たちの製品を使えるようにすることです。
         そして今日、Unity開発者向けのApple Accessibilityプラグインによって、アクセシブルなゲームのための大きな飛躍がありました。
         今回は、ゲームをアクセシブルにするための3つのAppleテクノロジーに焦点を当てます。
        VoiceOverは、目の不自由なユーザーを支援するスクリーンリーダーです。
         画面上の項目を読み上げ、ユーザーが操作するためのカスタムジェスチャーを提供します。
        スイッチ・コントロールは、運動制御能力の低い人が外部スイッチを使用してデバイスと対話できるようにするものです。
         そして、読書能力に応じて文字サイズを設定できるダイナミックタイプ。
        まず、リポジトリをクローンし、リポジトリのルートにあるビルドスクリプトを使って、Appleのプラグインをすべてビルドします。
         これにより、Unityプロジェクトに統合するための準備が整ったBuildフォルダが生成されます。
         最後に、Unityパッケージマネージャを使用して、Accessibilityプラグインを自分のプロジェクトに追加します。
         詳細については、リポジトリ内のドキュメントを見たり、AppleのUnityプラグインのすべてに関するビデオ「Plug-in and play」を見てください。Add Apple frameworks to your Unity game projects" プラグインが手に入ったので、3つの分野を案内します。
         1つ目はアクセシビリティ要素です。
         これにより、VoiceOverやSwitch Controlなどの支援技術へのサポートをゲームに追加することができます。
         次に、Dynamic Typeです。
         ユーザーの好みに合わせてテキストを拡大縮小できる、使いやすいユーティリティを作成します。
         そして、UI Accommodations。
         これらは、他のユーザーの好みを読み取るのに役立つユーティリティです。
         まず、アクセシビリティの要素から始めましょう。
        この概念を説明するために、簡単なカードゲームを作りました。
         めくり」ボタンをタップすると、ランダムに2枚のカードが引けることがお分かりいただけるかと思います。
         しかし、VoiceOverは画面上のテキストを読み上げませんし、外部スイッチはボタンをタップしないでしょう。
         何がインタラクションできるかをシステムが理解できるようにする必要があります。
         アクセシビリティ要素は、支援技術が相互作用できるものを定義します。
        画面上のテキスト、カード、およびボタンは、アクセシビリティ要素であるべきです。
         そして、各要素をラベルで記述することができます。
         VoiceOverは、それぞれのラベルを読み上げるので、ユーザーは画面に表示されているものを理解することができます。
        また、多言語対応のゲームであれば、これらのラベルもローカライズしておくとよいでしょう。
        さて、VoiceOverは画面に表示されているものを説明することはできますが、タップできるボタンがあることは認識できません。
         そこで、「trait」という別のプロパティを使って、要素の種類をシステムに知らせます。
         ここでは「Button」という特性を追加しましょう。
         これでVoiceOverは「Flip button」と読み、外部スイッチでこのボタンを操作できるようになります。
        また、text要素には「Static Text」特性を追加します。
         静的テキスト」特性は、通常ラベルやテキストエリアに付与され、VoiceOverがよりよいテキストインタラクション体験を提供できるようにします。
        また、「ボタン」や「静的テキスト」以外にも多くの特性があり、調べることができます。
        では、カードにはどんな特性を使えばいいのでしょうか？さて、すべてのアクセシビリティ要素に特性を使用する必要はありません。
         カードには何の特性も必要ないのです。
         しかし、カードにはVoiceOverが認識できない部分、つまり額面があります。
         これには「Value」という別のプロパティがあります。
        " 各カードに「Value」を追加すると、VoiceOverは「Card 1 with value 3 of clubs, card 2 with value Ace of clubs」と読み上げるようになります。
        " というようになります。
         さて、基本を理解したところで、Unityを開いてプロジェクトに追加する方法を確認しましょう。
        ここでは、このゲームのUnityエディタにいるところです。
         このプロジェクトには、Apple Accessibilityプラグインをすでに追加しています。
        まず、カメラ、ダイレクトライト、UIキャンバスのような通常のシーンオブジェクトがあります。
         キャンバスの下には、2つのテキストエレメントとボタンがあります。
         その後、カード用のゲームオブジェクトを2つ用意しました。
        それぞれ、2つのメッシュコンポーネントで構成され、カードの表と裏のテクスチャをそれぞれレンダリングします。
         まず、アクセシビリティ要素を定義することからはじめましょう。
         そのためには、このプラグインにある Accessibility Node コンポーネントが必要です。
        階層内のアクセシブルにすべきオブジェクトをすべて選択します。
        そして、アクセシビリティ・ノード・コンポーネントを追加して、アクセシビリティ要素にします。
        次に、ラベルを追加します。
         カードオブジェクトを選択し、右側の「Accessibility Node」コンポーネントを開き、「Label」フィールドを見つけます。
        そして、カスタムラベルを提供するために、ラベルフィールドチェックボックスがチェックされていることを確認します。
        そして、"Card 1 "と入力します。
        " カード2も同じように入力します。
        テキストとボタンにもラベルが必要ですが、Unity UIの標準コントロールを使用する場合は、明示的なアクセシビリティラベルを提供する必要はありません。
         プラグインには、それらのためのデフォルトの実装がすでにあります。
        次に、ボタンにtraitを追加する必要があります。
        フリップボタンを選択し、「Traits」を「None」から「Button」に変更します。
        " 2つのテキスト要素を選択します。
        ...そして「Traits」を「static text」に変更します。
        " 素晴らしい
         最後に、カードの表面のアクセシビリティのValueを設定する必要があります。
         カードはランダムに描かれるので、値を動的に設定するスクリプトを追加する必要があります。
        2枚のカードを選択し、AccessibleCardという新しいスクリプトを追加します。
        まず、私の他のC Sharpファイルの1つに、Playing Cardというすべてのカードの面を表すenumがすでにあります。
         新しいAccessibleCardモノ動作スクリプトでは、カードの種類を表す変数と、カードが上向きか下向きかを表すブール値を用意しています。
        では、これらのカードにアクセシビリティバリューを追加してみましょう。
         まず、このgameObjectにaccessibilityNodeというコンポーネントをくっつけます。
        次に、accessibilityValueデリゲートに、カードの表向きの値を動的に返す関数を設定します。
        この関数の中で、カードがカバーされている場合は、accessibilityValueに「covered」を返します。
         また、カバーされていない場合は、すべてのカードフェイスを列挙し、それぞれについて「スペードのエース」のような説明を返します。
        " といった具合です。
         それでは、プロジェクトをビルドして、その動作を確認してみましょう。
         これが私たちのゲームです。
         VoiceOverをオンにしてみましょう。
        自動音声です。VoiceOver on.
         エリックのゲームです。
         カード2、カバーされています。
         エリック:右にスワイプして次の要素に移れるんだ。
         自動音声: カード1、カバーされています。
        エリックのカードゲーム。
        カードをめくります。
        めくって
         ボタンを押す。
         Eric: 5つのオブジェクトがすべてVoiceOverでアクセスできるようになったのがわかりますね、これはすごいことです。
         VoiceOverがオンのときにボタンをタップするには、ダブルタップしてください。
         自動音声です。めくってください。
         Eric: もう一度、カードを確認してみましょう。
        自動音声: カード1、クラブの2
        カード2、クラブのエース。
         Eric: VoiceOverは更新されたカード面を正しく読み取るようになりました。
         かっこいいですね。
         これで、何百万人ものVoiceOverのユーザーが、私たちのゲームにアクセスできるようになり、その人たちは、このゲームに夢中になることができるようになりました。
         また、外部スイッチコントロールを使っている人たちも、私たちのゲームをプレイすることができます。
         これが、アクセシビリティの要素です。
         次に、Dynamic Typeについて説明します。
        ゲームは、文字が小さくて読みにくいという理由で、多くの人にとってプレイしにくいものです。
         iOSとtvOSでは、誰でも「設定」で自分の読書能力に合った文字サイズを選ぶことができます。
        Accessibility Pluginを使えば、この設定を読み込んで、ゲーム内のテキストが期待通りの大きさで表示されるようにすることができます。
        ゲームの例で、Dynamic Typeの使い方をみてみましょう。
        DynamicTextSize という Mono ビヘイビアスクリプトを作成します。
        csを作成します。
         start関数の中で、まずデフォルトのテキストサイズを変数に格納します。
        次にOnEnable関数内で、AccessibilitySettings.onPreferredTextSizesを使って設定変更イベントをサブスクライブします。
         onPreferredTextSizesChangedを使用します。
         これにより、ユーザーがテキスト設定を変更するとすぐにUIを更新することができます。
        次に、settingsChanged関数内で、まずPreferredContentSizeMultiplierを読み取ります。
         次に、SettingsChanged関数内で、まずPreferredContentSizeMultiplierを読み込み、元のテキストサイズを掛けてtext要素に割り当て直します。
        Unity Editor内で、Text要素を持つゲームオブジェクトを全て選択します。
         そして、先ほど作成したDynamicTextSizeコンポーネントを追加します。
        これでDynamicTextSizeのサポートは完了です。
         この結果を実際に見る前に、まず、ゲームでDynamic Typeをすばやくテストするためのトリックを紹介します。
         設定]を開き、[コントロールセンター]を見つけます。
        テキストサイズ]が表示されるまで下にスクロールし、[コントロールセンター]に追加します。
        これで、コントロールセンターを開いてテキストサイズのオプションを変更することで、テキストサイズをすばやく調整できるようになりました。
        文字サイズを変更すると、ゲーム内の文字サイズもリアルタイムで調整されます。
        Control Centerで表示されるテキストのパーセント値は、まさにその倍率から読み取ったものです。
         また、この設定は、テキスト以外のオブジェクトにも適用できます。
         たとえば、カード表面の資産を、サイズが大きくなったときにLarge Printに入れ替えることができるんだ。
        まず、DynamicCardFacesというスクリプトを作成する。
         そして、先ほどと同じようにTextSizeChangedイベントをサブスクライブする。
        倍率を読み取る代わりに、コントロールセンターのスライダーの刻みにマッピングされたテキストサイズカテゴリの列挙を読み取ります。
         誰かがより大きなテキストサイズを選択するたびに、アセットを交換することができます。
        そして、通常の素材と大判の素材のどちらかを選ぶだけです。
         ここで、本当に大きなサイズを選択すると...。
        ユーザーには大判のカードが表示され、弱視の方にも読みやすい素晴らしいカードフェイスになります。
        最後に、このプラグインでアクセスできるUIアコモデーションの設定についてお話したいと思います。
        1つ目の設定は、「透明度を下げる」です。
         この設定をオンにすると、背景がぼやけたり透明になったりする効果ではなく、不透明になる効果があります。
         これらの効果によってテキストが読みにくくなる場合、読みやすさを向上させることができます。
         この設定を確認するには、AccessibilitySettings.IsReduceTransparencyを呼び出します。
         IsReduceTransparencyEnabledを呼び出します。
        次に、「コントラストを上げる」設定です。
         スイッチのグレーが濃くなって目立つようになり、デバイス全体でコントロールを認識しやすくなっていることに注目してください。
        この設定を有効にした場合、AccessibilitySettings.IsIncreaseContrastEnabledでこの設定を確認することにより、独自のUIでコントラストを高めることができます。
         IsIncreaseContrastEnabledでチェックします。
        次に、「動きを抑える」設定です。
         このカードめくりアニメーションのように、動きに敏感な人もいます。
        Reduce Motionを有効にすると、そのアニメーションは削除されるはずです。
        そのためのコードを見てみよう。
        CardControllerスクリプトの中に、以下のFlip関数がある。
         まず、ユーザーのリデュースモーションの設定がオンになっているかどうかをチェックします。
         もし、オンになっていなければ、Coroutineでアニメーションを実行して、カードを反転させる必要がある。
         そうでなければ、回転を設定するだけで、アニメーションは行わない。
         それだけだ。
         これで、動きに敏感な人もこのゲームを楽しめるだろう。
         まとめ：このセッションのリソースにあるGitHubリポジトリをクローンして、Apple Accessibilityプラグインを使い始めましょう。
        VoiceOverやSwitch Controlをあなたのゲームで使えるように、アクセシビリティの要素を追加してください。
        Dynamic Typeを使用してテキストサイズを調整します。
        そして、誰もがゲームで素晴らしい体験をできるように、UIアコモデーションをチェックしましょう。
        ご参加ありがとうございました。
         アクセシビリティに配慮した、誰もが楽しめるゲーム作りをお待ちしています。
        """
    }


}
