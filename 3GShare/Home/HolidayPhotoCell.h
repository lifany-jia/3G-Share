//
//  HolidayPhotoCell.h
//  3GShare
//
//  Created by lifany on 2026/5/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HolidayPhotoCell : UITableViewCell
- (void)updateWithModel:(NSArray *)model index:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
