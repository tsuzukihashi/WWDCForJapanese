import Foundation

struct WhatsNewInManagingAppleDevices: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "What's new in managing Apple devices"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6538/6538_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10045/")!
    }

    var english: String {
        """
        Nadia Hussein: Welcome to WWDC! I'm Nadia, and my colleague Graham and I are so thrilled to tell you about all the new device management features we have for macOS Ventura and iOS and iPadOS 16.
         In the world of device management, it's our shared responsibility to enable employees to thrive in the workforce and increase student-teacher productivity.
         We're continuously developing the tools and technology to help foster this collaboration.
         And with macOS Ventura and iOS and iPadOS 16, there are many great enhancements and features, some of which we'll cover in this session.
         But first, I'd like to briefly highlight a few of the additional sessions where you can discover even more about the enterprise and education space.
         During WWDC 2021, we introduced declarative device management, a new paradigm for device management that makes devices more autonomous and proactive, while allowing servers to be lightweight and reactive.
         This year we are expanding declarative device management with new platform support and new features.
         Be sure to watch the session, "Adopt declarative device management.
        " Apple Business Essentials is one complete subscription that seamlessly brings together device management, 24/7 support, and cloud storage.
         With Apple Business Essentials, small businesses can easily manage every iPhone, iPad, Mac, and Apple TV every step of the way.
         Check out the session, "Explore Apple Business Essentials" to learn more.
         Managed device attestation is a new security feature that uses the Secure Enclave to provide strong assurances about a client device, such as its identity and software version.
         Attend the session, "Discover Managed Device Attestation" for additional information.
         In this session, we're going to discuss new capabilities with Apple Configurator; identity technologies across platforms; protocol modifications to macOS Ventura, iOS and iPadOS 16; and an exciting change to how we provide documentation.
         Let's start with Apple Configurator.
         At WWDC 2021, we announced Apple Configurator for iPhone.
         Education and enterprise customers love having this solution to take advantage of automated device enrollment for all of their Macs.
         Apple Configurator for iPhone makes it easy to add a Mac purchased outside of the normal channel to their organization in Apple School Manager or Apple Business Manager.
         In Setup Assistant on a Mac, simply hold your iPhone running Configurator over the animation.
         The Mac will then connect to the internet and add itself to your organization.
         Version 1.0.1 brought new, explicit support for taking advantage of existing network connectivity if available on the Mac.
         And we are excited to announce that with iOS and iPadOS 16, Apple Configurator for iPhone can now also add iPhone and iPad devices to your organization.
         This works just as you expect, just like adding a Mac.
         It's a great new alternative to the version of this feature in Configurator for Mac, which requires connecting each device via USB to the Mac running Configurator.
         A key difference for iOS and iPadOS is which pane in Setup Assistant you scan.
         On iOS and iPadOS, that's Wi-Fi, but on macOS, it's country or region.
         And remember, any device that requires interactive activation, such as activation lock or cellular carrier activation, must be handled manually before adding it to your organization, just like Configurator for Mac.
         Devices running iOS or iPadOS 16 can be added using the version of Apple Configurator for iPhone currently in the App Store.
         Now, lets cover identity management for business and education.
         We know identity management is important for the industry and it's a key priority for Apple as well.
         It enables our users to have a cohesive experience, while ensuring security of their data.
        Our goal for identity is for users to sign in once, and from then on, use that identity consistently across the operating system.
         We're working towards that goal, and there's a lot of technology that supports that, including the new features in macOS Ventura and iOS and iPadOS 16.
         For Federated Authentication, Apple Business Manager now integrates with Google Workspace as an Identity Provider.
         This allows users to leverage their work credentials as Managed Apple IDs for authentication to services on iOS, iPadOS, and macOS.
         And remember, use Directory Sync -- which we've formerly referred to as SCIM -- to create the user accounts as Managed Apple IDs automatically.
         Sign in with Apple can now be used at work and school with Managed Apple IDs.
         In apps that support Sign in with Apple, this will just work! If you want to control where users can sign in, you can choose to allow all apps or add apps to an explicit allow list in Apple School Manager or Apple Business Manager.
         Learn more in the session, "Discover Sign in with Apple at Work & School.
        " Another notable identity management update is OAuth support.
         In iOS and iPadOS 15, we used a simple access token authorization mechanism to allow the MDM server to verify the identity of users.
         In iOS and iPadOS 16, we are adding OAuth 2 as another authorization mechanism.
         OAuth opens the door for MDM servers to support a wide variety of identity providers already using OAuth today.
         It also improves security via its refresh token mechanism, which allows a short-lived access token to be used in conjunction with a silent refresh that won't prompt the user for credentials.
         OAuth can be used with the existing account-driven user enrollment flow, but it provides an even better user experience when combined with a cool new feature.
         We call it Enrollment Single Sign-on, or Enrollment SSO.
         It's a new, faster method for personal devices to complete an MDM enrollment and access your organization's apps and websites with a single authentication.
         This builds upon a few existing technologies.
         iOS 13 introduced extensible SSO as a new way to configure SSO for an organization's apps and websites.
         And iOS and iPadOS 15 introduced Account-Driven User Enrollment, which allows users to enroll in MDM by just entering their email address in Settings.
         To make enrollment even better, we combined these two technologies together because we know BYOD devices are an important part of your deployment.
         Users start out by entering their email address in Settings.
         They are then prompted to download an app from the App Store.
         This app, which contains an Enrollment Single Sign-on extension, provides a native UI to perform the authentication steps.
         Because this is an app-based model, you can use any authentication technology you choose.
         As a user, sign in once.
         The app will then sign in to get you through the enrollment flow without having to sign in again.
         There are four main pieces required to bring Enrollment Single Sign-on to life.
         First, the app developer updates their app to support enrollment SSO.
         Next, MDM vendors federate MDM protocol client authentication with an identity provider.
         Then administrators set up Managed Apple IDs using Apple School Manager or Apple Business Manager and finally, configure the MDM Server to return a URL to the JSON document in the authentication response headers.
         Now that we've talked about what this feature does and who needs to do what, let's dive into the details.
         When the initial authentication challenge from the server is received, there will be an HTTP header present indicating that Enrollment Single Sign-on is available and should be used.
         That header's value will be a URL that the client will use to download a JSON document.
         The JSON document contains all the details the client needs to continue the enrollment.
         The value for the iTunesStoreID key must refer to the Enrollment Single Sign-on app to be used during enrollment.
         The AssociatedDomains keys are the same keys available in ApplicationAttributes and can be configured here as well.
         Finally, the ConfigurationProfile should be a Base64EncodedProfile that contains at least one Extensible SSO payload and may contain certificate payloads if needed.
         And we'll be shipping this feature for customers in a later release of iOS and iPadOS 16.
         If you are interested in developing an app that supports this feature, you'll need to apply for a new entitlement though the Apple Developer Program.
         However, you can start developing for this now using test mode.
         This is a special version of the Enrollment Single Sign-on process that allows you to test your app before it's even offered on the App Store.
         To get started with test mode, head to the Developer section of Settings and enable Enrollment Single Sign-on test mode.
         You'll then need to configure your authentication response with the new HTTP header and the corresponding JSON document.
         Then, in VPN and Device Management, start the enrollment process.
         During the enrollment, you'll be prompted to install the Single Sign-on app.
         You can install the app using any method available from Xcode to TestFlight or even Enterprise app distribution.
         After that, return to Settings and complete the enrollment.
         To use test mode, there is a different header required in the response and a modified JSON document.
         Here's an example of the JSON document for test mode.
         You'll notice the iTunesStoreID key has been replaced by the AppIDs key and the value of this key is an array of strings containing the App IDs that can be used for enrollment.
         Everything else remains the same.
         Next, let's explore Single Sign-on extensions.
         In 2019, we added Single Sign-On extensions to iOS 13 and macOS Catalina to enable identity providers to use SSO authentication for all the apps and websites for their users.
         When using SSO extensions, the user is prompted to sign in to the extension after they've unlocked the device, which means entering credentials twice.
         If an organization also uses the built-in Kerberos extension, the user may have to sign in again.
         In many cases, these are all identical credentials.
         Well, in macOS Ventura, we're introducing Platform Single Sign-On -- or Platform SSO -- to enable users to sign in once at the login window and then automatically sign in to apps and websites.
         Platform SSO makes tokens from the login available to third-party SSO extensions and also works with the built-in Kerberos extension.
         The first login authenticates with a local account password, which also unlocks FileVault encryption on the device.
         This enables the user to login when offline or when connected to captive networks.
         From then on, their identity provider password can be used for unlock.
         Additionally, Platform SSO supports the use of a password or a Secure Enclave backed key to authenticate with the identity provider.
         And regardless of the authentication method, the SSO tokens are retrieved from the identity provider, stored in the keychain, and made available to the SSO extension.
         Kerberos TGTs can also be retrieved, imported to a credential cache, and optionally shared with the Kerberos extension.
         If the identity provider password changes, Platform SSO will validate that new password with the identity provider on unlock.
         Platform SSO is a fully integrated protocol that is built using OAuth and OpenID and does not use web views for authentication.
         Platform SSO is the modern replacement for AD binding and mobile accounts.
         Note, it does not directly use directory services, or check with the identity provider for each unlock attempt.
         Instead, the identity provider is only called when the user is attempting to use a new password at unlock or to retrieve SSO tokens.
         Platform SSO also does not prevent logging in to the Mac based on the response from the identity provider.
         For that purpose, leverage MDM or alternative strategies to disable access.
         To take advantage of this feature, the identity provider needs to implement the SSO protocol and update their SSO extension, then ensure the extensible SSO profile is updated to support the new keys on managed devices.
         Find more implementation details in the Apple Platform Deployment guide.
         To recap, we've introduced integration with Google Workspace, Enrollment SSO, OAuth support, and Platform SSO, to contribute to a simplified sign-in experience.
         Identity management is an ever-evolving technology and we are just getting started.
         macOS Ventura brings many enhancements across OS updates, enrollment, and security.
         Let's start with software updates.
         macOS Monterey introduced fundamental changes to Managed Software Updates.
         My colleague Lucy covered this in the session, "Manage software updates in your organization," where we break down OS updates into three areas: test, deploy, and enforce.
         This year, we focus on even more additions to deploy and enforce.
         Historically, all OS Update commands would return a NotNow when sent while in Power Nap mode.
         To ensure a more consistent and robust OS Update deployment process, the device will now acknowledge and respond to ScheduleOSUpdate, OSUpdateStatus, and AvailableOSUpdate commands even when the device is asleep or in Power Nap mode.
         Since we also understand that sometimes administrators want an OS update as soon as possible, we've introduced a new key called "priority" sent via the ScheduleOSUpdate command.
         Accepting a string value of High or Low, it controls the scheduling priority for downloading and preparing the requested update.
         Sending the command with a High priority will mimic as if the user had requested the update themselves in system settings.
         Note that this key is only supported for minor OS updates.
         In macOS 12.3, we added even more admin visibility into the logs and reporting with the OSUpdateStatus command.
         DeferralsRemaining indicates how many notifications are left to prompt the user to update.
         MaxDeferrals reveals the total number of times a user is allowed to defer the OS update notifications.
         NextScheduledInstall is the date that the OS will attempt to install the update next.
         And finally, PastNotifications is the exact dates and times when the notification was posted to the user.
         All of these updates to the OSUpdateStatus command will be useful for administrators to have further clarity into the compliance of their users.
         macOS Ventura and iOS and iPadOS 16 are introducing a new mechanism to ship critical security fixes to users more quickly.
         It does not modify the firmware, and the user can also remove the Rapid Security Response if necessary.
         We are introducing two restriction keys for this.
         Use allowRapidSecurity ResponseInstallation to disable this new security response mechanism, and use allowRapidSecurity ResponseRemoval to block the end user from being able to remove a Rapid Security Response.
         Now, let's cover a couple enrollment changes.
         Automated device enrollment provides a streamlined process for the device to be unboxed, activated, and enrolled in the organization's MDM solution.
         In an upcoming release, after erasing or restoring a Mac, an internet connection will be required to go through Setup Assistant for devices registered to your organization in Apple School Manager or Apple Business Manager.
         Once the Mac is set up for the first time and connected to a network, the Mac is acknowledged as owned by an organization.
         If later on, for example, MDM initiates an Erase All Content and Settings or the device is restored with Configurator, then the network -- and therefore, device enrollment -- cannot be bypassed in Setup Assistant.
         Stay tuned with the AppleSeed for IT release notes for timing.
         The profiles command line tool has been a staple for MDM deployments, migrations, and reporting in admins' tool kits for many years now, and we have an update to how it works as of macOS Ventura.
         Profiles tool will start enforcing rate limiting on macOS.
         This will only be for organization-owned enrollment types and to the show, renew, and validate commands.
         Each command has a maximum of 10 requests per day from the server, and if that number is exceeded, the results will return cached information.
         When you don't want to use one of the 10 requests, the show command has a new, optional flag to return cached information.
         Refer to the profiles manual page for more detailed information.
         In each release of macOS, we continue to improve protection capabilities for our users.
         Here are a few upcoming security changes to be aware of.
         In iOS 10.3, we introduced a change in the default TLS trust policy for certificate payloads to enhance overall protection for our users.
         In a future release, we'll be bringing it to macOS, meaning manually-installed certificate payloads will no longer be trusted for TLS purposes, unless the user grants them that trust using Keychain Access.
         Note, we will still continue full certificate trust if it's a certificate embedded in an MDM profile, but be sure to update any workflows if it involves interactive certificate installation.
         Next, "Allow accessories to connect" on macOS aims to protect our customers from close-access attacks.
         Supported on portable Macs with Apple silicon, the initial configuration is to ask the user to allow new Thunderbolt or USB accessories, even when unlocked.
         Approved accessories can connect to a locked Mac for up to three days.
         If you attach an unknown accessory to a locked Mac, you will be prompted to unlock the Mac.
         From an MDM perspective, we understand this may impact enterprise and education workflows such as bulk provisioning or test taking.
         To address this, we are leveraging the same restriction offered on iOS and iPadOS for macOS.
         The existing allowUSBRestrictedMode restriction will allow wired accessories to always connect without any limitation.
         It provides authorization to bypass the requirement of user consent.
         Also remember, this inherently makes your user's system less secure, so please only use this restriction if you have a legitimate business need to do so.
         For other restrictions and payload modifications, such as the new allowUniversalControl and UIConfigurationProfileInstallation, be sure to check out the documentation.
         Thanks for listening to the exciting changes coming to macOS Ventura.
         Now I'm going to hand it over to Graham to talk about iOS.
         Graham McLuhan: Thank you, Nadia! I'm really excited to be here today to tell you about a ton of great new device management features in iOS and iPadOS 16.
         We know managing network traffic on devices is an important way to improve the security of your data.
         There are three main ways that you can manage traffic on Apple devices: VPN, DNS Proxy, and Web Content Filter.
         For many years now, we've offered per-app VPN -- and in fact, for user-enrolled devices, this is the only type of VPN available to MDM.
         In iOS and iPadOS 16, we're expanding our per-app offerings to include DNS Proxy and Web Content Filter.
         These features will be available on all enrollment types but we think they'll be particularly useful for user enrollment since this is the first time organizations can secure their app traffic in this way for BYOD.
         Configuring these new features is a two-step process that will feel very similar to Per-App VPN.
         Let's take a quick look at how it's done.
         First you'll need to add a new key value pair to each payload.
         In the Web Content Filter payload, ContentFilterUUID.
         And for DNS Proxy, DNSProxyUUID.
         There are a few things to be aware of with these keys.
         First, the values for these keys can be any arbitrary string.
         And second, when this key is added to the payload, it can only be installed via MDM.
         Now, we need to configure the apps to use these new features.
         Using either the InstallApplication command or the Settings command, add the same UUID to the attributes of the app that will use the per-app feature.
         In this example, we included both keys, but you can just include one or the other.
         A few additional details I'd like to point out.
         First, app developers don't need to do anything new! All existing DNS Proxy and Web Content Filter apps will just work.
         Second, you can have multiple DNS Proxies but you cannot mix system-wide and per-app proxies.
         And finally, for Web Content Filters, you can have up to seven per-app filters and one system-wide filter.
         Next, I'd like to talk about managing eSIMs.
         eSIM has become the new standard for carriers around the world, and over the last few years, we've added a number of MDM features to make managing eSIM easier than ever.
         We wanted to take a moment to talk about how MDM vendors can bring all these features together to make for a better experience.
         When we talk to organizations using eSIM, some of the primary tasks they are doing are provisioning new devices, migrating devices between carriers, and supporting users with requirements such as multiple carriers or traveling and roaming.
         To accomplish these goals, they need to query data from enrolled devices and provide that data to carriers.
         And second, they need the ability to install an eSIM on a device.
         Let's begin by discussing the device query and carrier data requirements.
         The DeviceInformation query is the easiest way to collect data from a device.
         And in iOS 12, the ServiceSubscriptions key became the one stop shop for collecting all data relating to cellular on iPhone and iPad.
         A few points you may find useful when looking at these responses.
         Devices that return two items in the ServiceSubscriptions support two active cellular plans.
         If the response contains an EID, it's an eSIM.
         Newer devices like iPhone 13 and iPhone SE (3rd generation) support dual active carrier eSIM profiles so it's possible to have more than one eSIM returned in the ServiceSubscriptions response.
         Note that the EID is unique per device.
         Starting with iOS and iPadOS 16, otherDeviceInformation queries that return data which also appear in the ServiceSubscriptions response are deprecated and will no longer be returned in a future version of the operating system.
         Now that we know how to get data from the device, let's take a look at what we need to give to the carrier.
         In general, they require four pieces of data to get an eSIM set up for a device: IMEI, EID, serial number, and phone number.
         Giving your admins the ability to generate reports containing all this data will make it easier for them to get up and running with eSIM.
         Let's pull this all together and review how eSIMs get provisioned.
         First, the MDM server uses the ServiceSubscriptions query to collect the required data from the device.
         Then, the admin will send that data to the carrier.
         And finally, the carrier will provision eSIMs for the device on their eSIM server.
         We can now shift our focus to getting the eSIM installed on the device.
         The carrier will provide the customer with a server URL where devices can fetch an eSIM using the RefreshCellularPlans command.
         The MDM server will send the RefreshCellularPlans command to the device which will initiate a request to the carrier's eSIM server and check if an eSIM is available.
         If it is, it will automatically download and install it without requiring any user interaction.
         The MDM server can then use the ServiceSubscriptions query to confirm that the eSIM has successfully been installed when the query returns a nonempty phone number.
         Now let's talk about a few key points that you should keep in mind.
         eSIM installation is a one-time operation and future requests to install an eSIM on the same device require the carrier to provision a new eSIM.
         To prevent users from accidentally removing their eSIM, use the allowESIMModification restriction.
         Also note that the RefreshCellularPlans command can install an eSIM when the restriction is installed.
         And finally, MDM could also remove the eSIM when erasing a device.
         To avoid this, be sure to set the PreserveDataPlan key to True when sending an EraseDevice command.
         We hope this information provides a more complete picture on how to manage and deploy eSIM.
         Now let's talk about some updates to Shared iPad.
         Shared iPad is a great way for education and business customers to use iPad in a one-to-many environment while still giving users a personalized experience.
         This year we've made a few changes that will make Shared iPad even better.
         First, we added ManagedAppleIDDefaultDomains to the SharedDeviceConfiguration Settings command.
         With this command, you'll be able to save users time entering their Managed Apple ID using the QuickType keyboard.
         Once the user starts to enter their Managed Apple ID, a typing suggestion for your domain name will automatically appear for the user to tap.
         The Settings command will accept a list of any size but only three will be displayed to the user.
         Next, we've made some changes to the requirements for remote authentication.
         Currently, Shared iPad requires remote authentication approximately every seven days.
         In iPadOS 16, Shared iPad will only use local verification for existing users on the device.
         If admins want to enforce remote authentication, they can set the OnlineAuthenticationGracePeriod key in the SharedDeviceConfiguration Settings command.
         This key will be an integer value that represents the number of days between remote authentications; a value of zero will require all logins to be remotely authenticated.
         Both the ManagedAppleIDDefaultDomains and OnlineAuthentication GracePeriod values can be retrieved via the DeviceInformation query.
         Finally, I wanted to help provide some clarity around Shared iPad quotas.
         The SharedDeviceConfiguration command is the best way to manage quotas on Shared iPad.
         There are two relevant keys that you can use to set quotas: QuotaSize and ResidentUsers.
         Regardless of which key you choose to set, ultimately the operating system is computing a storage quota.
         Let's take a look at an example.
         This iPad has 35 gigabytes of free space for user data.
         If I send the SharedDevice ConfigurationSettings command asking the device to set ResidentUsers to three, it will compute each user's quota to 11.67 gigabytes.
         Alternatively, if I ask the device for a quota size of 10 gigabytes, each user will have a quota of 10 gigabytes.
         If we have three existing users on the device and a fourth user tries to log in, one of the existing user's data will be removed from the device to create enough space for the new user.
         In the QuotaSize example, even though there was five gigabytes of free space still available, that would not meet the requirement for the fourth user, and therefore, one user still needs to be removed.
         Let's look at one more scenario where we see how the number of users can be adjusted on the device without changing the quota.
         When we started the scenario, we had 35 gigabytes of free space.
         Well, it turns out that 25 gigabytes of the total space on the iPad was taken up by apps and books.
         After doing a little research, I realized that there's a few apps on this device that aren't being used anymore.
         Now that I've trimmed down my app library, my device has an additional 10 gigabytes of free space -- meaning when our fourth user comes to log in, it no longer requires another user to be removed.
         Also, remember that as of iOS 13.4, as long as there are no cached users on the device, quota sizes can be adjusted at any time.
         Keeping these points in mind should allow you to ensure the best possible experience for your Shared iPad deployments.
         Let's wrap up our iOS and iPadOS updates with some MDM protocol and behavior changes that you should be aware of.
         Apple devices come standard with built-in accessibility features that let people experience everything that their device has to offer.
         Traditionally, each user needed to enable accessibility settings themselves.
         But in iOS and iPadOS 16, we're adding the ability for MDM to manage many of the most popular accessibility settings.
         These features include Text Size, VoiceOver, Zoom, Touch Accommodations, Bold Text, Reduce Motion, Increase Contrast, and Reduce Transparency.
         With all these options available, we believe admins can make devices in schools, restaurants, and hospitals more accessible for all users.
         Be aware that these settings are not locked after being set and a user is free to modify them to match their own unique preferences.
         The MDM server can also query these settings with the DeviceInformation query.
         Next, starting in iOS and iPadOS 16, you'll now be able to install applications during the AwaitDeviceConfigured state during Automated Device Enrollment.
         A few things to keep in mind.
         Is it is very likely at this stage no user will be signed in to the App Store, so we recommend using device-based app licenses.
         Unsupervised devices in Setup will still return a NotNow until they reach the Home screen.
         With this feature, you can now ensure a device has everything a user needs to get started before exiting Setup Assistant.
         As we continue to improve the security of our devices, certain data types become inaccessible before first unlock.
         Because of this, the CertificateList query will start returning a NotNow before first unlock.
         Once the user unlocks the device, the query will respond as normal until the device is rebooted.
         MDM developers, please ensure that your servers are able to handle a NotNow response for this query.
         And finally, we have an exciting update for Apple TV.
         Starting in tvOS 16, when you erase an Apple TV -- either from Settings or via MDM -- the remote will now remained paired.
         Combined with Auto Advance, this ensures that your Apple TVs are always refreshed and ready to go.
         In addition to everything that we've discussed today, there are even more changes that you can check out in our documentation at developer.apple.com.
         Speaking of documentation, at a previous WWDC, we brought the MDM documentation to its new home.
         This change brought more accurate and up-to-date documentation but also gave you the ability to highlight changes in a particular OS release.
         The reception to this documentation has been amazing and today I'm excited to tell you that we are making the source code that backs this documentation publicly available under the MIT Open Source License in the new device management project on Apple's GitHub page.
         Let's take a look at what you'll find when you arrive.
         There will be two folders: one containing all of the MDM documentation and one containing the new declarative device management documentation, as well as a README file and our license information.
         Inside the MDM folder, you'll find folders for checkin, commands, and profiles.
         And for declarative management, declarations, protocol, and status.
         When you dive into these folders, you'll find YAML files for each command, profile, or declaration.
         I'd like to highlight a few items to get you familiar with these files.
         First is the payload key.
         This key shows the request type for the MDM command.
         In this example, that's ProfileList, which returns a list of all profiles installed on the device.
         Next, supportedOS key gives you platform-specific information like operating system and version support, as well as things like if it requires supervision or if it works with user enrollment.
         Here we find the ProfileList key was introduced in iOS 4.
         The payloadkeys give you information about additional features the query offers.
         Each sub-key may include an additional supportedOS key that will override the values from the payload above.
         The ProfileList query was introduced in iOS 4, but the ManagedOnly feature wasn't added until iOS 13.
         The rest of the supportedOS information remains the same, meaning supervision is not required and the query works for user enrollment.
         In the case of the ProfileList query, it returns a response to the MDM server.
         The response keys detail this information.
         In our example, we can expect an array of dictionaries that describe each profile installed.
         Inside that dictionary, you will see key value pairs including things like PayloadUUID and PayloadIdentifier.
         This is just a quick example and you will find comprehensive details about the schema and the structure of the repository in the README.
         Now let's talk about some details.
         You will find data published back to the initial release of iOS 15 and macOS Monterey.
         From there, we publish new branches for each release and seed as needed, meaning that the iOS 16 and macOS Ventura documentation is up for you to check out right now.
         We think that there are a lot of exciting use cases for this new data and we can't wait to see what new tools or integrations you come up with! As you start to work with this data, please use Feedback Assistant to let us know how it's going.
         We've covered a ton of information today, so let's take a moment to recap.
         Apple Configurator for iPhone now adds iPhone and iPad to your organization, allowing you to more easily manage and deploy devices.
         For identity, Google Workspace integration, Enrollment SSO, and Platform SSO bring a more cohesive authentication experience.
         From there, Nadia told us about how macOS Ventura gives you more information to help you manage software updates for your fleet.
         Automated Device Enrollment gets better by requiring a network connection during Setup Assistant after erasing or restoring a Mac.
         And we wrapped up with some important security changes that will impact your deployments.
         In iOS and iPadOS 16, you can now manage DNS Proxy and Web Content Filter on a per-app basis.
         We explored the tools used to manage eSIM on iPhone and iPad.
         We discussed enhancements to Shared iPad, and finally, changes to the MDM protocol including the ability to install apps during Setup Assistant.
         Last, we hope that our new machine-readable documentation enables you to build new and exciting tools and integrations.
         Thank you for joining us and I hope you have a great WWDC!

        """
    }

    var japanese: String {
        """
        ナディア・フセイン WWDCへようこそ! 私はナディアです。同僚のグラハムと私は、macOS VenturaとiOS、iPadOS 16に搭載された新しいデバイス管理機能について、皆さんにお伝えできることをとてもうれしく思っています。
         デバイス管理の世界では、従業員が職場で活躍できるようにし、生徒と教師の生産性を向上させることが私たちの共通の責任です。
         私たちは、このコラボレーションを促進するためのツールやテクノロジーを継続的に開発しています。
         そして、macOS VenturaとiOSおよびiPadOS 16では、多くの素晴らしい強化や機能があり、その一部をこのセッションで紹介します。
         しかし、その前に、企業や教育の領域についてさらに多くの発見ができる追加セッションのいくつかを簡単に紹介したいと思います。
         WWDC 2021では、デバイスをより自律的かつプロアクティブにし、サーバーを軽量かつリアクティブにするデバイス管理の新しいパラダイムであるdeclarative device managementを発表しました。
         今年は、新しいプラットフォームのサポートと新機能で、宣言型デバイス管理を拡張します。
         ぜひ、セッション「Adopt declarative device management」をご覧ください。
        " Apple Business Essentialsは、デバイス管理、24時間365日のサポート、クラウドストレージをシームレスに統合した、一つの完全なサブスクリプションです。
         Apple Business Essentialsを使えば、すべてのiPhone、iPad、Mac、Apple TVを簡単に一元管理することができます。
         詳しくはセッション「Apple Business Essentialsを探求する」をご覧ください。
         マネージドデバイス認証は、Secure Enclaveを使用して、クライアントデバイスの身元やソフトウェアのバージョンなど、デバイスに関する強力な保証を提供する新しいセキュリティ機能です。
         詳細については、セッション「Discover Managed Device Attestation」にご参加ください。
         このセッションでは、Apple Configurator の新機能、プラットフォーム間のアイデンティティ技術、macOS Ventura、iOS、iPadOS 16 のプロトコル変更、およびドキュメントの提供方法に関するエキサイティングな変更について説明します。
         まずはApple Configuratorから。
         WWDC 2021で、私たちはApple Configurator for iPhoneを発表しました。
         教育機関や企業のお客様には、すべてのMacの自動デバイス登録を活用できるこのソリューションが好評です。
         Apple Configurator for iPhoneを使えば、Apple School ManagerやApple Business Managerで、通常のチャネル以外で購入したMacを簡単に組織に追加することができます。
         Mac上のSetup Assistantで、Configuratorを起動したiPhoneをアニメーションにかざすだけです。
         するとMacがインターネットに接続され、あなたの組織に追加されます。
         バージョン1.0.1では、Mac上で既存のネットワーク接続が可能な場合、それを利用するための新しい明示的なサポートが提供されました。
         さらに、iOS および iPadOS 16 では、iPhone 用の Apple Configurator で iPhone や iPad デバイスを組織に追加できるようになりました。
         これは、Macを追加するのと同じように、期待通りに機能します。
         Configurator for Macのこの機能のバージョンでは、Configuratorを実行しているMacにUSBで各デバイスを接続する必要がありますが、それに代わる素晴らしい新機能です。
         iOSとiPadOSの主な違いは、セットアップアシスタントのどのペインをスキャンするかにあります。
         iOSとiPadOSではWi-Fiですが、macOSでは国または地域です。
         また、アクティベーションロックや携帯電話会社のアクティベーションなど、インタラクティブなアクティベーションが必要なデバイスは、Mac用のConfiguratorと同様に、組織に追加する前に手動で処理する必要があることも覚えておいてください。
         iOS または iPadOS 16 を実行しているデバイスは、現在 App Store にある Apple Configurator for iPhone のバージョンを使用して追加することができます。
         さて、ビジネスと教育のためのID管理について説明しましょう。
         ID管理は業界にとって重要であり、Appleにとっても重要な優先事項であることを私たちは知っています。
         ID管理は、ユーザーのデータの安全性を確保しながら、一貫した体験を可能にします。
        私たちが目指すアイデンティティは、ユーザーが一度サインインすれば、その後はオペレーティングシステム全体で一貫してそのアイデンティティを使えるようにすることです。
         私たちはこの目標に向かって取り組んでおり、macOS VenturaやiOS、iPadOS 16の新機能など、それをサポートする多くのテクノロジーがあります。
         Federated Authenticationについては、Apple Business ManagerがIdentity ProviderとしてGoogle Workspaceと統合されるようになりました。
         これにより、ユーザーはiOS、iPadOS、macOS上のサービスに対する認証のために、仕事の資格情報をManaged Apple IDとして活用することができます。
         そして、Directory Sync（以前はSCIMと呼んでいました）を使って、Managed Apple IDとしてのユーザーアカウントを自動的に作成することを忘れないでください。
         職場や学校でもManaged Apple IDでSign in with Appleが利用できるようになりました。
         サインイン・ウィズ・アップルに対応しているアプリでは、このまま使えます。ユーザーがサインインできる場所を制御したい場合は、Apple School ManagerまたはApple Business Managerで、すべてのアプリケーションを許可するか、明示的な許可リストにアプリケーションを追加するかを選択できます。
         詳しくは、セッション「職場と学校でAppleとサインインする」をご覧ください。
        " もう一つの注目すべきID管理のアップデートは、OAuthのサポートです。
         iOS and iPadOS 15では、MDMサーバーがユーザーの身元を確認できるように、シンプルなアクセストークンの認証メカニズムを使用しました。
         iOS and iPadOS 16では、もうひとつの認証メカニズムとしてOAuth 2を追加しています。
         OAuthは、現在すでにOAuthを使用しているさまざまなIDプロバイダーを、MDMサーバーがサポートできるようにするための扉を開くものです。
         また、リフレッシュトークンの仕組みにより、短時間のアクセストークンを、ユーザーに認証情報を求めないサイレントリフレッシュと組み合わせて使用できるようになり、セキュリティも向上します。
         OAuthは、既存のアカウント駆動型のユーザー登録フローでも使用できますが、クールな新機能と組み合わせることで、さらに優れたユーザーエクスペリエンスを提供します。
         これをEnrollment Single Sign-on（エンロールメント・シングルサインオン）、またはEnrollment SSOと呼んでいます。
         これは、個人所有のデバイスがMDM登録を完了し、1回の認証で組織のアプリやウェブサイトにアクセスするための、より高速な新しい方法です。
         これは、いくつかの既存技術を基に構築されています。
         iOS 13では、組織のアプリケーションやウェブサイトにSSOを設定する新しい方法として、extensible SSOが導入されました。
         また、iOSとiPadOS 15では、ユーザーが「設定」でメールアドレスを入力するだけでMDMに登録できる「アカウント駆動型ユーザー登録」が導入されました。
         BYODデバイスが導入の重要な一部分であることを考慮し、登録をより良くするために、この2つのテクノロジーを組み合わせました。
         ユーザーは、まず設定にメールアドレスを入力します。
         その後、App Storeからアプリをダウンロードするよう促されます。
         このアプリにはEnrollment Single Sign-onエクステンションが含まれており、認証手順を実行するためのネイティブUIが提供されます。
         これはアプリベースのモデルであるため、選択した任意の認証技術を使用することができます。
         ユーザーとして、一度サインインします。
         その後、アプリがサインインすることで、再度サインインすることなく、登録のフローに入ることができます。
         Enrollment Single Sign-onを実現するためには、主に4つの要素が必要です。
         まず、アプリ開発者がアプリをアップデートし、エンロールメントSSOをサポートします。
         次に、MDMベンダーは、MDMプロトコルのクライアント認証をIDプロバイダーとフェデレートします。
         次に、管理者は Apple School Manager または Apple Business Manager を使用して Managed Apple ID を設定し、最後に MDM Server が認証応答ヘッダで JSON ドキュメントへの URL を返すように設定します。
         さて、この機能が何をするのか、誰が何をする必要があるのかを説明したところで、詳細を見ていきましょう。
         サーバーからの最初の認証チャレンジを受信すると、Enrollment Single Sign-onが使用可能であることを示すHTTPヘッダーが表示されます。
         このヘッダーの値は、クライアントがJSONドキュメントをダウンロードするために使用するURLとなる。
         JSONドキュメントには、クライアントが登録を継続するために必要なすべての詳細情報が含まれています。
         iTunesStoreIDキーの値は、登録時に使用される登録用シングルサインオンアプリを参照する必要があります。
         AssociatedDomainsキーは、ApplicationAttributesで利用可能なキーと同じであり、ここでも同様に設定することができる。
         最後に、ConfigurationProfile は Base64EncodedProfile である必要があり、少なくとも 1 つの Extensible SSO ペイロードを含み、必要であれば証明書ペイロードを含むことができる。
         そして、この機能は、iOSとiPadOS 16の後のリリースで、お客様向けに出荷される予定です。
         この機能をサポートするアプリの開発に興味がある場合は、Apple Developer Programで新しいエンタイトルメントを申請する必要があります。
         しかし、テストモードを使えば、今すぐにでも開発を始めることができます。
         これは、登録型シングルサインオンプロセスの特別バージョンで、App Storeで提供される前にアプリケーションをテストすることができます。
         テストモードを開始するには、設定の開発者セクションに移動し、Enrollment Single Sign-onのテストモードを有効にします。
         その後、新しいHTTPヘッダーと対応するJSONドキュメントを使用して、認証レスポンスを構成する必要があります。
         その後、VPNとデバイス管理で、登録プロセスを開始します。
         登録中に、シングルサインオンアプリをインストールするよう促されます。
         XcodeからTestFlight、あるいはEnterpriseアプリの配布まで、利用可能な任意の方法を使用してアプリをインストールすることができます。
         その後、Settingsに戻り、登録を完了します。
         テストモードを使用するには、レスポンスに別のヘッダーが必要で、JSONドキュメントも変更されます。
         以下は、テストモード用のJSONドキュメントの例です。
         iTunesStoreIDのキーがAppIDsのキーに置き換えられ、このキーの値が登録に使用できるアプリIDを含む文字列の配列であることがわかります。
         それ以外はすべて同じです。
         次に、Single Sign-onエクステンションについて説明します。
         2019年、私たちはiOS 13とmacOS Catalinaにシングルサインオン拡張機能を追加し、IDプロバイダーがユーザーのすべてのアプリとWebサイトにSSO認証を使用できるようにしました。
         SSOエクステンションを使用する場合、ユーザーはデバイスのロックを解除した後にエクステンションにサインインするよう促されるため、認証情報を2度入力することになります。
         組織が組み込みのKerberos拡張も使用している場合、ユーザーは再度サインインする必要があるかもしれません。
         多くの場合、これらはすべて同一の認証情報です。
         さて、macOS Venturaでは、Platform Single Sign-On、つまりPlatform SSOを導入し、ユーザーがログイン画面で一度サインインすれば、あとは自動的にアプリケーションやWebサイトにサインインできるようにします。
         Platform SSOは、ログイン時のトークンをサードパーティのSSOエクステンションで利用できるようにするほか、内蔵のKerberosエクステンションとも連動させることができます。
         最初のログインでは、ローカルアカウントのパスワードで認証され、デバイス上のFileVault暗号化も解除されます。
         これにより、ユーザーはオフライン時やキャプティブネットワークに接続しているときでもログインできるようになります。
         それ以降は、IDプロバイダーのパスワードをロック解除に使用できます。
         さらに、Platform SSOでは、IDプロバイダとの認証にパスワードまたはSecure Enclaveでバックアップされたキーを使用することができます。
         そして、認証方法にかかわらず、SSOトークンはIDプロバイダーから取得され、キーチェーンに格納され、SSO拡張で利用できるようになる。
         Kerberos TGTも取得され、クレデンシャルキャッシュにインポートされ、オプションでKerberos拡張と共有することができる。
         IDプロバイダのパスワードが変更された場合、Platform SSOはロック解除時にその新しいパスワードをIDプロバイダと検証します。
         Platform SSOは、OAuthとOpenIDを使用して構築され、認証にWebビューを使用しない、完全に統合されたプロトコルです。
         Platform SSOは、ADバインディングやモバイルアカウントに代わる現代的なものです。
         注意点としては、ディレクトリサービスを直接使用したり、ロック解除を試みるたびにIDプロバイダに確認したりすることはないことです。
         その代わり、IDプロバイダーが呼び出されるのは、ユーザーがロック解除時に新しいパスワードを使おうとしたときや、SSOトークンを取得したときだけです。
         Platform SSOはまた、IDプロバイダーからの応答に基づいてMacにログインすることを防ぐことはできません。
         このため、MDMまたは別の戦略を活用してアクセスを無効にします。
         この機能を利用するには、IDプロバイダがSSOプロトコルを実装してSSO拡張機能を更新し、管理対象デバイスの新しいキーをサポートするように拡張可能なSSOプロファイルが更新されていることを確認する必要があります。
         実装の詳細については、Apple Platform Deployment ガイドを参照してください。
         Google Workspaceとの統合、Enrollment SSO、OAuthサポート、Platform SSOを導入し、シンプルなサインイン体験に貢献することをまとめました。
         アイデンティティ管理は進化し続けるテクノロジーであり、私たちはまだ始まったばかりです。
         macOS Venturaでは、OSのアップデート、登録、セキュリティに渡って多くの機能強化が行われています。
         まず、ソフトウェアアップデートから見ていきましょう。
         macOS Montereyでは、マネージド・ソフトウェア・アップデートに根本的な変更が加えられました。
         同僚のルーシーが「組織におけるソフトウェアアップデートの管理」というセッションで取り上げていますが、ここではOSアップデートをテスト、展開、施行の3つの領域に分類しています。
         今年は、デプロイとエンカウントのさらなる追加に焦点を当てます。
         これまで、パワーナップの状態で OS アップデートのコマンドを送信すると、すべて NotNow が返されました。
         より一貫した堅牢な OS アップデートの展開プロセスを確実にするために、デバイスがスリープまたは Power Nap モードであっても、デバイスは ScheduleOSUpdate、OSUpdateStatus および AvailableOSUpdate コマンドを認識し応答するようになりました。
         また、管理者ができるだけ早くOSアップデートを行いたい場合もあると思いますので、ScheduleOSUpdateコマンドで送信される「priority」という新しいキーが導入されました。
         HighまたはLowの文字列値を受け取り、要求されたアップデートのダウンロードと準備のスケジューリングの優先順位を制御します。
         Highの優先順位でコマンドを送信すると、ユーザーがシステム設定でアップデートを要求したかのようになります。
         このキーは、OSのマイナーなアップデートにのみ対応していることに注意してください。
         macOS 12.3では、OSUpdateStatusコマンドにより、ログとレポートに対する管理者の可視性をさらに高めました。
         DeferralsRemaining は、ユーザーにアップデートを促す通知があと何回残っているかを示します。
         MaxDeferrals は、ユーザーが OS アップデートの通知を延期できる総回数を示します。
         NextScheduledInstallは、OSが次にアップデートをインストールしようとする日付です。
         そして最後に、PastNotificationsは、ユーザーに対して通知が行われた正確な日時です。
         OSUpdateStatusコマンドへのこれらのアップデートはすべて、管理者がユーザーのコンプライアンスをさらに明確にするために役立つものです。
         macOS VenturaとiOSおよびiPadOS 16は、重要なセキュリティ修正をより迅速にユーザーに出荷するための新しい仕組みを導入しています。
         ファームウェアを変更することはなく、必要に応じてユーザーがRapid Security Responseを削除することも可能です。
         そのために2つの制限キーを導入しています。
         allowRapidSecurity ResponseInstallation は、この新しいセキュリティレスポンスの仕組みを無効にするために使用し、allowRapidSecurity ResponseRemoval は、エンドユーザが Rapid Security Response を削除することをブロックするために使用します。
         次に、登録に関するいくつかの変更点を説明します。
         自動デバイス登録は、デバイスの開封、アクティベーション、組織の MDM ソリューションへの登録を効率的に行うことができます。
         今後のリリースでは、Mac を消去または復元した後、Apple School Manager または Apple Business Manager で組織に登録されたデバイスのセットアップアシスタントを実行するために、インターネット接続が必要になる予定です。
         Mac を初めてセットアップしてネットワークに接続すると、その Mac は組織の所有物として認識されます。
         その後、たとえばMDMによって「すべてのコンテンツと設定の消去」が実行されたり、Configuratorでデバイスが復元されたりした場合、セットアップアシスタントでネットワーク、つまりデバイスの登録を回避することはできません。
         タイミングについてはAppleSeed for ITのリリースノートをご覧ください。
         プロファイルコマンドラインツールは、MDM の展開、移行、レポート作成において、長年管理者のツールキットの定番となっていますが、macOS Ventura での動作についてアップデートがあります。
         プロファイルツールは、macOS上でレートリミットを実施するようになります。
         これは、組織が所有する登録タイプと、show、renew、validateコマンドに対してのみ行われます。
         各コマンドは、サーバーからのリクエストが1日あたり最大10回で、その数を超えると、結果はキャッシュされた情報を返します。
         10回のリクエストのうち1回を使用したくない場合、showコマンドには、キャッシュされた情報を返すためのオプションのフラグが新たに追加されました。
         より詳細な情報については、profilesのマニュアルページを参照してください。
         macOSの各リリースでは、ユーザーのための保護機能を改善し続けています。
         ここでは、今後予定されているセキュリティ上の変更点をいくつかご紹介します。
         iOS 10.3では、証明書のペイロードに対するデフォルトのTLS信頼ポリシーの変更を導入し、ユーザーの保護機能を全体的に強化しました。
         つまり、手動でインストールされた証明書ペイロードは、ユーザがキーチェーンアクセスを使用して信頼を与えない限り、TLSの目的では信頼されなくなります。
         ただし、MDMプロファイルに埋め込まれた証明書であれば、証明書の完全な信頼は継続しますが、証明書のインタラクティブなインストールを伴う場合は、ワークフローを必ず更新してください。
         次に、macOSの「アクセサリの接続を許可する」は、クローズアクセス攻撃からお客様を保護することを目的としています。
         Appleシリコンを搭載したポータブルMacでサポートされ、初期設定では、ロックが解除されていても、新しいThunderboltまたはUSBアクセサリを許可するかどうかをユーザに尋ねます。
         許可されたアクセサリは、最大3日間、ロックされたMacに接続することができます。
         ロックされたMacに未知のアクセサリを取り付けた場合、Macのロックを解除するよう促されます。
         MDMの観点からは、一括プロビジョニングやテスト受験などの企業や教育機関のワークフローに影響を与える可能性があることを理解しています。
         これに対処するため、iOSとiPadOSで提供されているのと同じ制限をmacOSでも活用することにしました。
         既存のallowUSBRestrictedMode制限は、有線アクセサリーを制限なく常に接続することを可能にします。
         これは、ユーザーの同意という要件を回避するための認可を提供します。
         また、これは本質的にユーザーのシステムの安全性を低下させるので、正当なビジネスニーズがある場合にのみこの制限を使用することを忘れないでください。
         新しい allowUniversalControl や UIConfigurationProfileInstallation など、その他の制限やペイロードの変更については、必ずドキュメントを参照してください。
         macOS Venturaにもたらされるエキサイティングな変更について、ご清聴ありがとうございました。
         では、iOSについてのお話はGrahamにバトンタッチします。
         Graham McLuhanです。Nadiaさん、ありがとうございます。今日は、iOSとiPadOS 16に搭載された大量の素晴らしい新デバイス管理機能についてお話できることに、とても興奮しています。
         デバイス上のネットワークトラフィックを管理することが、データのセキュリティを向上させる重要な方法であることは、私たちも知っています。
         Appleのデバイスでトラフィックを管理する方法は、主に3つあります。VPN、DNSプロキシ、そしてWebコンテンツフィルターです。
         これまで何年にもわたって、私たちはアプリごとの VPN を提供してきました -- 実際、ユーザーが登録したデバイスでは、これが MDM で利用できる唯一のタイプの VPN です。
         iOSおよびiPadOS 16では、DNS ProxyとWeb Content Filterを含むアプリ単位のサービスを拡張しています。
         これらの機能は、すべての登録タイプで利用できますが、組織がBYODのためにこの方法でアプリのトラフィックを保護できるのは初めてなので、ユーザー登録で特に有用になると考えています。
         これらの新機能の設定は、アプリごとの VPN と非常によく似た 2 段階のプロセスで行います。
         どのように行うか、簡単に見てみましょう。
         まず、各ペイロードに新しいキー・バリュー・ペアを追加する必要があります。
         Web Content Filter のペイロードには、ContentFilterUUID を指定します。
         そして、DNS プロキシには、DNSProxyUUID を指定します。
         これらのキーには、いくつか注意すべき点があります。
         まず、これらのキーの値には、任意の文字列を指定することができる。
         そして第二に、このキーをペイロードに追加した場合、MDM経由でしかインストールできないことです。
         次に、これらの新機能を使用するようにアプリを設定する必要があります。
         InstallApplicationコマンドまたはSettingsコマンドのいずれかを使用して、アプリごとの機能を使用するアプリの属性に同じUUIDを追加します。
         この例では、両方のキーを含めていますが、どちらか一方だけを含めることもできます。
         さらに、いくつかの詳細を指摘したいと思います。
         まず、アプリ開発者は何も新しいことをする必要がありません。既存のDNSプロキシとWebコンテンツフィルターのアプリは、すべてそのまま動作します。
         次に、複数のDNSプロキシを持つことはできますが、システム全体のプロキシとアプリごとのプロキシを混在させることはできません。
         最後に、Webコンテンツフィルターについては、アプリごとのフィルターを7つまで、システム全体のフィルターを1つ持つことができます。
         次に、eSIMの管理についてお話したいと思います。
         eSIMは、世界中の通信事業者の新しい標準となっており、ここ数年、eSIMの管理をこれまで以上に簡単にするために、多くのMDM機能を追加してきました。
         私たちは、MDMベンダーがこれらの機能をどのようにまとめ、より良い体験を提供できるかについて、この場をお借りしてお話したいと思います。
         eSIMを使用している組織と話をすると、彼らが行っている主なタスクは、新しいデバイスのプロビジョニング、キャリア間のデバイスの移行、複数のキャリアや旅行、ローミングなどの要件を持つユーザーのサポートなどです。
         これらの目標を達成するためには、登録されたデバイスからデータを照会し、そのデータをキャリアに提供する必要があります。
         そしてもう一つは、デバイスにeSIMをインストールする機能が必要です。
         まず、デバイスクエリとキャリアデータの要件について説明します。
         DeviceInformationクエリは、デバイスからデータを収集する最も簡単な方法です。
         そしてiOS 12では、ServiceSubscriptionsキーが、iPhoneとiPadのセルラーに関連するすべてのデータを収集するワンストップショップとなった。
         これらの応答を見るときに役立つかもしれないいくつかのポイント。
         ServiceSubscriptionsで2つのアイテムを返すデバイスは、2つのアクティブなセルラープランをサポートしています。
         レスポンスにEIDが含まれている場合、それはeSIMです。
         iPhone 13やiPhone SE（第3世代）などの新しいデバイスは、デュアルアクティブキャリアeSIMプロファイルをサポートしているので、ServiceSubscriptionsレスポンスで複数のeSIMが返される可能性があります。
         EIDはデバイスごとにユニークであることに注意してください。
         iOSおよびiPadOS 16から、ServiceSubscriptionsレスポンスにも現れるデータを返すotherDeviceInformationクエリーは非推奨となり、将来のバージョンのオペレーティングシステムでは返されなくなりました。
         デバイスからデータを取得する方法がわかったので、キャリアに何を渡す必要があるのかを見てみましょう。
         一般的に、デバイスにeSIMをセットアップするためには、4つのデータを要求されます。IMEI、EID、シリアル番号、および電話番号です。
         管理者にこれらすべてのデータを含むレポートを作成する機能を与えることで、eSIMの立ち上げと実行を容易にすることができます。
         これをすべてまとめて、eSIMがどのようにプロビジョニングされるかを見てみましょう。
         まず、MDMサーバーはServiceSubscriptionsクエリを使用して、デバイスから必要なデータを収集する。
         次に、管理者はそのデータをキャリアに送ります。
         そして最後に、キャリアはそのeSIMサーバでデバイスのeSIMをプロビジョニングする。
         これで、デバイスにeSIMをインストールすることに焦点を移すことができます。
         キャリアは、デバイスがRefreshCellularPlansコマンドを使用してeSIMを取得できるサーバのURLを顧客に提供します。
         MDMサーバーはRefreshCellularPlansコマンドをデバイスに送信し、デバイスはキャリアのeSIMサーバーへのリクエストを開始し、eSIMが利用可能かどうかをチェックします。
         eSIMが利用可能な場合は、ユーザーの操作を必要とせず、自動的にダウンロードとインストールが行われます。
         MDMサーバーは、ServiceSubscriptionsクエリを使用して、クエリが空でない電話番号を返したときに、eSIMが正常にインストールされたことを確認することができます。
         では、覚えておくべきいくつかの重要なポイントについて説明します。
         eSIMのインストールは1回限りの操作であり、今後同じデバイスにeSIMのインストールを要求する場合は、キャリアが新しいeSIMをプロビジョニングする必要があります。
         ユーザーが誤ってeSIMを削除することを防ぐために、allowESIMModification制限を使用します。
         また、RefreshCellularPlansコマンドは、制限がインストールされているときにeSIMをインストールすることができることに注意してください。
         そして最後に、MDMはデバイスを消去するときにeSIMを削除することもできます。
         これを避けるには、EraseDeviceコマンドを送信する際に、PreserveDataPlanキーをTrueに設定することを確認してください。
         この情報により、eSIMを管理および展開する方法について、より完全な全体像が得られることを願っています。
         それでは、Shared iPad のアップデートについて説明します。
         Shared iPadは、教育機関や企業のお客様が1対多の環境でiPadを使用する際に、ユーザーにパーソナライズされた体験を提供することができる素晴らしい方法です。
         今年は、Shared iPadをより良いものにするために、いくつかの変更を加えました。
         まず、SharedDeviceConfigurationの設定コマンドにManagedAppleIDDefaultDomainsを追加しました。
         このコマンドを使えば、ユーザーがQuickTypeキーボードを使用してマネージドApple IDを入力する時間を短縮することができます。
         ユーザーがマネージドApple IDを入力し始めると、ドメイン名の入力候補が自動的に表示され、ユーザーがタップできるようになります。
         設定]コマンドは任意のサイズのリストを受け付けますが、ユーザーに表示されるのは3つだけです。
         次に、リモート認証に必要な条件を少し変更しました。
         現在、Shared iPadは、およそ7日ごとにリモート認証を要求しています。
         iPadOS 16では、Shared iPadは、デバイス上の既存のユーザーに対してのみ、ローカル認証を使用します。
         管理者がリモート認証を強制したい場合、SharedDeviceConfiguration設定コマンドでOnlineAuthenticationGracePeriodキーを設定することができます。
         このキーは、リモート認証の間隔を表す整数値で、値をゼロにすると、すべてのログインにリモート認証が必要となります。
         ManagedAppleIDDefaultDomainsとOnlineAuthentication GracePeriodの両方の値は、DeviceInformationクエリで取得することができます。
         最後に、Shared iPadのクォータについて、もう少し明確にしたいと思います。
         SharedDeviceConfigurationコマンドは、Shared iPadでクォータを管理するための最良の方法です。
         クォータを設定するために使用できる2つの関連するキーがあります。QuotaSizeとResidentUsersです。
         どちらのキーを設定するにしても、最終的にはオペレーティングシステムがストレージクォータを計算することになります。
         例を見てみましょう。
         このiPadには、ユーザーデータ用に35ギガバイトの空き容量があります。
         SharedDevice ConfigurationSettingsコマンドを送信して、ResidentUsersを3人に設定するようにデバイスに依頼すると、各ユーザーのクォータは11.67ギガバイトに計算されます。
         一方、デバイスにクォータサイズを10ギガバイトに設定するよう依頼した場合、各ユーザーのクォータは10ギガバイトになります。
         デバイスに3人の既存ユーザーがいて、4人目のユーザーがログインしようとすると、既存ユーザーのデータの1つがデバイスから削除され、新しいユーザーのための十分なスペースが作成されます。
         QuotaSizeの例では、まだ5ギガバイトの空き容量があったとしても、それは4人目のユーザーの要求を満たさないため、やはり1人のユーザーを削除する必要があります。
         もう一つのシナリオでは、クォータを変更することなく、デバイスのユーザー数を調整することができることを見てみましょう。
         このシナリオを開始したとき、35ギガバイトの空き容量がありました。
         しかし、iPadの総容量のうち25ギガバイトがアプリとブックに占拠されていることがわかりました。
         少し調べてみると、このデバイスにはもう使っていないアプリがいくつかあることに気づきました。
         つまり、4人目のユーザーがログインするときに、もう1人のユーザーを削除する必要がないのです。
         また、iOS 13.4では、デバイス上にキャッシュユーザが存在しない限り、クォータサイズはいつでも調整できることを忘れないでください。
         これらの点に留意することで、Shared iPadのデプロイメントにおいて可能な限り最高のエクスペリエンスを確保することができます。
         iOSとiPadOSのアップデートの最後に、注意すべきMDMのプロトコルと動作の変更をいくつか紹介します。
         Appleのデバイスには、そのデバイスが提供するすべてを体験できるようにするためのアクセシビリティ機能が標準装備されています。
         従来は、各ユーザーが自分でアクセシビリティの設定を有効にする必要がありました。
         しかし、iOSとiPadOS 16では、最も一般的なアクセシビリティ設定の多くをMDMで管理する機能が追加されています。
         これらの機能には、文字サイズ、VoiceOver、ズーム、タッチアコモデーション、太字、動きの抑制、コントラストの増加、透明度の低減などがあります。
         これらのオプションを利用することで、管理者は、学校、レストラン、病院のデバイスを、すべてのユーザーにとってより使いやすくすることができると考えています。
         なお、これらの設定は一度設定するとロックされないので、ユーザーは自分の好みに合わせて自由に変更することができます。
         また、MDMサーバーは、DeviceInformationクエリでこれらの設定を問い合わせることができます。
         次に、iOSとiPadOS 16から、Automated Device Enrollment中のAwaitDeviceConfiguredの状態で、アプリケーションをインストールできるようになりました。
         いくつか注意点があります。
         この段階では、ユーザーがApp Storeにサインインしていない可能性が非常に高いので、デバイスベースのアプリライセンスを使用することをお勧めします。
         セットアップ中の監視されていないデバイスは、ホーム画面に到達するまでNotNowを返します。
         この機能により、セットアップアシスタントを終了する前に、デバイスにユーザーが使い始めるために必要なものがすべて揃っていることを確認できるようになりました。
         デバイスのセキュリティを継続的に向上させるため、特定のデータタイプは最初のロック解除前にアクセス不能になります。
         このため、CertificateListクエリは、最初のロック解除の前にNotNowを返すようになります。
         ユーザーがデバイスのロックを解除すると、デバイスが再起動されるまで、クエリーは通常通り応答します。
         MDM の開発者の方は、お使いのサーバーがこのクエリの NotNow 応答を処理できることを確認してください。
         そして最後に、Apple TVのエキサイティングなアップデートをご紹介します。
         tvOS 16から、Apple TVを消去した時（設定からでもMDM経由でも）、リモコンはペアリングされたまま残るようになりました。
         Auto Advanceと組み合わせることで、あなたのApple TVが常にリフレッシュされ、使用できるようになります。
         今日ご紹介した以外にも、developer.apple.comにあるドキュメントで確認できる変更点があります。
         ドキュメントといえば、以前のWWDCで、私たちはMDMのドキュメントを新しいホームに移しました。
         この変更により、より正確で最新のドキュメントがもたらされただけでなく、特定のOSリリースの変更点を強調することができるようになりました。
         このドキュメントに対する反響は素晴らしく、今日、このドキュメントを支えるソースコードを、Apple の GitHub ページにある新しいデバイス管理プロジェクトで MIT オープンソースライセンスの下で一般公開することをお伝えできることを嬉しく思っています。
         それでは、到着したときに何が見つかるか見てみましょう。
         ひとつは MDM ドキュメント、もうひとつは新しい宣言型デバイス管理ドキュメント、そして README ファイルと私たちのライセンス情報が入っています。
         MDMのフォルダーの中には、チェックイン、コマンド、プロファイルのフォルダーがあります。
         また、宣言型管理では、宣言、プロトコル、ステータスのフォルダがあります。
         これらのフォルダに潜ると、各コマンド、プロファイル、宣言の YAML ファイルが見つかります。
         これらのファイルに慣れるために、いくつかの項目に注目したいと思います。
         最初に、ペイロードキーです。
         このキーは、MDM コマンドのリクエストタイプを示します。
         この例では、ProfileList で、デバイスにインストールされているすべてのプロファイルのリストが返されます。
         次に supportedOS キーでは、オペレーティングシステムやバージョンのサポート、監視が必要かどうか、ユーザー登録と連動するかどうかなど、プラットフォーム固有の情報を得ることができます。
         ここでは、iOS 4 で導入された ProfileList キーを確認できます。
         ペイロードキーは、クエリが提供する追加機能に関する情報を提供します。
         各サブキーは、上記のペイロードの値を上書きする追加の supportedOS キーを含むことができます。
         ProfileListクエリはiOS 4で導入されましたが、ManagedOnlyの機能はiOS 13まで追加されませんでした。
         残りの supportedOS 情報は同じままなので、監視は必要なく、クエリーはユーザー登録のために機能します。
         ProfileListクエリの場合、MDMサーバにレスポンスを返します。
         レスポンス・キーには、この情報の詳細が記載されています。
         この例では、インストールされている各プロファイルを記述したディクショナリの配列が期待できます。
         そのディクショナリーの中には、PayloadUUID や PayloadIdentifier などのキーと値のペアが含まれます。
         これは簡単な例であり、スキーマとリポジトリの構造に関する包括的な詳細は、README に記載されています。
         では、詳細について説明します。
         iOS 15とmacOS Montereyの最初のリリースまでさかのぼって公開されているデータを見つけることができます。
         そこから、リリースごとに新しいブランチを公開し、必要に応じてシードしています。つまり、iOS 16とmacOS Venturaのドキュメントが今すぐチェックできるようにアップされているのです。
         この新しいデータには多くのエキサイティングなユースケースがあると思います。このデータの使用を開始したら、フィードバックアシスタントを使用して、どのように使用されているかをお知らせください。
         今日はたくさんの情報をお伝えしましたが、少し振り返ってみましょう。
         Apple Configurator for iPhoneは、iPhoneとiPadを組織に追加し、より簡単にデバイスを管理、展開できるようになりました。
         アイデンティティについては、Google Workspaceとの統合、Enrollment SSO、Platform SSOにより、より一貫した認証体験が可能になりました。
         さらにNadiaは、macOS Venturaがどのようにソフトウェアアップデートを管理するのに役立つ情報を提供するかについて、次のように説明しました。
         デバイスの自動登録は、Macを消去または復元した後のセットアップアシスタントでネットワーク接続を要求することで、さらに改善されます。
         そして最後に、あなたの配備に影響を与える重要なセキュリティの変更について説明します。
         iOSとiPadOS 16では、DNSプロキシとWebコンテンツフィルタをアプリ単位で管理できるようになりました。
         iPhone と iPad の eSIM を管理するために使用するツールを探りました。
         Shared iPadの機能強化について説明し、最後に、セットアップアシスタント中にアプリをインストールする機能を含むMDMプロトコルの変更について説明しました。
         最後に、私たちの新しい機械読み取り可能なドキュメントによって、新しいエキサイティングなツールや統合を構築できるようになることを願っています。
         素晴らしいWWDCになることを願っています。

        """
    }
}

