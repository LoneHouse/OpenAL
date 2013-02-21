//
//  LHBaseViewController.h
//  OpenALTest
//
//  Created by Viktor on 29.10.12.
//  Copyright (c) 2012 LoneHouse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHBaseViewController : UIViewController <UIScrollViewDelegate>
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *buttonSoundSource;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *buttonListener;
@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;
@property (assign,nonatomic) BOOL isListenerOnField;

@end
