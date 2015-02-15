//
//  SKSearchResultParent.h
//  ForeverMapNGX
//
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKDefinitions.h"

/** SKSearchResultParent stores information about the SKSearchResult's parent.
 */
@interface SKSearchResultParent : NSObject

/** The index of the parent.
 */
@property(nonatomic, assign) int parentIndex;

/** The type of the parent (country, state, city, etc.).
 */
@property(nonatomic, assign) SKSearchResultType type;

/** The name of the parent.
 */
@property(nonatomic, strong) NSString *name;

/** Creates a SKSearchResultParent, initialized with the values passed as parameters.
 @param index The index of the parent.
 @param type The type of the parent (Country, state, city, etc.).
 @param name The name of the parent.
 @return A newly initialized SKSearchResultParent with the values passed as parameters.
 */
+ (instancetype)searchResultParentWithIndex:(int)index type:(int)type name:(NSString *)name;

@end
