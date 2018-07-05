//
//  EZNamedTupleImp.h
//
//  Created by William Zang on 2018/5/15.
//  Copyright (c) 2017 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

#import <EasyTuple/EZMetaMacros.h>

#define EZT_Once(...)                                   X,
#define EZT_NamedPropertyType(...)                      EZ_INIT(__VA_ARGS__)
#define EZT_NamedPropertyTypeWithComma(...)             EZT_NamedPropertyType(__VA_ARGS__),
#define EZT_NamedPropertyName(...)                      EZ_LAST(__VA_ARGS__)
#define EZT_NamedPropertyNameWithComma(...)             EZT_NamedPropertyName(__VA_ARGS__),
#define EZT_NamedPropertyTypeAndName(...)               EZT_NamedPropertyType(__VA_ARGS__) EZT_NamedPropertyName(__VA_ARGS__)
#define EZT_NamedPropertyTypeAndNameWithComma(...)      EZT_NamedPropertyTypeAndName(__VA_ARGS__),
#define EZT_TableToList(_Table_, _Function_)            EZ_INIT(_Table_(_Function_) X)
#define EZT_TableLength(_Table_)                        EZ_ARG_COUNT(EZT_TableToList(_Table_, EZT_Once))
#define EZT_NamedPropertyTypeList(_Table_)              EZT_TableToList(_Table_, EZT_NamedPropertyTypeWithComma)
#define EZT_NamedPropertyNameList(_Table_)              EZT_TableToList(_Table_, EZT_NamedPropertyNameWithComma)
#define EZT_TableInvoke(_Table_, _Function_)            _Table_(_Function_)

#define EZT_TableName(_ClassName_)                      EZ_CONCAT(_ClassName_, Table)
#define EZT_GenericList(...)                            EZ_IF_EQ(0, EZ_ARG_COUNT(__VA_ARGS__))()(<__VA_ARGS__>)
#define EZT_NamedPropertyFunctionParam(...)             id EZT_NamedPropertyName(__VA_ARGS__),
#define EZT_NamedPropertyParamsList(_Table_)            EZT_TableToList(_Table_, EZT_NamedPropertyFunctionParam)

#define EZT_NamedPropertyDefine(...) \
@property (nonatomic, strong, setter=EZ_CONCAT(set_, EZT_NamedPropertyName(__VA_ARGS__)):) \
    EZT_NamedPropertyTypeAndName(__VA_ARGS__);

#define _EZTNamedTupleDef(_ClassName_, ...) \
__attribute__((objc_subclassing_restricted)) \
@interface _ClassName_ EZT_GenericList(__VA_ARGS__) : EZ_CONCAT(EZTuple, EZT_TableLength(EZT_TableName(_ClassName_))) \
    <EZT_NamedPropertyTypeList(EZT_TableName(_ClassName_))>  \
EZT_TableName(_ClassName_)(EZT_NamedPropertyDefine) \
@end \
\
FOUNDATION_EXPORT _ClassName_ * EZ_CONCAT(_ClassName_, Make)(EZT_NamedPropertyParamsList(EZT_TableName(_ClassName_)));

#define EZT_GetterAndSetter(_index_, _propertyName_) \
- (id)_propertyName_ { \
    return [self EZ_ORDINAL_AT(_index_)]; \
} \
\
- (void)EZ_CONCAT(set_, _propertyName_):(id)value { \
    [self EZ_CONCAT(_set, EZ_ORDINAL_CAP_AT(_index_)):value excludeNotifiyKey:@EZ_STRINGIFY(_propertyName_)]; \
}

#define EZT_descriptionProperty(_, _propertyName_) \
[description appendString:@"\t" EZ_STRINGIFY(_propertyName_) @" = "]; \
[description appendString:[(id)self. _propertyName_ description] ?: @"nil"]; \
[description appendString:@";\n"]; \

#define _EZTNamedTupleImp(_ClassName_) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wmismatched-return-types\"") \
_Pragma("clang diagnostic ignored \"-Wmismatched-parameter-types\"") \
@implementation _ClassName_ \
EZ_FOR_EACH(EZT_GetterAndSetter, ;, EZT_NamedPropertyNameList(EZT_TableName(_ClassName_))) \
\
- (NSString *)description { \
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: %p>(\n", self.class, self]; \
    EZ_FOR_EACH(EZT_descriptionProperty, ;, EZT_NamedPropertyNameList(EZT_TableName(_ClassName_))) \
    [description appendString:@")"]; \
    return description; \
} \
@end \
_ClassName_ * EZ_CONCAT(_ClassName_, Make)(EZT_NamedPropertyParamsList(EZT_TableName(_ClassName_))) { \
    return EZTupleAs(_ClassName_, EZT_NamedPropertyNameList(EZT_TableName(_ClassName_))); \
} \
_Pragma("clang diagnostic pop")
