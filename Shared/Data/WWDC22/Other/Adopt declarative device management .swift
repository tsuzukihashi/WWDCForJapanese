import Foundation

struct AdoptDeclarativeDeviceManagement: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Adopt declarative device management"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6539/6539_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10046/")!
    }

    var english: String {
        """
        Welcome to the "Adopt declarative device management" session.
        My name is Cyrus Daboo, and I am an engineer on the Device Management team.
        I am here to tell you about the exciting new features in declarative device management.
        At WWDC21, my colleague Melissa introduced declarative device management, a new paradigm for managing Apple devices, reenvisioning the MDM protocol itself.
        As we learned in that session, declarative device management is powerful because it enables devices to be autonomous and proactive.
        The device is autonomous, as it reacts to its own state changes and then applies management logic to itself, without prompting from the server.
        The device is proactive, with the status channel asynchronously reporting to the server when important state changes occur, avoiding the need for servers to poll devices.
        There are two key elements to the declarative device management data model: declarations and status.
        Declarations encompass activations and predicates, configurations, assets, and management types.
        And status covers status items and status reporting.
        Let's take a moment to talk about why this matters, what it means for you, and the organizations that use your products.
        We have created this technology to support new complex management strategies, enhance the overall user experience of managed devices, alleviate the repetitive and tedious tasks of an IT admin, and empower devices to be the driver in their own management state.
        For you, as a developer of a device management solution, the declarative approach allows your servers to be lightweight and reactive.
        And with the declarative data model more closely mapping to how organizations are structured, that means changes to devices becomes more intuitive.
        Status reports provide a rich feedback channel, which enable your servers to monitor devices more closely, and present pertinent information in a more timely and reliable fashion, without the need for complex strategies used to implement polling.
        All of this means a simpler development effort, enabling you to focus on the device management features that add value where it matters most, and create a solution your customers will love.
        For IT admins, the declarative approach inspires more confidence that the device is in the expected state.
        And in the situations where it is not, that it is in a safe state that protects any sensitive organization data, even when connectivity to the server is lost.
        It provides critical feedback from devices via status reports, that also improves efficiency for admins through less utilization of resources such as network bandwidth.
        For the organization's users, device management becomes a more responsive and reliable experience with faster onboarding, quicker recovery times and better support from their organization.
        With all these benefits in mind, know that the focus of future protocol features will be declarative device management, making it even more important for you to adopt declarative device management in your products today.
        For an in-depth introduction to declarative device management and the steps needed to adopt it, make sure you watch the WWDC21 session video.
        In this release, we have three focus areas: expanding the scope of declarative device management, enhancing status reports, and enhancing predicates.
        Let's start with expanding the scope of declarative device management.
        When declarative device management was introduced, it was supported on only iOS with user enrollments.
        Now, declarative device management is available for every enrollment type MDM supports: automatic device enrollment, which includes supervised devices; profile-based enrollment; and profile and account-based user enrollments.
        Declarative device management is now also available on Shared iPad.
        In iOS 16, users can now find configurations in the MDM profile details view in the Settings app.
        Tapping the Configurations row reveals details about the active configurations.
        And I am also pleased to announce that declarative device management is available on every platform MDM supports.
        macOS Ventura now supports declarative device management, for all MDM enrollment types supported on macOS.
        tvOS 16 now supports declarative device management for MDM device enrollment types.
        Where supported by the OS, the same set of declarations and status that are available on iOS are also available on macOS and tvOS.
        On macOS, a Configurations section is present in the MDM profile details view, revealing the active configurations.
        The same goes for tvOS, where a Configurations section is present in the MDM profile details view.
        One last thing to note here: both macOS and Shared iPad devices each have two MDM channels.
        These are the device and user channel.
        The device channel allows management of device level state, whereas the user channel targets management state for specific users.
        To use declarative device management on any channel, it must be enabled separately for that channel.
        That means sending the DeclarativeManagement command on the corresponding channel.
        Also, declarative device management status reports are separately generated for each channel, so they need to be separately monitored as well.
        Now on to our second focus area: status reports.
        Let's do a quick review of status reports.
        Devices can incrementally report status to the server, for subscribed status items.
        The device tracks successful responses from the server to ensure status updates are reliable and not missed in the case of networking or other types of problem.
        Status reporting makes the device proactive.
        There is no need for servers to continuously poll the device to watch for state changes.
        In iOS 15, we introduced a set of status items for device properties, such as model type and operating system version.
        For this release we are expanding status in three areas: passcode state, accounts installed by configurations, and MDM installed apps.
        Let's start with passcode status.
        In iOS 15, we introduced a passcode policy configuration.
        There can be some lag between the policy being applied, and the passcode becoming compliant when changed by the user, just as there is with MDM passcode policy profiles.
        So, MDM servers have to poll the device to determine when the passcode becomes compliant.
        But with the new declarative device management passcode status items, there is no need to do that.
        We have added two status items: Passcode.
        is-compliant and passcode.
        is-present.
        Compliance indicates if the passcode is compliant with all passcode policies applied via MDM profiles or configurations.
        These status items have Boolean values that mirror the equivalent properties that can be retrieved via MDM queries.
        Let's explore a typical server behavior.
        Often, an organization has security sensitive state to apply to a device.
        For example, VPN or Wi-Fi profiles to allow access to protected networks.
        That state should only be active on a device, when a strong passcode policy is present, and the passcode is compliant with that policy.
        With traditional MDM, a server has to send a passcode policy profile then poll the device, to wait for the passcode to become compliant when the user changes it.
        Initially the passcode is likely not compliant, so the Wi-Fi profile cannot be sent.
        Eventually, the user changes the passcode to bring it into compliance.
        On the server's next poll, it detects the changed compliant state and determines it is OK to send the Wi-Fi profile, which then gets installed on the device.
        Declarative device management removes the need for the server to poll by using an activation predicate that is triggered by the passcode compliance state.
        The server sends both the passcode policy and the Wi-Fi profile as configurations, with the Wi-Fi configuration tied to an activation predicated on the passcode compliance.
        The passcode configuration is immediately activated and applies a strong passcode policy.
        Initially, the passcode is likely not compliant, so the activation predicate evaluates to false, and the Wi-Fi configuration is not activated.
        At some point, the user updates the passcode to be compliant.
        This triggers reevaluation of the activations and the predicate now evaluates to true, resulting in the Wi-Fi configuration being activated.
        All this happens without any intervention from the server, and in fact can happen without any connection to the server being present.
        The server does automatically get a status report from the device when the configuration activates, so it knows when the change takes place.
        This illustrates how we have successfully moved business logic from the server to the device, to avoid the need to poll and get a more responsive and reliable device behavior.
        Now, let's turn to account status.
        In iOS 15, we introduced account configurations to install accounts of various types on a device.
        These are typically organization accounts, giving the user access to organization data.
        It is useful for the admin to know when accounts have been successfully installed, and what state they are in, to help support users who might be having problems.
        This release adds eight account status items for mail, calendar, and other account types.
        Note, that status is only reported for accounts installed by configurations and won't include accounts created manually or installed via MDM profiles.
        Each new status item corresponds to an account configuration type, with status for incoming and outgoing mail accounts reported separately.
        The new status items each use a different type of JSON object, to represent the status of the corresponding account type.
        Here are examples of an incoming mail status item, and a subscribed calendar status item.
        The value of the identifier key is a unique identifier for an object within the array of status item objects -- more on this in a minute.
        The value of the declaration identifier key, matches the identifier property value of the configuration that installed the account, making it easy to cross-reference the status item object and its associated configuration.
        These two keys are always present in all types of account status item object.
        The other keys are specific to the type of account.
        For example, hostname and port for the mail server, or calendar-URL for the subscribed calendar.
        This release introduces status items whose value is an array, to support reporting on one or more accounts of the same type.
        Such array values have special behavior.
        Each item in the array is a JSON object with the same schema used for all objects in a single array.
        Each object type always has an identifier key, acting as the primary key for locating objects within the array.
        Other keys are present and tied to the underlying type of status being reported.
        To ensure forwards compatibility with any keys added in future OS releases, your server must accept unknown keys in array objects.
        Changes to an array value are always reported incrementally to the server on a per-object basis, for performance reasons.
        Let's run through an example that shows how this new feature works.
        In this example, the server sends two mail account configurations to the device.
        These are both active resulting in two mail accounts present on the device.
        The server now sends a status subscription for the mail account status item.
        When the subscription is activated, status for the accounts is collected, and the device sends a status report to the server.
        The status report will include the two account status objects in the status array, giving the server a complete picture of what is currently present on the device.
        Each array object has a different identifier.
        After processing this report, the server has status for two mail accounts, matching what is on the device.
        When the server adds a mail account on the device by sending a new configuration, the status item on the device has a new object added to its array value, and another status report is sent to the server.
        Only the new item is reported.
        The value of the identifier key does not match any the server already has, so the server can infer this corresponds to a new account.
        After processing this report, the server has status for three mail accounts, the two initial ones and the new one, again matching exactly what is on the device.
        When account status changes, such as when a user toggles the mail or notes enabled state, the status item on the device will have an updated object in its array value, and again, a status report is sent to the server.
        Only the changed item is reported.
        In this case, the user turned off the notes feature for the account.
        The value of the identifier key matches one the server already has, so the server can infer that this is an update to an existing account.
        Consequently, it replaces the existing status item array object with the new one.
        After processing this report, the server has status for three mail accounts, but one has changed.
        When an account configuration is removed from the device, the status item on the device has the corresponding object marked for removal, and another status report is sent to the server.
        Only the removed item is reported.
        To indicate removal, the array item object contains only two keys: the identifier key -- whose value matches one the server already has -- and the removed key, set to the value true.
        This allows the server to update its representation of the device state by removing the existing item.
        After processing this report, the server has status for only two mail accounts, correctly matching the state of the device.
        One last point about status reports.
        The device will limit the rate at which status reports are sent to avoid performance issues.
        The device aggregates changes to status items over a variable interval of up to one minute before sending a status report to the server.
        This means status is reported quickly, but it is not immediate.
        Next, let's turn our attention to solving a perennial MDM-bottleneck problem: monitoring application install status.
        MDM servers often install apps on devices to give users access to the tools needed for their work or education.
        Server-side logic is often dictated by whether an app is installed successfully or not.
        So MDM servers need to monitor app installation progress and watch for the possibility of users removing managed apps on their device.
        Currently, MDM servers can use the InstalledApplicationList or ManagedApplicationList commands to poll the device to observe app installation progress.
        We can avoid polling by having the device proactively send app install progress to the server.
        And the tool to do that is declarative device management status reports.
        This release adds an mdm.app status item.
        Its value is an array of objects that each represent an app that has been installed by the MDM server.
        Since this value is an array, it is reported incrementally, using the procedure described earlier.
        Note that only apps installed by MDM are reported here, even on supervised devices.
        This status report includes a status item for an app that has finished installing.
        The identifier key is the unique identifier for the array item object, and in this case, is the app's bundle identifier.
        The name key indicates the name of the app.
        The three version keys provide normal, short, and external version identifiers.
        And the state key is an enumeration that indicates the current install phase for the app.
        The values of these keys correspond to the equivalent items in the MDM ManagedApplicationList command response.
        With all this information, the server can immediately identify which app is being reported and what its state is.
        Let's examine an example of the flow of data as an app installs.
        On the right side, we have an iOS 16 device that is being managed by an MDM server.
        The server has already enabled declarative device management and sent a status subscription for the MDM-installed app status item.
        The next step for the server is to install an app using the MDM InstallApplication command.
        Since this is a user enrollment, user approval is needed to install the app, so a prompt appears when the device processes the app install command.
        At this point, the installation progress is paused, waiting for user input.
        The device will send a status report to the server, and that will contain a single MDM-installed app status object, with the bundle ID of the app and the state set to prompting.
        At some point, the user taps the Install button, and the app install starts on the device.
        As the install proceeds, another status report will be sent, this time with the app state set to installing; indicating the app is being downloaded and installed.
        Eventually, the app completes installation and is ready for use.
        At that point, another status report will be sent with the app state set to managed, indicating the app is properly installed and managed.
        Now, let's say the user manually deletes the app on the device.
        Again, a status report will be sent, this time with the app state set to managed-but-uninstalled.
        This indicates the app is no longer installed, but its management state is still being tracked on the device.
        Let's assume the server wants to remove the app-management state.
        It does that by sending a RemoveApplication command to the device.
        That removes the internally maintained management state, and if the app were still present, it would be removed too.
        Another status report will be sent with the app object marked as removed from the app status array.
        This illustrates the power of the new MDM status item to help improve the responsiveness and reliability of app installs, and it only takes a few steps to implement.
        Now, let's examine our third focus area: predicates.
        Let's quickly review activation predicates.
        Activations can include an optional predicate that determines whether the configurations referenced in the activation will be applied to the device.
        Predicates can reference status items to allow the values of those status items to be tested.
        When a status item referenced in a predicate changes, the device will reprocess all of the activations, reevaluating any predicates.
        Predicates are specified as a string using the NSPredicate syntax documented on the Apple Developer site.
        To support more complex predicate expressions, we have extended the predicate syntax to make it easier to detect status items in the expression.
        The new syntax places the status item name inside an @status term in the predicate string.
        In the example, the serial number status item appears in the predicate expression, using the new syntax.
        The previous syntax will continue to work for backwards compatibility, however, it is now deprecated, so please switch to the new one.
        Let's examine how predicates can be used with status item array values.
        As we just described, we now have status item values that are arrays for the accounts and MDM-installed app status items.
        It is useful to be able to predicate an activation on an item in the array.
        For example, we might want an activation to be triggered when an app with a particular bundle identifier is installed and managed on the device.
        NSPredicate has a SUBQUERY term that can be used to operate on arrays.
        This NSPredicate expression uses a SUBQUERY targeting the MDM-installed app status item.
        The status item is used as the first argument to the SUBQUERY.
        The second argument defines a variable that will refer to each element of the array.
        The third argument is a predicate expression that tests each element identified by that variable.
        The SUBQUERY expression returns an array of elements that match the predicate in the third argument.
        The @count operator then returns the length of that array, and the length is checked to determine if there is one resulting match.
        When the specified app is installed and managed, this SUBQUERY expression will return an array with a single element, and the predicate will evaluate to true.
        When the app is not installed, the SUBQUERY expression will return an empty array, and the predicate will evaluate to false.
        Note that in order to reference the keys in the status item array object, the @key extension term must be used to ensure the key paths are properly processed.
        The new predicate syntax is extensible, and we will now discuss how it can be used to add predicate terms for a new type of data.
        Servers need to be able to more directly control the evaluation of predicates, so that complex server-side logic can translate into simple state changes on the device, without the need to synchronize large sets of configurations to trigger those changes.
        An example of this might be an organization that has users with multiple roles and wants efficient, just-in-time assignment of devices as they are handed out to users, or organizations that need to quickly distribute replacement devices, or quickly put devices into a safe mode to protect organization data.
        To support this, I am pleased to say we are adding a new declaration to allow servers to set arbitrary properties on the device, that can be directly used in activation predicates.
        This is the new management properties declaration.
        The declaration consists of a JSON object whose key names are defined by the server.
        The JSON object values can be any JSON value type, including arrays or objects.
        The management properties declaration here, includes three properties: the name and age properties that have a string and integer value, and the roles property that is an array of strings.
        This is an activation with a predicate that references some management properties.
        First, it tests the age property to determine if its integer value is greater than or equal to 18, then it tests the roles property to determine if the string Grade12 is in the property array value.
        Each property is referenced using the @property extension term, with the property key name inside the term.
        Multiple management properties declarations can be sent to the device, but the keys should be unique across all of them.
        If there are duplicate keys, one of the values will be arbitrarily chosen when the property is referenced in a predicate, leading to unpredictable results.
        So please avoid using duplicate key names.
        Let's explore an example use case.
        This example involves a school.
        And of course, the school has a set of teachers.
        The school has two divisions: Upper and Lower.
        Each division has its own campus with its own Wi-Fi network.
        Some teachers function as an IT Admin and require access to a shared mail account.
        Some teachers also function as a sports coach and should have a subscribed calendar for all the team game schedules.
        There are thus four different roles that a teacher may have, and sometimes they have multiple roles.
        Each role has a set of configurations that must be applied to devices based on the roles of the teacher assigned to the device.
        Let's consider two teachers in our example.
        Teacher one teaches in Lower school and is also a sports coach.
        Teacher two teaches in Upper school and is also an IT admin.
        How might such a use case be handled by a traditional MDM server? Typically, the server has to wait for a device to be assigned to a teacher before it can fully configure that device.
        The server has to determine what roles the teacher has.
        It then determines what profiles are linked to each role.
        It then has to install each profile on the device one at a time.
        If a teacher changes roles, the server has to add or remove profiles to match the new roles.
        This is time-consuming and can introduce significant bottlenecks to a device-management system particularly at peak times, which in our case would be the first day of school when assignments are done.
        With the new management properties declaration, we have a more efficient alternative to this.
        This involves preloading a full set of declarations on the device ahead of time.
        Configurations are assigned to activations, with predicates that are triggered for different roles via management properties.
        When a device is assigned to a teacher, the server sends only a management properties declaration with the teacher's roles, which triggers activation of the configurations for those roles.
        This method minimizes the overall server and network traffic and reduces the complexity of making rapid changes to device state.
        Let's go back to our school example.
        The server will preload the following sets of declarations: two activation/configuration pairs that set up the Wi-Fi network for each division.
        Then, we have an activation/configuration pair for the IT admin role, that installs a mail account.
        Finally, we have an activation and configuration that installs a subscribed calendar.
        Each activation has a predicate that tests the division or function's name using the roles management property.
        When initially loaded on an unassigned device, all the predicates evaluate to false, so nothing is applied.
        Now, let's examine what happens on the day of assignment.
        All the server needs to do is create management properties declarations customized to each teacher.
        Teacher one has a roles property that lists Lower and Sports.
        Teacher two has a roles property that lists Upper and IT Admin.
        When these declarations are separately sent to each assigned device, the preloaded activations will all be reevaluated.
        So teacher one's device has the configurations for Lower and Sports roles activated.
        And teacher two's device has the configurations for the Upper and IT Admin roles activated.
        Only a single declaration is needed to trigger the application of many configurations.
        Finally, let's examine what happens when a teacher changes roles.
        In this case, teacher two has become a sports coach in addition to their existing roles.
        The management properties declaration for the teacher's assigned device is now updated to include the additional role name.
        When that declaration is updated on the device, all the activations are reevaluated.
        In this case, the subscribed calendar configuration for the new Sports role will be applied.
        Again, only a single declaration change is needed as a trigger.
        This illustrates how the management properties declaration provides a powerful way to quickly and easily switch between sets of configurations on a device, so that complex server-side logic can translate into simple state changes on the device.
        Now, let's wrap up.
        We have extended the scope of declarative device management on iOS 16, tvOS 16, and macOS Ventura, as well as making it available for all applicable types of MDM enrollment, including Shared iPad.
        This provides full support for declarative device management across all Apple devices that support MDM.
        We have added new status items for passcode, accounts, and MDM-installed apps.
        The MDM-installed app status provides a great solution for one of MDM's key bottlenecks.
        Finally, we have enhanced the predicate syntax to make it more extensible and easy to use and added the new management properties declaration that gives servers even more opportunity to move complex business logic to the device.
        Now is the time to add declarative device management to your products.
        And we're excited to learn what you'll do to reimagine device management solutions using declarative device management! As always, your feedback is greatly appreciated.
        Thank you and enjoy the rest of WWDC.
        """
    }

    var japanese: String {
        """
        Adopt declarative device management」セッションにようこそ。
        私はCyrus Dabooといい、デバイス管理チームのエンジニアです。
        今回は、宣言型デバイス管理のエキサイティングな新機能についてお伝えします。
        WWDC21で、私の同僚であるメリッサは、MDMプロトコルそのものを再定義した、Appleデバイス管理の新しいパラダイムであるdeclarative device managementを紹介しました。
        そのセッションで学んだように、宣言型デバイス管理は、デバイスを自律的かつプロアクティブにすることができるため、強力です。
        デバイスは自律的です。デバイスは自身の状態の変化に反応し、サーバーから促されることなく、管理ロジックを自分自身に適用します。
        デバイスはプロアクティブであり、重要な状態変化が発生すると、ステータスチャネルが非同期でサーバーに報告するため、サーバーがデバイスをポーリングする必要性を回避することができます。
        宣言型デバイス管理データモデルには、「宣言」と「ステータス」という2つの重要な要素があります。
        宣言には、アクティベーションと述語、コンフィギュレーション、アセット、および管理タイプが含まれる。
        そして、ステータスは、ステータス項目とステータスレポートをカバーします。
        なぜこれが重要なのか、それがあなたやあなたの製品を使用する組織にとって何を意味するのか、少しお話ししましょう。
        私たちは、新しい複雑な管理戦略をサポートし、管理対象デバイスの全体的なユーザー体験を向上させ、IT管理者の反復的で退屈な作業を軽減し、デバイスが自身の管理状態のドライバーとなるようにするために、このテクノロジーを作成しました。
        デバイス管理ソリューションの開発者としては、宣言型アプローチにより、サーバーを軽量化し、反応的にすることができます。
        また、宣言型データモデルは、組織の構造により近いため、デバイスへの変更がより直感的になります。
        ステータスレポートは豊富なフィードバックチャネルを提供し、サーバーはデバイスをより詳細に監視し、ポーリング実装のための複雑な戦略を必要とせずに、よりタイムリーで信頼性の高い方法で関連情報を提示することが可能になります。
        これらのことは、開発作業がよりシンプルになり、最も重要な価値を付加するデバイス管理機能に集中することができ、顧客に喜ばれるソリューションを作成することができることを意味します。
        IT管理者にとっては、宣言的なアプローチにより、デバイスが期待通りの状態にあるという確信が得られます。
        また、そうでない場合は、サーバーへの接続が失われた場合でも、組織の機密データを保護する安全な状態であることを確認できます。
        デバイスからの重要なフィードバックは、ステータスレポートを通じて提供され、ネットワーク帯域幅などのリソースの使用量を減らすことで管理者の効率も向上させます。
        組織のユーザーにとっても、デバイス管理は、より迅速な導入、迅速な復旧、組織からのより良いサポートによって、より迅速で信頼性の高い体験となります。
        これらの利点を考慮すると、今後のプロトコル機能の焦点は宣言型デバイス管理であり、今すぐ製品に宣言型デバイス管理を採用することがより重要であることが分かります。
        宣言的デバイス管理の詳細な紹介と、それを採用するために必要なステップについては、WWDC21のセッションビデオを必ずご覧ください。
        今回のリリースでは、宣言型デバイス管理のスコープ拡大、ステータスレポートの強化、述語の強化という3つのフォーカスエリアを設けています。
        まずは宣言型デバイス管理のスコープ拡大から。
        宣言型デバイス管理が導入された当初は、ユーザー登録が可能なiOSのみに対応していました。
        現在では、MDMがサポートするすべての登録タイプで宣言型デバイス管理が利用できます。自動デバイス登録（監視付きデバイスを含む）、プロファイルベース登録、プロファイルおよびアカウントベースのユーザー登録があります。
        宣言的デバイス管理は、共有iPadでも利用できるようになりました。
        iOS 16では、ユーザーは設定アプリケーションのMDMプロファイルの詳細ビューで設定を見つけることができるようになりました。
        Configurationsの行をタップすると、アクティブなコンフィギュレーションの詳細が表示されます。
        そして、MDMがサポートするすべてのプラットフォームで宣言型デバイス管理が利用できるようになったこともお知らせします。
        macOS Ventura は、macOS でサポートされるすべての MDM 登録タイプで、宣言型デバイス管理をサポートするようになりました。
        tvOS 16 は、MDM デバイスの登録タイプについて、宣言型デバイス管理をサポートするようになりました。
        OS がサポートしている場合、iOS で利用可能な宣言とステータスのセットは、macOS と tvOS でも利用可能です。
        macOSでは、MDMプロファイルの詳細ビューにConfigurationsセクションが存在し、アクティブな構成が明らかになります。
        tvOSでも同様で、MDMプロファイルの詳細ビューにConfigurationsセクションが存在します。
        macOSと共有iPadデバイスは、それぞれ2つのMDMチャンネルを持っています。
        デバイスチャンネルとユーザーチャンネルです。
        デバイスチャンネルはデバイスレベルの状態を管理できるのに対し、ユーザーチャンネルは特定のユーザーの管理状態を対象とします。
        任意のチャンネルで宣言型デバイス管理を使用するには、そのチャンネルで個別に有効にする必要があります。
        つまり、対応するチャネルでDeclarativeManagementコマンドを送信することになります。
        また、宣言型デバイス管理のステータスレポートは、各チャンネルで別々に生成されるので、それらも別々にモニターする必要があります。
        次に、2つ目の焦点であるステータスレポートについて説明します。
        ステータス・レポートについて、簡単におさらいしておきましょう。
        デバイスは、サブスクライブしたステータス項目について、サーバーにステータスをインクリメンタルに報告することができます。
        デバイスは、サーバーからの正常な応答を追跡し、ネットワークや他のタイプの問題が発生した場合でも、ステータス更新が確実に行われ、見落とされないようにします。
        ステータス報告により、デバイスはプロアクティブになります。
        サーバーは、状態の変化を監視するためにデバイスを継続的にポーリングする必要はありません。
        iOS 15では、モデルタイプやオペレーティングシステムのバージョンなど、デバイスのプロパティに関する一連のステータス項目を導入しました。
        今回のリリースでは、パスコードの状態、設定によってインストールされたアカウント、および MDM によってインストールされたアプリの 3 つの領域でステータスを拡張しています。
        まず、パスコードの状態から説明します。
        iOS 15では、パスコードのポリシー設定が導入されました。
        MDMのパスコードポリシープロファイルと同様に、ポリシーが適用され、ユーザーによってパスコードが変更されたときに準拠した状態になるまでに多少のタイムラグが発生することがあります。
        そのため、MDMサーバーはデバイスをポーリングして、パスコードがいつ準拠するのかを判断しなければなりません。
        しかし、新しい宣言型デバイス管理パスコードステータス項目を使えば、そのようなことをする必要はありません。
        2つのステータス項目を追加しました。Passcode.
        is-compliantとpasscode.
        is-presentです。
        Complianceは、パスコードがMDMプロファイルまたは構成を介して適用されるすべてのパスコードポリシーに準拠しているかどうかを示します。
        これらのステータス項目は、MDM クエリで取得できる同等のプロパティを反映したブール値を持っています。
        典型的なサーバーの挙動を調べてみよう。
        多くの場合、組織は、デバイスに適用するセキュリティに敏感な状態を持っています。
        例えば、保護されたネットワークへのアクセスを許可するためのVPNやWi-Fiプロファイルなどです。
        このような状態は、強力なパスコードポリシーが存在し、パスコードがそのポリシーに準拠している場合にのみ、デバイス上で有効になるはずです。
        従来の MDM では、サーバーがパスコード・ポリシーのプロファイルを送信し、デバイスをポーリングして、ユーザーがパスコードを変更したときにパスコードが準拠するのを待つ必要がありました。
        当初はパスコードが準拠していない可能性が高いため、Wi-Fiプロファイルを送信することはできません。
        やがて、ユーザーはパスコードを変更して準拠するようになります。
        サーバーは次のポーリングで、変更されたコンプライアンス状態を検出し、Wi-Fiプロファイルの送信に問題がないと判断し、デバイスにインストールされます。
        宣言型デバイス管理では、パスコードのコンプライアンス状態によって起動されるアクティベーション述語を使用することで、サーバーがポーリングする必要性を排除しています。
        サーバーは、パスコード・ポリシーとWi-Fiプロファイルの両方を構成として送信し、Wi-Fi構成はパスコード準拠を前提としたアクティベーションに結びつけられます。
        パスコード構成は直ちにアクティブ化され、強力なパスコード・ポリシーが適用されます。
        当初は、パスコードが準拠していない可能性が高いため、アクティブ化の述語は偽と評価され、Wi-Fi構成はアクティブ化されません。
        ある時点で、ユーザーはパスコードを更新し、準拠するようにします。
        これにより、アクティベーションの再評価が行われ、述語はtrueに評価され、Wi-Fiコンフィギュレーションがアクティベートされるようになります。
        これらはすべて、サーバーの介入なしに行われ、実際、サーバーへの接続がなくても行われます。
        サーバーは、設定が有効になったときにデバイスから自動的にステータスレポートを取得するため、変更が行われたことを知ることができます。
        これは、ビジネスロジックをサーバーからデバイスに移動することで、ポーリングの必要性をなくし、より応答性と信頼性の高いデバイスの動作を得ることに成功したことを表しています。
        次に、アカウントの状態について説明します。
        iOS 15 では、デバイスにさまざまな種類のアカウントをインストールするためのアカウント設定を導入しました。
        これらは通常、組織のアカウントであり、ユーザーは組織のデータにアクセスできるようになります。
        アカウントがいつ正常にインストールされたか、またどのような状態であるかを管理者が知ることは、問題を抱えている可能性のあるユーザーをサポートするのに役立ちます。
        このリリースでは、メール、カレンダー、およびその他のアカウントタイプについて、8つのアカウントステータス項目が追加されています。
        ステータスは、設定によってインストールされたアカウントに対してのみ報告され、手動で作成されたアカウントやMDMプロファイルを介してインストールされたアカウントは含まれないことに注意してください。
        それぞれの新しいステータス項目は、アカウント構成タイプに対応し、受信および送信メールアカウントのステータスは別々に報告されます。
        新しいステータス項目は、それぞれ異なるタイプの JSON オブジェクトを使用して、対応するアカウントタイプのステータスを表現します。
        以下は、メール受信のステータス項目とカレンダー購読のステータス項目の例です。
        識別子キーの値は、ステータスアイテムオブジェクトの配列内でオブジェクトを一意に識別するもので、これについては後ほど詳しく説明します。
        宣言識別子キーの値は、 アカウントをインストールした構成の識別子プロパティの値と一致するため、 ステータス項目オブジェクトとそれに関連する構成を簡単に相互参照できます。
        この2つのキーは、すべてのタイプのアカウントステータスアイテムオブジェクトに常に存在する。
        その他のキーは、アカウントの種類に固有のものである。
        たとえば、メールサーバのホスト名とポート、購読しているカレンダのcalendar-URLなどです。
        このリリースでは、同じタイプの1つ以上のアカウントのレポートをサポートするために、値が配列であるステータス項目を導入しています。
        このような配列の値には、特別な動作があります。
        配列の各項目は JSON オブジェクトで、 ひとつの配列内のすべてのオブジェクトに対して同じスキーマが使用されます。
        各オブジェクトの型は常に識別キーを持っており、 配列内のオブジェクトを見つけるための主キーとして働きます。
        他のキーも存在し、報告されるステータスの基本的な種類に関連付けられます。
        将来の OS リリースで追加されるキーとの互換性を確保するため、 サーバーは配列オブジェクトに未知のキーを含めるようにしなければなりません。
        配列の値の変更は、パフォーマンス上の理由から、常にオブジェクト単位でサーバーに増分的に報告されます。
        この新機能がどのように機能するかを示す例を実行しましょう。
        この例では、サーバーが2つのメールアカウント設定をデバイスに送信しています。
        これらは両方ともアクティブで、デバイス上に存在する2つのメールアカウントになります。
        サーバーは、メールアカウントステータス項目に対するステータス購読を送信します。
        購読がアクティブになると、アカウントのステータスが収集され、デバイスはサーバーにステータスレポートを送信する。
        ステータスレポートには、ステータス配列の2つのアカウントステータスオブジェクトが含まれ、サーバーは現在デバイス上に存在するものの全体像を把握することができるようになります。
        配列の各オブジェクトには、それぞれ異なる識別子が設定されています。
        このレポートを処理した後、サーバーはデバイス上にあるものと一致する2つのメールアカウントのステータスを持つことになります。
        サーバーが新しい構成を送信することによってデバイス上にメールアカウントを追加すると、デバイス上のステータスアイテムはその配列値に新しいオブジェクトが追加され、別のステータスレポートがサーバーに送信されます。
        報告されるのは新しい項目だけである。
        識別子キーの値はサーバーが既に持っているものと一致しないので、サーバーはこれが新しいアカウントに対応すると推測できます。
        このレポートが処理された後、サーバーは3つのメールアカウント（2つの初期アカウントと新しいアカウント）のステータスを持ち、これもデバイスにあるものと完全に一致する。
        ユーザーがメールやメモの有効状態を切り替えた場合など、アカウントの状態が変化した場合、デバイス上の状態項目はその配列値に更新されたオブジェクトを持ち、再び、状態レポートがサーバーに送信されます。
        変更された項目のみが報告されます。
        この場合、ユーザーはそのアカウントのノート機能をオフにしました。
        識別子キーの値はサーバーが既に持っているものと一致するので、サーバーはこれが既存のアカウントに対する更新であると推測することができます。
        その結果、既存のステータス項目配列オブジェクトを新しいものに置き換えます。
        このレポートを処理した後、サーバーは3つのメールアカウントのステータスを持ちますが、1つは変更されています。
        アカウント構成がデバイスから削除されると、デバイス上のステータス項目は対応するオブジェクトが削除のためにマークされ、別のステータスレポートがサーバーに送信される。
        削除された項目のみが報告される。
        そのキーとは、サーバーがすでに持っている値と一致する identifier キーと、 値が true に設定されている removed キーです。
        これにより、サーバーは既存のアイテムを削除して、デバイスの状態を更新することができます。
        このレポートを処理した後、サーバーには2つのメールアカウントのステータスがあり、デバイスの状態と正しく一致しています。
        ステータスレポートに関する最後のポイント。
        デバイスは、パフォーマンスの問題を避けるために、ステータスレポートの送信レートを制限する。
        デバイスは、サーバーにステータスレポートを送信する前に、最大1分間の可変間隔でステータスアイテムの変更を集約します。
        これは、ステータスが迅速に報告されることを意味しますが、即時性ではありません。
        次に、MDMの長年のボトルネックである「アプリケーションのインストール状況の監視」を解決する方法を考えてみましょう。
        MDMサーバーは、ユーザーが仕事や教育に必要なツールにアクセスできるように、デバイスにアプリケーションをインストールすることがよくあります。
        サーバー側のロジックは、アプリが正常にインストールされたかどうかで決定されることがよくあります。
        そのため、MDMサーバーは、アプリのインストール状況を監視し、ユーザーがデバイス上の管理対象アプリを削除する可能性を監視する必要があります。
        現在、MDM サーバーは InstalledApplicationList または ManagedApplicationList コマンドを使用してデバイスをポーリングし、アプリのインストール進捗を監視することができます。
        デバイスからサーバーにアプリのインストール状況をプロアクティブに送信することで、ポーリングを回避することができます。
        そのためのツールが、宣言型デバイス管理ステータスレポートです。
        このリリースでは、mdm.app ステータス項目が追加されました。
        その値は、MDMサーバーによってインストールされたアプリをそれぞれ表すオブジェクトの配列です。
        この値は配列であるため、前述の手順を使用して、増分的に報告されます。
        監視下のデバイスであっても、MDMによってインストールされたアプリのみがここで報告されることに注意してください。
        このステータスレポートには、インストールが完了したアプリのステータス項目が含まれます。
        identifierキーは、配列アイテムオブジェクトの一意な識別子で、この場合はアプリのバンドル識別子です。
        name キーは、アプリの名前を表します。
        3 つのバージョンキーは、通常バージョン、ショートバージョン、外部バージョンの識別子を提供します。
        そして state キーは、アプリの現在のインストール段階を示す列挙型です。
        これらのキーの値は、MDM ManagedApplicationListコマンドレスポンス内の同等の項目に対応しています。
        これらすべての情報により、サーバーは報告されるアプリとその状態を即座に特定することができます。
        アプリがインストールされる際のデータの流れの例を見てみましょう。
        右側には、MDM サーバーで管理されている iOS 16 デバイスがあります。
        サーバーは、すでに宣言的デバイス管理を有効にしており、MDMインストールされたアプリのステータス項目に対するステータスサブスクリプションを送信しています。
        サーバーの次のステップは、MDM InstallApplication コマンドを使用してアプリをインストールすることです。
        これはユーザー登録であるため、アプリのインストールにはユーザーの承認が必要であり、デバイスがアプリインストールコマンドを処理する際にプロンプトが表示されます。
        この時点で、インストールの進行は一時停止され、ユーザーの入力を待ちます。
        デバイスからサーバーに送信されるステータスレポートには、アプリのバンドル ID とプロンプト状態の MDM インストール済みアプリのステータスオブジェクトが 1 つ含まれます。
        ある時点で、ユーザーが［インストール］ボタンをタップすると、デバイス上でアプリのインストールが開始されます。
        インストールが進むと、今度はアプリの状態が「installing」に設定された別のステータス レポートが送信され、アプリがダウンロードおよびインストールされていることが示されます。
        最終的に、アプリはインストールを完了し、使用できるようになります。
        この時点で、アプリの状態がmanagedに設定され、アプリが適切にインストールおよび管理されていることを示す別のステータスレポートが送信されます。
        ここで、ユーザーがデバイス上のアプリを手動で削除したとします。
        この場合も、ステータスレポートが送信され、アプリの状態はmanaged-but-uninstalledに設定されます。
        これは、アプリがインストールされていないことを示しますが、アプリの管理状態はまだデバイス上で追跡されています。
        サーバーは、アプリの管理状態を削除することを望んでいるとします。
        この場合、サーバーはRemoveApplicationコマンドをデバイスに送信することで、アプリの管理状態を削除します。
        これにより、内部で維持されている管理状態が削除され、アプリがまだ存在する場合は、それも削除されます。
        また、アプリのステータス配列からアプリオブジェクトが削除された状態で、ステータスレポートが送信されます。
        これは、アプリインストールの応答性と信頼性を向上させるための新しい MDM ステータス項目の威力を示すもので、わずか数ステップで実装できます。
        さて、3つ目の重点項目である述語について見てみましょう。
        アクティベーションの述語について簡単に説明します。
        アクティベーションには、アクティベーションで参照される設定がデバイスに適用されるかどうかを決定する、オプションの述語を含めることができます。
        述語はステータス項目を参照し、その値をテストすることができます。
        述語で参照されるステータス項目が変更されると、デバイスはすべてのアクティベーションを再処理し、述語を再評価します。
        述語は、Apple Developerサイトに記載されているNSPredicate構文を使用した文字列として指定します。
        より複雑な述語表現に対応するため、述語の構文を拡張し、表現内のステータスアイテムの検出を容易にしました。
        新しい構文は、述語文字列の@status項内にステータス項目名を配置します。
        この例では、シリアル番号のステータス項目が、新しい構文を使って述語式に表示されています。
        以前の構文も後方互換性のために動作し続けますが、現在では非推奨となっていますので、新しい構文に切り替えてください。
        では、述語がどのようにステータス項目の配列値で使われるかを見てみましょう。
        先ほど説明したように、アカウントとMDMインストール済みアプリのステータス項目は配列であるステータス項目値を持っています。
        この配列の中のある項目に対して、アクティベーションを述語で指定できると便利です。
        例えば、特定のバンドル識別子を持つアプリがデバイスにインストールされ、管理されたときにアクティベーションがトリガーされるようにしたいかもしれません。
        NSPredicateには、配列の操作に使用できるSUBQUERY項があります。
        このNSPredicate式は、MDMインストールされたアプリのステータス項目をターゲットとするSUBQUERYを使用しています。
        ステータス項目は、SUBQUERYの最初の引数として使用されます。
        第2引数は、配列の各要素を参照する変数を定義します。
        第3引数は、その変数で特定される各要素をテストする述語式である。
        SUBQUERY式は、第3引数の述語にマッチする要素の配列を返します。
        その後、@count演算子でその配列の長さを返し、その長さをチェックして、結果的にマッチする要素が1つであるかどうかを判断します。
        指定されたアプリがインストールされ管理されている場合、このSUBQUERY式は1つの要素を持つ配列を返し、述語はtrueと評価されます。
        アプリがインストールされていない場合、SUBQUERY式は空の配列を返し、述語はfalseに評価されます。
        ステータス項目配列オブジェクトのキーを参照するには、キーパスが適切に処理されるように、@key 拡張項を使用する必要があることに注意してください。
        新しい述語の構文は拡張可能です。
        サーバーは、述語の評価をより直接的に制御できる必要があります。そうすれば、複雑なサーバー側のロジックは、デバイス上の単純な状態変化に変換され、それらの変化を引き起こすために大規模な設定セットを同期させる必要がなくなります。
        例えば、複数の役割を持つユーザーがいて、ユーザーに配るデバイスを効率的にジャストインタイムで割り当てたい組織や、交換用のデバイスを迅速に配布したり、組織のデータを保護するためにデバイスを迅速にセーフモードにする必要がある組織などが挙げられます。
        これをサポートするために、サーバーがデバイスに任意のプロパティを設定し、アクティベーション述語で直接使用できるようにする新しい宣言を追加することをお知らせします。
        これが新しい管理プロパティ宣言です。
        この宣言は、サーバーが定義するキー名を持つJSONオブジェクトで構成されます。
        JSONオブジェクトの値には、配列やオブジェクトなど、任意のJSON値型を使用することができます。
        ここでの管理プロパティ宣言では、文字列と整数値を持つnameプロパティとageプロパティ、そして文字列の配列であるrolesプロパティの3つのプロパティを含んでいます。
        これは、いくつかの管理プロパティを参照する述語を持つ活性化です。
        まず、ageプロパティをテストして、その整数値が18以上であるかどうかを判断し、次にrolesプロパティをテストして、プロパティ配列の値にGrade12という文字列があるかどうかを判断しています。
        各プロパティは、@property 拡張項を使用し、その項の中にプロパティキー名を入れて参照します。
        複数の管理プロパティ宣言をデバイスに送信することができますが、キーはそれらすべてで一意である必要があります。
        キーが重複していると、述語でプロパティを参照する際にいずれかの値が任意に選択され、予想外の結果を招くことになります。
        ですから、重複するキー名の使用は避けてください。
        使用例を探ってみましょう。
        この例では、ある学校を取り上げます。
        そしてもちろん、この学校には教師がいます。
        この学校には2つの部門があります。上部と下部の2つです。
        それぞれの部門は、独自のWi-Fiネットワークを持つ独自のキャンパスを持っています。
        一部の教師は、IT管理者として機能しており、共有メールアカウントへのアクセスを必要とします。
        また、スポーツのコーチとして、チームの試合日程のカレンダーを登録しなければならない先生もいます。
        このように、先生には4つの異なる役割があり、複数の役割を持つこともあります。
        それぞれの役割には、デバイスに割り当てられた教師の役割に基づいて、デバイスに適用しなければならない一連の設定があります。
        この例では、2人の先生を考えてみましょう。
        教師 1 は、Lower School で教えており、スポーツのコーチでもあります。
        2番目の教師は高等部で教えており、IT管理者でもあります。
        このようなユースケースは、従来の MDM サーバーではどのように処理されるでしょうか。通常、サーバーは、デバイスが教師に割り当てられるのを待ってから、そのデバイスを完全に設定する必要があります。
        サーバーは、教師がどのような役割を担っているかを判断しなければなりません。
        次に、各役割にどのプロファイルがリンクされているかを判断します。
        そして、各プロファイルを一度に1つずつデバイスにインストールする必要があります。
        教師が役割を変更した場合、サーバーは新しい役割に合わせてプロファイルを追加または削除しなければなりません。
        これは時間がかかる作業で、特にピーク時（私たちの場合は課題が出される登校初日）には、デバイス管理システムに大きなボトルネックをもたらす可能性があります。
        新しい管理プロパティの宣言では、これに対してより効率的な代替手段を用意しています。
        これは、前もってデバイスに宣言のフルセットをロードしておくというものです。
        設定はアクティベーションに割り当てられ、管理プロパティを介して異なる役割のためにトリガーされる述語が設定されます。
        デバイスが教師に割り当てられると、サーバーは教師のロールを含む管理プロパティ宣言のみを送信し、そのロールのためのコンフィギュレーションのアクティベーションをトリガーします。
        この方法は、サーバーとネットワークの全体的なトラフィックを最小限に抑え、デバイスの状態を迅速に変更する複雑さを軽減します。
        学校の例に戻りましょう。
        サーバーは、次の宣言セットをプリロードします。2つのアクティベーション/設定のペアは、各部門のWi-Fiネットワークをセットアップします。
        次に、IT管理者の役割のためのアクティベーションと構成のペアがあり、メールアカウントがインストールされます。
        最後に、購読カレンダーをインストールするアクティベーションとコンフィギュレーションのペアがあります。
        各アクティベーションには、ロール管理プロパティを使用して部門または関数の名前をテストする述語があります。
        未割り当てのデバイスに最初にロードされたとき、すべての述語はfalseと評価され、何も適用されません。
        さて、割り当て当日に何が起こるかを検証してみましょう。
        サーバーが行うべきことは、各教師にカスタマイズされた管理プロパティの宣言を作成することです。
        教師 1 には、「Lower」と「Sports」をリストしたロールプロパティがあります。
        Teacher two は、Upper と IT Admin をリストしたロールプロパティを持っています。
        これらの宣言が割り当てられた各デバイスに別々に送信されると、プリロードされたアクティベーションがすべて再評価されます。
        つまり、教師1のデバイスには、LowerとSportsのロールの構成が有効化されています。
        そして、教師2のデバイスには、「上層部」と「IT管理者」のロールの設定がアクティベートされています。
        たった1つの宣言で、多くのコンフィギュレーションを適用させることができるのです。
        最後に、教師がロールを変更した場合の動作を確認しましょう。
        この場合、教師2は、既存の役割に加えて、スポーツのコーチになりました。
        教師の割り当てデバイスの管理プロパティ宣言が更新され、追加の役割名が含まれるようになりました。
        デバイス上でその宣言が更新されると、すべてのアクティブ化が再評価されます。
        この場合、新しいスポーツの役割の購読カレンダー構成が適用されます。
        ここでも、トリガーとして必要なのは、1つの宣言の変更だけです。
        これは、管理プロパティ宣言が、デバイス上の構成のセットを迅速かつ容易に切り替える強力な方法を提供し、複雑なサーバー側のロジックがデバイス上の単純な状態の変化に変換できることを説明しています。
        さて、最後にまとめましょう。
        iOS 16、tvOS 16、macOS Ventura で宣言型デバイス管理の範囲を拡張し、Shared iPad を含む適用可能なすべてのタイプの MDM 登録で利用できるようにしました。
        これにより、MDM をサポートするすべての Apple デバイスで宣言型デバイス管理が完全にサポートされます。
        パスコード、アカウント、MDMインストール済みアプリの新しいステータス項目を追加しました。
        MDMインストール済みアプリのステータスは、MDMの主要なボトルネックの1つに対する素晴らしい解決策を提供します。
        最後に、述語の構文を拡張して、より使いやすくし、新しい管理プロパティ宣言を追加して、サーバーが複雑なビジネスロジックをデバイスに移動させる機会をさらに増やしました。
        今こそ、あなたの製品に宣言型デバイス管理を追加する時です。
        そして、宣言型デバイス管理を使ったデバイス管理ソリューションを再構築するために、皆様がどのようなことをされるのか、私たちは楽しみにしています。いつものように、皆様のご意見をお待ちしています。
        WWDCをお楽しみください。
        """
    }
}

