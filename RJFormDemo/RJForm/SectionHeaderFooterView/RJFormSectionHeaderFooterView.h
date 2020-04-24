//
//  RJFormSectionHeaderFooterView.h
//  RJFormDemo
//
//  Created by TouchWorld on 2020/4/24.
//  Copyright © 2020 RJSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RJFormSectionHeaderFooterViewUpdateProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface RJFormSectionHeaderFooterView : UITableViewHeaderFooterView <RJFormSectionHeaderFooterViewUpdateProtocol>

- (void)updateViewData:(id)data;

@end

NS_ASSUME_NONNULL_END
