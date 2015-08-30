//
//  NoteApi.swift
//  NoteList
//
//  Created by Clayton Minicus on 8/30/15.
//  Copyright (c) 2015 Clayton Minicus. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// turn into a class
struct Note {
    let id: String
    let title: String
    let body: String
    let date: String
}

class NoteApi {
    
    static let sharedInstance = NoteApi()
    private let baseURL = "http://cminicus-notelist.herokuapp.com/"
    
    private let body = "body"
    private let id = "_id"
    private let date = "published"
    private let title = "title"
    
    init() {
        println("connected")
    }
    
    /**
        Retrieves all notes on the server
    
        :callback: The callback method returning the notes and error if it exists
    */
    func getAllNotes(callback: (notes: [Note], error: NSError?) -> ()) {
        Alamofire.request(.GET, baseURL).responseJSON() { (request, response, jsonData, error) -> Void in
            if error != nil {
                callback(notes: [], error: error)
            }
            let json = JSON(jsonData!)
            if let jsonArray = json.array {
                let noteArray = jsonArray.map(self.convertToNote)
                callback(notes: noteArray, error: nil)
            }
        }
    }
    
    func createNewNote(note: Note, callback: (error: NSError?) -> ()) {
        let parameters = [
            title: note.title,
            body: note.body,
        ]
        Alamofire.request(.POST, baseURL, parameters: parameters, encoding: .JSON).responseJSON() { (request, response, jsonData, error) -> Void in
            if error != nil {
                callback(error: error)
            } else {
                callback(error: nil)
            }
        }
    }
    
    func deleteNote(note: Note, callback: (error: NSError?) -> ()) {
        let paramters = [
            id: note.id
        ]
//        Alamofire.request(.DELETE, baseURL, parameters: paramters, encoding: .JSON).responseJSON() { (request, response, jsonData, error) -> Void in
//            if error != nil {
//                callback(error: error)
//            } else {
//                callback(error: nil)
//            }
//        }
        
        Alamofire.request(.DELETE, baseURL + "\(note.id)", encoding: .JSON).responseJSON() { (request, response, jsonData, error) -> Void in
            if error != nil {
                callback(error: error)
            } else {
                callback(error: nil)
            }
        }

    }
    
    func convertToNote(json: JSON) -> Note {
        return Note(id: json[id].stringValue, title: json[title].stringValue, body: json[body].stringValue, date: json[date].stringValue)
    }
    
}