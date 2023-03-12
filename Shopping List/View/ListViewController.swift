//
//  ListViewController.swift
//  Shopping List
//
//  Created by Shishir_Mac on 12/3/23.
//

import UIKit
import CoreData

class ListViewController: UIViewController {
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var shareBarButton: UIBarButtonItem!
    @IBOutlet weak var deleteBarButton: UIBarButtonItem!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var listTableView: UITableView!
    
    var isdelete: Bool = false
    var isEdit: Bool = false
    
    var selectedRows = [IndexPath]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items: [Tasks]?
    var todoStruct = Todo(isMarked: false)
    
    private let cellIdentifier: String = "listCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.layer.cornerRadius = addButton.frame.width / 2
        addButton.dropShadow()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.separatorStyle = .none
        
        self.listTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        fetchPeople()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        let actionController = UIAlertController(title: "Add Tasks", message : nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Add", style: .default, handler: { (action) -> Void in
            if actionController.textFields![0].text == "" {
                print("Title")
            } else {
                let newTask = Tasks(context: self.context)
                newTask.title = actionController.textFields![0].text
                newTask.taskDone = false
                
                do {
                    try self.context.save()
                } catch {
                    
                }
                self.fetchPeople()
            }
        } )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        actionController.addAction(okAction)
        actionController.addAction(cancelAction)
        
        actionController.addTextField { textField -> Void in
            textField.placeholder = "Enter Title..."
        }
        
        self.present(actionController, animated: true, completion: nil)
        
    }
    
    @IBAction func editBarButtonAction(_ sender: UIBarButtonItem) {
        if isEdit != true {
            editBarButton.title = "Done"
            isEdit = true
        } else {
            editBarButton.title = "Edit"
            isEdit = false
        }
        
    }
    
    @IBAction func shareBarButtonAction(_ sender: UIBarButtonItem) {
        print("Share")
    }
    
    @IBAction func deleteBarButtonAction(_ sender: UIBarButtonItem) {
        
        if isdelete != true {
            deleteBarButton.tintColor = .systemCyan
            isdelete = true
            
        } else {
            deleteBarButton.tintColor = .systemRed
            isdelete = false
        }
    }
    
    // MARK: - Function
    func fetchPeople() {
        do {
            
            let request = Tasks.fetchRequest() as NSFetchRequest<Tasks>
            let sort = NSSortDescriptor(key: "title", ascending: true)
            request.sortDescriptors = [sort]
            
            self.items = try context.fetch(request)
            
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
            
        } catch {
            print("Error")
        }
    }
    
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ListTableViewCell {
            cell.configurateTheCell(items![indexPath.row])
            if selectedRows.contains(indexPath){
                cell.checkMarkButton.setImage(UIImage(named: "marked"), for: .normal)
                self.todoStruct.isMarked = true
            }
            else{
                cell.checkMarkButton.setImage(UIImage(named: "unmarked"), for: .normal)
                self.todoStruct.isMarked = false
            }
            cell.checkMarkButton.tag = indexPath.row
            cell.checkMarkButton.addTarget(self, action: #selector(checkBoxSelection(_:)), for: .touchUpInside)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEdit != false {
            let task = self.items![indexPath.row]
            
            let actionController = UIAlertController(title: "Edit Tasks", message : nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Save", style: .default, handler: { (action) -> Void in
                if actionController.textFields![0].text == "" {
                    print("Enter Task")
                } else {
                    
                    task.title = actionController.textFields![0].text
                    
                    do {
                        try self.context.save()
                    } catch {
                        
                    }
                    self.fetchPeople()
                }
                
            } )
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            
            actionController.addAction(okAction)
            actionController.addAction(cancelAction)
            
            actionController.addTextField { textField -> Void in
                textField.text = task.title
            }
            
            self.present(actionController, animated: true, completion: nil)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if isdelete != false {
            let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
                let personTORemove = self.items![indexPath.row]
                
                self.context.delete(personTORemove)
                
                do {
                    try self.context.save()
                } catch {
                    
                }
                
                self.fetchPeople()
            }
            return UISwipeActionsConfiguration(actions: [action])
        }
        return UISwipeActionsConfiguration()
    }
    
    
    @objc func checkBoxSelection(_ sender:UIButton) {
        let selectedIndexPath = IndexPath(row: sender.tag, section: 0)
        if self.selectedRows.contains(selectedIndexPath) {
            self.selectedRows.remove(at: self.selectedRows.firstIndex(of: selectedIndexPath)!)
        } else {
            self.selectedRows.append(selectedIndexPath)
        }
        self.listTableView.reloadData()
    }
    
}
