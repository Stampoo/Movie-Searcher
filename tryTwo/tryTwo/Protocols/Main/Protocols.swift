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
    func setupInitialState()
    
    //configure view
    func configure(with list: [Result],  use: Use)
    
}

//ViewInput
//Реализует Presenter, ссылка у View
protocol MainViewOutput: class {
    
    //notify
    func viewLoaded()
    
    //reload view
    func reload()

    //sendData
    func send(key word: String)
    
}

//ModuleInput
//Реализует Presenter
protocol ModuleInput: class {
    
    //configure
    func configureModule(with list: MovieList)
    
}

//ModuleOutput
//Реализует Presenter, на модуль которого осуществляется переход
protocol ModuleOutput: class {
    
    //notify
    func moduleEdited()
    
}


//RouterInput

protocol RouterInput {
    
    func showModule()

}

