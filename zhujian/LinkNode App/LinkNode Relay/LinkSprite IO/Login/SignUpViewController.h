//
//  SignUpViewController.h
//  LinkSprite IO
//
//  Created by Jian on 16/8/26.
//  Copyright © 2016年 LinkSprite. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerDelegate;

@interface SignUpViewController : UITableViewController

@property (weak, nonatomic) id<LoginViewControllerDelegate> loginDelegate;
@end
