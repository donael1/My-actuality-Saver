//
//  AddActualityController.swift
//  My personnal Actuality
//
//  Created by Philippe Donael Essono on 04/12/2018.
//  Copyright © 2018 Philippe Donael Essono. All rights reserved.
//

import Foundation
import UIKit

class AddActualityController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var Actualities: [Actuality]? = nil
    
    @IBOutlet weak var actualityName: UITextField!
    @IBOutlet weak var actuality: UITextField!
    
    @IBOutlet weak var TypeOfActuality: UIPickerView!
    let typeofActuality = ["YouTube", "Google Search", "Google Actuality"]
    var TypeOfActualitySelected = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        TypeOfActuality.delegate = self
        TypeOfActuality.dataSource = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeofActuality.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeofActuality[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        TypeOfActualitySelected = typeofActuality[row]
        
    }
    
    @IBAction func addActuality(_ sender: Any) {
        if actualityName.text != "" && actuality.text != "" {
        var mot = ""
        let activityCreate = Actuality(context: persistence.context)
        
        for lettre in (actuality?.text)! {
            if lettre != " " {
                mot.append(lettre)
            }
            else{
                mot.append("+")
            }
        }
        
        activityCreate.name = actualityName.text
        activityCreate.actuality = mot
        activityCreate.actualityType = TypeOfActualitySelected
        persistence.saveContext()
        Actualities?.append(activityCreate)
        performSegue(withIdentifier: "BackListActualities", sender: nil)
        }
    }
    
    @IBAction func BackListActuality(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let listActualities = segue.destination as? ViewController
        listActualities?.Actualities = self.Actualities!
    }
}
