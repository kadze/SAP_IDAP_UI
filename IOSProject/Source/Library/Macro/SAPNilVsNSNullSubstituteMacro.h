//
//  SAPCompareMacro.h
//  IOSProject
//
//  Created by SAP on 4/3/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#ifndef SAPCompareMacro_h
#define SAPCompareMacro_h

#define SAPNilIfNSNull(value) \
    ([NSNull new] == value) ? nil : value

#define SAPNSNullIfNil(value) \
    nil == value ? [NSNull new] : value

#endif /* SAPCompareMacro_h */
