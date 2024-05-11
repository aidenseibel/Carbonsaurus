//
//  DataModel.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 5/11/24.
//

import Foundation

struct DataModel{
    // saves the local user locally, returns true if successful.
    // since User is already Codable, most of the work is done for us.
    static func saveLocalUserToUserDefaults(user: User) -> Bool{
        do {
            // encode the user
            let encoder = JSONEncoder()
            let data = try encoder.encode(user)

            // save and return true
            UserDefaults.standard.set(data, forKey: "localUser")
            
            print("Successfully saved localUser to UserDefaults")
            return true
        } catch {
            print("Unable to encode localUser when setting to UserDefaults: \(error)")
        }
        return false
    }
    
    // loads in the local user on launch.
    static func getLocalUserFromAppStorage() -> User?{
        if let data = UserDefaults.standard.data(forKey: "localUser") {
            do {
                // try to decode
                let decoder = JSONDecoder()
                let localUser = try decoder.decode(User.self, from: data)
                
                print("Successfully fetched localUser from UserDefaults")
                return localUser
            } catch {
                print("Unable to decode localUser when getting from UserDefaults: \(error)")
            }
        }
        return nil
    }
}
