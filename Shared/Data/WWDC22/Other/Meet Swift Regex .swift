import Foundation

struct MeetSwiftRegexArticle: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Meet Swift Regex"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6711/6711_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/110357/")!
    }

    var english: String {
        """
        Hello, I am Michael Ilseman and I'm an engineer on the Swift standard library team.
         Join me as we meet and get to know Regex in Swift.
         There's a lot to Swift Regex, and we'll be getting just a taste of everything it has to offer.
         Let's say we're developers collaborating with some financial investigators on a tool to analyze transactions for irregularities.
         Now, you'd think that for a task this important we'd be processing well-structured data.
         But instead, we have a bunch of strings.
         Here the first field has the transaction kind, the second the transaction date, the third field the individual or institution, the fourth and final field the amount in US dollars.
         Fields are separated by either 2-or-more spaces or a tab for a very important technical reason that no one involved can remember.
         And, yes, that date field is totally ambiguous.
         We're just going to hope that it's month/day/year and see what happens.
         Processing these transactions involves processing strings, and string is a collection, which means we get access to generic collection algorithms.
         These algorithms basically come in two kinds, those that operate over elements, and those that operate over indices.
        We can try to use the element-based algorithms by splitting out the transaction fields, but the field separator being either tab or 2-or-more spaces makes this difficult.
         Splitting on whitespace alone doesn't cut it.
         Another approach is to drop down to low-level index manipulation code.
        But it's hard to do right, and even if you know what you're doing, it still takes a lot of code.
         Let's come back to split.
         The reason this approach doesn't work is because it is element-based while the field separator is a more complex pattern.
         A solution found in a wide variety of languages is to write a regular expression.
         Regular expressions emerged from formal language theory where they define a regular language.
         They entered practical application for search in editors and command-line tools as well as lexical analysis in compilers.
         These applications take regular expressions beyond their theoretical roots, as they need to extract portions of the input, control and direct execution, and add expressive power.
         And Swift is taking them further.
         We call this derivative Regex.
        Regex is a struct generic over its Output, which is the result of applying it, including captures.
         You can create one using a literal containing regex syntax in between slash delimiters.
         Swift's regex syntax is compatible with Perl, Python, Ruby, Java, NSRegularExpression, and many, many others.
        This regex matches one or more digits.
         The compiler knows regex syntax, so you'll get syntax highlighting, compile-time errors, and even strongly-typed captures, which we'll be meeting later.
         A regex can be created at run-time from a string containing the same regex syntax.
         This is useful for search fields in editors or command-line tools.
         This will throw an error at run-time if the input contains invalid syntax.
         The output type is an existential AnyRegexOutput, because the types and number of captures won't be known until run-time.
        And the same regex can be written using a declarative and well-structured, albeit more verbose, regex builder.
        Let's adapt our split approach from earlier to use a regex literal.
         The first portion matches 2-or-more occurrences of any whitespace character.
         The second portion matches a single horizontal tab.
         And the pipe character denotes a choice between alternatives, giving us a field separator of either 2-or-more-spaces or a single tab.
         Now that our fields are split, let's make a contribution to civilization itself and normalize that field separator to a single tab and be done with it.
         We could call 'join' on the result after splitting, but there's a better algorithm for that: 'replacing' lets us replace all field separators with a single tab.
        So we go out and evangelize our clearly superior approach to anyone who will listen.
         Adoption is...slow but promising.
         If you are familiar with regular expressions, you may also know of their mixed reputation.
         As the old saying goes, "I had a problem, so I wrote a regular expression.
         Now I have two problems.
        " But Swift regex is different.
        Swift advances the art in four key areas.
         Regex syntax is concise and expressive, but it can become terse and difficult to read.
         And newer features have to use increasingly cryptic syntax.
        Swift regexes can be structured and organized the way we structure and organize source code through Regex builders.
         Literals are concise, builders give structure, and literals can be used within builders to find that perfect balance.
        Textual representations for data have become a lot more complicated, and handling them correctly requires a standards-conforming parser.
         Swift regex lets you interweave industrial-strength parsers as individual components of a regex.
         This is done in a library-extensible fashion, meaning any parsers can participate.
        Much of the history of applied regular expressions took place in a world where the entire computer system only supported a single language and encoding, most notably ASCII.
         But the modern world is Unicode.
         Swift regex does the Unicode without compromising expressivity.
         And finally, the power of regular expressions can open up a broad search space that must be exhaustively explored.
         This makes their execution difficult to reason about.
         Some languages support controls, but because they're behind cryptic syntax, they tend to be obscure.
         Swift regex provides predictable execution and surfaces controls prominently.
         Let's go back to the financial statements we've been working with and fully parse each transaction using Regex builders, a declarative approach to string processing in Swift.
         We'll import the RegexBuilder module to get started.
         We can re-use the field separator regex that we just defined.
         The first field is simple; it's either a CREDIT or a DEBIT.
         We can use the regex literal syntax we've already seen to write that.
         After that comes a field separator, and then the date.
         Parsing dates by hand is a bad idea.
         Foundation has really good parsers for types like dates, numbers, and URLs, and we can use them directly in a Regex Builder.
        We supply an explicit locale which is our best guess at the author's intent.
         We do this instead of implicitly using the system's current locale.
         We can always change it later, and it's easy to do because we made our assumptions _explicit_ in code.
        The third field can be "anything," so it's tempting to just write "one or more of anything.
        " And while that will give us the right answer, it does a lot of unnecessary work first, because it starts off by matching anything else that comes after it.
         The regex will back up one character at a time and try the rest of the pattern.
         We want to tell the regex to stop when it sees the terminating field separator.
         There are a quite a few ways that we could accomplish this.
         One good way to do this is to use NegativeLookahead which peeks at the next part of the input without actually consuming it.
         Here we peek at the input to make sure a field separator isn't coming up before matching any character.
         NegativeLookahead is one of a family of tools that let you precisely control how a Regex matches its components.
        Finally, we match the amount, again using one of Foundation's parsers, this time for currency.
         We've been assuming that comma is a thousands separator while period is a decimal separator, and we make this assumption explicit.
        We've built a regex that lets us parse a line from the transaction ledger.
         We don't just want to recognize the lines.
         We want to extract some of this data out.
         To do this, we use captures, which extract portions of our input for later processing.
         By convention, the '0th' capture is the part of the input that the entire regex matched, and each explicit capture follows.
         Our transaction kind is captured as a Substring that is a slice of our input.
         For dates, we actually capture the strongly-typed value that was parsed out without needing to post-process the text.
         The individual or institution is again captured as a portion of our input, and the decimal capture is another strongly-typed value.
         To use it, we extract date and decimal values from the match result, and the investigators take it from here.
         It's at this point that we recommend they dump the data into a real database for obvious benefits like structured queries.
         They have a...different opinion.
         They want to keep everything as strings.
         Which is good news for this talk because we get to see even more of Swift Regex.
         Everything's going well until suddenly it's not.
         We just learned that the date order in the transaction text, which we told everyone was totally ambiguous, is in fact ambiguous.
         It's not always the same, and the leading theory is that it depends on the currency used in the transaction.
         Because of course it does.
         This means that US dollars is month/day/year and British pounds is day/month/year.
         So let's write a sed-like script to disambiguate this.
         For our regex, we're going to use an extended delimiter.
         This allows us to have slashes inside without having to escape them.
         This also gives us access to an extended syntax mode where whitespace is ignored, which means we can use whitespace for readability, just like in normal code.
         We used named captures, which show up in the Regex's output as tuple labels.
        And we use a Unicode Property to recognize currency symbols.
         This makes our regex more adaptable; we will handle the specific symbols in application logic.
        Rather than try to cut and splice text manually, we're going to yet again use Foundation's date parser.
         pickStrategy receives the currency symbol and will determine a parse strategy based on it.
         All of our assumptions are explicit in code, which makes it easier to adapt and evolve, something we almost certainly will end up needing.
        Let's use our regex and helper function with a find-and-replace algorithm by supplying a closure which uses the match result, including captures, to construct the replacement string.
         We pick a strategy based on the captured currency and parse the captured date.
         We can access the captures by name, instead of only by position.
         For our output, we'll format the new date using ISO-8601, an unambiguous industry standard.
         Our tool transforms this ledger Into an unambiguous one.
         Because we're using a real date parser and formatter, we're far more adaptable to changing requirements.
         And using a Unicode property to recognize currency symbols helps us evolve that much quicker.
         A regex declares an algorithm over some model of String.
         Swift's String presents multiple models for working with Unicode.
         This string, representing a love story for the ages, contains 3 characters.
         These characters are complex entities formally called Unicode extended grapheme clusters.
         A single Character is composed of one or more Unicode scalar values.
         String provides a UnicodeScalarView to access this lower-level representation of its contents.
         This enables advanced usage as well as compatibility with other systems.
        Our first Character, who is our story's protagonist, is composed of 4 Unicode scalars: ZOMBIE, Zero Width Joiner, FEMALE SIGN, and uh...
         VARIATION SELECTOR-16, which in this context signals a preference to be rendered as emoji.
         Of course! These scalars produce the single emoji we see visually.
         When strings are stored in memory, they are encoded as UTF-8 bytes.
         We can view these bytes using the UTF-8 view.
         UTF-8 is a variable-width encoding, meaning multiple bytes may be needed for a single scalar, and as we saw, multiple scalars may be needed for a single character.
         Our story's protagonist, represented by 4 Unicode scalars, is encoded using 13 UTF-8 bytes.
         In addition to being composed of multiple scalars, the same exact character can sometimes be represented by different sets of scalars.
         This comes up a lot when handling languages other than English.
         In this example, the 'e' with an acute accent can be represented as either a single scalar, precomposed ‘e’ with acute accent, or as an ASCII 'e' followed by a combining acute accent.
         These are the same characters, so String comparison will return true.
         This is because String obeys what is formally called Unicode Canonical Equivalence.
        From the perspective of the UnicodeScalarView, or the UTF-8 view, the contents are different, and we see this difference when we compare within these lower-level views.
         Just like String, Swift regex is obsessively Unicode correct by default.
         But it does this without compromising expressivity.
         Let's switch over a pair of strings.
         For the first string, we'll match the named Unicode Scalar SPARKLING HEART surrounded by any characters denoted by dot (.).
        The any character class will match any Swift character; that is, any Unicode extended grapheme cluster.
        For the second string, characters that are equal compare as equals.
        .. and we can ignore case.
         And now our simple love story has become a lot more complicated.
         Sometimes life, or in this case un-life, has complexities that we need to process.
        Just like String, if you do need to process Unicode scalar values yourself, either for compatibility or sub-grapheme cluster precision, you can by matching with 'unicodeScalar' semantics.
         When we match at the Unicode Scalar level, the dot matches a single Unicode Scalar value instead of a full Swift Character.
         Which means we get to see our friend again: VARIATION-SELECTOR 16.
         This friendly little selector gets matched by the dot, and you can't see it because when it's all alone, it renders as empty whitespace.
         So helpful.
        Now that we've worked with precision and correctness, let's do something a little different, and get back to finance.
         The investigators have returned, and this time they have an interesting request.
         They modified our transaction matching tool to sniff transactions live off the wire instead of processing ledgers after the fact.
         Looking at their code, they actually did a reasonably good job, but they're facing scaling issues and need our help.
         The transactions they are processing are very similar, but with minor differences.
         Instead of a date, they have a precise time stamp instead.
         This is represented in a clear, unambiguous, and shockingly proprietary format.
         They have a regular expression written in a prior century that matches this just fine.
         It's fine.
         Next they have a details field which includes individuals and identification codes.
         They filter transactions against this field by using a run-time compiled regex derived from input.
         Because this is live, and there are more fields later on, they like to bail early on any uninteresting transactions.
         Then comes an amount and other fields like checksums, which they handle just fine on their own.
         And of course, fields are still separated by 2-or-more spaces or a tab.
        Their transaction matcher looks a lot like ours.
         They have their own regex for the timestamp, their details regex is compiled from input, and they handle the rest of the fields.
         They did a reasonably good job.
         Everything technically works.
         It just isn't scaling well.
         They notice that their timestamp and details regexes often match much more of the input than their fields.
         Ideally, these regexes would be constrained to only run over a single field.
         We handled a similar issue in our project by using negative lookahead, so let's pull that regex in.
        'field' will efficiently match any character until it encounters a field separator, and we'd like to use it to contain their regexes.
         We could do this as a post-processing step, but because this is running live, we want to bail early if these regexes don't match their fields.
         We can do this using TryCapture.
         TryCapture passes the matched field to our closure, where we test against the investigator's timestamp and details regexes.
         If they match, we return the field's value, meaning that matching succeeded and the field is captured.
         Otherwise we return nil, which signals that matching failed.
        TryCapture's closure actively participates in matching, which is exactly what we need.
         And with this, we've solved a major scaling issue.
         But there's still one more problem: when something later on in the transaction matcher fails, it can take a long time to exit.
        Our fieldSeparator regex we defined at the very beginning matches 2-or-more whitespaces or a tab, which is what we want.
         If there are 8 whitespace characters, it will match all of them before trying the rest of the regex.
         But if the regex later fails, it will back up and only match 7 whitespace characters before trying again.
         And if that fails, it will match only 6 whitespace characters, and so on.
        Only after trying all alternatives does matching fail.
         This backing up in order to try alternatives is called global backtracking or, in formal logics, the Kleene closure.
         It's what gives regular expressions their characteristic power.
         But it opens up a broad search space to explore, and here we want a more linear search space.
         We want to match all of the whitespace and never give any up.
         There are a couple tools that we could use; the more general tool is to put fieldSeparator in a local backtracking scope instead of a global one.
        The Local builder creates a scope where, if the contained regex ever successfully matches, any untried alternatives are discarded.
        Even if our transaction matcher fails later on, we don't go back to try consuming fewer spaces.
         Global backtracking, the default for regex, is great for search and fuzzy matching.
         Local is useful for matching precisely specified tokens.
         The field separator, as vexing as it may be, is precise.
        Local is known elsewhere as an atomic non-capturing group, which can be a… frightening name.
         Makes it seem like your regex might blow up.
         But it actually does the opposite-- it contains the search space.
        And with this, we've helped them solve their scaling issues.
         Today we got to meet Swift Regex, but there's so much more that we weren't able to cover.
         Be sure to check out Swift Regex: Beyond the Basics by my colleague Richard.
         Before we leave, I want to highlight a few points.
         Regex builders give structure.
         Regex literals are concise.
         The choice between when to use one over the other will ultimately be subjective.
        Make sure to use real parsers whenever possible.
         This will save you massive amounts of time and avoid headaches.
         Just by using Swift's defaults, you're going to get far more Unicode support and goodness than anywhere else.
         Look for ways to use things like character properties effectively, such as when we matched the currency symbols.
         And finally, simplify your search and processing algorithms by using controls such as lookahead and local backtracking scopes.
         Thank you for watching.

        """
    }

    var japanese: String {
        """
        こんにちは、私はマイケル・イルセマンです。Swiftの標準ライブラリチームでエンジニアをしています。
         Swift の Regex を知るために、私と一緒に参加しませんか？
         Swift の Regex には多くのものがあり、私たちはそのすべてを味わうことになります。
         私たちは、金融調査員と協力して、不正な取引を分析するツールを開発しているとします。
         さて、このような重要なタスクでは、きちんと構造化されたデータを処理すると思うでしょう。
         しかし、その代わり、文字列の束があります。
         ここでは、最初のフィールドに取引の種類、2番目のフィールドに取引日、3番目のフィールドに個人または機関、4番目と最後のフィールドにドル建ての金額が格納されています。
         フィールドは2つ以上のスペースかタブで区切られているが、これは関係者が誰も覚えていない非常に重要な技術的理由によるものである。
         そして、日付のフィールドは、完全にあいまいです。
         月/日/年であることを祈るばかりで、何が起こるかわからない。
         これらのトランザクションを処理するには、文字列を処理する必要があります。文字列はコレクションであり、一般的なコレクションアルゴリズムにアクセスできることを意味します。
         このアルゴリズムは基本的に2種類ある。要素に対して操作するものと、インデックスに対して操作するものだ。
        トランザクションのフィールドを分割して要素ベースのアルゴリズムを使おうとすると、フィールドのセパレータがタブか2つ以上の空白であるため、これが難しくなる。
         空白文字だけで分割することはできない。
         もう一つの方法は、低レベルのインデックス操作のコードに落とし込むことです。
        しかし、これを正しく行うのは難しく、たとえ何をしているかを知っていたとしても、多くのコードを必要とします。
         スプリットに戻りましょう。
         この方法がうまくいかないのは、フィールドセパレータがもっと複雑なパターンであるのに対し、要素ベースであるためです。
         様々な言語で見られる解決策は、正規表現を書くことだ。
         正規表現は形式言語理論から生まれたもので、正規言語を定義するものである。
         その後、エディタやコマンドラインツールでの検索や、コンパイラでの字句解析など、実用的な用途に広がっていった。
         これらのアプリケーションは、入力の一部を抽出し、実行を制御し、指示し、表現力を加える必要があるため、正規表現をその理論的なルーツから超えました。
         そして、Swiftはそれらをさらに進めています。
         私たちはこの派生物をRegexと呼んでいます。
        Regexは、キャプチャを含むそれを適用した結果である、その出力に対する構造体の総称です。
         スラッシュで区切られた正規表現構文を含むリテラルを使用して、1つを作成することができます。
         Swift の正規表現構文は Perl、Python、Ruby、Java、NSRegularExpression、その他多くの構文と互換性を持っています。
        この正規表現は1つもしくは複数の数字にマッチします。
         コンパイラは正規表現の構文を知っているので、シンタックスハイライトやコンパイル時のエラー、さらには後で紹介する強引な型付けをしたキャプチャも表示されます。
         正規表現は、同じ正規表現構文を含む文字列から実行時に作成することができます。
         これは、エディタやコマンドラインツールの検索フィールドに便利です。
         これは、入力に無効な構文が含まれている場合、実行時にエラーを発生させます。
         出力型は実存的なAnyRegexOutputです。なぜなら、キャプチャの型と数は実行時まで分からないからです。
        同じ正規表現が、より冗長ではありますが、宣言的で構造化された正規表現ビルダーを使って書くことができます。
        先ほどの分割方法を正規表現リテラルに適用してみましょう。
         最初の部分は、2つ以上ある空白文字にマッチします。
         2番目の部分は、水平方向のタブ1個にマッチします。
         そしてパイプ文字は、2つ以上の空白文字か1つのタブのどちらかを選択することを意味します。
         フィールドが分割されたので、文明そのものに貢献するために、フィールドセパレータを単一のタブに正規化して終わりにしましょう。
         分割後の結果に対して 'join' を呼び出すこともできますが、これにはもっと良いアルゴリズムがあります。replacing'を使えば、すべてのフィールドセパレータを1つのタブに置き換えることができます。
        そこで私たちは、明らかに優れていると思われるこの方法を、誰でもいいから聞いてみようと思い、伝道に出かけました。
         採用されるのは...遅いですが、期待できます。
         正規表現に詳しい方なら、その評判がまちまちであることもご存じでしょう。
         古いことわざに、「問題があったので正規表現を書いた。
         今、私は2つの問題を抱えている。
        " しかし、Swift regexは違います。
        Swiftは4つの重要な領域で技術を進歩させています。
         正規表現の構文は簡潔で表現力が豊かですが、簡潔で読みにくいものになる可能性があります。
         そして、新しい機能はますます暗号化された構文を使用する必要があります。
        Swift の正規表現は、私たちが Regex ビルダーを通してソースコードを構造化し、組織化するのと同じように、構造化し、組織化することができます。
         リテラルは簡潔で、ビルダーは構造を与え、その完璧なバランスを見つけるためにビルダーの中でリテラルを使用することができます。
        データのためのテキスト表現は、かなり複雑になってきており、それらを正しく扱うには、標準に準拠したパーサーが必要です。
         Swift の正規表現では、正規表現の個々のコンポーネントとして、工業的に強力なパーサーを織り交ぜることができます。
        これはライブラリ拡張可能な方法で行われ、どんなパーサーでも参加できることを意味します。
        正規表現の応用の歴史の多くは、コンピュータシステム全体が単一の言語とエンコーディング、特にASCIIのみをサポートしていた世界で行われました。
         しかし、現代の世界はUnicodeです。
         Swift regexは表現力を損なうことなく、Unicodeに対応します。
         そして最後に、正規表現の力は、徹底的に探索されなければならない広い探索空間を開くことができます。
         このため、その実行を推論するのが難しくなります。
         いくつかの言語ではコントロールをサポートしていますが、暗号化された構文の後ろにあるため、不明瞭になりがちです。
         Swift の正規表現は予測可能な実行を提供し、コントロールが目立つように表示されます。
         私たちが作業していた財務諸表に戻り、Swift での文字列処理への宣言的なアプローチである Regex ビルダーを使用して、各トランザクションを完全に解析してみましょう。
         開始するために RegexBuilder モジュールをインポートします。
         先ほど定義したフィールドセパレーターの正規表現を再利用することができます。
         最初のフィールドは単純で、CREDIT または DEBIT のどちらかです。
         これは、すでに見た正規表現の構文で書くことができます。
         その後にフィールドセパレータ、そして日付が来ます。
         日付を手作業でパースするのはよくありません。
         Foundationには日付、数値、URLのような型に対する非常に優れたパーサーがあり、Regex Builderで直接使用することができます。
        明示的にロケールを指定することで、作者の意図を推測することができます。
         システムの現在のロケールを暗黙的に使用するのではなく、このようにします。
         このロケールは後でいつでも変更することができますし、コードの中で仮定を明示的にしているので簡単に変更することができます。
        3番目のフィールドは "anything "で、"one or more of anything "と書きたくなりますね。
        " これは正しい答えになるのですが、最初に不必要な作業をたくさんしてしまいます。
         正規表現は一文字ずつ後退して、残りのパターンを試します。
         正規表現がフィールドセパレータの終端を見たときに停止するようにしたいのです。
         これを実現するには、いくつかの方法があります。
         そのひとつは NegativeLookahead を使うことで、入力の次の部分を実際に消費することなく覗き見ることができます。
         ここでは、文字にマッチする前にフィールドセパレータが現れないことを確認するために入力を覗いています。
         NegativeLookahead は、Regex のマッチングを正確に制御するツールのひとつです。
        最後に、Foundation のパーサーの 1 つである通貨用のパーサーを使用して、金額をマッチングします。
         これまで、カンマは 1000 単位の区切り文字であり、ピリオドは小数点の区切り文字であると仮定してきましたが、この仮定を明確にします。
        取引台帳の行をパースするための正規表現を作成しました。
         私たちは単に行を認識したいだけではありません。
         このデータの一部を取り出したいのです。
         そのために、キャプチャを使用します。キャプチャは、入力の一部を抽出して後で処理するものです。
         規約では、「0番目の」キャプチャは正規表現全体がマッチした入力部分であり、その後に各明示的なキャプチャが続く。
         トランザクションの種類は、入力のスライスであるSubstringとしてキャプチャされる。
         日付については、テキストを後処理することなく、パースされたstrong-typedの値を実際にキャプチャします。
         個人または機関は再び入力の一部としてキャプチャされ、小数点のキャプチャは別の強く型付けされた値です。
         これを利用するために、マッチング結果から日付と10進数の値を抽出し、ここからは調査員がそれを利用する。
         この時点で、構造化クエリのような明らかな利点を得るために、データを実際のデータベースにダンプするよう勧めています。
         しかし、彼らは違う意見を持っています。
         彼らはすべてを文字列のままにしておきたいと考えています。
         Swift Regexをより多く見ることができるので、このトークにとって良いニュースです。
         突然そうでなくなるまで、すべてがうまくいっていました。
         トランザクションテキストの日付の順序が、全く曖昧であると皆に言っていましたが、実際に曖昧であることがわかりました。
         いつも同じとは限らないし、有力な説は、取引に使われた通貨に依存するというものだ。
         もちろんそうだからだ。
         つまり、米ドルは月/日/年、英ポンドは日/月/年ということです。
         そこで、これを曖昧さをなくすために、sedのようなスクリプトを書いてみよう。
         正規表現では、拡張デリミタを使うことにする。
         これにより、スラッシュをエスケープすることなく、中に入れることができるようになる。
         また、空白を無視する拡張構文モードにもアクセスできます。つまり、通常のコードと同じように空白を使用して読みやすくすることができるのです。
         名前付きキャプチャを使用し、Regexの出力にタプルラベルとして表示されます。
        また、通貨記号を認識するためにUnicode Propertyを使用しています。
         これにより、正規表現がより適応的になり、アプリケーションロジックで特定の記号を処理することができます。
        手動でテキストを切り貼りするのではなく、今回も Foundation の日付パーサーを使用することにします。
         pickStrategy は通貨記号を受け取り、それに基づいて解析ストラテジーを決定します。
         すべての仮定がコードで明示されているので、適応や進化が容易になり、最終的に必要になることはほぼ確実です。
        正規表現とヘルパー関数を検索置換アルゴリズムで使ってみましょう。クロージャを指定すると、キャプチャを含むマッチ結果を使用して置換文字列を作成します。
         キャプチャした通貨をもとに戦略を決め、キャプチャした日付をパースします。
         キャプチャには位置だけでなく、名前でもアクセスできます。
         出力には、曖昧さのない業界標準であるISO-8601を使用して、新しい日付をフォーマットします。
         このツールは、この台帳を曖昧さのないものに変換します。
         本物の日付パーサーとフォーマッターを使用しているため、変化する要件への適応性がはるかに高くなっています。
         また、通貨記号を認識するためにユニコードプロパティを使用することで、より迅速に進化させることができます。
         正規表現は、文字列のいくつかのモデル上のアルゴリズムを宣言します。
         Swift の String は、Unicode で作業するための複数のモデルを提示します。
         この文字列は、時代のための愛の物語を表し、3つの文字を含んでいます。
         これらの文字は、正式には Unicode 拡張書記素クラスタと呼ばれる複雑な実体です。
         1 つの文字は、1 つ以上の Unicode スカラー値で構成されます。
         文字列は、その内容のこの低レベル表現にアクセスするために、UnicodeScalarViewを提供します。
         これにより、高度な使用法と他のシステムとの互換性が可能になります。
        私たちの物語の主人公である最初のキャラクターは、4つのUnicodeスカラーで構成されています。ZOMBIE、Zero Width Joiner、FEMALE SIGN、そして...。
         VARIATION SELECTOR-16は、この文脈では、絵文字としてレンダリングされることを希望していることを意味します。
         もちろんだ! これらのスカラーは、私たちが視覚的に見ることのできる単一の絵文字を生成する。
         文字列がメモリに格納されるとき、それらはUTF-8バイトとしてエンコードされる。
         このバイトは、UTF-8ビューで見ることができる。
         UTF-8は可変長のエンコーディングなので、1つのスカラーに複数のバイトが必要になることがあり、1つの文字に複数のスカラーが必要になることもある。
         この物語の主人公は、4つのユニコードスカラーで表現され、13バイトのUTF-8を使ってエンコードされています。
         複数のスカラーで構成されるだけでなく、まったく同じ文字が異なるスカラーのセットで表現されることもある。
         これは、英語以外の言語を扱うときによく出てきます。
         この例では、鋭角アクセントのついた「e」は、単一のスカラー、鋭角アクセントのついた前合成の「e」、またはASCIIの「e」に続く結合鋭角アクセントとして表現することができます。
         これらは同じ文字なので、Stringの比較は真を返します。
         これは、Stringが、正式にはUnicode Canonical Equivalenceと呼ばれるものに従うからです。
        UnicodeScalarView、または UTF-8 ビューの観点から、内容は異なっており、これらの低レベルのビュー内で比較するときに、この違いを見ることができます。
         Stringと同じように、Swiftの正規表現はデフォルトで執拗なほどUnicodeに正しいです。
         しかし、それは表現力を損なうことなくこれを行います。
         文字列のペアを切り替えてみましょう。
         最初の文字列は、ドット(.)で示される任意の文字で囲まれた名前付きUnicodeスカラーSPARKLING HEARTにマッチします。
        任意の文字クラスは、任意のSwift文字、つまり、任意のUnicode拡張書記素クラスタにマッチします。
        2番目の文字列では、等しい文字は等しいものとして比較されます。
        ...そして大文字小文字を無視することができます。
         そして今、私たちのシンプルなラブストーリーは、もっと複雑になっています。
         人生には、あるいはこの場合人生でないものには、処理しなければならない複雑なことがあるのです。
        文字列と同じように、Unicode のスカラー値を自分で処理する必要がある場合は、 互換性のため、あるいはサブグレープクラスターの精度のために、 'unicodeScalar' セマンティクスでマッチングを行うことができます。
         Unicode Scalar レベルでマッチするとき、ドットは完全な Swift Character の代わりに、単一の Unicode Scalar 値にマッチします。
         つまり、私たちは再び友人に会うことができるのです。バリエーションセレクタ16です。
         このフレンドリーな小さなセレクタはドットによってマッチングされ、それが単独であるとき、空の空白としてレンダリングされるので、それを見ることはできません。
         とても便利ですね。
        さて、正確さと正しさを追求したところで、少し変わったことをやってみましょう。
         調査員が戻ってきて、今度は面白い依頼をしてきました。
         彼らは取引照合ツールを修正し、事後的に台帳を処理する代わりに、取引をリアルタイムで嗅ぎつけるようにした。
         しかし、スケールの問題に直面し、我々の助けが必要です。
         彼らが処理しているトランザクションは非常によく似ていますが、小さな違いがあります。
         日付の代わりに、正確なタイムスタンプを持っている。
         これは明確で曖昧さのない、衝撃的な独自フォーマットで表現されている。
         彼らは前世紀に書かれた正規表現を持っていて、それにうまくマッチする。
         それはいいことです。
         次に、個人と識別コードを含む詳細フィールドがある。
         彼らはこのフィールドに対して、入力からコンパイルされた正規表現を用いてトランザクションをフィルタリングする。
         これはライブであり、後でもっと多くのフィールドがあるので、彼らは面白くないトランザクションを早期に救済することを好みます。
         その後、金額やチェックサムなどのフィールドが来るが、これらは単独でうまく処理される。
         もちろん、フィールドは2つ以上のスペースかタブで区切られる。
        彼らのトランザクション・マッチャーは、我々のものとよく似ている。
         彼らはタイムスタンプのために独自の正規表現を持ち、詳細な正規表現は入力からコンパイルされ、残りのフィールドは彼らが処理する。
         彼らは合理的に良い仕事をした。
         技術的にはすべてうまくいっています。
         ただ、うまくスケーリングできないだけです。
         彼らは、タイムスタンプと詳細の正規表現が、しばしばフィールドよりも多くの入力にマッチすることに気づきました。
         理想的には、これらの正規表現は単一のフィールドに対してのみ実行されるように制約されるでしょう。
         私たちのプロジェクトでは、負のルックヘッドを使うことで同様の問題に対処しています。
        field' はフィールド区切り文字にぶつかるまでどんな文字にも効率よくマッチします。そして、その正規表現を格納するためにこれを使いたいと思います。
         これは後処理として行うこともできますが、ライブで実行しているため、これらの正規表現がフィールドにマッチしない場合は早期にベイルしたいのです。
         これは TryCapture を使って行うことができます。
         TryCaptureはマッチしたフィールドをクロージャに渡し、そこで調査者のタイムスタンプと詳細の正規表現に対してテストを行います。
         一致した場合は、フィールドの値を返します。これは、マッチングが成功し、フィールドがキャプチャされたことを意味します。
         一致しない場合は、nilを返し、マッチングが失敗したことを知らせます。
        TryCaptureのクロージャはマッチングに積極的に参加し、これこそ私たちが必要としていることです。
         これで、スケーリングの大きな問題を解決できました。
         しかし、まだもう一つ問題があります。トランザクションマッチャーの後のほうで何かが失敗すると、終了するのに長い時間がかかることがあります。
        冒頭で定義した fieldSeparator 正規表現は、2つ以上の空白文字かタブをマッチさせます。
         もし8個の空白文字があれば、残りの正規表現を試す前にそれらすべてにマッチします。
         しかし、正規表現が後で失敗した場合は、バックアップして7個の空白文字にのみマッチングさせてから再試行します。
         さらにそれが失敗すると、6 文字の空白文字にのみマッチし、以下同様です。
        すべての選択肢を試した後でのみ、マッチングは失敗します。
         この代替案を試すためのバックアップはグローバルバックトラックと呼ばれ、形式論理学ではクリーネクロージャと呼ばれます。
         正規表現に特徴的な力を与えているのはこれである。
         しかし、これによって探索できる探索空間が広くなってしまうので、ここではより直線的な探索空間を求めている。
         私たちは、すべての空白文字にマッチし、決してあきらめないことを望んでいるのです。
         より一般的な方法は、fieldSeparatorをグローバルなスコープではなく、ローカルなバックトラック・スコープに置くことです。
        ローカルビルダーは、含まれる正規表現がマッチングに成功した場合、未試行の選択肢はすべて破棄されるスコープを作成します。
        たとえトランザクションマッチャーが失敗しても、空白の消費量を減らすために後戻りすることはないのです。
         正規表現のデフォルトであるグローバルバックトラックは、検索やファジーマッチに適しています。
         ローカルは、正確に指定されたトークンをマッチングするのに便利です。
         フィールドセパレータは、厄介かもしれませんが、正確です。
        ローカルはアトミック・ノンキャプチャー・グループとして知られていますが、これは...恐ろしい名前です。
         正規表現が爆発しそうな名前です。
         しかし、実際にはその逆で、探索空間を内包しているのです。
        そしてこれによって、私たちは彼らのスケーリングの問題を解決する手助けをしてきました。
         今日はSwift Regexを紹介しましたが、紹介しきれなかったことがまだまだたくさんあります。
         私の同僚の Richard による Swift Regex: Beyond the Basics を是非ご覧ください。
         私たちが去る前に、いくつかのポイントにハイライトを当てたいと思います。
         Regexビルダーは構造を与える。
         Regexのリテラルは簡潔である。
         いつどちらを使うかは、最終的には主観的なものになります。
        可能な限り、本物のパーサーを使うようにしましょう。
         そうすることで、膨大な時間を節約し、頭痛を避けることができます。
         Swiftのデフォルトを使用するだけで、他のどこよりもはるかに多くのUnicodeサポートと良さを得ることができます。
         通貨記号をマッチさせたときのような、文字プロパティのようなものを効果的に使う方法を探してください。
         そして最後に、ルックアヘッドやローカル・バックトラック・スコープなどのコントロールを使用して、検索や処理のアルゴリズムを簡素化します。
         ご視聴ありがとうございました。

        """
    }
}

