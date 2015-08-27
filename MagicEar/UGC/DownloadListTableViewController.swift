//
//  DownloadListTableViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/8/28.
//  Copyright © 2015年 JYLabs. All rights reserved.
//

import UIKit

class DownloadListTableViewController: UITableViewController , DownloadView {

    var URLList : Array<NSURL> = Array<NSURL>()
    var taskList : Array<NSURLSessionDownloadTask> = Array<NSURLSessionDownloadTask>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "下载列表"
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        getDownloadListData()
    }
    
    func getDownloadListData() {
        NSNotificationCenter.defaultCenter().postNotificationName("NeedDownloadListData", object: self)
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
        return URLList.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : DownloadListTableViewCell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath) as! DownloadListTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.titleTextLabel.text = URLList[indexPath.row].lastPathComponent
        cell.accessoryType = UITableViewCellAccessoryType.None
        
        switch taskList[indexPath.row].state {
        case NSURLSessionTaskState.Running:
            cell.descriptionTextLabel.text = "下载中..."
            
        case NSURLSessionTaskState.Canceling:
            cell.descriptionTextLabel.text = "已取消"
            
        case NSURLSessionTaskState.Completed:
            cell.descriptionTextLabel.text = "已完成"
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
        default:
            cell.descriptionTextLabel.text = "已暂停"
        }
        
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
    
    //MARK: Download view protocol
    func updateProgress(index: Int, progress: Double) {
        if let cell : DownloadListTableViewCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as? DownloadListTableViewCell
        {
            cell.descriptionTextLabel.text = "\(progress)"
        }
    }
    
    func finishDownload(index: Int) {
        if let cell : DownloadListTableViewCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as? DownloadListTableViewCell
        {
            cell.descriptionTextLabel.text = "已完成"
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
    }


}
