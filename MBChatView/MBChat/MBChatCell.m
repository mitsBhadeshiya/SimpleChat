//
//  MBChatCell.m
//  MBChatView
//
//  Created by Mitul Bhadeshiya on 17/08/16.
//  Copyright © 2016 Mitul Bhadeshiya. All rights reserved.
//

#import "MBChatCell.h"

#define FONT_MSG [UIFont systemFontOfSize:13.0]

#define FONT_MSG_DATE [UIFont systemFontOfSize:11.0]
#define padding  10.0

#define COLOR_CHAT_LEFT  [[UIColor alloc]initWithRed:(252.0f/255.0f) green:(252.0f/255.0f) blue:(252.0f/255.0f)  alpha:1.0f]

#define COLOR_CHAT_RIGHT  [[UIColor alloc]initWithRed:(241.0f/255.0f) green:(255.0f/255.0f) blue:(226.0f/255.0f)  alpha:1.0f]



//static CGFloat padding = 10.0;

@implementation MBChatCell

@synthesize messageContentView;
@synthesize senderAndTimeLabel;
@synthesize bgImageView;


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGRect windowFrm =[UIScreen mainScreen].bounds;
        
        bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:bgImageView];
        
        messageContentView = [[UITextView alloc] init];
        messageContentView.backgroundColor = [UIColor clearColor];
        messageContentView.font = FONT_MSG;
        messageContentView.editable = NO;
        messageContentView.scrollEnabled = NO;
        [messageContentView sizeToFit];
        [self.contentView addSubview:messageContentView];
        
        senderAndTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, windowFrm.size.width, 20)];
        senderAndTimeLabel.textAlignment = NSTextAlignmentCenter;
        senderAndTimeLabel.font = FONT_MSG_DATE;
        senderAndTimeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:senderAndTimeLabel];
        
        bgImageView.layer.cornerRadius = 4.0f;
        bgImageView.layer.borderWidth = 0.5f;
        bgImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        [messageContentView setTextContainerInset:UIEdgeInsetsZero];
        messageContentView.textContainer.lineFragmentPadding = 5;
    }
    return self;
}


-(void)setChatdata:(MBChat *)chat
{
    CGSize size = [self getDynamicHeightOflbl:chat.message font:FONT_MSG];
    size.width += (padding/2);
    self.messageContentView.attributedText = [self getattributedString:chat.message font:FONT_MSG];
    
    CGRect windowFrm =[UIScreen mainScreen].bounds;
    
    UIImage *bgImage = nil;
    
    if (!chat.isMe) { // left aligned
        
        bgImage = [[UIImage imageNamed:@""] stretchableImageWithLeftCapWidth:7  topCapHeight:7];
        
        
        
        CGFloat width = size.width < 100 ? 100 : size.width;
        
        NSLog(@"WIDTH - %f", width);
        
        [self.messageContentView setFrame:CGRectMake(5, 5, width, size.height)];
        
        [self.bgImageView setFrame:CGRectMake( self.messageContentView.frame.origin.x  ,
                                              self.messageContentView.frame.origin.y,
                                              self.messageContentView.frame.size.width ,
                                              size.height + 15 )];
        
        self.senderAndTimeLabel.textAlignment = NSTextAlignmentLeft;
        [self.senderAndTimeLabel setFrame:CGRectMake(10 ,
                                                     self.messageContentView.frame.size.height+ self.messageContentView.frame.origin.y ,
                                                     windowFrm.size.width - 20,
                                                     15)];
        
        self.bgImageView.backgroundColor =  COLOR_CHAT_LEFT;
        
    } else {
        
        bgImage = [[UIImage imageNamed:@""] stretchableImageWithLeftCapWidth:7  topCapHeight:7];
        
        CGFloat width = size.width < 100 ? 100 : size.width;
        
        [self.messageContentView setFrame:CGRectMake(windowFrm.size.width - width - 5 ,
                                                     5 ,
                                                     width,
                                                     size.height)];
        [self.bgImageView setFrame:CGRectMake(self.messageContentView.frame.origin.x,
                                              self.messageContentView.frame.origin.y,
                                              width,
                                              size.height + 15)];
        
        self.bgImageView.backgroundColor =  COLOR_CHAT_RIGHT;
        
        self.senderAndTimeLabel.textAlignment = NSTextAlignmentRight;
        
        [self.senderAndTimeLabel setFrame:CGRectMake(10 ,
                                                     self.messageContentView.frame.size.height+ self.messageContentView.frame.origin.y ,
                                                     windowFrm.size.width - 20,
                                                     15)];
    }
    
    self.bgImageView.image = bgImage;
    
    NSTimeInterval _interval= [chat.timestamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    
    self.senderAndTimeLabel.text = [formatter stringFromDate:date];
    
}


-(CGSize )getDynamicHeightOflbl:(NSString *)lbl font:(UIFont *)font
{
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:lbl
                                                                         attributes:@ {NSFontAttributeName:font}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){[UIScreen mainScreen].bounds.size.width - 20, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    return size;
}


-(NSAttributedString *)getattributedString:(NSString *)str font:(UIFont *)font
{
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:str
                                                                         attributes:@ {NSFontAttributeName:font}];
    
    return attributedText;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
