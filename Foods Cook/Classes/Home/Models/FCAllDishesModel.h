//
//  FCAllDishesModel.h
//  Foods Cook
//
//  Created by 邓莎 on 2017/10/19.
//  Copyright © 2017年 邓莎. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol FCClassesOfDishes;

@interface FCAllDishesModel : JSONModel
///分类ID，默认全部
@property (nonatomic, copy)NSString <Optional> *parentId;
///分类类名
@property (nonatomic, copy)NSString <Optional> *name;
///分类详情
@property (nonatomic, copy)NSArray <Optional,FCClassesOfDishes> *list;

@end

@interface FCClassesOfDishesModel : JSONModel
///类别子id
@property (nonatomic, copy)NSString <Optional> *childId;
///单个类别名
@property (nonatomic, copy)NSString <Optional> *name;
///改类别id
@property (nonatomic, copy)NSString <Optional> *parentId;

@end
