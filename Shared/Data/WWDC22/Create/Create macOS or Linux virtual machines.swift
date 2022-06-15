import Foundation

struct CreateMacOSOrLinuxVirtualMachines: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Create macOS or Linux virtual machines"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6491/6491_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10002/")!
    }

    var english: String {
        """
        Benjamin Poulain: Hi everyone, and welcome to our session about virtualization.
        This is what we are going to do together today.
        We'll see how you can run macOS and Linux inside virtual machines, on Apple silicon.
        By the end of this session, you will be able to do the same on your own Mac.
        This may seem a little ambitious, but stick with us, and we'll do it together.
        Here is our agenda for today.
        We will start with an overview of virtualization technologies, and we'll see how to use Virtualization framework to build virtual machines.
        Then we'll do a deep dive into macOS.
        We'll see how we can set up a virtual Mac and install macOS into it.
        And finally, we'll do a second deep dive, this time into Linux.
        We'll see how to run full Linux distributions and some cool new features.
        Let’s get started with the overview.
        We'll first look into the stack that enables virtualization.
        It all starts with hardware.
        Apple silicon has special hardware that enables the virtualization of CPUs and memory.
        This means you can run multiple operating systems on top of a single SoC.
        Next, we need software to take advantage of this hardware.
        And this is built right into the macOS kernel.
        You no longer need to write kernel extensions, or KEXTs.
        It's all built in.
        To use those capabilities from your application, you can use Hypervisor framework.
        Hypervisor framework is a low-level API that lets you virtualize CPUs and memory.
        But, because it's a low-level framework, you need to write every single detail of the virtual environment.
        Oftentimes, we want to run full operating systems.
        For this, there is a higher-level API, which is Virtualization framework.
        Virtualization framework enables the creation of virtual machines running macOS on Apple silicon or Linux on both Apple silicon and Intel.
        Today, our session will focus on Virtualization framework.
        When using Virtualization framework, we'll deal with two kinds of objects.
        The first kind are configuration objects.
        They define all the properties of our virtual machines.
        The second kind are virtual machine objects.
        Those objects abstract virtual machines and how to interact with them.
        We'll start with looking at the configuration.
        The configuration defines the hardware.
        Creating a configuration is like configuring a Mac on the Apple Store.
        We define how many CPUs we want, how much memory, what kind of devices.
        We can start from a simple configuration.
        We can add a display, and we get to see the content.
        We can add a keyboard, and we can type.
        We can add a trackpad, and we can interact with the UI.
        Configuring a virtual machine is just like that.
        But since we are dealing with virtual machines, we'll do this in code.
        Let’s see how we can write the configuration in Swift.
        Defining the hardware is very simple.
        We start with an object of type VZVirtualMachineConfiguration.
        This is the root object of all configurations.
        Next, we define how many CPUs our machine should have.
        Here we give four CPUs.
        Then, we set how much memory we want.
        In this case, we give four gigabytes of memory.
        Finally, we define the devices our machine will have.
        In this example, we set a single storage device, the disk to boot from, and a pointing device, like a mouse.
        There are many devices available.
        The ones you set up depend on the problem you want to solve.
        Now we've seen the configuration.
        It starts with VZVirtualMachineConfiguration, on which we add the CPUs, the memory, and the devices.
        Next, we'll look into the virtual machine objects.
        After we have configured our Mac, we get it by the mail.
        It's time to unbox it and start it.
        But since we are dealing with virtual machine, we need to do that in code.
        Let’s see how we can do it in Swift.
        First, we'll create an instance of VZVirtualMachine from our configuration.
        A VZVirtualMachine abstracts an instance of the virtual hardware.
        Now that we have the virtual machine, we can operate on it.
        For example, in this case, we call start() to start it.
        We'll often want to interact with our virtual machines.
        For this, we have other objects to help us.
        For example, if we want to show our virtual display, we can use an object of type VZVirtualMachineView.
        We start by creating a view.
        Then we set our virtual machine as the virtualMachine property on the view, and it's ready.
        Now we can use this VZVirtualMachineView object like any NSView.
        We can integrate it in our app to see the content of the virtual machine.
        To wrap up, we've seen the configuration.
        The configuration starts with VZVirtualMachineConfiguration, from which we define the CPUs, memory, and our devices.
        From the configuration, we will create a virtual machine, and we will use virtual machine objects.
        We've seen VZVirtualMachine to abstract the VM itself, VZVirtualMachineView to display content, and there are other objects that can help us use the VM.
         We have seen that the configuration gives a lot of flexibility in how we define virtual machines.
         Unfortunately, there are too many features to cover in one session.
         In this session, we will look into some of the core capabilities.
         For everything else, we have documentation, and I invite you to check it out.
         In the overview, we just saw how to build virtual machines.
         Now it is time to look into how we can run a full operating system in them.
         And we will start with macOS.
         Virtualization framework supports macOS on Apple silicon.
         When we built Vvirtualization framework on Apple silicon, we've developed macOS and Virtualization framework together.
         What this gives us is incredible efficiency when running macOS inside virtual machines.
         Here is what we are going to see: First, we will look into what we need to turn a virtual machine into a virtual Mac.
         Then we'll look into the steps to install macOS on our virtual Mac.
         Next, we'll see some of the special devices we have for macOS.
         And finally, we will look into a very important use case, which is sharing files between the host system and the virtual Mac.
        Let’s start with the configuration.
         We have seen before how to build a generic virtual machine.
         Now we want to add the special properties that will make a virtual machine a Mac.
         So how do we make a virtual Mac? First, we will define a special platform.
         A platform is an object that holds all the properties of a particular type of virtual machine.
         There are three properties that are unique to the virtual Mac hardware.
         First, we have the hardware model.
         The hardware model specifies which version of the virtual Mac we want.
         Second, there is the auxiliary storage.
         The auxiliary storage is a form of non-volatile memory used by the system.
         And third, there is the machine identifier.
         The machine identifier is a unique number representing the machine, just like a physical Mac has a unique serial number.
         Once we have the platform, we have all the pieces to describe the hardware, but we need one more piece, which is a way to boot macOS.
         For this, we will use a special boot loader, the macOS boot loader.
         Let’s see how to do all of this in Swift.
         We start from the same base as before.
         This code is what we have seen in the overview.
         Then we create a VZMacPlatformConfiguration.
         This is our platform object for virtual Macs.
         We need a hardware model for this Mac.
         Here we use one we previously saved.
         In virtual machines, the auxiliary storage is backed by a file on the local filesystem.
         Here, we initialize our auxiliary storage from a file URL.
         For the unique identifier, we initialize a VZMacMachineIdentifier from one we previously saved.
         For a new install, we can also create a new identifier.
         We have set all three properties.
         Our platform is ready.
         All we have to do is set it on the configuration object.
         This gives us the hardware.
         Next we need a way to boot it.
        To do that, we set up the boot loader with VZMacBootLoader.
         Now our machine is ready to boot.
         What we have done so far is define the virtual Mac and how to start it.
         But we still need to get software on it, which brings us to the installation.
         Installing macOS is done in three steps.
         First, we need to download a restore image with the version of macOS we want to install.
         Then we need to create a configuration that is compatible with that version of macOS.
         And finally, we’ll install our restore image in the compatible virtual machine.
         So first, we need to download a restore image.
         You can download restore images from the developer website, but Virtualization can also help us.
         You can call VZMacOSRestoreImage.
        latestSupported to get a restore image object for the latest stable version of macOS.
         This object has a URL property that we can use to download the file.
         Then we want to create a virtual machine that is compatible with the version of macOS we downloaded.
         Virtualization can also help us here.
         We can ask the restore image object for the configuration requirements.
         If the restore image can be run on the current system, we get an object listing the requirements.
         From the requirements, we can obtain the hardware model needed needed to run this version of macOS.
         We have seen previously how to restore a hardware model.
         This is how we obtain a new one.
        The requirements also contain two useful properties.
         The object can tell us how many CPUs and how much memory is required to run this version of macOS.
        Finally, we are ready to start installation.
         We start by creating a new virtual machine from our configuration.
         Then we create an installer.
         The installer takes two arguments, the compatible virtual machine we created and the path to the restore image we downloaded.
         Now we can just call install(), and voilà, we are ready to run macOS.
        Now that we can set up a virtual Mac and install macOS, let’s see some of the special devices for the Mac.
         A first cool capability is GPU acceleration.
         We have built a graphic device that exposes the GPU capabilities to the virtual Mac.
         This means you can run Metal in the virtual machine, and get great graphics performance in macOS.
         Let’s see how to set it up.
        We start by creating the graphics device configuration.
         Here, we will use the VZMacGraphicsDeviceConfiguration.
         Next, we want to give it a display.
         We set up the display by defining its size and pixel density.
         Now our device configuration is ready.
         As usual, we set it on the main configuration object.
         We set it as the graphics device for our virtual machine.
        Next, we have a new device for interacting with the Mac.
         In macOS Ventura, we are adding the Mac trackpad support to the virtual Mac.
         With the new trackpad, it is possible to use gestures like rotation, pinch to zoom, and so on.
         This new device uses new drivers in macOS.
         So to use it, you will need macOS 13 both on the host system and in the virtual machine.
         Let’s see how to set it up.
         It’s very easy.
         We create a new object of type VZMacTrackpadConfiguration.
         Then we set it as the pointing device on the virtual machine.
         Now when we’ll use the view with our virtual Mac, we can use gestures.
         Finally, let’s look into a common use case for many of us, sharing files between the host system and the virtual machine.
         In macOS 12, we introduced the Virtio file-system device to share files on Linux.
         In macOS Ventura, we are adding support for macOS.
         You can now pick folders that you want to share with the virtual machine.
         Any change you make from the host system is instantly reflected within the virtual machine and vice versa.
         Let’s see how to set it up.
         First, we create a VZShareDirectory with a directory we want to share.
         Then we create a share object.
         Here we'll use VZSingleDirectoryShare to share a single directory.
         You can also share multiple directories by using VZMultipleDirectoryShare.
         Now that we have the share, we need to create a device.
         But we will start we something special.
         File system devices are identified by a tag.
         In macOS Ventura, we have added a special tag to tell the virtual machine to automount this device.
         Here, we take this special tag, macOSGuestAutomountTag.
         Then we create the device and use our special tag.
         We set the share from the single directory we configured.
         And finally, we add the device to the configuration as usual.
         Finally, let’s look at everything together in a demo.
         We start from a basic configuration.
         We have a VZVirtualMachineConfiguration with just CPU, memory, a keyboard, and a disk.
         We want a virtual Mac.
         To do that, we need to start by setting up the platform.
         We'll use createMacPlatform that is defined above to do that.
         The second piece of a virtual Mac is the boot loader.
         We need a boot loader that knows how to boot macOS.
         To get that, we set the platform's boot loader to VZMacOSBootLoader().
         Next, we want to set up the devices.
         We want accelerated graphics.
         To get it, we will set up a VZMacGraphicsConfiguration.
         We create the object, define the display size and pixel density, and we add it to the configuration.
         Next, we want to use the new trackpad.
         All we need to do is set the pointing device to VZMacTrackpadConfiguration.
         That's it.
         Now, we could start the VM, but let's add the cherry on top.
         We have seen how we can share directories.
         Let's do it here.
         We start by creating the filesystem device configuration.
         Here, notice we use the special tag to automount it into macOS.
         Then we define our share.
         Here we use a single directory share from a path on the file system.
         Here, we will share this project we are editing right now.
        We add the device to our configuration, and we are done.
        Everything is ready.
         We launch our app.
         Since we configured the Mac graphics device, the VZVirtualMachineView can show the content.
         This is what you see here in the window.
         And here it is.
         We have configured macOS from scratch.
         We can see the shared directory and the project we were editing right now.
         Finally, we will turn our eyes onto Linux.
         Virtualization framework has supported Linux since the very beginning in macOS Big Sur.
         In macOS Ventura, we have added some pretty cool new features, and we want to share some of them with you.
        First, we will see how we can install full Linux distributions, completely unmodified, in virtual machines.
         Then we will look at a new device we are adding to show UI from Linux.
         And finally, we will look at how we can take advantage of Rosetta 2 to run Linux binaries in virtual machines.
         Let’s start with installation.
         If we wanted to install Linux on a physical machine, we'd start by downloading an ISO file with the installer.
         Then we'd erase a flash drive with the ISO.
         And finally, we'd plug the drive in the computer and boot from it.
         When dealing with virtual machines, we will go through the same flow.
         But instead of using a physical USB drive, we will use a virtual one.
         Let’s see how it works.
         We start by creating an URL from the path to the ISO file we downloaded.
         Then we create a disk image attachment from the file.
         A disk image attachment represents a piece of storage that we can attach to a device.
         Next, we configure a virtual storage device.
         In this case, we want USB storage, so we use VZUSBMassStorageDeviceConfiguration.
         Finally, as always, we add our device in the main configuration.
         Here, the USB device appears next to another storage device, the main disk on which we will install Linux.
         Now we have a USB drive, but we need a way to boot from it.
        In macOS Ventura, we have added support for EFI.
         EFI is an industry standard for booting both ARM and Intel hardware.
         We are bringing the same support to virtual machines.
         EFI has a boot discovery mechanism.
         What this will allow is discovering the installer on our USB drive.
         EFI looks at each drive for one that can be booted.
         It will find the installer and start from there.
         The installer itself will tell EFI what drive to use next.
         After the installation, EFI can then start the Linux distribution.
         Let’s see how to set up EFI in code.
         First, we create a boot loader of type VZEFIBootLoader.
         EFI requires non-volatile memory to store information between boots.
         This is called the EFI variable store.
         With virtual machines, we can back such storage by a file on the filesystem.
         Here, we create a new variable store from scratch.
         Now EFI is ready.
         We just need to set it as the boot loader on the configuration.
         Next, we will look into a new capability for Linux VMs, graphics.
         In macOS Ventura, we have added support for Virtio GPU 2D.
         Virtio GPU 2D is a paravirtualized device that allows Linux to provide surfaces to the host macOS.
         Linux renders the content, gives the rendered frame to Virtualization framework, which can then display it.
         You can now show this content in your app with VZVirtualMachineView just like on macOS.
         Let’s see how to set it up.
        Setting up the device is similar to what we did for macOS.
         We start by creating a VZVirtioGraphicsDeviceConfiguration.
         We need to define the size of our virtual display.
         In Virtio terminology, a virtual display is a "scanout.
        " So we create one scanout with the size of the display.
         Finally, we set the new device as the graphics device of our configuration.
         Now our VM is ready to display content with VZVirtualMachineView.
         Next, let’s see everything together in a demo.
         We start from where we left off.
         Let's delete the code that is specific to the Mac.
         Then let's change the disk we are booting from.
         We'll swap the path from our Mac drive to our Linux drive.
         Next, we need a boot loader.
         We set up EFI with VZEFIBootLoader.
        We first create the EFI boot loader object.
         Then we load the variable store from its file.
         And finally, we set EFI as the boot loader on our configuration.
         Now we can boot, but it'd be nice to show the UI.
         Let's add Virtio GPU to our configuration.
         We simply create a graphics device of type VZVirtioGraphicsDeviceConfiguration.
         Then we define a scanout with the size of the virtual display.
         And we set the Virtio GPU as a graphics device on our configuration.
         The last touch is getting the mouse to work.
         We just use a virtual USB screen coordinate pointer device, and we'll have a mouse in Linux.
         That's it.
         We can run the project.
         EFI looks at the disk and finds it bootable.
         Then Linux shows the content of the UI through the Virtio GPU device.
         And we can use the mouse to interact with Linux.
         Last but not least, we'll see how we can take advantage of the Rosetta 2 technology inside Linux.
        For many of us, we love developing services on our Mac, but once our work is ready, the binaries we create may need to run on x86 servers.
         x86 instruction emulation has been great for this, but we can do better.
         In macOS Ventura, we are bringing the power of Rosetta 2 to Linux binaries.
        What Rosetta 2 does is translate the Linux x86-64 binaries inside your virtual machine.
         This means you can run your favorite ARM Linux distribution, and its x86-64 apps can run with Rosetta.
         And it's fast.
         It's the same technology we have been using on the Mac, which means we have incredible performance.
         Let’s see how to use it.
         First, we need to give Linux access to Rosetta.
         To do this, we use the same file sharing technology we have seen on macOS.
         Instead of sharing a folder, we use a special kind of object, a VZLinuxRosettaDirectoryShare.
         Then we create a sharing device and set up Rosetta directory share.
         Finally, we set up our device on the configuration as usual.
         Now our virtual machine is ready to use Rosetta.
         Next, let’s see how Linux can take advantage of it.
        In Linux, we start by mounting the shared directory in the file system.
         What we see from Linux is a Rosetta binary that can translate applications.
         Then we can use update-binfmts to tell the system to use Rosetta to handle any x86-64 binary.
         Don’t worry about remembering this command.
         It's all in the documentation.
         Now Linux is ready.
         Every x86-64 binary launched will be translated by Rosetta.
        Before we end our Linux section, let’s see everything together.
         Here, we have a full Linux distribution installed from scratch.
         We can show its UI with Virtio GPU 2D.
         From within the VM, we run a PHP server with Rosetta.
         And we can just connect to it from macOS host.
        We've seen that creating virtual machines has never been simpler.
         With Virtualization framework, you can get virtual machines running with just a few lines of code.
         We have also seen that virtual machines are ridiculously fast on macOS.
         To learn more about Virtualization, I invite you to check out the code samples and documentation.
         And on behalf of the team, we cannot wait to see what you will do next with this technology.
        """
    }

    var japanese: String {
        """
         Benjamin Poulainです。皆さんこんにちは、仮想化についてのセッションにようこそ。
         今日、私たちが一緒に行うのはこれです。
         Appleのシリコン上でmacOSとLinuxを仮想マシンの中で動かす方法を見ていきます。
         このセッションが終わる頃には、皆さんも自分のMacで同じことができるようになっていることでしょう。
         少し野心的かもしれませんが、私たちと一緒に頑張りましょう。
         本日のアジェンダは以下の通りです。
         まず、仮想化技術の概要を説明し、Virtualization frameworkを使用して仮想マシンを構築する方法を紹介します。
         次に、macOS について深く掘り下げます。
         仮想 Mac をセットアップして、そこに macOS をインストールする方法を見ていきます。
         最後に、2回目のディープダイブとして、今回はLinuxを取り上げます。
         Linuxのフルディストリビューションを実行する方法と、いくつかのクールな新機能を紹介します。
         それでは、概要から始めましょう。
         まず、仮想化を可能にするスタックについて見ていきます。
         すべてはハードウェアから始まります。
         Appleのシリコンは、CPUとメモリの仮想化を可能にする特別なハードウェアを持っています。
         つまり、1つのSoCの上で複数のOSを動作させることができるのです。
         次に、このハードウェアを活用するためのソフトウェアが必要です。
         そしてこれは、macOSのカーネルにそのまま組み込まれています。
         もうカーネルエクステンション、つまりKEXTを書く必要はありません。
         すべて組み込まれているのです。
         アプリケーションからこれらの機能を使うには、Hypervisorフレームワークを使います。
         ハイパーバイザーフレームワークは、CPUやメモリを仮想化するための低レベルのAPIです。
         しかし、低レベルのフレームワークなので、仮想環境の詳細をいちいち書く必要がある。
         多くの場合、完全なオペレーティング・システムを動かしたい。
         そのために、より上位のAPIであるVirtualizationフレームワークがあります。
         Virtualization frameworkを使うと、Appleのシリコン上でmacOSを動かしたり、AppleのシリコンとIntelの両方でLinuxを動かしたりする仮想マシンを作成することができます。
         本日のセッションは、Virtualization frameworkにフォーカスします。
         Virtualizationフレームワークを使う場合、2種類のオブジェクトを扱います。
         最初の種類は、コンフィギュレーション・オブジェクトです。
         このオブジェクトは、仮想マシンのすべてのプロパティを定義します。
         もう一つは、仮想マシン・オブジェクトです。
         これらのオブジェクトは、仮想マシンを抽象化し、仮想マシンと対話する方法を提供します。
         まず、コンフィギュレーションから見ていきましょう。
         コンフィギュレーションはハードウェアを定義するものです。
         構成を作成することは、Apple StoreでMacを設定するようなものです。
         CPUの数、メモリの数、デバイスの種類を定義します。
         シンプルな構成から始めることもできます。
         ディスプレイを追加すれば、コンテンツを見ることができます。
         キーボードを追加して、文字を入力することもできます。
         トラックパッドを追加すれば、UIを操作できるようになります。
         仮想マシンを設定するのも、これと同じです。
         しかし、今回は仮想マシンを扱うので、コードで行います。
         Swiftでどのように設定を書けばいいのか見てみましょう。
         ハードウェアの定義はとてもシンプルです。
         VZVirtualMachineConfiguration 型のオブジェクトから始めます。
         これはすべての構成のルートオブジェクトです。
         次に、マシンが持つべきCPUの数を定義します。
         ここでは 4 つの CPU を指定しています。
         次に、必要なメモリの量を設定します。
         ここでは、4ギガバイトのメモリを指定しています。
         最後に、マシンに搭載するデバイスを定義します。
         この例では、ストレージデバイスを1つ、起動用ディスクを1つ、マウスなどのポインティングデバイスを1つ設定します。
         デバイスはたくさんあります。
         解決したい問題によって、設定するデバイスは異なります。
         さて、設定を見てきました。
         VZVirtualMachineConfigurationから始まり、その上でCPU、メモリ、デバイスを追加しています。
         次に、仮想マシンのオブジェクトについて見ていきます。
        Macの設定が終わると、Macが郵送されてきます。
         いよいよ箱から出して起動します。
         しかし、私たちは仮想マシンを扱っているので、コードでそれを行う必要があります。
         では、Swiftでどのようにそれを行うか見てみましょう。
         まず、設定から VZVirtualMachine のインスタンスを作成します。
         VZVirtualMachine は、仮想ハードウェアのインスタンスを抽象化したものです。
         これで、仮想マシンができたので、その上で操作を行います。
         たとえば、この例では start() を呼び出して仮想マシンを起動します。
         仮想マシンと対話することもよくあります。
         そのために、他のオブジェクトが用意されています。
         例えば、仮想ディスプレイを表示したい場合、VZVirtualMachineView タイプのオブジェクトを使用します。
         まず、ビューを作成します。
         そして、仮想マシンをビューの virtualMachine プロパティとして設定し、準備完了です。
         これで、このVZVirtualMachineViewオブジェクトを他のNSViewと同様に使用することができます。
         アプリに組み込んで、仮想マシンの中身を見ることができます。
        最後に、構成を見てきました。
         構成は VZVirtualMachineConfiguration から始まり、そこから CPU、メモリ、デバイスを定義しています。
         この設定から、仮想マシンを作成し、仮想マシンオブジェクトを使用します。
         VM 自体を抽象化する VZVirtualMachine、コンテンツを表示する VZVirtualMachineView、その他 VM を使用するのに役立つオブジェクトがあることを確認しました。
         この構成により、仮想マシンをどのように定義するかについて、多くの柔軟性が得られることを見てきました。
         残念ながら、1回のセッションでカバーしきれないほど多くの機能があります。
         このセッションでは、コアとなる機能のいくつかを見ていきます。
         それ以外については、ドキュメントがありますので、ぜひご覧ください。
         概要では、仮想マシンを構築する方法について見てきました。
         今度は、その中で完全なオペレーティングシステムを実行する方法について見ていきましょう。
         まずはmacOSから。
         仮想化フレームワークは Apple シリコン上の macOS をサポートしています。
         Apple のシリコン上で Vvirtualization フレームワークを構築したとき、私たちは macOS と Virtualization フレームワークを一緒に開発しました。
         これにより、仮想マシン内でmacOSを実行する際に、驚くほどの効率化を実現することができます。
         これから見ていくのは、以下のような内容です。まず、仮想マシンを仮想Macにするために必要なものを見ていきます。
         次に、仮想MacにmacOSをインストールする手順を説明します。
         次に、macOSのための特別なデバイスをいくつか見ていきます。
         そして最後に、非常に重要な使用例である、ホストシステムと仮想Macの間でファイルを共有することについて見ていきます。
        まず、設定から始めましょう。
         一般的な仮想マシンを構築する方法については、以前に説明しました。
         今度は、仮想マシンをMacにするための特別なプロパティを追加したいと思います。
         では、どのように仮想Macを作るのでしょうか？まず、特別なプラットフォームを定義します。
         プラットフォームとは、特定の種類の仮想マシンのすべてのプロパティを保持するオブジェクトです。
         仮想Macのハードウェアに固有のプロパティは3つあります。
         まず、ハードウェア・モデルです。
         ハードウェア・モデルは、どのバージョンの仮想Macが欲しいかを指定します。
         2つ目は、補助記憶装置です。
         補助記憶装置は、システムで使用される不揮発性メモリの一形態である。
         そして3つ目は、マシン識別子です。
         マシン識別子は、物理的なMacに固有のシリアル番号があるように、マシンを表す一意の番号です。
         プラットフォームが決まれば、ハードウェアを記述するためのすべてのピースが揃いますが、もう1つ、macOSを起動するためのピースが必要です。
         そのためには、特別なブートローダであるmacOSブートローダを使用することになります。
         このすべてをSwiftで行う方法を見てみましょう。
         先ほどと同じベースからスタートします。
         このコードは、概要で見てきたものです。
         そして、VZMacPlatformConfigurationを作成します。
         これは、仮想 Mac 用のプラットフォーム・オブジェクトです。
         このMacのハードウェアモデルが必要です。
         ここでは、以前に保存したものを使用します。
         仮想マシンでは、補助記憶装置はローカルファイルシステム上のファイルによってバックアップされます。
         ここでは、ファイルのURLから補助記憶域を初期化します。
         一意な識別子には、以前保存したものからVZMacMachineIdentifierを初期化します。
         新規にインストールする場合は、新しい識別子を作成することもできます。
         3つのプロパティをすべて設定しました。
         これでプラットフォームの準備は完了です。
         あとは、コンフィギュレーションオブジェクトに設定するだけです。
         これで、ハードウェアが手に入りました。
         次に、それを起動する方法が必要です。
        そのために、VZMacBootLoaderでブートローダをセットアップします。
         これで、マシンが起動する準備ができました。
         ここまでで、仮想 Mac の定義とその起動方法ができました。
         しかし、まだソフトウェアが必要なので、インストールする必要があります。
         macOSのインストールは、3つのステップで行われます。
         まず、インストールしたいバージョンのmacOSのリストアイメージをダウンロードする必要があります。
         次に、そのバージョンのmacOSに対応した構成を作成する必要があります。
         そして最後に、互換性のある仮想マシンにリストアイメージをインストールします。
         そこでまず、リストアイメージをダウンロードする必要があります。
         リストアイメージは開発元のWebサイトからダウンロードできますが、Virtualizationでも対応可能です。
         VZMacOSRestoreImageを呼び出せばいいのです。
        latestSupported を呼び出すと、最新の安定版 macOS 用のリストア イメージ オブジェクトを取得できます。
         このオブジェクトにはURLプロパティがあり、それを使ってファイルをダウンロードすることができる。
         次に、ダウンロードしたmacOSのバージョンと互換性のある仮想マシンを作成したいと思います。
         ここでも仮想化が役に立ちます。
         リストア イメージ オブジェクトに、構成要件を問い合わせることができます。
         復元イメージを現在のシステムで実行できる場合、要件をリストしたオブジェクトが表示されます。
         この要件から、このバージョンの macOS を実行するために必要なハードウェア モデルを取得できます。
         ハードウェアモデルを復元する方法については、以前に説明しました。
         これは、新しいものを取得する方法です。
        要件には、2 つの便利なプロパティも含まれています。
         このオブジェクトは、このバージョンの macOS を実行するために必要な CPU 数とメモリ量を教えてくれます。
        最後に、インストールを開始する準備が整いました。
         まず、設定から新しい仮想マシンを作成します。
         次に、インストーラを作成します。
         インストーラは、作成した互換性のある仮想マシンと、ダウンロードした復元イメージへのパスの2つの引数を取ります。
         あとはinstall()を呼び出すだけで、macOSを起動する準備が整います。
        さて、仮想MacのセットアップとmacOSのインストールができたところで、Macの特別なデバイスを見てみましょう。
         最初のクールな機能は、GPUアクセラレーションです。
         私たちは、GPUの能力を仮想Macに公開するグラフィックデバイスを構築しました。
         つまり、仮想マシン上でMetalを実行し、macOSで素晴らしいグラフィックパフォーマンスを得ることができるのです。
         では、その設定方法を見ていきましょう。
        まず、グラフィックデバイスの設定を作成します。
         ここでは、VZMacGraphicsDeviceConfigurationを使用します。
         次に、ディスプレイを与えたいと思います。
         ディスプレイのサイズとピクセル密度を定義して、ディスプレイをセットアップします。
         これで、デバイスの設定は完了です。
         例によって、メイン構成オブジェクトに設定します。
         仮想マシンのグラフィックデバイスとして設定します。
        次に、Mac とインタラクションするための新しいデバイスを用意します。
         macOS Ventura では、仮想 Mac に Mac トラックパッドのサポートを追加しています。
         新しいトラックパッドを使用すると、回転、ピンチによるズームなどのジェスチャーを使用することができます。
         この新しいデバイスは、macOSの新しいドライバを使用します。
         したがって、これを使用するには、ホストシステムと仮想マシンの両方で macOS 13 が必要です。
         では、設定方法を見ていきましょう。
         とても簡単です。
         VZMacTrackpadConfiguration タイプの新しいオブジェクトを作成します。
         そして、それを仮想マシン上のポインティングデバイスとして設定します。
         これで、仮想Macでビューを使用するときに、ジェスチャーを使用することができます。
         最後に、多くの人がよく使う、ホストシステムと仮想マシンの間でファイルを共有するケースについて見てみましょう。
         macOS 12 では、Linux 上でファイルを共有するための Virtio ファイルシステム・デバイスを導入しました。
         macOS Ventura では、macOS のサポートを追加しています。
         仮想マシンと共有したいフォルダーを選ぶことができるようになりました。
         ホストシステムから行った変更は、即座に仮想マシン内に反映され、逆もまた然りです。
         では、設定方法を見ていきましょう。
         まず、共有したいディレクトリでVZShareDirectoryを作成します。
         そして、共有オブジェクトを作成します。
         ここでは、VZSingleDirectoryShare を使用して、1つのディレクトリを共有することにします。
         VZMultipleDirectoryShare を使用すると、複数のディレクトリを共有することもできます。
         さて、共有ができたので、デバイスを作成する必要があります。
         しかし、私たちは特別なものから始めます。
         ファイルシステムのデバイスは、タグで識別されます。
         macOS Venturaでは、このデバイスを自動マウントするよう仮想マシンに伝えるための特別なタグを追加しています。
         ここでは、この特別なタグ、macOSGuestAutomountTag を使用します。
         そして、デバイスを作成し、特別なタグを使用します。
         そして、設定した単一ディレクトリから共有を設定します。
         そして最後に、通常通りデバイスを構成に追加します。
         最後に、デモですべてを一緒に見てみましょう。
         まず、基本的な構成から始めます。
         CPU、メモリ、キーボード、ディスクだけの VZVirtualMachineConfiguration があります。
         仮想 Mac が必要です。
         そのためには、プラットフォームの設定から始める必要があります。
         そのためには、上で定義したcreateMacPlatformを使用します。
         仮想Macの2つ目の要素は、ブートローダです。
         macOS を起動する方法を知っているブートローダが必要です。
         それを得るために、プラットフォームのブートローダをVZMacOSBootLoader()に設定します。
         次に、デバイスをセットアップします。
         私たちは、加速されたグラフィックスが欲しいのです。
         そのために、VZMacGraphicsConfigurationをセットアップします。
         オブジェクトを作成し、ディスプレイサイズとピクセル密度を定義し、コンフィギュレーションに追加します。
         次に、新しいトラックパッドを使いたいと思います。
         ポインティングデバイスをVZMacTrackpadConfigurationに設定するだけです。
         これだけです。
         さて、VMを起動することができましたが、上にチェリーを追加してみましょう。
         ディレクトリを共有する方法について見てきました。
         ここでそれをやってみましょう。
         まず、ファイルシステムのデバイス構成を作成します。
         ここで、macOSに自動マウントさせるために特別なタグを使っていることに注意してください。
         次に、共有を定義します。
         ここでは、ファイルシステム上のパスから単一ディレクトリの共有を使用します。
         ここでは、今編集しているプロジェクトを共有します。
        デバイスを設定に追加して、完了です。
        これで準備は完了です。
         アプリを起動してみましょう。
         Mac のグラフィック デバイスを設定したので、VZVirtualMachineView はコンテンツを表示することができます。
         これが、このウィンドウに表示されているものです。
         そしてこちらがその状態です。
         macOSを一から設定しました。
         共有ディレクトリと、今編集していたプロジェクトが見えています。
         最後に、Linuxに目を向けます。
         仮想化フレームワークは、macOS Big Surでは当初からLinuxをサポートしていました。
         macOS Venturaでは、かなりクールな新機能が追加されましたので、そのいくつかを紹介したいと思います。
        まず、完全な Linux ディストリビューションを、完全に無修正で、仮想マシンにインストールする方法を見ていきます。
         次に、Linux から UI を表示するために追加された新しいデバイスについて見ていきます。
         そして最後に、Rosetta 2 を利用して、仮想マシン上で Linux バイナリを実行する方法について見ていきます。
         まず、インストールから始めましょう。
         物理的なマシンにLinuxをインストールしようと思ったら、まずインストーラー付きのISOファイルをダウンロードします。
         そして、ISOの入ったフラッシュドライブを消去します。
         そして最後に、そのドライブをコンピュータに接続して、そこから起動するのです。
         仮想マシンを扱う場合も、同じような流れになります。
         しかし、物理的なUSBドライブを使用するのではなく、仮想的なものを使用することにします。
         どのように動作するか見てみましょう。
         まず、ダウンロードしたISOファイルへのパスからURLを作成します。
         次に、そのファイルからディスクイメージ添付ファイルを作成します。
         ディスクイメージ・アタッチメントは、デバイスにアタッチできるストレージの一部を表しています。
         次に、仮想ストレージデバイスを設定します。
         今回は、USBストレージを使用するため、VZUSBMassStorageDeviceConfigurationを使用します。
         最後に、いつものように、メイン構成にデバイスを追加します。
         ここでは、USB デバイスが、Linux をインストールするメイン・ディスクである別のストレージ・ デバイスの隣に表示されています。
         これで USB ドライブは手に入りましたが、そこから起動する方法が必要です。
        macOS Venturaでは、EFIをサポートするようになりました。
         EFI は、ARM と Intel の両方のハードウェアをブートするための業界標準です。
         私たちは、仮想マシンにも同じサポートを導入しています。
         EFIには、ブートディスカバリーの仕組みがあります。
         これによって可能になるのは、USBドライブにあるインストーラを発見することです。
         EFIは、それぞれのドライブにブート可能なものがないか調べます。
         インストーラを見つけて、そこからスタートします。
         インストーラー自身が、次にどのドライブを使用するかをEFIに伝えます。
         インストールが終わると、EFI は Linux ディストリビューションを起動することができます。
         EFIをどのようにセットアップするか、コードで見てみましょう。
         まず、VZEFIBootLoaderというタイプのブートローダを作成します。
         EFIは、ブート間の情報を保存するために不揮発性メモリが必要です。
         これをEFI変数ストアと呼びます。
         仮想マシンでは、このようなストレージをファイルシステム上のファイルでバックアップすることができます。
         ここでは、ゼロから新しい変数ストアを作成します。
         これでEFIの準備は完了です。
         あとは、コンフィギュレーションでブートローダとして設定するだけです。
         次に、Linux VM の新しい機能であるグラフィックスについて見ていきます。
         macOS Venturaでは、Virtio GPU 2Dのサポートが追加されました。
         Virtio GPU 2D は準仮想化デバイスで、Linux がホスト macOS にサーフェスを提供することを可能にします。
         Linux はコンテンツをレンダリングし、レンダリングされたフレームを Virtualization フレームワークに渡し、Virtio フレームワークがそれを表示することができます。
         VZVirtualMachineViewを使えば、macOSと同じようにこのコンテンツをアプリで表示できるようになります。
         では、その設定方法を見ていきましょう。
        セットアップはmacOSのときと同様です。
         まず、VZVirtioGraphicsDeviceConfigurationを作成します。
         仮想ディスプレイのサイズを定義する必要があります。
         Virtio の用語では、仮想ディスプレイは "スキャンアウト "です。
        " そこで、ディスプレイのサイズで1つのスキャンアウトを作成します。
         最後に、この新しいデバイスを構成のグラフィック・デバイスとして設定します。
         これで、VM は VZVirtualMachineView を使ってコンテンツを表示する準備が整いました。
         次に、デモですべてを一緒に見てみましょう。
         前回の続きから始めます。
         Macに特化したコードを削除しましょう。
         次に、起動するディスクを変更します。
         MacのドライブからLinuxのドライブにパスを入れ替えましょう。
         次に、ブートローダが必要です。
         VZEFIBootLoaderを使ってEFIをセットアップします。
        まず、EFIブートローダオブジェクトを作成します。
         そして、そのファイルから変数ストアをロードします。
         そして最後に、EFIをブートローダとして設定します。
         これでブートできるようになりましたが、UIを表示したいところです。
         Virtio GPU を構成に追加してみましょう。
         VZVirtioGraphicsDeviceConfiguration タイプのグラフィックデバイスを作成します。
         そして、仮想ディスプレイの大きさでスキャンアウトを定義します。
         そして、Virtio GPU をグラフィックデバイスとして設定します。
         最後の仕上げは、マウスを動作させることです。
         USBの仮想画面座標のポインタデバイスを使えば、Linuxでマウスが使えるようになります。
         これで完成です。
         プロジェクトを実行することができます。
         EFIがディスクを見て、ブート可能であると判断します。
         するとLinuxはVirtio GPUデバイスを通してUIの内容を表示します。
         そして、マウスを使ってLinuxと対話することができるのです。
         最後になりますが、Linux内部のRosetta 2テクノロジーをどのように利用できるかを見ていきます。
        私たちの多くは、Macでサービスを開発するのが好きですが、作品が出来上がると、作成したバイナリをx86サーバで動作させる必要が出てくるかもしれません。
         x86命令エミュレーションは、このような場合に最適ですが、私たちは、もっと良い方法を見つけることができます。
         macOS Venturaでは、Rosetta 2のパワーをLinuxバイナリに導入しています。
        Rosetta 2が行うことは、あなたの仮想マシン内のLinux x86-64バイナリを翻訳することです。
         つまり、お気に入りのARM Linuxディストリビューションを実行し、そのx86-64アプリケーションをRosettaで実行することができるのです。
         しかも高速です。
         Macで使ってきたのと同じ技術だから、信じられないようなパフォーマンスを発揮するんだ。
         では、その使い方を見てみましょう。
         まず、LinuxがRosettaにアクセスできるようにする必要があります。
         これを行うには、macOSで見たのと同じファイル共有技術を使用します。
         フォルダを共有するのではなく、VZLinuxRosettaDirectoryShareという特殊なオブジェクトを使用します。
         次に、共有デバイスを作成し、Rosettaディレクトリ共有をセットアップします。
         最後に、通常通り構成上のデバイスをセットアップします。
         これで、仮想マシンがRosettaを使用する準備が整いました。
         次に、Linuxでどのように利用できるかを見てみましょう。
        Linuxでは、まずファイルシステムに共有ディレクトリをマウントすることから始めます。
         Linuxから見えるのは、アプリケーションを翻訳することができるRosettaバイナリです。
         そして、update-binfmtsを使って、x86-64のバイナリを扱うのにRosettaを使うようにシステムに指示します。
         このコマンドを覚えるのに心配することはありません。
         全てドキュメントに書いてあります。
         これでLinuxは準備完了です。
         起動した全てのx86-64バイナリは、Rosettaによって翻訳されます。
        Linuxのセクションを終える前に、すべてを一緒に見てみましょう。
         ここでは、ゼロからインストールされた完全なLinuxディストリビューションがあります。
         Virtio GPU 2DでそのUIを表示することができます。
         VMの中で、Rosettaを使ったPHPサーバーを動かしています。
         そして、macOSホストから接続することができます。
        仮想マシンの作成が、かつてないほどシンプルになったことがおわかりいただけたと思います。
         Virtualizationフレームワークを使えば、ほんの数行のコードで、仮想マシンを動かすことができます。
         また、macOSでは仮想マシンがとんでもなく高速であることもおわかりいただけたと思います。
         Virtualizationについてもっと知りたい方は、ぜひコードサンプルやドキュメントをチェックしてみてください。
         そして、チームを代表して、皆さんがこの技術を使って次に何をするのか、待ち遠しいです。
        """
    }
}
