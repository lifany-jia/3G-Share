//
//  HomeArticelCell.h
//  3GShare
//
//  Created by lifany on 2026/5/18.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeArticelCell : UITableViewCell
- (void)updateWithModel:(NSArray<ArticleModel *> *) article row:(NSInteger) row;
@end

NS_ASSUME_NONNULL_END
