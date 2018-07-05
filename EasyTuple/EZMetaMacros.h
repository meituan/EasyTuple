//
//  EZMetaMacros.h
//
//  Created by Chengwei Zang on 2017/8/3.
//  Copyright (c) 2017 Beijing Sankuai Online Technology Co.,Ltd (Meituan)
//

#import <Foundation/Foundation.h>
#import <EasyTuple/EZTupleBase.h>


// Origin data

#define EZ_ORDINAL_NUMBERS                                   first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth, eleventh, twelfth, thirteenth, fourteenth, fifteenth, sixteenth, seventeenth, eighteenth, nineteenth, twentieth
#define EZ_ORDINAL_CAP_NUMBERS                               First, Second, Third, Fourth, Fifth, Sixth, Seventh, Eighth, Ninth, Tenth, Eleventh, Twelfth, Thirteenth, Fourteenth, Fifteenth, Sixteenth, Seventeenth, Eighteenth, Nineteenth, Twentieth
#define EZ_CHARS                                             A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z

// Meta macro method

#define EZ_STRINGIFY(VALUE)                                  EZ_STRINGIFY_(VALUE)
#define EZ_STRINGIFY_(VALUE)                                 # VALUE

#define EZ_CONCAT(A, B)                                      EZ_CONCAT_(A, B)
#define EZ_CONCAT_(A, B)                                     A ## B

#define EZ_ARG_HEAD(FIRST, ...)                              FIRST
#define EZ_ARG_TAIL(FIRST, ...)                              __VA_ARGS__

#define EZ_ARG_AT(N, ...)                                    EZ_ARG_AT_(N, __VA_ARGS__)
#define EZ_ARG_AT_(N, ...)                                   EZ_CONCAT(EZ_ARG_AT, N)(__VA_ARGS__)
#define EZ_ARG_AT0(...)                                      EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT1(_0, ...)                                  EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT2(_0, _1, ...)                              EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT3(_0, _1, _2, ...)                          EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT4(_0, _1, _2, _3, ...)                      EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT5(_0, _1, _2, _3, _4, ...)                  EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT6(_0, _1, _2, _3, _4, _5, ...)              EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT7(_0, _1, _2, _3, _4, _5, _6, ...)          EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT8(_0, _1, _2, _3, _4, _5, _6, _7, ...)      EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT9(_0, _1, _2, _3, _4, _5, _6, _7, _8, ...)  EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT10(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, ...)                                                                \
    EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT11(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, ...)                                                           \
    EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT12(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, ...)                                                      \
    EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT13(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, ...)                                                 \
    EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT14(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, ...)                                            \
    EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT15(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, ...)                                       \
    EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT16(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, ...)                                  \
    EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT17(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, ...)                             \
    EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT18(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, ...)                        \
    EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT19(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, ...)                   \
    EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_ARG_AT20(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, ...)              \
    EZ_ARG_HEAD(__VA_ARGS__)

#define EZ_DEC(VAL)                                          EZ_ARG_AT(VAL, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19)
#define EZ_INC(VAL)                                          EZ_ARG_AT(VAL, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21)
#define EZ_ARG_COUNT(...)   _EZ_ARG_COUNT(__VA_ARGS__)
#define _EZ_ARG_COUNT(...)                                    EZ_ARG_AT(20, ##__VA_ARGS__, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)

#define EZ_TAKE(N, ...)                                      EZ_CONCAT(EZ_TAKE, N)(__VA_ARGS__)
#define EZ_TAKE0(...)
#define EZ_TAKE1(...)                                        EZ_ARG_HEAD(__VA_ARGS__)
#define EZ_TAKE2(...)                                        EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE1(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_TAKE3(...)                                        EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE2(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_TAKE4(...)                                        EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE3(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_TAKE5(...)                                        EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE4(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_TAKE6(...)                                        EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE5(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_TAKE7(...)                                        EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE6(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_TAKE8(...)                                        EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE7(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_TAKE9(...)                                        EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE8(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_TAKE10(...)                                       EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE9(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_TAKE11(...)                                       EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE10(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_TAKE12(...)                                       EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE11(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_TAKE13(...)                                       EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE12(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_TAKE14(...)                                       EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE13(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_TAKE15(...)                                       EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE14(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_TAKE16(...)                                       EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE15(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_TAKE17(...)                                       EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE16(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_TAKE18(...)                                       EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE17(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_TAKE19(...)                                       EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE18(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_TAKE20(...)                                       EZ_ARG_HEAD(__VA_ARGS__), EZ_TAKE19(EZ_ARG_TAIL(__VA_ARGS__))

#define EZ_DROP(N, ...)                                      EZ_CONCAT(EZ_DROP, N)(__VA_ARGS__)
#define EZ_DROP0(...)                                        __VA_ARGS__
#define EZ_DROP1(...)                                        EZ_ARG_TAIL(__VA_ARGS__)
#define EZ_DROP2(...)                                        EZ_DROP1(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_DROP3(...)                                        EZ_DROP2(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_DROP4(...)                                        EZ_DROP3(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_DROP5(...)                                        EZ_DROP4(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_DROP6(...)                                        EZ_DROP5(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_DROP7(...)                                        EZ_DROP6(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_DROP8(...)                                        EZ_DROP7(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_DROP9(...)                                        EZ_DROP8(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_DROP10(...)                                       EZ_DROP9(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_DROP11(...)                                       EZ_DROP10(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_DROP12(...)                                       EZ_DROP11(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_DROP13(...)                                       EZ_DROP12(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_DROP14(...)                                       EZ_DROP13(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_DROP15(...)                                       EZ_DROP14(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_DROP16(...)                                       EZ_DROP15(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_DROP17(...)                                       EZ_DROP16(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_DROP18(...)                                       EZ_DROP17(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_DROP19(...)                                       EZ_DROP18(EZ_ARG_TAIL(__VA_ARGS__))
#define EZ_DROP20(...)                                       EZ_DROP19(EZ_ARG_TAIL(__VA_ARGS__))

#define EZ_INIT(...)                                         EZ_TAKE(EZ_DEC(EZ_ARG_COUNT(__VA_ARGS__)), __VA_ARGS__)
#define EZ_LAST(...)                                         EZ_DROP(EZ_DEC(EZ_ARG_COUNT(__VA_ARGS__)), __VA_ARGS__)

#define EZ_FOR(COUNT, MARCO, SEP)                            EZ_CONCAT(EZ_FOR, COUNT)(MARCO, SEP)
#define EZ_FOR0(MARCO, SEP)
#define EZ_FOR1(MARCO, SEP)                                  MARCO(0)
#define EZ_FOR2(MARCO, SEP)                                  EZ_FOR1(MARCO, SEP) SEP MARCO(1)
#define EZ_FOR3(MARCO, SEP)                                  EZ_FOR2(MARCO, SEP) SEP MARCO(2)
#define EZ_FOR4(MARCO, SEP)                                  EZ_FOR3(MARCO, SEP) SEP MARCO(3)
#define EZ_FOR5(MARCO, SEP)                                  EZ_FOR4(MARCO, SEP) SEP MARCO(4)
#define EZ_FOR6(MARCO, SEP)                                  EZ_FOR5(MARCO, SEP) SEP MARCO(5)
#define EZ_FOR7(MARCO, SEP)                                  EZ_FOR6(MARCO, SEP) SEP MARCO(6)
#define EZ_FOR8(MARCO, SEP)                                  EZ_FOR7(MARCO, SEP) SEP MARCO(7)
#define EZ_FOR9(MARCO, SEP)                                  EZ_FOR8(MARCO, SEP) SEP MARCO(8)
#define EZ_FOR10(MARCO, SEP)                                 EZ_FOR9(MARCO, SEP) SEP MARCO(9)
#define EZ_FOR11(MARCO, SEP)                                 EZ_FOR10(MARCO, SEP) SEP MARCO(10)
#define EZ_FOR12(MARCO, SEP)                                 EZ_FOR11(MARCO, SEP) SEP MARCO(11)
#define EZ_FOR13(MARCO, SEP)                                 EZ_FOR12(MARCO, SEP) SEP MARCO(12)
#define EZ_FOR14(MARCO, SEP)                                 EZ_FOR13(MARCO, SEP) SEP MARCO(13)
#define EZ_FOR15(MARCO, SEP)                                 EZ_FOR14(MARCO, SEP) SEP MARCO(14)
#define EZ_FOR16(MARCO, SEP)                                 EZ_FOR15(MARCO, SEP) SEP MARCO(15)
#define EZ_FOR17(MARCO, SEP)                                 EZ_FOR16(MARCO, SEP) SEP MARCO(16)
#define EZ_FOR18(MARCO, SEP)                                 EZ_FOR17(MARCO, SEP) SEP MARCO(17)
#define EZ_FOR19(MARCO, SEP)                                 EZ_FOR18(MARCO, SEP) SEP MARCO(18)
#define EZ_FOR20(MARCO, SEP)                                 EZ_FOR19(MARCO, SEP) SEP MARCO(19)

#define EZ_FOR_SPACE(COUNT, MARCO)                           EZ_CONCAT(EZ_FOR_SPACE, COUNT)(MARCO)
#define EZ_FOR_SPACE0(MARCO)
#define EZ_FOR_SPACE1(MARCO)                                 MARCO(0)
#define EZ_FOR_SPACE2(MARCO)                                 EZ_FOR_SPACE1(MARCO) MARCO(1)
#define EZ_FOR_SPACE3(MARCO)                                 EZ_FOR_SPACE2(MARCO) MARCO(2)
#define EZ_FOR_SPACE4(MARCO)                                 EZ_FOR_SPACE3(MARCO) MARCO(3)
#define EZ_FOR_SPACE5(MARCO)                                 EZ_FOR_SPACE4(MARCO) MARCO(4)
#define EZ_FOR_SPACE6(MARCO)                                 EZ_FOR_SPACE5(MARCO) MARCO(5)
#define EZ_FOR_SPACE7(MARCO)                                 EZ_FOR_SPACE6(MARCO) MARCO(6)
#define EZ_FOR_SPACE8(MARCO)                                 EZ_FOR_SPACE7(MARCO) MARCO(7)
#define EZ_FOR_SPACE9(MARCO)                                 EZ_FOR_SPACE8(MARCO) MARCO(8)
#define EZ_FOR_SPACE10(MARCO)                                EZ_FOR_SPACE9(MARCO) MARCO(9)
#define EZ_FOR_SPACE11(MARCO)                                EZ_FOR_SPACE10(MARCO) MARCO(10)
#define EZ_FOR_SPACE12(MARCO)                                EZ_FOR_SPACE11(MARCO) MARCO(11)
#define EZ_FOR_SPACE13(MARCO)                                EZ_FOR_SPACE12(MARCO) MARCO(12)
#define EZ_FOR_SPACE14(MARCO)                                EZ_FOR_SPACE13(MARCO) MARCO(13)
#define EZ_FOR_SPACE15(MARCO)                                EZ_FOR_SPACE14(MARCO) MARCO(14)
#define EZ_FOR_SPACE16(MARCO)                                EZ_FOR_SPACE15(MARCO) MARCO(15)
#define EZ_FOR_SPACE17(MARCO)                                EZ_FOR_SPACE16(MARCO) MARCO(16)
#define EZ_FOR_SPACE18(MARCO)                                EZ_FOR_SPACE17(MARCO) MARCO(17)
#define EZ_FOR_SPACE19(MARCO)                                EZ_FOR_SPACE18(MARCO) MARCO(18)
#define EZ_FOR_SPACE20(MARCO)                                EZ_FOR_SPACE19(MARCO) MARCO(19)

#define EZ_FOR_RECURSIVE(COUNT, MARCO, SEP)                  EZ_CONCAT(EZ_FOR_RECURSIVE, COUNT)(MARCO, SEP)
#define EZ_FOR_RECURSIVE0(MARCO, SEP)
#define EZ_FOR_RECURSIVE1(MARCO, SEP)                        MARCO(0)
#define EZ_FOR_RECURSIVE2(MARCO, SEP)                        EZ_FOR_RECURSIVE1(MARCO, SEP) SEP MARCO(1)
#define EZ_FOR_RECURSIVE3(MARCO, SEP)                        EZ_FOR_RECURSIVE2(MARCO, SEP) SEP MARCO(2)
#define EZ_FOR_RECURSIVE4(MARCO, SEP)                        EZ_FOR_RECURSIVE3(MARCO, SEP) SEP MARCO(3)
#define EZ_FOR_RECURSIVE5(MARCO, SEP)                        EZ_FOR_RECURSIVE4(MARCO, SEP) SEP MARCO(4)
#define EZ_FOR_RECURSIVE6(MARCO, SEP)                        EZ_FOR_RECURSIVE5(MARCO, SEP) SEP MARCO(5)
#define EZ_FOR_RECURSIVE7(MARCO, SEP)                        EZ_FOR_RECURSIVE6(MARCO, SEP) SEP MARCO(6)
#define EZ_FOR_RECURSIVE8(MARCO, SEP)                        EZ_FOR_RECURSIVE7(MARCO, SEP) SEP MARCO(7)
#define EZ_FOR_RECURSIVE9(MARCO, SEP)                        EZ_FOR_RECURSIVE8(MARCO, SEP) SEP MARCO(8)
#define EZ_FOR_RECURSIVE10(MARCO, SEP)                       EZ_FOR_RECURSIVE9(MARCO, SEP) SEP MARCO(9)
#define EZ_FOR_RECURSIVE11(MARCO, SEP)                       EZ_FOR_RECURSIVE10(MARCO, SEP) SEP MARCO(10)
#define EZ_FOR_RECURSIVE12(MARCO, SEP)                       EZ_FOR_RECURSIVE11(MARCO, SEP) SEP MARCO(11)
#define EZ_FOR_RECURSIVE13(MARCO, SEP)                       EZ_FOR_RECURSIVE12(MARCO, SEP) SEP MARCO(12)
#define EZ_FOR_RECURSIVE14(MARCO, SEP)                       EZ_FOR_RECURSIVE13(MARCO, SEP) SEP MARCO(13)
#define EZ_FOR_RECURSIVE15(MARCO, SEP)                       EZ_FOR_RECURSIVE14(MARCO, SEP) SEP MARCO(14)
#define EZ_FOR_RECURSIVE16(MARCO, SEP)                       EZ_FOR_RECURSIVE15(MARCO, SEP) SEP MARCO(15)
#define EZ_FOR_RECURSIVE17(MARCO, SEP)                       EZ_FOR_RECURSIVE16(MARCO, SEP) SEP MARCO(16)
#define EZ_FOR_RECURSIVE18(MARCO, SEP)                       EZ_FOR_RECURSIVE17(MARCO, SEP) SEP MARCO(17)
#define EZ_FOR_RECURSIVE19(MARCO, SEP)                       EZ_FOR_RECURSIVE18(MARCO, SEP) SEP MARCO(18)
#define EZ_FOR_RECURSIVE20(MARCO, SEP)                       EZ_FOR_RECURSIVE19(MARCO, SEP) SEP MARCO(19)

#define EZ_FOR_COMMA(COUNT, MARCO)                           EZ_CONCAT(EZ_FOR_COMMA, COUNT)(MARCO)
#define EZ_FOR_COMMA0(MARCO)
#define EZ_FOR_COMMA1(MARCO)                                 MARCO(0)
#define EZ_FOR_COMMA2(MARCO)                                 EZ_FOR_COMMA1(MARCO), MARCO(1)
#define EZ_FOR_COMMA3(MARCO)                                 EZ_FOR_COMMA2(MARCO), MARCO(2)
#define EZ_FOR_COMMA4(MARCO)                                 EZ_FOR_COMMA3(MARCO), MARCO(3)
#define EZ_FOR_COMMA5(MARCO)                                 EZ_FOR_COMMA4(MARCO), MARCO(4)
#define EZ_FOR_COMMA6(MARCO)                                 EZ_FOR_COMMA5(MARCO), MARCO(5)
#define EZ_FOR_COMMA7(MARCO)                                 EZ_FOR_COMMA6(MARCO), MARCO(6)
#define EZ_FOR_COMMA8(MARCO)                                 EZ_FOR_COMMA7(MARCO), MARCO(7)
#define EZ_FOR_COMMA9(MARCO)                                 EZ_FOR_COMMA8(MARCO), MARCO(8)
#define EZ_FOR_COMMA10(MARCO)                                EZ_FOR_COMMA9(MARCO), MARCO(9)
#define EZ_FOR_COMMA11(MARCO)                                EZ_FOR_COMMA10(MARCO), MARCO(10)
#define EZ_FOR_COMMA12(MARCO)                                EZ_FOR_COMMA11(MARCO), MARCO(11)
#define EZ_FOR_COMMA13(MARCO)                                EZ_FOR_COMMA12(MARCO), MARCO(12)
#define EZ_FOR_COMMA14(MARCO)                                EZ_FOR_COMMA13(MARCO), MARCO(13)
#define EZ_FOR_COMMA15(MARCO)                                EZ_FOR_COMMA14(MARCO), MARCO(14)
#define EZ_FOR_COMMA16(MARCO)                                EZ_FOR_COMMA15(MARCO), MARCO(15)
#define EZ_FOR_COMMA17(MARCO)                                EZ_FOR_COMMA16(MARCO), MARCO(16)
#define EZ_FOR_COMMA18(MARCO)                                EZ_FOR_COMMA17(MARCO), MARCO(17)
#define EZ_FOR_COMMA19(MARCO)                                EZ_FOR_COMMA18(MARCO), MARCO(18)
#define EZ_FOR_COMMA20(MARCO)                                EZ_FOR_COMMA19(MARCO), MARCO(19)

#define EZ_FOR_EACH(...)                                     _EZ_FOR_EACH(__VA_ARGS__)
#define _EZ_FOR_EACH(MACRO, SEP, ...)                        EZ_FOR_EACH_CTX(EZ_FOR_EACH_ITER_, SEP, MACRO, ##__VA_ARGS__)
#define EZ_FOR_EACH_ITER_(INDEX, PARAM, MACRO)               MACRO(INDEX, PARAM)

#define EZ_FOR_EACH_CTX(MACRO, SEP, CTX, ...)                EZ_CONCAT(EZ_FOR_EACH_CTX, EZ_ARG_COUNT(__VA_ARGS__))(MACRO, SEP, CTX, ##__VA_ARGS__)
#define EZ_FOR_EACH_CTX0(MACRO, SEP, CTX)
#define EZ_FOR_EACH_CTX1(MACRO, SEP, CTX, _0) MACRO(0, _0, CTX)
#define EZ_FOR_EACH_CTX2(MACRO, SEP, CTX, _0, _1) \
    EZ_FOR_EACH_CTX1(MACRO, SEP, CTX, _0) SEP MACRO(1, _1, CTX)
#define EZ_FOR_EACH_CTX3(MACRO, SEP, CTX, _0, _1, _2) \
    EZ_FOR_EACH_CTX2(MACRO, SEP, CTX, _0, _1) SEP MACRO(2, _2, CTX)
#define EZ_FOR_EACH_CTX4(MACRO, SEP, CTX, _0, _1, _2, _3) \
    EZ_FOR_EACH_CTX3(MACRO, SEP, CTX, _0, _1, _2) SEP MACRO(3, _3, CTX)
#define EZ_FOR_EACH_CTX5(MACRO, SEP, CTX, _0, _1, _2, _3, _4) \
    EZ_FOR_EACH_CTX4(MACRO, SEP, CTX, _0, _1, _2, _3) SEP MACRO(4, _4, CTX)
#define EZ_FOR_EACH_CTX6(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5) \
    EZ_FOR_EACH_CTX5(MACRO, SEP, CTX, _0, _1, _2, _3, _4) SEP MACRO(5, _5, CTX)
#define EZ_FOR_EACH_CTX7(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6) \
    EZ_FOR_EACH_CTX6(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5) SEP MACRO(6, _6, CTX)
#define EZ_FOR_EACH_CTX8(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7) \
    EZ_FOR_EACH_CTX7(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6) SEP MACRO(7, _7, CTX)
#define EZ_FOR_EACH_CTX9(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8) \
    EZ_FOR_EACH_CTX8(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7) SEP MACRO(8, _8, CTX)
#define EZ_FOR_EACH_CTX10(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9) \
    EZ_FOR_EACH_CTX9(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8) SEP MACRO(9, _9, CTX)
#define EZ_FOR_EACH_CTX11(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10) \
    EZ_FOR_EACH_CTX10(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9) SEP MACRO(10, _10, CTX)
#define EZ_FOR_EACH_CTX12(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11) \
    EZ_FOR_EACH_CTX11(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10) SEP MACRO(11, _11, CTX)
#define EZ_FOR_EACH_CTX13(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12) \
    EZ_FOR_EACH_CTX12(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11) SEP MACRO(12, _12, CTX)
#define EZ_FOR_EACH_CTX14(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13) \
    EZ_FOR_EACH_CTX13(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12) SEP MACRO(13, _13, CTX)
#define EZ_FOR_EACH_CTX15(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14) \
    EZ_FOR_EACH_CTX14(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13) SEP MACRO(14, _14, CTX)
#define EZ_FOR_EACH_CTX16(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15) \
    EZ_FOR_EACH_CTX15(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14) SEP MACRO(15, _15, CTX)
#define EZ_FOR_EACH_CTX17(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16) \
    EZ_FOR_EACH_CTX16(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15) SEP MACRO(16, _16, CTX)
#define EZ_FOR_EACH_CTX18(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17) \
    EZ_FOR_EACH_CTX17(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16) SEP MACRO(17, _17, CTX)
#define EZ_FOR_EACH_CTX19(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18) \
    EZ_FOR_EACH_CTX18(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17) SEP MACRO(18, _18, CTX)
#define EZ_FOR_EACH_CTX20(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19) \
    EZ_FOR_EACH_CTX19(MACRO, SEP, CTX, _0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18) SEP MACRO(19, _19, CTX)

#define EZ_IF_EQ(A, B)                                       EZ_CONCAT(EZ_IF_EQ, A)(B)

#define EZ_CONSUME_(...)
#define EZ_EXPAND_(...)                                      __VA_ARGS__

#define EZ_IF_EQ0(VALUE)                                     EZ_CONCAT(EZ_IF_EQ0_, VALUE)
#define EZ_IF_EQ0_0(...)                                     __VA_ARGS__ EZ_CONSUME_
#define EZ_IF_EQ0_1(...)                                     EZ_EXPAND_
#define EZ_IF_EQ0_2(...)                                     EZ_EXPAND_
#define EZ_IF_EQ0_3(...)                                     EZ_EXPAND_
#define EZ_IF_EQ0_4(...)                                     EZ_EXPAND_
#define EZ_IF_EQ0_5(...)                                     EZ_EXPAND_
#define EZ_IF_EQ0_6(...)                                     EZ_EXPAND_
#define EZ_IF_EQ0_7(...)                                     EZ_EXPAND_
#define EZ_IF_EQ0_8(...)                                     EZ_EXPAND_
#define EZ_IF_EQ0_9(...)                                     EZ_EXPAND_
#define EZ_IF_EQ0_10(...)                                    EZ_EXPAND_
#define EZ_IF_EQ0_11(...)                                    EZ_EXPAND_
#define EZ_IF_EQ0_12(...)                                    EZ_EXPAND_
#define EZ_IF_EQ0_13(...)                                    EZ_EXPAND_
#define EZ_IF_EQ0_14(...)                                    EZ_EXPAND_
#define EZ_IF_EQ0_15(...)                                    EZ_EXPAND_
#define EZ_IF_EQ0_16(...)                                    EZ_EXPAND_
#define EZ_IF_EQ0_17(...)                                    EZ_EXPAND_
#define EZ_IF_EQ0_18(...)                                    EZ_EXPAND_
#define EZ_IF_EQ0_19(...)                                    EZ_EXPAND_
#define EZ_IF_EQ0_20(...)                                    EZ_EXPAND_

#define EZ_IF_EQ1(VALUE)                                     EZ_IF_EQ0(EZ_DEC(VALUE))
#define EZ_IF_EQ2(VALUE)                                     EZ_IF_EQ1(EZ_DEC(VALUE))
#define EZ_IF_EQ3(VALUE)                                     EZ_IF_EQ2(EZ_DEC(VALUE))
#define EZ_IF_EQ4(VALUE)                                     EZ_IF_EQ3(EZ_DEC(VALUE))
#define EZ_IF_EQ5(VALUE)                                     EZ_IF_EQ4(EZ_DEC(VALUE))
#define EZ_IF_EQ6(VALUE)                                     EZ_IF_EQ5(EZ_DEC(VALUE))
#define EZ_IF_EQ7(VALUE)                                     EZ_IF_EQ6(EZ_DEC(VALUE))
#define EZ_IF_EQ8(VALUE)                                     EZ_IF_EQ7(EZ_DEC(VALUE))
#define EZ_IF_EQ9(VALUE)                                     EZ_IF_EQ8(EZ_DEC(VALUE))
#define EZ_IF_EQ10(VALUE)                                    EZ_IF_EQ9(EZ_DEC(VALUE))
#define EZ_IF_EQ11(VALUE)                                    EZ_IF_EQ10(EZ_DEC(VALUE))
#define EZ_IF_EQ12(VALUE)                                    EZ_IF_EQ11(EZ_DEC(VALUE))
#define EZ_IF_EQ13(VALUE)                                    EZ_IF_EQ12(EZ_DEC(VALUE))
#define EZ_IF_EQ14(VALUE)                                    EZ_IF_EQ13(EZ_DEC(VALUE))
#define EZ_IF_EQ15(VALUE)                                    EZ_IF_EQ14(EZ_DEC(VALUE))
#define EZ_IF_EQ16(VALUE)                                    EZ_IF_EQ15(EZ_DEC(VALUE))
#define EZ_IF_EQ17(VALUE)                                    EZ_IF_EQ16(EZ_DEC(VALUE))
#define EZ_IF_EQ18(VALUE)                                    EZ_IF_EQ17(EZ_DEC(VALUE))
#define EZ_IF_EQ19(VALUE)                                    EZ_IF_EQ18(EZ_DEC(VALUE))
#define EZ_IF_EQ20(VALUE)                                    EZ_IF_EQ19(EZ_DEC(VALUE))

// Functions

#define EZ_ORDINAL_AT(N)                                     EZ_ARG_AT(N, EZ_ORDINAL_NUMBERS)
#define EZ_ORDINAL_CAP_AT(N)                                 EZ_ARG_AT(N, EZ_ORDINAL_CAP_NUMBERS)
#define EZ_CHARS_AT(N)                                       EZ_ARG_AT(N, EZ_CHARS)

#define EZ_GENERIC_TYPE(index)                               __covariant EZ_CHARS_AT(index): id
#define EZ_PROPERTY_DEF(index)                               @property (nonatomic, strong) EZ_CHARS_AT(index) EZ_ORDINAL_AT(index)
#define _EZ_INIT_PARAM_FIRST(index)                          EZ_ORDINAL_CAP_AT(index):(EZ_CHARS_AT(index))EZ_ORDINAL_AT(index)
#define _EZ_INIT_PARAM(index)                                EZ_ORDINAL_AT(index):(EZ_CHARS_AT(index))EZ_ORDINAL_AT(index)
#define EZ_INIT_PARAM(index)                                 EZ_IF_EQ(0, index)(_EZ_INIT_PARAM_FIRST(index))(_EZ_INIT_PARAM(index))

#define EZ_TUPLE_DEF(i)                                                                                                         \
@interface EZ_CONCAT(EZTuple, i)<EZ_FOR_COMMA(i, EZ_GENERIC_TYPE)> :EZTupleBase                                                     \
                                                                                                                               \
EZ_FOR_RECURSIVE(i, EZ_PROPERTY_DEF, ;);                                                                                         \
                                                                                                                               \
@property (nonatomic, strong) EZ_CHARS_AT(EZ_DEC(i)) last;                                                                       \
                                                                                                                               \
- (instancetype)EZ_CONCAT(initWith, EZ_FOR_SPACE(i, EZ_INIT_PARAM));                                                              \
                                                                                                                               \
@end

#define EZ_TUPLE_DEF_FOREACH(index)                          EZ_TUPLE_DEF(EZ_INC(index))

#define EZ_TUPLE_CLASSES_DEF                                 EZ_FOR(20, EZ_TUPLE_DEF_FOREACH, ;)

#define _EZ_INIT_PARAM_CALL_FIRST(index, param)              EZ_ORDINAL_CAP_AT(index):param
#define _EZ_INIT_PARAM_CALL(index, param)                    EZ_ORDINAL_AT(index):param
#define EZ_INIT_PARAM_CALL(index, param)                     EZ_IF_EQ(0, index)(_EZ_INIT_PARAM_CALL_FIRST(index, param))(_EZ_INIT_PARAM_CALL(index, param))

#define EZTupleAs(_Class_, ...)                              [[_Class_ alloc] EZ_CONCAT(initWith, EZ_FOR_EACH(EZ_INIT_PARAM_CALL, ,__VA_ARGS__))]

#define EZTuple(...)                                         EZTupleAs(EZ_CONCAT(EZTuple, EZ_ARG_COUNT(__VA_ARGS__)), __VA_ARGS__)

#define EZT_FromVar(tuple)                                    (tuple)

#define EZT_UNPACK(index, param, tuple)                       param = [tuple EZ_ORDINAL_AT(index)]

#define EZTupleUnpack(...)                                   EZ_FOR_EACH_CTX_(EZT_UNPACK, ;, EZ_LAST(__VA_ARGS__), EZ_INIT(__VA_ARGS__))
#define EZ_FOR_EACH_CTX_(...)                                EZ_FOR_EACH_CTX(__VA_ARGS__)

#define EZTupleExtend(tuple, ...)                            [tuple join:EZTuple(__VA_ARGS__)]

#define EZT_PrivateSetterDef(_index_)  \
- (void)EZ_CONCAT(_set, EZ_ORDINAL_CAP_AT(_index_)):(id)value excludeNotifiyKey:(NSString *)key

@interface EZTupleBase (Private)

EZ_FOR(20, EZT_PrivateSetterDef, ;);

@end
