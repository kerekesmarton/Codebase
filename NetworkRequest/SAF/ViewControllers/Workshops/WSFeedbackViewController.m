//
//  WSFeedbackViewController.m
//  SAFapp
//
//  Created by Jozsef-Marton Kerekes on 1/7/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "WSFeedbackViewController.h"
#import "WorkshopObject.h"
#import "PageControl.h"
#import "AFNetworking.h"
#import "FeedbackClient.h"
#import <MessageUI/MessageUI.h>
#import <QuartzCore/QuartzCore.h>
#import "SAFDefines.h"

@interface WSFeedbackViewController () <MFMailComposeViewControllerDelegate>

@property(nonatomic,strong) NSNumber* uid;
@property(nonatomic,strong) WorkshopObject *ws;

@end

@implementation WSFeedbackViewController {
    
    UILabel         *_suggestTitle;
    UIScrollView    *_scroll;
    UITableView     *_rating;
    UITableView     *_useful;
    UITextView      *_feedback;
    PageControl     *_pageControl;
}

@synthesize uid;

- (id)initWithUID:(NSNumber*)uID
{
    self = [super init];
    if (self) {
        
        self.uid = uID;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.view.backgroundColor = [UIColor colorWithHex:0x1b1a19];
    
    UIBarButtonItem *send = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleBordered target:self action:@selector(sendInfo)];
    self.navigationItem.rightBarButtonItem = send;
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    [self fetchWorkshop];
    
    _suggestTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    _suggestTitle.text = @"Please rate this workshop";
    _suggestTitle.textAlignment = NSTextAlignmentCenter;
    _suggestTitle.backgroundColor = [UIColor clearColor];
    _suggestTitle.textColor = [UIColor whiteColor];
    _suggestTitle.font = [UIFont fontWithName:myriadFontB size:16];
    [self.view addSubview:_suggestTitle];
    
    _pageControl = [[PageControl alloc] initWithFrame:CGRectMake(0.0, 40.0, self.view.bounds.size.width, 20)];
    _pageControl.numberOfPages = 3;
    _pageControl.currentPage = 0;
    [self.view addSubview:_pageControl];
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-120)];
    _scroll.contentSize = CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height-120);
    _scroll.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    _scroll.clipsToBounds = YES;
    _scroll.backgroundColor = [UIColor colorWithHex:0x1b1a19];
    [self.view addSubview:_scroll];
    
    _rating = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-120) style:UITableViewStylePlain];
    _rating.dataSource = self;
    _rating.delegate = self;
    _rating.bounces = NO;
    _rating.backgroundColor = [UIColor colorWithHex:0x1b1a19];
    _rating.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_scroll addSubview:_rating];
    
    if ([_ws.feedbackRating intValue]) {
        NSIndexPath *ipRating = [NSIndexPath indexPathForRow:5-[_ws.feedbackRating integerValue] inSection:0];
        [_rating selectRowAtIndexPath:ipRating animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    _useful = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 60, self.view.frame.size.width, self.view.frame.size.height-120) style:UITableViewStylePlain];
    _useful.dataSource = self;
    _useful.delegate = self;
    _useful.bounces = NO;
    _useful.backgroundColor = [UIColor colorWithHex:0x1b1a19];
    _useful.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_scroll addSubview:_useful];
    
    if (_ws.feedbackUseful) {
        NSIndexPath *ipUseful = [NSIndexPath indexPathForRow:1-[_ws.feedbackUseful boolValue] inSection:0];
        [_useful selectRowAtIndexPath:ipUseful animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    _feedback = [[UITextView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*2, 60, self.view.frame.size.width, self.view.frame.size.height-120)];
    _feedback.text = @"Please provide a comment her";
    _feedback.delegate = self;
    _feedback.backgroundColor = [UIColor colorWithHex:0x3c3c3c];
    _feedback.textColor = [UIColor whiteColor];
    _feedback.font = [UIFont fontWithName:myriadFontB size:16];
    [_scroll addSubview:_feedback];
    
    if (![[_ws.feedbackComment stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        _feedback.text = _ws.feedbackComment;
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sending) name:kNotifSending object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sentOK) name:kNotifSentOK object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sentErr) name:kNotifSentErr object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self fetchWorkshop];
    _ws.feedbackComment = _feedback.text;
    [[VICoreDataManager getInstance] saveMainContext];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utils

- (void)fetchWorkshop
{
    if (_ws)
    {
        return;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uID == %@", self.uid];
    id res = [WorkshopObject fetchForPredicate:predicate forManagedObjectContext:[[VICoreDataManager getInstance] managedObjectContext]];
    
    if ([res isKindOfClass:[NSArray class]]) {
        self.ws = [res lastObject];
    } else {
        self.ws = res;
    }
    NSAssert(self.ws, @"%s, Workshop not present", __PRETTY_FUNCTION__);
}

#pragma mark - Notifications

-(void)sending {
    
    UIActivityIndicatorView *sending = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    UIBarButtonItem *view = [[UIBarButtonItem alloc] initWithCustomView:sending];
    self.navigationItem.rightBarButtonItem = view;
    [sending startAnimating];
}

-(void)sentOK {
    
    UIAlertView *sent = [[UIAlertView alloc] initWithTitle:@"Thank You!" message:@"You really made our day by sending this feedback." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [sent show];
    
    UIBarButtonItem *send = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleBordered target:self action:@selector(sendInfo)];
    self.navigationItem.rightBarButtonItem = send;
}

-(void)sentErr {
    
    UIAlertView *sent = [[UIAlertView alloc] initWithTitle:@"Connection problem" message:@"There seems to be a problem with the connection. Your feedback was saved and will be sent later. Thank you!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [sent show];
    
    UIBarButtonItem *send = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleBordered target:self action:@selector(sendInfo)];
    self.navigationItem.rightBarButtonItem = send;
}

#pragma mark Table View Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == _rating) {
        return 5;
    }
    
    if (tableView == _useful) {
        return 2;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    if (tableView == _rating) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Excelent";
                break;
            case 1:
                cell.textLabel.text = @"Good";
                break;
            case 2:
                cell.textLabel.text = @"OK";
                break;
            case 3:
                cell.textLabel.text = @"Could be better";
                break;
            case 4:
                cell.textLabel.text = @"Poor";
                break;
                
            default:
                break;
        }
    }
    
    if (tableView == _useful) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"YES";
                break;
            case 1:
                cell.textLabel.text = @"NO";
                break;
            default:
                break;
        }
    }
    cell.backgroundColor = [UIColor colorWithHex:0x1b1a19];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.textLabel.font = [UIFont fontWithName:myriadFontB size:16];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(10, 5, self.view.frame.size.width-20, 40);
    [gradientLayer setMasksToBounds:YES];
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithHex:0x3c3c3c] CGColor],(id)[[UIColor colorWithHex:0x323232] CGColor], nil]];
    gradientLayer.cornerRadius = 5;
    
    [cell.contentView.layer insertSublayer:gradientLayer atIndex:0];
    
    return cell;
}

static bool scrolling = false;

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self fetchWorkshop];
    
    if (tableView == _rating) {
        _ws.feedbackRating = [NSNumber numberWithInt: 5-indexPath.row];
    }
    
    if (tableView == _useful) {
        _ws.feedbackUseful = [NSNumber numberWithBool:1-indexPath.row];
    }
    
    [[VICoreDataManager getInstance] saveMainContext];
    
    CGRect rect = CGRectMake(_scroll.frame.size.width * (_pageControl.currentPage+1), 0, _scroll.frame.size.width,_scroll.frame.size.height);
    [_scroll scrollRectToVisible:rect animated:YES];
}


#pragma mark - Textview Delegate

-(void)textViewDidChange:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@"Please provide your comment here"]) {
        textView.text = @"";
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    
    [self fetchWorkshop];
    
    if ([textView.text isNotEmptyOrWhiteSpace]) {
        _ws.feedbackComment = textView.text;
    }
    [[VICoreDataManager getInstance] saveMainContext];
}

#pragma mark - ScrollView Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrolling) {
        return;
    }
    
    CGFloat pageWidth = _scroll.frame.size.width;
    int page = floor((_scroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (page != _pageControl.currentPage) {
        _pageControl.currentPage = page;
        switch (page) {
            case 0:
                _suggestTitle.text = @"Please rate this workshop";
                [_feedback resignFirstResponder];
                break;
            case 1:
                _suggestTitle.text = @"Was it useful?";
                [_feedback resignFirstResponder];
                break;
            case 2:
                _suggestTitle.text = @"Please provide your comment here:";
                [_feedback becomeFirstResponder];
                break;
            default:
                break;
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    scrolling = false;
}

-(void)pop {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Alert View Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.alertViewStyle == UIAlertViewStylePlainTextInput) {
        if (buttonIndex == 1) {
            //verify email input
            
            NSString *email = [[alertView textFieldAtIndex:0] text];
            
            NSRange valid1 = [email rangeOfString:@"@"];
            NSRange valid2 = [email rangeOfString:@"."];
            
            if ([email length] >0 && valid1.location != NSNotFound && valid2.location != NSNotFound) {
                //save info and send
                
                [[NSUserDefaults standardUserDefaults] setValue:email forKey:@"feedbackEmail"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [[FeedbackClient sharedClient] sendFeedbackForID:_ws.uID];
                
            } else {
                //bad email address
                
                UIAlertView *bad = [[UIAlertView alloc] initWithTitle:@"Wrong email address!" message:@"This doesn't seem to be a correct email address" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                bad.alertViewStyle = UIAlertViewStyleDefault;
                [bad show];
            }
            
        } else {
            // cancelled
        }
    }
    else if ([alertView.title isEqualToString:@"Thank You!"])
    {
        [self pop];
    }
    else
    {
    //    user introduced a bad email address and this message was presented to ask to introduce a correct one. dismiss
    }
}

#pragma mark - Send Feedback button

-(void)sendInfo {
    
    [self fetchWorkshop];
    
    _ws.feedbackSent = @NO;
    _ws.feedbackComment = _feedback.text;
    [[VICoreDataManager getInstance] saveMainContext];
    
    [_feedback resignFirstResponder];
    
    if (!_ws.feedbackRating || !_ws.feedbackUseful) {
        
        //minimum feedback info not met
        UIAlertView *missing = [[UIAlertView alloc] initWithTitle:@"Please rate this workshop" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [missing show];
        
    } else {
        
        //ask for email if needed or send
        
        NSString *email = [[NSUserDefaults standardUserDefaults] valueForKey:@"feedbackEmail"];
        
        UIAlertView *provideInput = [[UIAlertView alloc] initWithTitle:@"Please provide your email address" message:nil delegate:self cancelButtonTitle:@"No, Thanks" otherButtonTitles:@"Submit", nil];
        provideInput.alertViewStyle = UIAlertViewStylePlainTextInput;
        
        UITextField *textField = [provideInput textFieldAtIndex:0];
        textField.keyboardType = UIKeyboardTypeEmailAddress;
        if ([email length]) {
            //email was previusly saved. prefill
            textField.text = email;
        }
        
        [provideInput show];
    }
}

#pragma mark Mail Compose Delegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    if (result == MFMailComposeResultFailed) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email"
                                                         message:@"Email failed to send. Please try again."
                                                        delegate:nil cancelButtonTitle:@"Dismiss"
                                               otherButtonTitles:nil];
		[alert show];
    }
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    
    return NO;
}

@end
