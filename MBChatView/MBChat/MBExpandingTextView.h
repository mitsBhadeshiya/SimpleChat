//
//  MBExpandingTextView.h
//  MBChatView
//
//  Created by Mitul Bhadeshiya on 17/08/16.
//  Copyright © 2016 Mitul Bhadeshiya. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MBExpandingTextView;
@class MBTextView;

@protocol ExpandingTextViewDelegate

@optional
- (BOOL)expandingTextViewShouldBeginEditing:(MBExpandingTextView *)textView;
- (BOOL)expandingTextViewShouldEndEditing:(MBExpandingTextView *)textView;

- (void)expandingTextViewDidBeginEditing:(MBExpandingTextView *)textView;
- (void)expandingTextViewDidEndEditing:(MBExpandingTextView *)textView;

- (BOOL)expandingTextView:(MBExpandingTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)expandingTextViewDidChange:(MBExpandingTextView *)textView;

- (void)expandingTextView:(MBExpandingTextView *)textView willChangeHeight:(float)height;
- (void)expandingTextView:(MBExpandingTextView *)textView didChangeHeight:(float)height;

- (void)expandingTextViewDidChangeSelection:(MBExpandingTextView *)textView;
- (BOOL)expandingTextViewShouldReturn:(MBExpandingTextView *)textView;

@end



@interface MBExpandingTextView : UIView <UITextViewDelegate>
{
    MBTextView *internalTextView;
    
    int minHeight;
    int maxHeight;
    
    int maxNumberOfLines;
    int minNumberOfLines;
    
    BOOL animateHeightChange;
    NSTimeInterval animationDuration;
    
    NSObject <ExpandingTextViewDelegate> *__unsafe_unretained delegate;
    NSTextAlignment textAlignment;
    NSRange selectedRange;
    BOOL editable;
    UIDataDetectorTypes dataDetectorTypes;
    UIReturnKeyType returnKeyType;
    UIKeyboardType keyboardType;
    
    UIEdgeInsets contentInset;

}


@property int maxNumberOfLines;
@property int minNumberOfLines;
@property (nonatomic) int maxHeight;
@property (nonatomic) int minHeight;
@property BOOL animateHeightChange;
@property NSTimeInterval animationDuration;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UITextView *internalTextView;



@property(unsafe_unretained) NSObject<ExpandingTextViewDelegate> *delegate;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) UIFont *font;
@property(nonatomic,strong) UIColor *textColor;
@property(nonatomic) NSTextAlignment textAlignment;
@property(nonatomic) NSRange selectedRange;
@property(nonatomic,getter=isEditable) BOOL editable;
@property(nonatomic) UIDataDetectorTypes dataDetectorTypes __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_3_0);
@property (nonatomic) UIReturnKeyType returnKeyType;
@property (nonatomic) UIKeyboardType keyboardType;
@property (assign) UIEdgeInsets contentInset;
@property (nonatomic) BOOL isScrollable;
@property(nonatomic) BOOL enablesReturnKeyAutomatically;


#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
- (id)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer;
#endif

- (BOOL)becomeFirstResponder;
- (BOOL)resignFirstResponder;
- (BOOL)isFirstResponder;

- (BOOL)hasText;
- (void)scrollRangeToVisible:(NSRange)range;

- (void)refreshHeight;



@end
