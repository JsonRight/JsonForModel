//
//  HomeVC.h
//  JsonForModel
//
//  Created by jk on 2016/12/29.
//  Copyright © 2016年 jk. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@protocol ESInputJsonControllerDelegate <NSObject>

@optional
-(void)windowWillClose;
@end

@interface HomeVC : NSViewController
@property (nonatomic , strong) IBOutlet NSButton *mj_btn;
@property (nonatomic , strong) IBOutlet NSButton *yy_btn;
@property (nonatomic , strong) IBOutlet NSButton *json_btn;


@property (nonatomic, weak) id<ESInputJsonControllerDelegate> delegate;
@end
