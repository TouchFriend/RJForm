//
//  RJFormBaseCell.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormBaseCell.h"
#import "RJFormBaseItem.h"

@implementation RJFormBaseCell

- (UIViewController *)viewController
{
    id responder = self;
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]])
        {
            return responder;
        }
        responder = [responder nextResponder];
    }
    
    return nil;
}

- (void)updateViewData:(RJFormBaseItem *)data
{
    
}

@end
