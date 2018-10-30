//
//  ChatRoomViewController.swift
//  SimpleChatApp
//
//  Created by Lainel John Dela Cruz on 28/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit
import CoreData;

class ChatRoomViewController: TFAccessoryViewController {
    
    var context:NSManagedObjectContext?;
    var userInfo:UserInfo?;
    
    @IBOutlet weak var UINavItem: UINavigationItem!
    @IBOutlet weak var UIMessageTF: UITextField!
    @IBOutlet weak var UIMessageTV: UITableView!
    var messages:[Chat]=[];
    
    var chatInfo:ChatRoom?;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.UIMessageTF.delegate=self;
        self.UIMessageTF.inputAccessoryView=self.navbarAccessory
        self.UINavItem.title=self.chatInfo?.name
        //
        UIMessageTV.delegate=self;
        UIMessageTV.dataSource=self;
        UIMessageTV.backgroundColor=UIColor.clear
        self.UIMessageTV.register(UINib(nibName: "CustomCell1TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell");
        self.LoadData();
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SendOnClick(_ sender: Any) {
    }

}
//MARK - TextField Func
extension ChatRoomViewController{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        (textField as! AdjustingTF).Move(view: self.view, duration: 0.3, moveDistance: 280, up: false)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as! AdjustingTF).Move(view: self.view, duration: 0.3, moveDistance: 0, up: false)
    }
}


//MARK: -TableView func

extension ChatRoomViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell1TableViewCell
        cell.UIMessageContent.text = self.messages[indexPath.row].message!;
        cell.UISenderTF.text=self.messages[indexPath.row].sender
        cell.backgroundColor=UIColor.clear;
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

//MARK: - Firebase func
extension ChatRoomViewController {
    func LoadData(){
        Chat.all(rname: self.chatInfo!.name!, context: self.context!, completionHandler: {
            (res, err) in
            self.messages.append(res!)
            self.UIMessageTV.reloadData();
        })
    }
}


