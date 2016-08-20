//
//  MBChat.h
//  MBChatView
//
//  Created by Mitul Bhadeshiya on 17/08/16.
//  Copyright © 2016 Mitul Bhadeshiya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBChat : NSObject

@property (nonatomic)BOOL isMe;
@property (nonatomic)BOOL isRead;
@property (strong , nonatomic)NSString *message;
@property (strong , nonatomic)NSString *timestamp;

@end
