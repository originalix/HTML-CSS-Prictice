//
//  PicListController.m
//  NativeProject
//
//  Created by Lix on 2018/3/15.
//  Copyright © 2018年 Originalee. All rights reserved.
//

#import "PicListController.h"

@interface PicListController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation PicListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
    for (int i = 0; i < 30; i++) {
        [self.dataSource addObject:[NSString stringWithFormat:@"第%d行", i]];
    }
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupViews {
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStylePlain];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

#pragma mark - 长按tableView移动
- (UIView *)customSnapshotFromView:(UIView *)inputView {
    // 用Cell的图层生成一个Image，方便一会儿显示
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 自定义这个快照的显示
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = false;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    return snapshot;
}

@end
