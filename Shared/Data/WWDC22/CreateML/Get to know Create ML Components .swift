import Foundation

struct GetToKnowCreateMLComponents: ArticleProtocol {
    var id: String {
        UUID().uuidString
    }

    var title: String {
        "Get to know Create ML Components"
    }

    var imageUrl: URL {
        URL(string: "https://devimages-cdn.apple.com/wwdc-services/images/124/6512/6512_wide_250x141_2x.jpg")!
    }

    var link: URL {
        URL(string: "https://developer.apple.com/videos/play/wwdc2022/10019/")!
    }

    var english: String {
        """
        Hello, I'm Alejandro.
         I'm an engineer on the CreateML team.
         Today I'm going to talk about a brand-new API for building machine learning models using components.
         Create ML provides a simple API for training machine learning models.
         It is based on a set of supported tasks like image classification, sound classification, and so on.
         At WWDC 2021, we presented two great talks on the Create ML framework.
         Make sure to check those out if you haven't.
         But I want to talk about going beyond predefined tasks.
         What if you wanted to customize a task to your particular problem beyond what Create ML offers? Or what if you wanted to build a different type of task? Using components, you can now compose tasks in new and creative ways.
         Let's dig in.
         I'll start by breaking up an ML task and explaining what each component does.
         Then, I'll talk about how you can piece components together.
         Followed with an example of a custom image task.
         Then, I'll talk about tabular tasks.
         And I'll end with deployment strategies.
         Let me start by exploring the insides of a machine learning task so that you understand what goes into it and how it works.
         This way, when we start building custom tasks, you know what I'm talking about.
         I'm going to use an image classifier as an example.
         An image classifier uses a list of labeled images to train a model.
         In this example, I have images of cats and dogs with their respective labels.
         But let's explore how images are transformed at each step.
         To do that, I'll expand the image classification task to see what's inside.
         Conceptually, an image classifier is very simple.
         It consists of a feature extractor and a classifier.
         But the important part is that Create ML components gives you access to these components independently.
         You can add, remove, or switch components to compose new tasks.
         I'm going to represent components as boxes.
         Arrows represent the flow of data.
         Let's zoom into the first step of the image classifier: feature extraction.
         Generally, feature extractors reduce the dimensionality of the input by keeping only the interesting parts -- the features.
         In the case of images, a feature extractor looks for patterns in the image.
         Create ML uses Vision Feature Print, which is an excellent image-feature extractor provided by the Vision Framework.
         Now, let's talk about the second piece: the classifier.
         A classifier uses a set of examples to learn a classification.
         Some common implementations are logistic regression, boosted trees, and neural networks.
         So training an image classifier starts with annotated images, goes to annotated features, and ends with the classifier.
         But why do we want to break it into pieces? The reason is we want to expand the possibilities.
         Maybe you want to do some preprocessing by increasing the contrast.
         Or maybe you want to normalize all images so they have uniform brightness before you extract features.
         Or maybe you want to try a different feature extractor.
         Or maybe you want to try a different classifier.
         The possibilities are endless.
         These are just a few of the options.
         That's why we've added support for ML components in macOS, iOS, iPadOS, and tvOS.
         Our hope is that you can compose new models using some of the components we provide together with your own components, or even components built by others in the community.
         And you can leverage it across all of our platforms.
         Here are some of the components built into Create ML Components.
         But let me take a step back and introduce some concepts.
         There are two types of components: transformers and estimators.
         A transformer is simply a type that is able to perform some transformation.
         It defines an input type and an output type.
         For example, an image-feature extractor takes an input image and produces a shaped array of features.
         An estimator, on the other hand, needs to learn from data.
         It takes input examples, does some processing, and produces a transformer.
         We call this process "fitting.
        " Great.
         With those concepts out of the way, let me talk about how Create ML Components lets you build an image classifier from its individual components using composition.
         This is an image classifier using components.
         It has ImageFeaturePrint as the feature extractor and LogisticRegressionClassifier as the classifier.
         Regardless of whether a component is a transformer or an estimator, you combine them using the appending method.
         And this is where components provide unlimited possibilities.
         You can use a fully connected neural network as a classifier instead of logistic regression with a simple change.
         Or you can use a custom feature extractor in a CoreML model.
         For example, the headless ResNet-50 model you can find in the model gallery.
         When composing two components, the output of the first component must match the input of the second.
         In the case of our image classifier, the output of the feature extractor is a shaped array, from the CoreML framework.
         Which is also the input of a logistic regression classifier.
         If you get a compiler error when using the appending method, this is the first thing to check.
         Make sure the types match.
         But let me clarify an important point around fitting.
         I said before that fitting is the process of going from an estimator to a transformer.
         Let's look at this from the perspective of a composed estimator.
         When your composed estimator has both transformers and estimators, like in the case of the image classifier, only the estimator pieces are fitted.
         But the transformers are an important part of the process because they are used to feed the correct features to the estimator's fitted method.
         Here is the code.
         The image classifier needs a collection of annotated features where the features are images and the annotations are strings.
         We'll talk about loading the features when we go into the demo.
         Once I have the data, I can call the fitted method.
         This returns the trained model, a transformer.
         And it's important to note that the types used when fitting are related but different from the types of the resulting transformer.
         In particular, the types used in the fitted method are always collections.
         And in the case of supervised estimators, the features must include the annotations.
         Create ML Components uses the AnnotatedFeature type to represent a feature along with its annotation.
         Once I have the model, I can do predictions.
         It doesn't matter if it's a model I just fitted, or if I'm loading the parameters from a disk.
         The API is the same in both cases.
         Since I am training a classifier, the result is a classification distribution.
         The distribution includes a probability for each label.
         In this case, I'm just printing the most likely label for the image.
         The fitted method also provides a mechanism to observe training events, including validation metrics.
         In this example, I'm passing validation data and printing the validation accuracy.
         Note that only supervised estimators provide validation metrics.
         Once you train a model, you can save the learned parameters, either to reuse later or to deploy to an app.
         You do this using the write method.
         Later, you can read using the read method.
         And that's composition.
         This is where it gets interesting.
         Let me talk about writing a new task, something that Create ML didn't support until now.
        What if you wanted to train a model to score images? Let's say you have photos of fruit, but instead of classifying the fruit, you wanted to rate it.
         Give it a score based on how ripe it is.
         To do this, you need to do regression instead of classification.
         So let me write an image regressor that gives a score to images of bananas based on ripeness.
         I'll give each image a ripeness value between one and 10.
         An image regressor is very similar to an image classifier.
         The only difference is that our estimator is going to be a regressor instead of a classifier.
         As you may have already guessed, this is going to be easy.
         To refresh your memory, here is our image classifier.
         And this is an image regressor.
         I substituted the logistic regression classifier with a linear regressor.
         This simple change also changes the expected input to the fitted method.
         Before, it expected images and labels.
         Now, it expects images and scores.
         But enough about concepts.
         Let me demo this with some actual code.
        Let me show you how to write a custom image regressor.
         I'll start by defining an ImageRegressor struct to encapsulate the code.
        I have a folder with images of bananas at different levels of ripeness.
         I'm going to start by defining that URL.
        The next step is to add a train method.
         This is where you use training data to produce a model.
         I'm going to use the "some" keyword on the return type so that the return type doesn't change as I add or modify steps in the composed estimator.
         Now, I'm going to define the estimator.
         It's simply the feature extractor with the linear regressor appended.
         And now, I need to load the training images with their score.
         I can use AnnotatedFiles, which is a collection of AnnotatedFeatures containing URLs and string labels.
         It provides a convenience initializer that fits my needs.
         My files consist of a name, followed by a dash, followed by the ripeness value.
         So I'm going to specify that the separator is a dash and the annotation is at index: 1 of the filename components.
         I'm also going to request only image files by using the type argument.
         Now that I have URLs, I need to load the images.
         I can use the mapFeatures method and the ImageReader to do this.
         I also need to convert the scores from strings to floating point values.
         I can use the mapAnnotations method to do this.
        And with that, I have the training data.
         But I want to put some of it aside for validation.
         I can use the randomSplit method to do this.
         I'll keep 80 percent for training and use the rest for validation.
         Now, I'm ready to fit.
        And I'm going to save the trained parameters so that I can deploy to my app.
         I'll choose a location to save to.
        And I'll call the write method.
        Finally, I'll return the transformer.
        This is the essence of defining and training a model using components.
         I defined my composed estimator, I loaded my training data, I called the fitted method, and I used write to save the parameters.
         But there are some things I can improve.
         For starters, I am passing a validation data set but not observing the validation error, so I'll do that.
         The fitted method takes an event handler that you can use to gather metrics.
        For now, I'll just print both the training and validation maximum-error values.
         I also want the mean absolute error for the final model.
        I compute that by applying the fitted transformer to the validation features and then passing that along with the actual scores to the meanAbsoluteError function.
         I ran this but I didn't get a great model - the error was high.
         This is because I don't have that many images of bananas.
         I should get more images, but before I do that, I can try augmenting my dataset.
         I can rotate and scale my images to get more examples.
         To do this, I'm going to write a new method that takes an annotated image and augments it.
         It returns an array of annotated images.
        The first augmentation I'm going to do is rotation.
        I'll randomly choose an angle between -pi and pi and use it to rotate the image.
         I'll also do a random scale.
        And I'll return three images: the original, the rotated one, and the scaled one.
        Now that I have my augment function, I'll use it to augment my training images using flatMap.
        Each element of my dataset will be converted to an array.
         FlatMap flattens that array of arrays into a single array, which is what I need for the fitted method.
         Note that augmentations only apply when fitting, not when doing predictions.
         OK, this increased my accuracy.
         But let me talk about one more improvement that is going to make my model even better.
         I want to use the Vision framework to crop the images to the salient object.
         This is one of the images in my training data.
         Someone is holding bananas with other fruits in the background.
         The model may get confused by the other objects in the photo.
         Using the Vision framework API, I can automatically crop the image to the most salient object.
         To do this, please check out the Vision talk from WWDC 2019.
         I can easily apply this transformation to all my images, both when fitting and when getting predictions if I write a custom transformer.
         Let me show you how.
         The only thing I need to do to conform to a transformer protocol is implement the applied method.
         And in this case, I want it to take an image and return an image.
         I'm not going to go into this code, except to say that if I don't get a salient object, I'll just return the original image.
         Now that I have my custom transformer, I'll add it to my image regressor.
        I just need to use my custom transformer before feature extraction.
        Now that saliency is part of my task definition, it will be used to crop every training image, and it will also be used when doing inference.
         This is one of the advantages of sharing the task definition between training and inference.
         Before we go on to the next task, let me highlight some important points.
         Using components, I can now create custom tasks.
         I did this by using the appending method.
         I used AnnotatedFiles to load my files with annotated file names, but you can also load files annotated by directories.
         I mapped the URL to images using ImageReader and mapped the annotations from strings to values.
         I used randomSplit to set aside a validation dataset, and I saved the trained parameters for use later.
         Then I added augmentations and defined a custom transformer to improve my model.
         But this works for more than just images.
         I'll switch gears and talk about another type of task: tabular tasks.
         These are tasks that use tabular data.
         Tabular data is characterized by having multiple features of different types.
         It can include both numerical data as well as categorical data.
         A popular example is house-pricing data.
         You have things like area and age, but also things like neighborhood, type of building, et cetera.
         And you want to learn to predict a value; for example, the sale price.
         In 2021, we introduced the TabularData framework.
         Now you can use the TabularData framework together with Create ML Components to build and train tabular classifiers and regressors.
         I also recommend the tech talk on TabularData.
         It's a great introduction to data exploration, which you will likely need when building a tabular task.
         Let's dive in.
         When dealing with tabular data, each column of the table will have a different type of feature.
         And you may want to process each column differently, based on what type of information it contains; the distribution, range of values, and other factors.
         Create ML Components lets you do this using the ColumnSelector.
         Here is an example.
         I mentioned house prices, but those are ridiculous.
         I'm going to use avocado prices instead.
         I have this table of avocado prices.
         I want to build a tabular regressor to predict avocado prices based on this.
         It contains columns with numeric data such as bags, year, and volume and columns with categorical data such as type and region.
         Some regressors benefit from having a better representation of these values.
         For instance, this is the distribution of volume values in the dataset.
         It is close to a normal distribution, but with large values centered around 15,000.
         I think this is a great example of a dataset that could benefit from normalization.
         So the first thing I want to do is normalize these values.
         To do this, I can pass the column names I want to normalize to the ColumnSelector and then use a standard scaler.
         Here is the code.
         First I create a column selector.
         Then I pass the column names I want to scale.
         All columns must contain the same type of element; in this case, Double.
         Then I unwrap optionals.
         I can do this because I know there are no missing values.
         But I could also use an imputer which replaces missing values.
         And then I append the StandardScaler to the unwrapper.
         So I started with this table where bags numbers were in the tens of thousands and volumes were in the hundreds of thousands.
         And after scaling those columns, I end up with values that now have a magnitude close to one, which could improve the performance of my model.
         To be more specific, my values now have a mean of zero and a standard deviation of one.
         Here is a similar example, but in this example, I'm selecting the type and region columns, which are of type string and performing a one-hot encoding.
         One-hot encoding refers to encoding categorical data using an array to indicate the presence of each category.
         In this example, I have three categories: Bronze, Silver, and Gold.
         Each gets a unique position within the array, indicated by a one in that position.
         An alternative is to use an ordinal encoder, which gives a consecutive number to each category.
         Use a one-hot encoder when there are only a few categories and an ordinal encoder otherwise.
         Now let me put all this together and build a tabular regressor.
        As before, I'll start creating a struct and defining the data URL and the parameters URL.
        I also want to define a column ID for the column I want to predict: price.
        I'll define my task separately so that I can use it both from the train method and the predict method.
        As I mentioned, I'm going to normalize the volume.
        Then I'm going to use a boosted tree regressor to predict the price.
         It takes the name of the annotation column -- which is also the column of the resulting predictions -- and it takes the names of all three feature columns.
         I'll start with these three columns.
         Then I'll combine the pieces using the appending method and return the task.
        Now that I have my task definition, I'll add a train method as before.
        And as before, I want to make sure that the return type doesn't depend the specifics of my model.
         The first step is to load the CSV file into a data frame.
         I'm using the TabularData framework to do this.
         And as before, I want to split off some of the data for validation.
        I'll pass the training and validation datasets to the fitted method.
        I'll also report validation error as before, and I'll save the trained parameters for use later.
        Finally, I'll return the transformer.
        Once I have a trained transformer, I can use it to make price predictions on data frames.
         I'm going to write a predict method to do this.
        I'll start by loading the model from the task definition and the parameters URL.
        I need to make sure the data frame I use for predictions has the columns I used as features: type, region, and volume.
         The predicted value will be in the price column.
         I'll use the column ID I defined at the top.
        And that concludes my tabular regressor.
         I have a train method, that I only need to call once to produce my trained parameters, and a predict method that returns the avocado price, predictions based on the type, region, and the volume of avocados.
         That's all I need to use this in my app.
         Here are some things to keep in mind when working on tabular tasks.
         You can use ColumnSelector operations to process specific columns.
         It's worth noting that tree classifiers and regressors are all tabular, but you can also use a nontabular estimator, such as a linear regressor, in a tabular task using AnnotatedFeatureProvider.
         Please refer to the documentation.
         When doing predictions, build a data frame with the required columns, making sure to use the correct types.
         Now that you know how to build a custom task, let's talk about deployment.
         So far, I've used the same API for training and inference.
         I want to point out that when using Create ML Components, your model is your code.
         You need the task definition, even when loading the trained parameters from a file.
         This is useful in some situations, but sometimes you may want to use Core ML for deployment.
         When using Core ML, you leave the code behind.
         The model is fully represented by a model file.
         If you are all ready using Core ML, this may be a good workflow.
         And it has the advantage of optimized tensor operations.
         But there are some considerations you should keep in mind.
         Not all operations are supported in Core ML.
         Specifically, custom transformers and estimators are not supported.
         And Core ML only supports a few types like images and shaped arrays.
         If you are using custom types, you may need to convert those in your app when using the Core ML model.
         This is how you can export your transformer as a Core ML model.
         If your transformer contains unsupported operations, this will throw an error.
         If you'd rather stick with deploying your task definition along with the trained parameters, you should consider bundling them in a Swift package.
         This way, you can provide simple methods to load the parameters and perform a prediction.
         For more information on Swift package resources, check out the Swift packages talk from WWDC 2020.
         That's all I have.
         The main thing to remember is that you can now create custom tasks with composition.
         The possibilities are endless.
         I look forward to seeing what you build.
         For more advanced techniques, including audio and video tasks, check out "Compose advanced models with Create ML Components" where my colleague David will present more advanced custom tasks.
         Thank you and enjoy the rest of WWDC 2022!
        """
    }

    var japanese: String {
        """
        こんにちは、私はアレハンドロです。
         CreateML チームのエンジニアです。
         今日は、コンポーネントを使って機械学習モデルを構築するための全く新しいAPIについてお話します。
         Create MLは、機械学習モデルをトレーニングするためのシンプルなAPIを提供します。
         これは、画像分類や音分類などのサポートされているタスクのセットに基づいています。
         WWDC 2021では、Create MLフレームワークに関する2つの素晴らしい講演が行われました。
         もしまだなら、それらを必ずチェックしてください。
         しかし、私は事前定義されたタスクを超えることについて話したいと思います。
         もしあなたが、Create MLが提供する以上のタスクを、あなたの特定の問題に合わせてカスタマイズしたいと思ったらどうしますか？あるいは、別のタイプのタスクを作りたいとしたらどうでしょう？コンポーネントを使えば、新しい創造的な方法でタスクを構成することができるようになります。
         さっそく調べてみましょう。
         まず、MLタスクを分割して、それぞれのコンポーネントが何をするのかを説明します。
         そして、コンポーネントをどのように組み合わせるかについて説明します。
         続いて、カスタム画像タスクの例です。
         次に、表形式のタスクについて説明します。
         そして最後に、デプロイメント戦略について説明します。
         まず、機械学習タスクの内部を調べて、何が入っていて、どのように動作するのかを理解することから始めたいと思います。
         そうすれば、カスタム・タスクの作成を始めるときに、私が何を言っているのかがわかるでしょう。
         ここでは画像分類器を例にとって説明します。
         画像分類器は、ラベル付けされた画像のリストを使ってモデルを学習します。
         この例では、猫と犬の画像とそれぞれのラベルを用意しました。
         しかし、各ステップで画像がどのように変換されるかを調べてみましょう。
         そのために、画像分類タスクを拡張して中身を見てみることにします。
         概念的には、画像分類器はとてもシンプルです。
         特徴抽出器と分類器から構成されています。
         しかし、重要なのは、MLコンポーネントを作成すると、これらのコンポーネントに独立してアクセスできるようになることです。
         コンポーネントを追加したり，削除したり，切り替えたりして，新しいタスクを構成することができます．
         ここではコンポーネントを箱で表現します。
         矢印はデータの流れを表しています。
         画像分類器の最初のステップである特徴抽出にズームインしてみましょう。
         一般に、特徴抽出器は、興味深い部分、つまり特徴だけを残すことによって、入力の次元を減らすことができます。
         画像の場合，特徴抽出器は画像の中にあるパターンを探します．
         Create MLでは，Vision Frameworkが提供する優れた画像特徴抽出器であるVision Feature Printを使用しています．
         さて、2つ目の部品である分類器について説明します。
         分類器は，分類を学習するために一連の例を使用します．
         一般的な実装としては、ロジスティック回帰、ブースティング・ツリー、ニューラルネットワークなどがあります。
         つまり、画像分類器の学習は、アノテーションされた画像から始まり、アノテーションされた特徴に行き、分類器に行き着くわけです。
         しかし、なぜそれをバラバラにしたいのでしょうか？その理由は、可能性を広げたいからです。
         もしかしたら、コントラストを上げることで前処理をしたいかもしれません。
         あるいは、特徴を抽出する前に、すべての画像を正規化し、明るさをそろえるかもしれません。
         あるいは、別の特徴抽出器を試してみたい。
         あるいは、別の分類器を試してみる。
         可能性は無限大です。
         これらはほんの一部のオプションに過ぎません。
         macOS、iOS、iPadOS、tvOSでMLコンポーネントをサポートするようにしたのは、そのためです。
         私たちの願いは、私たちが提供するいくつかのコンポーネントとあなた自身のコンポーネント、あるいはコミュニティの他の人が作ったコンポーネントを一緒に使って、新しいモデルを構成していただくことです。
         そして、私たちのすべてのプラットフォームで、それを活用することができます。
         以下は、Create ML Componentsに組み込まれているコンポーネントの一部です。
         しかし、一歩下がって、いくつかの概念を紹介しましょう。
         コンポーネントには、トランスフォーマーとエスティメーターという2つのタイプがあります。
         トランスフォーマーとは，何らかの変換を行うことができる型です．
         入力型と出力型が定義されている。
         例えば，画像特徴抽出器は，入力画像を受け取り，特徴量の整形配列を生成する．
         一方、推定器は、データから学習する必要がある。
         推定器は、入力されたデータから学習し、何らかの処理を施し、変換器を生成する。
         この処理を「フィッティング」と呼ぶ。
        " 素晴らしい。
         それでは、Create ML Componentsを使うと、個々のコンポーネントから画像分類器を構成できることを説明します。
         これはコンポーネントを使った画像分類器です。
         特徴抽出器としてImageFeaturePrintを、分類器としてLogisticRegressionClassifierを搭載しています。
         コンポーネントが変換器であろうと推定器であろうと、appendingメソッドを使って組み合わせます。
         そして、ここがコンポーネントの無限の可能性を感じさせるところです。
         簡単な変更で、ロジスティック回帰の代わりに完全連結型ニューラルネットワークを分類器として使用することができます。
         あるいは、CoreMLのモデルでカスタムの特徴抽出器を使うこともできます。
         例えば、モデルギャラリーにあるヘッドレスResNet-50モデルがそうです。
         2つのコンポーネントを構成するとき、最初のコンポーネントの出力は2番目のコンポーネントの入力と一致しなければなりません。
         今回の画像分類器の場合，特徴抽出器の出力はCoreMLフレームワークから出力される整形配列です．
         これは、ロジスティック回帰分類器の入力でもあります。
         appendingメソッドを使用する際にコンパイラーエラーが発生した場合、最初に確認するのはこの点です。
         型が一致していることを確認してください。
         しかし、フィッティングに関する重要な点を明らかにしておきましょう。
         先ほど、フィッティングとは推定器から変換器へのプロセスであると言いました。
         これをコンポジション・エスティメーターの観点から見てみよう。
         画像分類器のように、変換器と推定器の両方を持つ合成推定器の場合、推定器の部分だけがフィッティングされます。
         しかし、トランスフォーマーは、正しい特徴をエスティメーターのフィッティングメソッドに与えるために使われるため、重要な役割を担っている。
         以下はそのコードです。
         画像分類器には注釈付き特徴量のコレクションが必要で、特徴量は画像で、注釈は文字列です。
         特徴量のロードについては、デモの中で説明します。
         データを入手したら、fittedメソッドを呼び出すことができます。
         これは学習されたモデル、トランスフォーマーを返します。
         ここで重要なのは、フィッティングの際に使用される型は、関連性はあるが、結果として得られるトランスフォーマーの型とは異なるということだ。
         特に，fittedメソッドで使われる型は常にcollectionである．
         また，教師あり推定量の場合，特徴量には注釈が含まれていなければなりません．
         Create ML Componentsでは，AnnotatedFeature型を使用して，アノテーションとともに素性を表現します．
         モデルができれば、予測をすることができる。
         フィッティングしたばかりのモデルでも、ディスクからパラメータを読み込んだモデルでも構いません。
         APIはどちらの場合も同じです。
         分類器を学習させるので、結果は分類分布になります。
         この分布には、各ラベルの確率が含まれています。
         今回は、画像に対して最も可能性の高いラベルを出力しているだけです。
         fittedメソッドは、検証メトリクスを含む学習イベントを観察するメカニズムも提供します。
         この例では、検証データを渡し、検証の精度を表示しています。
         なお、検証のための指標を提供するのは教師あり推定法のみです。
         モデルを学習したら、学習したパラメータを保存して、後で再利用したり、アプリにデプロイしたりすることができます。
         保存はwriteメソッドで行います。
         その後、readメソッドで読み込むことができます。
         これがコンポジションだ。
         ここが面白いところです。
         今までCreate MLがサポートしていなかった、新しいタスクの書き方について説明します。
        画像をスコアリングするモデルを学習させたいとしたらどうでしょう？例えば、果物の写真があったとして、その果物を分類するのではなく、評価したいとします。
         どれだけ熟しているかで点数をつけるのです。
         これを実現するには、分類の代わりに回帰を行う必要があります。
         そこで、バナナの画像に熟れ具合を点数化する画像回帰器を書いてみましょう。
         それぞれの画像に1〜10の熟度値を与えることにします。
         画像回帰器は画像分類器に非常によく似ています。
         唯一の違いは、我々の推定値が分類器の代わりにリグレッサになることです。
         もうお気づきかもしれませんが、これは簡単なことです。
         記憶を呼び起こすために、これが画像分類器です。
         そしてこれが画像リグレッサです。
         ロジスティック回帰の分類器を線形リグレッサに置き換えてみました。
         この単純な変更により、適合するメソッドに期待される入力も変更されます。
         以前は画像とラベルを想定していました。
         今は、画像とスコアです。
         しかし、コンセプトについてはもう十分でしょう。
         実際のコードでデモをしてみよう。
        カスタム画像リグレッサーの書き方をお見せしましょう。
         まず、ImageRegressor構造体を定義して、コードをカプセル化します。
        熟成度の異なるバナナの画像が入ったフォルダがあります。
         まず、その URL を定義することから始めます。
        次に、train メソッドを追加します。
         これは学習データを使ってモデルを作成するところです。
         戻り値の型に "some "キーワードを使用することで、コンポジション・エスティメーターのステップを追加または変更しても戻り値の型が変わらないようにします。
         さて，次に推定器を定義する．
         これは単純に特徴抽出器に線形リグレッサを追加したものである。
         そして，学習用画像とそのスコアをロードする必要がある．
         AnnotatedFilesはURLと文字列のラベルを含むAnnotatedFeaturesのコレクションであり、これを使うことができる。
         これは、私のニーズに合った便利なイニシャライザを提供します。
         私のファイルは、名前、ダッシュ、熟成度の値の順に構成されています。
         そこで、セパレータをダッシュにして、インデックスにアノテーションを指定することにします。1とする。
         また、type引数で画像ファイルのみを要求することにします。
         URLが得られたので、画像をロードする必要がある。
         mapFeaturesメソッドとImageReaderを使って、これを行うことができる。
         また、スコアを文字列から浮動小数点値に変換する必要があります。
         これはmapAnnotationsメソッドで行える。
        これで学習データができた。
         しかし、そのうちのいくつかは検証のために置いておきたい。
         そのためにrandomSplitメソッドを使います。
         80%はトレーニング用、残りは検証用にします。
         さて、フィットする準備ができました。
        学習したパラメータを保存して、自分のアプリにデプロイできるようにします。
         保存する場所を選びます。
        そして書き込みメソッドを呼び出します。
        最後に、トランスフォーマーを返します。
        これがコンポーネントを使ったモデルの定義と学習のエッセンスだ。
         構成された推定量を定義し、学習データをロードし、fittedメソッドを呼び出し、writeでパラメータを保存しました。
         しかし、いくつか改善すべき点があります。
         手始めに、検証データセットを渡しているのに、検証エラーを観測していないので、それをやってみる。
         fittedメソッドは、メトリクスを収集するために使用できるイベントハンドラを取ります。
        とりあえず、学習と検証の最大誤差の値を出力してみます。
         また、最終的なモデルの平均絶対誤差が欲しいです。
        検証用の特徴量にフィットした変換を適用して計算し、実際のスコアと一緒にmeanAbsoluteError関数に渡します。
         これを実行しましたが、素晴らしいモデルは得られず、誤差が大きくなってしまいました。
         これは、バナナの画像がそれほど多くないからです。
         もっと多くの画像を手に入れるべきですが、その前にデータセットを増やしてみることにします。
         画像を回転させたり、拡大縮小したりして、より多くの例を得ることができます。
         そのために、注釈付き画像を受け取ってそれを拡張する新しいメソッドを書きます。
         これはアノテーションされた画像の配列を返します。
        最初の拡張は、回転です。
        piとπの間の角度をランダムに選び、それを使って画像を回転させる。
         また、ランダムな拡大縮小も行います。
        そして3つの画像を返す。元の画像、回転させた画像、そして拡大縮小した画像だ。
        さて、augment関数ができたので、これを使ってflatMapで学習画像を拡張してみます。
        データセットの各要素は配列に変換されます。
         FlatMapはその配列の配列を1つの配列にフラット化します。これはfittedメソッドに必要なものです。
         オーグメンテーションはフィットのときだけ適用され、予測のときには適用されないことに注意してください。
         さて、これで精度が上がりました。
         しかし、もう一つ、私のモデルをさらに良くするための改良についてお話しましょう。
         Visionフレームワークを使用して、顕著なオブジェクトに画像をトリミングしたいと思います。
         これは私のトレーニングデータの中の1枚です。
         誰かがバナナを持っていて、背景には他の果物も写っています。
         このように、他の物体が写っていると、モデルは混乱してしまうかもしれません。
         Vision framework APIを使用すると、自動的に最も顕著なオブジェクトに画像を切り取ることができます。
         これを行うには、WWDC 2019のVisionの講演をご覧ください。
         私は、カスタムトランスフォーマーを書けば、フィッティングするときも、予測を得るときも、すべての画像にこの変換を簡単に適用することができます。
         その方法をお見せしましょう。
         トランスフォーマープロトコルに準拠するために必要なことは、適用されるメソッドを実装することだけです。
         この場合、画像を受け取って画像を返すようにしたい。
         このコードには触れませんが、もし顕著なオブジェクトが得られなかったら、単に元の画像を返すというだけのことです。
         さて、カスタム変換器ができたので、それを画像圧縮ファイルに追加します。
        特徴抽出の前にカスタム変換器を使うだけでいいんです。
        これでsaliencyがタスク定義の一部となり、すべての学習画像の切り出しに使用され、推論を行う際にも使用されるようになりました。
         これは、学習と推論の間でタスク定義を共有することの利点の1つです。
         次のタスクに進む前に、いくつかの重要な点を強調しておきます。
         コンポーネントを使って、カスタムタスクを作ることができるようになりました。
         私は、appendingメソッドを使ってこれを行いました。
         私はAnnotatedFilesを使って、ファイル名に注釈をつけたファイルをロードしましたが、ディレクトリに注釈をつけたファイルをロードすることも可能です。
         ImageReaderを使ってURLから画像にマッピングし、アノテーションを文字列から値にマッピングしました。
         randomSplitを使って検証用データセットを確保し、後で使うために学習済みパラメータを保存しました。
         その後、拡張機能を追加し、カスタムトランスフォーマーを定義して、モデルを改善しました。
         しかし、これは画像以外にも有効です。
         ここで話を変えて、別のタイプのタスク、表形式タスクについて説明します。
         これは表形式のデータを使用するタスクです。
         表形式のデータは、異なるタイプの複数の特徴を持つことが特徴です。
         数値データだけでなく、カテゴリーデータも含まれます。
         よくある例は、住宅価格のデータです。
         面積や築年数だけでなく、近隣の環境や建物の種類など、様々な特徴を持ちます。
         そして、例えば売却価格のような値を予測する学習をしたいのです。
         2021年、私たちはTabularDataフレームワークを導入しました。
         TabularDataフレームワークをCreate ML Componentsと一緒に使うことで、表形式の分類器や回帰器を構築して学習することができるようになりました。
         また、TabularDataの技術講演もおすすめです。
         これは、表形式のタスクを構築する際に必要となるであろう、データ探索の素晴らしい入門書です。
         では、さっそく始めましょう。
         表形式のデータを扱う場合、テーブルの各カラムは異なるタイプの特徴を持つことになります。
         そして，それぞれの列がどのような情報を持っているか，分布や値の範囲，その他の要因に基づいて，異なる処理を行いたいと思うかもしれません．
         Create ML Componentsでは，ColumnSelectorを利用してこのような処理を行うことができます．
         以下はその例です．
         住宅価格と書きましたが、これは馬鹿馬鹿しいですね。
         代わりにアボカドの価格を使いましょう。
         アボカドの値段の表があります。
         これをもとにアボカド価格を予測する表形式リグレッサーを作りたいと思います。
         この表には、袋、年、量などの数値データの列と、種類や地域などのカテゴリカル・データの列があります。
         リグレッサーの中には、これらの値をよりよく表現することで利益を得るものがある。
         例えば、これはデータセット中の体積値の分布である。
         正規分布に近いですが、15,000を中心とした大きな値になっています。
         これは正規化によって恩恵を受けることができるデータセットの素晴らしい例だと思います。
         そこで、最初にしたいことは、これらの値を正規化することです。
         これを行うには、正規化したい列名を ColumnSelector に渡して、標準的なスケーラーを使用します。
         以下はそのコードです。
         まず、カラムセレクタを作成します。
         そして、スケーリングしたいカラム名を渡します。
         すべての列は同じタイプの要素、ここでは Double を含んでいなければなりません。
         そして、オプションのアンラップを行います。
         これは欠損値がないことが分かっているからできることです。
         しかし、欠損値を置き換えるインピュータを使用することもできます。
         そして、StandardScalerをアンラッパーに追加します。
         このテーブルでは、バッグの数が数万個で、量が数十万個という状態からスタートしました。
         そして、これらの列をスケーリングした後、私は1近くの大きさを持つ値にたどり着き、私のモデルのパフォーマンスを向上させることができました。
         より具体的には、平均が0、標準偏差が1になりました。
         同じような例ですが、この例では、type と region 列を選択し、string 型でワンホットエンコーディングを実行しています。
         ワンホットエンコーディングとは、カテゴリデータを配列を使ってエンコードし、各カテゴリの存在を示すことである。
         この例では、3つのカテゴリがあります。ブロンズ、シルバー、そしてゴールドです。
         それぞれは配列の中でユニークな位置を占め、その位置が「1」であることを示します。
         別の方法として、各カテゴリーに連続した番号を与える序数エンコーダを使用することもできます。
         カテゴリーが少ないときはワンホットエンコーダーを、そうでないときはオーディナルエンコーダーを使用します。
         さて、これらをまとめて、表形式リグレッサを構築してみましょう。
        前回と同様に、まず構造体を作成して、データの URL とパラメータの URL を定義します。
        また、予測したい列（price）の列IDを定義したいと思います。
        trainメソッドとpredictメソッドの両方から使用できるように、タスクを別々に定義します。
        先ほど述べたように、ボリュームを正規化するつもりです。
        そして、ブーストされたツリー型リグレッサーを使用して価格を予測します。
         アノテーションカラムの名前（これは予測結果のカラムでもあります）と、3つの特徴カラムの名前を受け取ります。
         まずはこの3つのカラムから始めます。
         そして、appendingメソッドを使ってこれらを結合し、タスクを返します。
        タスクの定義ができたので、前と同じようにtrainメソッドを追加します。
        そして、前と同じように、戻り値の型がモデルの仕様に依存しないようにしたい。
         最初のステップは、CSVファイルをデータフレームにロードすることです。
         私はこれを行うためにTabularDataフレームワークを使用しています。
         そして、前と同じように、検証のためにデータの一部を分割したいと思います。
        トレーニング用と検証用のデータセットをfittedメソッドに渡します。
        また、前回と同じように検証エラーを報告し、後で使うために学習したパラメータを保存しておきます。
        最後に、変換器を返します。
        学習した変換器を手に入れたら、それを使ってデータフレームの価格予測をすることができます。
         そのための predict メソッドを書いてみます。
        まず、タスク定義とパラメータURLからモデルをロードします。
        予測に使うデータフレームには、特徴量として使ったカラム、type、region、volumeがあることを確認する必要がありますね。
         予測値はpriceカラムになります。
         最初に定義したカラムIDを使用します。
        これで表形式リグレッサは終了です。
         train メソッドは一回呼び出すだけで学習されたパラメータを生成し、predict メソッドはアボカドの価格、種類、地域、量に基づいた予測値を返します。
         私のアプリでこれを使うために必要なのはこれだけです。
         ここで、表形式のタスクに取り組む際に注意すべき点をいくつか挙げておきます。
         ColumnSelectorの操作で、特定の列を処理することができます。
         注目すべきは、木分類器とリグレッサーはすべて表形式であることです。しかし、AnnotatedFeatureProviderを使えば、線形リグレッサーなどの非表形式の推定量も表形式タスクで使用することが可能です。
         ドキュメントを参照してください。
         予測を行う場合、必要なカラムを持つデータフレームを構築し、正しい型を使用することを確認してください。
         さて、カスタムタスクの作り方がわかったところで、デプロイメントについて説明します。
         ここまでは、学習と推論に同じAPIを使用してきました。
         Create ML Componentsを使う場合、あなたのモデルはあなたのコードであることを指摘しておきたいと思います。
         学習したパラメータをファイルから読み込む場合でも、タスクの定義が必要です。
         これはこれで便利なのですが，時にはCore MLを使ったデプロイをしたい場合もあるでしょう．
         Core MLを使う場合、コードは残します。
         モデルは完全にモデルファイルによって表現されます．
         もしあなたがCore MLを使う準備がすべて整っているのであれば、このワークフローはよいかもしれません。
         テンソル演算が最適化されるというメリットもありますし。
         しかし、留意すべき点がいくつかあります。
         Core MLでは、すべての演算がサポートされているわけではありません。
         具体的には，カスタム変換器やカスタム推定器はサポートされていない．
         また，Core MLは，画像や整形された配列など一部の型しかサポートしていません．
         カスタム型を使用している場合，Core MLのモデルを使用する際には，アプリ内でそれらを変換する必要があるかもしれません．
         このようにして、トランスフォーマーをCore MLのモデルとしてエクスポートすることができます。
         トランスフォーマーにサポートされていない演算が含まれている場合は、エラーが発生します。
         もし、学習済みパラメータと一緒にタスクの定義を配備することにこだわりたいのであれば、Swiftパッケージにまとめることを検討すべきです。
         この方法では、パラメータをロードして予測を実行するためのシンプルなメソッドを提供することができます。
         Swift パッケージのリソースの詳細については、WWDC 2020 での Swift パッケージの講演をご覧ください。
         以上です。
         覚えておきたいのは、コンポジションでカスタムタスクを作成できるようになったということです。
         可能性は無限大です。
         あなたが何を作るか楽しみです。
         オーディオやビデオのタスクなど、より高度なテクニックについては、私の同僚であるDavidがより高度なカスタムタスクを紹介する「Compose advanced models with Create ML Components」をチェックしてみてください。
         ありがとうございました！WWDC 2022の残りをお楽しみください。
        """
    }
}

