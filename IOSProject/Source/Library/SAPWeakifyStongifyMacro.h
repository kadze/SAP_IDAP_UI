//
//  SAPWeakifyStongifyMacro.h
//  IOSProject
//
//  Created by S A P on 2/2/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#define weakify(variable) \
__weak typeof(variable) weak##variable = variable

#define strongify(variable) \
__strong typeof(variable) variable = weak##variable

