//
//  MBChatCell.h
//  MBChatView
//
//  Created by Mitul Bhadeshiya on 17/08/16.
//  Copyright © 2016 Mitul Bhadeshiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBChat.h"

@interface MBChatCell : UITableViewCell
{
    UILabel	*senderAndTimeLabel;
    UITextView *messageContentView;
    UIImageView *bgImageView;
}

@property (nonatomic,strong) UILabel *senderAndTimeLabel;
@property (nonatomic,strong) UITextView *messageContentView;
@property (nonatomic,strong) UIImageView *bgImageView;

-(void)setChatdata:(MBChat *)chat;


@end
