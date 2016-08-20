//
//  MBChatViewController.m
//  MBChatView
//
//  Created by Mitul Bhadeshiya on 17/08/16.
//  Copyright © 2016 Mitul Bhadeshiya. All rights reserved.
//

#import "MBChatViewController.h"

#define padding1 10.0


@interface MBChatViewController ()

@end

@implementation MBChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    imgBG = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imgBG.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    [self.view addSubview:imgBG];
    
    tblChat =[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    tblChat.dataSource = self;
    tblChat.delegate = self;
    tblChat.backgroundColor = [UIColor clearColor];
    tblChat.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, tblChat.frame.size.height - 40, tblChat.frame.size.width, 40)];
    tblChat.separatorStyle = UITableViewCellSeparatorStyleNone;
    tblChat.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    

    [self.view addSubview:tblChat];
    
    containerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, tblChat.frame.size.width, 40)];
    
    textView = [[MBExpandingTextView alloc] initWithFrame:CGRectMake(6, 3, tblChat.frame.size.width- 100, 40)];

    textView.delegate = self;
    textView.isScrollable = NO;
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    textView.minNumberOfLines = 1;
    textView.maxNumberOfLines = 6;
    textView.returnKeyType = UIReturnKeyGo;
    textView.font = [UIFont systemFontOfSize:15.0f];
    textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor colorWithRed:(242.0f/255.0f) green:(242.0f/255.0f) blue:(242.0f/255.0f) alpha:1];
    //[UIColor colorWithHue:(242.0f/255.0f) saturation:(242.0f/255.0f) brightness:(242.0f/255.0f) alpha:1];
    textView.placeholder = @"Type Message!";
    containerView.backgroundColor = [UIColor whiteColor];
    
    [containerView addSubview:textView];
    
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 70  , 8, 63, 27);
    //doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [doneBtn setTitle:@"Send" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    
    
    [doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
    doneBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
    doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    
    [doneBtn addTarget:self action:@selector(resignTextView) forControlEvents:UIControlEventTouchUpInside];
    //[doneBtn setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
    //[doneBtn setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
    [containerView addSubview:doneBtn];
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self.view addSubview:containerView];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}


-(void)resignTextView{
    
    [self setMessageWithMessage:textView.text];
    [textView resignFirstResponder];
    textView.text = @"";
}



-(void)setBackgroundColor:(UIColor *)color
{
    imgBG.backgroundColor = color;
}
-(void)setBackGroundImage:(UIImage *)img
{
    imgBG.image = img;
    imgBG.alpha = 0.7;
}


#pragma mark -
#pragma mark Table view delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MBChatCell";
    
    MBChatCell *cell = (MBChatCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell =[[MBChatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.contentView.backgroundColor =[UIColor clearColor];
    cell.backgroundColor =[UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.userInteractionEnabled = NO;
    
    MBChat *objChat = (MBChat *)[messages objectAtIndex:indexPath.row];
    [cell setChatdata:objChat];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MBChat *objChat = (MBChat *)[messages objectAtIndex:indexPath.row];
    
    UIFont *font = [UIFont boldSystemFontOfSize:13];
    CGSize size = [self getDynamicHeightOflbl:objChat.message font:font];
    size.height += padding1*2 ;
    CGFloat height = size.height < 42 ? 42 : size.height;
    
    return height;
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


-(void)setDefaultMessages:(NSArray *)arrMsg
{
    messages =[[NSMutableArray alloc]init];
    [messages addObjectsFromArray:arrMsg];
    
    [self reloadChat];
}
-(void)sendMessage:(MBChat *)msg
{
    if(!messages){
        messages =[[NSMutableArray alloc]init];
    }
    [messages addObject:msg];
    
    [self reloadChat];
}
-(void)reloadChat
{
    [tblChat reloadData];
}



- (void)expandingTextView:(MBExpandingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    CGRect r = containerView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    containerView.frame = r;
}


//Code from Brett Schumann
-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    containerView.frame = containerFrame;
    
    [UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    containerView.frame = containerFrame;
    [UIView commitAnimations];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
