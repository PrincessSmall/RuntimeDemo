//
//  LMPerson.m
//  MyRuntime
//
//  Created by 李敏 on 2018/9/13.
//  Copyright © 2018年 李敏. All rights reserved.
//

#import "LMPerson.h"

@implementation LMPerson{
    
    NSString * name;
}
//初始化person属性
-(instancetype)init{
    if (self = [super init]) {
        
        self.age  = 18;
        name = @"lily";
        
    }
    return self;
}

-(void)fun1{
    NSLog(@"执行了fun1方法");
}

-(void)fun2{
    NSLog(@"执行了fun2方法");
}

//输出person对象的方法
-(NSString *)description{
   
    return [NSString stringWithFormat:@"name == %@ , age == %d",name,self.age];
    
}



@end
