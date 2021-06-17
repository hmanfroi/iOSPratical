//
//  TaskListViewModelTests.swift
//  iOSPraticalTests
//
//  Created by Vinicius Chagas Soares on 27/05/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxTest
import Quick
import Nimble

@testable import iOSPratical

final class TaskListViewModelTests: QuickSpec {
    private var sut: TaskListViewModel!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    override func spec() {
        super.spec()
        
        start()
    }
    
    private func setup() {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()

        sut = TaskListViewModel(service: TaskListServiceMock())
    }
    
    private func start() {
        describe("TaskListViewModel") {
            context("quando for solicitado o carregamento das tasks") {
                beforeEach {
                    self.setup()
                    
                    self.scheduler.createHotObservable([.next(300, ())])
                        .bind(to: self.sut.getTasks)
                        .disposed(by: self.disposeBag)
                }
                
                it("deverá ser preenchida uma lista de tasks") {
                    let _ = self.sut.states.drive().disposed(by: self.disposeBag)
                    
                    let observer = self.scheduler.start({ self.sut.tasksList.asObservable() })
                    
                    expect(observer.events).to(contain([.next(300, [Task("Teste")])]))
                }
                
                it("deverá ser exibido o conteúdo da tela") {
                    let observer = self.scheduler.start({ self.sut.states.asObservable() })
                    
                    expect(observer.events).to(contain([.next(300, .showContent)]))
                }
            }
        }
        
        context("quando for selecionada uma task") {
            beforeEach {
                self.setup()
                
                self.scheduler.createHotObservable([.next(300, ())])
                    .bind(to: self.sut.getTasks)
                    .disposed(by: self.disposeBag)
                
                self.scheduler.scheduleAt(500) { self.sut.changeTask(row: 0) }
            }
            
            it("o estado da task deverá ser modificado") {
                let _ = self.sut.states.drive().disposed(by: self.disposeBag)
                
                let observer = self.scheduler.start({ self.sut.tasksList.asObservable() })
                
                expect(observer.events)
                    .to(contain([.next(300, [Task(taskText: "Teste", taskDone: false)])]))
                
                expect(observer.events)
                    .to(contain([.next(500, [Task(taskText: "Teste", taskDone: true)])]))
            }
        }
    }
}

final class TaskListServiceMock: TaskListServiceProtocol {
    func readTasks() -> Observable<[Task]> {
        return .just([Task("Teste")])
    }
}
