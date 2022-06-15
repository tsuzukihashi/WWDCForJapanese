import Foundation

struct BringYourWorldIntoAugmentedReality: ArticleProtocol {
    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6625/6625_wide_250x141_2x.jpg")!
    }
    
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Bring your world into augmented reality"
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10128/")!
    }

    var english: String {
        """
        Hao Tang: Hi, my name is Hao.
         I'm an engineer on the Object Capture team.
         Today, my colleague Risa and I will be showing you how to use the Object Capture API and RealityKit to create 3D models of real-world objects and bring them into AR.
         Let's get started.
         First, I'll give you a recap of Object Capture, which we launched as a RealityKit API on macOS last year.
         Then, I'll introduce you to a couple of camera enhancements in ARKit, which allow you to capture high-res photos of your object and can help you better integrate Object Capture into your AR applications.
         After that, I will go through the best practice guidelines of Object Capture so you can continue to make the best out of this technology.
         In the last section, Risa will take you through an end-to-end workflow with Object Capture in RealityKit and demonstrate how you can bring real-world objects into an AR experience.
         Let's start with a quick recap of Object Capture.
         Object Capture is a computer vision technology that you can leverage to easily turn images of real-world objects into detailed 3D models.
         You begin by taking photos of your object from various angles with an iPhone, iPad, or DSLR.
         Then, you copy those photos to a Mac which supports Object Capture.
         Using the Photogrammetry API, RealityKit can transform your photos into a 3D model in just a few minutes.
         The output model includes both a geometric mesh as well as various material maps, including textures, that are automatically applied to your model.
         For more details of the Object Capture API, I would highly recommend that you watch last year's WWDC session on Object Capture.
         Many developers have created amazing 3D capture apps using Object Capture: Unity, Cinema4D, Qlone, PolyCam, PhotoCatch, just to name a few.
         In addition to this, we have beautiful-looking models that were created using this API.
         Here's a few models that were created by Ethan Saadia using the power of Object Capture within the PhotoCatch app.
         And our friend Mikko Haapoja from Shopify also generated a bunch of great-looking 3D models using this API.
         The detailed quality of the output 3D models you get with Object Capture is highly beneficial in e-commerce.
         Here's the GOAT app, for example, that lets you try on a variety of shoes on your feet.
         All of these shoe models have been created with the Object Capture API which has been designed to capture the finest level of detail on them.
         This can go a long way in helping you with your purchase decision on a product, or even try out an accurate fit for an object in your space.
         For example, the Plant Story app lets you preview real-looking 3D models of various plants in your space, all of which have been created with Object Capture.
         This can help you get a sense of how much space you may need for a plant, or simply see them in your space in realistic detail.
         Speaking about realism, were you able to spot the real plant in this video? Yes, it's the one in the white planter on the left-most corner of the table.
         We are very thrilled to see such a stunning and widespread use of the Object Capture API since its launch in 2021.
         Now, let's talk about some camera enhancements in ARKit, which will greatly help the quality of reconstruction with Object Capture.
         A great Object Capture experience starts with taking good photos of objects from all sides.
         To this end, you can use any high-resolution camera, like the iPhone or iPad, or even a DSLR or mirrorless camera.
         If you use the Camera app on your iPhone or iPad, you can take high-quality photos with depth and gravity information which lets the Object Capture API automatically recover the real-world scale and orientation of the object.
         In addition to that, if you use an iPhone or iPad, you can take advantage of ARKit's tracking capabilities to overlay a 3D guidance UI on top of the model to get good coverage of the object from all sides.
         Another important thing to note is that the higher the image resolution from your capture, the better the quality of the 3D model that Object Capture can produce.
         To that end, with this year's ARKit release we are introducing a brand-new high-resolution background photos API.
         This API lets you capture photos at native camera resolution while you are still running an ARSession.
         It allows you to use your 3D UI overlays on top of the object while taking full advantage of the camera sensor on device.
         On an iPhone 13, that means the full 12 megapixels native resolution of the Wide camera.
         This API is nonintrusive.
         It does not interrupt the continuous video stream of the current ARSession, so your app will continue to provide a smooth AR experience for your users.
         In addition, ARKit makes EXIF metadata available in the photos, which allows your app to read useful information about white balance, exposure, and other settings that can be valuable for post-processing.
         ARKit makes it extremely easy to use this new API in your app.
         You can simply query a video format that supports high-resolution frame capturing on ARWorldTrackingConfguration, and if successful, set the new video format and run the ARSession.
         When it comes to capturing a high-res photo, simply call ARSession's new captureHighResolutionFrame API function, which will return to you a high-res photo via a completion handler asynchronously.
         It is that simple.
         We have also recognized that there are use cases where you may prefer manual control over the camera settings such as focus, exposure, or white balance.
         So we are providing you with a convenient way to access the underlying AVCaptureDevice directly and change its properties for fine-grained camera control.
         As shown in this code example, simply call configurableCaptureDevice ForPrimaryCamera on your ARWorldTrackingConfiguration to get access to the underlying AVCaptureDevice.
         For more details on these enhancements, I highly recommend you to check out the "Discover ARKit 6 session" from this year's WWDC.
         Now, let's go through some best practice guidelines with Object Capture.
         First things first; we need to choose an object with the right characteristics for Object Capture.
         A good object has adequate texture on its surface.
         If some regions of the object are textureless or transparent, the details in those regions may not be reconstructed well.
         A good object should also be free of glare and reflections.
         If the object does not have a matte surface, you can try to reduce the specular on it using diffuse lighting.
         If you would like to flip over the object to capture its bottom, please ensure that your object stays rigid.
         In other words, it should not change its shape when flipped.
         And lastly, a good object can contain fine structure to some degree, but you will need to use a high-resolution camera and take close-up photos to recover the fine detail of the object.
         The next important thing is setting up an ideal capture environment.
         You will want to make sure that your capture environment has good, even, and diffuse lighting.
         It is important to ensure a stable background and have sufficient space around the object.
         If your room is dark, you can make use of a well-lit turntable.
         Next, we'll look at some guidelines for capturing good photos of your object, which in turn, will ensure that you get a good quality 3D model from Object Capture.
         As an example, I'll show you how my colleague Maunesh used his iPhone to capture the images of a beautiful pirate ship that was created by our beloved ARKit engineer, Christian Lipski.
         Maunesh begins by placing the pirate ship in the middle of a clean table.
         This makes the ship clearly stand out in the photos.
         He holds his iPhone steadily with two hands.
         As he circles around the ship slowly, he captures photos at various heights.
         He makes sure that the ship is large enough in the center of the camera's field of view so that he can capture the maximum amount of detail.
         He also makes sure that he always maintains a high degree of overlap between any two adjacent photos.
         After he takes a good number of photos -- about 80 in this case -- he flips the ship on its side, so that he can also reconstruct its bottom.
         He continues to capture about 20 more photos of the ship in a flipped orientation.
         One thing to note is that he is holding the iPhone in landscape mode.
         This is because he is capturing a long object, and in this case, the landscape mode helps him capture maximum amount of detail of the object.
         However, he may need to use the iPhone in portrait mode if he were to capture a tall object instead.
        That's it! The final step in the process is to copy those photos onto a Mac and process them using the Object Capture API.
         You can choose from four different detail levels, which are optimized for different use cases.
         The reduced and medium detail levels are optimized for use in web-based and mobile experiences, such as viewing 3D content in AR QuickLook.
         The reconstructed models for those detail levels have fewer triangles and material channels, thereby consuming less memory.
         The full and raw detail levels are intended for high-end interactive use cases, such as in computer games or post-production workflows.
         These models contain the highest geometric detail and give you the flexibility to choose between baked and unbaked materials, but they require more memory to reconstruct.
         It is important to select the right output level depending on your use case.
         For our pirate ship, we chose the medium detail level, which only took a few minutes to process it on an M1 Mac.
         The output 3D model looked so stunning that we actually put together an animated clip of the pirate ship sailing in high seas.
         And that's the power of Object Capture for you! Ahoy! Now I'll hand it off to Risa, who will be walking you through an end-to-end workflow with Object Capture in RealityKit.
        Risa Yoneyama: Thanks, Hao.
         Now that we have gone over the Object Capture API, I am excited to go over an end-to-end developer workflow, to bring your real-life object into AR using RealityKit.
         We'll walk through each step in detail with an example workflow, so let's dive straight into a demo.
         My colleague Zach is an occasional woodworker and recently built six oversized wooden chess pieces -- one for each unique piece.
         Looking at these chess pieces, I'm inspired to create an interactive AR chess game.
         Previously, you'd need a 3D modeler and material specialist to create high-quality 3D models of real-world objects.
         Now, with the Object Capture API, we can simply capture these chess pieces directly and bring them into augmented reality.
         Let's start off by capturing the rook.
         My colleague Bryan will be using this professional setup, keeping in mind the best practices we covered in the previous section.
         In this case, Bryan is placing the rook on this turntable with some professional lighting to help avoid harsh shadows in the final output.
         You can also use the iPhone camera with a turntable, which provides you with automatic scale estimation and gravity vector information in your output USDZ.
         Please refer to the Object Capture session from 2021 for more details on this.
         Of course, if you do not have an elaborate setup like Bryan does here, you can also simply hold your iOS device and walk around your object to capture the images.
         Now that we have all the photos of our rook piece, I'm going to transfer these over to the Mac.
         I'll process these photos using the PhotogrammetrySession API that was introduced in 2021.
         Per the best practice guidelines, I'll use the reduced detail level to reconstruct, as we want to make sure our AR app performs well.
         The final output of the API will be a USDZ file type model.
         Here is our final output of the rook chess piece I just reconstructed.
         To save us some time, I've gone ahead and captured the other five pieces ahead of time.
         You may be wondering how we will create a chess game with only one color scheme for the chess pieces.
         Let's duplicate our six unique pieces and drag them into Reality Converter.
         I have inverted the colors in the original texture and replaced the duplicated set with this new inverted texture.
         This way, we can have a lighter version and a darker version of the chess pieces, one for each player.
         I'll be exporting the models with the compressed textures option turned on in the Export menu.
         This will help decrease the memory footprint of the textures.
        Now that we have our full set of chess pieces, we are ready to bring the models into our Xcode project.
         I've created a chessboard using RealityKit by scaling down primitive cubes on the y-axis and alternating the colors between black and white.
         Here are all the chess pieces I reconstructed, laid out on the chessboard.
         This is already exciting to see our real-life objects in our application, but let's start adding some features to make it an actual interactive game.
         Throughout this part of the demo, I would like to showcase several different existing technologies, so we can provide examples of how you might want to combine the technologies to accomplish your desired output.
         As we'll be going over some practical use cases of advanced topics in RealityKit, I would recommend checking out the RealityKit sessions from 2021 if you are not already familiar with the APIs.
         I want to start by adding a start-up animation when we first launch the application.
         I am imagining an animation where the checker tiles slowly fall into place from slightly above its final position, all while the chess pieces also translate in together.
         To replicate this effect in code, all it takes is two steps.
         The first step is to translate both our entities up along the y-axis, while also uniformly scaling down the chess piece.
         The second step and final step is to animate both entities back to its original transform.
         The code for this is quite simple.
         I'll start by iterating through the checker tile entities.
         For each entity, I'll save the current transform of the checker tile as this will be the final position it lands on.
         Then, I'll move each square up 10 cm on the y-axis.
         We can now take advantage of the move function to animate this back to our original transform.
         I also happen to know that this border USDZ that outlines the checkerboard has a built-in animation.
         We can use the playAnimation API to start the animation simultaneously.
         I've added the exact same animation to the chess pieces but also modifying the scale as they translate.
         And here we have it: a simple startup animation with just a few lines of code.
         However, we won't actually be able to play chess without the ability to move the chess pieces.
         Let's work on that next.
         Before we can start moving the chess pieces, we'll need to be able to select one.
         I've already added a UITapGestureRecognizer to my ARView.
         When the users taps a specific location, we will define a ray that starts from the camera origin and goes through that 2D point.
         We can then perform a raycast with that ray into the 3D scene to see if we hit any entities.
         I've specified my chess piece collision group as a mask as I know I only want to be able to select the chess pieces in my scene.
         Be mindful that the raycast function will ignore all entities that do not have a CollisionComponent.
         If we do find a chess piece, we can finally select it.
         Now that we know which piece is selected, I want to add an effect that will make the piece look like it is glowing.
         We can leverage custom materials to achieve this; more specifically, surface shaders.
         Surface shaders allow you to calculate or specify material parameters through Metal, which then gets called by RealityKit's fragment shader once per each pixel.
         We can write a surface shader that looks like this fire effect in Metal.
         Then apply a custom material, with this surface shader to our rectangular prism to have the shader affect how our entity looks.
         Let's write some code to achieve our desired effect.
         I've already added a noise texture to the project to use in this surface shader.
         We'll sample the texture twice, once for the overall shape of the effect and another for detail.
         We then take the RGB value and remap it to look just the way we want.
         Then, with the processed value we just extracted, we'll calculate the opacity of the sample point by comparing its y-position with the image value.
         To give the effect some movement, we'll be moving through the y-axis of the texture as a function of time.
         Additionally, we will also use the facing angle of each sample point in conjunction with the viewing direction of the camera to fade the effect at the sides.
         This will soften the edges and hide the regular nature of the underlying model.
         Finally, we'll set the color and opacity we just calculated using the surface parameter functions.
         And here are the chess pieces with the selection shader applied to it.
         They really do look like they are glowing from the inside.
         Now, if we combine that with three separate translation animations, that will result in something that looks like this.
         With the functionality to move chess pieces implemented, we'll also be able to capture the opponent's pieces.
         Just like surface shaders, geometry modifiers can be implemented using custom materials.
         They are a very powerful tool, as you can change vertex data such as position, normals, texture coordinates, and more.
         Each of these Metal functions will be called once per vertex by RealityKit's vertex shader.
         These modifications are purely transient and do not affect the vertex information of the actual entity.
         I'm thinking we could add a fun geometry modifier to squash the pieces when they are captured.
         I have this property on my chess piece called capturedProgress to represent the progress of the capturing animation from 0 to 1.
         Since capturing is a user-initiated action, we somehow need to tell the geometry modifier when to start its animation.
         The good thing is you can do this by setting the custom property on a customMaterial.
         This allows data to be shared between the CPU and the GPU.
         We will specifically use the custom value property here and pass the animation progress to the geometry modifier.
         To extract the animation progress from the Metal side, we can use the custom parameter on uniforms.
         Since I want to scale the object vertically, as if it is being squashed by another piece, we will set the scale axis as the y-direction.
         To add some complexity to the animation, we will also change the geometry in the x-axis to create a wave effect.
         The offset of the vertex can be set using the set_model_position_ offset function.
         Here is the final product of our geometry modifier.
         You can see that it scales up a bit before collapsing down, while being stretched vertically along the x-axis.
         As a chess novice myself, I thought it might be helpful to add a feature to indicate where your selected piece can move to to help me learn the game.
         Since the checker pieces are each individual entities with their own Model Component, I can apply a pulsing effect using a surface shader to potential moves to distinguish them from others.
         Next, I'll add a post-processing effect called "bloom" to accentuate the effect even more.
         Again, we're using the custom parameter here we used in the surface shader for the glow effect.
         In this case, we are passing in a Boolean from the CPU side to our Metal surface shader.
         If this checker is a possible move, I want to add a pulsing effect by changing the color.
         We'll specifically add the pulse to the emissive color here.
         Lastly, I'll add the bloom effect to the entire view.
         Bloom is a post-processing effect that produces feathers of light from the borders of bright areas.
         We can accomplish this effect by taking advantage of the render callbacks property on ARView.
         We will write the bloom effect using the already built-in Metal performance shader functions.
         Next, we'll simply set the renderCallbacks.
        postProcess closure as our bloom function we just defined.
         When we pulse our checkers, we are pulsing to a white color which will now be further emphasized with the bloom effect.
         With the surface shader and bloom effect together, we can see exactly where we can move our pieces to.
         Finally, let's combine everything we have together to see our real-life chess pieces come to life in our AR app.
         We can see how all the features we added look in our environment.
         For your convenience we have linked the Capture Chess sample project to the session resources.
         Please download it and try it out for yourself to see it in your environment.
         And it's that simple.
         From capture to reconstruction of the oversized chess pieces, then into our augmented reality app.
         We've covered a lot in this session today so let's summarize some of the key points.
         We first started off by recapping the Object Capture API that we announced in 2021.
         We then went over a new API in ARKit that enables capturing photos on-demand at native camera resolution during an active ARSession.
         To help you get the most out of the Object Capture technology, we listed types of objects that are suited for reconstruction, ideal environments to get high-quality images, and the recommended flow to follow while capturing your object.
         For the latter part of this session, we walked through an example end-to-end developer workflow.
         We captured photos of the oversized chess pieces and used the images as input to the PhotogrammetrySession API to create 3D models of them.
         Then, we imported the models into Reality Converter to replace some textures.
         And finally, we slowly built up our chess game to see our chess pieces in action in AR.
         And that's it for our session today.
         Thank you so much for watching.
         Ahoy!
        """
    }

    var japanese: String {
        """
        ハオ・タン こんにちは、私はハオです。
         Object Captureチームのエンジニアです。
         今日は同僚のRisaと一緒に、Object Capture APIとRealityKitを使って現実世界のオブジェクトの3Dモデルを作成し、ARに取り込む方法を紹介します。
         さっそく始めましょう。
         まず、昨年macOSのRealityKit APIとして公開したObject Captureのおさらいをします。
         次に、オブジェクトの高解像度写真をキャプチャでき、オブジェクト・キャプチャをARアプリケーションにうまく統合するのに役立つ、ARKitのカメラ拡張をいくつか紹介します。
         その後、Object Captureのベストプラクティスのガイドラインを確認し、この技術を最大限に活用し続けることができるようにします。
         最後のセクションでは、RisaがRealityKitのObject Captureを使ったエンドツーエンドのワークフローを紹介し、現実世界のオブジェクトをAR体験に持ち込む方法を実演します。
         まず、Object Captureについて簡単におさらいしましょう。
         オブジェクト・キャプチャは、コンピュータ・ビジョンの技術で、現実世界のオブジェクトの画像を簡単に詳細な3Dモデルに変換することができます。
         まず、iPhoneやiPad、デジタル一眼レフカメラで、対象物をさまざまな角度から撮影します。
         そして、その写真をオブジェクトキャプチャに対応したMacにコピーします。
         RealityKitはPhotogrammetry APIを使用して、わずか数分で写真を3Dモデルに変換することができます。
         出力されるモデルには、幾何学的なメッシュと、テクスチャを含む様々なマテリアルマップの両方が含まれており、これらは自動的にモデルに適用されます。
         Object Capture APIの詳細については、昨年のWWDCで行われたObject Captureに関するセッションをご覧になることを強くお勧めします。
         多くの開発者が、Object Captureを使って素晴らしい3Dキャプチャーアプリを作成しています。Unity、Cinema4D、Qlone、PolyCam、PhotoCatchなど、数え上げればきりがありません。
         これに加えて、このAPIを使って作成された美しい外観のモデルもあります。
         これは、Ethan SaadiaがPhotoCatchアプリ内のオブジェクトキャプチャーの力を使って作成したモデルの一部です。
         また、Shopifyの友人であるMikko Haapojaも、このAPIを使って素晴らしい3Dモデルをたくさん作成しました。
         Object Captureで出力される3Dモデルの詳細な品質は、eコマースで非常に有益です。
         例えば、これはGOATのアプリで、自分の足で様々な靴を試着することができます。
         これらの靴のモデルはすべてObject Capture APIで作成されており、非常に細かい部分までキャプチャできるように設計されています。
         これは、商品の購入を決定する際に大いに役立つだけでなく、空間にあるオブジェクトの正確なフィッティングを試すこともできます。
         例えば、「Plant Story」アプリでは、オブジェクトキャプチャで作成された、空間にあるさまざまな植物のリアルな3Dモデルをプレビューすることができます。
         これにより、植物を置くスペースがどれくらい必要なのかを把握したり、実際に植物を置いてみることで、リアルな空間を実現できます。
         ところで、このビデオに登場する植物は本物ですか？はい、テーブルの左端にある白いプランターに入っている植物です。
         2021年の発売以来、Object Capture APIがこのように見事に広く使われていることに、私たちは大変感激しています。
         さて、Object Captureによる再構築の質を大きく向上させる、ARKitのカメラ強化について説明します。
         素晴らしい Object Capture の体験は、オブジェクトをあらゆる方向からうまく撮影することから始まります。
         そのためには、iPhoneやiPad、あるいはデジタル一眼レフカメラやミラーレスカメラなど、どんな高解像度のカメラでも使うことができます。
         iPhoneやiPadのカメラアプリを使えば、オブジェクトキャプチャAPIが実世界のスケールと向きを自動的に復元するための奥行きと重力の情報を含む高画質な写真を撮影することができます。
         それに加えて、iPhoneやiPadを使えば、ARKitのトラッキング機能を利用して、モデルの上に3DガイダンスUIを重ね、オブジェクトを全方向からしっかりカバーすることができます。
         もう一つ重要なことは、キャプチャーの画像解像度が高いほど、Object Captureが生成できる3Dモデルの品質が高くなることです。
         そのため、今年のARKitのリリースでは、全く新しい高解像度の背景写真APIを導入しています。
         このAPIを使用すると、ARSessionを実行したまま、ネイティブのカメラ解像度で写真をキャプチャすることができます。
         これにより、デバイスのカメラセンサーを最大限に活用しながら、オブジェクトの上で3D UIオーバーレイを使用することができます。
         iPhone 13 では、ワイド カメラの 12 メガピクセルのネイティブ解像度をフルに活用できることになります。
         このAPIは、非侵入型です。
         現在の ARSession の連続的なビデオストリームを中断しないので、アプリケーションはユーザーにスムーズな AR 体験を提供し続けることができます。
         さらに、ARKit は写真の EXIF メタデータを利用可能にします。これにより、アプリはホワイトバランス、露出、その他の設定など、後処理に役立つ情報を読み取れるようになります。
         ARKit では、この新しい API をアプリで非常に簡単に使用できます。
         ARWorldTrackingConfguration で高解像度フレームキャプチャをサポートするビデオフォーマットを照会し、成功すれば新しいビデオフォーマットを設定して ARSession を実行するだけです。
         高解像度写真をキャプチャする場合は、ARSession の新しい API 関数 captureHighResolutionFrame を呼び出すだけで、非同期に完了ハンドラを介して高解像度写真が返されます。
         とてもシンプルです。
         また、フォーカス、露出、ホワイトバランスなど、カメラの設定を手動でコントロールすることを好むユースケースもあることを認識しています。
         そこで、基礎となる AVCaptureDevice に直接アクセスし、そのプロパティを変更してきめ細かなカメラ制御を行う便利な方法を提供します。
         このコード例に示すように、ARWorldTrackingConfiguration の configurableCaptureDevice ForPrimaryCamera を呼び出すだけで、基盤となる AVCaptureDevice にアクセスすることができます。
         これらの拡張機能の詳細については、今年のWWDCの「Discover ARKit 6 セッション」をご覧になることを強くお勧めします。
         それでは、オブジェクトキャプチャーのベストプラクティスのガイドラインを見ていきましょう。
         まず最初に、オブジェクト・キャプチャーに適した特性を持つオブジェクトを選択する必要があります。
         良いオブジェクトとは、表面に適度なテクスチャがあるものです。
         オブジェクトの一部の領域にテクスチャがなかったり、透明であったりすると、その領域のディテールがうまく再現されないことがあります。
         また、グレアや反射がないことも重要です。
         オブジェクトの表面がマットでない場合は、拡散照明を使用してオブジェクトのスペキュラを減らすことができます。
         被写体を裏返して底面を撮影する場合は、被写体が固定されていることを確認してください。
         つまり、反転しても形が変わらないようにします。
         最後に、良い物にはある程度細かい構造が含まれていますが、細かい部分を復元するためには、高解像度のカメラを使い、アップで撮影する必要があります。
         次に大切なのは、理想的な撮影環境を整えることです。
         撮影環境は、均一で拡散性のある良好な照明を確保したいところです。
         背景が安定していること、被写体の周りに十分なスペースがあることも重要です。
         部屋が暗い場合は、明るいターンテーブルを利用するとよいでしょう。
         次に、オブジェクトキャプチャから高品質の3Dモデルを得るために、対象物の写真を上手に撮るためのガイドラインを紹介します。
         例として、私の同僚であるMauneshが、ARKitのエンジニアであるChristian Lipskiが作成した美しい海賊船の画像を、iPhoneを使ってどのようにキャプチャしたかを紹介します。
         Mauneshはまず、海賊船をきれいなテーブルの真ん中に置きます。
         こうすることで、写真の中で船がはっきりと目立つようになります。
         彼は、iPhoneを両手でしっかりと持っています。
         船の周りをゆっくり回りながら、さまざまな高さの写真を撮影していきます。
         船の大きさがカメラの視野の中心に来るようにし、ディテールを最大限に写し込む。
         また、隣り合う2枚の写真の重なり具合も常に確認する。
         80枚ほど撮影したところで、船を横向きにし、船底も復元できるようにします。
         さらに20枚ほど撮影を続け、船底を復元した。
         iPhoneを横向きにしているのがポイントです。
         これは、長い物体を撮影しているためで、この場合、横向きで撮影することで物体のディテールを最大限に表現することができます。
         しかし、背の高いものを撮影する場合は、iPhoneをポートレートモードで使用する必要があるかもしれません。
        以上です。最後に、撮影した写真をMacにコピーし、Object Capture APIを使って処理します。
         使用用途に応じて最適化された4種類のディテールレベルを選択できます。
         縮小および中程度の詳細レベルは、AR QuickLookで3Dコンテンツを表示するなど、ウェブベースやモバイルでのエクスペリエンスでの使用に最適化されています。
         これらの詳細レベルで再構築されたモデルは、トライアングルとマテリアルチャンネルの数が少ないため、より少ないメモリしか消費しません。
         フルおよびローディテールレベルは、コンピュータゲームやポストプロダクションワークフローなど、ハイエンドのインタラクティブなユースケースを対象としています。
         これらのモデルは最も高い幾何学的ディテールを含み、ベイクされたマテリアルとされていないマテリアルを柔軟に選択できますが、再構築に必要なメモリはより多くなります。
         使用するケースに応じて、適切な出力レベルを選択することが重要です。
         私たちの海賊船では、中程度のディテールレベルを選択し、M1 Macでの処理に数分しかかかりませんでした。
         出力された3Dモデルは非常に美しく、実際に海賊船が公海を航行するアニメーションクリップを作成しました。
         これがオブジェクトキャプチャの威力です。では では、米山さんからRealityKitのObject Captureを使ったエンドツーエンドのワークフローをご紹介いただきます。
        米山リサ：ハオさん、ありがとうございます。
         オブジェクト・キャプチャAPIについて説明したところで、RealityKitを使って現実のオブジェクトをARに取り込むための、エンドツーエンドの開発者向けワークフローを説明したいと思います。
         各ステップをワークフローの例で詳しく説明しますので、さっそくデモをご覧ください。
         私の同僚のZachは、時々木工をしますが、最近、6つの特大の木製チェス駒を作りました--ユニークな駒ごとに1つずつです。
         このチェスの駒を見て、インタラクティブなARチェス・ゲームを作りたいと思うようになりました。
         以前は、現実世界の物体の高品質な3Dモデルを作成するためには、3Dモデラーや材料の専門家が必要でした。
         しかし、Object Capture APIを使えば、このチェスの駒を直接キャプチャするだけで、AR（拡張現実）に取り込むことができるのです。
         まず、ルークをキャプチャしてみましょう。
         私の同僚であるBryanは、前のセクションで説明したベストプラクティスを念頭に置きながら、このプロフェッショナルなセットアップを使用します。
         この場合、ブライアンはルークをターンテーブルの上に置き、最終的な出力できつい影ができないように、プロフェッショナルな照明をいくつか使っています。
         また、iPhoneのカメラをターンテーブルと一緒に使うことで、出力されるUSDZに自動的なスケール推定と重力ベクトル情報が含まれます。
         これについての詳細は、2021年のオブジェクトキャプチャーのセッションを参照してください。
         もちろん、今回のブライアンのような凝った設定がない場合は、単にiOSデバイスを持って対象物の周りを歩いて撮影することも可能です。
         さて、ルーク駒の写真がすべて揃ったので、これをMacに転送してみます。
         2021年に導入されたPhotogrammetrySession APIを使って、これらの写真を処理します。
         ベストプラクティスのガイドラインに従って、ARアプリのパフォーマンスを確認するために、縮小したディテールレベルを使用して再構築します。
         このAPIの最終出力は、USDZファイルタイプのモデルになります。
         先ほど再構築したルークチェスの駒の最終出力がこちらです。
         時間を節約するために、先に他の 5 つの駒をキャプチャしておきました。
         チェスの駒が 1 つの配色しかない場合、どのようにチェスゲームを作成するのか、疑問に思うかもしれません。
         6つのユニークな駒を複製して、Reality Converterにドラッグしてみましょう。
         元のテクスチャの色を反転させ、複製したセットをこの新しい反転テクスチャに置き換えたのです。
         こうすることで、チェスの駒の明るいバージョンと暗いバージョンを、各プレイヤーに1つずつ用意することができます。
         私は、エクスポートメニューで圧縮テクスチャオプションをオンにして、モデルをエクスポートします。
         これによって、テクスチャのメモリフットプリントを減らすことができます。
        これで、チェスの駒のフルセットができたので、そのモデルを Xcode のプロジェクトに取り込む準備ができました。
         RealityKit を使って、プリミティブな立方体を Y 軸で縮小し、色を黒と白に交互に変えて、チェス盤を作りました。
         これが、私が再構築したすべてのチェスの駒を、チェス盤の上に並べたものです。
         このように、現実のオブジェクトをアプリケーションで見ることができるのはすでにエキサイティングですが、実際のインタラクティブなゲームにするために、いくつかの機能を追加していきましょう。
         このデモのパートでは、いくつかの異なる既存技術を紹介し、希望するアウトプットを達成するために技術をどのように組み合わせるかの例を提供したいと思います。
         RealityKitの高度なトピックの実用的な使用例について説明しますので、APIにまだ慣れていない方は、2021年のRealityKitのセッションをチェックすることをお勧めします。
         まずは、アプリケーションを初めて起動するときの起動アニメーションを追加してみたいと思います。
         チェッカー・タイルが最終位置の少し上からゆっくりと所定の位置に落ち、同時にチェスの駒も一緒に並進していくようなアニメーションを想像しています。
         この効果をコードで再現するために必要なのは、2つのステップだけです。
         最初のステップは、両方のエンティティを Y 軸に沿って上に移動させ、同時にチェスの駒を一様に縮小させることです。
         2 番目のステップと最後のステップは、両方のエンティティを元の変形に戻すアニメートです。
         このコードは、非常にシンプルです。
         まず、チェッカータイルのエンティティを繰り返し処理します。
         各エンティティについて、チェッカータイルの現在のトランスフォームを保存します。
         次に、各スクエアを Y 軸上で 10cm 上へ移動します。
         これで、移動関数を利用して、元のトランスフォームに戻るアニメーションを行うことができます。
         また、チェッカーボードの輪郭を描くこのボーダーUSDZには、アニメーションが組み込まれていることも知っています。
         playAnimation API を使用して、同時にアニメーションを開始することができます。
         チェスの駒にもまったく同じアニメーションを追加しましたが、駒が移動するときにスケールも変更します。
         こうして、わずか数行のコードでシンプルな起動アニメーションを実現することができた。
         しかし、チェスの駒を動かすことができなければ、実際にチェスをすることはできない。
         次はそれをやってみよう。
         チェスの駒を動かし始める前に、駒を選択できるようにする必要がある。
         すでにARViewにUITapGestureRecognizerを追加しています。
         ユーザーが特定の場所をタップすると、カメラの原点から始まってその2Dポイントを通るレイを定義します。
         そして、そのレイで3Dシーンにレイキャストを行い、エンティティにヒットするかどうかを確認することができます。
         チェスの駒のコリジョングループをマスクとして指定し、シーン内のチェスの駒だけを選択できるようにしたいと思います。
         レイキャスト関数は、CollisionComponent を持たないエンティティをすべて無視することに注意してください。
         チェスの駒が見つかったら、ついにそれを選択することができます。
         どの駒が選択されているかがわかったので、その駒が光っているように見える効果を追加したいと思います。
         これを実現するには、カスタムマテリアルを活用します。より具体的には、サーフェスシェーダを使います。
         サーフィスシェーダは、Metalを通してマテリアルのパラメータを計算または指定することができ、RealityKitのフラグメントシェーダから各ピクセルごとに呼び出されます。
         このファイアーエフェクトのようなサーフィスシェーダをMetalで書くことができます。
         そして、このサーフェスシェーダを使ったカスタムマテリアルを長方形のプリズムに適用すると、シェーダがエンティティの見え方に影響するようになります。
         それでは、目的の効果を実現するためのコードを書いてみましょう。
         この表面シェーダで使用するノイズテクスチャは、すでにプロジェクトに追加してあります。
         テクスチャを 2 回サンプリングします。1 回は効果全体の形状、もう 1 回は細部の形状をサンプリングします。
         次に、RGB 値を取得し、私たちが望むように見えるように再マッピングします。
         次に、先ほど抽出した処理済みの値を使って、サンプルポイントの y 位置を画像値と比較して、不透明度を計算します。
         この効果に動きを与えるため、テクスチャのy軸を時間の関数として移動させます。
         さらに、各サンプルポイントの向きとカメラの視線方向を組み合わせて、側面での効果をフェードさせます。
         これにより、エッジが柔らかくなり、基礎となるモデルの規則的な性質が隠されます。
         最後に、サーフェスパラメータ関数を使って、先ほど計算した色と不透明度を設定します。
         そしてここに、選択シェーダが適用されたチェスの駒があります。
         本当に内側から光っているように見えますね。
         さて、これを 3 つの別々の移動アニメーションと組み合わせると、次のようなものになります。
         チェスの駒を動かす機能が実装されたので、相手の駒を捕獲することもできるようになります。
         サーフェスシェーダと同様に、ジオメトリモディファイアもカスタムマテリアルを使って実装することができます。
         位置、法線、テクスチャ座標などの頂点データを変更することができるので、非常に強力なツールです。
         これらの Metal 関数はそれぞれ、RealityKit のバーテックスシェーダによって頂点ごとに一度だけ呼び出されます。
         これらの変更は純粋に一時的なもので、実際のエンティティの頂点情報には影響しません。
         私は、駒が捕獲されたときに、駒をつぶす楽しいジオメトリ修飾を追加できないかと考えています。
         私はチェスの駒にcapturedProgressというプロパティを持っていて、0から1までのキャプチャアニメーションの進行状況を表現しています。
         キャプチャはユーザが行う動作なので、ジオメトリモディファイアにアニメーションを開始するタイミングを伝える必要があります。
         良いことに、customMaterial のカスタムプロパティを設定することでこれが可能になります。
         これによって、CPU と GPU の間でデータを共有することができます。
         ここでは特にカスタム値プロパティを使用し、アニメーションの進捗をジオメトリモディファイアに渡します。
         Metal 側からアニメーションの進捗を取り出すには、uniforms のカスタムパラメータを使用します。
         オブジェクトを他のパーツに押しつぶされるように、縦方向にスケールさせたいので、スケール軸をY方向に設定します。
         アニメーションに複雑さを加えるために、X 軸のジオメトリも変更して、波のような効果を作り出します。
         頂点のオフセットは、set_model_position_offset 関数を使用して設定できます。
         ジオメトリモディファイアの最終的な成果です。
         X軸に沿って垂直に引き伸ばされながら、崩れ落ちる前に少しスケールアップしているのがわかります。
         私自身チェスの初心者なので、ゲームを学ぶために、選択した駒がどこに移動できるかを示す機能を追加するのが役に立つかもしれないと思いました。
         チェッカーの駒は、それぞれ独自のモデルコンポーネントを持つ個別のエンティティなので、潜在的な動きに対してサーフィスシェーダを使用して脈動効果を適用し、他の駒と区別することができます。
         次に、「ブルーム」と呼ばれる後処理効果を加えて、さらに効果を強調することにします。
         ここでも、グロー効果のサーフェスシェーダで使用したカスタムパラメータを使用しています。
         この場合、CPU側からMetalのサーフィスシェーダーにブール値を渡しています。
         このチェッカーが可能な動きであれば、色を変化させることでパルス効果を加えたいと思います。
         ここでは具体的にエミッシブカラーにパルスを追加することにします。
         最後に、ブルーム効果をビュー全体に追加してみます。
         ブルームは、明るい領域の境界から光の羽を生成するポストプロセス効果です。
         ARViewのレンダーコールバックプロパティを利用することで、この効果を実現することができます。
         ここでは、すでに組み込まれているMetalのパフォーマンスシェーダ関数を使用してブルーム効果を記述します。
         次に、renderCallbacks.postProcessクロージャをブルーム効果として設定します。
        postProcessクロージャを、先ほど定義したブルーム関数として設定します。
         チェッカーをパルスするとき、白色にパルスしていますが、これはブルーム効果でさらに強調されます。
         サーフィスシェーダとブルーム効果を併用することで、駒をどこに移動させればよいか、正確に把握することができます。
         最後に、今あるものをすべて組み合わせて、現実のチェスの駒が AR アプリで生き返るのを見ましょう。
         追加したすべての機能が、この環境でどのように見えるかを見ることができます。
         セッションのリソースに、Capture Chess のサンプル・プロジェクトをリンクしています。
         ぜひダウンロードして、ご自分の環境で試してみてください。
         と、そんな簡単なものです。
         キャプチャから特大チェスの駒の再構築、そして拡張現実アプリへ。
         今日はこのセッションで多くのことを学びましたので、重要なポイントをまとめてみましょう。
         まず、2021年に発表したObject Capture APIの再確認から始めました。
         そして、アクティブな ARSession 中にネイティブのカメラ解像度でオンデマンドに写真をキャプチャできる、ARKit の新しい API について説明しました。
         Object Captureの技術を最大限に活用するために、再構成に適したオブジェクトの種類、高画質を得るための理想的な環境、オブジェクトをキャプチャする際の推奨フローをリストアップしました。
         後半は、開発者のワークフローの例を紹介しました。
         特大のチェスの駒を撮影し、その画像をPhotogrammetrySession APIへの入力として、3Dモデルを作成しました。
         次に、そのモデルを Reality Converter にインポートして、いくつかのテクスチャを交換しました。
         そして最後に、私たちはゆっくりとチェスゲームを構築し、ARで動くチェスの駒を見ることができました。
         本日のセッションは以上です。
         ご視聴ありがとうございました。
         それではまた。
        """
    }
}
