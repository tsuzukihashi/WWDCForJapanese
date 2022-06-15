import Foundation

struct WhatsNewWithInAppPurchase: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "What's new with in-app purchase"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6496/6496_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10007/")!
    }

    var english: String {
        """
        Dani Chootong: Hello, and welcome to "What's new with in-app purchase."
        I'm Dani, and I'm an engineer on the StoreKit team.
        Today I'll be presenting with my colleague Ian, and we'll be going over the new improvements we're bringing to in-app purchase this year.
        Last year, we introduced StoreKit 2, a set of new APIs designed from the ground up to make it simple to integrate in-app purchases.
        StoreKit 2 uses modern language features, including Swift concurrency using the async/await pattern.
        On the server side, we complemented these new StoreKit features with an entirely new set of App Store Server endpoints.
        These server endpoints make it easy to retrieve transaction information and check subscription status on your server.
        We also released Version 2 of App Store Server Notifications, to make tracking the subscription lifecycle on your server easier than ever.
        Today I'll be going over these new APIs, as well as enhancements we're bringing to the new StoreKit models.
        Then, Ian will walk you through some exciting new server updates, including App Store Server API enhancements and brand-new APIs for App Store Server Notifications.
        First, I'll go over the new App Transaction API for verifying the purchase of your app.
        Next, I'll dig into some new properties we've added to our StoreKit models.
        I'll introduce you to the new SwiftUI friendly APIs for redeeming subscription offer codes and asking a customer to review your app.
        Then, I'll introduce you to StoreKit Messages, an API used to display App Store messages to your customers.
        And finally, I'll go over an enhancement we're adding to preserve Application Username when you're migrating from the original to the modern StoreKit APIs.
        Throughout this presentation, I'll be using my favorite app, Food Truck.
        In the Food Truck app, I manage a pop-up donut food truck that visits various cities to make donut deliveries.
        So, let's get started! Meet App Transaction.
        The App Transaction is our new API for verifying the purchase of your app.
        The App Transaction represents the signed information for the purchase of your app for the device it's running on.
        It's signed using JWS, and it replaces the app detail portion of the app receipt from the original StoreKit API.
        Just like transaction verification, StoreKit performs automatic verification of the app transaction for you.
        However, if you wish, you can also perform your own validation.
        Validating a JWS signature is a well-documented standard.
        You can refer to the public documentation to implement your own validation.
        StoreKit takes care of automatically updating the App Transaction when necessary.
        However, in the rare case that the user thinks there's something wrong, it can be refreshed.
        You should provide UI in your app to allow your customers to refresh the app transaction.
        This should only be used in response to user action, as refreshing the App Transaction prompts the user to authenticate.
        Preventing fraud isn't the only reason to love App Transaction.
        If you're looking to switch business models from a paid app to a free app that offers in-app purchases, if you're curious about which of your customers preordered your app, or even if you just want to know when your app was purchased, these are all situations you can handle with App Transaction.
        In the app receipt, the receipt payload combine the purchase data about your application along with all the in-app purchases that have occurred.
        These are now broken up into two separate components in StoreKit.
        The first of these is the Transaction History.
        StoreKit's transaction APIs give you insight into the user's entire in-app purchase history, right on the device.
        These APIs allow you to find the exact information you need, including the user's latest transactions, unfinished transactions, and current entitlements.
        If you prefer to perform these calculations on your server, you can also get the user's purchase history from the App Store Server API.
        Ian will have some exciting updates on this later this session.
        And the second component is the App Transaction, which contains the data you need to make sure that your app is valid for the device it's running on.
        It's easy to verify the purchase of your app using App Transaction, and in just a moment, I'll be going over an example of how you can use it.
        But first, let me give you some background about my favorite app.
        With Food Truck, I'm able to make donut deliveries, check in on a basic social feed, and visualize my sales history.
        Keeping all this information in a database is an ongoing cost for my app, so to help me cover the costs, I'm going to turn the yearly sales history chart into a onetime purchase.
        Additionally, I want to enhance the social feed.
        So instead of just seeing what others are saying about my food truck, I want to provide the tools so I can engage with my customers as well.
        This will be a subscription service, and I'll have a monthly and a yearly plan.
        Food Truck began as a paid app, but I'm going to make the switch to a free app that offers in-app purchases.
        But I don't want my existing customers who already purchased Food Truck to feel left out.
        So, I'll be using the App Transaction to make sure that the customers who purchased Food Truck continue to have access to the premium content they paid for.
        Here's the timeline for Food Truck.
        At the initial release, Food Truck started out as a paid app that cost $4.99.
        Version 1.0 offered donut deliveries, a basic social feed, and sales history charts.
        Later, at the release of version 8.0, my business model changed.
        Food Truck is now free, but includes a variety of in-app purchases which unlock premium features.
        The yearly sales history chart is now a nonconsumable onetime purchase, and now there's a new subscription service for a premium social feed that gives you advanced engagement tools.
        Now let's take a look at two different types of customers who might be affected by this.
        Alice found out about my Food Truck app in version 2.
        5, and she decided she wants to share her passion for donuts in the digital world.
        So, she purchased my app for $4.
        99 and began her donut delivery journey.
        A second customer, Bob, finds out about my Food Truck app though a friend and downloads it for free in the App Store in version 8.2.
        In this scenario, Alice, who purchased my app before it became free, should still have access to all the premium content she already paid for.
        She still has the option to purchase the premium social feed subscription, but I don't want to deny her the yearly sales history chart that was initially included.
        Bob, however, got my app for free.
        I know then not to unlock features and content until they complete the in-app purchase.
        So, let's see how we can achieve this with App Transaction in code.
        I'll start off by fetching the app transaction by calling AppTransaction.
        shared.
        This call gets me a VerificationResult containing my app transaction.
        Within the result, the AppTransaction type contains the JWS payload.
        Next, I'll switch on the result.
        If the result is unverified, this would be a good time to alert the user that their app purchase could not be verified by the App Store, and then, I can prompt them to refresh the app transaction.
        At this time, I'll offer a minimal experience for my app.
        If the result is verified, I'm going to use this as an opportunity to check whether the user has purchased my app.
        Customers that purchased my app should be granted the services they paid for.
        For this, I'll use the original app version property.
        This property lets me know the app version in which the customer had downloaded my app for the very first time.
        Version 8.0 is the version in which my app became free with in-app purchases.
        I'm going to pass the customer's original app version to my function which checks if the user purchased my app before version 8.0.
        And with that, I can make an informed decision about how I should go about providing premium content to my users.
        For customers like Alice, who purchased my app, I'm going to provide the content the user is entitled to that they had at the time of purchase.
        In my case, I'm going to unlock the yearly sales history chart for her deliveries.
        Also, I want to check any additional in-app purchases they may have made so I can provide that as well.
        Otherwise, I can be confident that the user downloaded my app after I switched my business model, like Bob.
        This can be a good time to check the user's current entitlements so I can unlock the features and content they paid for.
        And with just a few lines of code, I was able to verify the purchase of my app, check whether the user downloaded the paid version of my app, and I can immediately start providing my premium content, whether the customer purchased my app or not.
        With App Transaction, you can easily support your customers whether they're early supporters or if they've just recently downloaded your app.
        Now I'd like to move on to the new properties we're adding to our StoreKit models.
        The first of these properties is the price locale.
        The price locale is now included in StoreKit products.
        You may already be familiar with price locale from interfacing with our original purchase APIs.
        Next, I'll dig into the server environment property.
        Now, you can tell the server environment a transaction or renewal info occurred in.
        Then, I'll move onto the recent subscription start date property.
        You can use this as a tool to make informed decisions for your customers based on their subscription patterns.
        And lastly, I'll go over some special considerations for these properties when you're using them with StoreKit Testing in Xcode.
        These properties return sentinel values in older operating systems, and I'll explain what this means in just a bit.
        The StoreKit APIs were designed with flexibility in mind, so I'm proud to announce that you can take advantage of these new properties on devices as far back as last year's operating systems, even though they did not originally ship with them.
        All you'll need to make this happen is to use Xcode 14 to build your app, and you'll have access to these properties in the previous operating systems.
        This is possible because the implementation for these properties are compiled into your app, so when your customers update to the new version, they'll be able to get the benefits of these enhancements without needing to update their operating system.
        There is one thing to keep in mind when using these properties, though.
        These properties will return sentinel values when you're using StoreKit testing in Xcode in these older operating systems.
        When I say sentinel values, I'm referring to placeholder values that signal that these are not real values you should work with, and I'll explain why this occurs.
        The sandbox and production environments make use of these properties by extracting the values from the App Store server response.
        StoreKit testing in Xcode, however, is a local testing environment that operates independently from the App Store server.
        This means we're not able to backport the value of these properties to the previous operating systems there.
        You can easily get around this limitation by updating your test device to a new operating system, and you'll be all set to test these values in the local environment.
        Let's discuss some situations that demonstrate how you can start using these new properties, the first of which is price locale.
        StoreKit products already have a display price property to label the purchase price, but with price locale, you can format numbers deriving from the product's decimal price.
        If you have a yearly subscription, you might use this as an opportunity to show your customers how much it would cost them per month.
        In this example, you can see that the yearly subscription amounts to $4.
        17 per month.
        Or perhaps you'd want to show them how much they would save if they purchased your yearly service over your monthly service.
        With this information, your customers can make informed decisions when they're considering your purchase options.
        Now, let's move on to the environment property.
        The environment property is available in the Transaction and renewal Info.
        This property tells you the server environment in which the transaction or renewal info originated in, which could be Xcode, sandbox, or production.
        Your app may communicate transaction information to your server after a customer makes a purchase for bookkeeping and analytics.
        When your app generates these transactions, it could be from any one of these server environments.
        Like most of you, I don't want to add noise to my analytics with irrelevant test data.
        So, knowing the environment can help you filter out unnecessary information from being sent up to your server.
        Finally, let's take a look at the recent subscription start date.
        The recent subscription start date is available within a product's subscription information, and it represents the most recent period of continuous subscription.
        A subscription is considered continuous if there is no more than a 60-day gap between any two subscribed periods.
        Keep in mind that this period can contain gaps where the customer was not subscribed to your product, so don't use this as an indicator for the number of days a customer has been subscribed.
        The recent subscription start date can help you determine a pattern of loyalty between you and your customers.
        For your loyal customers, you might offer them a reward as a way to keep them engaged with your product.
        Or if you notice that a customer has unsubscribed from your service, you can use it as a chance to win back a lapsed customer by offering them an incentive to start using your product again.
        I mentioned earlier that we'd take a closer look at the sentinel values for these properties.
        As a reminder, when I say sentinel values, I'm referring to placeholder values that serve as an indicator of the absence of a real value.
        The sentinel values for these properties are easy to identify.
        When you're dealing with price locale, the sentinel value is a locale with the identifier xx_XX.
        For the environment property, it'll be an empty string.
        And finally, for the recent subscription start date, this value is Date.
        distantPast.
        Luckily, the occurrence of these sentinel values are predictable -- you'll only encounter them if you're using StoreKit testing in Xcode in older operating systems, and you can get around this by updating your test device.
        So now you've seen the enhancements we've made to our StoreKit models.
        And my favorite part is, they're backward compatible all the way back to the operating system in which the models were introduced, so your customers can see the benefits right away just by updating your app.
        When you perform arithmetic with price values, the price locale helps you correctly format it so that it matches the App Store's locale.
        For transactions and subscription information, the environment tells you exactly where they originated from, so if you store this data on your server, you can act on it accordingly depending on the environment.
        The recent subscription start date helps you understand customer loyalty, so you can tailor specific offers to long-time customers, or maybe you can provide an incentive for customers who have unsubscribed.
        And in case you were wondering, yes, the environment and recent subscription start date are also available via App Store Server API and App Store Server Notifications, which Ian will discuss.
        Now I'd like talk about the new SwiftUI APIs we're providing for redeeming offer codes and requesting a review.
        Offer codes can help you acquire, retain, and win back subscribers by providing subscriptions at a discount or free for a limited time.
        Now in App Store Connect, you can create uniquely named custom codes.
        There, you can set a maximum redemption limit and you can choose whether or not to set an expiration.
        Let's look at the SwiftUI implementation to present an offer code redemption sheet straight from your app.
        Here, I've got a SwiftUI view with a button to trigger the offer code redeem sheet.
        The offer code redemption sheet now has its own view modifier in SwiftUI.
        The view modifier is easy to use, it just needs a binding Boolean to start the process.
        And once the offer code sheet is dismissed, you'll get a result representing whether or not the sheet presented successfully.
        When a customer redeems an offer code for your app, the resulting transaction is sent to the transaction listener.
        So, be sure to set up a transaction listener as soon as your app launches to receive new and updated transactions while your app is running.
        The offer code view modifier is available starting on iOS 16.
        Next, I'd like to talk about updates to request review.
        Getting customer feedback is important.
        Potential new customers might use reviews as a deciding factor in their decision to download your app.
        Others might want to leave a review as a way to provide feedback or suggestions.
        Either way, we want to give you the tools to make it easy for you to request a rating from your customers, so you can let them know you're listening and you can continue engaging with them.
        Let's review the code.
        Here I have a very simple view to demonstrate the Request Review APIs.
        In SwiftUI, there's now an environment value called requestReview.
        You can use this value to get an instance of the RequestReviewAction, and when you're ready to request a rating, simply call the instance as a function to request to display the review prompt.
        You can decide the right time to request a review for your app.
        However, you should be aware that the prompt will only be displayed to customers a maximum of three times within a 365-day period.
        And you shouldn't ask customers to review the same version of your app multiple times.
        Avoid interrupting customers with a review prompt.
        A good time to ask for a review could be after they've had a positive interaction, such as completing a purchase on an e-commerce app, or completing a level in a game.
        Finally, customers can disable requests from ever appearing on their device, so you shouldn't request a review as a result of a user action.
        These APIs are really going to come in handy for your SwiftUI apps.
        Next, I'd like to introduce you to our new API for StoreKit messages.
        A StoreKit message represents a sheet that appears over your app to display important information to the user.
        Messages are vended by the App Store.
        Each message has a reason, which is included in the message metadata.
        StoreKit messages are retrieved when your app comes to the foreground.
        As an example, let's take a look at one of the message reasons -- price increase consent.
        When you increase the price of a subscription and it requires user consent, the App Store will inform affected subscribers through email, push notification, and an in-app price consent sheet.
        In this case, the App Store requires that the user agrees to the new price of your subscription before it renews at the higher price.
        So, if you decide to charge more for your subscription, a price increase consent sheet may appear when a user opens your app if they haven't already responded to your price increase.
        By default, StoreKit messages appear over your app when the user brings your app to the foreground, and it may ask the user to take some action relating to your app.
        Let's review this.
        The entire process starts with your app.
        When your app enters the foreground, StoreKit knows to check if there's pending messages to display.
        And if there are, StoreKit checks in with the App Store.
        The App Store returns information about the message to StoreKit.
        At this time, StoreKit checks whether your app is set up to receive messages.
        You can do this by setting up a message listener in your app, which I'll get into shortly.
        If your app has set up a message listener, StoreKit sends information about the message to your app.
        Now's your chance to decide whether or not it's a good time for your app to display the message, or if you want to defer the presentation for later.
        If you don't set up a message listener, StoreKit displays the message right away by presenting the message sheet over your app.
        I'll go over how to do this in code.
        But before I do that, I'll explain a situation in which it would be useful to control the presentation of an App Store message.
        In the Food Truck app, I'm able to customize the donuts I'm delivering to different cities.
        If a message gets delivered to my app during this time, it would be confusing to the user if they're suddenly interrupted by a message sheet, so I'm going to be implementing the messages API to make sure this doesn't happen by controlling when incoming messages are presented.
        Now let's get into the code.
        Here, I have a simple view for the donut editor.
        As I mentioned earlier, pending messages are sent each time your app comes to the foreground.
        So, I want to set up a message listener in each view in which I want to defer the presentation of a message.
        I'll add a binding array to collect all the messages that are delivered to my app while I'm in the editing view.
        This is important, because if I don't set up a message listener, StoreKit is going to display the message sheet right away when my app comes to the foreground.
        As soon as the view appears, I set up my message listener.
        I'll do this by setting up a task that iterates over a static property on the message type.
        This property is an async sequence, and I'm able to receive messages as they come in.
        For my use case, I'm going to save the message in the pendingMessages array.
        Since pending messages get delivered each time your app enters the foreground, your app could receive the same message more than once, so I have this condition to avoid adding duplicate messages to my array.
        Then, once the view dismisses, I'll display the messages in the parent view.
        This is the parent view which holds a navigation link to the donut editor.
        Here, I've collected all the pending messages I need to display in this pendingMessages array.
        So how do I display these pending messages? Well, now there's an environment value displayStoreKitMessage.
        This gets you an instance of a DisplayMessageAction, which you can then use to display a given message.
        When the view appears, I'll iterate through the pending messages and call displayStoreKitMessage passing in the message I want to display.
        StoreKit takes care of presenting the message sheet.
        Earlier, I mentioned that the same message may get delivered to your app more than once.
        That's because a message doesn't get marked as read until it's presented to the user.
        So, StoreKit makes sure that each unique message is only presented once.
        And that was a quick implementation of the Messages API.
        Remember, StoreKit messages are sent to your app each time it comes to the foreground, so you'll want to set up a message listener in each view in which you want to control the timing of when the messages are presented.
        You can ensure customers have a great experience by making sure message sheets don't appear at unexpected moments.
        Or perhaps you want to tailor your logic for certain messages types.
        With a price increase consent message, you may want to educate your customer about the additional value you're providing before the price increase consent sheet appears.
        Finally, let's review how StoreKit preserves the applicationUsername as an appAccountToken after a user makes a purchase.
        If you have a user account system on your server, chances are you're already making use of the applicationUsername property.
        The applicationUsername is a string that you create to associate a transaction with a user account on your service.
        In the original API for in-app purchase, you set the applicationUsername value when you add a payment to the payment queue.
        Although the applicationUsername accepts any string, we recommend that you provide the string representation of a UUID.
        When you provide it a UUID string, StoreKit persists the value and you'll see it in the transaction that the queue updates.
        If you don't provide a UUID string for the applicationUsername, StoreKit may not persist it.
        There's no guarantee the value will persist between the time you add the payment transaction to the queue and when the queue updates the transaction.
        When you provide the string representation of a UUID, you can identify which of your app's user accounts began and completed a transaction.
        In the modern StoreKit APIs, we implement this concept as a purchase option called appAccountToken and it requires a UUID format.
        Now, when you set the applicationUsername to a UUID string during payment, the App Store server stores it as an appAccountToken.
        So you'll see its UUID appear in the signed transaction info returned by the App Store Server API and in V2 App Store Server Notifications.
        And as a UUID, it's compatible with the appAccountToken in the modern StoreKit transaction APIs.
        So, now you can be sure that when you update your codebase to the modern StoreKit APIs, the UUID you used for the applicationUsername is preserved as an appAccountToken in the StoreKit transactions.
        We touched on a lot of things today.
        Before moving on to the server updates, let's review this year's StoreKit updates.
        We discussed validating your app's purchase with App Transaction, redeeming an offer code and requesting a review in SwiftUI, and controlling the presentation of StoreKit messages.
        We talked about new price locale, environment, and recent subscription start date properties.
        And, we went over the importance of using a string representation of a UUID for the applicationUsername to persist it as an app account token.
        I highly recommend you check out our other session "What's new in StoreKit testing."
         And if you need a refresher on the StoreKit 2 APIs, check out last year's session "Meet StoreKit 2."
         Now I'd like to hand it over to Ian to walk you through the updates to the App Store server.
        Ian Zanger: Thanks, Dani.
        Hi, everyone.
         My name is Ian, and I'm an engineer on the App Store Server team.
        Now that you've heard the latest about in-app purchase with StoreKit, I'm going to switch gears and talk about the server.
        First, I'll review some recent developments from the past year before moving on to some exciting new updates coming to the App Store Server API and App Store Server Notifications Version 2.
        Let's get started.
        Last year was big.
        We brought you an entirely new suite of endpoints with the App Store Server API and App Store Server Notifications V2, including full sandbox testing support for all these new features.
        We shared how you can use the Get Transaction History endpoint to get the full history of a user's in-app purchases, or the Get All Subscription Statuses endpoint to stay up to date with the current state of a user's subscriptions.
        Both of these endpoints conveniently key off of a user's originalTransactionId, so you can access this trove of data by storing just this one simple value.
        We also covered how version 2 of App Store Server Notifications can simplify event processing on your server and complement the App Store Server API.
        With V2 notifications, the App Store server calls your server directly, providing in-app purchase updates as they happen.
        The streamlined notification type and subtype make it easy to understand what's happening.
        You can use these to track changes related to in-app subscriptions and other events.
        With all of these data sources, we wanted to make that data as easy as possible to parse.
        Receipts are now a thing of the past, as these new services provide in-app data in signed JSON format, so you can easily parse it and trust that it came from the App Store server.
        Last year was a big year for the App Store server.
        It may have been big for you as well if you worked to update your server code to leverage all these new features.
        Rest assured that effort will continue to pay off as we bring powerful new enhancements and features to App Store Server API and App Store Server Notifications V2.
        That's our year in review, but if you'd like more of a refresher after hearing this year's updates, be sure to check out the WWDC21 sessions titled "Manage in-app purchases on your server," "Meet StoreKit 2," and "Support customers and handle refunds."
         Now let's move on to brand-new updates coming to the App Store server for WWDC22.
        First I'll share some updates to transaction and renewal info fields.
        Next I'll tell you about new enhancements to the App Store Server API.
        And finally, I'll share exciting new features coming to App Store Server Notifications V2.
        Now let's dive in with the first of our new topics: new fields found in transaction and renewal info.
        Earlier, you heard from Dani about a couple new fields coming to the transaction and renewal info of in-app purchases.
        These fields, environment and recentSubscriptionStartDate, are also coming to the transaction and renewal info payloads you receive from the App Store Server API and in V2 App Store Server Notifications.
        Let's take a fresh look at the data you can expect to receive from the App Store server with these new fields included.
        First is the transaction info payload, which we can see here after decoding.
        Down at the bottom, you can see our new field: environment.
        You can use it to tell, at a glance, whether the transaction took place in the production or sandbox environment.
        Next is the renewal info payload, also seen here after decoding.
        As you can see, the environment field is also available here for your reference.
        Additionally, recentSubscriptionStartDate will now appear in every renewal info payload.
        This is the start date of the user's first subscription purchase in their most recent string of renewals, ignoring any gaps of 60 days or fewer.
        recentSubscriptionStartDate is an easy way to get an idea of a customer's loyalty at a glance.
        But if you'd like more detail, including the timing and length of any gaps in service, you can call the Get Transaction History endpoint and examine the full history of a user's subscription renewal purchases.
        Or for even more detail, with App Store Server Notifications V2, the App Store server automatically sends updates about user subscriptions to your server.
        These notifications give you maximum insight into the timing of events like renewal preference changes, offer redemptions, billing failures, and more.
        As you can see, recentSubscriptionStartDate rounds out a suite of options for determining customer loyalty.
        Use these tools to target offers and reward your most loyal customers.
        Now let's move on to some convenient new enhancements to the Get Transaction History endpoint.
        With the Get Transaction History endpoint, you can fetch the full history of a user's purchases in your app.
        The endpoint response is paginated so you can process this data in reasonable chunks.
        Each response contains a revision token that you provide in the next request in order to get the next page.
        And the pages are sorted by modified date, meaning each subsequent page contains transactions that are more recently modified.
        Let's take a look at how this works.
        You call the Get Transaction History endpoint, and provide an originalTransactionId.
        The App Store server will return up to 20 signed transactions for that user.
        It will also return an updated revision value that you will provide in your next page request for this user.
        You'll know there's more data available when the hasMore field in the response is true.
        Let's say in this case that there's another page of data available.
        You make another request to the endpoint, and you include that revision value from the first response.
        You receive the next page of data, including an updated revision value.
        hasMore is now false, so you know you're up to date with the latest transaction data.
        Except this time, you notice something about the final transaction in the response; you've seen it before! It was one of the original 20 you received in response to your first request.
        This means the transaction must have been modified, so it was put back at the top of the sort order.
        Now, you can examine the data of that transaction and take note of what's changed.
        In this instance, you notice the revocationDate and revocationReason fields are now populated, meaning the transaction was revoked.
        You can take action by revoking any content associated with the purchase.
        It's a good idea to store the revision value from this final response alongside the originalTransactionId you used to identify the user.
        The next time you call the endpoint for this user, you can provide that revision and know that you're getting back only fresh transaction data that has been modified since your last request.
        As you've seen, the Get Transaction History endpoint provides you a simple way to retrieve a comprehensive set of in-app purchase data.
        But maybe sometimes it can be a bit too comprehensive.
        Some users have lengthy purchase histories dating back several years.
        For these users, this endpoint could return hundreds of purchases of a variety of types.
        Even with pages, this can be a lot to handle.
        That's why this year, we're enhancing this endpoint with a variety of new sort and filter options.
        Now, you can tell us exactly the data you want from the start, saving processing time on your server and reducing the number of network calls needed to retrieve all available pages.
        You can sort by descending modified date if you're interested in seeing the most recently modified purchases on the first page of results.
        You can also filter by several useful fields such as product type, product ID, Family sharing status, and more.
        To apply these new sort and filter options, just append them as query parameters to your request to the Get Transaction History endpoint.
        Let's take a closer look at how that works.
        Here you can see all the new parameter options.
        These may look familiar, since most are taken directly from the transaction info payload.
        You can mix and match these parameters to get very specific results.
        For example, maybe we want to fetch only the nonconsumable purchases a user has made since the beginning of this year.
        We also want to exclude any revoked purchases.
        We will build our custom request by setting the productType to NON_CONSUMABLE and specifying the startDate as the beginning of this year represented in milliseconds.
        Finally, we'll set excludeRevoked to true.
        And that's our request! Since we did not specify a sort order, the response will default to sorting by ascending modified date.
        Now even with a request as specific as this, there could be multiple pages of purchases to retrieve.
        For follow-up requests, we should make sure to include the exact same query parameters, in addition to the revision from the previous response.
        For even more flexibility, three of the filter fields support multiple values, so you can filter to only those purchases that match at least one of the provided values.
        These fields are productType, productId, and subscriptionGroupIdentifier.
        To provide multiple values for these parameters, simply define them multiple times.
        Next let's move on to App Store Server Notification updates.
        With App Store Server Notifications V2, you can take your server to the next level.
        V2 notifications give detailed insights about in-app purchase events that you can't get anywhere else.
        These are especially useful for tracking the lifecycle of autorenewable subscriptions offered in your app.
        You can use these insights to retain customers, win back those that have churned, resolve customer support requests, and more.
        With all of these benefits, you might wonder how to get started.
        As with any new feature, the sandbox testing environment is the best place to start.
        That's why last year, we added the ability to set a separate server URL in App Store Connect for receiving App Store Server Notifications in sandbox.
        After registering your server URL, you'll want to confirm your server is receiving notifications from the App Store server.
        You might set up a sandbox account just to trigger a notification through a user action.
        For example, let's say you perform a first time buy of a subscription using that sandbox account.
        You should receive a V2 notification of type SUBSCRIBED and subtype INITIAL_BUY.
        But what if that notification doesn't come? You might wonder if there was an issue with your server or the steps you took to trigger a notification.
        This situation can generate a lot of uncertainty right as you're getting started.
        We want to simplify this experience and give you a way to easily verify that App Store Server Notifications can reach your server.
        That's why this year, we're introducing the new Request a Test Notification endpoint.
        By calling this simple endpoint, you can ask us to send a V2 Notification of type TEST to the server URL registered for your app in App Store Connect.
        The new TEST notification type is used exclusively for this endpoint.
        You can call the endpoint in sandbox or production to test your saved URL for either environment.
        Use this new endpoint to quickly test new server URLs and configurations.
        Let's see how this simplifies first-time setup.
        Now, if you're just looking to trigger your first notification, there's no need to set up a sandbox account or perform a purchase.
        Just call the new endpoint in whichever environment you want to test and you'll receive an HTTP 200 response confirming your request.
        The response will contain a new field, testNotificationToken, which identifies the test notification your server will receive.
        We will come back to this field later.
        Shortly afterward, your server should receive a V2 notification of type TEST at the URL saved in App Store Connect.
        Now let's see how to call this endpoint.
        Just send a simple POST request to this new path on the App Store server.
        You'll receive an HTTP 200 response and know that your request has been submitted.
        The response will contain that new field I mentioned, testNotificationToken.
        Take note of this for later.
        Soon you'll receive a signed TEST Notification.
        Here's what that notification will look like once it's decoded.
        You'll notice it contains all the usual top-level fields of a V2 notification, including the new notificationType, TEST.
        The contents of the data object are a bit shorter than a normal notification.
        Since this is just a test, there are no transaction-related data to include, so we omit transaction-specific fields, most notably the signedTransactionInfo.
        When calling the new Request a Test Notification endpoint, keep in mind that App Store Server Notifications are sent asynchronously.
        Your successful call to the endpoint will return an HTTP 200 but the actual test notification will arrive separately, a short while later.
        Given that this endpoint is all about testing your server configuration, you might be wondering what to do when that test fails.
        In other words, what if the test notification doesn't arrive? To further enhance your testing capabilities, we're releasing the Get Test Notification Status endpoint, which you will use in conjunction with the Request a Test Notification endpoint.
        With this new endpoint, you can check on the status of a previously requested TEST notification.
        The endpoint response will tell you if the App Store server was able to reach your server and successfully send the TEST notification.
        If the send failed, it will give you an idea of why, so you can better troubleshoot your server configuration.
        Let's check out how you'll use this endpoint.
        Send a GET request to this path on the App Store server.
        In the path, include the testNotificationToken you received from the Request a Test Notification endpoint.
        This will tell us which test notification you want to check the status of.
        Now for the response.
        The signedPayload field contains the TEST notification payload that the App Store server attempted to send to your server.
        And the firstSendAttemptResult field indicates the result of that send attempt.
        Here, SUCCESS indicates that the send was successful, meaning the App Store server received an HTTP 200 response from your server.
        If the send was unsuccessful, you'll instead see one of several different error values.
        These values indicate the error the App Store server experienced trying to reach your server with the test notification.
        With this information, you can troubleshoot your server issue, request new test notifications as needed, and get your server running reliably.
        Collectively, these test notification endpoints are simple to use and can save you a lot of trouble when setting up or reconfiguring your server to receive V2 App Store Server Notifications.
        Now with the help of these endpoints, you can set up your server and confirm it's running smoothly.
        But servers aren't perfect and outages happen.
        How do you recover when your server goes down, leading you to miss App Store Server Notifications? The current solution to this is a retry system.
        When the App Store server fails to reach your server, it initiates a retry process.
        It will retry sending the same notification up to five times, with a longer wait between each attempt.
        These retries take place only in the production environment.
        Retries help you eventually recover from an outage, but they're not perfect for every situation.
        For example, some outages can be extensive.
        If your server is down long enough to miss the final retry attempt from the App Store server, that notification is lost.
        Or more commonly, your server could experience a very brief issue, during which it misses only a handful of notifications.
        But missing even a single notification means some of your customer records are out of date for at least an hour.
        Yet you don't know which ones! Clearly, server outages are stressful, and recovering from them can be a complex task.
        That's why we want to make it as easy as possible to recover missed App Store Server Notifications, so you can get your server back on track as soon as possible.
        That's why this year, we are introducing the new Get Notification History endpoint.
        With this endpoint, you can fetch the history of V2 App Store Server Notifications generated for your app.
        Whether your server successfully received a notification or not, that notification will appear in the response of this endpoint.
        When calling this endpoint, you'll specify a date range of notifications to fetch.
        With WWDC, we have started recording this data, and we will build up to the cap of the latest six months of rolling history being available.
        You can optionally filter your request by type and subtype, or fetch just a single user's notifications by providing an originalTransactionId.
        And the existing retry system is still available, so you can use it in tandem with this new endpoint.
        Let's take a look at how you'll call this endpoint.
        You'll send a POST request to this new path on the App Store server.
        In the request body, you'll include a startDate and endDate.
        The response will contain only notifications we first attempted to send in this window.
        Keep in mind that the earliest notifications available will be those sent six months before the date of your request.
        Optionally, you can specify a notificationType and notificationSubtype.
        If you do, the history will be filtered to only notifications that match both of these values.
        Keep in mind that some notifications have no subtype.
        Alternatively, you can provide an originalTransactionId of a user, to fetch the notification history of only that user.
        Finally, you should provide a paginationToken as a query parameter for every follow-up request in order to get the next page.
        Make sure you use the same request body for follow-up requests, changing only this paginationToken.
        Now let's take a look at the response.
        The notificationHistory array contains up to 20 notifications, with the oldest notifications first.
        Each entry in this array represents a notification and inside you'll find the signedPayload, which you can decode as usual to view the transaction data.
        The data within is identical to the payload the App Store server sent in the original notification.
        You'll see that we've also brought the new firstSendAttemptResult field to this endpoint response.
        You can use this field to look for sequences of timeouts and other errors to better understand why your server missed notifications in the past.
        The response also contains a paginationToken if there are more pages to retrieve.
        You should provide this in your next request in order to get the next page of notifications.
        You'll know there are more pages to retrieve as long as the hasMore field is true.
        And that's everything you need to know about this useful new endpoint.
        That concludes our App Store server updates for today.
        Every server feature announced today is available now in both sandbox and production.
        We hope you'll take advantage of these new features to make your server the best it can be.
        For more great content on using a server with in-app purchase, including how to use the latest features while supporting legacy clients, I encourage you to check out another session at WWDC22, "Explore in-app purchase integration and migration."
         Both: Thanks for joining us at WWDC22!

        """
    }

    var japanese: String {
        """
        ダニ・チュウトン こんにちは、「アプリ内課金の新情報」へようこそ。
        I StoreKitチームのエンジニアのダニです。
        今日は同僚のイアンと一緒に、今年のアプリ内課金に関する新しい改善について説明します。
        昨年、私たちはStoreKit 2を発表しました。これは、アプリ内課金を簡単に統合できるようにゼロから設計された新しいAPIセットです。
        StoreKit 2は、async/awaitパターンを使用したSwiftの並行処理など、最新の言語機能を使用しています。
        サーバー側では、これらの新しいStoreKitの機能を、まったく新しいApp Store Serverエンドポイントのセットで補完しています。
        これらのサーバーエンドポイントにより、サーバー上でトランザクション情報を取得したり、サブスクリプションのステータスを確認したりすることが容易になります。
        また、App Store Server Notifications のバージョン 2 もリリースし、サーバー上のサブスクリプションのライフサイクルをこれまで以上に簡単に追跡できるようになりました。
        今日は、これらの新しいAPIと、新しいStoreKitモデルにもたらされる強化点について説明します。
        それから、Ian が、App Store Server API の強化や App Store Server Notification のための新しい API など、エキサイティングな新しいサーバーのアップデートを説明します。
        まず、アプリの購入を確認するための新しい App Transaction API について説明します。
        次に、StoreKit モデルに追加された新しいプロパティについて説明します。
        サブスクリプション・オファーコードを利用したり、顧客にアプリのレビューを依頼するための、新しい SwiftUI フレンドリーな API を紹介します。
        それから、顧客に App Store のメッセージを表示するために使用される API である StoreKit Messages を紹介します。
        そして最後に、オリジナルの StoreKit API から最新の StoreKit API に移行する際に、アプリケーション名を保持するために追加された機能強化について説明します。
        このプレゼンテーションでは、私のお気に入りのアプリである Food Truck を使用します。
        Food Truckアプリで、私は様々な都市を訪問してドーナツの配達をするポップアップドーナツ屋台を管理しています。
        では、さっそく始めましょう App Transactionの紹介です。
        App Transactionは、アプリの購入を確認するための私たちの新しいAPIです。
        App Transactionは、あなたのアプリが実行されているデバイスの購入に関する署名された情報を表します。
        これはJWSを使用して署名され、オリジナルのStoreKit APIにあったアプリの領収書のアプリ詳細部分を置き換えるものです。
        トランザクションの検証と同様に、StoreKitはあなたに代わってアプリトランザクションの自動検証を実行します。
        しかし、希望すれば、独自に検証を行うことも可能です。
        JWS署名の検証は、十分に文書化された規格です。
        公開されているドキュメントを参照して、独自の検証を実装することができます。
        StoreKitは、必要に応じてApp Transactionを自動的に更新するように配慮しています。
        しかし、稀にユーザーが何かおかしいと思った場合は、リフレッシュすることができます。
        顧客がアプリトランザクションをリフレッシュできるように、アプリ内にUIを用意する必要があります。
        アプリ取引を更新するとユーザーに認証が求められるため、これはユーザーのアクションに対応する場合にのみ使用する必要があります。
        App Transactionの魅力は、不正行為の防止だけではありません。
        有料アプリからアプリ内課金のある無料アプリにビジネスモデルを変更したい場合、どの顧客がアプリを予約したか気になる場合、あるいはアプリがいつ購入されたかを知りたい場合、これらはすべてApp Transactionで対応可能です。
        アプリのレシートでは、レシートのペイロードに、アプリケーションに関する購入データと、発生したすべてのアプリ内課金が結合されています。
        これらは、StoreKitでは2つの別々のコンポーネントに分割されました。
        その1つ目は、「トランザクション履歴」です。
        StoreKit のトランザクション API を使用すると、ユーザーのアプリ内購入履歴全体を、デバイス上で把握することができます。
        これらのAPIにより、ユーザーの最新のトランザクション、未完了のトランザクション、現在のエンタイトルメントなど、必要な情報を正確に見つけることができます。
        これらの計算をサーバー上で行いたい場合は、App Store Server APIからユーザーの購入履歴を取得することも可能です。
        このセッションの後半で、Ianがこれに関するエキサイティングなアップデートを行う予定です。
        そして2つ目のコンポーネントはApp Transactionで、アプリが実行されているデバイスに対して有効であることを確認するために必要なデータが含まれています。
        App Transactionを使えば、アプリの購入を簡単に確認することができます。
        その前に、私が愛用しているアプリの背景を少し説明します。
        Food Truckでは、ドーナツの配達、基本的なソーシャルフィードでのチェックイン、販売履歴の可視化などを行うことができます。
        これらの情報をデータベース化することは、アプリの継続的なコストになるので、そのコストをカバーするために、年間の売上履歴のグラフを1回限りの購入にしようと思っているんだ。
        さらに、ソーシャルフィードも充実させたいと考えています。
        他の人が自分の屋台について言っていることを見るだけでなく、お客さんとの交流もできるようなツールを提供したいです。
        これはサブスクリプション・サービスで、月額プランと年間プランを用意する予定です。
        Food Truckは有料アプリとして始まりましたが、アプリ内課金を提供する無料アプリに切り替えるつもりです。
        しかし、すでにFood Truckを購入した既存のお客さまには、取り残されたような気持ちになってほしくありません。
        そこで、App Transactionを利用して、Food Truckを購入したお客さまが、支払ったプレミアムコンテンツに引き続きアクセスできるようにするつもりです。
        ここで、Food Truckの時系列を説明します。
        最初のリリース時、Food Truckは4.99ドルの有料アプリとしてスタートしました。
        バージョン1.0では、ドーナツの配達、基本的なソーシャルフィード、売上履歴のチャートなどが提供されました。
        その後、バージョン8.0のリリース時に、私のビジネスモデルは変わりました。
        Food Truckは無料になりましたが、プレミアム機能をアンロックするさまざまなアプリ内課金が含まれています。
        1年間の販売履歴グラフは、消費しない1回限りの購入となり、高度なエンゲージメントツールを提供するプレミアムソーシャルフィードの新しいサブスクリプションサービスがあります。
        では、この影響を受ける可能性のある2種類のお客様について見てみましょう。
        アリスは、バージョン2.5で私のFood Truckアプリを知りました。
        5で私のフードトラックアプリを知ったアリスは、ドーナツへの情熱をデジタルの世界で共有したいと思い立ちました。
        そこで、彼女は私のアプリを4.99ドルで購入し、ドーナツ配達の旅を始めました。
        99ドルで購入し、ドーナツ配達の旅に出ました。
        2番目の顧客であるボブは、友人を通じて私のFood Truckアプリを知り、App Storeでバージョン8.2のアプリを無料でダウンロードしました。
        このシナリオでは、無料になる前に私のアプリを購入したアリスは、すでに支払ったすべてのプレミアムコンテンツにまだアクセスできるはずです。
        彼女はまだプレミアムソーシャルフィード購読を購入するオプションを持っていますが、私は当初含まれていた年間販売履歴チャートを否定したくありません。
        しかし、ボブは私のアプリを無料で手に入れました。
        私は、彼らがアプリ内課金を完了するまで、機能やコンテンツをアンロックしないことを承知しています。
        では、App Transactionでどのようにこれを実現するか、コードで見てみましょう。
        まず、AppTransactionを呼び出してアプリのトランザクションを取得するところから始めます。
        を共有します。
        この呼び出しによって、アプリのトランザクションを含むVerificationResultが取得されます。
        この結果には、AppTransactionタイプにJWSペイロードが含まれています。
        次に、result を切り替えてみます。
        結果が未検証の場合、アプリの購入がApp Storeで確認できなかったことをユーザーに警告し、アプリのトランザクションを更新するよう促すのに良い機会です。
        このとき、私は自分のアプリに最小限のエクスペリエンスを提供します。
        結果が検証されたら、これを機に、ユーザーが私のアプリを購入したかどうかを確認します。
        アプリを購入したお客さまには、支払った分のサービスを提供する必要があります。
        そのために、オリジナルアプリのバージョンプロパティを使います。
        このプロパティは、お客様が初めて私のアプリをダウンロードしたときのアプリのバージョンを知ることができます。
        バージョン8.0は、私のアプリがアプリ内課金で無料になったときのバージョンです。
        この関数では、ユーザーがバージョン8.0より前にアプリを購入したかどうかをチェックするため、顧客の元のアプリのバージョンを渡そうと思います。
        これによって、ユーザーにプレミアムコンテンツを提供する方法について、十分な情報を得た上で決定することができます。
        アリスのように、私のアプリを購入したユーザーには、購入時に持っていたコンテンツを提供するつもりです。
        私の場合、彼女の配信する年間販売履歴チャートをアンロックします。
        また、アプリ内で追加購入されたものも確認したいので、それも提供します。
        そうでなければ、ボブのようにビジネスモデルを切り替えた後にアプリをダウンロードしたユーザーだと確信できます。
        これは、ユーザーの現在の権利を確認する良い機会であり、彼らが支払った機能やコンテンツのロックを解除することができます。
        そして、ほんの数行のコードで、私のアプリの購入を確認し、ユーザーが私のアプリの有料版をダウンロードしたかどうかをチェックし、顧客が私のアプリを購入したかどうかにかかわらず、私のプレミアムコンテンツの提供をすぐに開始することができました。
        このように、App Transactionを利用することで、初期のサポーターであっても、最近アプリをダウンロードしたばかりのユーザーであっても、簡単にサポートすることができるのです。
        次に、StoreKitのモデルに追加された新しいプロパティについて説明します。
        このプロパティの1つ目は、価格ロケールです。
        StoreKitの商品には、価格ロケールが含まれるようになりました。
        価格ロケールについては、弊社オリジナルの購入APIと連動しているので、すでにご存知の方も多いかもしれません。
        次に、サーバー環境のプロパティを掘り下げます。
        これで、トランザクションや更新情報が発生したサーバー環境を伝えることができるようになりました。
        次に、最近のサブスクリプション開始日プロパティに進みます。
        これは、顧客の購読パターンに基づいて、情報に基づいた意思決定を行うためのツールとして使用することができます。
        そして最後に、XcodeのStoreKit Testingでこれらのプロパティを使用する際の、特別な考慮事項について説明します。
        これらのプロパティは、古いOSではセンチネル値を返しますが、これが何を意味するのか、少し説明します。
        StoreKit APIは柔軟性を念頭に置いて設計されているので、元々同梱されていないにもかかわらず、昨年のOSまでさかのぼったデバイスでこれらの新しいプロパティを利用できることを発表できることを誇りに思っています。
        これを実現するために必要なのは、Xcode 14を使用してアプリをビルドすることだけで、以前のオペレーティングシステムでこれらのプロパティにアクセスできるようになります。
        これは、これらのプロパティの実装がアプリにコンパイルされているためで、顧客が新しいバージョンにアップデートしたときに、オペレーティングシステムをアップデートする必要なく、これらの拡張機能の利点を得ることができるようになります。
        ただし、これらのプロパティを使用する際には、1つだけ注意すべき点があります。
        これらのプロパティは、これらの古いオペレーティングシステムでXcodeのStoreKitテストを使用している場合、センチネル値を返します。
        センチネル値というのは、「これは本当の値ではない」ということを示すプレースホルダー値のことで、なぜこのようなことが起こるのかを説明します。
        サンドボックスと本番環境では、App Storeサーバーの応答から値を抽出することで、これらのプロパティを利用します。
        しかし、XcodeでのStoreKitのテストは、App Storeサーバとは独立して動作するローカルなテスト環境となります。
        つまり、そこではこれらのプロパティの値を以前のオペレーティングシステムにバックポートすることができないのです。
        テストデバイスを新しいオペレーティングシステムに更新すれば、ローカル環境でこれらの値をテストする準備がすべて整いますので、この制限を簡単に回避することができます。
        これらの新しいプロパティをどのように使い始めることができるかを示すいくつかの状況について説明しましょう、その第一は価格ロケールです。
        StoreKitの商品には、購入価格を表示するためのdisplay priceプロパティがすでにありますが、price localeを使用すると、商品の10進数価格に由来する数値をフォーマットすることができます。
        年間契約をしている場合、顧客に月々いくらかかるかを示す機会として使うことができます。
        この例では、年間契約は4.17ドルであることがわかります。
        1ヶ月あたり17ドルです。
        あるいは、年額プランを購入した場合、月額プランよりいくらお得になるかを示すこともできます。
        このような情報があれば、お客様は購入オプションを検討する際に、十分な情報を得た上で意思決定をすることができます。
        さて、次にenvironmentプロパティを説明します。
        環境プロパティは、「取引情報」と「更新情報」で利用できます。
        このプロパティは、トランザクションまたは更新情報が発信されたサーバー環境（Xcode、サンドボックス、または本番環境）を知らせます。
        アプリは、簿記や分析のために顧客が購入した後、サーバーにトランザクション情報を通信することがあります。
        アプリがこれらのトランザクションを生成するとき、これらのサーバー環境のいずれかから生成される可能性があります。
        皆さんの多くがそうであるように、私も無関係なテストデータで分析にノイズを加えたくありません。
        ですから、環境を知ることで、サーバーに送られる不要な情報をフィルタリングすることができます。
        最後に、最近のサブスクリプションの開始日について見てみましょう。
        最近のサブスクリプション開始日は、製品のサブスクリプション情報内で利用可能であり、継続的なサブスクリプションの直近の期間を表します。
        2つの購読期間の間に60日以上の空白がない場合、購読は継続的であるとみなされます。
        この期間には、顧客が製品を購読していない空白期間が含まれる可能性があるため、これを顧客が購読している日数の指標として使用しないように注意してください。
        最近の購読開始日は、あなたとあなたの顧客の間のロイヤルティのパターンを決定するのに役立ちます。
        忠実な顧客には、製品への関与を維持する方法として、報酬を提供することができます。
        あるいは、お客様がサービスから退会したことに気づいたら、再び製品を使い始めるためのインセンティブを提供することで、退会したお客様を取り戻すチャンスとして利用することもできます。
        先ほど、これらのプロパティのセンチネル値について詳しく見ていこうと述べました。
        センチネル値とは、実際の値がない場合の指標となるプレースホルダー値のことです。
        このセンチネル値は、簡単に見分けることができる。
        価格ロケールを扱う場合、センチネル値は識別子xx_XXを持つロケールである。
        環境プロパティについては、空の文字列となります。
        そして最後に、最近の購読開始日についてですが、この値は Date.
        distantPast となります。
        幸いなことに、これらのセンチネル値の出現は予測可能です。XcodeでStoreKitのテストを古いOSで使用している場合にのみ遭遇しますし、テストデバイスを更新することでこれを回避することができます。
        ここまでで、私たちがStoreKitモデルに施した機能拡張をご覧いただきました。
        しかも、そのモデルが登場したOSまで遡って互換性があるので、アプリケーションをアップデートするだけで、すぐに効果を実感できます。
        価格の値で演算を行う場合、価格ロケールは、App Storeのロケールと一致するように、正しくフォーマットするのに役立ちます。
        トランザクションと購読情報については、その発信元が環境であることがわかるので、これらのデータをサーバーに保存しておけば、環境に応じて適切に対処できます。
        最近の購読開始日は、顧客の忠誠心を理解するのに役立ちます。そのため、長い間購読している顧客に特定のオファーを提供したり、購読を中止した顧客にインセンティブを提供したりすることができるかもしれません。
        この環境と最近の購読開始日は、App Store Server API と App Store Server Notifications でも利用可能です。
        さて、オファーコードの交換とレビューの要求のために私たちが提供している新しいSwiftUI APIについて話したいと思います。
        オファーコードは、割引または期間限定の無料購読を提供することで、購読者を獲得、維持、回復するのに役立ちます。
        App Store Connectで、ユニークな名前のカスタムコードを作成できるようになりました。
        そこで、交換の上限を設定し、有効期限を設定するかどうかを選択することができます。
        アプリから直接オファーコードの引き換えシートを表示するための SwiftUI の実装を見てみましょう。
        ここでは、オファーコード引き換えシートをトリガーするためのボタンを持つSwiftUIビューを用意しました。
        オファーコード引き換えシートは、SwiftUIで独自のビュー修飾子を持っています。
        ビューモディファイアは使いやすく、処理を開始するためにブール値をバインドする必要があるだけです。
        そして、いったんオファーコードシートが却下されると、シートが正常に提示されたかどうかを表す結果を得ます。
        顧客があなたのアプリのオファーコードを利用すると、その結果のトランザクションがトランザクションリスナーに送信されます。
        したがって、アプリを起動したらすぐにトランザクションリスナーを設定して、アプリの実行中に新しいトランザクションや更新されたトランザクションを受信するようにしてください。
        オファーコードビューモディファイアは、iOS 16から利用可能です。
        次に、リクエストレビューのアップデートについてお話したいと思います。
        お客様のフィードバックを得ることは重要です。
        潜在的な新規顧客は、アプリをダウンロードする際の決定要因としてレビューを利用するかもしれません。
        また、フィードバックや提案をするためにレビューを残したいという方もいらっしゃるかもしれません。
        いずれにせよ、私たちは、あなたが顧客からの評価を簡単にリクエストできるツールを提供したいと思います。これにより、あなたは顧客に耳を傾けていることを伝え、顧客との関係を継続することができるのです。
        コードを確認してみましょう。
        ここでは、Request Review APIを実演するために、とてもシンプルなビューを用意しました。
        SwiftUIでは、requestReviewと呼ばれる環境値が存在します。
        この値を使ってRequestReviewActionのインスタンスを取得し、評価をリクエストする準備ができたら、レビュープロンプトを表示するようにリクエストする関数としてインスタンスを呼び出すだけでよいのです。
        アプリにレビューを依頼するタイミングは、自分で決めることができます。
        ただし、プロンプトが顧客に表示されるのは、365日以内に最大3回までであることを認識しておく必要があります。
        また、同じバージョンのアプリを何度もレビューするように顧客に依頼するべきではありません。
        レビューのプロンプトでお客様を中断させることは避けてください。
        レビューを依頼する良いタイミングは、eコマースアプリで購入を完了した後や、ゲームのレベルをクリアした後など、ポジティブなインタラクションがあった後かもしれません。
        最後に、顧客は自分のデバイスにレビュー要求が表示されないようにすることができるので、ユーザーのアクションの結果としてレビューを要求するべきではありません。
        これらのAPIは、あなたのSwiftUIアプリにとって本当に便利なものになるでしょう。
        次に、StoreKitメッセージの新しいAPIを紹介したいと思います。
        StoreKitメッセージは、ユーザーに重要な情報を表示するために、アプリの上に表示されるシートを表します。
        メッセージは、App Storeによって販売されます。
        各メッセージには理由があり、その理由はメッセージのメタデータに含まれています。
        StoreKitメッセージは、あなたのアプリがフォアグラウンドになったときに取得されます。
        例として、メッセージの理由の1つである「値上げの同意」を見てみましょう。
        サブスクリプションの価格を引き上げ、それがユーザーの同意を必要とする場合、App Storeは影響を受けるサブスクライバーにメール、プッシュ通知、アプリ内の価格同意書を通じて通知します。
        この場合、App Storeは、高い価格で更新される前に、ユーザーがあなたのサブスクリプションの新しい価格に同意することを要求します。
        そのため、サブスクリプションの料金を高くすることにした場合、ユーザーがまだ値上げに同意していなければ、ユーザーがアプリを開いたときに値上げ同意シートが表示されることがあります。
        デフォルトでは、ユーザーがあなたのアプリを前景に出したときに、StoreKitのメッセージがあなたのアプリの上に表示され、あなたのアプリに関連する何らかのアクションをユーザーに求めることがあります。
        これをおさらいしましょう。
        全体の流れは、あなたのアプリから始まります。
        アプリがフォアグラウンドに入ると、StoreKitは表示すべき保留中のメッセージがあるかどうかを確認することを知っています。
        そして、もしあれば、StoreKitはApp Storeにチェックインします。
        App Storeは、メッセージに関する情報をStoreKitに返します。
        このとき、StoreKitはあなたのアプリがメッセージを受信するように設定されているかどうかを確認します。
        これは、アプリにメッセージリスナーを設定することで行えますが、これについては後ほど説明します。
        アプリがメッセージリスナーを設定していれば、StoreKitはメッセージに関する情報をアプリに送信します。
        ここで、アプリがメッセージを表示するのに適したタイミングかどうか、あるいは表示を後回しにするかどうかを決めるチャンスです。
        メッセージリスナーを設定しない場合、StoreKitはメッセージシートをアプリに重ねて表示することで、メッセージをすぐに表示します。
        この方法をコードで説明します。
        しかしその前に、App Storeメッセージの表示を制御すると便利な状況について説明します。
        Food Truckアプリでは、さまざまな都市に配達するドーナツをカスタマイズすることができるんだ。
        この間にアプリにメッセージが届くと、突然メッセージシートで中断されるとユーザーが混乱するので、メッセージ API を実装して、受信したメッセージが表示されるタイミングを制御することで、このようなことが起こらないようにしようと思っています。
        では、コードに入りましょう。
        ここでは、ドーナツ・エディタのためのシンプルなビューを用意しています。
        先ほど述べたように、保留中のメッセージはアプリがフォアグラウンドになるたびに送信されます。
        そこで、メッセージの表示を延期したい各ビューにメッセージリスナーをセットアップしたいと思います。
        編集ビューにいる間にアプリに配信されたすべてのメッセージを収集するために、バインディング配列を追加します。
        これは重要なことです。メッセージリスナーを設定しないと、アプリがフォアグラウンドに来たときにStoreKitはすぐにメッセージシートを表示しようとするからです。
        ビューが表示されたら、すぐにメッセージ・リスナーを設定します。
        メッセージタイプの静的プロパティを反復処理するタスクを設定することで、これを行うことにします。
        このプロパティは非同期シーケンスで、メッセージが送られてくるとそれを受け取ることができます。
        私のユースケースでは、pendingMessages 配列にメッセージを保存するつもりです。
        保留中のメッセージは、アプリがフォアグラウンドに入るたびに配信されるので、アプリは同じメッセージを複数回受け取る可能性があります。そこで、配列に重複するメッセージを追加しないように、この条件を設定しています。
        そして、ビューが終了したら、親ビューにメッセージを表示します。
        これは、ドーナツ・エディターへのナビゲーション・リンクを保持する親ビューです。
        ここで、表示する必要のあるすべての保留中のメッセージを pendingMessages 配列に集めました。
        では、これらの保留中のメッセージをどのように表示すればよいのでしょうか？さて、環境値として displayStoreKitMessage があります。
        これで DisplayMessageAction のインスタンスを取得し、それを使って指定されたメッセージを表示することができます。
        ビューが表示されたら、保留中のメッセージを繰り返し表示し、表示したいメッセージを渡してdisplayStoreKitMessageを呼び出します。
        メッセージシートの表示はStoreKitが行います。
        先ほど、同じメッセージが複数回アプリに配信される可能性があると述べました。
        それは、メッセージはユーザーに提示されるまで既読にならないからです。
        そこでStoreKitは、それぞれのユニークなメッセージが一度だけ提示されるようにします。
        以上が、Messages APIの簡単な実装でした。
        StoreKitのメッセージは、アプリがフォアグラウンドになるたびに送信されるので、メッセージが表示されるタイミングを制御したい各ビューにメッセージリスナーを設定する必要があることを忘れないでください。
        メッセージシートが予期せぬ瞬間に表示されないようにすることで、顧客に素晴らしい体験をさせることができます。
        また、特定のメッセージタイプに対してロジックを調整することもできます。
        値上げの同意メッセージでは、値上げの同意シートが表示される前に、提供する付加価値について顧客に説明することができます。
        最後に、StoreKit がユーザーが購入した後に、applicationUsername を appAccountToken として保持する方法を確認しましょう。
        サーバにユーザアカウントシステムがある場合、すでにapplicationUsernameプロパティを利用している可能性があります。
        applicationUsernameは、トランザクションをサービスのユーザーアカウントと関連付けるために作成する文字列です。
        アプリ内課金のオリジナルAPIでは、支払いキューに支払いを追加する際に、applicationUsernameの値を設定します。
        applicationUsernameは任意の文字列を受け付けますが、UUIDの文字列表現を指定することを推奨します。
        UUID文字列を指定すると、StoreKitはその値を永続化し、キューが更新されるトランザクションでその値を確認することができます。
        applicationUsernameにUUID文字列を提供しない場合、StoreKitはその値を永続化しない可能性があります。
        キューに決済トランザクションを追加してから、キューがトランザクションを更新するまでの間、値が持続する保証はありません。
        UUIDの文字列表現を提供すると、アプリのどのユーザーアカウントが取引を開始し、完了したかを特定することができます。
        最近のStoreKit APIでは、この概念をappAccountTokenという購入オプションとして実装しており、UUID形式を要求しています。
        さて、決済時にapplicationUsernameにUUID文字列を設定すると、App StoreサーバーはそれをappAccountTokenとして保存します。
        そのため、そのUUIDはApp Store Server APIから返される署名付きトランザクション情報や、V2 App Store Server Notificationに表示されます。
        そしてUUIDとして、最新のStoreKitトランザクションAPIにおけるappAccountTokenと互換性があるのです。
        つまり、コードベースを最新のStoreKit APIに更新したときに、applicationUsernameに使用したUUIDがStoreKitトランザクションのappAccountTokenとして保持されることを確認できるようになったわけです。
        今日はいろいろと触れましたね。
        サーバーのアップデートに移る前に、今年のStoreKitのアップデートをおさらいしておきましょう。
        App Transactionによるアプリの購入の検証、SwiftUIでのオファーコードの引き換えとレビューの要求、StoreKitメッセージの表示制御について説明しました。
        新しい価格ロケール、環境、最近のサブスクリプション開始日プロパティについて説明しました。
        そして、applicationUsername に UUID の文字列表現を使用して、アプリのアカウントトークンとして永続化することの重要性を説明しました。
        他のセッション "What's new in StoreKit testing" をチェックすることを強くお勧めします。
         また、StoreKit 2のAPIについて復習したい方は、昨年のセッション "Meet StoreKit 2" をチェックしてみてください。
         それでは、イアンに引き継いで、App Storeサーバーのアップデートについて説明したいと思います。
        イアン・ザンガーです。ありがとう、Dani。
        皆さん、こんにちは。
         私はApp Store Serverチームのエンジニア、イアンと申します。
        StoreKitを使ったアプリ内課金についての最新情報を聞いていただいたところで、話を切り替えて、サーバーについてお話しします。
        まず、過去1年間の最近の開発状況を振り返り、次にApp Store Server APIとApp Store Server Notifications Version 2に搭載されるエキサイティングな新アップデートについて説明します。
        では、はじめましょう。
        昨年は大きな年でした。
        App Store Server API と App Store Server Notifications V2 で、まったく新しいエンドポイント群を提供し、これらすべての新機能のサンドボックステストを完全にサポートしました。
        Get Transaction History エンドポイントを使用してユーザーのアプリ内購入の全履歴を取得する方法、または Get All Subscription Statuses エンドポイントを使用してユーザーのサブスクリプションの現在の状態を常に最新の状態に保つ方法を共有しました。
        これらのエンドポイントは、どちらもユーザーの originalTransactionId をキーにしているので、この単純な値だけを保存しておけば、このデータの山にアクセスできます。
        また、App Store Server Notifications のバージョン 2 が、サーバー上のイベント処理を簡素化し、App Store Server API を補完する方法についても説明しました。
        V2通知では、App Storeサーバがあなたのサーバを直接呼び出し、アプリ内課金の更新を随時提供します。
        合理化された通知タイプとサブタイプにより、何が起こっているのかを簡単に把握できます。
        これらを使って、アプリ内課金やその他のイベントに関連する変更を追跡することができます。
        これらのデータソースがあるため、そのデータをできるだけ簡単に解析できるようにしたかったのです。
        これらの新しいサービスでは、アプリ内データを署名付きJSON形式で提供するため、レシートは過去のものとなり、簡単に解析して、それがApp Storeのサーバーから来たものであることを信頼することができるようになりました。
        昨年は、App Storeサーバにとって大きな年でした。
        これらの新機能を活用するためにサーバコードの更新に取り組んだ場合、あなたにとっても大きな1年となったかもしれません。
        App Store Server APIとApp Store Server Notifications V2に強力な新機能を提供するため、その努力は引き続き報われますので、ご安心ください。
        以上が今年の振り返りですが、今年のアップデートを聞いてさらに復習したい方は、WWDC21のセッション "Manage in-app purchases on your server", "Meet StoreKit 2", "Support customers and handle refunds" をぜひチェックしてみてください。
         それでは、WWDC22でApp Storeサーバーにもたらされる真新しいアップデートに移りましょう。
        まず、取引と更新情報のフィールドのアップデートをお伝えします。
        次に、App Store Server APIの新しい拡張について説明します。
        そして最後に、App Store Server Notifications V2 に搭載されるエキサイティングな新機能を紹介します。
        それでは、新しいトピックの1つ目、「取引・更新情報の新フィールド」について説明します。
        先ほど、Dani からアプリ内課金の取引・更新情報に新しいフィールドが追加されることを聞きました。
        これらのフィールド、environmentとrecentSubscriptionStartDateは、App Store Server APIやV2 App Store Server Notificationから受け取る取引・更新情報のペイロードにも含まれるようになります。
        これらの新しいフィールドが含まれた状態で、App Store サーバから受け取ることができるデータを改めて見てみましょう。
        まず、トランザクション情報のペイロードをデコードしてみます。
        一番下に、新しいフィールド「環境」が表示されています。
        これを使うと、トランザクションが本番環境で行われたのかサンドボックス環境で行われたのかが一目瞭然になります。
        次に、更新情報のペイロードです。こちらもデコード後に表示されます。
        見ての通り、ここにも環境フィールドがあり、参考にすることができます。
        さらに、recentSubscriptionStartDate が、すべての更新情報のペイロードに表示されるようになりました。
        これは、60日以下の空白期間を無視して、ユーザーの直近の一連の更新の中で最初にサブスクリプションを購入した開始日です。
        recentSubscriptionStartDateは、顧客のロイヤリティを一目で把握する簡単な方法です。
        しかし、サービスの空白期間のタイミングや長さなど、より詳細を知りたい場合は、Get Transaction Historyエンドポイントを呼び出し、ユーザーの購読更新購入の全履歴を調査することができます。
        また、App Store Server Notifications V2を使用すると、App Storeサーバーは、ユーザーの購読に関する更新をサーバーに自動的に送信します。
        これらの通知により、更新の優先順位の変更、オファーの償還、課金の失敗などのイベントのタイミングについて、最大限の洞察を得ることができます。
        このように、recentSubscriptionStartDateは、顧客のロイヤリティを決定するための一連のオプションとなります。
        これらのツールを使用して、キャンペーンの対象を絞り込み、最も忠実な顧客に報酬を与えることができます。
        次に、Get Transaction History エンドポイントの便利な新機能について説明します。
        Get Transaction History エンドポイントを使用すると、アプリでのユーザーの購入履歴をすべて取得できます。
        エンドポイント応答はページ分割されるため、このデータを適切なチャンクで処理できます。
        各レスポンスにはリビジョントークンが含まれており、次のページを取得するために次のリクエストでそれを提供します。
        つまり、後続の各ページには、より最近に変更されたトランザクションが含まれます。
        では、この仕組みを見てみましょう。
        Get Transaction Historyエンドポイントを呼び出し、originalTransactionIdを指定します。
        App Storeサーバーは、そのユーザーの署名済みトランザクションを最大20件まで返します。
        また、このユーザーに対する次のページ要求で提供する更新されたリビジョン値も返されます。
        レスポンスのhasMoreフィールドがtrueになると、さらにデータがあることがわかります。
        この場合、利用可能なデータがもう1ページあるとします。
        エンドポイントに再度リクエストを行い、最初のレスポンスからそのリビジョン値を含めます。
        そして、更新されたリビジョン値を含む、次のページのデータを受信します。
        hasMoreはfalseになったので、最新のトランザクションデータで最新であることがわかります。
        しかし、今回、最後のトランザクションのレスポンスを見て、以前にも見たことがあることに気がつきました。それは、最初のリクエストに応えて受け取った20件のうちの1件である。
        つまり、そのトランザクションは変更され、ソート順の先頭に戻されたに違いない。
        では、そのトランザクションのデータを見て、どこが変わったかを確認します。
        この例では、revocationDateとrevocationReasonフィールドが入力されていることに気づきます。
        これは、トランザクションが取り消されたことを意味します。購入に関連するすべてのコンテンツを取り消すことで、アクションを起こすことができます。
        この最終レスポンスの revision 値を、ユーザーを識別するために使用した originalTransactionId と共に保存することは良いアイデアです。
        次回、このユーザーのエンドポイントを呼び出すときに、そのリビジョンを提供することで、前回のリクエスト以降に変更された新鮮なトランザクションデータのみを取得していることを確認できます。
        これまで見てきたように、Get Transaction Historyエンドポイントでは、アプリ内課金データの包括的なセットを取得するための簡単な方法を提供しています。
        しかし、時には少し包括的すぎることもあるかもしれません。
        ユーザーによっては、数年前にさかのぼる長い購入履歴を持っている場合があります。
        このようなユーザーの場合、このエンドポイントでは、さまざまな種類の数百件の購入履歴が返される可能性があります。
        このような場合、ページ数が多くても、処理するのは大変なことです。
        そこで今年、このエンドポイントにさまざまな新しいソートとフィルターオプションを追加しました。
        これにより、サーバーでの処理時間を短縮し、利用可能なすべてのページを取得するために必要なネットワークの呼び出し回数を減らすことができます。
        最も新しく更新された購入品を最初のページに表示したい場合は、更新日の降順でソートすることができます。
        また、商品タイプ、商品ID、家族の共有状況など、便利なフィールドでフィルタリングすることもできます。
        これらの新しいソートおよびフィルタオプションを適用するには、Get Transaction Historyエンドポイントへのリクエストにクエリパラメータとして追加するだけです。
        それでは、その仕組みについて詳しく見ていきましょう。
        ここでは、新しいパラメータ・オプションをすべて見ることができます。
        これらのほとんどは、トランザクション情報のペイロードから直接取得されているため、見慣れたものに見えるかもしれません。
        これらのパラメータを組み合わせて、非常に特殊な結果を得ることができます。
        例えば、あるユーザーが今年の初めから行った非消費型の購入品だけを取得したいとします。
        また、取り消された購入も除外したい。
        productTypeをNON_CONSUMABLEに設定し、startDateを今年の始まりとしてミリ秒単位で指定して、カスタムリクエストを構築することになります。
        最後に、excludeRevoked を true に設定します。
        これでリクエストは完了です。ソート順を指定していないので、レスポンスのデフォルトは更新日時の昇順になります。
        さて、このように特定のリクエストであっても、取得する購入品のページが複数ある可能性があります。
        次のリクエストでは、前のレスポンスのリビジョンに加え、まったく同じクエリパラメータを含めるようにします。
        さらに柔軟性を高めるために、3 つのフィルタフィールドが複数の値をサポートしています。
        これらのフィールドは、productType、productId、およびsubscriptionGroupIdentifierです。
        これらのパラメータに複数の値を指定するには、単純に複数回定義します。
        次に、App Store Server Notification の更新について説明します。
        App Store Server Notifications V2 を使用すると、サーバーを次のレベルに引き上げることができます。
        V2通知は、アプリ内課金イベントに関する、他では得られない詳細な洞察を提供します。
        これらは、アプリで提供されている自動更新可能なサブスクリプションのライフサイクルを追跡するために特に有用です。
        これらのインサイトを利用して、顧客の維持、離脱者の回復、カスタマーサポートのリクエストの解決などに役立てることができます。
        このような利点があるにもかかわらず、どのように始めればよいのかと思われるかもしれません。
        他の新機能と同様、サンドボックスのテスト環境は、開始するのに最適な場所です。
        そこで昨年、サンドボックスでApp Store Server Notificationを受信するために、App Store Connectで別のサーバーURLを設定する機能を追加しました。
        サーバーURLを登録したら、自分のサーバーがApp Storeサーバーからの通知を受信していることを確認したいところです。
        ユーザーのアクションによって通知をトリガーするためだけに、サンドボックスアカウントを設定することもできます。
        例えば、そのサンドボックスアカウントを使って、Subscriptionの初回購入を実行したとします。
        あなたは、タイプSUBSCRIBED、サブタイプINITIAL_BUYのV2通知を受け取るはずです。
        しかし、その通知が来なかったらどうでしょうか？あなたのサーバーに問題があるのか、通知をトリガーするために取った手順に問題があるのかと思うかもしれません。
        このような状況は、開始直後には多くの不確実性を生み出します。
        私たちは、このような経験を簡素化し、App Store Server Notificationがサーバーに到達することを簡単に確認する方法を提供したいと思います。
        そのため、今年、新しいRequest a Test Notificationエンドポイントを導入しました。
        このシンプルなエンドポイントを呼び出すことで、App Store Connectでアプリに登録されたサーバーURLに、TESTタイプのV2 Notificationを送信するよう依頼できます。
        新しいTEST通知タイプは、このエンドポイントにのみ使用されます。
        サンドボックスまたは本番環境でこのエンドポイントを呼び出し、保存したURLをどちらの環境でもテストすることができます。
        この新しいエンドポイントを使用して、新しいサーバー URL と構成をすばやくテストできます。
        それでは、初回セットアップをどのように簡略化するか見ていきましょう。
        さて、最初の通知をトリガーしたいだけなら、サンドボックス・アカウントをセットアップしたり、購入を実行したりする必要はありません。
        テストしたい環境で新しいエンドポイントを呼び出すだけで、リクエストを確認するHTTP 200レスポンスが返されます。
        このレスポンスには、新しいフィールドである testNotificationToken が含まれ、サーバーが受け取るテスト通知を識別します。
        このフィールドについては、後ほど説明します。
        その後まもなく、App Store Connectに保存されたURLで、TESTタイプのV2通知をサーバーが受信するはずです。
        では、このエンドポイントを呼び出す方法を見てみましょう。
        App Storeサーバーのこの新しいパスに、単純なPOSTリクエストを送信するだけです。
        HTTP 200 レスポンスを受信し、リクエストが送信されたことがわかります。
        このレスポンスには、先ほど説明した新しいフィールド、testNotificationToken が含まれています。
        これは後日のためにメモしておいてください。
        まもなく、署名されたテスト通知が届きます。
        これは、その通知がデコードされるとどのように見えるかを示しています。
        新しいnotificationTypeであるTESTを含む、V2通知の通常のトップレベルフィールドをすべて含んでいることに気づくでしょう。
        データオブジェクトのコンテンツは、通常の通知より少し短いです。
        これは単なるテストなので、含めるべきトランザクション関連のデータはありません。したがって、トランザクション固有のフィールド、特にsignedTransactionInfoは省略します。
        新しい Request a Test Notification エンドポイントを呼び出すときは、App Store Server Notification が非同期で送信されることに留意してください。
        エンドポイントの呼び出しに成功すると、HTTP 200が返されますが、実際のテスト通知は、しばらく後に別途届きます。
        このエンドポイントはサーバー構成をテストするためのものなので、そのテストが失敗したときにどうすればいいのか気になるかもしれません。
        言い換えれば、テスト通知が届かなかったらどうするのでしょうか？テスト機能をさらに強化するために、私たちは Get Test Notification Status エンドポイントをリリースしています。
        この新しいエンドポイントを使用すると、以前にリクエストしたテスト通知のステータスを確認できます。
        エンドポイントの応答は、App Store サーバーがあなたのサーバーに到達し、テスト通知を正常に送信できたかどうかを示します。
        送信に失敗した場合、その理由を教えてくれるので、サーバー構成のトラブルシューティングをより良く行うことができます。
        このエンドポイントをどのように使用するか確認してみましょう。
        App Store サーバーのこのパスに GET リクエストを送信します。
        パスには、Request a Test Notification エンドポイントから受け取った testNotificationToken を含めます。
        これにより、どのテスト通知の状態を確認したいかがわかります。
        次に、レスポンスです。
        signedPayloadフィールドには、App Storeサーバーがあなたのサーバーに送信しようとしたTEST通知のペイロードが含まれています。
        そして、firstSendAttemptResultフィールドは、その送信試行の結果を示しています。
        ここで、SUCCESSは送信が成功したことを示し、App Storeサーバーがお客様のサーバーからHTTP 200応答を受信したことを意味します。
        送信に失敗した場合、代わりにいくつかの異なるエラー値のうちの1つが表示されます。
        これらの値は、App Storeサーバーがテスト通知でお客様のサーバーに到達しようとした際に発生したエラーを示しています。
        この情報があれば、サーバーの問題をトラブルシューティングし、必要に応じて新しいテスト通知を要求し、サーバーを確実に稼働させることができます。
        これらのテスト通知エンドポイントは、簡単に使用でき、V2 App Store Server Notificationを受信するためにサーバーを設定または再構成する際に、多くの手間を省くことができる。
        これらのエンドポイントを利用することで、サーバーをセットアップし、スムーズに動作することを確認することができます。
        しかし、サーバーは完璧ではありませんし、障害も発生します。
        サーバーがダウンし、App Store Server Notificationを見逃した場合、どのようにリカバーすればよいのでしょうか？現在のところ、リトライシステムがこの問題を解決しています。
        App Storeサーバーがあなたのサーバーに到達できない場合、リトライプロセスが開始されます。
        同じ通知の送信を最大5回まで再試行し、各試行間の待機時間を長くします。
        これらの再試行は、本番環境でのみ行われます。
        再試行は、最終的に障害から回復するのに役立ちますが、すべての状況に対して完璧ではありません。
        例えば、一部の停止は広範囲に及ぶことがあります。
        サーバーが長時間停止し、App Storeサーバーからの最終的な再試行を逃すと、その通知は失われます。
        あるいは、より一般的には、サーバーにごく短時間の問題が発生し、その間にほんの数件の通知を見逃すことがあります。
        しかし、たった1つの通知を見逃すだけで、少なくとも1時間、顧客記録の一部が更新されないことになります。
        しかし、どの記録が更新されないかわからないのです。サーバーの停止はストレスであり、その復旧は複雑なタスクです。
        だからこそ、私たちは、App Store Server Notificationの障害をできるだけ簡単に回復し、サーバーをできるだけ早く軌道に乗せたいと考えています。
        そのため、今年、新しいGet Notification Historyエンドポイントを導入しました。
        このエンドポイントを使用すると、アプリに対して生成されたV2 App Store Server Notificationの履歴を取得することができます。
        サーバーが通知を正常に受信したかどうかに関わらず、その通知はこのエンドポイントのレスポンスに表示される。
        このエンドポイントを呼び出す際には、取得する通知の日付範囲を指定することになる。
        WWDCで、このデータの記録を開始し、最新の6ヶ月のローリング履歴が利用可能になるという上限まで積み上げる予定です。
        オプションで、タイプやサブタイプでリクエストをフィルタリングしたり、originalTransactionIdを指定して、1人のユーザーの通知だけを取得することもできます。
        また、既存のリトライシステムも引き続き利用できるため、この新しいエンドポイントと組み合わせて使用することも可能です。
        このエンドポイントをどのように呼び出すか見てみましょう。
        App Storeサーバ上のこの新しいパスにPOSTリクエストを送信します。
        リクエスト・ボディには、startDateとendDateを含めます。
        応答には、このウィンドウで最初に送信しようとした通知のみが含まれます。
        最も古い通知は、リクエストの日付の6ヶ月前に送信されたものになることに留意してください。
        オプションで、notificationTypeとnotificationSubtypeを指定することができます。
        指定した場合、履歴は、これらの値の両方に一致する通知のみにフィルタリングされます。
        サブタイプを持たない通知もあることに留意してください。
        また、ユーザーのoriginalTransactionIdを指定すると、そのユーザーのみの通知履歴を取得することができます。
        最後に、次のページを取得するために、すべてのフォローアップ・リクエストのクエリ・パラメータとしてpaginationTokenを提供する必要があります。
        フォローアップ・リクエストには同じリクエスト・ボディを使用し、このpaginationTokenだけを変更するようにしてください。
        では、レスポンスを見てみましょう。
        notificationHistory 配列は、最大 20 件の通知を含み、最も古い通知が最初になります。
        この配列の各エントリはnotificationを表し、その中にsignedPayloadがあります。このsignedPayloadを通常通りデコードすると、トランザクションデータを見ることができます。
        このデータは、App Storeサーバーがオリジナルの通知で送信したペイロードと同じものです。
        このエンドポイントレスポンスに、新しいfirstSendAttemptResultフィールドも持ってきていることがわかります。
        このフィールドを使用して、タイムアウトやその他のエラーのシーケンスを検索し、サーバーが過去に通知を逃した理由をより良く理解することができます。
        また、取得するページがまだある場合は、レスポンスに paginationToken が含まれます。
        次のページの通知を取得するためには、次のリクエストでこれを指定する必要があります。
        hasMoreフィールドがtrueであれば、取得するページがまだあることがわかります。
        これで、この便利な新しいエンドポイントについて知っておく必要があることはすべて終わりました。
        以上で、本日の App Store サーバのアップデートを終了します。
        今日発表されたすべてのサーバ機能は、サンドボックスと本番環境の両方で利用可能です。
        これらの新機能を利用して、あなたのサーバーを最高のものにしてください。
        レガシークライアントをサポートしながら最新機能を利用する方法など、アプリ内課金でサーバーを利用する際の素晴らしいコンテンツについては、WWDC22の別のセッション "Explore in-app purchase integration and migration" をご覧いただくことをお勧めします。
         両氏：WWDC22へのご参加ありがとうございました。

        """
    }
}

