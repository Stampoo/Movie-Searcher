//
//  Protocols.swift
//  tryTwo
//
//  Created by fivecoil on 30/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import Foundation

//MARK: - Protocols MainView
//ViewInput
//Реализует View, ссылка у Presenter
protocol MainViewInput: class {
    
    //initial setup
    func setupInitialState(_ data: [Result])
    
    //configure view
    func configure(with list: [Result],  use: Category)
    
}


//ViewInput
//Реализует Presenter, ссылка у View
protocol MainViewOutput: class {
    
    //notify
    func viewLoaded()
    
    //reload view
    func reloadView()

    //sendData
    func send(key word: String)
    
    //present module
    func present(with data: Int)

    func popModule(animation: Bool)
    
}


//ModuleInput
//Реализует Presenter, который вызывает второй модуль 
protocol ModuleInput: class {
    
    //configure
    func configureModule(with list: MovieList)
    
}


//ModuleOutput
//Реализует Presenter, который вызывает второй модуль
protocol ModuleOutput: class {
    
    //notify
    func moduleEdited(complitionHandler: (_ data: Int) -> Void)
    
}


//RouterInput

protocol MainRouterInput {
    
    func showModule(_ moduleOutput: ModuleOutput)

    func popModule(animation: Bool)

}

