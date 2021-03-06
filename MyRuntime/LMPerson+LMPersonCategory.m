//
//  LMPerson+LMPersonCategory.m
//  MyRuntime
//
//  Created by 李敏 on 2018/9/14.
//  Copyright © 2018年 李敏. All rights reserved.
//

#import "LMPerson+LMPersonCategory.h"
#import <objc/runtime.h>

const char * str = "mykey";

@implementation LMPerson (LMPersonCategory)

-(void)setHeight:(float)height{
    
    NSNumber * num = [NSNumber numberWithFloat:height];
    /*
     第一个参数是需要添加属性的对象；
     第二个参数是属性的key;
     第三个参数是属性的值,类型必须为id，所以此处height先转为NSNumber类型；
     第四个参数是使用策略，是一个枚举值，类似@property属性创建时设置的关键字，可从命名看出各枚举的意义；
     objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
     */
    objc_setAssociatedObject(self, str, num, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//提取属性的值        
-(float)height{
    
    NSNumber * number = objc_getAssociatedObject(self, str);
    return [number floatValue];
}

@end
