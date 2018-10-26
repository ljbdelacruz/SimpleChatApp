//
//  DashboardViewController.swift
//  SimpleChatApp
//
//  Created by Lainel John Dela Cruz on 25/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    
    @IBOutlet weak var UIRoomSB: UISearchBar!
    var roomMessages:[ChatRoom]=[];
    @IBOutlet weak var UIRoomTV: UITableView!
    override func viewDidLoad(){
        super.viewDidLoad()
        self.UIRoomTV.delegate=self;
        self.UIRoomTV.dataSource=self;
    }
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func CreateOnClick(_ sender: Any) {
        
    }
}

//MARK: -UITableView functionalities
extension DashboardViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.roomMessages.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.roomMessages[indexPath.row].name!;
        return cell;
    }
}

