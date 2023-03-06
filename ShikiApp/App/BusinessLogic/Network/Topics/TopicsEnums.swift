//
//  TopicsEnums.swift
//  ShikiApp
//
//  Created by Алексей Шинкарев on 19.01.2023.
//

import Foundation

enum ForumParameter: String {
    case all
    case animanga
    case site
    case games
    case visualNovels = "vn"
    case contests
    case offtopic
    case clubs
    case myClubs = "my_clubs"
    case critiques
    case news
    case collections
    case articles
    case cosplay
}

enum LinkedTypeParameter: String, CaseIterable {
    case anime = "Anime"
    case manga = "Manga"
    case ranobe = "Ranobe"
    case character = "Character"
    case person = "Person"
    case club = "Club"
    case clubPage = "ClubPage"
    case critique = "Critique"
    case review = "Review"
    case contest = "Contest"
    case cosplayGallery = "CosplayGallery"
    case collection = "Collection"
    case article = "Article"
}

enum TopicTypeParameter: String {
    case topic = "Topic"
    case clubUserTopic = "Topics::ClubUserTopic"
    case entryTopic = "Topics::EntryTopic"
    case animeTopic = "Topics::EntryTopics::AnimeTopic"
    case articleTopic = "Topics::EntryTopics::ArticleTopic"
    case characterTopic = "Topics::EntryTopics::CharacterTopic"
    case clubPageTopic = "Topics::EntryTopics::ClubPageTopic"
    case clubTopic = "Topics::EntryTopics::ClubTopic"
    case collectionTopic = "Topics::EntryTopics::CollectionTopic"
    case contestTopic = "Topics::EntryTopics::ContestTopic"
    case cosplayGalleryTopic = "Topics::EntryTopics::CosplayGalleryTopic"
    case mangaTopic = "Topics::EntryTopics::MangaTopic"
    case personTopic = "Topics::EntryTopics::PersonTopic"
    case ranobeTopic = "Topics::EntryTopics::RanobeTopic"
    case critiqueTopic = "Topics::EntryTopics::CritiqueTopic"
    case reviewTopic = "Topics::EntryTopics::ReviewTopic"
    case newsTopic = "Topics::NewsTopic"
    case contestStatusTopic = "Topics::NewsTopics::ContestStatusTopic"
}

// MARK: - API restrictions enums

enum APIRestrictions: Int {
    case maxPages = 100_000
    case limit30 = 30
    case limit10 = 10
    case limit50 = 50
    case limit100 = 100
    case limit1000 = 1000
    case limit5000 = 5_000
}

// MARK: - API keys enums

enum APIKeys: String {
    case topic
    case page
    case limit
    case forum
    case type
    case linkedId = "linked_id"
    case linkedType = "linked_type"
    case userId = "user_id"
    case body
    case title
    case forumId = "forum_id"
    case isNickName = "is_nickname"
    case status
    case censored
    case targetId = "target_id"
    case targetType = "target_type"
    case search
    case order
    case kind
    case season
    case score
    case duration
    case rating
    case genre
    case studio
    case franchise
    case myList = "mylist"
    case ids
    case excludeIds = "exclude_ids"
    case text
    case chapters
    case episodes
    case rewatches
    case textHtml = "text_html"
    case volumes
    
}
