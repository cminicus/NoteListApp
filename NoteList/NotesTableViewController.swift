//
//  NotesTableViewController.swift
//  NoteList
//
//  Created by Clayton Minicus on 8/30/15.
//  Copyright (c) 2015 Clayton Minicus. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {

    var noteArray: [Note] = []
    var lastSelectedNote: Note!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NoteApi.sharedInstance.getAllNotes { (notes, error) -> () in
            if error == nil {
                self.noteArray = notes
                self.tableView.reloadData()
            } else {
                println(error)
            }
        }

        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteTableCell", forIndexPath: indexPath) as! UITableViewCell
        
        configureCell(cell, forIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: UITableViewCell, forIndexPath indexPath: NSIndexPath) {
        let note = noteArray[indexPath.row]
        
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.body
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        lastSelectedNote = noteArray[indexPath.row]
        performSegueWithIdentifier("Show Note", sender: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            NoteApi.sharedInstance.deleteNote(noteArray[indexPath.row], callback: { (error) -> () in
                if error == nil {
                    self.noteArray.removeAtIndex(indexPath.row)
                    self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                } else {
                    println(error!.localizedDescription)
                }
            })
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Show Note" {
            let singleNoteViewController = segue.destinationViewController as! SingleNoteViewController
            singleNoteViewController.note = lastSelectedNote
        }
    }

}
