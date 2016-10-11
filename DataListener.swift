//
//  DataListener.swift
//  Authentication
//
//  Created by Andrew Goodwin on 9/7/16.
//  Copyright © 2016 Conway Corporation. All rights reserved.
//

import Foundation
import UIKit

public class Listeners{
    static let sharedListeners = Listeners()
    private init(){
        
    }
    var dataListeners = [DataListener]()
}

public class DataListener{
    var messageType = ""
    var command = ""
    var speak: ((String?, String?, [String:AnyObject]?) -> Void)
    var listener = ""
    var speaker = ""
    var listenerAddress = ""
    var speakerAddress = ""
    
    init(listener:String, messageType:String, command:String, speak:((String?, String?, [String:AnyObject]?) -> Void)){
        self.listener = listener
        self.messageType = messageType
        self.command = command
        self.speak = speak
    }
    
    init(speaker:String, listener:String, messageType:String, command:String, speak:((String?, String?, [String:AnyObject]?) -> Void)){
        self.speaker = speaker
        self.listener = listener
        self.messageType = messageType
        self.command = command
        self.speak = speak
    }
}