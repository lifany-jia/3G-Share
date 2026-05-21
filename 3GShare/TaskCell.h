//
//  TaskCell.h
//  3GShare
//
//  Created by lifany on 2026/5/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskCell : UITableViewCell
- (void)updateWithImaName:(NSArray *) imaName label:(NSArray *)label row:(NSInteger) row;
@end

NS_ASSUME_NONNULL_END
