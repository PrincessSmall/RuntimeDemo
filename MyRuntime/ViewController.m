//
//  ViewController.m
//  MyRuntime
//
//  Created by 李敏 on 2018/9/13.
//  Copyright © 2018年 李敏. All rights reserved.
//  是仿照简书啊左写的demo，谢谢啊左的分享，啊左的文章链接https://www.jianshu.com/p/ed65518ec8db

#import "ViewController.h"
#import <objc/runtime.h>
#import "LMPerson.h"
#import "LMPerson+LMPersonCategory.h"

@interface ViewController ()

@property (nonatomic , strong)UIButton * btn1;
@property (nonatomic , strong)UIButton * btn2;
@property (nonatomic , strong)UIButton * btn3;
@property (nonatomic , strong)UIButton * btn4;
@property (nonatomic , strong)UIButton * btn5;
@property (nonatomic , strong)UIButton * btn6;
/**模型*/
@property (nonatomic , strong)LMPerson * person;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.btn1];
    [self.view addSubview:self.btn2];
    [self.view addSubview:self.btn3];
    [self.view addSubview:self.btn4];
    [self.view addSubview:self.btn5];
    [self.view addSubview:self.btn6];
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(LMPerson *)person{
    if (!_person) {
        _person = [[LMPerson alloc]init];
    }
    return _person;
}


-(UIButton *)btn1{
    if (!_btn1) {
        _btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width-20, 40)];
        _btn1.backgroundColor = [UIColor grayColor];
        [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn1 setTitle:@"获取所有变量" forState:UIControlStateNormal];
        [_btn1 addTarget:self action:@selector(getAllVariable) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn1;
}


//1. 获取person所有的成员变量
-(void)getAllVariable{
    
    unsigned int count = 0;
    
    //获取类的一个包含所有变量的列表，Ivar是runtime声明的一个宏，是实例变量的意思
    Ivar * allVariables = class_copyIvarList([LMPerson class], &count);
    //遍历每一个变量，包含名称和类型（此处没有*号）
    for (int i = 0 ; i < count; i++) {
        Ivar ivar = allVariables[i];
        const char * variableName = ivar_getName(ivar);//获取成员变量名称
        const char * variableType = ivar_getTypeEncoding(ivar);//获取成员变量类型
        NSLog(@"variableName = %s，variableType = %s",variableName,variableType);
    }
    
}

-(UIButton *)btn2{
    if (!_btn2) {
        _btn2 = [[UIButton alloc]initWithFrame:CGRectMake(10, 160, [UIScreen mainScreen].bounds.size.width-20, 40)];
        _btn2.backgroundColor = [UIColor grayColor];
        [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn2 setTitle:@"获取所有方法" forState:UIControlStateNormal];
        [_btn2 addTarget:self action:@selector(getAllmethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn2;
}

//2. 获取person的所有方法
-(void)getAllmethod{
    
    unsigned int count;
    //获取方法列表，所有在.m文件显示实现的方法都会被找到，包括setter+getter方法
    Method * allMethods = class_copyMethodList([LMPerson class], &count);
    for (int i = 0; i < count; i++) {
        //Method，为runtime声明的一个宏，表示对一个方法的描述
        Method md = allMethods[i];
        //获取SEL：SEL类型,即获取方法选择器@selector()
        SEL sel = method_getName(md);
        //得到sel的方法名：以字符串格式获取sel的name，也即@selector()中的方法名称
        const char * methodName = sel_getName(sel);
        NSLog(@"methodName = %s",methodName);
    }
    
}

-(UIButton *)btn3{
    if (!_btn3) {
        _btn3 = [[UIButton alloc]initWithFrame:CGRectMake(10, 220, [UIScreen mainScreen].bounds.size.width-20, 40)];
        _btn3.backgroundColor = [UIColor grayColor];
        [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn3 setTitle:@"改变私有变量name的值" forState:UIControlStateNormal];
        [_btn3 addTarget:self action:@selector(changeVariable) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn3;
}

//3. 改变私有变量name的值
-(void)changeVariable{
    
    NSLog(@"改变前的person: %@",self.person);
    
    unsigned int count = 0;
    Ivar * allVariables = class_copyIvarList([LMPerson class], &count);
    Ivar ivalName = allVariables[0];
    object_setIvar(self.person, ivalName, @"tom");
    NSLog(@"改变后的person: %@",self.person);
    
}

-(UIButton *)btn4{
    if (!_btn4) {
        _btn4 = [[UIButton alloc]initWithFrame:CGRectMake(10, 280, [UIScreen mainScreen].bounds.size.width-20, 40)];
        _btn4.backgroundColor = [UIColor grayColor];
        [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn4 setTitle:@"添加一个新属性" forState:UIControlStateNormal];
        [_btn4 addTarget:self action:@selector(addNewVariable) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn4;
}

//4. 添加一个新属性
-(void)addNewVariable{
    
    self.person.height = 21.4;
    NSLog(@"新属性height的值：%.2f",self.person.height);
    
}

-(UIButton *)btn5{
    if (!_btn5) {
        _btn5 = [[UIButton alloc]initWithFrame:CGRectMake(10, 340, [UIScreen mainScreen].bounds.size.width-20, 40)];
        _btn5.backgroundColor = [UIColor grayColor];
        [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn5 setTitle:@"添加一个新方法" forState:UIControlStateNormal];
        [_btn5 addTarget:self action:@selector(addMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn5;
}

/*5.添加新的方法试试(这种方法等价于对Father类添加Category对方法进行扩展)：*/
-(void)addMethod{
    /* 动态添加方法：
     第一个参数表示Class cls 类型；
     第二个参数表示待调用的方法名称；
     第三个参数(IMP)myAddingFunction，IMP一个函数指针，这里表示指定具体实现方法myAddingFunction；
     第四个参数表方法的参数，0代表没有参数；
     */
    class_addMethod([LMPerson class], @selector(newMethod), (IMP)myAddingFunction, nil);
    
    //调用方法 【如果使用[per NewMethod]调用方法，在ARC下会报“no visible @interface"错误】
    [self.person performSelector:@selector(newMethod)];
}
//具体的实现（方法的内部都默认包含两个参数Class类和SEL方法，被称为隐式参数。）
int myAddingFunction(id self, SEL _cmd){
    NSLog(@"已新增方法:NewMethod");
    return 1;
}

-(void)newMethod{
    
}

-(UIButton *)btn6{
    if (!_btn6) {
        _btn6 = [[UIButton alloc]initWithFrame:CGRectMake(10, 400, [UIScreen mainScreen].bounds.size.width-20, 40)];
        _btn6.backgroundColor = [UIColor grayColor];
        [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn6 setTitle:@"交换两个方法功能之后" forState:UIControlStateNormal];
        [_btn6 addTarget:self action:@selector(replaceMethod) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btn6;
}
//6. 交换方法
-(void)replaceMethod{
    
    Method method1 = class_getInstanceMethod([LMPerson class], @selector(fun1));
    Method method2 = class_getInstanceMethod([LMPerson class], @selector(fun2));
    //交换方法
    method_exchangeImplementations(method1, method2);
    
    [self.person fun1];//输出结果检验是否交换方法成功
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
