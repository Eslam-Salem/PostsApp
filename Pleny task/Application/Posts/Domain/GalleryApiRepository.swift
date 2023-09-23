//
//  GalleryApiRepository.swift
//  Pleny task
//
//  Created by Eslam Salem on 23/09/2023.
//

import Foundation

protocol GalleryApiRepository {
    func getPosts(page: Int, completion: @escaping (_ :PostsDomainModel?, _ :String?) -> Void)
    func searchPosts(page: Int, query: String, completion: @escaping (_ :PostsDomainModel?, _ :String?) -> Void)
}
