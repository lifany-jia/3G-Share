//
//  tagView.h
//  3GShare
//
//  Created by lifany on 2026/5/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface tagView : UIView
- (instancetype)initWithTitle:(NSString *) title tags:(NSArray<NSString *> *) tags;
- (instancetype)initWithTags:(NSArray<NSString *> *) tags;
@end

NS_ASSUME_NONNULL_END
