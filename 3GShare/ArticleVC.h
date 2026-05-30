//
//  ArticleVC.h
//  3GShare
//
//  Created by lifany on 2026/5/17.
//

#import <UIKit/UIKit.h>
#import "ArticleModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ArticleVC : UIViewController
- (instancetype)initWithTitle:(NSString *) title segName:(NSArray<NSString *> *) segName;
@end

NS_ASSUME_NONNULL_END
