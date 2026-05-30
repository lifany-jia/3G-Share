//
//  BasicInfoCell.h
//  3GShare
//
//  Created by lifany on 2026/5/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicInfoCell : UITableViewCell
- (void)updateWithTitle:(NSString *) title avatar:(NSString *) avatar;
- (void)updateWithTitle:(NSString *) title content:(NSString *) content;
- (void)updateWithTitle:(NSString *) title isFemale:(BOOL) isFemale;
@end

NS_ASSUME_NONNULL_END
