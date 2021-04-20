//
//  PostsStorage.swift
//  FirstCourseFinalTask
//
//  Created by 18774669 on 11.03.2021.
//  Copyright © 2021 E-Legion. All rights reserved.
//

import Cocoa
import FirstCourseFinalTaskChecker

class PostsStorage: PostsStorageProtocol {
    
    var posts: [PostInitialData]
    var likes: [(GenericIdentifier<UserProtocol>, GenericIdentifier<PostProtocol>)]
    var currentUserID: GenericIdentifier<UserProtocol>
    
    var count: Int {
        return posts.count
    }
    
    required init(posts: [PostInitialData], likes: [(GenericIdentifier<UserProtocol>, GenericIdentifier<PostProtocol>)], currentUserID: GenericIdentifier<UserProtocol>) {
        self.posts = posts
        self.likes = likes
        self.currentUserID = currentUserID
    }

    
    func post(with postID: GenericIdentifier<PostProtocol>) -> PostProtocol? {
        return nil
    }
    
    func findPosts(by authorID: GenericIdentifier<UserProtocol>) -> [PostProtocol] {
        return []
    }
    
    func findPosts(by searchString: String) -> [PostProtocol] {
        return []
    }
    
    func likePost(with postID: GenericIdentifier<PostProtocol>) -> Bool {
        return false
    }
    
    func unlikePost(with postID: GenericIdentifier<PostProtocol>) -> Bool {
        return false
    }
    
    func usersLikedPost(with postID: GenericIdentifier<PostProtocol>) -> [GenericIdentifier<UserProtocol>]? {
        return nil
    }
    
}
