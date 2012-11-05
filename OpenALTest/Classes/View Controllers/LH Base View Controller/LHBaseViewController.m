//
//  LHBaseViewController.m
//  OpenALTest
//
//  Created by Viktor on 29.10.12.
//  Copyright (c) 2012 LoneHouse. All rights reserved.
//

#import "LHBaseViewController.h"
#import <QuartzCore/QuartzCore.h>

#define pathImageListener @"img_ear_55X55.png"
#define pathImageSoundSource @"img_soundSource_on_55X55.png"

@interface LHBaseViewController ()
{
    UIImageView * imageToMove;
    NSMutableArray * soundSources;
    UIPanGestureRecognizer * panRecognizer;
}

@end

@implementation LHBaseViewController

#pragma mark - init & ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        soundSources = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGSize newSize = self.view.bounds.size;
    newSize.height *= 2;
    newSize.width  *= 2;
    self.scrollView.contentSize = newSize;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_scrollView release];
    [_buttonSoundSource release];
    [_buttonListener release];
    [_toolBar release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setScrollView:nil];
    [self setButtonSoundSource:nil];
    [self setButtonListener:nil];
    imageToMove = nil;
    [self setToolBar:nil];
    [super viewDidUnload];
}

#pragma mark - Touches

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint beginPoint = [[touches anyObject]locationInView:self.view];
    
    NSLog(@"Start at point x:%f y:%f",beginPoint.x,beginPoint.y);
    
    if (CGRectContainsPoint(self.buttonListener.customView.bounds, [touch locationInView:self.buttonListener.customView]))
    {
        //In Listener button touch
        [self startToAnimateToolBarButton:self.buttonListener withImage:pathImageListener toPoint:beginPoint];
    }
    else if (CGRectContainsPoint(self.buttonSoundSource.customView.bounds, [touch locationInView:self.buttonSoundSource.customView]))
    {
        //In Sound Source button touch
        [self startToAnimateToolBarButton:self.buttonSoundSource withImage:pathImageSoundSource toPoint:beginPoint];
    }

}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint endPoint = [[touches anyObject]locationInView:self.view];
    NSLog(@"End at point x:%f y:%f",endPoint.x,endPoint.y);
    
    [self dropImageView:imageToMove onScrollView:self.scrollView];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint movePoint = [[touches anyObject]locationInView:self.view];
    NSLog(@"Move at point x:%f y:%f",movePoint.x,movePoint.y);
    
    [UIView animateWithDuration:0.05 animations:^{
        imageToMove.center = movePoint;
    }];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint beginPoint = [[touches anyObject]locationInView:self.view];
    NSLog(@"Cancel at point x:%f y:%f",beginPoint.x,beginPoint.y);
}

#pragma mark - drag & drop system

- (void) dropImageView:(UIImageView*) imageView onScrollView:(UIScrollView*) scrollViewToDrop
{
    [imageView.layer removeAllAnimations];
    
    [imageView removeFromSuperview];
    CGPoint centerWithOffset = imageView.center;
    centerWithOffset.x += scrollViewToDrop.contentOffset.x;
    centerWithOffset.y += scrollViewToDrop.contentOffset.y;
    imageView.center = centerWithOffset;
    
    [scrollViewToDrop addSubview:imageToMove];
}

#pragma mark - animation

- (void) startToAnimateToolBarButton:(UIBarButtonItem*) button withImage:(NSString*) pathToImage toPoint: (CGPoint) point
{
    imageToMove =[[UIImageView alloc] initWithImage:[UIImage imageNamed:pathToImage]];
    [self.view addSubview:imageToMove];
    imageToMove.frame = [self.view convertRect:button.customView.frame fromView:self.toolBar];
    [UIView animateWithDuration:0.1 animations:^{
        imageToMove.center = point;
    }];
}
@end