import Foundation

struct WhatsNewInSafariAndWebKit: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "What's new in Safari and WebKit"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6541/6541_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10048/")!
    }

    var english: String {
        """
        Hi there! I'm Kendall Bagley, a software engineer on the Safari team.
        It's been a full year since we last got together at WWDC, and today, we're going to be talking about all the amazing features and enhancements to Safari and WebKit from both what's new here at this year's WWDC and from what we've seen throughout this whole past year.
        In fact, it's been quite a busy year! Since last fall, each release of Safari has delivered new and exciting features that we know y'all as web developers have been asking for.
        Each of the new enhancements delivered this year aimed to address some of the biggest points of feedback you've been sharing with us.
        Like adding a parent selector with the :has() pseudo class, the new flexbox inspector, and even container queries.
        We want to make your daily work that much better and easier while building the best and most powerful software for the web.
        In fact, what's here is just some of the new content that we'll be going over today.
        But there's so much more that we wouldn't possibly be able to cover it all in this one session.
        There's been a total of 162 new web platform features and improvements across the seven Safari releases this past year.
        We've been proud to provide so many new tools for you to use to make your websites and web apps.
        And for macOS, the best way to see what's new and exciting as soon as possible is through Safari Technology Preview, where you can try out the latest and greatest for Safari and WebKit and also help us know what we should have come next.
        But like you saw, there's a whole bunch of new features, so let's take a look at everything that we're going to cover.
        Today we'll be looking at new HTML features, CSS enhancements -- including a bunch to help your code architecture -- new Web Inspector tools, a wide selection of new web API, great JavaScript and WebAssembly features, and improvements to security and privacy.
        So, let's get started with what's new with HTML by taking a look at a web page I'm creating for my coworkers and I to use.
        I personally really like to thrift and repurpose my clothes as a way to make my wardrobe more sustainable, and I thought a clothing swap website would be a great way to have my team try it out too.
        My design for the site includes a Request Item button that should show you a form to fill out when you spot a piece of clothing that you like.
        And I want that form to show up in an overlay over top of the whole page.
        The new dialog element provides a really easy way to create overlays in a robust and accessible manner that we can use for our request form.
        And the new backdrop pseudo-element in CSS makes it possible to style the background behind the modal.
        Let's bring up the dialog by requesting an item.
        See that shadow and animation? It's really looking great! Then, once an item is requested on our site, the person who posted it needs to be able to accept the request.
        At the bottom of the page, there's a carousel to flip through all your received requests.
        But I don't want someone to accidentally interact with a button or a text field for one of the items that's not the frontmost, with either clicks or keyboard navigation.
        I can use the inert attribute to fix this.
        By dynamically applying the inert attribute with the JavaScript here, I'm disabling any interactions for elements on slides that aren't the currently selected slide as we switch between them.
        And, using inert includes disabling interactions for assistive technologies and prevents screen readers from reading those disabled items aloud, giving much clearer guidance on which elements are intended for interaction.
        And lastly for HTML, there's the new lazy loading for images.
        On my site, there's some icons in the header that I need to load right away, but for the clothing item images that are offscreen on that first load, we can utilize lazy loading for them, so the images only load when the user scrolls to them, making the page feel faster and more responsive.
        I'm really loving how the site's looking so far, and it's going to work great for those using assistive technologies as well.
        And those HTML features are just getting us started, because there's so much to check out with CSS this year too.
        A huge part of our CSS focus has been around making your CSS easier to reuse through more powerful architecture.
        With that, we know the number one request for new web technology has been container queries.
        And we're thrilled to announce container queries will ship in Safari 16! You'll be able to use both size queries and container query units.
        Here, I'm experimenting with an alternative layout for the clothing swap website.
        I'm making the card that presents a piece of clothing into a reusable component and dropping that component into several different places in the page layout.
        Here in the sidebar, the available space is a bit narrow, so I want all the content inside my component to stack vertically.
        In the main grid of items, I want to feature the first one as a hero graphic that should take up all the available space horizontally and arrange the content in a fashion that makes more sense for a wide layout.
        The rest of the items in the main content area should be divided into smaller columns.
        So I've created another layout that works when there's a medium amount of horizontal space.
        Using container queries to handle the change in the layout, rather than media queries, I can write the layout code for this component just once and use that component any place on my site in a container of any size, and the correct layout will always get applied.
        I specified which element to use for the container and whether I want to measure against just the inline size or both inline and block size at the same time, by using the container-type property.
        I can optionally name my container using the container-name property, which gives me more flexibility in how I structure the HTML.
        Then I use the @container rule to apply styles conditionally, based on the size of the container.
        Here, if the clothing card component is in a container that's wider than 250 pixels, the grid will change to have two columns instead of one.
        Next up with CSS architecture: cascade layers.
        This is a powerful change to the CSS cascade.
        Since the beginning of CSS, the cascade has been made up of these different layers.
        But no matter what specificity of any given selector inside each layer, author styles -- the styles you write as web developers -- always beats UA styles.
        Inline styles are always more powerful than author styles, and so on with the rest of the hierarchy.
        Cascade layers takes this same concept and allows you to create your own custom layers where specificity is calculated independently inside each layer.
        One entire layer beats another entire layer, no matter what the specificity is of the selectors being used.
        And you determine which layer has power over the others through the order of how you define the layers in your CSS.
        Cascade layers will be a useful tool for architecting CSS on large projects and maintaining that code over time.
        Perhaps your team will use them to separate a design system from overrides or a framework you're using for custom styles for your project.
        It's totally up to you! And, to round out all the amazing new enhancements for your CSS architecture is :has(), a pseudo-class that can act as the long-wanted parent selector and much more.
        Combined with any other selector in CSS, :has() can look for siblings, attributes, states of form fields, and much more.
        It's really powerful.
        Here, I want to highlight the entire message box whenever someone has checked the "Urgent?" checkbox for one of their messages.
        I can use the :has pseudo-class here to say that anytime the form element has an input of type checkbox with that checkbox checked, apply this CSS.
        And I don't even need to use any JavaScript.
        We hope all these great improvements to handling your CSS architecture, with :has(), cascade layers, and container queries, make your work as a web developer that much better.
        But these aren't the only CSS additions that we're excited about.
        You've wanted a tool similar to existing viewport units but would be more useful on devices where scrolling causes the size of the viewport to change.
        And for that, there's new viewport units for y'all.
        When you want to know the height of the viewport when it's at its smallest, use svh.
        For the height of the viewport when it's at its largest, use lvh.
        Just remember: s for small, l for large.
        For a dynamic number that changes to always match the current actual height of the viewport, use dvh.
        And it's not just for height.
        We've got you covered with even more viewport units.
        There's width units, which are good for completeness to match up with the highly used height units.
        We've got block and inline -- both being useful when writing for multiple languages with differing ways in which text can flow.
        And we didn't forget, min and max, too.
        But what about when you want to create some movement on your page, not just react to it? Animation has previously been very declarative where you can specify a start, an end, and a duration to get objects moving.
        But it's been a challenge to animate elements on a page either when trying to get it to follow a curved path or even just being able to move it around by an offset.
        And I'd like to add a secret animation for the header when you click on it, Really just thought it'd be fun.
        With the new offset-path, you can define a path that you want your object to animate along.
        Set the path with offset-path and use offset-distance for the keyframe effect.
        Then use the animation property to apply the keyframe effect, giving you all the control you'd want with your animations, all in CSS.
        We also want to give you more control over your page even with the parts of the web that have typically been defined by the browser engine itself, and over scroll-behavior is just our first example of this.
        Since the beginning of the web, if you click on a link that moves you to another part of a web page, it visually appears as a jump.
        Sometimes this is disorienting to your users.
        The scroll-behavior property in CSS provides a way to specify if you want this behavior or not.
        By default, it's set to auto, and it'll appear as that jump.
        By specifying scroll-behavior as smooth, you can ask the browser to instead scroll smoothly to the next place on the page.
        You can also do this with the JavaScript methods window.
        scroll(), scrollTo(), or scrollBy().
        You know your customers best and should be able to define your own web page experience outside of the browser engine defaults, which is also where the use of :focus-visible as well as accent-color can come into play.
        You're probably familiar with the focus selector if you've ever wanted to apply a specific style to the focus indicator, likely to have it more in line with your overall design.
        But there are some accessibility pitfalls of losing the browser-based heuristic when you do that.
        And on my site, instead of the built-in form colors, I'd love to use a custom color.
        Let's use the teal color that's already in my header for both the focus highlight and the checkbox.
        With the :focus-visible pseudo-class, you can style the focus indicator how you choose while also having that stylized indicator only show if it would be shown natively by the browser.
        And to add another layer of customization to your forms, you can use accent-color to change the color of different parts of the form control UI.
        It'll take affect on that checkbox as well as radio buttons, and so much more.
        Also with CSS, we've been replacing more and more of the WebKit prefixes.
        These used to be the perfect way to try out experimental features, but now, we're able to move towards their standards-defined properties to make your CSS easier to write and more interoperable.
        But don't worry, your existing CSS with WebKit prefixes will keep working as you transition to their web standards counterparts.
        Backface-visibility, print-color-adjust, and text-align: match-parent are all exactly the same as their prefixed counterpart.
        Both mask and text-combine-upright have had their syntax updated from the prefixed version to match the standard.
        And the nonprefixed appearance property also adds support for the new auto value but has removed the WebKit-specific values in Safari 16, like caret or listitem, as it got brought up to standards specifications.
        There's been a lot to note about our typography additions as well.
        In particular, we've added the font-palette property that allows for easy selection of a color palette within a color font.
        It's something that I think would be really cool to try out with some potential logos for my site.
        We can test out how it looks with the built-in dark or light palettes or even what it'd be like to customize it to exactly what I want with color overrides and get some yellow in there to brighten it up.
        And with typography, there's been the addition of text-decoration-skip-ink, which allows you to control what happens when an underline or overline intersects with a letter or character.
        Plus the ic unit, which makes it possible to precisely line up CJK characters in the block direction.
        It's useful for creating a clean typography grid in languages like Chinese, Japanese, and Korean.
        To wrap up our discussion of all these great CSS features, we've definitely got to talk about subgrid.
        For years, layout on the web was pretty hard.
        CSS Grid has been revolutionary, but it only affects the direct children of a grid container.
        Here, I'm using CSS Grid to layout these cards, and to automatically adjust the layout to fit the viewport width by adding and removing columns without any media queries.
        But the size of the content on each card isn't the same; some headlines are longer, the photos have different aspect ratios, and that's causing the visuals to look really messy.
        I'd like for all the Request Item buttons and the message boxes to line up across the page, and I'd like a longer title on one card to affect the layout on the other cards, so they all get the same spacing.
        Now, we can accomplish this using subgrid.
        I've put a grid on each article, and I've tied all of those grids to the grid of their parent simply by writing "grid-template-rows: subgrid.
        " You can see how all the content on each clothing card now perfectly lines up by using the Grid Inspector in Web Inspector where I can turn on all the grids I could possibly need too.
        A lot of CSS work becomes easier when we use the Web Inspector.
        In fact, there's been some amazing additions to the Web Inspector that I think you'll be really excited to try out.
        First off, layout is easier to write when you can see what's going on, which is exactly what makes the Web Inspector so important.
        And with the new Flexbox Inspector, you can actually visualize the spacing between elements.
        Here on my website, I was having some trouble adding these icons to my header.
        All I need to do is inspect the element, and go to the Layout tab, and since I'm not concerned with my grids right now, I can go ahead and collapse that section to get right to the new Flexbox Inspector.
        I can even turn on all the views with just a single click and still have smooth performance.
        And with all the views turned on, I can clearly see with the hash marks and container boxes how my elements are being arranged and how the empty space is taking up the view.
        So now I want to make sure I'm getting my alignment right, which I can use the new alignment editor for.
        I can go to the Styles tab to find a new button next to align-items.
        Here, I'm able to toggle through the different options to find what works best for my header, and I can do the same with justify-content as well.
        Again, just toggling through each of the options and then landing on the one that I think looks just right.
        I also think the yellow icons are a bit too small, and I want to try making them the same size as the red icons, which I believe are using a variable with "medium" in the name, but I really can't remember the full name.
        I can try out changing the size by inspecting one of the yellow icons and editing its height in the inspector.
        And, thanks to our new CSS fuzzy autocompletion, I can go ahead and type "medium" and the variable I want pops up even though "medium" is at the end of the name.
        And those yellow icons definitely aren't too small anymore.
        And when those other variables for the different icons aren't being used for the element I'm inspecting, they get hidden away with our new CSS tooling.
        But don't worry, there's a button to reveal them when you need them.
        And probably most excitingly for Web Inspector this year, we are happy to announce support for developer tool extensions for the Safari Web Inspector.
        The creators of your favorite developer tools extensions will now be able to port them to Safari, using the same underlying APIs that they use in other browsers.
        If you're interested in learning how to make an extension for the Web Inspector, exploring the new APIs, and getting set up to start using them yourself, make sure to watch "Create Safari Web Inspector Extensions" at this year's WWDC.
        Now we've covered a lot of what's new with our front-end technologies, so let's switch gears and get into what's new with our web APIs.
        Which we are so excited to announce support for web push.
        It'll be available in Safari 16 on macOS Ventura.
        It's coming to iOS and iPadOS next year.
        Web push lets you remotely send notifications to your users from your website or web app.
        This is a fully interoperable, standards-based implementation.
        If you've implemented web push already and it works in other browsers, it should just work in Safari without any modifications.
        And you don't need an Apple Developer account either.
        To learn all about the details, watch "Meet Web Push for Safari" here at WWDC22.
        If you're excited about web push, then you'll probably be excited about new web app manifest improvements too.
        Now, you can define the icon that's used when people save your web app to the Home Screen in your manifest file.
        To have the icons in the manifest take precedence, you'll need to ensure that there is no apple-touch-icon defined in the HTML head.
        If you want to deliver one icon to iOS and iPadOS, while delivering a different icon to other mobile platforms, you can still do so by defining the icon for Apple devices in that HTML head using the apple-touch-icon.
        And if you don't declare an icon in either place, then when a user saves your site to the Home Screen, they'll simply get a screenshot of your site.
        Excitingly, we also no longer wait for the user to choose "Add to Home Screen" from the Share menu to load the manifest file, which means you can use that manifest file to define characteristics of your web page on all your sites and even further reduce the need to use meta tags.
        Continuing with our APIs, we've done a lot to improve the use of web pages in multiple browsing contexts with the same origins.
        Broadcast channels allow you to send notifications between those different browsing contexts.
        Let's imagine someone is using the clothing swap website and they have it open in two windows at the same time.
        Then they claim a piece of clothing in one window.
        We'll be able to post a message and sync that unavailable state to any other open tabs or windows.
        But maybe it's not updating a tab in the background, but updating a file saved for your site.
        For that, there's been the addition of the File System Access API.
        We've had incremental updates to this API across multiple releases this year, starting with origin private file system, which is private storage based on origin.
        So for instance, my clothing swap site wouldn't have other sites, like apple.
        com, reading its files.
        We then added to the API with the getFile() method of FileSystemFileHandle, which reads an existing file retrieved from your site's root directory, like we're doing with a draft file here that we also happened to have just created.
        Now let's take a look at our most vibrant API addition this year with some new color richness.
        The Display P3 color space makes it possible to represent colors that just don't exist in RGB.
        Here, we've got some examples of the color picker.
        On the left of the squiggly white line is color that exists in RGB.
        And on the right of the line are colors only available in P3.
        In 2016, we added P3 support for videos and photos.
        Last year, we were thrilled to be the first browser engine to implement the new color syntax defined in CSS Color Level 4.
        This year, we've added support for P3 color for content inside the canvas element.
        So, no need to use the colors based on devices all the way from the 90s, when you can now start utilizing the full color capabilities of all the amazing devices of today.
        But there's even more to check out with our new Web APIs from this past year, including shadow realms, web locks, and updated support to the ResizeObserver API for the ResizeObserverSize interface, which will help you observe changes to an element's box-sizing properties.
        There's so much to try out across all of our new API additions, and of course, with all of our new features too.
        In fact, we've still got more to cover.
        So let's next get into all that's new in JavaScript & WebAssembly.
        If your website uses workers, and you want instances of these workers to be shared across tabs and windows, then the new shared workers interface will definitely help and potentially reduce memory usage.
        Instead of spawning new workers for every task that you want to happen in the background, you can have just one worker in use for each browsing context with the same origin.
        Each script would create a shared worker in the same way, and then they can receive and post messages using the same port.
        The shared worker would be able to receive and respond to messages sent from all of the different scripts.
        This will result in less demand on your servers, while also making your webpage fast and responsive for your customers.
        We've also got a whole array of array features to show you.
        Instead of having to mutate an array using reverse() when you want to search from the end, you now can use the findLast() and findLastIndex() methods, like I've done here to find the item and index for the last item containing a "shoestring.
        " The new at() method also makes searching from the end of an array even easier.
        Using braces works great when the index is positive, but with at(), we get the additional feature of indexing with negative values making your code more concise and readable.
        But even with that good number of new array features, nothing much can beat the sheer number of new internationalization features we got for you.
        WebKit has continued to add regular updates to our Intl implementation throughout this past year.
        There's been added support for different numbering systems with new methods in NumberFormat, calendars, thanks to updates with Locale as well as DisplayNames, and currency with the Intl Enumeration API.
        And like I said, there's a lot that's been added to our Intl implementation this year that you'll have no shortage of things to try out and explore to cater to your users across the world.
        And for all those that have existing code in all sorts of different coding languages, like C, Objective C, or Swift, that they'd like to bring to the web, WebAssembly gets them running without any need to rewrite.
        And with this year's improvements, your web apps using WebAssembly are only getting more powerful with the addressable memory being expanded to 4GB, and the performance gains that come with the new zero-cost exception handling.
        Overall, there's definitely some exciting stuff for JavaScript and WebAssembly to try out here.
        And speaking of WebAssembly, we also have some security and privacy enhancements that not only will protect the users of the web who we develop for, but will also bring new potential for you as developers.
        With both of the new Cross Origin Opener Policy and Cross Origin Embedder Policy HTTP response headers, your site can opt in to process isolation, which means your site will run in its own dedicated webContent process.
        We know that a lot of apps can benefit from running on multiple threads in parallel using WebAssembly threading, and with these new headers, you're able to do so securely.
        Our second security enhancement also involves HTTP headers with our improved support for content security policy level 3.
        CSP provides enhanced security control over your loading content and mitigates risk of cross-site scripting and other vulnerabilities.
        With the level 3 updates, the most exciting addition has been the new strict-dynamic source expression.
        The designers of strict-dynamic realized you can use nonces to allow certain scripts, then extend that trust to scripts loaded by the already trusted ones.
        No explicit allow list needed.
        Look how much simpler the header becomes.
        Going from that original long list of domains that could potentially end up allowing too much.
        And with that, we wrap up our security and privacy features, which also brings us to the end of all that we'll get to cover today, but there's even more to explore on your own.
        For instance, we've had media updates including support for capturing a specific Safari window with the getUserDisplay() API, WebRTC Perfect Negotiation, In-band chapter tracks, and requestVideoFrameCallback().
        As well as a lot of cool additions for web extensions with manifest version 3 support, and a bunch of new web extensions APIs.
        To dive deeper into all these features covered here today, and to explore all the 162 features and improvements developed in Safari and WebKit in the past year, make sure to download Safari Technology Preview to keep up with what's coming in the future, explore web technology by checking out our release notes, blog posts, and all the great content on webkit.
        org, including extensive documentation for Web Inspector.
        And as always, let us know what you think and what you'd like to see next by filing your bug reports.
        If you come across a bug in WebKit -- something about HTML, CSS, JavaScript, DOM APIs, or the Web Inspector -- make sure to send your feedback through WebKit's bug tracking system at bugs.
        webkit.org.
        And for suggestions or bugs with the Safari interface, file issues in Apple's Feedback Assistant.
        We look forward to delivering more of the amazing features that make the work of web developers like you that much better with all the Safari and Safari Technology Preview releases to come in this next year.
        Thank you for joining me today, and I hope you have the best time here at WWDC.
        Bye now!

        """
    }

    var japanese: String {
        """
        こんにちは。Safariチームのソフトウェアエンジニア、Kendall Bagleyです。
        今日は、今年のWWDCでの新機能と、この1年を通して私たちが見てきたことの両方から、SafariとWebKitの素晴らしい機能と強化についてお話します。
        実際、この一年は非常に忙しい年でした。昨年の秋以来、Safariの各リリースは、ウェブデベロッパの皆さんが求めていた新しいエキサイティングな機能を提供してきました。
        今年提供された新しい機能強化はどれも、みなさんから寄せられた最大のフィードバックのいくつかに対応することを目的としています。
        たとえば、:has() 擬似クラスによる親セレクタの追加、新しいフレックスボックスインスペクタ、さらにはコンテナクエリなどです。
        私たちは、ウェブ用の最高で最強のソフトウェアを作りながら、みなさんの日々の仕事をより良く、より簡単にしたいと願っています。
        実は、ここにあるのは今日ご紹介する新コンテンツの一部に過ぎません。
        しかし、このセッションですべてをカバーすることはできないほど、多くの内容があります。
        この1年間にリリースされた7つのSafariでは、合計162の新しいWebプラットフォーム機能と改良点がありました。
        WebサイトやWebアプリケーションを作るために、たくさんの新しいツールを提供できることを誇りに思います。
        macOSでは、SafariとWebKitの最新かつ最高の機能を試せるだけでなく、私たちが次に何をすべきかを知るために、Safari Technology Previewを通じて、新機能やエキサイティングな機能をできるだけ早く確認するのが最適な方法です。
        しかし、ご覧いただいたように、たくさんの新機能があります。
        今日は、新しい HTML 機能、CSS の強化 -- あなたのコード・アーキテクチャに役立つたくさんの機能を含む -- 新しい Web Inspector ツール、幅広い選択肢の新しい Web API、優れた JavaScript と WebAssembly 機能、そしてセキュリティとプライバシーの改善について見ていきます。
        では、さっそくHTMLの新機能を、私が同僚と一緒に作るWebページを見てみましょう。
        私は個人的に、自分のワードローブをより持続可能なものにするために、服を古着にして再利用するのがとても好きなのですが、服の交換サイトは、私のチームにも試してもらうのに素晴らしい方法だと思いました。
        私のデザインでは、「Request Item」ボタンがあり、気に入った服が見つかったら、フォームに記入してもらうようにしました。
        そして、そのフォームをページ全体の上にオーバーレイ表示させたいと思っています。
        新しい dialog 要素は、リクエストフォームに使用できる、堅牢でアクセスしやすい方法でオーバーレイを作成する、実に簡単な方法を提供します。
        また、CSS の新しい backdrop 擬似要素により、モーダルの背後にある背景をスタイル設定することができます。
        アイテムを要求してダイアログを表示させてみましょう。
        この影とアニメーションを見てください。とても素敵になりましたね。そして、私たちのサイトでアイテムがリクエストされたら、それを投稿した人がリクエストを受け入れることができるようにする必要があります。
        ページの下部には、受け取ったリクエストをすべて表示するためのカルーセルがあります。
        しかし、一番前ではない項目のボタンやテキストフィールドを、誰かがクリックやキーボード操作で誤って操作してしまうのは困ります。
        これを解決するために、inert属性を使用することができます。
        このJavaScriptでinert属性を動的に適用することで、現在選択されているスライド以外のスライドを切り替える際に、そのスライド上の要素に対するインタラクションを無効にしているのです。
        また、inertを使用すると、支援技術のためのインタラクションが無効になり、スクリーンリーダーがそれらの無効な項目を音声で読み上げるのを防ぐことができ、どの要素がインタラクションを意図しているのかについてより明確なガイダンスを提供することができます。
        そして、HTMLの最後には、画像の新しい遅延ロードがあります。
        私のサイトでは、ヘッダーにあるアイコンをすぐに読み込む必要がありますが、最初の読み込みで画面外に出てしまう衣料品の画像については、遅延読み込みを利用して、ユーザーがスクロールしたときにのみ画像を読み込むようにし、ページの高速化と応答性の向上を実現しています。
        今のところ、このサイトの見た目はとても気に入っていますし、支援技術を利用している人にとっても素晴らしいものになるでしょう。
        HTMLの機能はまだ始まったばかりですが、今年はCSSについてもチェックすべきことがたくさんあります。
        CSSについては、より強力なアーキテクチャによってCSSの再利用を容易にすることに重点を置いています。
        そのため、新しいウェブ技術に対する要望の第一位がコンテナクエリであることを私たちは知っています。
        そして、コンテナクエリがSafari 16に搭載されることを発表できて、とてもうれしく思っています。サイズクエリとコンテナクエリの両方のユニットを使用できるようになります。
        ここでは、洋服の交換会のウェブサイトで、別のレイアウトを試しています。
        洋服を紹介するカードを再利用可能なコンポーネントにして、そのコンポーネントをページレイアウトのさまざまな場所にドロップしています。
        サイドバーでは、スペースが狭いので、コンポーネント内のコンテンツをすべて縦に並べています。
        メイングリッドのアイテムでは、最初の1つをヒーローグラフィックとしてフィーチャーし、水平方向に空いているスペースをすべて使って、ワイドレイアウトでより意味のある方法でコンテンツを配置したいと思います。
        メインコンテンツの残りのアイテムは、小さなカラムに分割して配置します。
        そこで、横方向に中程度のスペースがある場合に有効な別のレイアウトを作成しました。
        メディアクエリではなくコンテナクエリを使ってレイアウトを変更することで、このコンポーネントのレイアウトコードを一度書くだけで、サイト上のどの場所のどのサイズのコンテナでも、常に正しいレイアウトが適用されるようにすることができます。
        コンテナに使用する要素と、インラインサイズのみ、またはインラインとブロックの両方のサイズを同時に測定するかどうかを、container-typeプロパティで指定しました。
        コンテナの名前はcontainer-nameプロパティで任意に指定できるので、HTMLの構成がより柔軟になりますね。
        次に、@containerルールを使って、コンテナのサイズに応じたスタイルを条件付きで適用しています。
        ここでは、幅が250ピクセル以上のコンテナ内に衣類カードコンポーネントがある場合、グリッドは1列ではなく2列に変更されます。
        CSSアーキテクチャの次は、カスケード・レイヤーです。
        これは、CSSのカスケードに対する強力な変更点です。
        CSSの登場以来、カスケードはこのようなさまざまなレイヤーで構成されてきました。
        しかし、各レイヤー内の任意のセレクタがどのような特異性を持っていても、オーサー・スタイル（ウェブ開発者として書くスタイル）は、常にUAスタイルに勝ります。
        インライン・スタイルはオーサー・スタイルよりも常に強力であり、他の階層も同様です。
        カスケードレイヤーはこれと同じ概念で、各レイヤーの内部で独自に特異性を計算する独自のレイヤーを作成することができるのです。
        あるレイヤー全体が別のレイヤー全体に勝ることは、使用されているセレクタの特異性がどのようなものであっても同じです。
        そして、どのレイヤーが他のレイヤーより強いかは、CSSでレイヤーを定義する順番で決まります。
        カスケードレイヤーは、大規模なプロジェクトでCSSを設計し、そのコードを長期にわたって維持するために有用なツールです。
        また、デザインシステムとオーバーライドを分離したり、プロジェクトのカスタムスタイルに使用するフレームワークに使用することもできます。
        それは完全にあなた次第です。そして、CSSアーキテクチャのための素晴らしい新機能を締めくくるのは、念願の親セレクタとして機能する擬似クラスである :has() です。
        CSSの他のセレクタと組み合わせることで、兄弟や属性、フォームフィールドの状態など、さまざまなものを検索することができます。
        実に強力です。
        ここでは、誰かがメッセージのひとつにある「緊急」チェックボックスをチェックしたときに、メッセージボックス全体を強調表示することにします。
        ここで :has 疑似クラスを使用すると、フォーム要素にチェックボックスタイプの入力があり、そのチェックボックスがチェックされると、いつでもこの CSS を適用するようにできます。
        そして、JavaScript を使用する必要もありません。
        has()、カスケード・レイヤー、コンテナ・クエリなど、CSSアーキテクチャの扱いに関するこれらの素晴らしい改善により、あなたのウェブ開発者としての仕事がより良いものになることを願っています。
        しかし、私たちが期待しているのは、このようなCSSの追加機能だけではありません。
        既存のビューポートユニットに似たツールで、スクロールによってビューポートのサイズが変化するようなデバイスでより便利に使えるものを求めていました。
        そのために、新しいビューポートユニットを用意しました。
        ビューポートが最も小さいときの高さを知りたいときは、svhを使用します。
        最大時のビューポートの高さは、lvhを使用します。
        sは小さい、lは大きいと覚えておいてください。
        ビューポートの現在の実際の高さに常に一致するように変化する動的な数値には、dvhを使用します。
        また、高さだけではありません。
        さらに多くのビューポート単位を用意しています。
        幅の単位がありますが、これは非常によく使われる高さの単位と一致させるのに適しています。
        ブロックとインラインは、テキストの流れ方が異なる複数の言語向けに記述する場合に便利です。
        そして、minとmaxも忘れてはならない。
        しかし、単に動きに反応させるだけでなく、ページに動きをつけたい場合はどうしたらいいのでしょうか。これまでアニメーションは、オブジェクトを動かすための開始、終了、継続時間を指定できる、非常に宣言的なものでした。
        しかし、ページ上の要素を曲線に沿って動かしたり、オフセットで移動させたりすることは困難でした。
        また、ヘッダーをクリックしたときのシークレットアニメーションを追加したいのですが、これは面白いですね。
        新しいoffset-pathを使えば、オブジェクトをアニメーションさせたいパスを定義することができます。
        offset-pathでパスを設定し、offset-distanceでキーフレームエフェクトを使用します。
        次に、animation プロパティを使用してキーフレーム効果を適用すると、CSS でアニメーションのすべての制御が可能になります。
        また、一般的にブラウザエンジンによって定義されているウェブの部分についても、ページをより自由にコントロールできるようにしたいと考えており、スクロールの挙動については、その最初の例に過ぎません。
        ウェブが始まって以来、ウェブページの別の場所に移動するリンクをクリックすると、視覚的にジャンプするように表示されます。
        時には、これはユーザーにとって見当違いなことです。
        CSS の scroll-behavior プロパティは、この動作をさせるかどうかを指定する方法を提供します。
        デフォルトではautoに設定されており、ジャンプしたように表示されます。
        scroll-behaviorにsmoothを指定すると、ページの次の場所までスムーズにスクロールするようにブラウザに指示することができます。
        これは、JavaScriptのメソッドwindow.Scroll()、window.ScrollTo()でも行えます。
        scroll()、scrollTo()、scrollBy()などのJavaScriptメソッドでも可能です。
        ブラウザエンジンのデフォルト以外の独自のウェブページ体験を定義することができるのは、顧客のことを一番よく知っているあなたです。
        フォーカスインジケータに特定のスタイルを適用して、デザイン全体に調和させたいと思ったことがあれば、おそらくフォーカスセレクタをよくご存じでしょう。
        しかし、そうすると、ブラウザベースのヒューリスティックを失うというアクセシビリティ上の落とし穴があります。
        また、私のサイトでは、組み込みのフォームカラーではなく、カスタムカラーを使いたいと思っています。
        ヘッダーにすでにあるティール色を、フォーカスハイライトとチェックボックスの両方に使ってみましょう。
        focus-visible疑似クラスを使用すると、フォーカスインジケータを好きなようにスタイルすることができ、そのスタイルされたインジケータは、ブラウザでネイティブに表示される場合のみ表示されるようにすることもできます。
        さらに、フォームをカスタマイズするために、accent-colorを使用してフォームコントロールのUIのさまざまな部分の色を変更することができます。
        これは、チェックボックスやラジオボタンなど、さまざまな部分に影響を及ぼします。
        また、CSSについても、WebKitの接頭辞をどんどん置き換えています。
        以前は、実験的な機能を試すのに最適な方法でしたが、今では、標準的に定義されたプロパティに移行することで、CSS をより簡単に記述し、相互運用性を向上させることができるようになりました。
        ただし、WebKit の接頭辞を使用した既存の CSS は、Web 標準に対応するものに移行しても引き続き機能しますので、ご安心ください。
        Backface-visibility、print-color-adjust、text-align: match-parent はすべて接頭辞付きの対応するものと全く同じです。
        maskとtext-combine-uprightはどちらも構文が接頭辞付きバージョンから標準に合うように更新されています。
        また、接頭辞なしの外観プロパティは、新しい auto 値のサポートを追加していますが、標準仕様に合わせたため、Safari 16 では caret や listitem など WebKit 固有の値を削除しています。
        タイポグラフィの追加についても、注目すべき点がたくさんあります。
        特に、カラーフォント内のカラーパレットを簡単に選択できるfont-paletteプロパティが追加されました。
        これは、私のサイトのロゴの候補で試してみると、とてもクールなものになると思います。
        内蔵のダークパレットやライトパレットでどのように見えるかを試したり、カラーオーバーライドで思い通りにカスタマイズして、黄色を入れて明るくしたりすることも可能です。
        また、タイポグラフィでは、アンダーラインやオーバーラインが文字と交差したときにどうするかをコントロールできるtext-decoration-skip-inkが追加されています。
        さらに、日中韓の文字をブロック方向に正確に並べることができる「icユニット」を搭載。
        中国語、日本語、韓国語などの言語で、きれいなタイポグラフィのグリッドを作成するのに便利です。
        これらの素晴らしいCSS機能の説明を終えるにあたって、ぜひとも触れておきたいのが「subgrid」です。
        何年もの間、Web上のレイアウトはかなり難しいものでした。
        CSS Gridは革命的でしたが、グリッドコンテナの直接の子要素にしか影響を与えません。
        ここでは、CSS Gridを使ってカードをレイアウトし、メディアクエリなしで列を追加したり削除したりして、ビューポートの幅に合うようにレイアウトを自動的に調整するようにしています。
        しかし、各カードのコンテンツのサイズは同じではありません。ある見出しは長く、写真は異なるアスペクト比を持ち、そのためビジュアルが非常に乱雑に見えてしまいます。
        また、あるカードのタイトルが長いと、他のカードのレイアウトにも影響を与えるので、すべてのカードの間隔を同じにしたいのです。
        さて、これを実現するには、サブグリッドが必要です。
        各記事にグリッドを設定し、「grid-template-rows: subgrid」と記述することで、すべてのグリッドを親のグリッドに結びつけました。
        " Web InspectorのGrid Inspectorで、必要なグリッドをすべてオンにすると、それぞれの衣類カードのコンテンツが完璧に整列するのがわかると思います。
        Webインスペクタを使うと、多くのCSS作業が簡単になります。
        実際、Web インスペクタには驚くような機能が追加されており、きっとみなさんも試してみたいと思うことでしょう。
        まず、レイアウトは、何が起こっているのかが見えると書きやすくなります。これこそが、Webインスペクタが重要な理由です。
        新しいFlexboxインスペクタでは、要素間の間隔を実際に視覚化することができます。
        私のウェブサイトでは、ヘッダーにアイコンを追加するのに苦労しました。
        今はグリッドに関心がないので、そのセクションを閉じて、新しいFlexboxインスペクタにアクセスします。
        シングルクリックですべてのビューをオンにすることもでき、しかもスムーズなパフォーマンスが得られます。
        すべてのビューをオンにすると、ハッシュマークとコンテナボックスで、要素がどのように配置され、空いたスペースがどのようにビューを占めているかを明確に見ることができます。
        そこで、整列が正しく行われていることを確認するために、新しい整列エディタを使用します。
        スタイル]タブを開くと、align-itemsの隣に新しいボタンがあります。
        ここで、さまざまなオプションを切り替えて、ヘッダーに最適なものを見つけることができますし、justify-contentでも同様にできます。
        また、justify-contentについても同様です。それぞれのオプションを切り替えて、ちょうどよく見えるものを選びます。
        また、黄色のアイコンは少し小さすぎると思うので、赤のアイコンと同じ大きさにしてみたいと思います。
        黄色いアイコンの1つをインスペクトして、インスペクタでその高さを編集すれば、サイズを変えてみることができる。
        さらに、新しいCSSファジーオートコンプリートのおかげで、「medium」と入力すると、「medium」が名前の最後にあるにもかかわらず、目的の変数がポップアップで表示されます。
        黄色いアイコンも、もう小さすぎるということはありません。
        さらに、さまざまなアイコンのための他の変数が、私が検査する要素で使用されていないときは、新しいCSSツールで隠されてしまうんです。
        でもご心配なく。必要なときに表示するためのボタンがあります。
        そして、おそらく今年の Web Inspector にとって最もエキサイティングなことは、Safari Web Inspector の開発者ツール拡張機能のサポートを発表できることです。
        お気に入りのデベロッパーツール拡張機能の作成者は、他のブラウザで使用しているのと同じ基礎的な API を使用して、それらを Safari に移植することができるようになります。
        Webインスペクタのエクステンションを作成する方法、新しいAPIの探索、および自分で使い始めるためのセットアップに興味がある方は、今年のWWDCで「Create Safari Web Inspector Extensions」を必ずご覧ください。
        さて、ここまでフロントエンドのテクノロジーに関する新機能をたくさん紹介してきましたが、次はWeb APIの新機能について紹介します。
        Webプッシュのサポートを発表できることをとてもうれしく思っています。
        macOS VenturaのSafari 16で利用できるようになる予定です。
        iOSとiPadOSには来年登場する予定です。
        ウェブプッシュを使えば、あなたのウェブサイトやウェブアプリケーションからユーザーに通知を遠隔送信することができます。
        これは完全に相互運用可能な、標準ベースの実装です。
        もしあなたがすでにウェブプッシュを実装していて、それがほかのブラウザで動作しているなら、Safariでも何の修正も加えずにそのまま動作するはずです。
        Apple Developerアカウントも必要ありません。
        詳細については、WWDC22で行われた「Meet Web Push for Safari」をご覧ください。
        ウェブプッシュに興奮したなら、新しいウェブアプリケーションマニフェストの改善にも興奮することでしょう。
        ウェブアプリケーションをホーム画面に保存するときに使用されるアイコンを、マニフェストファイルで定義できるようになりました。
        マニフェスト内のアイコンを優先するには、HTML ヘッドに apple-touch-icon が定義されていないことを確認する必要があります。
        iOS と iPadOS にはあるアイコンを配信し、他のモバイル プラットフォームには別のアイコンを配信したい場合でも、Apple デバイス用のアイコンをその HTML ヘッドで apple-touch-icon を使用して定義することにより、配信することができます。
        また、どちらの場所でもアイコンを宣言しない場合、ユーザーがサイトをホーム画面に保存すると、単にサイトのスクリーンショットが表示されるだけです。
        また、共有メニューから「ホーム画面に追加」を選択するのを待たずに、マニフェストファイルを読み込むことができます。つまり、マニフェストファイルを使用して、すべてのサイトでウェブページの特性を定義でき、メタタグを使用する必要性をさらに減らすことができます。
        API の続きですが、同じオリジンで複数のブラウジングコンテキストでウェブページを使用することを改善するために、多くのことを行いました。
        ブロードキャストチャンネルを使用すると、これらの異なるブラウジングコンテキスト間で通知を送信することができます。
        例えば、誰かが洋服の交換サイトを利用していて、同時に2つのウィンドウで開いているとします。
        すると、1つのウィンドウで洋服をクレームしてきます。
        メッセージを投稿し、その利用できない状態を、他の開いているタブやウィンドウに同期させることができるようになります。
        でも、もしかしたら、バックグラウンドでタブを更新しているのではなく、サイト用に保存したファイルを更新しているのかもしれません。
        そのために、File System Access APIが追加されました。
        このAPIは今年、複数のリリースにわたって段階的に更新されてきました。まず、オリジンに基づくプライベート・ストレージであるオリジン・プライベート・ファイルシステムが追加されました。
        例えば、私の洋服の交換サイトでは、apple.comのような他のサイトにファイルを読み取られることはありません。
        com などにファイルを読み取られることはありません。
        これは、サイトのルート・ディレクトリから取得した既存のファイルを読み込むもので、たとえば、ここではたまたま作成したばかりの下書きファイルを読み込んでいます。
        それでは、今年追加されたAPIの中で最も鮮やかな、新しいカラーリッチを見てみましょう。
        Display P3色空間は、RGBにはない色を表現することができます。
        ここでは、カラーピッカーの例をいくつか紹介します。
        白い四角い線の左側がRGBに存在する色、右側がRGBに存在しない色です。
        そして、線の右側はP3でしか使えない色です。
        2016年には、動画と写真のP3対応を行いました。
        昨年は、CSS Color Level 4で定義された新しいカラーシンタックスを実装する最初のブラウザエンジンとなり、感動しました。
        今年は、canvas要素内のコンテンツに対するP3カラーのサポートを追加しました。
        このため、90 年代のデバイスに基づく色を使用する必要はなく、今日のあらゆる素晴らしいデバイスの色彩能力をフルに活用できるようになりました。
        シャドウ領域、Web ロック、ResizeObserver API の更新サポート（要素のボックス サイズ プロパティの変更を監視するのに役立つ ResizeObserverSize インターフェイス）など、この 1 年の新しい Web API にはさらに多くのチェックポイントがあります。
        新しい API の追加や、もちろん新しい機能についても、試してみたいことがたくさんあります。
        実は、まだまだ紹介したいことがあるのです。
        それでは次に、JavaScript と WebAssembly の新機能のすべてを紹介します。
        Web サイトで Worker を使用していて、Worker のインスタンスをタブやウィンドウで共有したい場合、新しい共有 Worker インターフェースは間違いなく役に立ち、メモリ使用量を減らせる可能性があります。
        バックグラウンドで発生させたいタスクごとに新しい Worker を生成する代わりに、同じオリジンを持つブラウジング コンテキストごとに使用する Worker を 1 つだけ持つことができます。
        各スクリプトは同じ方法で共有ワーカーを作成し、同じポートを使ってメッセージの受信と投稿を行うことができます。
        共有ワーカーは、すべての異なるスクリプトから送信されたメッセージを受信して応答することができます。
        これにより、サーバーへの負荷が軽減されるとともに、顧客にとってWebページが高速で応答性の高いものになります。
        また、配列の機能も一通り紹介しました。
        配列の末尾から検索したいときに reverse() を使って配列を変更する代わりに、 findLast() と findLastIndex() メソッドを使うことができるようになりました。
        " 新しい at() メソッドは、配列の末尾からの検索をより簡単にします。
        中括弧を使うのはインデックスが正の値の場合に有効ですが、at() を使うと負の値でもインデックスを指定できるので、コードがより簡潔で読みやすくなります。
        しかし、これだけの配列の新機能があっても、国際化の新機能の多さに勝るものはないでしょう。
        WebKit はこの一年間、Intl の実装に定期的なアップデートを加え続けてきました。
        NumberFormat の新しいメソッドで異なる番号体系をサポートし、Locale と DisplayNames の更新でカレンダーを、そして Intl Enumeration API で通貨を追加しています。
        このように、今年はIntlの実装に多くのことが追加されたので、世界中のユーザーに対応するために、いろいろなことを試したり、探したりするのに事欠くことはないでしょう。
        また、C、Objective C、Swift などの様々なコーディング言語で書かれた既存のコードを Web で利用したい場合、WebAssembly は、書き直しの必要なく実行させることができます。
        そして今年の改良で、アドレス可能なメモリが4GBに拡張され、新しいゼロコスト例外処理によってパフォーマンスが向上し、WebAssemblyを使用するWebアプリケーションはさらに強力になります。
        全体として、JavaScript と WebAssembly のために試せるエキサイティングなことがここにあるのは間違いありません。
        WebAssemblyについて言えば、私たちが開発するウェブのユーザーを保護するだけでなく、開発者としてのあなたにも新しい可能性をもたらすような、セキュリティとプライバシーの強化もあります。
        新しいCross Origin Opener PolicyとCross Origin Embedder PolicyのHTTPレスポンスヘッダでは、プロセスの分離を選択することができ、あなたのサイトは専用のwebContentプロセスで実行されることを意味します。
        WebAssembly のスレッドを使用して複数のスレッドを並行して実行することで、多くのアプリが恩恵を受けることがわかっており、これらの新しいヘッダーを使用すれば、安全に実行することが可能になります。
        2つ目のセキュリティ強化は、コンテンツセキュリティポリシーレベル3のサポート強化で、HTTPヘッダにも関係します。
        CSP は、読み込み中のコンテンツに対するセキュリティ制御を強化し、クロスサイトスクリプティングやその他の脆弱性のリスクを軽減するものです。
        レベル 3 の更新で、最もエキサイティングな追加機能は、新しい strict-dynamic ソース表現です。
        strict-dynamic の設計者は、nonces を使用して特定のスクリプトを許可し、その信頼をすでに信頼されているスクリプトによって読み込まれるスクリプトに拡張できることに気づきました。
        明示的な許可リストが不要になります。
        ヘッダがどれだけ単純になったか見てみましょう。
        元々の長いドメインリストから、過剰に許可してしまう可能性のあるドメインを取り除いたのです。
        これで、セキュリティとプライバシーの機能は一通り終わりましたが、今日取り上げるのはこれで終わりです。
        たとえば、getUserDisplay() API による特定の Safari ウィンドウのキャプチャのサポート、WebRTC Perfect Negotiation、In-band chapter tracks、requestVideoFrameCallback() など、メディアに関する更新が行われました。
        また、マニフェスト バージョン 3 をサポートする Web 拡張機能、および多数の新しい Web 拡張機能 API が追加されています。
        今日ここで取り上げたすべての機能、および過去 1 年間に Safari と WebKit で開発された 162 の機能と改良点についてさらに詳しく知りたい方は、Safari Technology Preview をダウンロードしてください。
        Web Inspector の広範なドキュメントを含む、webkit.org のすべての素晴らしいコンテンツをチェックして、Web テクノロジーを探求してください。
        また、バグレポートにより、ご意見やご要望をお聞かせください。
        WebKit のバグ（HTML、CSS、JavaScript、DOM API、Web Inspector に関するもの）を発見した場合は、WebKit のバグ追跡システム bugs.
        webkit.orgまで。
        また、Safariのインターフェイスに関する提案やバグについては、AppleのFeedback Assistantに問題を登録してください。
        私たちは、来年リリース予定のSafariとSafari Technology Previewで、あなたのようなウェブデベロッパの仕事をより良くする素晴らしい機能を提供できることを楽しみにしています。
        そして、WWDCで最高の時間を過ごしてください。
        それでは、さようなら。

        """
    }
}

