import Foundation

struct GetTheMostOutOfXcodeCloud: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Get the most out of Xcode Cloud"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6729/6729_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/110374/")!
    }

    var english: String {
        """
        Hi, my name is Adam, and I'm a Manager with the Developer Experience Team.
         And I'm Sasan, an Engineer with the Xcode Cloud Team.
         In this session, we're gonna show you how to get the most out of Xcode Cloud by reviewing an existing workflow and highlighting the brand-new Xcode Cloud Usage dashboard.
         Then, we'll take a look at how we can use what we've learned from viewing our existing projects usage, to optimize it further, and begin developing a new Watch OS App version of our project Before we get to that, let's do a quick overview of Xcode Cloud.
         At WWDC 2021, we announced Xcode Cloud, a continuous integration and delivery service built into Xcode and designed expressly for Apple developers.
         Xcode Cloud lets you adopt continuous integration and delivery, a standard software development practice that helps you develop and maintain your code, and deliver apps to testers and users.
         Xcode Cloud accelerates the development and delivery of high-quality apps by bringing together cloud-based tools that help you build apps, run automated tests in parallel, deliver apps to testers, and view.
         and manage user feedback, all while protecting user privacy.
         If you'd like to learn more about setting up Xcode Cloud for the first time, check out "Meet Xcode Cloud" from WWDC 2021, where Holly and Geoff go into more detail in setting up your first workflow.
         Now, let's take a look at an existing workflow and build for our Food Truck app in Xcode Cloud.
         This is the Xcode Cloud dashboard in App Store Connect, it gives us an overview of a recent build of our Food Truck project.
         We recently made the decision to add a companion watchOS app, so a food truck operator can accept incoming orders from their watch quickly, without having to reach for their phone every time a new order comes in.
         Before we get started building the new watchOS app in Xcode Cloud, we'd like to make sure our current workflows and project are fully optimized, getting us the build and test results we want, as quickly as possible.
         We think there may be some ways in which we can save some time and resources here.
        To better understand where we might be able to start making some of these optimizations, let's take a closer look at the build details overview.
         First, we notice that we started the build at 9:15 a.
        m.
         and that it took 14 minutes to complete and present us with results.
         We also see there is a time associated with usage, which in this case is 32 minutes.
         This is the total time it took for all the actions in our 14 minute build to complete.
         Next to the usage, you'll see an option to view the distribution of actions for this build.
        Each action is broken out, along with its respective usage, with the 32-minute total indicated at the bottom.
         This Usage distribution gives us an idea of some places we could possibly make some optimizations.
         But before we get to that, let's take a moment to look more closely at how Xcode Cloud performs these actions, and the difference between a build duration and usage.
        Each build is broken out into a series of actions depending on the setup of your workflow.
         You'll see how Xcode Cloud breaks each action out into multiple parallel actions like Analyze, Archive, Build, and Test.
         Because these actions are performed in parallel, the duration of the build is equal to the longest running action; in this case, the tests we've configured in our workflow that took 14 minutes to complete.
         Now, when calculating usage, each one of these actions, when observed in sequence, give us the total compute usage of the build???in this case, 32 minutes.
         And that's how Xcode Cloud calculates the build duration, and usage for a given build.
        Now, let's take a look at the Xcode Cloud Usage dashboard in App Store Connect! At the top is the usage overview, since the beginning of our monthly cycle for the Truck to Table Team, including a total percentage used.
         Additionally, we see total usage expressed in minutes, along with the remaining compute available on our team's current cycle.
        Beneath this, we see an area dedicated to usage trends for our team, broken out by builds created and overall usage, along with percentage increases or decreases during the last 30 days.
         If we'd like to see the usage over a different time period, we can do so by changing the time period in the top, right-hand corner of the trends section.
        A little further down the page, we see the total usage of each one of our products currently using Xcode Cloud, again, during the time period that we selected above.
         All right, let's select Food Truck so we can see its total usage breakdown.
        Here we start by seeing the same trends from our team view, but now specific to our Food Truck project.
         A little further down the page, we see the usage stats for each one of our workflows.
         At a quick glance, I can see from the Release workflow this is going to be an excellent place to start making a couple of optimizations.
         Now, I'm gonna hand it over to Sasan who, after observing some of the build details and compute usage, is gonna show us a couple of ways we can optimize our project.
         Show them how it's done, Sasan.
         Sasan: Thanks, Adam.
         Let's use the Food Truck project to cover some of the best practices when using Xcode Cloud.
         This should allow us to start iterating quickly on our new watchOS app.
         Workflows define when to start a build through the use of Start Conditions.
         It is important to configure your Start Conditions so that builds only start for changes that are intended for the Workflow.
         Let's see how we can apply this practice to the Release workflow of the Food Truck project.
         But first, I recommend checking out "Explore Xcode Cloud Workflows" for more detailed information.
        I have the same build that Adam showed us earlier open in Xcode.
         To start, let me open the Release workflow in the editor window.
        I right-click on the Workflow in the Navigation Panel and select Edit Workflow.
        In the editor window, I can see all of the configurable sections that make up a Workflow, including a section for Start Conditions.
         We've discovered that sometimes the scheduled build doesn't contain any new changes.
         To address that, let's add a new start condition for branch changes to replace the existing scheduled start condition.
         This will ensure that we don't build duplicate commits.
         I on the Plus button and select Branch Changes.
        Now to delete the scheduled start condition, I will select it and click on the trash icon.
        The Branch Changes Start Condition will run whenever a new commit is pushed to a remote branch.
         By default, the Source Branch is configured to be Any Branch.
         This means that any change made to any branch of your repo will cause this workflow to start a build.
         Since our release workflow is configured to be thorough, I want to restrict this to ensure we only start builds for our release branches.
        I click on Custom Branches, and I can immediately see that I need to specify the custom branch.
        I click on the Plus button and enter the branch name.
        The editor will allow me to choose from either the exact branch name or a prefix.
         In this case, we know we have multiple release branches so I'll select branches beginning with "release".
        Next, I want to specify which files and folders from the release branch can start a build.
         My goal is to not start builds when the docs folder is modified.
         This folder contains only our development documentation so it's safe to skip.
         For the Files and Folders option, I select Custom Conditions.
        I select the Start a Build dropdown and select Don't start a build.
        I click on the Plus button to add a new condition.
        I will specify which folder to exclude by selecting Any Folder and selecting Choose.
        Finally, this will open a file picker.
         Now I can select the docs folder and click Open.
        To finish up, I'll click Save to persist my changes.
        I have now configured the Start Condition to be more selective when starting by restricting to only branches with the release prefix and to ignore changes to the docs folder.
         Workflows also define how to run your builds through the use of pre-defined Actions.
         Actions allow you to analyze, archive, build, and test your changes.
         One important component of the test action is the selection of test destinations.
         To make sure that results are delivered fast, each destination will run in parallel once the test products are built.
        I want to make sure that I'm selecting a concise set of simulator destinations for my tests.
         In addition to speeding up my builds, this also helps reduce noise from the tests that might fail on similar devices.
        Xcode Cloud provides an alias for recommended destinations.
         These are curated lists of simulators that represent a cross section of screen sizes.
        Let's visit the Release workflow again to see how we can select a reasonable set of simulator destinations for the iOS test action.
         After selecting the Test iOS action, we can see there are a wide range of selected test destinations.
         To remove test destinations, I'll select each one and click the Minus button.
         Then I'll click on the dropdown menu of the last item and select Recommended iPhones.
        Again, I'll click Save to persist my changes.
        I now have a set of test destinations that will help provide a clear signal if we introduce a regression.
        As we discussed earlier, Xcode Cloud will run your workflow when you push new changes to your repository.
         Sometimes, you may want to skip building in CI depending on the type of change being committed.
         We've added in the ability to do just that.
         Let's take a look in Xcode.
        To skip your commit in Xcode Cloud, simply append "ci skip" to the end of the commit message.
         Now, when you push to remote, Xcode Cloud will know to ignore this event.
        Make sure you're using the exact format of the ci skip tag shown here.
        For each action, custom scripts are executed at multiple points.
         Tidying up unused dependencies and resiliently retrying API requests that are known to be unreliable will ensure builds complete fast and consistently.
         For more information on custom scripts and other advanced customizations, check out "Customize your advanced Xcode Cloud workflows".
        For testing, you should ensure that flakey and unreliable tests are corrected quickly.
         When a flakey test fails, the instinct is to immediately retry the build.
         Depending on the reliability of your test suite, this can result in many retried builds.
         Make sure to spend more time writing reliable tests.
        For more information on how to do that effectively, check out our other session "Author fast and reliable tests for Xcode Cloud".
         So far we've discussed some best practices and applied them to the Food Truck project.
         Let's see what sort of impact those changes had by comparing the build from earlier with one from our updated workflow.
         This is a build that was started after applying the best practices.
         Compared to the previous build that Adam showed us, the duration decreased by a minute but the usage reduced by four minutes.
         It looks like we've made some good improvements overall.
        Let's return to the usage dashboard to better understand the impact.
        Since it might be difficult to see the impact from a single build right away, we've applied the best practices to another one of our workflows, the Integration Workflow.
         We've been running builds for a while with best practices applied.
         We can tell that our changes were effective because usage is trending downward.
        This means we're now capable of adding more workflows and starting more builds to start development of the watchOS app.
        Using the usage dashboard, you can continue to apply the same best practices to your existing projects and workflows to get the most out of Xcode Cloud.
         For more information on how to manage Xcode Cloud for large teams, check out Deep Dive into Xcode Cloud for teams.
         We hope you enjoyed our session.
         Adam: Thank you for watching.
        """
    }

    var japanese: String {
        """
        ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ??????????????????Xcode Cloud????????????????????????????????????Sasan?????????
         ??????????????????????????????????????????????????????????????????????????????????????? Xcode Cloud Usage ????????????????????????????????????????????????Xcode Cloud ????????????????????????????????????????????????????????????????????????
         ???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????Watch OS App?????????????????????????????????????????????????????????????????????????????????????????? ???????????????Xcode Cloud?????????????????????????????????????????????
         WWDC 2021??????????????????Xcode?????????????????????Apple??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????Xcode Cloud????????????????????????
         Xcode Cloud?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         Xcode Cloud ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         Xcode Cloud????????????????????????????????????????????????????????????WWDC 2021??????Meet Xcode Cloud?????????Holly???Geoff???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ?????????Xcode Cloud???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ????????????App Store Connect ??? Xcode Cloud ??????????????????????????????????????? Food Truck ????????????????????????????????????????????????????????????????????????
         ??????????????????????????????????????? watchOS ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         Xcode Cloud ???????????? watchOS ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ???????????????????????????????????????????????????????????????????????????????????????????????????
        ????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ???????????????????????????9???15?????????????????????????????????????????????
        m.
         ??????????????????????????????????????????????????????????????????14????????????????????????????????????????????????
         ???????????????????????????????????????32????????????????????????????????????
         ????????????14?????????????????????????????????????????????????????????????????????????????????????????????????????????
         ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????
        ???????????????????????????????????????????????????????????????????????????32????????????????????????????????????????????????
         ????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ???????????????????????????Xcode Cloud ???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
        ????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         Xcode Cloud ???????????????????????? Analyze???Archive???Build???Test ????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????? 14 ??????????????????????????????
         ????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????32???????????????????????????
         ????????????Xcode Cloud ?????????????????????????????????????????????????????????????????????????????????
        ?????????App Store Connect ??? Xcode Cloud Usage ???????????????????????????????????????????????????????????????Truck to Table ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
        ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????? 30 ???????????????????????????????????????????????????????????????
         ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
        ????????????????????????????????? Xcode Cloud ???????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ???????????????Food Truck???????????????????????????????????????????????????????????????????????????
        ????????????????????????????????????????????????????????????????????????????????????????????????Food Truck?????????????????????????????????????????????
         ????????????????????????????????????????????????????????????????????????????????????????????????
         ???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ?????????Sasan??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ??????????????????????????????????????????????????????Sasan???
         Sasan: ??????????????????????????????
         Food Truck ????????????????????????????????????Xcode Cloud ?????????????????????????????? ?????????????????????????????????????????????????????????
         ??????????????????????????? watchOS ?????????????????????????????????????????????????????????????????????????????????
         ????????????????????????Start Conditions ??????????????????????????????????????????????????????????????????????????????
         Workflow ???????????????????????????????????????????????????????????????????????????Start Conditions ???????????????????????????????????????
         ???????????????????????? Food Truck ????????????????????? Release ???????????????????????????????????????????????????
         ??????????????????????????????????????????????????????????????????Explore Xcode Cloud Workflows???????????????????????????????????????????????????????????????
        Adam??????????????????????????????????????????????????????Xcode????????????????????????
         ????????????????????????????????????????????????Release??????????????????????????????????????????
        ??????????????????????????????????????????????????????????????????????????????Edit Workflow?????????????????????????????????????????????????????????
        ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ????????????????????????????????????????????????????????????????????????????????????????????????
         ???????????????????????????????????????????????????????????????????????????
        ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
        ????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ???????????????????????????????????????????????? Any Branch ??????????????????????????????
         ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
        ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
        ???????????????????????????????????????????????????????????????????????????
        ???????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ????????????????????????????????????????????????????????????????????????????????????????????????release????????????????????????????????????????????????
        ????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ??????????????????docs ????????????????????????????????????????????????????????????????????????????????????????????????
         ????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         Files and Folders????????????????????????Custom Conditions?????????????????????
        Start a Build???????????????????????????????????????Don't start a build?????????????????????
        ??????????????????????????????????????????????????????????????????????????????
        Any Folder???????????????Choose???????????????????????????????????????????????????????????????
        ????????????????????????????????????????????????????????????
         ????????????docs??????????????????????????????Open?????????????????????????????????????????????
        ????????????[??????]????????????????????????????????????????????????
        ?????????????????????????????????????????????????????????release???????????????????????????????????????????????????docs??????????????????????????????????????????????????????????????????
         ????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ????????????????????????????????????????????????????????????1???????????????????????????????????????
         ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
        ????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
        Xcode Cloud ??????????????????????????????????????????????????????????????????
         ??????????????????????????? ????????????????????????????????????????????????????????????????????????????????????
        ???????????? ??????????????????????????????????????????iOS ????????? ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         Test iOS????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ?????????????????????????????????????????????????????????????????????????????????????????????Recommended iPhones????????????????????????
        ????????????????????????????????????????????????????????????????????????????????????
        ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
        ?????????????????????????????????Xcode Cloud ?????????????????????????????????????????????????????????????????????????????????????????????????????????
         ??????????????????????????????????????????????????????CI ???????????????????????????????????????????????????????????????
         ??????????????????????????????????????????????????????????????????????????????
         Xcode ???????????????????????????
        Xcode Cloud???????????????????????????????????????????????????????????????????????????????????????ci skip?????????????????????????????????
         ?????????????????????????????????????????????????????????Xcode Cloud ???????????????????????????????????????????????????????????????
        ??????????????????????????? ci skip ?????????????????????????????????????????????????????????????????????????????????????????????
        ????????????????????????????????????????????? ???????????????????????????????????????????????????????????????
         ???????????????????????????????????????????????????????????????????????????????????????????????? API ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ?????????????????????????????????????????????????????????????????????????????????????????????????????????Customize your advanced Xcode Cloud workflows?????????????????????????????????
        ???????????????????????????flakey ??????????????????????????????????????????????????????????????????????????????????????????????????????
         ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ????????????????????????????????????????????????????????????????????????????????????????????????????????????
        ????????????????????????????????????????????????????????????????????????????????????????????????Author fast and reliable tests for Xcode Cloud???????????????????????????
         ????????????????????????????????????????????????????????????????????????????????????Food Truck??????????????????????????????????????????
         ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
         ?????????????????????????????????????????????????????????????????????????????????????????????
         Adam????????????????????????????????????????????????????????????1??????????????????????????????????????????4???????????????????????????
         ??????????????????????????????????????????????????????
        ????????????????????????????????????????????????????????????????????????????????????????????????
        1??????????????????????????????????????????????????????????????????????????????????????????????????????????????????1????????????????????????????????????????????????????????????????????????????????????????????????
         ?????????????????????????????????????????????????????????????????????????????????????????????
         ???????????????????????????????????????????????????????????????????????????????????????????????????????????????
        ????????????watchOS???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
        ????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????Xcode Cloud ???????????????????????????????????????????????????
         ????????????????????????????????? Xcode Cloud ????????????????????????????????????????????????Deep Dive into Xcode Cloud for teams ??????????????????????????????
         ???????????????????????????????????????????????????????????????????????????
         ?????????????????????????????????????????????????????????
        """
    }
}

