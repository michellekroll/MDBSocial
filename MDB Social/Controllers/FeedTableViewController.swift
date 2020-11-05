//
//  FeedTableViewController.swift
//  MDB Social
//
//  Created by Michelle Kroll on 11/4/20.
//

import UIKit
import Firebase

class FeedTableViewController: UITableViewController {
    
    var tableData: [Event] = []
    var tappedEvent: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFIRListener()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    
    func addFIRListener() {
        let db = Firestore.firestore()
        db.collection("eventInfo").addSnapshotListener { querySnapshot, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                if let snapshot = querySnapshot {
                    self.tableData = snapshot.documents.compactMap {
                        return try? $0.data(as: Event.self)
                    }
                    self.tableView.reloadData()
                }
        }
    }
    
    //need a write function that to update corresponding numInterested value in firebase
    

        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tappedEvent = self.tableData[indexPath.row]
        performSegue(withIdentifier: "DetailVCSegue", sender: self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableData.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! FeedCell
        let event = tableData[indexPath.row]
        cell.eventTitle.text = event.name
        cell.eventNumInterested.text = String(event.numInterested)
        cell.eventCreator.text = event.creator
        cell.eventInterested.setTitle("Interested?", for: .normal)
        cell.eventImageView.load(urlString: event.imgURL)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? DetailViewController else { return }
        vc.event = self.tappedEvent
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

