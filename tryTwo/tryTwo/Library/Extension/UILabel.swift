//
//  UILabelDate.swift
//  filmInfo
//
//  Created by fivecoil on 23/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

//MARK: - extensions for converts Models date to Month 10 1993 format
extension UILabel {
    
    //for movie
    func setYear(_ movie: Movie) {
        let releaseDate = movie.releaseDate
        let date = releaseDate.split(separator: "-")
        if !date.isEmpty {
            let year = date[0]
            let day = date[2]
            var month: MonthPick = .undefined
            switch date[1] {
            case "01":
                month = .january
            case "02":
                month = .february
            case "03":
                month = .march
            case "04":
                month = .april
            case "05":
                month = .may
            case "06":
                month = .june
            case "07":
                month = .july
            case "08":
                month = .august
            case "09":
                month = .september
            case "10":
                month = .october
            case "11":
                month = .november
            case "12":
                month = .december
            default:
                month = .undefined
            }
            self.text = "\(month.rawValue) \(day), \(year)"
        }
        else {
            self.text = "Unknow"
        }
    }
    
    //for Welcome
    func setYear(_ film: Result) {
        guard let releaseDate = film.releaseDate else { return }
        let date = releaseDate.split(separator: "-")
        if !date.isEmpty {
            let year = date[0]
            let day = date[2]
            var month: MonthPick = .undefined
            switch date[1] {
            case "01":
                month = .january
            case "02":
                month = .february
            case "03":
                month = .march
            case "04":
                month = .april
            case "05":
                month = .may
            case "06":
                month = .june
            case "07":
                month = .july
            case "08":
                month = .august
            case "09":
                month = .september
            case "10":
                month = .october
            case "11":
                month = .november
            case "12":
                month = .december
            default:
                month = .undefined
            }
            self.text = "\(month.rawValue) \(day), \(year)"
        }
        else {
            self.text = "Unknow"
        }
    }
}
