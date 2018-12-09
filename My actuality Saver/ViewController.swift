//
//  ViewController.swift
//  My actuality Saver
//
//  Created by Philippe Donael Essono on 04/12/2018.
//  Copyright © 2018 Philippe Donael Essono. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    public var Actualities = [Actuality]()
    
    @IBOutlet weak var table: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.delegate = self
        self.table.dataSource = self
        
        let fetchRequest: NSFetchRequest<Actuality> = Actuality.fetchRequest()
        
        do {
            let Actualities = try persistence.context.fetch(fetchRequest)
            self.Actualities = Actualities
            table.reloadData()
        }
        catch {}
    }
    
    
    @IBAction func addActuality(_ sender: Any) {
        performSegue(withIdentifier: "addActuality", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Actualities.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if let label = cell?.contentView.viewWithTag(102
            ) as? UILabel {
            label.text = Actualities[indexPath.row].name
            print(label)
        }
        //cell.textLabel?.text = Actualities[indexPath.row].name
        return cell!
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if Actualities[indexPath.row].actualityType != ""{
            if Actualities[indexPath.row].actualityType == "Google Search"{
                UIApplication.shared.open(NSURL(string:"http://www.google.com/search?q=" + Actualities[indexPath.row].actuality! )! as URL)
                }
            if Actualities[indexPath.row].actualityType == "Google Actuality"{
                UIApplication.shared.open(NSURL(string:"http://www.google.com/search?q=" + Actualities[indexPath.row].actuality! + "&tbm=nws" )! as URL)
            }
            if Actualities[indexPath.row].actualityType == "YouTube"{
                UIApplication.shared.open(NSURL(string:"https://www.youtube.com/results?search_query=" + Actualities[indexPath.row].actuality!)! as URL)
            }
            
        }
        
    }
    

    @IBAction func DeleteActuality(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: table)
        guard let indexPath = table.indexPathForRow(at: point) else {
            return
        }
        print(indexPath)
        Actualities.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .left)
        persistence.saveContext()
        
    }
    
    @IBAction func ReloadTable(_ sender: Any) {
        table.reloadData()
        self.view.setNeedsLayout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tranfert = segue.destination as? AddActualityController
        tranfert?.Actualities = self.Actualities
    }

}
