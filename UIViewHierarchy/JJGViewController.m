//
//  JJGViewController.m
//  UIViewHierarchy
//
//  Created by Jeff Gayle on 5/26/14.
//  Copyright (c) 2014 Jeff Gayle. All rights reserved.
//

#import "JJGViewController.h"

@interface JJGViewController ()

@property (strong, nonatomic) IBOutlet UIView *bubbleView;
@property (strong, nonatomic) UIView *smallBubbles;
@property (strong, nonatomic) UIDynamicAnimator *animation;
@property (strong, nonatomic) UICollisionBehavior *collision;
@property (strong, nonatomic) UIGravityBehavior *gravity;

@end

@implementation JJGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.bubbleView.backgroundColor = [UIColor redColor];
    self.bubbleView.layer.cornerRadius = self.bubbleView.frame.size.width / 2.0;
    [self.bubbleView setClipsToBounds:YES];
    
    _smallBubbles = [[UIView alloc]init];
    _smallBubbles.backgroundColor = [UIColor greenColor];
    _smallBubbles.frame = CGRectMake(30, 30, 30, 30);
    _smallBubbles.layer.cornerRadius = _smallBubbles.frame.size.width / 2.0;
    
    [self.bubbleView addSubview:_smallBubbles];
    
    [self setUpGravity];
}

- (void)setUpGravity
{
    _animation = [[UIDynamicAnimator alloc]initWithReferenceView:self.bubbleView];
    _gravity = [[UIGravityBehavior alloc]initWithItems:@[_smallBubbles]];
    [_animation addBehavior:_gravity];
    _collision = [[UICollisionBehavior alloc]initWithItems:@[_smallBubbles]];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
    [_animation addBehavior:_collision];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch *touch = obj;
        CGPoint touchPoint = [touch locationInView:self.bubbleView];
        
        _smallBubbles = [[UIView alloc]init];
        _smallBubbles.backgroundColor = [UIColor greenColor];
        _smallBubbles.frame = CGRectMake(touchPoint.x, touchPoint.y, 30, 30);
        _smallBubbles.layer.cornerRadius = _smallBubbles.frame.size.width / 2.0;
        [_smallBubbles setClipsToBounds:YES];
        
        [self.bubbleView addSubview:_smallBubbles];
        [self.gravity addItem:_smallBubbles];
        [self.collision addItem:_smallBubbles];
        
        [self setUpGravity];
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

