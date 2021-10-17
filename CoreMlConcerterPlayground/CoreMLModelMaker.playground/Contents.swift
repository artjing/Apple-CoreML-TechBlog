import Cocoa
import CreateML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/tousei/Documents/IOS面试资料/代码练习/TweetSentimentModelMaker/twitter-sanders-apple3.csv"))
let(trainingData, testingData) = data.randomSplit(by: 0.9, seed: 5)
let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")
let evaluationMetrics = sentimentClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "class")
let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100
let metadata = MLModelMetadata(author: "Jing Dong", shortDescription: "A model trained to classify sentiment on Tweets", version: "1.0")
try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/tousei/Documents/IOS面试资料/代码练习/TweetSentimentModelMaker/tweetsSentimentClassifier.mlmodel"))
try sentimentClassifier.prediction(from: "@Apple is terrible company")
try sentimentClassifier.prediction(from: "@I just found the rest restorant ever, and it's @DuckandWaffle")
try sentimentClassifier.prediction(from: "@happy")

