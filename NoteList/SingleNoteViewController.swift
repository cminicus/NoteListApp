//
//  SingleNoteViewController.swift
//  NoteList
//
//  Created by Clayton Minicus on 8/30/15.
//  Copyright (c) 2015 Clayton Minicus. All rights reserved.
//

import UIKit

class SingleNoteViewController: UIViewController {

    var note: Note!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = note.title
        bodyTextView.text = note.body
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
