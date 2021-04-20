//
//  UserStorage.swift
//  FirstCourseFinalTask
//
//  Created by 18774669 on 11.03.2021.
//  Copyright © 2021 E-Legion. All rights reserved.
//

import Cocoa
import FirstCourseFinalTaskChecker

class User: UserProtocol {
    var id: Identifier
    
    var username: String
    
    var fullName: String
    
    var avatarURL: URL?
    
    var currentUserFollowsThisUser: Bool
    
    var currentUserIsFollowedByThisUser: Bool
    
    var followsCount: Int
    
    var followedByCount: Int
    
    init(id: Identifier,
         username: String,
         fullName: String,
         avatarURL: URL?,
         currentUserFollowsThisUser: Bool,
         currentUserIsFollowedByThisUser: Bool,
         followsCount: Int,
         followedByCount: Int
    ) {
        self.id = id
        self.username = username
        self.fullName = fullName
        self.avatarURL = avatarURL
        self.currentUserFollowsThisUser = currentUserFollowsThisUser
        self.currentUserIsFollowedByThisUser = currentUserIsFollowedByThisUser
        self.followsCount = followsCount
        self.followedByCount = followedByCount
    }
}

class UserStorage: UsersStorageProtocol {
    
    var users: [UserProtocol]
    var followers: [(GenericIdentifier<UserProtocol>, GenericIdentifier<UserProtocol>)]
    
    var count: Int {
        return users.count
    }
    
    let currentUserID: GenericIdentifier<UserProtocol>
    
    required init?(users: [UserInitialData],
                   followers: [(GenericIdentifier<UserProtocol>, GenericIdentifier<UserProtocol>)],
                   currentUserID: GenericIdentifier<UserProtocol>) {
        let validInit = users.contains{ $0.id == currentUserID }
        guard validInit else { return nil }
        self.users = [UserProtocol]()
        self.followers = followers
        self.currentUserID = currentUserID
        users.forEach { (initialData) in
            let user = User(id: initialData.id,
                            username: initialData.username,
                            fullName: initialData.fullName,
                            avatarURL: initialData.avatarURL,
                            currentUserFollowsThisUser: doesCurrentUserFollowsThisUser(followers: followers,
                                                                                       currentUserID: currentUserID,
                                                                                       userID: initialData.id),
                            currentUserIsFollowedByThisUser: doesCurrentUserIsFollowedByThisUser(followers: followers,
                                                                                                 currentUserID: currentUserID,
                                                                                                 userID: initialData.id),
                            followsCount: getFollowsCount(followers: followers,
                                                          userID: initialData.id),
                            followedByCount: getFollowedByCount(followers: followers,
                                                                userID: initialData.id)
                            )
            self.users.append(user)
        }
    }
    
    private func doesCurrentUserFollowsThisUser(followers: [(GenericIdentifier<UserProtocol>, GenericIdentifier<UserProtocol>)],
                                                currentUserID: GenericIdentifier<UserProtocol>,
                                                userID: GenericIdentifier<UserProtocol>) -> Bool {
        let filteredUsers = followers.filter { (followerID, followingID) -> Bool in
            return (followerID == currentUserID && followingID == userID)
        }
        return !filteredUsers.isEmpty
    }
    
    private func doesCurrentUserIsFollowedByThisUser(followers: [(GenericIdentifier<UserProtocol>, GenericIdentifier<UserProtocol>)],
                                                currentUserID: GenericIdentifier<UserProtocol>,
                                                userID: GenericIdentifier<UserProtocol>) -> Bool {
        let filteredUsers = followers.filter { (followerID, followingID) -> Bool in
            return (followerID == userID && followingID == currentUserID)
        }
        return !filteredUsers.isEmpty
    }
    
    private func getFollowsCount(followers: [(GenericIdentifier<UserProtocol>, GenericIdentifier<UserProtocol>)],
                                 userID: GenericIdentifier<UserProtocol>) -> Int {
        return followers.filter { (followerID, _) -> Bool in
            return followerID == userID
        }.count
    }
    
    private func getFollowedByCount(followers: [(GenericIdentifier<UserProtocol>, GenericIdentifier<UserProtocol>)],
                                 userID: GenericIdentifier<UserProtocol>) -> Int {
        return followers.filter { (_, followingID) -> Bool in
            return followingID == userID
        }.count
    }
    
    
    func currentUser() -> UserProtocol {
        // Force unwrap valid cause we checked in init for initial data contains current user
        return users.first{ $0.id == currentUserID }!
    }
    
    func user(with userID: GenericIdentifier<UserProtocol>) -> UserProtocol? {
        return users.first{ $0.id == userID }
    }
    
    func findUsers(by searchString: String) -> [UserProtocol] {
        return users.filter{ $0.fullName.contains(searchString) || $0.username.contains(searchString) }
    }
    
    func follow(_ userIDToFollow: GenericIdentifier<UserProtocol>) -> Bool {
        let firstUserWithID = users.first{ $0.id == userIDToFollow }
        guard firstUserWithID != nil else { return false }
        let needToFollow = followers.filter { (followerID, followingID) -> Bool in
            return (followerID == currentUserID && followingID == userIDToFollow)
        }.isEmpty
        if needToFollow {
            let followPair = (currentUserID, userIDToFollow)
            followers.append(followPair)
            let currentUser = user(with: currentUserID)
            let newCurrentUser: UserProtocol = User(id: currentUser?.id,
                                      username: currentUser?.username,
                                      fullName: currentUser?.fullName,
                                      avatarURL: currentUser?.avatarURL,
                                      currentUserFollowsThisUser: currentUser?.currentUserFollowsThisUser,
                                      currentUserIsFollowedByThisUser: currentUser?.currentUserIsFollowedByThisUser,
                                      followsCount: currentUser?.followsCount + 1,
                                      followedByCount: currentUser?.followedByCount + 1)
            
        }
        return true
    }
    
    func unfollow(_ userIDToUnfollow: GenericIdentifier<UserProtocol>) -> Bool {
        let unFollowPair = followers.filter { (followerID, followingID) -> Bool in
            return (followerID == currentUserID && followingID == userIDToUnfollow)
        }
        guard !unFollowPair.isEmpty else { return false }
        followers = followers.filter{ (followerID, followingID) -> Bool in
            return (followerID == currentUserID && followingID == userIDToUnfollow)
        }
        return true
    }
    
    func usersFollowingUser(with userID: GenericIdentifier<UserProtocol>) -> [UserProtocol]? {
        guard !users.filter({ $0.id == userID }).isEmpty else { return nil }
        let followersIDs = followers.compactMap{ (followerID, followingID) -> GenericIdentifier<UserProtocol>? in
            return followingID == userID ? followerID : nil
        }
        var followers: [UserProtocol]?
        followersIDs.forEach { (id) in
            followers?.append(contentsOf: users.filter{ $0.id == id })
        }
        return followers
    }
    
    func usersFollowedByUser(with userID: GenericIdentifier<UserProtocol>) -> [UserProtocol]? {
        guard !users.filter({ $0.id == userID }).isEmpty else { return nil }
        let followedIDs = followers.compactMap{ (followerID, followingID) -> GenericIdentifier<UserProtocol>? in
            return followerID == userID ? followingID : nil
        }
        var followed: [UserProtocol]?
        followedIDs.forEach { (id) in
            followed?.append(contentsOf: users.filter{ $0.id == id })
        }
        return followed
    }
}
