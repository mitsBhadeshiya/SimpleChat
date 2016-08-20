//
//  MBChatViewController.h
//  MBChatView
//
//  Created by Mitul Bhadeshiya on 17/08/16.
//  Copyright © 2016 Mitul Bhadeshiya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBChatCell.h"
#import "MBExpandingTextView.h"

@interface MBChatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource , ExpandingTextViewDelegate >
{
    UIImageView *imgBG;
    UITableView *tblChat;
    NSMutableArray	*messages;
    UIView *containerView;
    
    MBExpandingTextView *textView;
    
}
-(void)setBackGroundImage:(UIImage *)img;
-(void)setBackgroundColor:(UIColor *)color;

-(void)setDefaultMessages:(NSArray *)arrMsg;
-(void)sendMessage:(MBChat *)msg;
-(void)reloadChat;

-(void)setMessageWithMessage:(NSString *)msg;




@end
