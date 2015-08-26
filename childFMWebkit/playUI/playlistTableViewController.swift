//
//  playlistTableViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/14.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import UIKit

class playlistTableViewController: UITableViewController , DemoModule
{
    var navigationDelegate : NavigationProtocol?

    var data : [String] = [
        "You Are My Sunshine",
        "All the Night",
        "The Nightingale",
        "Sweet Dream",
        "Baby toys meet melody",
        "New Found Glory",
        "Nachtblut",
        "Mono"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()

        self.clearsSelectionOnViewWillAppear = false
        
        self.title = "睡前磨耳朵"
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let ugcBarButton : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("link2UGC"))
        
        self.navigationItem.rightBarButtonItem = ugcBarButton
        
    }
    
    func link2UGC ()
    {
        //navigationDelegate?.loadModuleToNavigation("Main", storyboardIdentifier: "UGCHome")
        let UGCHomeVC : UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("UGCHome0") as UIViewController!
        
        self.navigationController?.pushViewController(UGCHomeVC, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return section == 0 ? 1 : data.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section
        {
        case 0:
            return ""
        case 1:
            return "即将播放"
        default:
            return ""
        }
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section
        {
        case 0:
            let cell : PlaylistStatisticTableViewCell = tableView.dequeueReusableCellWithIdentifier("statisticCell", forIndexPath: indexPath) as! PlaylistStatisticTableViewCell
            
            cell.ViewWidth = self.view.frame.size.width
            
            return cell
            
        case 1:
            let cell : playlistTableViewCell = tableView.dequeueReusableCellWithIdentifier("playlistCell", forIndexPath: indexPath) as! playlistTableViewCell
            
            cell.titleLabel.text = data[indexPath.row]
            cell.tagLabel.text = "为马小明推荐"
            
            
            return cell
            
        default:
            let cell : UITableViewCell = UITableViewCell()
            return cell
        }
        
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section
        {
        case 0:
            return 213.0
            
        case 1:
            return 63.0
            
        default:
            return 44.0
        }
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section
        {
        case 1:
            return 44.0
        default:
            return 0.0
        }
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        
        switch indexPath.section
        {
        case 1:
            return true
        default:
            return false
        }
    }
    

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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
