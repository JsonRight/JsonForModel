//
//  TestWindowController.h
//  ESJsonFormat
//
//  Created by 尹桥印 on 15/6/19.
//  Copyright (c) 2015年 EnjoySR. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol ESInputJsonControllerDelegate <NSObject>

@optional
-(void)windowWillClose;
@end

@interface ESInputJsonController : NSWindowController
@property (weak) IBOutlet NSButton *mj_btn;
@property (weak) IBOutlet NSButton *yy_btn;
@property (weak) IBOutlet NSButton *json_btn;


@property (nonatomic, weak) id<ESInputJsonControllerDelegate> delegate;
@end
