//
//  SAFPOIsViewController.h
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 11/14/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POIAnnotation.h"

typedef void (^DidPickAnnotation)(POIAnnotation *);


@interface SAFPOIsViewController : UITableViewController

+(UINavigationController *)modalNavigationControllerWithCompletion:(DidPickAnnotation)completion;

@property(nonatomic,copy) DidPickAnnotation completion;

@end
