import Foundation

struct WhatsNewInSwift: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "What's new in Swift"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6708/6708_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/110354/")!
    }

    var english: String {
        """
        Hi, I'm Angela.
         And I'm Becca.
         Welcome to what's new in Swift! We're really excited to talk to you today about all of the great new features in Swift 5.7.
         Many of the things we'll talk about today demonstrate Swift's goal to make your life as a developer easier.
         We'll look at new tooling to help you customize your workflow and some amazing under-the-hood improvements.
         Then we'll talk about the latest in Swift's concurrency model and the road to Swift 6, including full-thread safety.
         Then I'll finish up by taking you through some language improvements that make Swift easier to read and write, including cleaner, simpler generics, and powerful new string processing facilities.
         But first, let's start by talking about one of the things that makes Swift so special -- all of you.
         Your input and contributions are what have enabled Swift to expand so rapidly.
         Community involvement is at Swift's core.
         This year, more of the Swift project became available to the community when docC -- the documentation generation tool announced last year -- and the Swift.org website were open sourced.
         Open source works best when you have an active community shepherding it.
         We've been using the workgroup model for Swift on Server and Diversity in Swift to provide stewardship and support for community members interested in specific areas.
         This has been working really well so we've started two new workgroups.
         One for iterating on the Swift website and making it more of a community resource, and another for C++ interoperability, to shape the design of the model between C++ and Swift.
         As we venture into new areas, we all need support from members within the community.
         As a part of that, the Diversity in Swift workgroup introduced the Swift Mentorship Program last year.
         The program provides pathways to contribute to all of the workgroup areas for folks who don't know how to start or are looking to deepen their expertise in a particular area.
         Last year's program was a huge success.
         There were a lot of interested mentees; and with that, we were able to create 41 mentorship pairs.
         This success is why the program is being brought back for year two.
         The program would love to include everyone who's interested; but to do that, we need you -- the excited and experienced developers listening now who are ready to share their breadth of knowledge and make new connections.
         Because the mentorship program is not just about the code but about building relationships within the community.
         And a little guidance can have a lasting effect.
         Don't just take my word for it.
         Last year, Amrit participated in the mentorship program and focused on compiler and language design.
         What started off as intrigue for Amrit transformed into tangible contributions.
         Diving into a new domain is not easy.
         Even so, she walked away finding success and feeling inspired to contribute more.
         Like many others, this experience opened a door for Amrit.
         In addition to compiler and language design, last year there were a wide range of available focus areas, from technical writing and testing to contributing to Swift packages.
         This year, we're adding even more and there's always opportunities for new topics.
         If you don't see something in this list that interests you, you can still mention it in your application.
         Another addition is that this year's program will offer mentorship year-round for starter bug contributions to help accommodate anyone who may have a lower capacity to participate but is still excited to get involved.
         If you're interested in applying, or just eager to hear more, check out the most recent Swift blog post.
         There, you can find links to detailed reflections from the highlighted mentees.
         The mentorship program is just one initiative under Diversity in Swift umbrella.
         To learn more about the mentorship program and other Diversity in Swift efforts, you can visit Swift.org/diversity.
         To open the door even further, we want to make it as easy as possible to use Swift with the resources you have! We have streamlined the Swift toolchain distribution process for the Linux platform by adding support for Linux package formats.
         With the new native toolchain installers, you can now download RPMs for Amazon Linux 2 and CentOS 7 directly from Swift.org.
         These toolchains are experimental, so be sure to share feedback on the Swift.org forums.
         Swift is primarily used for building apps.
         However, the vision has always been for Swift to be scalable -- used from everything from high-level scripts down to bare-metal environments.
         To encourage Swift to be used where it's never been used before, Swift underwent some major changes this year.
         To make the standard library smaller for standalone, statically linked binaries, we dropped the dependency on an external Unicode support library, replacing it with a faster native implementation.
         Smaller, faster binaries are a huge benefit when running on event-driven server solutions.
         You get static linking on Linux by default to better support containerized deployments for the server.
         This size reduction makes Swift suitable for even restricted environments, which allowed us to use it in Apple's Secure Enclave Processor.
         Swift is useful from apps to servers all the way down to restricted processors; tying it all together is the package ecosystem.
         This year's new features in Swift packages will make your life better.
         To start, Swift Package Manager has introduced TOFU.
         No, not the delicious snack.
         TOFU is an acronym that stands for Trust On First Use.
         It's a new security protocol where the fingerprint of a package is now being recorded when the package is first downloaded.
         Subsequent downloads will validate this fingerprint and report an error if the fingerprints are different.
         This is just one example of how trust and security are built into the core of the package ecosystem to help you feel confident using it.
         Command plug-ins are a great way to improve the workflow for Swift developers.
         They are the first step in providing more extensible and secure build tools.
         Command plug-ins can be used for documentation generation, source code reformatting and more.
         Instead of writing your automation in a shell script and having to maintain separate workflows, you can use Swift! Think open source formatters and linters.
         Now, all of those open source tools are available within Xcode and Swift Package Manager.
         Command plug-ins are the glue between open source tools and Swift Package Manager.
         The Swift project is embracing developer tools in the open source community to provide seamless integration with your automated workflows.
         docC is great tool to integrate documentation into your source code.
         This year, it got even better with Objective-C and C support.
         Let's take a look at what it would take to create a plug-in with docC.
         Plug-ins are just simple Swift code.
         You can define a plug-in by creating a struct that conforms to the CommandPlugin protocol.
         And then you just add a function that tells your plug-in which tool you'd like to invoke.
         Within this function is where we want to call docC.
         Once you've defined your plug-in, it becomes available through the Swift PM command line interface and Xcode as a menu entry.
         Now, we can tell Swift PM to generate documentation and it knows to pass this action to the docC executable.
         It doesn't stop there.
         There's a second plug-in known as build tool plug-ins.
         These plug-ins are packages that allow you to inject additional steps during the build.
         When you implement a build tool plug-in, that will create a command for the build system to execute in a sandbox.
         They differ from command plug-ins which you execute directly at any time and can be granted explicit permission to change files in your package.
         Build tool plug-ins can be used for source code generation or custom processing for special types of files.
         With build tool plug-ins, this would be the package layout.
         In this example, the plugin.
        Swift is the Swift script that implements the package plug-in target.
         The plug-in is treated as a Swift executable.
         And you write the plug-in in the same way you write any Swift executable.
         You can implement your plug-in by defining a set of build commands that tells the build system what executable command to run and what outputs are expected as a result.
         Package plug-ins are secure solutions that provide extensibility in your packages.
         You can learn more about how plug-ins work and how to implement your own plug-in, in two sessions, "Meet Swift Package plugins" and "Create Swift Package plugins."
         As you expand your use of packages, you might have encountered module collisions.
         That's when two separate packages define a module with the same name.
         To solve this situation, Swift 5.7 introduces module disambiguation.
         Module disambiguation is a feature that allows you to rename modules from outside the packages that define them.
         Here in our Stunning application, we're bringing in two packages that define a Logging module, so they clash.
         To fix this for our Stunning application, you'll just need to add the moduleAliases keyword to the dependencies section of your package manifest.
         That way you can use two different names to distinguish between modules that previously had the same name.
         Swift 5.7 brings some fantastic performance improvements.
         Let's start by looking at build times.
         Last year, we told you about how we had rewritten the Swift Driver -- the program that coordinates the compilation of Swift source code in Swift.
         Last year's rearchitecture unlocked some really important changes that speed up builds significantly.
         The driver can now be used as a framework directly inside the Xcode build system instead of as a separate executable.
         This allows it to coordinate builds more closely with the build system to allow things like parallelization.
         If you're someone who loves the sound of quick builds, you can get more details in the "Demystify parallelization in Xcode builds" session.
         To show you how much faster builds are, let's look at some examples of how long it takes to build some of the tools we use often that are written in Swift.
         On a 10-core iMac, the improvements have ranged from 5 percent all the way up to 25 percent.
         Next, there are improvements to the speed of type checking.
         This year, we improved the type-checker performance by reimplementing a key part of the generics system -- the part that computes a function signature from things like protocols and "where" clauses.
         In the old implementation, time and memory usage could scale exponentially as more protocols were involved.
         For example, here, we have a complicated set of protocols that define a coordinate system, with a lot of generic requirements on the many associated types.
         Previously, this would take 17 seconds to type-check this code.
         But now, in Swift 5.7, this example is able to type-check significantly quicker, in under a second.
         We also have some equally impressive runtime improvements.
         Before Swift 5.7, we've seen protocol checking on app startup take as long as four seconds on iOS.
         Protocols needed to be computed every time we launched apps, resulting in launch times that got longer the more protocols you added.
         Now, they're cached.
         Depending on how an app was written and how many protocols it used, this can mean launch times being cut in half in some apps when running on iOS 16.
         The session "Improve app size and runtime performance" will dive deeper into how you can leverage these improvements in your own application.
         Now, it's time for something I'm sure a lot of you have been eager to hear about.
         Last year, we introduced the new concurrency model, bringing together actors and async/await.
         This had a transformative effect on the concurrency architecture of your applications.
         Async/await and actors are safer and easier than callbacks and manual queue management.
         This year, we further fleshed out the model with data race safety at the forefront.
         Because concurrency was such a fundamental and important improvement to your app's codebase, we made it possible to back-deploy these changes all the way back to iOS 13 and macOS Catalina.
         In order to deploy to older operating systems, your app bundles a copy of the Swift 5.5 concurrency runtime for older OSes.
         This is similar to back-deploying Swift to operating systems before ABI stability.
         Next, we've taken this model in new directions.
         We've introduced language features and supporting packages.
         First, let's talk about data race avoidance.
         Before I jump into that, I should probably take a step back and say that one of the really important features of Swift, is memory safety by default.
         Swift users can't do things with unpredictable behavior, like reading a value while you're in the middle of modifying it.
         In this example, we're removing all of the numbers in an array that match the same array's count.
         Initially, the array's count is 3, so we'll remove the 3 from the array.
         But once we've done that, the count will be 2.
         Do we remove the 3 and the 2 from the array, or just the 3? The answer is neither.
         Swift will prevent you from doing this because it's not safe to access the array's count while you're in the middle of modifying it.
         Our goal is to do something similar for thread safety.
         We envision a language that eliminates low-level data races by default.
         In other words, we want to prevent concurrency bugs that can cause unpredictable behavior.
         Here's another example.
         Using the same number's array, we create a background task that appends 0 to the array, and then we remove the array's last element.
         But wait, does removing the last element happen before or after we append 0? The answer, again, is neither.
         Swift will block you from doing this because it's not safe to modify the array from a background task without synchronizing access with something like an actor.
         Actors were the first major step towards eliminating data races.
         This year we've refined the concurrency model to push us even further towards the end goal.
         You can think of each actor as its own island, isolated from everything else in the sea of concurrency.
         But what happens when different threads want to query the information stored by each of the isolated actors? This metaphor will be explored in depth in the session "Eliminate data races using Swift Concurrency."
         From memory safety to thread safety by default; that is the goal for Swift 6.
         To get us there, we first improved last year's concurrency model with the new language features I just mentioned.
         The second thing I haven't mentioned yet is the new opt-in safety checks that identify potential data races.
         You can experiment with stricter concurrency checking by enabling it in your build settings.
         Let's take a look at actors again.
         We can take this notion of actor isolation, and take it further with distributed actors.
         Distributed actors put those islands on different machines with a network between them.
         This new language feature makes developing distributed systems much simpler.
         Let's say you want to create a game app; you can now easily write the back end in Swift.
         Here, the distributed actor is like an actor but it might be on a different machine.
         In this example, we're looking at computer player that will maintain state during a game with a user.
         The distributed keyword can also be added to a function that we expect will need to be called on an actor that might be on a remote machine.
         Let's add another function called endOfRound.
         It will loop over the players and call makeMove on each one.
         Some of these players might be local or remote, but we have the benefit of not needing to care about which is which.
         The only difference from a regular actor call is that a distributed actor call can potentially fail because of network errors.
         In the event of a network failure, the actor method would throw an error.
         So, you need to add the try keyword as well as the usual await keyword that's needed when you call a function outside of the actor.
         Building on these core language primitives, we also built an open source Distributed Actors package that is focused on building server-side, clustered distributed systems in Swift.
         The package includes an integrated networking layer using SwiftNIO and implements the SWIM consensus protocol to manage state across the cluster.
         The "Meet distributed actors in Swift" session will go into more details on how to build distributed systems with these new features.
         We also launched a new set of open source algorithms to provide easy out-of-the-box solutions to common operations when dealing with AsyncSequence, which was released with Swift 5.5.
         Releasing these APIs as a package gives developers flexibility in deploying across platforms and operating system versions.
         There are several ways to combine multiple async sequences and to group values into collections.
         These are just some of the algorithms included in the package.
         Check out the "Meet Swift Async Algorithms" talk to see how you can use this new powerful API.
         But there's another aspect of concurrency, which is performance.
         This year, with actor prioritization, actors now execute the highest-priority work first.
         And continuing our deep integration with the operating system scheduler, the model has priority-inversion prevention built in, so less important work can't block higher-priority work.
         Historically, it has been really hard to visualize the performance impact of concurrency in your app.
         But now, we have a great new tool for doing exactly that.
         The new Swift Concurrency view in Instruments can help you investigate performance issues.
         The Swift Tasks and Swift Actors instruments provide a full suite of tools to help you visualize and optimize your concurrency code.
         At the top level, the Swift Tasks Instrument provides useful statistics, including the number of tasks running simultaneously and the total tasks that have been created up until that point in time.
         In the bottom half of this window, you can see what's referred to as a Task Forest.
         It provides a graphical representation of the parent-child relationships between tasks in structured concurrent code.
         This is just one of the detailed views for the Swift Actor Instrument.
         To learn how to use this exciting new tool, you'll want to hop over to the talk "Visualize and optimize Swift concurrency."
         And don't forget to give those new packages a try.
         Don't be shy to let us know how it's going on the forums.
         Now, I'll hand it over to Becca to talk about the many improvements to Swift language usability.
         Languages are tools, and there's a funny thing about tools -- they can really affect the things you build with them.
         When all you have is a hammer, you're going to build things with nails instead of screws.
         And even if you have a full set of tools, if your hammer has a big, grippy handle while your screwdriver is plasticky and hard to hold, you might still lean towards the nails.
         A language is the same way.
         If Swift has a good tool for expressing something, people will use it more often.
         And this year, Swift's tools for expressing what you want your code to do have improved in many ways.
         Some of these changes are simple conveniences for things you do often.
         For example, it's really common in Swift to use if let with the same name on both sides of the equal sign.
         After all, there probably isn't a better name for the unwrapped value than the name you gave the optional one.
         But when the name is really long, that repetition starts to get cumbersome.
         You might be tempted to abbreviate the name, but then your code becomes kind of cryptic.
         And if you later rename the optional variable, the abbreviation might get out of sync.
         Swift 5.7 introduces a new shorthand for this common pattern.
         If you're unwrapping an optional and want the unwrapped value to have the same name, just drop the right-hand side.
         Swift will assume it's the same.
         And of course, this also works with guard, too, and even while, for that matter.
         We also looked at places where a feature suddenly stops working when you make a minor change.
         For instance, Swift has always been able to figure out what type a call will return based on the code written inside a one-statement closure.
         In this compactMap call, the closure returns the value of parseLine, and the parseLine function returns a MailmapEntry, so Swift can figure out that entries should be an array of MailmapEntry.
         This now works for more complicated closures that have multiple statements or control flow features.
         So you can use do-catch, or if...else, or just add a print call, without having to manually specify the closure's result type.
         Another thing we looked at is danger flags that aren't really flagging any actual danger.
         Swift is very concerned with type and memory safety.
         To keep you from making mistakes, it never automatically converts between pointers with different pointer types, nor between raw pointers and typed pointers.
         This is very different from C, which allows certain conversions.
         For example, you can change the signed-ness of the pointee, or cast any pointer to char star to access it as bytes, without violating any of C's pointer rules.
         But sometimes these differences in pointer behavior will cause problems when a C API is imported into Swift.
         The original developer may have designed their APIs with slight mismatches that are handled by automatic conversions in C but are errors in Swift.
         In Swift, accessing a pointer of one type as though it were a different type is very dangerous, so you have to describe what you're doing very explicitly.
         But that's all pointless if we're passing the pointer directly to C, because in C, that pointer mismatch is perfectly legal! So in this case, we've treated something really straightforward as though it were dangerous.
         This matters because, as much as Swift values type safety, it also values easy access to C-family code.
         That's why C and Objective-C interop are so rich and seamless, and it's why the Swift project formed the C++ working group Angela mentioned earlier to start building equally capable C++ interop.
         We don't want using C functions like these to be unnecessarily painful.
         So Swift now has a separate set of rules for calls to imported functions and methods.
         It allows pointer conversions that would be legal in C even though they normally aren't in Swift.
         That way, your Swift code can use these APIs seamlessly.
         So far we've talked about small improvements to the tools you already had.
         But this year, Swift also has a brand-new tool for extracting information from strings.
         Here's a function that parses some information out of a string.
         This sort of task has always been a bit of a challenge in Swift.
         You end up searching, splitting, and slicing over and over until you get what you want.
         When people notice this, they tend to focus on the little things, like how wordy it can be to manipulate string indices, but I think that's kind of missing the bigger picture.
         Because even if we changed this syntax, it doesn't help you answer the basic question you're asking when you look at this code -- what does the line variable that's passed into it actually look like? What sort of string is it trying to take apart? If you stare at it long enough, you might realize that it's parsing a simplified version of a mailmap -- a file you put in a git repository to correct a developer's name in old commits.
         But extracting that information by searching and slicing is so involved that it's hard to figure that out.
         You get so lost in how to slice up the string that you kind of lose track of what that string is.
         The problem is not these two expressions; the problem is the whole thing.
         We need to rip out all of this and replace it with something better.
         We need a different approach; one where your code sort of draws a picture of the string you want to match, and the language figures out how to do it.
         A declarative approach, not an imperative one.
         In Swift 5.7, you can now do that by writing a regex.
         A regex is a way to describe a pattern in a string.
         For over 50 years, languages and tools have allowed developers to write regexes in a dense, information-packed syntax.
         Some of you already use them in the Xcode find bar, in command-line tools like grep, in Foundation's NSRegularExpression class, or in other programming languages.
         That syntax is now supported by Swift's regex literals, and it works just like it does in any other developer tool.
         But some of you haven't used regexes before and you're probably going, "Is that real code or did a cat walk across her keyboard?" And I don't blame you.
         Regex literals are written in symbols and mnemonics that you have to memorize in order to read them.
         To someone who knows the language, even the gnarliest parts of this regex, like the part that matches the developer's name are just combinations of several simple matching rules.
         But that's a lot of behavior to cram into 11 characters.
         Regex literals are so compact that even experienced developers sometimes need a minute to understand a complicated one.
         But what if you could write the same kind of matching rules, just with words instead of symbols? That seems like it'd be easier to understand.
         In fact, put it all together, and you get something that looks a lot like SwiftUI.
         That'd be a great alternative to a regex literal, wouldn't it? So it's a good thing Swift supports that! The RegexBuilder library provides a whole new SwiftUI-style language for regexes that's easier to use and more readable than the traditional syntax.
         It can do the same things a regex literal can, but it describes its behavior in words you can understand or look up, instead of symbols and abbreviations you have to memorize.
         Regex builders are great for beginners, but this is far from a beginner-only feature.
         It has powerful capabilities that go way beyond what a regex literal can do.
         To start with, you can turn a regex into a reusable regex component, just as you can turn a SwiftUI view hierarchy into a view.
         You can use these components from other regexes created with the builder syntax, and you can even make them recursive.
         Regex builders also support dropping some Swift types directly into a regex.
         For example, string literals just match the exact text inside them -- no special escaping needed.
         You can also use regex literals in the middle of a regex builder.
         So you can strike a balance between the clarity of a regex builder and the conciseness of a regex literal.
         And other types -- like this Foundation date-format style -- can integrate custom parsing logic with regex builders, and even convert the data to a richer type before capturing it.
         Finally, no matter which syntax you use, regexes support a bunch of useful matching methods and strongly typed captures that are easy to use.
         Now, for the regex nerds who have been squirming in their seats, Swift Regex uses a brand-new open source matching engine, with a feature set comparable to the most advanced regex implementations.
         The literal syntax is compatible with the Unicode regex standard, and it has an uncommon level of Unicode correctness.
         For instance, dot matches a whole character by default, not a Unicode.
        Scalar or a UTF-8 byte.
         To use Swift Regex, your app will need to be running on an OS with the Swift Regex engine built into it, like macOS 13 or iOS 16.
         Swift Regex is an entire language -- well, two languages, really -- so there's much more to say about it.
         These two sessions -- "Meet Swift Regex" and "Swift Regex: Beyond The Basics" -- will give you lots more details about using it.
         Finally, there's one place where we took a comprehensive look at the tools we have and made a bunch of changes to improve them.
         That's in generics and protocols.
         To show you how these tools have improved, I'll need an example protocol.
         Let's say you're writing a git client and you have to represent mailmaps in two different ways.
         When you're displaying commits, you use a type with a dictionary to quickly look up names.
         But when you're letting users edit the mailmap, you use a type with an array to keep the entries in their original order.
         And you have a protocol called Mailmap that both of them conform to, so your mailmap parser can add entries to either type.
         But there are two ways the parser could use the Mailmap protocol.
         I've written two different versions of this addEntries function to illustrate them, but it's actually kind of hard to explain how they're different, because Swift is using the same syntax for two different things.
         It turns out that the word "Mailmap" means one thing here but it means something subtly different here.
        When you name a protocol in an inheritance list, generic parameter list, generic conformance constraint, or an opaque result type, it means "an instance that conforms to this protocol."
         But in a variable type, a generic argument, a generic same-type constraint, or a function parameter or result type, it actually means "a box which contains an instance that conforms to this protocol."
         This distinction is important because the box typically uses more space, takes more time to operate on, and doesn't have all of the capabilities of the instance inside it.
         But the places where you're using a box look just like the places where you aren't, so it's hard to figure out if you're using one.
         Swift 5.7 fixes this oversight.
         When you're using one of these boxes containing a conforming type, Swift will now expect you to write the any keyword.
         This is not mandatory in code that was valid before Swift 5.7, but it is encouraged and you will see it in generated interfaces and error messages, even if you don't write it out explicitly.
         So the preferred way to write all of those things in the right-hand column is with the any keyword.
         If you do that, you'll be able to tell when you're using one of these boxes.
         Now that the any keyword marks one of the parameters in this example, it's a lot easier to explain the difference between these two functions.
         addEntries1 takes the Mailmap as a generic type; addEntries2 takes it as an any type.
         And it's also easier for error messages to explain what's happening when you hit one of the limitations of any types.
         For instance, this mergeMailmaps function tries to pass an any Mailmap to a generic Mailmap parameter.
         This used to produce an error saying that Mailmap cannot conform to itself, which always seemed kind of paradoxical.
         But now that we have the concept of any types, we can explain what's happening more clearly.
         The problem is that any Mailmap -- the box containing a mailmap -- doesn't conform to the Mailmap protocol.
         But the box is what you're trying to pass, and it doesn't fit into the generic parameter.
         If you want to pass the instance inside the box here, you'd have to somehow open up the box, take out the mailmap inside it, and pass that instead.
         But actually, in simple cases like this one, Swift will now just do that for you.
         Open up the box, take out the instance inside it, and pass it to the generic parameter.
         So you won't be seeing this error message nearly as much anymore.
         But there's an even more exciting improvement to any types than that one.
         Previously, a protocol could not be used as an any type if it either used the self type or had associated types, or even just conformed to a protocol that did, like Equatable.
         But in Swift 5.7, this error is just -- poof -- gone.
         A lot of developers have struggled with this one, so we're thrilled to have fixed it at the source.
         Now, that's exciting enough just for protocols like Mailmap, but this goes even further.
         Because even very sophisticated protocols, like Collection, can be used as any types.
         You can even specify the element type, thanks to a new feature called "primary associated types."
         A lot of associated types are basically just implementation details.
         You usually don't care which type a collection uses for its index, iterator, or subsequence; you just need to use the type it supports.
         But its Element is a different story.
         You might not always care exactly which Element type a collection uses, but you're probably going to do something with the elements, so you'll need to constrain them or return them or something.
         When you have an associated type like Element that nearly every user of a protocol will care about, you can put its name after the protocol's name in angle brackets to make it a primary associated type.
         Once you do that, you can constrain the protocol's primary associated types with the angle bracket syntax pretty much anywhere you can write the protocol's name, including in any Collection.
         Now, some of you might be looking at this type and going, "Wait a minute.
         Isn't there already something called AnyCollection, just run together and with the 'any' capitalized?" And you're right, there is! The old AnyCollection is a type-erasing wrapper -- a handwritten struct which serves the same purpose as an any type.
         The difference is that the AnyCollection struct is just line after line of the most boring boilerplate code you've ever seen in your life; whereas the any type is a built-in language feature that does basically the same thing -- for free! Now, the AnyCollection struct will stick around for backwards compatibility and because it has a couple of features that any types can't quite match yet.
         But if you have your own type-erasing wrappers in your code, you might want to see if you can reimplement them using built-in any types instead of box classes or closures.
         Or maybe even just replace them with type aliases.
         So Swift has dramatically improved any types.
         It's introduced the any keyword so you can see where you're using them.
         It allows you to pass them to generic arguments.
         It's abolished the restriction that kept many protocols from being used with them.
         And it even lets you constrain an any type's primary associated types.
         But even with all of those improvements, any types still have limitations.
         For example, even though you can now use any Mailmaps when Mailmap conforms to Equatable, you still can't use the equals operator with them, because the equals operator requires both mailmaps to have the same concrete type, but that's not guaranteed when you're using two any Mailmaps.
         So even though Swift has improved any types a lot, they still have important limitations, in both capabilities and performance.
         And that's why a lot of the time, you shouldn't use them -- you should use generics instead.
         So let's go back to the two versions of addEntries and apply that wisdom.
         Both versions do exactly the same thing, but the one on the top uses generic types, and the one on the bottom uses any types.
         The generic version will likely be more efficient and more capable, so you ought to use that one.
         And yet, you're probably tempted to use any types, because they're just so much easier to read and write.
         To write the generic version, you need to declare two generic type names, constrain them both, and finally, use those generic type names as the types of the parameters.
         That's just exhausting compared to writing "any Collection" and "any Mailmap.
        " So you'd be tempted to use any types despite their drawbacks.
         But that's the same thing I was talking about earlier -- using your hammer instead of your screwdriver because the hammer has a big, grippy handle.
         You shouldn't have to make that choice.
         So Swift is making generics just as easy to use as any types.
         If a generic parameter is only used in one place, you can now write it with the some keyword as a shorthand.
         And it even supports primary associated types, so you can accept all collections of mailmap entries with code that's a lot easier to understand.
         With that in your toolbox, there's no reason to avoid generics anymore.
         If you have a choice between generics and any types, generics will be just as easy to use -- just write "some" instead of "any".
         So you might as well use the best tool for the job.
         I've only scratched the surface of these changes to protocols and generics.
         For an in-depth look, as well as a great review of all of Swift's generics features, we have two more talks for you this year: "Embrace Swift generics," and "Design protocol interfaces in Swift."
         Now, Angela and I have talked about nearly two dozen changes to Swift, but there are lots more that we couldn't fit into this session.
         Every one of these changes was pitched, proposed, reviewed, and accepted publicly in the Evolution board on the Swift Forums.
         And all of them were shaped and realized with the help of community members from outside Apple.
         If you're one of those people, thank you for making Swift 5.7 the great release it is.
         And if you want to help decide what comes next, visit Swift.org/contributing to find out how to participate.
         Thanks for your time.
         And happy coding.

        """
    }

    var japanese: String {
        """
        こんにちは、私はアンジェラです。
         そして私はベッカです。
         Swiftの新機能へようこそ! 私たちは今日、Swift 5.7 の素晴らしい新機能のすべてについてお話しすることに、とても興奮しています。
         今日お話しすることの多くは、開発者としてのあなたの生活をより簡単にするという Swift の目標を実証するものです。
         私たちは、あなたのワークフローをカスタマイズするのに役立つ新しいツールと、いくつかの驚くべきアンダーザフードの改善について見ていきます。
         そして、Swift の並行処理モデルの最新版と、フルスレッドセーフを含む Swift 6 への道筋について話します。
         そして最後に、よりクリーンでシンプルなジェネリックスや、強力な新しい文字列処理機能など、Swift をより読みやすく、書きやすくするための言語の改良について紹介します。
         しかし、最初に、Swift をとても特別なものにしているものの1つについて話すことから始めましょう -- あなた方全員です。
         皆さんの意見や貢献が、Swiftの急速な拡大を可能にしたのです。
         コミュニティへの参加は、Swiftの核心です。
         今年、昨年発表されたドキュメント生成ツールであるdocCとSwift.orgのウェブサイトがオープンソース化され、Swiftプロジェクトのより多くがコミュニティで利用できるようになりました。 orgのウェブサイトがオープンソース化されました。
         オープンソースが最もうまく機能するのは、それを管理する活発なコミュニティがあるときです。
         私たちは、特定の分野に興味を持つコミュニティのメンバーにスチュワードシップとサポートを提供するために、Swift on Server と Diversity in Swift のためのワークグループモデルを使用してきました。
         これは本当にうまくいっているので、私たちは2つの新しいワークグループを開始しました。
         一つは、Swiftのウェブサイトを繰り返し、よりコミュニティのリソースにするためのもので、もう一つはC++の相互運用性のためのもので、C++とSwiftの間のモデルの設計を形成するためのものです。
         新しい領域に踏み出すには、コミュニティ内のメンバーからのサポートが必要です。
         その一環として、Swiftの多様性ワークグループは、昨年Swift Mentorship Programを導入しました。
         このプログラムは、どのように始めたらよいかわからない人々や、特定の領域で専門性を深めようとしている人々のために、ワークグループのすべての領域に貢献する道を提供します。
         昨年のプログラムは大成功でした。
         メンティーに興味を持つ人が多く、その結果、41組のメンターシップを作ることができました。
         この成功を受け、2年目もこのプログラムを開催することになりました。
         しかし、そのためには、幅広い知識を共有し、新しい人脈をつくる準備ができている、興奮した経験豊かな開発者のみなさんが必要です。
         メンターシップ・プログラムは、コードだけでなく、コミュニティ内の人間関係を構築するためのものだからです。
         そして、ちょっとした指導が長続きするのです。
         私の言葉をそのまま鵜呑みにしないでください。
         昨年、Amritはメンターシップ・プログラムに参加し、コンパイラと言語設計に焦点を当てました。
         最初は興味本位で始めたことが、具体的な貢献へと変わっていった。
         新しい分野に飛び込むのは、簡単なことではありません。
         しかし、彼女は成功を収め、さらに貢献したいと思うようになった。
         この経験は、他の多くの人と同じように、アムリットの扉を開くことになった。
         昨年は、コンパイラや言語設計に加え、テクニカルライティングやテスト、Swiftパッケージへの貢献など、幅広い分野にフォーカスすることができました。
         今年は、さらに多くのテーマを追加し、常に新しいトピックを提供する機会を設けています。
         もし、このリストの中に興味のあるものがなくても、応募の際にそのことを書いていただければ結構です。
         また、今年のプログラムでは、スターターバグの投稿に対して、年間を通じてメンターシップを提供し、参加能力が低くても、参加することに興味がある人に対応できるようにする予定です。
         もしあなたが応募することに興味があったり、もっと話を聞きたいと思っているなら、最新のSwiftブログポストをチェックしてください。
         そこでは、ハイライトされたメンティーからの詳細な振り返りへのリンクが見つかります。
         メンターシッププログラムは、Swiftの多様性の傘下にある1つの取り組みに過ぎません。
         メンターシッププログラムとSwiftの他の多様性の取り組みについてもっと知るには、Swift.org/diversityをご覧ください。
         さらにドアを開けるために、私たちは、あなたが持っているリソースでSwiftを使うことをできるだけ簡単にしたいと思います！私たちは、Swiftのツールチェインを合理化しました。私たちは、Linux パッケージ形式のサポートを追加することで、Linux プラットフォームのための Swift ツールチェイン配布プロセスを合理化しました。
         新しいネイティブツールチェーンインストーラーにより、Amazon Linux 2とCentOS 7のRPMをSwift.orgから直接ダウンロードすることができるようになりました。
         これらのツールチェーンは実験的なものなので、Swift.org のフォーラムでフィードバックを共有するようにしてください。 org のフォーラムでフィードバックを共有してください。
         Swiftは、主にアプリケーションを構築するために使用されます。
         しかし、Swiftのビジョンは常にスケーラブルであること、つまり高レベルのスクリプトからベアメタル環境まで、あらゆるものから使用されることです。
         Swiftがこれまで使われたことのない場所で使われることを促進するために、Swiftは今年、いくつかの大きな変更を行った。
         スタンドアロン、静的にリンクされたバイナリのために標準ライブラリを小さくするために、私たちは外部のユニコードサポートライブラリへの依存をやめ、より高速なネイティブの実装に置き換えたのです。
         より小さく、より速いバイナリは、イベントドリブンのサーバーソリューションで実行する際に大きな利点となります。
         Linuxではデフォルトでスタティックリンクを取得し、サーバーのコンテナ化されたデプロイメントをより良くサポートします。
         このサイズの縮小により、Swift は制限された環境にも適しており、Apple の Secure Enclave Processor で使用することができました。
         Swiftは、アプリからサーバーまで、制限のあるプロセッサに至るまで有用です。すべてを結びつけるのは、パッケージのエコシステムです。
         今年のSwiftパッケージの新機能は、あなたの生活をより良いものにするでしょう。
         手始めに、SwiftパッケージマネージャはTOFUを導入しました。
         いいえ、美味しいスナック菓子ではありません。
         TOFUは、Trust On First Useの頭文字をとったものです。
         これは新しいセキュリティ・プロトコルで、パッケージが最初にダウンロードされるときに、パッケージのフィンガープリントが記録されるようになりました。
         その後のダウンロードでは、このフィンガープリントを検証し、異なるフィンガープリントの場合はエラーを報告します。
         これは、パッケージのエコシステムの中核に信頼とセキュリティが組み込まれ、安心して使用できるようになった一例です。
         コマンドプラグインは、Swift 開発者のワークフローを改善するための素晴らしい方法です。
         それらは、より拡張可能で安全なビルドツールを提供するための最初のステップです。
         コマンドプラグインは、ドキュメント生成、ソースコードの再フォーマットなどに使用することができます。
         シェルスクリプトで自動化を書いて、別々のワークフローを維持する代わりに、Swift を使うことができます! オープンソースのフォーマッタとリンタを考える
         今、これらのすべてのオープンソースツールは、Xcode と Swift パッケージマネージャの中で利用可能です。
         コマンドプラグインは、オープンソースツールと Swift パッケージマネージャの間の接着剤です。
         Swift プロジェクトは、自動化されたワークフローとのシームレスな統合を提供するために、オープンソースコミュニティの開発者のツールを受け入れています。
         docC は、ソースコードにドキュメントを統合するための素晴らしいツールです。
         今年は、Objective-CとCをサポートして、さらに良くなりました。
         docCでプラグインを作成するために必要なことを見てみましょう。
         プラグインは、単純な Swift のコードです。
         CommandPluginプロトコルに準拠した構造体を作ることで、プラグインを定義することができます。
         そして、どのツールを呼び出したいかをプラグインに伝える関数を追加するだけです。
         この関数の中で、docCを呼び出すことになります。
         一度プラグインを定義すると、Swift PM のコマンドラインインターフェイスと Xcode のメニュー項目として利用できるようになります。
         これで、ドキュメントを生成するように Swift PM に伝えることができ、このアクションを docC 実行ファイルに渡すことができるようになりました。
         それだけにとどまりません。
         ビルドツールプラグインとして知られる2つ目のプラグインがあります。
         これらのプラグインは、ビルド中に追加のステップを挿入することを可能にするパッケージです。
         ビルドツールプラグインを実装すると、ビルドシステムがサンドボックス内で実行するためのコマンドが作成されます。
         これは、いつでも直接実行でき、パッケージ内のファイルを変更する明示的な権限を付与できるコマンドプラグインとは異なります。
         ビルドツールプラグインは、ソースコードの生成や特殊なファイルのカスタム処理に使用することができます。
         ビルドツールプラグインでは、これはパッケージレイアウトになります。
         この例では、プラグイン
        Swift はパッケージのプラグインターゲットを実装する Swift スクリプトです。
         プラグインはSwiftの実行ファイルとして扱われます。
         そして、任意のSwift実行ファイルを書くのと同じ方法でプラグインを書きます。
         ビルドコマンドのセットを定義することで、ビルドシステムに実行する実行可能なコマンドと、結果として期待される出力を伝えることで、プラグインを実装することができます。
         パッケージプラグインは、あなたのパッケージの拡張性を提供する安全なソリューションです。
         プラグインがどのように機能するのか、そしてどのように独自のプラグインを実装するのか、"Meet Swift Package plugins" と "Create Swift Package plugins" という2つのセッションで詳しく学ぶことができます。
         パッケージの使用を拡大するにつれて、モジュールの衝突に遭遇することがあります。
         それは、2つの別々のパッケージが、同じ名前のモジュールを定義している場合です。
         この状況を解決するために、Swift 5.7 はモジュールの曖昧さ回避を導入しています。
         モジュールの曖昧さ回避は、モジュールを定義しているパッケージの外からモジュールの名前を変更することができる機能です。
         ここで、私たちの Stunning アプリケーションでは、Logging モジュールを定義する 2 つのパッケージを持ってきているため、それらが衝突しています。
         Stunning アプリケーションでこれを修正するには、パッケージマニフェストの dependencies セクションに moduleAliases キーワードを追加するだけです。
         そうすれば、以前は同じ名前だったモジュールを区別するために、2つの異なる名前を使用することができます。
         Swift 5.7 は、いくつかの素晴らしいパフォーマンスの改善をもたらします。
         まず、ビルド時間から見ていきましょう。
         昨年、私たちは Swift Driver -- Swift ソースコードの Swift でのコンパイルを調整するプログラム -- をどのように書き換えたかについてお伝えしました。
         昨年の再設計は、ビルドを大幅に高速化するいくつかの本当に重要な変更の鍵を開けました。
         ドライバは、独立した実行ファイルとしてではなく、Xcode ビルドシステム内で直接フレームワークとして使用することができるようになりました。
         これにより、ビルドシステムとより密接にビルドを調整し、並列化などを可能にする。
         もしあなたが、ビルドが速いという響きが好きな人なら、「Xcodeビルドにおける並列化の謎解き」セッションで詳細を知ることができます。
         ビルドがどれだけ速くなったかを示すために、私たちがよく使う、Swiftで書かれたツールのいくつかをビルドするのにかかる時間の例を見てみましょう。
         10コアのiMacでは、5パーセントから一気に25パーセントまで向上しています。
         次に、型チェックの高速化です。
         今年は、ジェネリックスシステムの重要な部分、つまりプロトコルや「where」句などから関数のシグネチャを計算する部分を再実装し、型チェックのパフォーマンスを向上させました。
         以前の実装では、プロトコルの数が増えるにつれて、時間とメモリの使用量が指数関数的に増大する可能性がありました。
         例えば、ここでは座標系を定義する複雑なプロトコルのセットがあり、関連する多くの型に多くの汎用的な要件があります。
         以前は、このコードをタイプチェックするのに17秒かかっていました。
         しかし今、Swift 5.7では、この例は1秒以下と大幅に速くタイプチェックすることができます。
         また、同様に素晴らしい実行時の改善もあります。
         Swift 5.7 より前の iOS では、アプリの起動時のプロトコルチェックに 4 秒もかかることがありました。
         アプリを起動するたびにプロトコルを計算する必要があり、結果として起動時間はプロトコルを追加すればするほど長くなっていました。
         しかし、現在はキャッシュされています。
         アプリの書き方や使用するプロトコルの数にもよりますが、iOS 16で実行する場合、アプリによっては起動時間が半分に短縮されることになります。
         セッション「アプリのサイズとランタイムパフォーマンスを改善する」では、これらの改善を自分のアプリケーションでどのように活用できるかを深く掘り下げていきます。
         さて、ここからは、多くの方が待ち望んでいた話題です。
         昨年、私たちは新しい並行処理モデルを導入し、アクターと非同期/待ちを統合しました。
         これは、アプリケーションの並行処理アーキテクチャに大きな変化をもたらしました。
         非同期/待ち受けとアクターは、コールバックや手動でのキュー管理よりも安全で簡単です。
         今年は、データレースセーフを前面に出して、さらにモデルを練り上げました。
         同時実行は、アプリのコードベースにとって基本的かつ重要な改善であるため、これらの変更を iOS 13 と macOS Catalina にまで遡ってバックデプロイすることを可能にしました。
         古い OS にデプロイするために、アプリには、古い OS 用の Swift 5.5 同時実行ランタイムのコピーがバンドルされています。
         これは、ABI が安定する前の OS に Swift をバックデプロイするのと似ています。
         次に、私たちはこのモデルを新しい方向へと導きました。
         言語機能とサポートするパッケージを導入しました。
         まず、データレースの回避についてです。
         この話に入る前に、一歩下がって、Swiftの本当に重要な機能の1つは、デフォルトでメモリ安全性であると言うべきかもしれません。
         Swiftのユーザーは、値を変更している最中に値を読み取るような、予測不可能な動作をすることはできません。
         この例では、同じ配列のcountに一致する配列内の数値をすべて削除しています。
         最初は配列のcountが3なので、配列から3を削除します。
         しかし、それを実行すると、カウントは2になります。
         このとき、配列から3と2を取り除くのでしょうか、それとも3だけを取り除くのでしょうか？答えはどちらでもありません。
         配列の修正中に配列のカウントにアクセスすることは安全ではないので、Swiftはこれを行うことを妨げます。
         私たちの目標は、スレッドセーフのために同じようなことをすることです。
         低レベルのデータ競合をデフォルトで排除するような言語を想定しています。
         つまり、予測不可能な動作を引き起こす並行処理のバグを防ぎたいのです。
         もうひとつ例を挙げよう。
         同じ数値の配列を使って、配列に0を追加し、配列の最後の要素を削除するバックグラウンドタスクを作成します。
         しかし、最後の要素を削除するのは、0を追加する前でしょうか、それとも後でしょうか？答えは、もう一度言いますが、どちらでもありません。
         アクターのようなものとアクセスを同期させることなく、バックグラウンドタスクから配列を変更することは安全ではないので、Swift はこれを行うことをブロックします。
         アクターは、データ競合を排除するための最初の主要なステップでした。
         今年、私たちは並行処理モデルを改良し、最終目標に向けてさらに前進させました。
         各アクターは、並行処理の海の中で他のものから隔離された、自分だけの島だと考えることができます。
         しかし、異なるスレッドが、分離された各アクターによって格納された情報を照会したい場合はどうなるのでしょうか？このメタファーについては、セッション "Swift Concurrency を使ってデータ競合を排除する" で深く掘り下げていきます。
         メモリ安全性からデフォルトでスレッド安全性へ、それがSwift 6の目標です。
         そこに到達するために、私たちはまず、今述べた新しい言語機能で昨年の並行処理モデルを改善しました。
         2つ目は、まだ触れていませんが、潜在的なデータ競合を特定する新しいオプトインの安全性チェックです。
         ビルド設定で有効にすることで、より厳格な並行性チェックを試すことができます。
        もう一度、アクターについて見てみましょう。
        このアクターの分離という概念をさらに発展させ、分散アクターとすることができます。
        分散アクターは、それらの島を、ネットワークを介した異なるマシンに置きます。
        この新しい言語機能により、分散システムの開発がよりシンプルになります。
        例えば、ゲームアプリを作りたいとしましょう。Swiftで簡単にバックエンドを書くことができるようになりました。
        ここで、分散アクターは、アクターのようなものですが、別のマシンにあるかもしれません。
        この例では、ユーザーとのゲーム中に状態を維持するコンピュータのプレーヤーを見ています。
        distributed キーワードは、リモートマシン上にあるアクター上で呼び出される必要があると予想される関数に追加することもできます。
        ここでは、endOfRoundという関数を追加してみましょう。
        この関数はプレーヤーをループして、各プレーヤーに対して makeMove を呼び出します。
        これらのプレーヤーの中にはローカルまたはリモートのものがありますが、どれがどれかを気にする必要がないという利点があります。
        通常のアクター呼び出しとの唯一の違いは、分散アクター呼び出しはネットワーク エラーによって失敗する可能性があることです。
        ネットワークに障害が発生した場合、アクターメソッドはエラーを投げることになります。
        そのため、アクター外の関数を呼び出す際に必要な通常のawaitキーワードの他に、tryキーワードを追加する必要があります。
        これらのコア言語プリミティブを基に、私たちは、Swift でサーバーサイド、クラスタ化された分散システムを構築することに焦点を当てた、オープンソースの分散アクターパッケージも構築しました。
        このパッケージには、SwiftNIO を使用した統合ネットワーク層が含まれており、クラスタ全体の状態を管理するために SWIM コンセンサスプロトコルを実装しています。
        Meet distributed actors in Swift" セッションでは、これらの新機能を使って分散システムを構築する方法について、より詳しく説明します。
        また、Swift 5.5 でリリースされた AsyncSequence を扱う際に、一般的な操作に対する簡単ですぐに使えるソリューションを提供する、新しい一連のオープンソースアルゴリズムを発表しました。
        これらのAPIをパッケージとしてリリースすることで、開発者はプラットフォームやオペレーティングシステムのバージョンを超えて柔軟に展開することができます。
        複数の非同期シーケンスを組み合わせたり、値をコレクションにグループ化したりする方法がいくつかあります。
        これらはパッケージに含まれるアルゴリズムの一部に過ぎません。
        この新しい強力な API をどのように使うかについては、「Swift 非同期アルゴリズムの紹介」の講演をチェックしてください。
        しかし、並行処理の別の側面、それはパフォーマンスです。
        今年、アクターの優先順位付けにより、アクターは最も優先度の高い作業を最初に実行するようになりました。
        また、オペレーティングシステムのスケジューラとの深い統合を継続し、このモデルには優先順位の逆転防止機能が組み込まれており、重要度の低い作業が優先順位の高い作業をブロックすることはありません。
        これまで、アプリケーションの並行処理が性能に与える影響を可視化することは、非常に困難なことでした。
        しかし今、まさにそれを行うための素晴らしい新しいツールを手に入れました。
        Instruments の新しい Swift Concurrency ビューは、パフォーマンスの問題を調査するのに役立ちます。
        Swift Tasks と Swift Actors のインストルメントは、同時実行コードを視覚化して最適化するのに役立つ、完全なツール群を提供します。
        トップレベルでは、Swift Tasks インストルメントが、同時に実行されているタスクの数や、その時点までに作成されたタスクの合計など、有用な統計情報を提供します。
        このウィンドウの下半分では、タスクフォレストと呼ばれるものを見ることができます。
        これは、構造化された並行処理コードのタスク間の親子関係をグラフィカルに表現したものです。
        これは Swift Actor Instrument の詳細なビューのひとつに過ぎません。
        このエキサイティングな新しいツールの使い方を学ぶには、"Visualize and optimize Swift concurrency" という講演に飛びつくことになるでしょう。
        そして、それらの新しいパッケージを試してみることを忘れないでください。
        恥ずかしがらずに、フォーラムで様子を教えてください。
        それでは、Swift言語の使いやすさの多くの改善について、ベッカに話を譲りたいと思います。
        言語はツールです。ツールについて面白いことがありまして、ツールはそれを使って作るものに大きな影響を与えます。
        ハンマーしか持っていないと、ネジではなく釘でモノを作ることになります。
        また、道具が一通り揃っていても、ハンマーが大きくて握りやすいハンドルで、ドライバーがプラスチックで持ちにくかったら、やはり釘の方に傾くかもしれません。
        言語も同じです。
        Swiftが何かを表現するための良い道具を持っていれば、人々はそれをより頻繁に使うようになります。
        そして今年、コードに何をさせたいかを表現するためのSwiftのツールは、多くの点で改善されました。
        これらの変更のいくつかは、あなたが頻繁に行うことのための単純な利便性です。
        例えば、等号の両側で同じ名前のif letを使用することは、Swiftでは本当によくあることです。
        結局のところ、あなたがオプションのものを与えた名前よりも、ラップされていない値のためのより良い名前はおそらくありません。
        しかし、その名前が本当に長い場合、その繰り返しが面倒になり始めます。
        名前を省略したくなるかもしれませんが、そうするとコードがわけのわからないものになってしまいます。
         そして、後でオプショナル変数の名前を変更した場合、省略形が同期しなくなる可能性があります。
         Swift 5.7 では、このよくあるパターンのための新しい略記法を導入しています。
         オプショナルをアンラップしていて、アンラップされた値が同じ名前を持つようにしたい場合、右側をドロップするだけです。
         Swift はそれが同じであるとみなします。
         そしてもちろん、これはガードもそうですし、それどころかwhileでも有効です。
         また、ちょっとした変更をしたときに、ある機能が突然使えなくなるような場所にも注目しました。
         例えば、Swiftは常に1ステートメントクロージャの中に書かれたコードに基づいて、呼び出しがどのような型を返すかを把握することができました。
         このコンパクトマップの呼び出しでは、クロージャは parseLine の値を返し、parseLine 関数は MailmapEntry を返すので、Swift はエントリが MailmapEntry の配列でなければならないことを理解することができます。
         これは今、複数のステートメントや制御フロー機能を持つより複雑なクロージャのために動作します。
         そのため、クロージャの結果の型を手動で指定することなく、do-catch、または if...else を使用したり、単に print 呼び出しを追加したりすることができます。
         もう1つ、私たちが調べたのは、実際の危険性を示すフラグではない危険フラグです。
         Swiftは、型とメモリの安全性に非常に注意を払っています。
         間違いを起こさないように、異なるポインタ型を持つポインタ間や、生のポインタと型付きポインタ間の自動変換は決して行いません。
         これは、特定の変換を許可しているC言語とは大きく異なります。
         例えば、ポインタの符号付きを変更したり、任意のポインタを char star にキャストしてバイトとしてアクセスしたりすることは、C のポインタの規則に違反することなく行うことができます。
         しかし、時々、ポインタの動作のこれらの違いは、CのAPIがSwiftにインポートされたときに問題を引き起こします。
         元の開発者は、C言語では自動変換で処理されるのに、SwiftではエラーとなるわずかなミスマッチでAPIを設計している可能性があります。
         Swiftでは、ある型のポインタを別の型であるかのようにアクセスすることは非常に危険なので、非常に明示的に何をしているのかを記述しなければなりません。
         しかし、C言語ではそのポインタの不一致は完全に合法なので、ポインタを直接C言語に渡しているのであれば、それはすべて無意味なことなのです この場合、私たちは本当に簡単なことを危険であるかのように扱いました。
         Swiftが型の安全性を重視するのと同じくらい、Cファミリーのコードに簡単にアクセスできることも重視するので、これは重要です。
         それが、CとObjective-Cの相互運用がとても豊かでシームレスである理由であり、Swiftプロジェクトが、同様に有能なC++の相互運用を構築し始めるために、先に述べたC++ワーキンググループを形成した理由なのです。
         私たちは、このようなCの関数を使うことが不必要に苦痛にならないようにしたいのです。
         そこでSwiftでは、インポートされた関数やメソッドを呼び出すためのルールを別に設けています。
         それは、通常Swiftでは合法でなくても、Cで合法であるようなポインタの変換を許可します。
         そうすることで、SwiftのコードはこれらのAPIをシームレスに使用することができます。
         ここまでは、すでに持っているツールの小さな改良について話してきました。
         しかし、今年、Swiftには、文字列から情報を抽出するための全く新しいツールもあります。
         ここに、文字列からいくつかの情報を解析する関数があります。
         この種のタスクは、Swiftでは常にちょっとした挑戦でした。
         結局、欲しいものを得るまで、何度も何度も検索、分割、スライスしてしまうのです。
         人々がこれに気づいたとき、彼らは、文字列のインデックスを操作するためにどれだけ言葉が必要になるかというような小さなことに焦点を当てがちですが、私はそれが大きな絵を見逃しているようなものだと思います。
         なぜなら、この構文を変えたとしても、このコードを見たときに抱く基本的な疑問、つまり、渡された行変数が実際にはどのように見えるのか？このコードに渡された行変数は実際にはどのようなものなのか？長い間眺めていると、メールマップの簡易版を解析していることに気づくかもしれません。メールマップとは、古いコミットで開発者の名前を修正するために git リポジトリに置くファイルです。
         でも、検索やスライスによってその情報を抽出することは、とても複雑なので、それを理解するのは難しいんです。
         どうやってスライスするかで迷ってしまい、なんだかその文字列が何なのかがわからなくなってしまうのです。
         問題はこの2つの表現ではなく、全体にあるのです。
         問題なのはこの2つの式ではなく、これらすべてです。
         マッチさせたい文字列のイメージをコードが描き、言語がその方法を見つけ出すというような、異なるアプローチが必要なのです。
         命令型アプローチではなく、宣言型アプローチです。
         Swift 5.7では、正規表現を書くことによって、それを行うことができます。
         正規表現は、文字列でパターンを記述する方法です。
         50年以上にわたって、言語とツールは、開発者が密集した、情報満載の構文で正規表現を書くことを可能にしてきました。
         あなたの何人かは、すでにXcodeの検索バーで、grepのようなコマンドラインツールで、FoundationのNSRegularExpressionクラスで、または他のプログラミング言語で、それらを使用しています。
         その構文は、現在 Swift の正規表現リテラルでサポートされており、他の開発者ツールで行うのと同じように動作します。
         でも、正規表現を使ったことがない人は、「これは本物のコードなのか、それとも猫がキーボードを横切ったのか」と思うかもしれない。そして、私はあなたを責めるつもりはありません。
         正規表現リテラルは記号やニーモニックで書かれているので、それを読むためには暗記しなければなりません。
         この言語を知っている人にとっては、この正規表現の最も厄介な部分、例えば開発者の名前にマッチする部分でさえ、いくつかの単純なマッチングルールの組み合わせに過ぎないのです。
         しかし、11文字の中に多くの動作を詰め込むのは大変なことです。
         正規表現は非常にコンパクトなので、経験豊富な開発者でも複雑なものを理解するのに1分ほどかかることがあります。
         しかし、同じようなマッチングルールを、記号ではなく単語で書けるとしたらどうでしょう？その方が理解しやすそうですね。
         実際、それをすべてまとめると、SwiftUIによく似たものができあがります。
         それは正規表現リテラルの素晴らしい代替になるのではないでしょうか？だから、Swiftがそれをサポートするのは良いことです! RegexBuilderライブラリは、従来の構文よりも使いやすく、読みやすい、正規表現のための全く新しいSwiftUIスタイルの言語を提供します。
         これは、正規表現リテラルができることと同じことを行うことができますが、覚えなければならない記号や略語の代わりに、理解したり調べたりできる言葉でその動作を記述しています。
         Regexビルダーは初心者に最適ですが、これは初心者専用の機能ではありません。
         正規表現リテラルができることをはるかに超えた強力な機能を備えています。
         手始めに、SwiftUIのビュー階層をビューに変えるのと同じように、正規表現を再利用可能な正規表現コンポーネントに変えることができます。
         ビルダー構文で作成された他の正規表現からこれらのコンポーネントを使用することができ、それらを再帰的にすることさえできます。
         正規表現ビルダーは、いくつかの Swift の型を直接正規表現にドロップすることもサポートしています。
         たとえば、文字列リテラルは、それらの中の正確なテキストにマッチします - 特別なエスケープは必要ありません。
         また、正規表現ビルダーの途中で正規表現リテラルを使用することができます。
         正規表現ビルダーの明快さと、正規表現リテラルの簡潔さのバランスをとることができます。
         また、このFoundationの日付フォーマットのような型では、独自の解析ロジックを正規表現ビルダーに統合し、データを取り込む前によりリッチな型に変換することもできます。
         最後に、どの構文を使っても、正規表現は多くの便利なマッチングメソッドと強く型付けされたキャプチャをサポートしており、簡単に使うことができます。
         さて、席でもじもじしている正規表現オタクのために、Swift Regex は最も高度な正規表現の実装に匹敵する機能セットを持つ、まったく新しいオープンソースのマッチングエンジンを使用します。
         リテラルの構文は Unicode 正規表現規格と互換性があり、Unicode の正しさでは並外れたレベルを持っています。
         例えば、ドットはデフォルトで文字全体にマッチし、Unicode.
        スカラーや UTF-8 バイトではありません。
         Swift Regex を使用するには、アプリは macOS 13 や iOS 16 のような Swift Regex エンジンが組み込まれた OS 上で実行される必要があります。
         Swift Regex は言語全体 -- いや、実際には 2 つの言語 -- なので、それについて語るべきことはもっとたくさんあります。
         この2つのセッション -- 「Meet Swift Regex」と「Swift Regex: Beyond The Basics」 -- では、その使用法についてより多くの詳細が語られます。
         最後に、私たちが持っているツールを包括的に見て、それらを改善するために多くの変更を行った場所が1つあります。
         それは、ジェネリックとプロトコルにあります。
         これらのツールがどのように改善されたかをお見せするには、プロトコルの例が必要です。
         gitクライアントを書いていて、2種類の方法でメールマップを表現しなければならないとします。
         コミットを表示するときには、名前をすばやく検索できるように辞書付きの型を使用します。
         しかし、ユーザーにメールマップを編集させる場合は、エントリーを元の順序で保持するために配列を持つ型を使用します。
         メールマップパーサはどちらの型にもエントリーを追加することができます。
         しかし、パーサーがMailmapプロトコルを使うには2つの方法があります。
         私はそれらを説明するために、このaddEntries関数の2つの異なるバージョンを書きましたが、Swiftが2つの異なるもののために同じ構文を使用しているので、それらがどのように異なっているかを説明するのは、実際にはちょっと難しいです。
         それは、"Mailmap "という単語が、ここでは一つのことを意味しますが、ここでは微妙に異なることを意味することがわかりました。
        継承リスト、汎用パラメータリスト、汎用適合性制約、不透明な結果型でプロトコルを名付けると、それは "このプロトコルに適合するインスタンス" を意味します。
         しかし、変数型、汎用引数、汎用同一型制約、関数パラメータや結果型では、実際には "このプロトコルに適合するインスタンスを含むボックス" という意味になります。
         この区別は重要で、箱は通常、より多くのスペースを使い、操作に時間がかかり、その中のインスタンスのすべての機能を備えているわけではないからです。
         しかし、ボックスを使用している場所は、使用していない場所と同じように見えるので、ボックスを使用しているかどうかを把握することは困難です。
         Swift 5.7 では、この見落としが修正されました。
         適合する型を含むこれらのボックスのいずれかを使用しているとき、Swift は any キーワードを書き出すことを期待するようになりました。
         これは Swift 5.7 より前に有効だったコードでは必須ではありませんが、推奨されており、たとえ明示的に書き出さなかったとしても、生成されたインターフェースとエラーメッセージで見ることができます。
         ですから、右側の列にあるものをすべて書くのに望ましいのは、anyキーワードを使う方法です。
         そうすれば、これらのボックスのいずれかを使用しているときに、それを見分けることができるようになります。
         さて、この例ではanyキーワードがパラメータの1つをマークしているので、この2つの関数の違いを説明するのがとても簡単になりました。
         addEntries1 は Mailmap を generic 型として受け取り、addEntries2 は any 型として受け取ります。
         また、any型の制限にぶつかったときに何が起こっているのか、エラーメッセージで説明するのも簡単です。
         たとえば、この mergeMailmaps 関数は、汎用 Mailmap パラメータに any Mailmap を渡そうとしています。
         これまでは、Mailmapは自分自身に適合できないというエラーが発生し、逆説的な感じがしていました。
         しかし、any型の概念ができたので、何が起こっているのかがもっと明確に説明できるようになりました。
         問題は、どんなMailmapも--Mailmapを含むボックスも--Mailmapのプロトコルに準拠していないことです。
         しかし、ボックスはあなたが渡そうとしているものであり、ジェネリックパラメータに適合しない。
         もしボックスの中のインスタンスを渡したいなら、何らかの方法でボックスを開けて、その中のメールマップを取り出して、代わりにそれを渡さなければならない。
         しかし実は、このような単純なケースでは、Swiftは今ちょうどあなたのためにそれを行います。
         ボックスを開き、その中のインスタンスを取り出して、それをジェネリックパラメータに渡します。
         ですから、もうこのエラーメッセージを見ることはほとんどありません。
         しかし、それよりももっとエキサイティングな改良があらゆる型に施されている。
         以前は、プロトコルは self 型を使用するか、関連する型を持っているか、あるいは Equatable のような、関連するプロトコルに準拠している場合、any 型として使用することが出来ませんでした。
         しかし、Swift 5.7 では、このエラーはちょうど -- パッと -- 消えてしまいました。
         多くの開発者がこのエラーで苦労していたので、ソースで修正できたことに感激しています。
         Mailmapのようなプロトコルだけでも十分にエキサイティングですが、これはさらに先に進みます。
         なぜなら、Collectionのような非常に洗練されたプロトコルでも、任意の型として使用することができるからです。
         "プライマリー・アソシエイテッド・タイプ "という新機能のおかげで、要素のタイプを指定することもできるんだ。
         多くの関連型は、基本的に実装の詳細だけだ。
         通常、コレクションがインデックス、イテレータ、サブシーケンスにどの型を使うかは気にせず、それがサポートする型を使用すればよい。
         しかし、そのエレメントはまた別の話です。
         コレクションがどのElement型を使うかは、必ずしも気にする必要はないでしょうが、おそらくElementで何かをすることになるので、それらを制約したり、返したりする必要があるでしょう。
         Elementのような、プロトコルのほぼすべてのユーザが気にするような関連型がある場合、その名前をプロトコル名の後に角括弧で囲んで、主関連型とすることができます。
         そうすれば、プロトコルの名前を書ける場所ならどこでも、Collectionでも、角括弧構文でプロトコルの主要な関連型を制約することができる。
         さて、この型を見て、「ちょっと待てよ、すでにAnyという型があるじゃないか」と思う人もいるかもしれない。
         AnyCollectionというのが既にあるじゃないか、anyを大文字にして一緒に走らせればいいだけじゃないか？その通り、ありますよ。古いAnyCollectionは、型を消去するラッパーで、any型と同じ役割を果たす手書きの構造体である。
         違いは、AnyCollection構造体は、今まで見たこともないような退屈な定型文が何行も何行も続くだけなのに対し、any型は、基本的に同じことを無料で行う組み込みの言語機能であることです。AnyCollection構造体は後方互換性を保つため、また、any型がまだ対応できないいくつかの機能を備えているため、このまま存続する予定です。
         しかし、もしあなたのコードに独自の型消去ラッパーがあるならば、ボックスクラスやクロージャの代わりに組み込みのany型を使用して再実装できないか試してみるのもいいかもしれない。
         あるいは、それらを型エイリアスに置き換えることさえあるかもしれません。
         そこで Swift は、any 型を劇的に改善しました。
         それは、あなたがそれらを使用している場所を見ることができるように、any キーワードを導入しました。
         それは、それらを一般的な引数に渡すことを可能にします。
         それは、多くのプロトコルがそれらと一緒に使用されるのを防いでいた制限を廃止しました。
         さらに、any型の主要な関連型を制限することもできる。
         しかし、これらの改善点を考慮しても、any型にはまだ制限がある。
         例えば、Mailmap が Equatable に準拠するとき、any Mailmap を使えるようになったとしても、equals 演算子は、両方の Mailmap が同じ具象型を持つ必要がありますが、2 つの any Mailmap を使っているときは、それが保証されないため、まだそれらを使って equals を使用することはできません。
         Swift が any 型をかなり改善したとはいえ、機能とパフォーマンスの両方において、重要な制限が残っています。
         そしてそれが、多くの場合、それらを使うべきではない理由です -- 代わりにジェネリックスを使うべきなのです。
         では、addEntriesの2つのバージョンに戻り、この知恵を応用してみましょう。
         どちらのバージョンもまったく同じことをしますが、上のバージョンはジェネリック型を使用し、下のバージョンは任意の型を使用します。
         汎用型の方がより効率的で高機能なので、そちらを使うべきでしょう。
         でも、読み書きが楽だから、任意の型を使いたくなることもあるだろう。
         汎用型を書くには、2つの汎用型名を宣言し、その両方を制約し、最後にその汎用型名をパラメータの型として使わなければならない。
         これは、"any Collection "や "any Mailmap "と書くのに比べて、とても大変な作業だ。
        " だから、欠点があるにもかかわらず、任意の型を使いたくなるんだ。
         でもそれは、さっきの話と同じで、ドライバーの代わりにハンマーを使うのは、ハンマーに大きくて握りやすい柄があるからです。
         そのような選択をする必要はないはずです。
         ですからSwiftは、ジェネリックを他の型と同じように使いやすくしています。
         ジェネリックパラメータが1つの場所でしか使われない場合、短縮形としてsomeキーワードで書くことができるようになりました。
         さらに、主関連型もサポートしているので、メールマップエントリーのすべてのコレクションを、より理解しやすいコードで受け入れることができます。
         これさえあれば、もうジェネリックスを避ける理由はありません。
         もし、ジェネリックスと任意の型のどちらかを選ぶのであれば、ジェネリックスも同じように使いやすいでしょう--「任意の」の代わりに「ある」と書くだけです。
         つまり、その仕事に最適なツールを使ったほうがいいのです。
         ここでは、プロトコルとジェネリックスの変更点について、ほんの少し触れてみただけです。
         Swift のジェネリクス機能のすべての素晴らしいレビューと同様に、より深く見るために、私たちは今年さらに 2 つの講演を行っています。"Swiftのジェネリックスを受け入れる "と "Swiftでプロトコルインターフェイスを設計する "です。
         さて、Angela と私は、Swift へのほぼ 20 の変更について話してきましたが、このセッションに収まりきらないほど、もっとたくさんの変更があります。
         これらの変更のすべてが、Swift Forums の Evolution ボードで公に提案され、検討され、受け入れられました。
         そして、それらすべては、Appleの外部からのコミュニティメンバーの助けによって形作られ、実現されました。
         もしあなたがそのうちの一人なら、Swift 5.7 を素晴らしいリリースにしてくれてありがとうございます。
         そして、もしあなたが次に来るものを決めるのを手伝いたいのであれば、Swift.org/contributing を訪れて、参加する方法を見つけてください。
         お時間をいただきありがとうございました。
         そして、ハッピーコーディング。

        """
    }
}

