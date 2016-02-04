//
//  SAPClangMacro.h
//  IOSProject
//
//  Created by S A P on 2/4/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#define SAPClangDiagnosticPush _Pragma("clang diagnostic push")
#define SAPClangDiagnosticPop _Pragma("clang diagnostic pop")
#define SAPClangDiagnosticIgnodred(option) _Pragma("clang diagnostic ignored \"##option##\"")

#define SAPClangDiagnosticPushIgnored(option) \
    SAPClangDiagnosticPush \
    SAPClangDiagnosticIgnodred(option)






