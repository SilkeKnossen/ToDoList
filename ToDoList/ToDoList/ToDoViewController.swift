//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Silke Knossen on 27/11/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {
    
    // Initialize the picker hidden
    var isEndDatePickerHidden = true
    
    // Initialize the TODO with an optional.
    var todo: ToDo?
    
    // Initialize all outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /* When the view did load, set all outlets with the variables
     * from the ToDo-struct if there is one, else only set the date
     * from the date picker.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = todo {
            navigationItem.title = "ToDo"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        }
        updateDueDateLabel(date: dueDatePickerView.date)
        updateSaveButtonState()
    }
    
    // Make sure only the save button can be tapped if the ToDo has a title.
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    // Check for an update for the save button if the ToDo-title changes.
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    // When the return key is pressed, set the textField.
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }
    
    // Set the complete button if it is tapped.
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }

    // Updates the due date button text with the data from the date picker.
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    // When the date picker changes, update the due date button text.
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }
    
    /* Set the height for each cell. When the due date button is tapped,
     * expand the cell to a large cell. Notes have large cells.
     */
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
        switch(indexPath) {
        case [1,0]: // Due Date Cell
        return isEndDatePickerHidden ? normalCellHeight : largeCellHeight
        
        case [2,0]: // Notes Cell
        return largeCellHeight
        
        default: return normalCellHeight
        }
    }
    
    /* If due date button is selected, enable the date picker and set
     * color of the button text.
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath) {
        case [1,0]:
        isEndDatePickerHidden = !isEndDatePickerHidden
        
        dueDateLabel.textColor =
        isEndDatePickerHidden ? .black : tableView.tintColor
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        default: break
        }
    }
    
    // Before going back to the previous view, change the variables in the ToDo-struct.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
    }

}
