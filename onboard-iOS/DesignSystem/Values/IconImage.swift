//
//  IconImage.swift
//  onboard-iOS
//
//  Created by 혜리 on 2023/10/09.
//

import UIKit

enum IconImage {
    case search
    case search_gray
    
    case X
    case X_gray
    
    case plus
    case plusButton
    
    case manager
    case code
    case member
    
    case gold
    case sliver
    case bronze
    
    case circleX
    case back
    
    case galleryDefault
    case gallery
    
    case copyDefault
    case copy
    
    case deselect
    case selected
    case select
    case select2
    
    case eyeDefault
    case eye
    
    case myDefault
    case my
    case me
    
    case rank3Default
    case rank3
    case rank3Default2
    
    case rank1Default
    case rank1
    
    case hambugerDefault
    case hambuger
    
    case settingDefault
    case setting
    
    case meatballDefault
    case meatball
    
    case nextDefault
    
    case calendarFill1
    case calendarFill2
    case calendarLine1
    case calendarLine2
    
    case timeFill1
    case timeFill2
    case timeLine1
    case timeLine2
    
    case iconHome
    
    case dice
    case emptyDice
    
    case requiredInput
    
    var image: UIImage? {
        switch self {
        case .search:
            return UIImage(named: "icon_search")
        case .search_gray:
            return UIImage(named: "icon_search_gray")
            
        case .X:
            return UIImage(named: "icon_X")
        case .X_gray:
            return UIImage(named: "icon_X2")
            
        case .plus:
            return UIImage(named: "icon_plus")
        case .plusButton:
            return UIImage(named: "icon_plusButton")
            
        case .manager:
            return UIImage(named: "icon_manager")
        case .code:
            return UIImage(named: "icon_code")
        case .member:
            return UIImage(named: "icon_member")
            
        case .gold:
            return UIImage(named: "icon_gold")
        case .sliver:
            return UIImage(named: "icon_sliver")
        case .bronze:
            return UIImage(named: "icon_bronze")
            
        case .circleX:
            return UIImage(named: "icon_circleX")
        case .back:
            return UIImage(named: "icon_back")
            
        case .galleryDefault:
            return UIImage(named: "icon_gallery_default")
        case .gallery:
            return UIImage(named: "icon_gallery")
            
        case .copyDefault:
            return UIImage(named: "icon_copy_default")
        case .copy:
            return UIImage(named: "icon_copy")
            
        case .deselect:
            return UIImage(named: "icon_deselect")
        case .selected:
            return UIImage(named: "icon_selected")
        case .select:
            return UIImage(named: "icon_select")
        case .select2:
            return UIImage(named: "icon_select2")
            
        case .eyeDefault:
            return UIImage(named: "icon_eye_default")
        case .eye:
            return UIImage(named: "icon_eye")
            
        case .myDefault:
            return UIImage(named: "icon_myDefault")
        case .my:
            return UIImage(named: "icon_my")
        case .me:
            return UIImage(named: "icon_me")
            
        case .rank3Default:
            return UIImage(named: "icon_rank3_default")
        case .rank3:
            return UIImage(named: "icon_rank3")
        case .rank3Default2:
            return UIImage(named: "icon_rank3_2")
            
        case .rank1Default:
            return UIImage(named: "icon_rank1_default")
        case .rank1:
            return UIImage(named: "icon_rank1")
            
        case .hambugerDefault:
            return UIImage(named: "icon_hambuger_default")
        case .hambuger:
            return UIImage(named: "icon_hambuger")
            
        case .settingDefault:
            return UIImage(named: "icon_setting_default")
        case .setting:
            return UIImage(named: "icon_setting")
            
        case .meatballDefault:
            return UIImage(named: "icon_meatball_default")
        case .meatball:
            return UIImage(named: "icon_meatball")
            
        case .nextDefault:
            return UIImage(named: "icon_next_default")
            
        case .calendarFill1:
            return UIImage(named: "icon_calendar_fill16")
        case .calendarFill2:
            return UIImage(named: "icon_calendar_fill24")
        case .calendarLine1:
            return UIImage(named: "icon_calendar_line16")
        case .calendarLine2:
            return UIImage(named: "icon_calendar_line24")
            
        case .timeFill1:
            return UIImage(named: "icon_time_fill16")
        case .timeFill2:
            return UIImage(named: "icon_time_fill24")
        case .timeLine1:
            return UIImage(named: "icon_time_line16")
        case .timeLine2:
            return UIImage(named: "icon_time_line24")
            
        case .iconHome:
            return UIImage(named: "icon_home")
            
        case .dice:
            return UIImage(named: "icon_dice")
        case .emptyDice:
            return UIImage(named: "icon_empty_dice")
            
        case .requiredInput:
            return UIImage(named: "icon_requiredInput")
        }
    }
}
