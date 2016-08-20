//
//  WhoChatViewController.m
//  MBChatView
//
//  Created by Mitul Bhadeshiya on 17/08/16.
//  Copyright © 2016 Mitul Bhadeshiya. All rights reserved.
//

#import "WhoChatViewController.h"

@interface WhoChatViewController ()

@end

@implementation WhoChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title= @"Light Chat";
    
    [self setDefaultMessages:[self defaultMessages]];
    
    
    // SET BACK GROUND IMAGE  OPTIONAL
    //[self setBackgroundColor:[UIColor lightGrayColor]];
    
    
    
    // SET BACK GROUND IMAGE  OPTIONAL
    [self setBackGroundImage:[UIImage imageNamed:@"BGG"]];
}

-(NSArray *)defaultMessages
{
    NSMutableArray *arr =[[NSMutableArray alloc]init];
    
    MBChat *chat =[[MBChat alloc]init];
    chat.message = @"Hi there how are you ?";
    chat.timestamp = @"14342323123";
    chat.isMe = NO;
    chat.isRead = YES;
    
    [arr addObject:chat];
    
    MBChat *chat1 =[[MBChat alloc]init];
    chat1.message = @"i am fine";
    chat1.timestamp = @"14342323123";
    chat1.isMe = YES;
    chat1.isRead = YES;
    
    [arr addObject:chat1];
    
    MBChat *chat2 =[[MBChat alloc]init];
    chat2.message = @"What about you?";
    chat2.timestamp = @"14342323123";
    chat2.isMe = YES;
    chat2.isRead = YES;
    [arr addObject:chat2];
    
    return arr;
}

-(void)setMessageWithMessage:(NSString *)msg
{
    MBChat *chat = [[MBChat alloc]init];
    chat.message = msg;
    chat.isMe  = YES;
    [self sendMessage:chat];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
