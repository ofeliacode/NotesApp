//
//  ViewController.swift
//  Notes
//
//  Created by Офелия Баширова on 26.11.2020.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {
    
    var items: Results<Item>!
    
    var isFilter = false
    
    @IBAction func addItem(_ sender: Any) {
        let item = Item()
        item.id = self.items.count + 1
        item.name = "task \(self.items.count + 1)"
        //добавляем в базу рилма новые итемы
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(item)
        try! realm.commitWrite()
        self.tableView.reloadData()
    }
    
    @IBAction func editItem(_ sender: Any) {
        let editItem = !tableView.isEditing
        self.tableView.setEditing(editItem, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = try! Realm()
        //Выбери все объекты типа рилм из базы данных
        self.items = realm.objects(Item.self) //.filter("id > 5")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell")
        let item = self.items[indexPath.row]
        let name = "name: \(item.name), id: \(item.id)"
        cell?.textLabel?.text = name
        return cell!
    }
    //метод вызывается при нажатии на кнопку delete cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let realm = try! Realm()
            let deletedItem = self.items[indexPath.row]
            realm.beginWrite()
            realm.delete(deletedItem)
            try! realm.commitWrite()
            self.tableView.reloadData()
        }
    }
}

