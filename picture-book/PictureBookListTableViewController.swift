//
//  PictureBookListTableViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/8/23.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import UIKit

class PictureBookListTableViewController: UITableViewController {

    let listData : Array<Dictionary<String,String>> = [
        [
            "title" : "Silly Sally",
            "introduction" : "Silly Sally went to town, walking backwards, upside down - and that''s just the beginning. Come along with Sally and her companions as they parade into town in a most unusual way",
            "image" : "0"
        ],
        [
            "title" : "Lost And Found",
            "introduction" : "Nancy Shaw is the author of seven beloved tales featuring the endearing and comical sheep.",
            "image" : "1"
        ],
        [
            "title" : "Sheep in a Jeep Board Book",
            "introduction" : "Beep! Beep! Sheep in a jeep on a hill that’s steep.",
            "image" : "2"
        ],
        [
            "title" : "One Fish Two Fish Red Fish Blue Fish",
            "introduction" : "Did you ever fly a kite in bed? Did you ever walk with ten cats on your head?",
            "image" : "3"
        ]
        
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "萌宝绘本精灵"

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listData.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : PictureBookListTableViewCell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath) as! PictureBookListTableViewCell
        
        cell.pictureBookImageView.image = UIImage(named: listData[indexPath.row]["image"]!)
        cell.title.text = listData[indexPath.row]["title"]
        cell.introduction.scrollEnabled = false
        cell.introduction.text = listData[indexPath.row]["introduction"]

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
