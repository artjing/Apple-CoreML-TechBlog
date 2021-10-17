//
//  ViewController.swift
//  MLTweetsSentimentAnalysize
//
//  Created by 董静 on 10/17/21.
//

import UIKit
import CoreML
import SwifteriOS

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let sentimentClassifier = tweetsSentimentClassifier()
    
    let swifter = Swifter(consumerKey: "tSpO21xZRqDWPYN0ycWB77bQy", consumerSecret: "pMKsQxRbfHXmBecUK30rHiNAfQP7GLS8fJ10DJKRHWpRLLTMO6")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 1000, tweetMode: .extended, success:{ result, metasata in
            
            var allTweets = [tweetsSentimentClassifierInput]()
            var allTweetsText = [String]()
            for i in 0..<1000 {
                if let text = result[i]["full_text"].string {
                    let input = tweetsSentimentClassifierInput(text: text)
                    allTweetsText.append(text)
                    allTweets.append(input)
                }
            }
            print(allTweetsText)
            do{
                let sentimentResult = try self.sentimentClassifier.predictions(inputs: allTweets)
                for p in sentimentResult {
                    print(p.label)
                }
            }
            catch {
                
            }
        }, failure: {_ in
            
        })
        
        /* predict directly
        do {
            let result = try sentimentClassifier.prediction(text: "@Apple is great")
            print(result.label)
        }
        catch{

        }
         */
    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

