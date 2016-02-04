//
//  SAPWeakifyStongifyMacro.h
//  IOSProject
//
//  Created by S A P on 2/2/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#define SAPWeakify(obj) \
    __weak typeof(obj) __weak_##obj = obj

#define SAPStrongify(obj) \
    SAPClangDiagnosticPushIgnored("-Wshadow") \
    __strong typeof(obj) obj = __weak_##obj \
    SAPClangDiagnosticPop

#define SAPStrongifyAndReturnValueIfNil(obj, returnValue) \
    SAPStrongify(obj); \
    if (!obj) { \
        return returnValue; \
    }

#define SAPStrongifyAndReturnNilIfNil(obj) \
    SAPStrongifyAndReturnValueIfNil(obj, nil)

#define SAPStrongifyAndReturnIfNil(obj) \
    SAPStrongifyAndReturnValueIfNil(obj, SAPEmpty)

