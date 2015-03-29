//
//  ZKDataCenter.m
//  爱限免-框架
//
//  Created by qianfeng on 15-3-13.
//  Copyright (c) 2015年 zhaokai. All rights reserved.
//



#import "ZKDataCenter.h"
#import "ZKAppListModel.h"
#import "FMDatabase.h"

@interface ZKDataCenter ()
@property (nonatomic, strong)FMDatabase *database;
@end

@implementation ZKDataCenter
static ZKDataCenter *center;
+ (ZKDataCenter *)singleInstance {
    @synchronized(self) {
        if (center == nil) {
            center = [[[self class] alloc] init];
        }
    }
    return center;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    if (!center) {
        center = [super allocWithZone:zone];
    }
    return center;
}

//打开/创建数据库
- (id)init {
    if (self = [super init]) {
        NSString *path = [NSString stringWithFormat:@"%@/Documents/database.rdb", NSHomeDirectory()];
        
        _database = [[FMDatabase alloc] initWithPath:path];
        
        if (_database.open == NO) {
            NSLog(@"打开失败");
            return 0;
        }
        //创建表
        NSString *sql = @"create table if not exists applist ("
        " id integer primary key autoincrement not null, "
        " recordType varchar(32), "
        " applicationId integer not null, "
        " name varchar(128), "
        " iconUrl varchar(1024), "
        " type varchar(32) ,"
        " lastPrice integer, "
        " currentPrice integer "
        ");";
        
        BOOL isSuc = [_database executeUpdate:sql];
        if (isSuc == NO) {
            NSLog(@"创建/打开失败");
            return 0;
        }
    }
    return self;
}


//增加
- (void)addApplistModel:(ZKAppListModel *)model andRecondType:(RecondType)type {
    NSString *sql = @"insert into applist(recordType,applicationId,name,iconUrl,type,lastPrice,currentPrice) values(?,?,?,?,?,?,?)";
    BOOL isSuc = [_database executeUpdate:sql,[NSString stringWithFormat:@"%d", type], model.applicationId, model.name, model.iconUrl, @"limit", model.lastPrice, model.currentPrice];
    if (isSuc == NO) {
        NSLog(@"添加失败");
    } else {
        NSLog(@"添加成功");
    }
}
//删除
- (void)deleteApplistModel:(ZKAppListModel *)model andRecondType:(RecondType)type {
    NSString *sql = @"delete from applist where applicationId=? and recordType=?";
    
    BOOL isSuc = [_database executeUpdate:sql,model.applicationId, [NSString stringWithFormat:@"%i", type]];
    if (isSuc == NO) {
        NSLog(@"删除失败");
    } else {
        NSLog(@"删除成功");
    }
}
//查找
- (BOOL)selectApplistModel:(ZKAppListModel *)model andRecondType:(RecondType)type {
    NSString *sql = @"select count(*) from applist where applicationId=? and recordType=?";
    
    //注意:在查找时, 用得方法是executeQuery
    FMResultSet *set = [_database executeQuery:sql, model.applicationId, [NSString stringWithFormat:@"%i", type]];
    int count = 0;
    //结果集
    if (set.next) {
        count = [set intForColumnIndex:0];
    }
    return count;
}
//获取

- (NSArray *)getApplistModelsWithRecondType:(RecondType)type {
    NSString *sql = @"select * from applist where recordType=?";
    
    FMResultSet *set = [_database executeQuery:sql, [NSString stringWithFormat:@"%i", type]];
    
    //结果集
    NSMutableArray *array = [NSMutableArray array];
    while (set.next) {
        ZKAppListModel *model = [[ZKAppListModel alloc] init];
        model.applicationId = [set stringForColumn:@"applicationId"];
        model.name = [set stringForColumn:@"name"];
        NSLog(@"¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥\n\n\n%@", model.name);
        model.iconUrl = [set stringForColumn:@"iconUrl"];
        [array addObject:model];
    }
    return array;
}


@end
