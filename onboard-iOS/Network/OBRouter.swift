//
//  OBRouter.swift
//  onboard-iOS
//
//  Created by Daye on 2023/09/17.
//

import Foundation

import Alamofire

import ReactorKit

enum OBRouter: URLRequestConvertible {
    
    // MARK: - Properties
    
    typealias Header = [String: Any]
    typealias Body = [String: Any]
    typealias Params = [String: Any]
    
    var baseURL: URL {
        return URL(string: API.BASE_URL)!
    }
    
    // MARK: - APIs
    
    // Group
    case groupList(params: Params) // 그룹 리스트 가져오기
    case groupInfo(groupId: Int) // 단일 그룹 상세 정보 보기
    
    case groupDelete(groupId: Int) // 그룹 삭제하기, Onwer만 가능
    case groupAccessCodeCheck(groupId: Int, accessCode: String) // 그룹 id 가지고 액세스 코드 확인
    case gameLeaderboard(groupId: Int, gameId: Int)
    
    // Match
    case match(body: Body)
    
    // Terms
    
    // Auth
    
    // Setting
    
    // User
    
    case getMe // 내 기본 정보 가져오기
    case setUser(body: Body)
    case getMyGroupsV2 // 내가 가입한 그룹 목록 가져오기 v2
    
    // Game
    
    // Member
    case joinGroupHost(groupId: Int, nickname: String, accessCode: String, guestId: String?) //guest id 설정시 닉네임 무시되고 게스트계정으로 가입됨
    
    case myGroupUnsubscribe(groupId: Int)
    case validateNickname(groupId: Int, nickname: String) //닉네임 유효성 체크
    
    // File
    
    // 정리안됨
    case testAPI
    case forceUpdateTest
    
    // Auth
    case auth(body: Body)
    
    // Group
    case addGroup(body: Body)
    case gameList
    case createGroup(body: Body)
    
    // Group Image
    case pickerImage(params: Params)
    case randomImage
    case getTerms
    case groupMemeberPatch(groupId: Int, userId: Int)
    case groupMembers(groupId: Int)
    case addGroupGuest(groupId: Int, nickName: String?)

    
    // Game
    case gameResult(params: Params)
    case gamePlayer(params: Params)
    case addPlayer(params: Params, body: Body)
    
    // MARK: - HTTP Method
    
    var method: HTTPMethod {
        switch self {
        case .testAPI, .groupList, .gameList, .randomImage, .getTerms, .gameResult, .gamePlayer, .groupMembers, .groupInfo, .getMe, .getMyGroupsV2, .validateNickname, .forceUpdateTest, .gameLeaderboard:
            return .get
        case .auth, .addGroup, .pickerImage, .createGroup, .addGroupGuest, .addPlayer, .groupAccessCodeCheck, .joinGroupHost, .match:
            return .post
        case .setUser:
            return .put
        case .groupMemeberPatch:
            return .patch
        case .myGroupUnsubscribe, .groupDelete:
            return .delete
        }
    }
    
    // MARK: - Path
    
    var path: String {
        switch self {
        case .testAPI:
            return "api/v1/test"
        case .auth:
            return "api/v1/auth/login"
        case .groupList, .addGroup:
            return "api/v1/group"
        case .setUser, .getMe:
            return "api/v1/user/me"
        case .gameList:
            return "api/v1/group/0/game"
        case .pickerImage:
            return "api/v1/file"
        case .randomImage:
            return "api/v1/group/default-image"
        case .createGroup:
            return "api/v1/group"
        case .getTerms:
            return "api/v1/terms"
        case let .groupMemeberPatch(groupId, userId):
            return "api/v1/group/\(groupId)/member/\(userId)"
        case let .groupMembers(groupId):
            return "api/v1/group/\(groupId)/member"
        case let .addGroupGuest(groupId, _):
            return "api/v1/group/\(groupId)/guest"
        case let .groupInfo(groupId):
            return "api/v1/group/\(groupId)"
        case .getMyGroupsV2:
            return "api/v1/user/me/group"
        case .gameResult:
            let groupId = GameDataSingleton.shared.getGroupId()!
            return "api/v1/group/\(groupId)/game"
        case .gamePlayer:
            let groupId = GameDataSingleton.shared.getGroupId()!
            return "api/v1/group/\(groupId)/member"
        case let .myGroupUnsubscribe(groupId):
            return "api/v1/group/\(groupId)/me"
        case let .groupDelete(groupId):
            return "api/v1/group/\(groupId)"
        case .addPlayer:
            let groupId = GameDataSingleton.shared.getGroupId()!
            return "api/v1/group/\(groupId)/guest"
        case let .groupAccessCodeCheck(groupId, _):
            return "api/v1/group/\(groupId)/accessCode"
        case let .validateNickname(groupId, _):
            return "api/v1/group/\(groupId)/member/validateNickname"
        case let .joinGroupHost(groupId, _, _, _):
            return "api/v1/group/\(groupId)/host"
        case .forceUpdateTest:
            return "api/v1/test/force-update"
        case let .gameLeaderboard(groupId, gameId):
            return "api/v1/group/\(groupId)/game/\(gameId)"
        case .match:
            return "api/v1/match"
        }
    }
    
    // MARK: - Header
    
    var header: Header? {
        switch self {
        case .testAPI, .auth, .addGroup, .groupList, .randomImage, .validateNickname:
            return nil
        case .setUser, .gameList, .getTerms, .createGroup, .groupMemeberPatch, .groupMembers, .addGroupGuest, .groupInfo, .getMe, .getMyGroupsV2, .gameResult, .gamePlayer, .myGroupUnsubscribe, .groupDelete, .groupAccessCodeCheck, .joinGroupHost, .addPlayer, .forceUpdateTest, .gameLeaderboard, .match :
            return ["Authorization": "Bearer \(LoginSessionManager.getLoginSession()?.accessToken ?? "")"]
        case .pickerImage:
            return ["Authorization": "Bearer \(LoginSessionManager.getLoginSession()?.accessToken ?? "")",
                    "content-type": "multipart/form-data"]
        }
    }
    
    // MARK: - Request Body
    
    var body: Body? {
        switch self {
        case let .addGroupGuest(_, nickname):
            return ["nickname": nickname ?? "x"]
            
        case let .groupAccessCodeCheck(groupId, accessCode):
            return ["accessCode": accessCode]
            
        case let .joinGroupHost(groupId, nickname, accessCode, guestId):
            if let guest = guestId {
                return ["guestId": guest, "accessCode": accessCode]
            } else {
                return ["nickname": nickname, "accessCode": accessCode]
            }
            
        case .testAPI, .groupList, .gameList, .pickerImage, .randomImage, .getTerms, .groupMemeberPatch, .groupMembers, .groupInfo, .getMe, .getMyGroupsV2, .gameResult, .gamePlayer, .myGroupUnsubscribe, .groupDelete, .validateNickname, .forceUpdateTest, .gameLeaderboard:
            return nil
            
        case let .auth(body), let .addGroup(body), let .setUser(body), let .createGroup(body), let .match(body):
            return body
            
        case let .addPlayer(_, body):
            return body
        }
    }
    
    // MARK: - Request Params
    
    var params: Params? {
        switch self {
        case .testAPI, .auth, .addGroup, .setUser, .gameList, .randomImage, .createGroup, .getTerms, .groupMemeberPatch, .addGroupGuest, .groupInfo, .getMe, .getMyGroupsV2, .myGroupUnsubscribe, .groupDelete, .groupAccessCodeCheck, .joinGroupHost, .forceUpdateTest, .gameLeaderboard, .match:
            return nil
        case let .groupList(params):
            return params
        case let .pickerImage(params):
            return params
        case let .groupMembers(groupId):
            return ["groupId": groupId, "size": 100]
        case let .validateNickname(_, nickname):
            return ["nickname": nickname]
        case let .gameResult(params), let .gamePlayer(params), let .addPlayer(params, _):
            return params
        }
    }
    
    // MARK: - URL Request
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.method = method
        
        header?.forEach({ element in
            request.setValue("\(element.value)", forHTTPHeaderField: element.key)
        })
        
        params?.forEach({ element in
            request.url?.append(queryItems: [URLQueryItem(name: element.key, value: "\(element.value)")])
        })
        
        request = try JSONEncoding.default.encode(
            request,
            with: body
        )
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Accept"
        )
        
        return request
    }
}
