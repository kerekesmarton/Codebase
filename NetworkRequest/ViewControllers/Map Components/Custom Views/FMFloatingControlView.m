//
//  FMFloatingControlView.m
//  ForeverMapNGX
//
//  Created by Kerekes Jozsef-Marton on 7/11/13.
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import "FMFloatingControlView.h"

#define collapsedHeight     60
#define viewDistancing      5

@implementation FMFloatingControlView {
    
    FMFloatingControlViewState      _state;
    FMFloatingControlViewState      _previousState;
    UIView                          *header;
    UILabel                         *headerLbl;
    UIImageView                     *headerImg;
    UIImageView                     *arrow;
    UIView                          *views;
    NSMutableArray                  *controls;
    int                             count;
}
@synthesize delegate,dataSource;

- (id)init
{
    self = [self initWithState:FMFloatingControlViewStateCollapsed];
    if (self) {
        //
    }
    return self;
}
-(id)initWithState:(FMFloatingControlViewState)state
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _state = state;
        controls = [[NSMutableArray alloc] init];
        _previousState = FMFloatingControlViewStateExpanded;
    }
    return self;
}

- (void)dealloc
{
    [controls release];
    [super dealloc];
}

-(FMFloatingControlViewState)state {
    return _state;
}

-(void)setState:(FMFloatingControlViewState)state {
    
    _state = state;

    [self animateToState:self.state withBlock:^{}];
}

-(void)setState:(FMFloatingControlViewState)state completion:(void (^)(void))block {
    
    _state = state;
    
    [self animateToState:self.state withBlock:block];
}

-(void) showInView:(UIView *)view {
    
    CGRect frame = view.frame;
    frame.origin.y = view.frameHeight;
    frame.size.height = collapsedHeight;
    self.frame = frame;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    self.backgroundColor = [UIColor clearColor];
    
    [view addSubview:self];
}

-(void) dismiss {
    self.state = FMFloatingControlViewStateHidden;
    [self animateToState:self.state withBlock:^{
        [self removeFromSuperview];
    }];
}

- (void)hide {
    
    _state = FMFloatingControlViewStateHidden;
    
    [self animateToState:_state withBlock:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(floatingControlView:didExpandToState:)]) {
            [self.delegate floatingControlView:self didExpandToState:_state];
        }
    }];
}

-(void)addHeader {
    
    if (!header) {
        header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frameWidth, collapsedHeight)];
        header.backgroundColor = [UIColor colorWithHex:0xFFFFFF];
        header.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        header.clipsToBounds = YES;
        [self addSubview:header];
        [header release];
        
        headerLbl = [[UILabel alloc] initWithFrame:CGRectMake(header.frameX+viewDistancing, header.frameY, header.frameWidth, header.frameHeight)];
        headerLbl.backgroundColor = [UIColor clearColor];
        headerLbl.font = [UIFont fontWithName:@"Avenir-Heavy" size:17];
        headerLbl.textColor = [UIColor colorWithHex:0x3a3a3a];
        headerLbl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [header addSubview:headerLbl];
        [headerLbl release];
        headerLbl.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleTapped:)];
        [header addGestureRecognizer:tap];
        [tap release];
        
        headerImg = [[UIImageView alloc] initWithFrame:CGRectMake(header.frameWidth-collapsedHeight, header.frameY, collapsedHeight, header.frameHeight)];
        headerImg.backgroundColor = [UIColor clearColor];
        headerImg.contentMode = UIViewContentModeCenter;
        headerImg.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        
        [header addSubview:headerImg];
        [headerImg release];
        headerImg.userInteractionEnabled = YES;
        
        arrow = [[UIImageView alloc] initWithFrame:CGRectMake(0, header.frameHeight-2*viewDistancing, header.frameWidth, viewDistancing)];
        arrow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        arrow.image = [UIImage imageNamed:@"slim_arrow_down"];
        arrow.contentMode = UIViewContentModeCenter;
        [header addSubview:arrow];
        [arrow autorelease];
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleImageTapped:)];
        [headerImg addGestureRecognizer:tap2];
        [tap2 release];
        
        [tap requireGestureRecognizerToFail:tap2];
                
    }
    
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(titleForFloatingControl:)]) {
        NSString *str = [self.dataSource titleForFloatingControl:self];
        headerLbl.text = str;
    }
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(imageForTitleAccessoryViewForFloatingControl:)]) {
        UIImage *img = [self.dataSource imageForTitleAccessoryViewForFloatingControl:self];
        if (img) {
            headerImg.image = img;
            headerLbl.frameWidth = header.frameWidth - collapsedHeight;
            headerLbl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        } else {
            headerImg.image = nil;
            headerLbl.frameWidth = header.frameWidth;
            headerLbl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        }
    }
}

-(void)addRows {
    views = [[UIView alloc] initWithFrame: CGRectMake(0, collapsedHeight, self.frameWidth, collapsedHeight*count)];
    if (_state == FMFloatingControlViewStateFull) {
        views.frameHeight = self.superview.frameHeight-collapsedHeight;
    }
    views.backgroundColor = [UIColor colorWithHex:0xefefef];
    views.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:views];
    [views release];
    
    for (int i = 0; i < count; i++) {
        
        FMToolbarSegmentedControl *rowView = [self.dataSource floatingControlView:self viewForRow:i];
        rowView.delegate = self;
        rowView.frameY = i * collapsedHeight;
        rowView.frameHeight = collapsedHeight;
        rowView.frameWidth = views.frameWidth;
        rowView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [views addSubview:rowView];
        [controls addObject:rowView];
    }
}

-(void)reloadControls {
    
    count = [self.dataSource numberOfRowsInFloatingControlView:self];
    
    [self addHeader];
    
    if (_state == FMFloatingControlViewStateExpanded  || _state == FMFloatingControlViewStateFull ) {
        [views removeFromSuperview];
        [controls removeAllObjects];
        
        [self addRows];
    }
}

- (void)animateToState:(FMFloatingControlViewState) toState withBlock:(void (^)(void))block {
    [self reloadControls];
    CGRect newFrame;
    switch (toState) {
        case FMFloatingControlViewStateHidden:
            newFrame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.frameWidth, collapsedHeight);
            break;
        case FMFloatingControlViewStateCollapsed:
            newFrame = CGRectMake(0, self.superview.frameHeight-collapsedHeight, self.frameWidth, collapsedHeight);
            break;
        case FMFloatingControlViewStateExpanded: {
            newFrame = CGRectMake(0, self.superview.frameHeight-(collapsedHeight*(1+count)), self.frameWidth, collapsedHeight*(1+count));
        }
            break;
        case FMFloatingControlViewStateFull:
//            newFrame = CGRectMake(0, self.superview.frameHeight-collapsedHeight*(4+count), self.frameWidth, collapsedHeight*(4+count));
            newFrame = CGRectMake(0, 0, self.frameWidth, self.superview.frameHeight);
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.3 animations:^{

        self.frame = newFrame;
        if (toState == FMFloatingControlViewStateExpanded | toState == FMFloatingControlViewStateFull) {
            arrow.transform = CGAffineTransformIdentity;
        } else {
            arrow.transform = CGAffineTransformMakeRotation(degreesToRadians(180));
        }
    } completion:^(BOOL finished) {
        block();
    }];

}

- (void)titleTapped:(id)sender {
    
    FMFloatingControlViewState toState = FMFloatingControlViewStateCollapsed;
    if (_state == toState) {
        toState = FMFloatingControlViewStateExpanded;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(floatingControlView:shouldExpandToState:)]) {
        
        if (![self.delegate floatingControlView:self shouldExpandToState:toState]) {
            return;
        } else {
            _state = toState;
        }
    } else {
        _state = toState;
    }
    
    [self animateToState:toState withBlock:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(floatingControlView:didExpandToState:)]) {
            [self.delegate floatingControlView:self didExpandToState:_state];
        }
    }];
}

- (void)titleImageTapped:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(floatingControlView:titleImageTapped:)]) {
        
        [self.delegate floatingControlView:self titleImageTapped:_state];
    }
}

#pragma mark - FMToolbarButton delegate

- (void)toolbarSegmentedControl:(FMToolbarSegmentedControl*)control didSelectButtonAtIndex:(int)index {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(floatingControlView:didTapOnControl:Row:atIndex:)]) {
        
        [self.delegate floatingControlView:self didTapOnControl:control Row:[controls indexOfObject:control] atIndex:index];
    }
}

@end
