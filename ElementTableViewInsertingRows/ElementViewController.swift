//
//  ViewController.swift
//  ElementTableView
//
//  Created by Ani Adhikary on 18/11/17.
//  Copyright © 2017 Ani Adhikary. All rights reserved.
//

import UIKit

class ElementViewController: UIViewController {
    
    @IBOutlet weak var elementTableView: UITableView!
    var elements = [Element]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        elementTableView.allowsSelectionDuringEditing = true
        loadElements()
    }
    
    func loadElements() {
        elements = [
            Element(elementName: "Hydrogen", elementSymbol: "H"),
            Element(elementName: "Helium", elementSymbol: "He"),
            Element(elementName: "Lithium", elementSymbol: "Li"),
            Element(elementName: "Beryllium", elementSymbol: "Be"),
            Element(elementName: "Boron", elementSymbol: "B"),
            Element(elementName: "Carbon", elementSymbol: "C"),
            Element(elementName: "Nitrogen", elementSymbol: "N"),
            Element(elementName: "Oxygen", elementSymbol: "O"),
            Element(elementName: "Fluorine", elementSymbol: "F"),
            Element(elementName: "Neon", elementSymbol: "Ne"),
            Element(elementName: "Sodium", elementSymbol: "Na"),
            Element(elementName: "Magnesium", elementSymbol: "Mg"),
            Element(elementName: "Aluminum", elementSymbol: "Al"),
            Element(elementName: "Silicon", elementSymbol: "Si"),
            Element(elementName: "Phosphorus", elementSymbol: "P"),
            Element(elementName: "Sulfur", elementSymbol: "S"),
            Element(elementName: "Chlorine", elementSymbol: "Cl"),
            Element(elementName: "Argon", elementSymbol: "Ar"),
            Element(elementName: "Potassium", elementSymbol: "K"),
            Element(elementName: "Calcium", elementSymbol: "Ca"),
            Element(elementName: "Scandium", elementSymbol: "Sc")
        ]
    }
}

extension ElementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let adjustment = isEditing ? 1 : 0
        return elements.count + adjustment
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let elementCell = tableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath)
        
        if indexPath.row >= elements.count && isEditing {
            elementCell.textLabel?.text = "Add new Element"
            elementCell.detailTextLabel?.text = nil
        } else {
            let element = elements[indexPath.row]
            elementCell.textLabel?.text = element.elementName
            elementCell.detailTextLabel?.text = element.elementSymbol
        }
        
        return elementCell
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing {
            elementTableView.beginUpdates()
            let indexPath = IndexPath(row: elements.count, section: 0)
            elementTableView.insertRows(at: [indexPath], with: .automatic)
            elementTableView.endUpdates()
            elementTableView.setEditing(true, animated: true)
        } else {
            
            elementTableView.beginUpdates()
            let indexPath = IndexPath(row: elements.count, section: 0)
            elementTableView.deleteRows(at: [indexPath], with: .automatic)
            elementTableView.endUpdates()
            elementTableView.setEditing(false, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            elements.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        } else if editingStyle == .insert {
            let elementToAdd = Element(elementName: "New Element", elementSymbol: "El")
            elements.append(elementToAdd)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
}

extension ElementViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if indexPath.row >= elements.count {
            return .insert
        } else {
            return .delete
        }
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if isEditing && indexPath.row < elements.count {
            return nil
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row >= elements.count && isEditing {
            self.tableView(tableView, commit: .insert, forRowAt: indexPath)
        }
    }
}
