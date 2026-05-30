//
//  HomeHeaderCell.h
//  3GShare
//
//  Created by lifany on 2026/5/18.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface HomeHeaderCell : UITableViewCell
- (void)configWithModel:(NSArray *) imas;
- (void)startTime;
- (void)stopTime;
@end

NS_ASSUME_NONNULL_END
