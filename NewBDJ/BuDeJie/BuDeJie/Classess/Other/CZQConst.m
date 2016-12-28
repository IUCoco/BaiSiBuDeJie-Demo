#import <UIKit/UIKit.h>

//底部TabBar的高度
CGFloat const CZQTabBarH = 49;
//顶部statusBar的高度
CGFloat const CZQStatusBarH = 20;
//顶部TitleView的高度
CGFloat const CZQTitleViewH = 35;
//ScrollView顶部contentInset的高度
CGFloat const CZQContentInsetH = 20 + 44;
//tabBarButton按钮被重复点击了
//UIKeyboardWillHideNotification 仿照系统来为通知命名
NSString * const CZQTabBarButtonDidRepeatClickNotification = @"CZQTabBarButtonDidRepeatClickNotification";
//titleBarButton按钮被重复点击了
//UIKeyboardWillHideNotification 仿照系统来为通知命名
NSString * const CZQTitleButtonDidRepeatClickNotification = @"CZQTitleButtonDidRepeatClickNotification";
