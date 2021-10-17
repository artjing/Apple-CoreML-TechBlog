import Cocoa
import CreateML

//  use the local path of your /cvs/json file
let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "(local path).csv"))

// define the training data and testing data, give it a split
let(trainingData, testingData) = data.randomSplit(by: 0.9, seed: 5)

// define the text and label base on your colums in the cvs file
let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

// define the metrics
let evaluationMetrics = sentimentClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "class")

// calculate the accuracy
let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

// degine some basic info of your model
let metadata = MLModelMetadata(author: "Jing Dong", shortDescription: "A model trained to classify sentiment on Tweets", version: "1.0")

// define the ouuput path of model
try sentimentClassifier.write(to: URL(fileURLWithPath: "(localpath/name).mlmodel"))

// give it a test
try sentimentClassifier.prediction(from: "@I am so depressed")

//
try sentimentClassifier.prediction(from: "@So great day")

//
try sentimentClassifier.prediction(from: "@happy")

