//
//  ViewController.m
//  JsonForModel
//
//  Created by jk on 2016/12/29.
//  Copyright © 2016年 jk. All rights reserved.
//

#import "ViewController.h"
#import "ESJsonFormat.h"
#import "ESClassInfo.h"
#import "ESJsonFormatSetting.h"
#import "ESJsonFormatManager.h"

#import "ESInputJsonController.h"
#import "HomeVC.h"

#define kInputJsonPlaceholdText @("请输入json或者xml字符串")
#define kSourcePlaceholdText @("自动生成对象模型类源文件")
#define kHeaderPlaceholdText @("自动生成对象模型类头文件")
@interface ViewController (){
    NSMutableString       *   _classString;        //存类头文件内容
    NSMutableString       *   _classMString;       //存类源文件内容
    NSString              *   _classPrefixName;    //类前缀
    BOOL                      _didMake;
}



@property (nonatomic , strong)IBOutlet  NSTextView  * classField;
@property (nonatomic , strong)IBOutlet  NSTextView  * classMField;


@property (nonatomic) NSTextView *currentTextView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(outputResult:) name:ESFormatResultNotification object:nil];
    _classString = [NSMutableString new];
    _classMString = [NSMutableString new];
    _classField.editable = NO;
    _classMField.editable = NO;
    // Do any additional setup after loading the view.
    [self setTextViewStyle];
    [self setClassSourceContent:kSourcePlaceholdText];
    [self setClassHeaderContent:kHeaderPlaceholdText];

    // Do any additional setup after loading the view.
}
- (void)setJsonContent:(NSString *)content {
//    if (content != nil) {
//        NSMutableAttributedString * attrContent = [[NSMutableAttributedString alloc] initWithString:content];
//        [_jsonField.textStorage setAttributedString:attrContent];
//        [_jsonField.textStorage setFont:[NSFont systemFontOfSize:14]];
//        [_jsonField.textStorage setForegroundColor:[NSColor orangeColor]];
//    }
}

- (void)setClassHeaderContent:(NSString *)content {
    if (content != nil) {
        NSMutableAttributedString * attrContent = [[NSMutableAttributedString alloc] initWithString:content];
        [_classField.textStorage setAttributedString:attrContent];
        [_classField.textStorage setFont:[NSFont systemFontOfSize:12]];
        [_classField.textStorage setForegroundColor:[NSColor colorWithRed:61.0 / 255.0 green:160.0 / 255.0 blue:151.0 / 255.0 alpha:1.0]];
    }
}

- (void)setClassSourceContent:(NSString *)content {
    if (content != nil) {
        NSMutableAttributedString * attrContent = [[NSMutableAttributedString alloc] initWithString:content];
        [_classMField.textStorage setAttributedString:attrContent];
        [_classMField.textStorage setFont:[NSFont systemFontOfSize:12]];
        [_classMField.textStorage setForegroundColor:[NSColor colorWithRed:61.0 / 255.0 green:160.0 / 255.0 blue:151.0 / 255.0 alpha:1.0]];
    }
}

- (void)setTextViewStyle {
//    _jsonField.font = [NSFont systemFontOfSize:14];
//    _jsonField.textColor = [NSColor colorWithRed:198.0 / 255.0 green:77.0 / 255.0 blue:21.0 / 255.0 alpha:1.0];
//    _jsonField.backgroundColor = [NSColor colorWithRed:40.0 / 255.0 green:40.0 / 255.0 blue:40.0 / 255.0 alpha:1.0];
//    _classMField.backgroundColor = _jsonField.backgroundColor;
//    _classField.backgroundColor = _jsonField.backgroundColor;
//    _classMHeightConstraint.constant = 0;
}

- (IBAction)clickCheckUpdate:(NSButton *)sender {
    
    
}



- (IBAction)clickMakeButton:(NSButton*)sender{
    
    HomeVC*vc = [[HomeVC alloc] init];
    
    [self presentViewControllerAsSheet:vc];
//    [ESJsonFormatSetting defaultSetting];
//    ESJsonFormat* es=[[ESJsonFormat alloc]initWithBundle:nil];
//    [es showInputJsonWindow:nil];
//    return;

}

- (NSString *)handleAfterClassName:(NSString *)className {
    if (className != nil && className.length > 0) {
        NSString * first = [className substringToIndex:1];
        NSString * other = [className substringFromIndex:1];
        return [NSString stringWithFormat:@"%@%@%@",_classPrefixName,[first uppercaseString],other];
    }
    return className;
}

- (NSString *)handlePropertyName:(NSString *)propertyName {
    if (propertyName != nil && propertyName.length > 0) {
        NSString * first = [propertyName substringToIndex:1];
        NSString * other = [propertyName substringFromIndex:1];
        return [NSString stringWithFormat:@"%@%@",[first lowercaseString],other];
    }
    return propertyName;
}

#pragma mark -解析处理引擎-

-(void)outputResult:(NSNotification*)noti{
    ESClassInfo *classInfo = noti.object;
    
    self.currentTextView=[NSTextView new];
    
        //先添加主类的属性
        [self.currentTextView insertText:classInfo.classContentForH];
        [self.currentTextView insertText:@"\n"];
        
        //再添加把其他类的的字符串拼接到最后面
        [self.currentTextView insertText:classInfo.classInsertTextViewContentForH replacementRange:NSMakeRange(self.currentTextView.string.length, 0)];
        
        //@class
        NSString *atClassContent = classInfo.atClassContent;
        if (atClassContent.length>0) {
            NSRange atInsertRange = [self.currentTextView.string rangeOfString:@"@interface"];
            if (atInsertRange.location != NSNotFound) {
                [self.currentTextView insertText:[NSString stringWithFormat:@"%@\n",atClassContent] replacementRange:NSMakeRange(atInsertRange.location, 0)];
            }
        }
        
        //再添加.m文件的内容
        
        //The original content
        NSString *originalContent = classInfo.classContentForM;
        
        
        NSString *methodStr = [ESJsonFormatManager methodContentOfObjectClassInArrayWithClassInfo:classInfo];
        if (![originalContent rangeOfString:methodStr].length) {
            if (methodStr.length) {
                NSRange lastEndRange = [originalContent rangeOfString:@"@end"];
                if (lastEndRange.location != NSNotFound) {
                    originalContent = [originalContent stringByReplacingCharactersInRange:NSMakeRange(lastEndRange.location, 0) withString:methodStr];
                }
            }
        }
        originalContent = [originalContent stringByReplacingCharactersInRange:NSMakeRange(originalContent.length, 0) withString:
                           classInfo.classInsertTextViewContentForM];
        //            [originalContent writeToURL:writeUrl atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        [self setClassHeaderContent:self.currentTextView.string];
        [self setClassSourceContent:originalContent];
        
    
    //    }
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
