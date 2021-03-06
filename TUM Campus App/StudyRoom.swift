//
//  StudyRoom.swift
//  TUM Campus App
//
//  This file is part of the TUM Campus App distribution https://github.com/TCA-Team/iOS
//  Copyright (c) 2018 TCA
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, version 3.
//
//  This program is distributed in the hope that it will be useful, but
//  WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
//  General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program. If not, see <http://www.gnu.org/licenses/>.
//

import Sweeft

class StudyRoom: DataElement {
    
    let status: StudyRoomStatus
    
    let roomNumber: Int
    let code: String
    let architectNumber: String
    let name: String
    
    let occupiedUntil: Date?
    let occupiedFor: Int
    let occupiedFrom: Date?
    let occupiedIn: Int
    let occupiedBy: String
    
    let buildingName: String
    
    init(status: StudyRoomStatus,
         roomNumber: Int,
         code: String,
         architectNumber: String,
         name: String,
         occupiedUntil: Date?,
         occupiedFor: Int,
         occupiedFrom: Date?,
         occupiedIn: Int,
         occupiedBy: String,
         buildingName: String) {
        self.status = status
        self.roomNumber = roomNumber
        self.code = code
        self.architectNumber = architectNumber
        self.name = name
        self.occupiedUntil = occupiedUntil
        self.occupiedFor = occupiedFor
        self.occupiedFrom = occupiedFrom
        self.occupiedIn = occupiedIn
        self.occupiedBy = occupiedBy
        self.buildingName = buildingName
    }
    
    convenience init?(from json: JSON) {
        guard let status = StudyRoomStatus(rawValue: json["status"].string ?? ""),
            let roomNumber = json["raum_nr"].int,
            let code = json["raum_code"].string,
            let architectNumber = json["raum_nr_architekt"].string,
            let name = json["raum_name"].string,
            let occupiedUntilString = json["belegung_bis"].string,
            let occupiedFor = json["belegung_fuer"].int,
            let occupiedFromString = json["belegung_ab"].string,
            let occupiedIn = json["belegung_in"].int,
            let occupiedBy = json["belegung_durch"].string,
            let buildingName = json["gebaeude_name"].string else {
                return nil
        }
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let occupiedUntil = dateformatter.date(from: occupiedUntilString)
        let occupiedFrom = dateformatter.date(from: occupiedFromString)
        self.init(status: status, roomNumber: roomNumber, code: code,
                  architectNumber: architectNumber, name: name, occupiedUntil: occupiedUntil,
                  occupiedFor: occupiedFor, occupiedFrom: occupiedFrom, occupiedIn: occupiedIn,
                  occupiedBy: occupiedBy, buildingName: buildingName)
    }
    
    // Returns a verbose string like "Free" or "Occupied until 14:45"
    var nextEvent: String {
        switch status {
        case .Free:
            return NSLocalizedString("Free", comment: "")
        case .Occupied:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            if (occupiedUntil != nil) {
                let time = dateFormatter.string(from: occupiedUntil!)
                return NSLocalizedString("Occupied until \(time)", comment: "")
            } else {
                return NSLocalizedString("Occupied", comment: "")
            }
        }
    }
    
    var text: String {
        return "\(code) \(name)"
    }
    func getCellIdentifier() -> String {
        return "studyRoom"
    }
}
