//
//  cartoonListTableViewController.swift
//  childFMWebkit
//
//  Created by bijiabo on 15/7/12.
//  Copyright (c) 2015年 JYLabs. All rights reserved.
//

import UIKit

class cartoonListTableViewController: UITableViewController {

    var data : [String] = [
        "不要送孩子去英语班",
        "该给孩子听点小故事了",
        "宝宝能叫妈妈啦",
        "孩子开始说话了",
        "宝宝对我叫他有反应了",
        "宝宝刚出生，我该做点什么"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "成长漫画"
        
        //设置navigationbar样式
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        
        self.clearsSelectionOnViewWillAppear = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return data.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : cartoonListTableViewCell = tableView.dequeueReusableCellWithIdentifier("cartoonListCell", forIndexPath: indexPath) as! cartoonListTableViewCell

        cell.title.text = data[indexPath.row]
        
        if indexPath.row == 0
        {
            cell.tip = true
        }
        else
        {
            cell.tip = false
        }

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let cell : cartoonListTableViewCell = sender as? cartoonListTableViewCell
        {
            //目前漫画数量，用余数来循环显示
            let currentCartoonCount : Int = 3
            
            let index : Int = tableView.indexPathForCell(cell)!.row % currentCartoonCount
            
            var cartoonDetailVC : cartoonDetailViewController = segue.destinationViewController as! cartoonDetailViewController
            
            cartoonDetailVC.cartoonTitle = cell.title.text!

            cartoonDetailVC.imageDirectoryPath = "cartoonImage/\(index)"
        }
        
    }


}
