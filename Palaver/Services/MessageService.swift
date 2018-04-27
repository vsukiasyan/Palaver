//
//  MessageService.swift
//  Palaver
//
//  Created by Vic Sukiasyan on 4/25/18.
//  Copyright © 2018 Vic Sukiasyan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel: Channel?
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else { return }
                if let json = try? JSON(data: data).array {
                    for item in json! {
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                        self.channels.append(channel)
                    }
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                }
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                self.clearMessages()
                
                guard let data = response.data else { return }
                if let json = try? JSON(data: data).array {
                    for item in json! {
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let id = item["_id"].stringValue
                        let userName = item["userName"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                        
                        self.messages.append(message)
                    }
                    //print(self.messages)
                    completion(true)
                }
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, userName: String, userAvatar: String, userAvatarColor: String, completion: @escaping CompletionHandler) {
        
        let body: [String: Any] = [
            "messageBody": messageBody,
            "userId": userId,
            "channelId": channelId,
            "userName": userName,
            "userAvatar": userAvatar,
            "userAvatarColor": userAvatarColor
            ]
        
        Alamofire.request(URL_ADD_MESSAGE, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let channelId = self.selectedChannel?.id else { return }
                self.findAllMessagesForChannel(channelId: channelId, completion: { (success) in
                    if success {
                        print("GOT MESSAGE AFTER")
                    }
                })
                
                
//                guard let data = response.data else { return }
//                if let json = try? JSON(data: data) {
//                    print(json)
//                } else {
//                    debugPrint(response.result.error as Any)
//                    completion(false)
//                }
                
                
            } else {
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    
    func clearMessages() {
        messages.removeAll()
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
    
    
    
}
