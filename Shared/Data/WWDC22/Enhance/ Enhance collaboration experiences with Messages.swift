import Foundation

struct EnhanceCollaborationExperiencesWithMessages: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Enhance collaboration experiences with Messages"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6589/6589_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10095/")!
    }

    var english: String {
        """
        Miranda Zhou: Hi, my name is Miranda and I'm an engineer on the Sharing team.
         Elana Stettin: I'm Elana and I'm an engineer on the Messages team.
         Miranda: In this video, Elana and I will be diving into how to enhance collaboration with Messages in your app.
         I'll start with an introduction of what the feature is.
         You'll learn how to prepare to adopt this feature, and how to tie Messages into the process to start a collaboration.
         Elana will explain how to add collaboration with Messages UI to your app, and finally she will discuss how to keep up to date when the collaboration is updated.
         First, let me introduce collaboration with Messages! In iOS 16 and macOS Ventura, we've added a new and easy way to improve communication between people who are collaborating.
         Collaborators are able to tie a document to conversations by sharing via Messages.
         Collaboration activity is surfaced in Messages conversations and in ongoing FaceTime calls.
         A customizable Collaboration popover is also provided to your app to manage details of the collaboration and connect to the Messages conversation.
         This builds on technologies that you are already using, such as the share sheet and drag and drop.
         Next, I'll go over the types of collaboration infrastructures we support, and how to tie each of those to Messages collaboration.
         We support three types of collaboration infrastructures: CloudKit, iCloud Drive, and whatever custom collaboration infrastructure you may be using today! In this video, I'll mainly focus on the CloudKit and iCloud Drive cases.
         If you are using a custom infrastructure, watch the "Integrate your custom collaboration app with Messages" video for more details.
         If you use CloudKit-based collaboration, we've provided a new API to create an object that the system can recognize for collaboration.
         This is based off the macOS Sierra API to start or manage a share with NSSharingService.
         Once you have the collaboration object, identify where in the app you are showing UI to start or manage the share.
         You need to update to the new API to enhance your collaboration with Messages, as we will deprecate the existing AppKit API.
         The new collaboration object API uses NSItemProvider.
         NSItemProvider is used by system services to transport your app's data to other processes on the system.
         The provider requires either the CKShare for the collaboration item, or a preparation handler to create a CKShare when collaboration starts.
         Your app's CKContainer is also required.
         And finally, provide a CKAllowedSharingOptions object representing the access and permissions options for the collaboration.
         The values of the options are the same as the NSCloudKitSharingServiceOptions which were previously requested from NSCloudSharingServiceDelegate methods.
         Here's a brief overview of what it looks like to create a CloudKit collaboration object.
         If the collaboration is being started and you pass in a preparation handler, you need to both create the share and save it to the server in the handler.
         If it's already started, just pass in the associated share.
         The CKAllowedSharingOptions instance being registered is using a static standard property which returns the default set of allowed options.
         CloudKit adopters can use that or create a custom instance of the class for a restricted set of allowed options.
        For those of you who might be interested in adopting CloudKit, CloudKit lets you use iCloud as your app's database without writing your own server code.
         You will also get a built-in method of sharing parts of that data with other iCloud users.
         For more details, watch the "What's new in CloudKit" video.
         If you're using iCloud Drive, your object for collaboration is simply your file URL -- we'll do all the work to recognize it! Once you have that, identify the entry points to start or manage collaboration in your app and prepare to replace them with the new and improved versions.
         For custom collaboration infrastructures, your collaboration object is called SWCollaborationMetadata, wrapped in new NSItemProvider API.
         Watch the "Integrate your custom collaboration app with Messages" video for details on how to use this API to update your collaboration UI.
         Now you're ready to go.
         Next, initiating a collaboration.
         There are two different ways: through the share sheet in its new collaboration mode, and through drag and drop to Messages, either from your app or from the Files app on iOS and Finder on macOS.
         The new share sheet collaboration mode can be identified by an indicator in the header, which also provides a choice between collaboration and sending a copy.
         In order to have collaboration in the share sheet, give the share sheet the collaboration object you prepared earlier.
         On macOS, this collaboration indicator is shown in a beautiful new share popover! The share popover also includes a title and image in the header, plus a row of conversation suggestions, and all the transports we offered already.
         For more details about this, watch the WWDC22 "What's new in AppKit" video.
         On iOS and Mac Catalyst, show the share sheet using the UIActivityViewController class.
         On macOS, show the share popover using NSSharingServicePicker.
         Pass the collaboration object to UIActivityViewController as an activity item to present it with collaboration enabled.
         And similarly, initialize NSSharingServicePicker with the collaboration object to show it with collaboration enabled.
         CloudKit adopters will need to take an extra step to provide a title and image for the headers.
         On iOS, use existing API such as UIActivityItemsConfiguration or UIActivityItemSource to provide an LPLinkMetadata object with a title and imageProvider.
         Create your configuration with your collaboration object, then set the metadata provider to return your LPLinkMetadata object for the item being shared.
         Finally, initialize UIActivityViewController with that configuration.
         On macOS, we have a new API called NSPreviewRepresenting ActivityItem for providing the header metadata.
         Refer to the NSPreviewRepresenting ActivityItem documentation for more details.
         To use NSPreviewRepresenting ActivityItem, first choose your title, image, and icon.
         The image represents the item being shared, while the icon represents the source of the item being shared -- for example, an app icon.
         Create an NSPreviewRepresenting ActivityItem with your collaboration object, title, image, and icon, and initialize NSSharingServicePicker with that preview item.
         On an exciting note, the new SwiftUI ShareLink API for the share sheet will also support collaboration mode! To adopt, the item you are sharing must be represented by Transferable, a new protocol for sharing and data transfer.
         CloudKit adopters provide the share, container, and options through a CKShareTransferRepresentation returned by your Transferable item.
         For more details, watch the "Meet Transferable" and WWDC22 "What's new in SwiftUI" videos.
         Here's an example of how a CloudKit adopter like Notes would create a transferable object to share with ShareLink.
         The note provides a CKShareTransferRepresentation, which is constructed either as its existing value with an existing CKShare, CKContainer, and CKAllowedSharingOptions value, or as its prepareShare value with a CKContainer, CKAllowedSharingOptions value, and a preparation handler to create and save a CKShare for the collaboration object.
         For iCloud Drive adopters, your file URL is the Transferable object which you share through ShareLink.
         If you have a custom collaboration infrastructure, watch the "Integrate your custom collaboration app with Messages" video for how to return an SWCollaborationMetadata object from your transferable object.
         Once you have your Transferable object, pass it to the ShareLink initializer as the item to share.
         At the same time, pass in a preview with a title and image to fill in the share sheet header.
         One notable feature of the share sheet collaboration mode header is the summary of the access and permissions options.
         Tapping this summary brings up a view where collaborators choose what access and permissions options to use when collaborating.
         For CloudKit adopters, this view shows the set of options registered in the collaboration object.
         iCloud Drive adopters show the standard set of iCloud Drive options.
         If you have a custom infrastructure, watch the "Integrate your custom collaboration app with Messages" video for how to specify your custom options and have them show up in this view.
         There's one more way to start a collaboration, and that's through drag and drop.
         A collaborator can simply drag your document into Messages and get the new collaboration-enabled rich link for the document in Messages.
         This rich link provides functionality both for collaboration and sending a copy, and for selecting collaboration options.
         To adopt, provide your collaboration object through ShareLink on iOS 16 and macOS Ventura.
         And that's how you prepare for and initiate collaborations with Messages.
         Next, I'll hand it over to Elana, who will talk about taking your app's collaboration experience to the next level.
         Elana: Thanks, Miranda! Now that you know how to get started, I'll talk about how to further integrate our collaboration UI into your app.
         We've added these new features to amplify the collaboration experience.
         The collaboration button is placed in your app's navigation and will show the group photo of the associated messages group.
         There is also an active participant count to the right of the button that will show when others are present in the document.
         When you tap the collaboration button, the new collaboration popover appears.
         The customizable popover shows the overview of the collaboration.
         It also allows users to initiate communication with other participants with just one tap.
         This provides them the ability to work together in real time via Messages and FaceTime.
        These UI elements are all powered by a single class in the SharedWithYou framework: SWCollaborationView.
         This view represents the button view in the navigation.
         All you need to do is initialize the SWCollaborationView and we will take care of the popover layout and presentation for you.
         To show custom content, you'll provide a view which will be added to the popover.
         Now, I'll go over the code to create the SWCollaborationView.
         Initialize the SWCollaborationView with an itemProvider.
         The itemProvider contains the CKShare for CloudKit-based apps, the fileURL for iCloud Drive-based apps, or the SW Collaboration metadata for custom collaboration infrastructures.
        Set the activeParticipantCount property on the collaboration view to show the number of active participants on the document.
         Then set the contentView property on the collaborationView to provide the popover with custom content.
         The ContentView is what makes the popover completely customizable.
         This is where you'll add your own content to give users a unique view of what is going on in the collaboration.
         For example, in Pages, the ContentView contains the Current Participants list and the Participant Cursors toggle.
         Now, let's look at the "manage" button.
         For CloudKit and iCloud Drive adopters, this manage button will bring up the manage UI, where you can add and remove participants or change the share settings.
         I'll talk more about this shortly.
         Customize the provided button title by setting the manageButtonTitle property on the collaboration view.
         If you do not set this property, the title will default to "Manage Share.
        " If your app uses a custom collaboration infrastructure, include your own manage button in the contentView.
         One will not be provided for you.
         On Mac, make sure the button has a transparent background to adhere to Apple design recommendations.
         Finally, create a UIBarButtonItem on iOS as shown here, using the collaborationView as the custom view.
         On Mac, initialize an NSToolbarItem using a UIBarButtonItem.
         Then, add the bar button item or toolbar item to the ViewController's navigationItem.
         As I mentioned earlier, CloudKit and iCloud Drive adopters are provided with a button in the collaboration popover.
         This enables you to manage the share in the same way you've always been able to.
         Changes in the provided manage UI are observable by adhering to the same delegate protocols already used to observe changes: UICloudSharing ControllerDelegate and NSCloudSharing ServiceDelegate.
         Now you have an understanding of how to integrate the new collaboration UI into your app.
         Next, I'll go over how to observe and handle updates to collaborations.
         It is critical to know when a share starts or stops.
         For CloudKit adopters, we've added a new protocol called CKSystemSharing UIObserver to notify you of just that.
         With this protocol, you get callbacks corresponding to when your CKShare is saved or removed without needing the CloudKit Sharing UI.
         I'll take you through some code now.
         Initialize an observer using the CKContainer.
         On the observer, define a closure to be executed when the CKShare is saved and assign it to the systemSharingUI DidSaveShareBlock.
         In the closure, if the Share was saved correctly, you'll get a success result -- indicating the share was started -- and an associated CKShare to work with.
         If the save was unsuccessful, you receive a failure result and the associated error.
         Here is the implementation of the closure for when the document owner stops sharing.
         In the success case, the CKShare has successfully been deleted.
         In the failure case, you will also get the associated error.
         Starting and stopping shares are not the only changes you may care about.
         Some changes, you might even want to bubble up to users.
         We've added API to enable you to post notices summarizing updates to a collaboration, right at the top of the relevant Messages thread.
         Collaborators are shown what the update was and who made the change.
         To post a notice, retrieve the SWCollaborationHighlight, which is a collaboration-specific type of highlight in Shared with You.
         Use it to create an SWCollaborationHighlight event.
         Learn more about SWHighlights and other SharedWithYou APIs in the "Add Shared with You to your app" video.
         Watch this video before beginning your work to adopt notices.
         I'll talk through posting different notices using a CloudKit app as an example.
         If your app uses a custom collaboration infrastructure, view the "Integrate your custom collaboration app with Messages" video for detailed instructions.
         To represent a notice, we've introduced a protocol called SWHighlightEvent.
         Highlight events are initialized with SWHighlights retrieved from the SWHighlightCenter API.
         The supported event types include a change event for content updates or comments; a mention event when a user is mentioned in a collaboration; a persistence event when content is moved, renamed, or deleted; and a membership event when a participant is added or removed from a document.
         Here's an example showing how to post a change event when a collaboration has been edited.
         Using the highlight center API, retrieve a collaboration highlight using the CKShare URL.
         Remember, this CKShare is one you defined during the collaboration initiation, so your app should have this available when a content change is made.
         Next, create a HighlightChangeEvent instance.
         The initializer takes a highlight, and a trigger enum value.
         In this case, we set the trigger type to edit.
         Lastly, post the notice for that event to the highlightCenter.
         The rest of the events follow a similar format with the sole exception being the mentionEvent, as it requires more information to indicate which user was mentioned.
         You are able to post this type of event only if your app supports user mentions.
         Create the mentionEvent by passing in the retrieved highlight and the handle of the mentioned CKShare participant.
         This notice will only be shown to the mentioned user.
         Use the persistence event type when content is moved, renamed, or deleted.
         Here, the renamed trigger type is used to signify the document name has been changed.
         Finally, here is a membershipEvent.
         For a membershipEvent, use the addedCollaborator or removedCollaborator trigger type instead.
         With mentionevents, notices are posted to show how the document membership has changed.
         However, we've also made it possible to keep collaborators on your shared documents in sync when the Messages group membership changes.
         For CloudKit and iCloud Drive, this is simple: we do the work for you.
         When someone new is added to the Messages group with a collaboration, the document owner is prompted via a notice to add them to the share.
         The same goes for when someone is removed.
        For apps with custom collaboration infrastructures, there's a little more work to be done.
         You will need to adopt the SWCollaborationActionHandler API, which you can learn more about in "Integrate your custom collaboration app with Messages.
        " Now you know how to get started with collaboration in Messages and integrate it into your app, whether you're using CloudKit, iCloud Drive, or your own collaboration infrastructure.
         Prepare your app to initiate collaborations by adopting the new share sheet and drag and drop APIs.
         Integrate the new collaboration UI to provide a customized overview of what is happening in the shared document.
         Once you have that set up, go even further and adopt notices to display changes to the collaboration from within the Messages thread.
         Miranda and I can't wait to see how your app takes advantage of these new collaboration features in Messages! Both: Thank you for watching!
        """
    }

    var japanese: String {
        """
        ミランダ・ズー 私はMirandaです。Sharingチームのエンジニアです。
         Elana Stettin: 私はElanaで、Messagesチームのエンジニアです。
         Miranda: このビデオでは、Elanaと私が、あなたのアプリでMessagesを使ったコラボレーションを強化する方法について掘り下げていきます。
         まずは、どんな機能なのかの紹介から。
         この機能を採用するための準備と、コラボレーションを開始するためのプロセスにメッセージを関連付ける方法について学びます。
         Elanaは、アプリにMessages UIとのコラボレーションを追加する方法を説明し、最後にコラボレーションが更新されたときに最新の状態を維持する方法について説明します。
         まずは、Messagesとのコラボレーションについて紹介します iOS 16とmacOS Venturaでは、コラボレーションしている人たちのコミュニケーションを改善する、新しい簡単な方法が追加されました。
         コラボレーターは、メッセージを介して共有することで、ドキュメントと会話を結びつけることができます。
         メッセージでの会話や進行中のFaceTime通話でも、コラボレーションの活動が表示されます。
         カスタマイズ可能なコラボレーションポップオーバーは、コラボレーションの詳細を管理し、メッセージの会話に接続するために、アプリケーションに提供されます。
         これは、共有シートやドラッグ＆ドロップなど、あなたがすでに使っているテクノロジーをベースにしています。
         次に、私たちがサポートしているコラボレーションインフラストラクチャの種類と、それぞれをメッセージコラボレーションに関連付ける方法について説明します。
         コラボレーション・インフラには、3つのタイプがあります。CloudKit、iCloud Drive、そしてあなたが今使っているカスタムコラボレーション基盤です。このビデオでは、主にCloudKitとiCloud Driveのケースに焦点を当てます。
         カスタムインフラストラクチャを使用している場合は、「カスタムコラボレーションアプリとメッセージの統合」ビデオで詳細をご覧ください。
         CloudKitベースのコラボレーションを使用する場合、システムがコラボレーション用に認識できるオブジェクトを作成するための新しいAPIを提供しました。
         これは、NSSharingServiceで共有を開始または管理するためのmacOS Sierra APIをベースにしています。
         コラボレーションオブジェクトを取得したら、アプリのどこで共有を開始または管理するためのUIを表示しているかを確認します。
         既存のAppKit APIを廃止するため、Messagesとのコラボレーションを強化するためには、新しいAPIにアップデートする必要があります。
         新しいコラボレーション・オブジェクトAPIは、NSItemProviderを使用します。
         NSItemProvider は、システムサービスによって、アプリのデータをシステム上の他のプロセスに転送するために使用されます。
         プロバイダは、コラボレーションアイテムの CKShare、またはコラボレーション開始時に CKShare を作成する準備ハンドラのいずれかを必要とします。
         アプリのCKContainerも必要です。
         そして最後に、コラボレーションのためのアクセスとパーミッションのオプションを表す、CKAllowedSharingOptionsオブジェクトを提供します。
         オプションの値は、以前NSCloudSharingServiceDelegateメソッドから要求されたNSCloudKitSharingServiceOptionsと同じものです。
         CloudKitのコラボレーション・オブジェクトを作成する際のイメージを簡単に説明します。
         コラボレーションが開始されていて、準備ハンドラを渡す場合は、ハンドラ内で共有の作成とサーバーへの保存の両方を行う必要があります。
         すでに始まっている場合は、関連する共有を渡すだけです。
         登録されているCKAllowedSharingOptionsインスタンスは、許可されたオプションのデフォルト・セットを返す静的標準プロパティを使用しています。
         CloudKitの採用者はそれを使うか、許可されたオプションの制限されたセットのためにクラスのカスタムインスタンスを作成することができます。
        CloudKitを採用することに興味があるかもしれない人のために説明すると、CloudKitでは独自のサーバコードを書かずにiCloudをアプリのデータベースとして使用することができます。
         また、そのデータの一部を他のiCloudユーザと共有する方法も組み込まれています。
         詳しくは、「CloudKitの新機能」ビデオをご覧ください。
         iCloud Driveを使用している場合、コラボレーションのためのオブジェクトは単にファイルのURLです -- それを認識するための作業はすべて私たちが行います これができたら、アプリでコラボレーションを開始または管理するためのエントリーポイントを特定し、それらを新しく改良されたバージョンに置き換える準備をします。
         カスタムコラボレーションインフラの場合、コラボレーションオブジェクトはSWCollaborationMetadataと呼ばれ、新しいNSItemProvider APIでラップされています。
         このAPIを使用してコラボレーションUIを更新する方法の詳細については、「カスタムコラボレーションアプリをメッセージと統合する」ビデオをご覧ください。
         これで準備は整いました。
         次に、コラボレーションの開始です。
         新しいコラボレーションモードのシェアシートからと、アプリから、またはiOSのFilesアプリやmacOSのFinderからメッセージにドラッグ＆ドロップする方法の2種類があります。
         新しい共有シートのコラボレーションモードは、ヘッダーのインジケータで識別でき、コラボレーションかコピー送信かの選択も可能です。
         共有シートでコラボレーションを行うには、先に用意したコラボレーションオブジェクトを共有シートに付与します。
         macOSでは、このコラボレーションのインジケータは、新しい美しい共有ポップオーバーに表示されます! この共有ポップオーバーには、ヘッダーのタイトルと画像、さらに会話の提案の列、そしてすでに提供したすべてのトランスポートも含まれています。
         この詳細については、WWDC22の「What's new in AppKit」ビデオをご覧ください。
         iOSとMac Catalystでは、UIActivityViewControllerクラスを使って、シェアシートを表示します。
         macOSでは、NSSharingServicePickerを使って、共有ポップオーバーを表示します。
         コラボレーションオブジェクトをアクティビティアイテムとしてUIActivityViewControllerに渡し、コラボレーションを有効にした状態で表示します。
         また同様に、NSSharingServicePickerをコラボレーションオブジェクトで初期化し、コラボレーションを有効にした状態で表示します。
         CloudKitを採用する場合は、ヘッダーのタイトルと画像を用意する手間がかかる。
         iOS では、UIActivityItemsConfiguration や UIActivityItemSource などの既存の API を使用して、タイトルと imageProvider を指定した LPLinkMetadata オブジェクトを提供します。
         コラボレーション・オブジェクトで設定を作成し、共有されるアイテムの LPLinkMetadata オブジェクトを返すようにメタデータ・プロバイダを設定します。
         最後に、その構成でUIActivityViewControllerを初期化します。
         macOS では、ヘッダメタデータを提供するための NSPreviewRepresenting ActivityItem という新しい API を用意しています。
         詳細は、NSPreviewRepresenting ActivityItemのドキュメントをご参照ください。
         NSPreviewRepresenting ActivityItem を使用するには、まず、タイトル、画像、アイコンを選択します。
         画像は共有されるアイテムを表し、アイコンは共有されるアイテムのソース（例えば、アプリのアイコンなど）を表します。
         コラボレーションオブジェクト、タイトル、画像、アイコンで NSPreviewRepresenting ActivityItem を作成し、そのプレビューアイテムで NSSharingServicePicker を初期化します。
         エキサイティングなことに、共有シートのための新しい SwiftUI ShareLink API は、コラボレーションモードもサポートするようになります! 採用するには、共有するアイテムが、共有とデータ転送のための新しいプロトコルである Transferable で表現されている必要があります。
         CloudKit の採用者は、あなたの Transferable アイテムによって返される CKShareTransferRepresentation を通して、共有、コンテナ、およびオプションを提供します。
         詳しくは、"Meet Transferable" と WWDC22 "What's new in SwiftUI" ビデオをご覧ください。
         以下は、ノートのようなCloudKit採用企業が、ShareLinkで共有するためのTransferableオブジェクトを作成する例です。
         ノートは CKShareTransferRepresentation を提供し、これは既存の CKShare、CKContainer、CKAllowedSharingOptions 値でその既存の値として、または CKContainer、CKAllowedSharingOptions 値、コラボレーション オブジェクトの CKShare を作成し保存する準備ハンドラーでその prepareShare 値として構築されます。
         iCloud Driveを採用している場合、ファイルのURLはShareLinkを通じて共有するTransferableオブジェクトとなります。
         カスタム コラボレーション インフラストラクチャを使用している場合は、「カスタム コラボレーション アプリとメッセージの統合」ビデオで、Transferable オブジェクトから SWCollaborationMetadata オブジェクトを返す方法についてご覧ください。
         Transferable オブジェクトを取得したら、それを ShareLink イニシャライザに共有するアイテムとして渡します。
         同時に、共有シートのヘッダーを埋めるためのタイトルと画像を含むプレビューを渡します。
         共有シートのコラボレーションモードヘッダーの特筆すべき点は、アクセス権や権限オプションの概要です。
         このサマリーをタップすると、コラボレーションの際に使用するアクセス権や権限オプションをコラボレーターが選択するビューが表示されます。
         CloudKit を採用している場合、このビューにはコラボレーション・オブジェクトに登録されている一連のオプションが表示されます。
         iCloud Drive を採用している場合は、iCloud Drive の標準的なオプションが表示されます。
         カスタム基盤の場合は、カスタムオプションを指定してこのビューに表示させる方法について、「カスタムコラボレーションアプリとメッセージの統合」ビデオをご覧ください。
         コラボレーションを開始するには、もう1つ方法があります。
         コラボレーターは、あなたの文書をメッセージにドラッグするだけで、その文書への新しいコラボレーション可能なリッチリンクをメッセージに表示することができます。
         このリッチリンクは、コラボレーションとコピーの送信、およびコラボレーションオプションの選択のための機能を提供します。
         採用するには、iOS 16とmacOS VenturaのShareLinkを通じてコラボレーション・オブジェクトを提供します。
         そして、これがメッセージでのコラボレーションの準備と開始の方法です。
         次はElanaにバトンタッチして、アプリのコラボレーション体験を次のレベルに引き上げることについて話してもらいます。
         Elana: ありがとう、Miranda! では、コラボレーションUIをアプリに統合する方法について説明します。
         私たちは、コラボレーション体験を増幅させるために、これらの新機能を追加しました。
         コラボレーションボタンはアプリのナビゲーションに配置され、関連するメッセージグループのグループ写真が表示されます。
         また、ボタンの右側にはアクティブな参加者数が表示され、他の人がドキュメントに参加していることを示します。
         コラボレーションボタンをタップすると、新しいコラボレーションポップオーバーが表示されます。
         カスタマイズ可能なこのポップオーバーには、コラボレーションの概要が表示されます。
         また、ユーザーはワンタップで他の参加者とコミュニケーションを開始することができます。
         これにより、メッセージやFaceTimeを使ってリアルタイムに共同作業を行うことができます。
        これらのUI要素は、すべてSharedWithYouフレームワークの1つのクラスによって提供されています。SWCollaborationViewです。
         このビューは、ナビゲーション内のボタンビューを表します。
         SWCollaborationViewを初期化するだけで、ポップオーバーのレイアウトと表示は私たちに任せてください。
         カスタムコンテンツを表示するには、ポップオーバーに追加されるビューを提供することになります。
         では、SWCollaborationView を作成するためのコードを説明します。
         SWCollaborationViewをitemProviderで初期化します。
         itemProviderには、CloudKitベースのアプリの場合はCKShare、iCloud Driveベースのアプリの場合はfileURL、カスタムコラボレーション基盤の場合はSW Collaborationのメタデータを指定します。
        コラボレーションビューのactiveParticipantCountプロパティを設定し、ドキュメント上でアクティブな参加者の数を表示します。
         次にcollaborationViewにcontentViewプロパティを設定し、ポップオーバーにカスタムコンテンツを提供します。
         ContentViewはポップオーバーを完全にカスタマイズできるようにするものです。
         ここに独自のコンテンツを追加して、コラボレーションで何が起こっているのかをユーザーにユニークに見せることができます。
         例えば、Pagesの場合、ContentViewには現在の参加者リストと参加者カーソルのトグルが表示されます。
         次に、"管理 "ボタンについて見てみましょう。
         CloudKitとiCloud Driveを採用している場合、この管理ボタンを押すと管理UIが表示され、参加者の追加や削除、共有設定の変更などができます。
         これについては、追って詳しく説明します。
         コラボレーションビューの manageButtonTitle プロパティを設定することで、提供されるボタンのタイトルをカスタマイズすることができます。
         このプロパティを設定しない場合、タイトルのデフォルトは "Manage Share.
        " アプリがカスタムコラボレーションインフラストラクチャを使用する場合、contentViewに独自の管理ボタンを追加してください。
         このボタンは提供されません。
         Mac の場合は、Apple のデザイン推奨に従って、ボタンの背景が透明であることを確認してください。
         最後に、iOSでは、collaborationViewをカスタムビューとして使用して、次のようにUIBarButtonItemを作成します。
         Macでは、UIBarButtonItemを使用して、NSToolbarItemを初期化します。
         そして、ViewControllerのnavigationItemにバーボタンアイテムまたはツールバーアイテムを追加します。
         先ほど述べたように、CloudKitとiCloud Driveの採用者には、コラボレーションポップオーバーにボタンが用意されています。
         これにより、これまでと同じように共有を管理することができます。
         提供された管理UIの変更は、変更を観察するために既に使用されているのと同じデリゲートプロトコルに準拠することで観察可能です。UICloudSharing ControllerDelegateとNSCloudSharing ServiceDelegateです。
         これで、新しいコラボレーションUIをアプリに統合する方法について理解できたと思います。
         次に、コラボレーションの更新を監視し、処理する方法について説明します。
         共有がいつ開始され、いつ停止されるかを知ることは非常に重要です。
         CloudKit を採用している企業向けに、CKSystemSharing UIObserver という新しいプロトコルを追加して、そのことを通知するようにしました。
         このプロトコルを使用すると、CloudKit Sharing UI を使用せずに、CKShare が保存または削除されたときに対応するコールバックを得ることができます。
         これからいくつかのコードを紹介します。
         CKContainerを使ってオブザーバーを初期化する。
         オブザーバーに、CKShareが保存されたときに実行されるクロージャを定義し、systemSharingUI DidSaveShareBlockに割り当てます。
         クロージャでは、Share が正しく保存された場合、成功結果（Share が開始されたことを示す）と、関連する CKShare を取得し、作業することができます。
         保存に失敗した場合は、失敗結果と関連するエラーを受け取ります。
         以下は、ドキュメントオーナーが共有を停止した場合のクロージャの実装です。
         成功の場合、CKShareは正常に削除されました。
         失敗の場合は、関連するエラーも表示されます。
         共有の開始と停止は、あなたが気にする可能性のある唯一の変更ではありません。
         いくつかの変更は、ユーザーにバブルアップしたいかもしれません。
         コラボレーションの更新を要約した通知を、関連するメッセージスレッドのトップに投稿できるAPIが追加されました。
         共同作業者は、更新内容と誰が変更したかを見ることができます。
         お知らせを投稿するには、Shared with Youのコラボレーション専用のハイライトである、SWCollaborationHighlightを取得します。
         それを使って、SWCollaborationHighlightイベントを作成します。
         SWHighlightsやその他のSharedWithYou APIの詳細については、「アプリにShared with Youを追加する」ビデオでご覧ください。
         お知らせを採用する作業を始める前に、このビデオを見てください。
         CloudKitアプリを例にして、さまざまなお知らせの投稿についてお話しします。
         アプリがカスタムコラボレーションインフラストラクチャを使用している場合は、「カスタムコラボレーションアプリをメッセージと統合する」ビデオで詳細な手順をご覧ください。
         通知を表現するために、SWHighlightEventというプロトコルを導入しています。
         Highlight イベントは、SWHighlightCenter API から取得した SWHighlights で初期化されます。
         サポートされているイベントタイプは、コンテンツの更新やコメントに対するchangeイベント、コラボレーションでユーザーが言及されたときのmentionイベント、コンテンツの移動、名前の変更、削除に対するpersistenceイベント、ドキュメントに参加者が追加または削除されたときのmembershipイベントです。
         以下は、コラボレーションが編集されたときに変更イベントを投稿する例です。
         highlight center API を使用して、CKShare の URL を使用してコラボレーションのハイライトを取得します。
         この CKShare はコラボレーションの開始時に定義したもので、コンテンツが変更されたときにアプリがこれを利用できるようにする必要があります。
         次に、HighlightChangeEvent のインスタンスを作成します。
         イニシャライザーは、ハイライトとトリガー列挙値を取ります。
         今回は、トリガータイプをeditに設定します。
         最後に、そのイベントの通知を highlightCenter にポストします。
         他のイベントも同様の形式で行われますが、唯一の例外は mentionEvent で、これはどのユーザーが言及されたかを示すために、より多くの情報を必要とします。
         このタイプのイベントは、アプリがユーザーへの言及をサポートしている場合にのみ投稿することができます。
         取得したハイライトと、言及した CKShare 参加者のハンドルを渡して、mentionEvent を作成します。
         この通知は、言及されたユーザーに対してのみ表示されます。
         コンテンツが移動、名前変更、または削除された場合は、persistence イベントタイプを使用します。
         ここでは、ドキュメント名が変更されたことを示すために、renamed トリガータイプが使用されています。
         最後に、membershipEventを紹介します。
         membershipEvent では、代わりに addedCollaborator または removedCollaborator のトリガータイプを使用します。
         mentioneventsでは、ドキュメントのメンバシップが変更されたことを示す通知が掲示されます。
         しかし、Messages グループのメンバーシップが変更されたときに、共有ドキュメントの共同作業者を同期させることもできるようにしました。
         CloudKitとiCloud Driveの場合、これは簡単です：私たちがあなたに代わって作業を行います。
         メッセージグループに新しい共同作業者が追加されると、ドキュメントのオーナーはその共同作業者を共有に追加するよう通知されます。
         誰かが削除された場合も同様です。
        カスタムコラボレーションインフラストラクチャを持つアプリの場合は、もう少し作業が必要です。
         SWCollaborationActionHandler APIを採用する必要があります。詳細は「カスタムコラボレーションアプリとMessagesを統合する」で説明しています。
        " CloudKit、iCloud Drive、または独自のコラボレーションインフラを使用しているかどうかにかかわらず、Messagesでのコラボレーションを開始し、アプリに統合する方法はおわかりいただけたと思います。
         新しい共有シートとドラッグ＆ドロップAPIを採用して、コラボレーションを開始できるようにアプリを準備します。
         新しいコラボレーションUIを統合して、共有ドキュメントで起こっていることの概要をカスタマイズして提供します。
         この設定が完了したら、さらに進んで、メッセージスレッドからコラボレーションの変更を表示するための通知を採用します。
         Mirandaと私は、あなたのアプリがメッセージの新しいコラボレーション機能をどのように活用しているかを見るのが楽しみです。両氏：ご覧いただきありがとうございました。
        """
    }
}
