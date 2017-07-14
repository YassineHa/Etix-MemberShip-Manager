# EUM (Etix Users Manager)

[![N|Solid](https://www.siliconluxembourg.lu/wp-content/uploads/2016/10/Etix_Everywhere_Logo-400x300.png)](https://nodesource.com/products/nsolid)

For the rewrite of our rights system, this iOS app manages which user belongs to which organization.
this app provides a page that lists, for a given organization, the users that belong to it.
### Features
###### With this app, you can: 
  - list the users that belong to a specific organization
  - remove any user from the organization 
  - add any available user to the organization (a user can be member of multiple organizations) 

### Tech

this app uses a number of libraries:
* [Alamofire] - Alamofire is an HTTP networking library written in Swift.
* [SwiftyJSON] - SwiftyJSON makes it easy to deal with JSON data in Swift.

this app is written with:
* [Swift] - Apple programming language

the pattern design used is:
* [MVVM] - Model–view–viewmodel (MVVM) is a software architectural pattern.



### Get Started
Clone or Download the github project.
###### Important
make sure to open the xcworkspace (not the .xcodeproj in order to load the Pods).
###### to change the api urls go to Shared.swift and change the:
[Shared.swift]
```swift
    let baseUrl = URL(string: "http://localhost:3000/db")                       
    let usersUrl = URL(string: "http://localhost:3000/users")                  
    let membershipsUrl = URL(string: "http://localhost:3000/memberships")  
    let organizationsUrl = URL(string: "http://localhost:3000/organizations") 
```

#### MVVM

Each model have its own ViewModel, and each list of models goes through its Manager
  [User]  -->  [UsersManager] --> [UserViewModel]  --> [UsersViewController]

and all the networking and parsing data from the api function are implemented in:
[Client.swift]
example:
```swift
    // delete a membership by its id
    func DeleteMemberShip(deletedMembershipId: Int) {
        
        // the Url of the jsonObject to remove
        let deleteUrl = URL(string: "http://localhost:3000/memberships/\(deletedMembershipId)")
        
        // simple delete alamofire Request
        Alamofire.request(deleteUrl!, method: .delete)
            .responseJSON { response in
                if let error = response.result.error {
                    print(error)
                } else {
                    print("membership deleted")
                }
        }
    }
```
 
### To do (perspective)

 - Write MORE Tests
 - Add an offline mode

   [Client.swift]: <https://github.com/YassineHa/Etix-MemberShip-Manager/blob/master/EUM/Client.swift>
   [UsersViewController]: <https://github.com/YassineHa/Etix-MemberShip-Manager/blob/master/EUM/UsersViewController.swift>
   [UsersManager]: <https://github.com/YassineHa/Etix-MemberShip-Manager/blob/master/EUM/UsersManager.swift>
   [UserViewModel]: <https://github.com/YassineHa/Etix-MemberShip-Manager/blob/master/EUM/UserViewModel.swift>
   [User]: <https://github.com/YassineHa/Etix-MemberShip-Manager/blob/master/EUM/User.swift>
   [Shared.swift]: <https://github.com/YassineHa/Etix-MemberShip-Manager/blob/master/EUM/Shared.swift>
   [MVVM]: <https://fr.wikipedia.org/wiki/Modèle-vue-vue_modèle>
   [Swift]: <https://swift.org>
   [SwiftyJSON]: <https://github.com/SwiftyJSON/SwiftyJSON>
   [Alamofire]: <https://github.com/Alamofire/Alamofire>

