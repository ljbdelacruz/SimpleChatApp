//
//  DashboardViewController.swift
//  SimpleChatApp
//
//  Created by Lainel John Dela Cruz on 25/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit
import CoreData;
import SVProgressHUD;

class DashboardViewController: TFAccessoryViewController {
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    @IBOutlet weak var UIRoomSB: UISearchBar!
    var userInfo:UserInfo?
    var roomMessages:[ChatRoom]=[];
    var baseArray:[ChatRoom]=[];
    var selectedRoom:ChatRoom?;
    

    @IBOutlet weak var UIRoomTV: UITableView!
    override func viewDidLoad(){
        super.viewDidLoad()
        self.UIRoomTV.delegate=self;
        self.UIRoomTV.dataSource=self;
        self.UIRoomSB.delegate=self;
        self.UIRoomSB.inputAccessoryView=self.inputAccessoryView
        self.LoadData(searchText: "");
        UIRoomTV.backgroundColor=UIColor.clear
        self.UIRoomTV.register(UINib(nibName: "CustomCell1TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell");
    }
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: -Button Events
    @IBAction func LogoutOnClick(_ sender: Any) {
        self.userInfo=nil;
        self.roomMessages=[];
        self.navigationController?.popToRootViewController(animated: true);
    }
    @IBAction func CreateOnClick(_ sender: Any){
        var roomNameTF:UITextField?;
        let uialert=UIAlertController(title: "Add Room", message: "", preferredStyle: .alert)
        uialert.addTextField(configurationHandler: {
            (tf) in
            tf.placeholder="Room Name";
            roomNameTF=tf;
        })
        let addAction=UIAlertAction(title: "Add", style: .default, handler:{
            (action) in
            //action invoked when user added new item button
            ChatRoom.insert(rname: roomNameTF!.text!, sender: self.userInfo!.Email, message: "Hello", completionHandler:{
                (res, err) in
                err == nil ? self.LoadData(searchText: "") : print("ERROR Inserting New ChatRoom")
            })
        })
        let cancelAction=UIAlertAction(title: "Cancel", style: .default, handler: {
            (action) in
        })
        uialert.addAction(addAction);
        uialert.addAction(cancelAction);
        present(uialert, animated: true, completion: nil)
    }
}
//MARK: -UITableView functionalities
extension DashboardViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.roomMessages.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell1TableViewCell
        cell.UIMessageContent.text = self.roomMessages[indexPath.row].name!;
        cell.backgroundColor=UIColor.clear;
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedRoom=self.roomMessages[indexPath.row];
        self.view.endEditing(false);
        performSegue(withIdentifier: "roomListToRoom", sender: nil);
    }
}
//MARK: -SearchBar Functionality
extension DashboardViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.LoadData(searchText: searchBar.text!);
    }
}

//MARK: Firebase/CoreData Storage
extension DashboardViewController{
    func LoadData(searchText:String){
        if searchText.count <= 0 {
            self.roomMessages=[];
            ChatRoom.all(context: self.context, completionHandler: {
                (cr, err) in
                self.roomMessages.append(cr!);
                self.baseArray=self.roomMessages;
                self.UIRoomTV.reloadData();
            })
        }else{
            self.roomMessages=self.baseArray.filter { ($0.name?.contains(searchText))!};
            self.UIRoomTV.reloadData()
        }
    }
}
//MARK: -Segue Func
extension DashboardViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "roomListToRoom"{
            let destVC=segue.destination as! ChatRoomViewController;
            destVC.chatInfo=self.selectedRoom;
            destVC.context=self.context;
            destVC.userInfo=self.userInfo;
        }
    }
}


