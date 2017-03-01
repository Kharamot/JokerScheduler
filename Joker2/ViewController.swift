//
//  ViewController.swift
//  Joker2
//
//  Created by Kameron Haramoto on 1/20/17.
//  Copyright © 2017 Kameron Haramoto. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    var notificationsOkay: Bool = false
    
    @IBOutlet weak var NotifyLabel: UILabel!

    @IBAction func scheduleJokeButtonPressed(_ sender: UIButton) {
        
        if(notificationsOkay){
            NotifyLabel.text = "Joke Scheduled"
            scheduleNotification()
        }
        else{
            NotifyLabel.text = "Notifications Disabled"
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotifyLabel.text = ""
        initializeJokes()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Variable declarations.
    var jokesArray = [Joke]()
    var noRepetes: Int? = nil
    var index: Int = 0;
    
    
    // Initilizes jokes using the Joke class, and stores them in the array.
    func initializeJokes(){
        let joke = Joke(first: "How many programmers", second: " does it take to", third: " change a lightbulb?", answer: "Zero. That's a hardware problem.")
        self.jokesArray.append(joke)
        
        let joke2 = Joke(first: "What prize do", second: " you get for putting", third: " your phone on vibrate?", answer: "The No Bell Prize.")
        self.jokesArray.append(joke2)
        
        let joke3 = Joke(first: "What do you get", second: " when you cross a", third: " stereo and a refrigerator?", answer: "Cool music.")
        self.jokesArray.append(joke3)
        
        let joke4 = Joke(first: "Why do phones ring?", answer: "Because they can't talk.")
        self.jokesArray.append(joke4)
        
        let joke5 = Joke(first: "Hillary Clinton", second: " spent $1.2 Billion", answer: "And still lost! lol")
        self.jokesArray.append(joke5)
    }
    
    // Chooses random joke from jokeArray. Will not repete a joke.
    func chooseJoke(){
        var randomJokeIndex = Int(arc4random_uniform(UInt32(self.jokesArray.count)))
        
        while noRepetes == randomJokeIndex {
            randomJokeIndex = Int(arc4random_uniform(UInt32(self.jokesArray.count)))
        }
        noRepetes = randomJokeIndex
        
        index = randomJokeIndex
        
        //firstLine.text = jokesArray[randomJokeIndex].firstLine
        //secondLine.text = jokesArray[randomJokeIndex].secondLine
        //thirdLine.text = jokesArray[randomJokeIndex].thirdLine
        //answerLine.text = jokesArray[randomJokeIndex].answerLine
        
    }
    
    func checkIfNotificationsStillOkay() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings(completionHandler:
            self.handleNotificationSettings)
    }
    
    func handleNotificationSettings (notificationSettings: UNNotificationSettings) {
        if ((notificationSettings.alertSetting == .enabled) &&
            (notificationSettings.badgeSetting == .enabled) &&
            (notificationSettings.soundSetting == .enabled)) {
            self.notificationsOkay = true
            print("yes")
        } else {
            self.notificationsOkay = false
            print("no")
        }
    }
    
    func scheduleNotification () {
        let content = UNMutableNotificationContent()
        chooseJoke()
        content.title = "Here's a joke. Tap for the answer."
        content.body = jokesArray[index].firstLine + jokesArray[index].secondLine + jokesArray[index].thirdLine
        content.userInfo["message"] = "Yo!"
        
        // Configure trigger for 5 seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // Create request
        let request = UNNotificationRequest(identifier: "NowPlusFive", content: content, trigger: trigger)
        
        // Schedule request
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
    }
    
    func handleNotification (_ response: UNNotificationResponse) {
        //let message = response.notification.request.content.userInfo["message"] as! String
        //self.messageLabel.text = message
        doAlert()
    }
    
    func doAlert() {
        let alert = UIAlertController(title: "Answer",
                                      message: jokesArray[index].answerLine,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            // execute some code when this option is selected
        }))
        present(alert, animated: true, completion: nil)
    }
    
}

