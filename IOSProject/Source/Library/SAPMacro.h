//
//  SAPMacro.h
//  UIProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 Andrey Shevtsov. All rights reserved.
//

#define SAPDefineBaseViewProperty(propertyName, ViewClass) \
    @property (nonatomic, readonly) ViewClass *propertyName;

#define SAPBaseViewGetterSynthesize(selector, viewClass) \
    - (viewClass *)selector { \
        if ([self isViewLoaded] && [self.view isKindOfClass:[viewClass class]]) { \
            return (viewClass *)self.view; \
        } \
        \
        return nil; \
    }

#define SAPViewControllerBaseViewProperty(viewControllerClass, propertyName, baseViewClass) \
    @interface viewControllerClass (__SAPPrivateBaseView) \
    SAPDefineBaseViewProperty(propertyName, baseViewClass) \
    \
    @end \
    \
    @implementation viewControllerClass (__SAPPrivateBaseView) \
    \
    @dynamic propertyName;\
    \
    SAPBaseViewGetterSynthesize(propertyName, baseViewClass) \
    \
    @end