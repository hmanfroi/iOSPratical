
import Foundation

struct Task: Decodable, Equatable {
    
    internal init(taskText: String, taskDone: Bool) {
        self.taskText = taskText
        self.taskDone = taskDone
    }
    
    var taskText: String
    var taskDone: Bool
}

extension Task {
    init(
        _ text: String,
        _ done: Bool = false
    ){
        taskText = text
        taskDone = done
    }
}

