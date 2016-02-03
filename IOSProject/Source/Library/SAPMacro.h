//
//  SAPMacro.h
//  UIProject
//
//  Created by S A P on 1/28/16.
//  Copyright © 2016 Andrey Shevtsov. All rights reserved.
//
#define SAPViewPropertySynthesize(viewClass, propertyName) \
    @property (nonatomic, strong) viewClass *propertyName;

#define SAPViewGetterSynthesize(viewClass, propertyName) \
    - (viewClass *)propertyName { \
        if ([self isViewLoaded] && [self.view isKindOfClass:[viewClass class]]) { \
            return (viewClass *)self.view; \
        } \
    \
        return nil; \
    }

#define SAPCategoryForViewProperty(controllerName, categoryName, propertyName, viewClass) \
    \
    @interface controllerName (categoryName) \
    SAPViewPropertySynthesize(viewClass, propertyName) \
    \
    @end \
    \
    @implementation controllerName (categoryName)  \
    \
    @dynamic propertyName; \
    \
    SAPViewGetterSynthesize(viewClass, propertyName) \
    \
    @end \
