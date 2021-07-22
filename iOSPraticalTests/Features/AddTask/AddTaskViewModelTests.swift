//
//  AddTaskViewModelTests.swift
//  iOSPraticalTests
//
//  Created by Vinicius Chagas Soares on 20/05/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxTest
import Quick
import Nimble

@testable import iOSPratical

final class AddTaskViewModelTests: QuickSpec {
    private var sut: AddTaskViewModel!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    override func spec() {
        super.spec()
        
        start()
    }
    
    private func setup(taskList: BehaviorRelay<[Task]>) {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        
        sut = AddTaskViewModel(taskList: taskList)
    }
    
    private func start() {
        
        describe("AddTaskViewModel") {
            context("Quando botão de adicionar task for pressionado") {
                let taskList: BehaviorRelay<[Task]> = .init(value: [])
                beforeEach {
                    self.setup(taskList: taskList)
                    
                    self.sut.output.didAddTask.drive().disposed(by: self.disposeBag)
                    
                    self.scheduler.createHotObservable([.next(300, "Teste")])
                        .bind(to: self.sut.input.title)
                        .disposed(by: self.disposeBag)
                    
                    self.scheduler.createHotObservable([.next(300, ())])
                        .bind(to: self.sut.input.button)
                        .disposed(by: self.disposeBag)
                }
                
                it("então nova task aparecerá na lista de tasks") {
                    let observer = self.scheduler.start({ taskList.asObservable() })
                    
                    expect(observer.events.count).to(equal(2))
                    expect(observer.events.last?.value.element?.first?.taskText).to(equal("Teste"))
                    expect(taskList.value.count).to(equal(1))
                    
                    expect(observer.events).to(contain([
                        .next(300, [Task("Teste", false)])
                    ]))
                }
            }
            
            context("Quando botão de adicionar task for pressionado") {
                let taskList: BehaviorRelay<[Task]> = .init(value: [])
                
                beforeEach {
                    self.setup(taskList: taskList)
                    
                    self.sut.output.didAddTask.drive().disposed(by: self.disposeBag)
                    
                    self.scheduler.createHotObservable([.next(100, "Teste 1")])
                        .bind(to: self.sut.input.title)
                        .disposed(by: self.disposeBag)
                    
                    self.scheduler.createHotObservable([.next(105, ())])
                        .bind(to: self.sut.input.button)
                        .disposed(by: self.disposeBag)
                    
                    self.scheduler.createHotObservable([.next(200, "Teste 2")])
                        .bind(to: self.sut.input.title)
                        .disposed(by: self.disposeBag)
                    
                    self.scheduler.createHotObservable([.next(205, ())])
                        .bind(to: self.sut.input.button)
                        .disposed(by: self.disposeBag)
                }
                
                it("então nova task aparecerá na lista de tasks") {
                    let observer = self.scheduler.start({ taskList.asObservable() })
                    
                    expect(observer.events.count).to(equal(2))
                    expect(observer.events.last?.value.element?.first?.taskText).to(equal("Teste 1"))
                    expect(observer.events.last?.value.element?.last?.taskText).to(equal("Teste 2"))
                    expect(taskList.value.count).to(equal(2))
                }
            }
        }
    }
}
