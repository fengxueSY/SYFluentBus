//
//  FBTranslator.h
//  FluentBus
//
//  Created by 666GPS on 2016/12/26.
//  Copyright © 2016年 yang. All rights reserved.
//

#ifndef FBTranslator_h
#define FBTranslator_h
//--------------------打印参数
#ifdef DEBUG
#define DBLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define DebugLog(...) NSLog(__VA_ARGS__)
#define DebugMethod() NSLog(@"%s [Line %d]", __FUNCTION__, __LINE__)
#define DebugReleaseMark() NSLog(@"Release %s [Line %d]", __FUNCTION__, __LINE__)
#else
#define DBLog(...)
#define DebugLog(...)
#define DebugMethod()
#define DebugReleaseMark()
#endif

//--------------------屏幕尺寸
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height
#define SCREENRANTE  [[UIScreen mainScreen] bounds].size.width/320.0


//--------------------手机尺寸
#define ScreenWidth_iPhone4s 320
#define ScreenHeight_iPhone4s 480
#define ScreenWidth_iPhone5s 320
#define ScreenHeight_iPhone5s 568
#define ScreenWidth_iPhone6s 375
#define ScreenHeight_iPhone6s 667
#define ScreenWidth_iPhone6sPlus 414
#define ScreenHeight_iPhone6sPlus 736

//--------------------view的尺寸
#define Min_X(view) CGRectGetMinX(view.frame)
#define Max_X(view) CGRectGetMaxX(view.frame)
#define Min_Y(view) CGRectGetMinY(view.frame)
#define Max_Y(view) CGRectGetMaxY(view.frame)
#define Mid_X(view) CGRectGetMidX(view.frame)
#define Mid_Y(view) CGRectGetMidY(view.frame)
#define View_Width(view) CGRectGetWidth(view.frame)
#define View_Height(view) CGRectGetHeight(view.frame)

//--------------------颜色相关
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorWithRGB(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define ThemeColor UIColorFromRGB(0x38C3E7)
#define ColorRGB_f05d5d UIColorFromRGB(0xf05d5d)
#define ColorRGB_ff7f50 UIColorFromRGB(0xff7f50)
#define ColorRGB_7fcbfa UIColorFromRGB(0x7fcbfa)
#define ColorRGB_dc75d7 UIColorFromRGB(0xdc75d7)
#define textBlackColor UIColorFromRGB(0x333333)/**<大部分字体要用的黑色*/
#define viewBlueColor UIColorFromRGB(0x508cee)/**<大部分view要用的蓝色*/
#define backCommonlyUsedColor UIColorFromRGB(0xf5f5f5)/**<大部分view要用的背景色*/
#define buttonCommonlyUsedColor UIColorFromRGB(0x7BE653)/**<大部分button的背景色*/

#define oneHeadingColor UIColorFromRGB(0x000000)//一级标题颜色
#define twoHeadingColor UIColorFromRGB(0x333333)//二级标题颜色
#define threeHeadingColor UIColorFromRGB(0x999999)//三级标题颜色
#define lineLabelColor UIColorFromRGB(0xffffff)//一般线的颜色
#define blueUnifyColor UIColorFromRGB(0x208de0)//天蓝色
#define greenUnifyColor UIColorFromRGB(0x24c552)//绿色
#define whiteUnifyColor [UIColor whiteColor]
//--------------------防止死循环
#define WeakSelf(weakSelf) __weak typeof(self) weakSelf= self

//--------------------判断字符串不为空
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define StringNotNilAndNull(_ref) (NotNilAndNull(_ref) && ![_ref isEqualToString:@""])
#define ArrayNotNilAndNull(_ref) (NotNilAndNull(_ref) && _ref.count != 0)
#define User_IS_BEFOR_LOGIN (@"__userIsBeforLogin__")
#define User_IS_Auto_LOGIN (@"__userIsAutoLogin__")
#define User_IS_AutoFail_LOGIN (@"__userIsAutoFailLogin__")
//--------------------简化常用语句
#define FONT(a) [UIFont systemFontOfSize:a]
#define UIImageName(a) [UIImage imageNamed:a]
#endif /* FBTranslator_h */
