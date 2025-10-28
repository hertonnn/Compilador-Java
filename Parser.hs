{-# OPTIONS_GHC -w #-}
module Parser where

import Tokens
import AST
import qualified Lexer as L
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.12

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 t22 t23 t24 t25 t26 t27 t28 t29
	= HappyTerminal (Tokens)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14
	| HappyAbsSyn15 t15
	| HappyAbsSyn16 t16
	| HappyAbsSyn17 t17
	| HappyAbsSyn18 t18
	| HappyAbsSyn19 t19
	| HappyAbsSyn20 t20
	| HappyAbsSyn21 t21
	| HappyAbsSyn22 t22
	| HappyAbsSyn23 t23
	| HappyAbsSyn24 t24
	| HappyAbsSyn25 t25
	| HappyAbsSyn26 t26
	| HappyAbsSyn27 t27
	| HappyAbsSyn28 t28
	| HappyAbsSyn29 t29

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,340) ([0,0,256,960,0,32768,73,192,0,0,0,192,0,0,0,0,0,0,3840,1008,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24576,18,32,0,32768,73,192,0,0,294,768,0,0,1024,0,0,0,0,0,0,0,0,4,15,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,56832,14,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15224,0,0,0,0,0,0,0,128,0,0,8192,49664,14,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,4096,0,16,0,19328,32800,0,0,0,1,0,0,0,4,0,0,0,16,0,0,0,64,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,52096,32768,0,0,0,0,0,0,0,8,3,0,0,61487,3,0,0,0,0,0,0,294,512,0,0,1176,2048,0,0,4704,8192,0,0,18816,32768,0,0,9728,1,2,0,38912,4,8,0,24576,18,32,0,32768,73,128,0,0,294,512,0,0,1176,2048,0,0,4704,8192,0,0,18816,49152,0,0,9728,1,3,0,0,0,0,0,0,0,0,0,0,60,0,0,0,240,0,0,0,960,0,0,0,3840,0,0,0,15360,0,0,0,61440,0,0,0,0,0,0,0,0,0,0,0,0,48,0,0,0,192,0,0,0,3008,0,0,0,0,0,0,0,0,0,0,0,61440,0,0,0,0,264,0,0,0,0,0,0,0,0,0,0,0,512,7168,0,0,1176,3072,0,0,4704,12288,0,0,19328,32768,0,0,0,0,2,0,49152,515,0,0,0,2048,0,0,0,0,0,0,0,302,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,192,0,0,0,0,0,0,0,0,0,0,0,2048,45184,3,0,0,0,0,0,0,2048,0,0,0,0,0,0,15360,32,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,752,0,0,0,2048,0,0,0,8192,3072,0,0,32768,12288,0,0,0,66,0,0,0,0,0,0,0,0,32,0,0,1024,0,0,0,0,0,0,0,1208,2048,0,0,3840,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,1792,0,0,4096,0,0,0,16384,0,0,0,0,8,0,0,0,32,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3778,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,32768,2048,59,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_calc","ExprL","ExprR","Expr","Program","ListaFuncoes","Funcao","TipoRetorno","DeclParametros","Parametro","BlocoPrincipal","Declaracoes","Declaracao","Tipo","ListaId","Bloco","ListaCmd","Comando","Retorno","CmdSe","CmdEnquanto","CmdAtrib","CmdEscrita","CmdLeitura","ChamadaProc","ChamadaF","ListaParametros","CInt","CDouble","literal","'+'","'-'","'*'","'/'","'('","')'","'['","']'","'{'","'}'","','","';'","'>='","'<='","'<'","'>'","'=='","'!='","'&&'","'||'","'!'","id","int","string","double","void","return","read","'='","print","while","if","else","%eof"]
        bit_start = st * 66
        bit_end = (st + 1) * 66
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..65]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (41) = happyShift action_18
action_0 (55) = happyShift action_19
action_0 (56) = happyShift action_20
action_0 (57) = happyShift action_21
action_0 (58) = happyShift action_22
action_0 (7) = happyGoto action_12
action_0 (8) = happyGoto action_13
action_0 (9) = happyGoto action_14
action_0 (10) = happyGoto action_15
action_0 (13) = happyGoto action_16
action_0 (16) = happyGoto action_17
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (30) = happyShift action_6
action_1 (31) = happyShift action_7
action_1 (34) = happyShift action_8
action_1 (37) = happyShift action_9
action_1 (53) = happyShift action_10
action_1 (54) = happyShift action_11
action_1 (4) = happyGoto action_2
action_1 (5) = happyGoto action_3
action_1 (6) = happyGoto action_4
action_1 (28) = happyGoto action_5
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (51) = happyShift action_61
action_2 (52) = happyShift action_62
action_2 _ = happyFail (happyExpListPerState 2)

action_3 _ = happyReduce_5

action_4 (33) = happyShift action_51
action_4 (34) = happyShift action_52
action_4 (35) = happyShift action_53
action_4 (36) = happyShift action_54
action_4 (45) = happyShift action_55
action_4 (46) = happyShift action_56
action_4 (47) = happyShift action_57
action_4 (48) = happyShift action_58
action_4 (49) = happyShift action_59
action_4 (50) = happyShift action_60
action_4 _ = happyFail (happyExpListPerState 4)

action_5 _ = happyReduce_20

action_6 _ = happyReduce_18

action_7 _ = happyReduce_19

action_8 (30) = happyShift action_6
action_8 (31) = happyShift action_7
action_8 (34) = happyShift action_8
action_8 (37) = happyShift action_50
action_8 (54) = happyShift action_11
action_8 (6) = happyGoto action_49
action_8 (28) = happyGoto action_5
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (30) = happyShift action_6
action_9 (31) = happyShift action_7
action_9 (34) = happyShift action_8
action_9 (37) = happyShift action_9
action_9 (53) = happyShift action_10
action_9 (54) = happyShift action_11
action_9 (4) = happyGoto action_47
action_9 (5) = happyGoto action_3
action_9 (6) = happyGoto action_48
action_9 (28) = happyGoto action_5
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (30) = happyShift action_6
action_10 (31) = happyShift action_7
action_10 (34) = happyShift action_8
action_10 (37) = happyShift action_9
action_10 (53) = happyShift action_10
action_10 (54) = happyShift action_11
action_10 (4) = happyGoto action_46
action_10 (5) = happyGoto action_3
action_10 (6) = happyGoto action_4
action_10 (28) = happyGoto action_5
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (37) = happyShift action_45
action_11 _ = happyReduce_21

action_12 (66) = happyAccept
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (41) = happyShift action_18
action_13 (55) = happyShift action_19
action_13 (56) = happyShift action_20
action_13 (57) = happyShift action_21
action_13 (58) = happyShift action_22
action_13 (9) = happyGoto action_43
action_13 (10) = happyGoto action_15
action_13 (13) = happyGoto action_44
action_13 (16) = happyGoto action_17
action_13 _ = happyFail (happyExpListPerState 13)

action_14 _ = happyReduce_25

action_15 (54) = happyShift action_42
action_15 _ = happyFail (happyExpListPerState 15)

action_16 _ = happyReduce_23

action_17 _ = happyReduce_28

action_18 (54) = happyShift action_36
action_18 (55) = happyShift action_19
action_18 (56) = happyShift action_20
action_18 (57) = happyShift action_21
action_18 (59) = happyShift action_37
action_18 (60) = happyShift action_38
action_18 (62) = happyShift action_39
action_18 (63) = happyShift action_40
action_18 (64) = happyShift action_41
action_18 (14) = happyGoto action_23
action_18 (15) = happyGoto action_24
action_18 (16) = happyGoto action_25
action_18 (19) = happyGoto action_26
action_18 (20) = happyGoto action_27
action_18 (21) = happyGoto action_28
action_18 (22) = happyGoto action_29
action_18 (23) = happyGoto action_30
action_18 (24) = happyGoto action_31
action_18 (25) = happyGoto action_32
action_18 (26) = happyGoto action_33
action_18 (27) = happyGoto action_34
action_18 (28) = happyGoto action_35
action_18 _ = happyFail (happyExpListPerState 18)

action_19 _ = happyReduce_38

action_20 _ = happyReduce_39

action_21 _ = happyReduce_40

action_22 _ = happyReduce_29

action_23 (54) = happyShift action_36
action_23 (55) = happyShift action_19
action_23 (56) = happyShift action_20
action_23 (57) = happyShift action_21
action_23 (59) = happyShift action_37
action_23 (60) = happyShift action_38
action_23 (62) = happyShift action_39
action_23 (63) = happyShift action_40
action_23 (64) = happyShift action_41
action_23 (15) = happyGoto action_96
action_23 (16) = happyGoto action_25
action_23 (19) = happyGoto action_97
action_23 (20) = happyGoto action_27
action_23 (21) = happyGoto action_28
action_23 (22) = happyGoto action_29
action_23 (23) = happyGoto action_30
action_23 (24) = happyGoto action_31
action_23 (25) = happyGoto action_32
action_23 (26) = happyGoto action_33
action_23 (27) = happyGoto action_34
action_23 (28) = happyGoto action_35
action_23 _ = happyFail (happyExpListPerState 23)

action_24 _ = happyReduce_36

action_25 (54) = happyShift action_95
action_25 (17) = happyGoto action_94
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (42) = happyShift action_93
action_26 (54) = happyShift action_36
action_26 (59) = happyShift action_37
action_26 (60) = happyShift action_38
action_26 (62) = happyShift action_39
action_26 (63) = happyShift action_40
action_26 (64) = happyShift action_41
action_26 (20) = happyGoto action_92
action_26 (21) = happyGoto action_28
action_26 (22) = happyGoto action_29
action_26 (23) = happyGoto action_30
action_26 (24) = happyGoto action_31
action_26 (25) = happyGoto action_32
action_26 (26) = happyGoto action_33
action_26 (27) = happyGoto action_34
action_26 (28) = happyGoto action_35
action_26 _ = happyFail (happyExpListPerState 26)

action_27 _ = happyReduce_45

action_28 _ = happyReduce_52

action_29 _ = happyReduce_46

action_30 _ = happyReduce_47

action_31 _ = happyReduce_48

action_32 _ = happyReduce_49

action_33 _ = happyReduce_50

action_34 _ = happyReduce_51

action_35 (44) = happyShift action_91
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (37) = happyShift action_45
action_36 (61) = happyShift action_90
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (30) = happyShift action_6
action_37 (31) = happyShift action_7
action_37 (32) = happyShift action_88
action_37 (34) = happyShift action_8
action_37 (37) = happyShift action_50
action_37 (44) = happyShift action_89
action_37 (54) = happyShift action_11
action_37 (6) = happyGoto action_87
action_37 (28) = happyGoto action_5
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (37) = happyShift action_86
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (37) = happyShift action_85
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (37) = happyShift action_84
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (37) = happyShift action_83
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (37) = happyShift action_82
action_42 _ = happyFail (happyExpListPerState 42)

action_43 _ = happyReduce_24

action_44 _ = happyReduce_22

action_45 (30) = happyShift action_6
action_45 (31) = happyShift action_7
action_45 (32) = happyShift action_80
action_45 (34) = happyShift action_8
action_45 (37) = happyShift action_50
action_45 (38) = happyShift action_81
action_45 (54) = happyShift action_11
action_45 (6) = happyGoto action_78
action_45 (28) = happyGoto action_5
action_45 (29) = happyGoto action_79
action_45 _ = happyFail (happyExpListPerState 45)

action_46 _ = happyReduce_3

action_47 (38) = happyShift action_77
action_47 (51) = happyShift action_61
action_47 (52) = happyShift action_62
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (33) = happyShift action_51
action_48 (34) = happyShift action_52
action_48 (35) = happyShift action_53
action_48 (36) = happyShift action_54
action_48 (38) = happyShift action_76
action_48 (45) = happyShift action_55
action_48 (46) = happyShift action_56
action_48 (47) = happyShift action_57
action_48 (48) = happyShift action_58
action_48 (49) = happyShift action_59
action_48 (50) = happyShift action_60
action_48 _ = happyFail (happyExpListPerState 48)

action_49 _ = happyReduce_16

action_50 (30) = happyShift action_6
action_50 (31) = happyShift action_7
action_50 (34) = happyShift action_8
action_50 (37) = happyShift action_50
action_50 (54) = happyShift action_11
action_50 (6) = happyGoto action_75
action_50 (28) = happyGoto action_5
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (30) = happyShift action_6
action_51 (31) = happyShift action_7
action_51 (34) = happyShift action_8
action_51 (37) = happyShift action_50
action_51 (54) = happyShift action_11
action_51 (6) = happyGoto action_74
action_51 (28) = happyGoto action_5
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (30) = happyShift action_6
action_52 (31) = happyShift action_7
action_52 (34) = happyShift action_8
action_52 (37) = happyShift action_50
action_52 (54) = happyShift action_11
action_52 (6) = happyGoto action_73
action_52 (28) = happyGoto action_5
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (30) = happyShift action_6
action_53 (31) = happyShift action_7
action_53 (34) = happyShift action_8
action_53 (37) = happyShift action_50
action_53 (54) = happyShift action_11
action_53 (6) = happyGoto action_72
action_53 (28) = happyGoto action_5
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (30) = happyShift action_6
action_54 (31) = happyShift action_7
action_54 (34) = happyShift action_8
action_54 (37) = happyShift action_50
action_54 (54) = happyShift action_11
action_54 (6) = happyGoto action_71
action_54 (28) = happyGoto action_5
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (30) = happyShift action_6
action_55 (31) = happyShift action_7
action_55 (34) = happyShift action_8
action_55 (37) = happyShift action_50
action_55 (54) = happyShift action_11
action_55 (6) = happyGoto action_70
action_55 (28) = happyGoto action_5
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (30) = happyShift action_6
action_56 (31) = happyShift action_7
action_56 (34) = happyShift action_8
action_56 (37) = happyShift action_50
action_56 (54) = happyShift action_11
action_56 (6) = happyGoto action_69
action_56 (28) = happyGoto action_5
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (30) = happyShift action_6
action_57 (31) = happyShift action_7
action_57 (34) = happyShift action_8
action_57 (37) = happyShift action_50
action_57 (54) = happyShift action_11
action_57 (6) = happyGoto action_68
action_57 (28) = happyGoto action_5
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (30) = happyShift action_6
action_58 (31) = happyShift action_7
action_58 (34) = happyShift action_8
action_58 (37) = happyShift action_50
action_58 (54) = happyShift action_11
action_58 (6) = happyGoto action_67
action_58 (28) = happyGoto action_5
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (30) = happyShift action_6
action_59 (31) = happyShift action_7
action_59 (34) = happyShift action_8
action_59 (37) = happyShift action_50
action_59 (54) = happyShift action_11
action_59 (6) = happyGoto action_66
action_59 (28) = happyGoto action_5
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (30) = happyShift action_6
action_60 (31) = happyShift action_7
action_60 (34) = happyShift action_8
action_60 (37) = happyShift action_50
action_60 (54) = happyShift action_11
action_60 (6) = happyGoto action_65
action_60 (28) = happyGoto action_5
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (30) = happyShift action_6
action_61 (31) = happyShift action_7
action_61 (34) = happyShift action_8
action_61 (37) = happyShift action_9
action_61 (53) = happyShift action_10
action_61 (54) = happyShift action_11
action_61 (4) = happyGoto action_64
action_61 (5) = happyGoto action_3
action_61 (6) = happyGoto action_4
action_61 (28) = happyGoto action_5
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (30) = happyShift action_6
action_62 (31) = happyShift action_7
action_62 (34) = happyShift action_8
action_62 (37) = happyShift action_9
action_62 (53) = happyShift action_10
action_62 (54) = happyShift action_11
action_62 (4) = happyGoto action_63
action_62 (5) = happyGoto action_3
action_62 (6) = happyGoto action_4
action_62 (28) = happyGoto action_5
action_62 _ = happyFail (happyExpListPerState 62)

action_63 _ = happyReduce_2

action_64 _ = happyReduce_1

action_65 (33) = happyShift action_51
action_65 (34) = happyShift action_52
action_65 (35) = happyShift action_53
action_65 (36) = happyShift action_54
action_65 _ = happyReduce_7

action_66 (33) = happyShift action_51
action_66 (34) = happyShift action_52
action_66 (35) = happyShift action_53
action_66 (36) = happyShift action_54
action_66 _ = happyReduce_6

action_67 (33) = happyShift action_51
action_67 (34) = happyShift action_52
action_67 (35) = happyShift action_53
action_67 (36) = happyShift action_54
action_67 _ = happyReduce_8

action_68 (33) = happyShift action_51
action_68 (34) = happyShift action_52
action_68 (35) = happyShift action_53
action_68 (36) = happyShift action_54
action_68 _ = happyReduce_9

action_69 (33) = happyShift action_51
action_69 (34) = happyShift action_52
action_69 (35) = happyShift action_53
action_69 (36) = happyShift action_54
action_69 _ = happyReduce_11

action_70 (33) = happyShift action_51
action_70 (34) = happyShift action_52
action_70 (35) = happyShift action_53
action_70 (36) = happyShift action_54
action_70 _ = happyReduce_10

action_71 _ = happyReduce_15

action_72 _ = happyReduce_14

action_73 (35) = happyShift action_53
action_73 (36) = happyShift action_54
action_73 _ = happyReduce_13

action_74 (35) = happyShift action_53
action_74 (36) = happyShift action_54
action_74 _ = happyReduce_12

action_75 (33) = happyShift action_51
action_75 (34) = happyShift action_52
action_75 (35) = happyShift action_53
action_75 (36) = happyShift action_54
action_75 (38) = happyShift action_76
action_75 _ = happyFail (happyExpListPerState 75)

action_76 _ = happyReduce_17

action_77 _ = happyReduce_4

action_78 (33) = happyShift action_51
action_78 (34) = happyShift action_52
action_78 (35) = happyShift action_53
action_78 (36) = happyShift action_54
action_78 _ = happyReduce_69

action_79 (38) = happyShift action_114
action_79 (43) = happyShift action_115
action_79 _ = happyFail (happyExpListPerState 79)

action_80 _ = happyReduce_70

action_81 _ = happyReduce_66

action_82 (38) = happyShift action_113
action_82 (55) = happyShift action_19
action_82 (56) = happyShift action_20
action_82 (57) = happyShift action_21
action_82 (11) = happyGoto action_110
action_82 (12) = happyGoto action_111
action_82 (16) = happyGoto action_112
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (30) = happyShift action_6
action_83 (31) = happyShift action_7
action_83 (34) = happyShift action_8
action_83 (37) = happyShift action_9
action_83 (53) = happyShift action_10
action_83 (54) = happyShift action_11
action_83 (4) = happyGoto action_109
action_83 (5) = happyGoto action_3
action_83 (6) = happyGoto action_4
action_83 (28) = happyGoto action_5
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (30) = happyShift action_6
action_84 (31) = happyShift action_7
action_84 (34) = happyShift action_8
action_84 (37) = happyShift action_9
action_84 (53) = happyShift action_10
action_84 (54) = happyShift action_11
action_84 (4) = happyGoto action_108
action_84 (5) = happyGoto action_3
action_84 (6) = happyGoto action_4
action_84 (28) = happyGoto action_5
action_84 _ = happyFail (happyExpListPerState 84)

action_85 (30) = happyShift action_6
action_85 (31) = happyShift action_7
action_85 (32) = happyShift action_107
action_85 (34) = happyShift action_8
action_85 (37) = happyShift action_50
action_85 (54) = happyShift action_11
action_85 (6) = happyGoto action_106
action_85 (28) = happyGoto action_5
action_85 _ = happyFail (happyExpListPerState 85)

action_86 (54) = happyShift action_105
action_86 _ = happyFail (happyExpListPerState 86)

action_87 (33) = happyShift action_51
action_87 (34) = happyShift action_52
action_87 (35) = happyShift action_53
action_87 (36) = happyShift action_54
action_87 (44) = happyShift action_104
action_87 _ = happyFail (happyExpListPerState 87)

action_88 (44) = happyShift action_103
action_88 _ = happyFail (happyExpListPerState 88)

action_89 _ = happyReduce_55

action_90 (30) = happyShift action_6
action_90 (31) = happyShift action_7
action_90 (32) = happyShift action_102
action_90 (34) = happyShift action_8
action_90 (37) = happyShift action_50
action_90 (54) = happyShift action_11
action_90 (6) = happyGoto action_101
action_90 (28) = happyGoto action_5
action_90 _ = happyFail (happyExpListPerState 90)

action_91 _ = happyReduce_64

action_92 _ = happyReduce_44

action_93 _ = happyReduce_34

action_94 (43) = happyShift action_99
action_94 (44) = happyShift action_100
action_94 _ = happyFail (happyExpListPerState 94)

action_95 _ = happyReduce_42

action_96 _ = happyReduce_35

action_97 (42) = happyShift action_98
action_97 (54) = happyShift action_36
action_97 (59) = happyShift action_37
action_97 (60) = happyShift action_38
action_97 (62) = happyShift action_39
action_97 (63) = happyShift action_40
action_97 (64) = happyShift action_41
action_97 (20) = happyGoto action_92
action_97 (21) = happyGoto action_28
action_97 (22) = happyGoto action_29
action_97 (23) = happyGoto action_30
action_97 (24) = happyGoto action_31
action_97 (25) = happyGoto action_32
action_97 (26) = happyGoto action_33
action_97 (27) = happyGoto action_34
action_97 (28) = happyGoto action_35
action_97 _ = happyFail (happyExpListPerState 97)

action_98 _ = happyReduce_33

action_99 (54) = happyShift action_129
action_99 _ = happyFail (happyExpListPerState 99)

action_100 _ = happyReduce_37

action_101 (33) = happyShift action_51
action_101 (34) = happyShift action_52
action_101 (35) = happyShift action_53
action_101 (36) = happyShift action_54
action_101 (44) = happyShift action_128
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (44) = happyShift action_127
action_102 _ = happyFail (happyExpListPerState 102)

action_103 _ = happyReduce_54

action_104 _ = happyReduce_53

action_105 (38) = happyShift action_126
action_105 _ = happyFail (happyExpListPerState 105)

action_106 (33) = happyShift action_51
action_106 (34) = happyShift action_52
action_106 (35) = happyShift action_53
action_106 (36) = happyShift action_54
action_106 (38) = happyShift action_125
action_106 _ = happyFail (happyExpListPerState 106)

action_107 (38) = happyShift action_124
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (38) = happyShift action_123
action_108 (51) = happyShift action_61
action_108 (52) = happyShift action_62
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (38) = happyShift action_122
action_109 (51) = happyShift action_61
action_109 (52) = happyShift action_62
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (38) = happyShift action_120
action_110 (43) = happyShift action_121
action_110 _ = happyFail (happyExpListPerState 110)

action_111 _ = happyReduce_31

action_112 (54) = happyShift action_119
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (41) = happyShift action_18
action_113 (13) = happyGoto action_118
action_113 _ = happyFail (happyExpListPerState 113)

action_114 _ = happyReduce_65

action_115 (30) = happyShift action_6
action_115 (31) = happyShift action_7
action_115 (32) = happyShift action_117
action_115 (34) = happyShift action_8
action_115 (37) = happyShift action_50
action_115 (54) = happyShift action_11
action_115 (6) = happyGoto action_116
action_115 (28) = happyGoto action_5
action_115 _ = happyFail (happyExpListPerState 115)

action_116 (33) = happyShift action_51
action_116 (34) = happyShift action_52
action_116 (35) = happyShift action_53
action_116 (36) = happyShift action_54
action_116 _ = happyReduce_67

action_117 _ = happyReduce_68

action_118 _ = happyReduce_27

action_119 _ = happyReduce_32

action_120 (41) = happyShift action_18
action_120 (13) = happyGoto action_137
action_120 _ = happyFail (happyExpListPerState 120)

action_121 (55) = happyShift action_19
action_121 (56) = happyShift action_20
action_121 (57) = happyShift action_21
action_121 (12) = happyGoto action_136
action_121 (16) = happyGoto action_112
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (41) = happyShift action_134
action_122 (18) = happyGoto action_135
action_122 _ = happyFail (happyExpListPerState 122)

action_123 (41) = happyShift action_134
action_123 (18) = happyGoto action_133
action_123 _ = happyFail (happyExpListPerState 123)

action_124 (44) = happyShift action_132
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (44) = happyShift action_131
action_125 _ = happyFail (happyExpListPerState 125)

action_126 (44) = happyShift action_130
action_126 _ = happyFail (happyExpListPerState 126)

action_127 _ = happyReduce_60

action_128 _ = happyReduce_59

action_129 _ = happyReduce_41

action_130 _ = happyReduce_63

action_131 _ = happyReduce_61

action_132 _ = happyReduce_62

action_133 _ = happyReduce_58

action_134 (54) = happyShift action_36
action_134 (59) = happyShift action_37
action_134 (60) = happyShift action_38
action_134 (62) = happyShift action_39
action_134 (63) = happyShift action_40
action_134 (64) = happyShift action_41
action_134 (19) = happyGoto action_139
action_134 (20) = happyGoto action_27
action_134 (21) = happyGoto action_28
action_134 (22) = happyGoto action_29
action_134 (23) = happyGoto action_30
action_134 (24) = happyGoto action_31
action_134 (25) = happyGoto action_32
action_134 (26) = happyGoto action_33
action_134 (27) = happyGoto action_34
action_134 (28) = happyGoto action_35
action_134 _ = happyFail (happyExpListPerState 134)

action_135 (65) = happyShift action_138
action_135 _ = happyReduce_56

action_136 _ = happyReduce_30

action_137 _ = happyReduce_26

action_138 (41) = happyShift action_134
action_138 (18) = happyGoto action_141
action_138 _ = happyFail (happyExpListPerState 138)

action_139 (42) = happyShift action_140
action_139 (54) = happyShift action_36
action_139 (59) = happyShift action_37
action_139 (60) = happyShift action_38
action_139 (62) = happyShift action_39
action_139 (63) = happyShift action_40
action_139 (64) = happyShift action_41
action_139 (20) = happyGoto action_92
action_139 (21) = happyGoto action_28
action_139 (22) = happyGoto action_29
action_139 (23) = happyGoto action_30
action_139 (24) = happyGoto action_31
action_139 (25) = happyGoto action_32
action_139 (26) = happyGoto action_33
action_139 (27) = happyGoto action_34
action_139 (28) = happyGoto action_35
action_139 _ = happyFail (happyExpListPerState 139)

action_140 _ = happyReduce_43

action_141 _ = happyReduce_57

happyReduce_1 = happySpecReduce_3  4 happyReduction_1
happyReduction_1 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (And happy_var_1 happy_var_3
	)
happyReduction_1 _ _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_3  4 happyReduction_2
happyReduction_2 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (Or happy_var_1 happy_var_3
	)
happyReduction_2 _ _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_2  4 happyReduction_3
happyReduction_3 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (Not happy_var_2
	)
happyReduction_3 _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_3  4 happyReduction_4
happyReduction_4 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (happy_var_2
	)
happyReduction_4 _ _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  4 happyReduction_5
happyReduction_5 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Rel happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_3  5 happyReduction_6
happyReduction_6 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (Req happy_var_1 happy_var_3
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  5 happyReduction_7
happyReduction_7 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (Rdif happy_var_1 happy_var_3
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  5 happyReduction_8
happyReduction_8 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (Rgt happy_var_1 happy_var_3
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  5 happyReduction_9
happyReduction_9 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (Rlt happy_var_1 happy_var_3
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  5 happyReduction_10
happyReduction_10 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (Rge happy_var_1 happy_var_3
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  5 happyReduction_11
happyReduction_11 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (Rle happy_var_1 happy_var_3
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  6 happyReduction_12
happyReduction_12 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (Add happy_var_1 happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  6 happyReduction_13
happyReduction_13 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (Sub happy_var_1 happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  6 happyReduction_14
happyReduction_14 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (Mul happy_var_1 happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  6 happyReduction_15
happyReduction_15 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (Div happy_var_1 happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_2  6 happyReduction_16
happyReduction_16 (HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (Neg happy_var_2
	)
happyReduction_16 _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  6 happyReduction_17
happyReduction_17 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (happy_var_2
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  6 happyReduction_18
happyReduction_18 (HappyTerminal (CINT happy_var_1))
	 =  HappyAbsSyn6
		 (Const (CInt happy_var_1)
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  6 happyReduction_19
happyReduction_19 (HappyTerminal (CDOUBLE happy_var_1))
	 =  HappyAbsSyn6
		 (Const (CDouble happy_var_1)
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  6 happyReduction_20
happyReduction_20 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  6 happyReduction_21
happyReduction_21 (HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn6
		 (IdVar happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_2  7 happyReduction_22
happyReduction_22 (HappyAbsSyn13  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (case happy_var_2 of
                                         BlocoP v c -> Prog (map (funcaoDeFundef) happy_var_1) (map (defDeFundef) happy_var_1) v c
	)
happyReduction_22 _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  7 happyReduction_23
happyReduction_23 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn7
		 (case happy_var_1 of
                           BlocoP v c -> Prog [] [] v c
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_2  8 happyReduction_24
happyReduction_24 (HappyAbsSyn9  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1 ++ [happy_var_2]
	)
happyReduction_24 _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  8 happyReduction_25
happyReduction_25 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn8
		 ([happy_var_1]
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happyReduce 6 9 happyReduction_26
happyReduction_26 ((HappyAbsSyn13  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_2)) `HappyStk`
	(HappyAbsSyn10  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (FunDef (happy_var_2 :->: (happy_var_4, happy_var_1)) happy_var_6
	) `HappyStk` happyRest

happyReduce_27 = happyReduce 5 9 happyReduction_27
happyReduction_27 ((HappyAbsSyn13  happy_var_5) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_2)) `HappyStk`
	(HappyAbsSyn10  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn9
		 (FunDef (happy_var_2 :->: ([], happy_var_1)) happy_var_5
	) `HappyStk` happyRest

happyReduce_28 = happySpecReduce_1  10 happyReduction_28
happyReduction_28 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  10 happyReduction_29
happyReduction_29 _
	 =  HappyAbsSyn10
		 (TVoid
	)

happyReduce_30 = happySpecReduce_3  11 happyReduction_30
happyReduction_30 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1 ++ [happy_var_3]
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  11 happyReduction_31
happyReduction_31 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn11
		 ([happy_var_1]
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_2  12 happyReduction_32
happyReduction_32 (HappyTerminal (ID happy_var_2))
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn12
		 (happy_var_2:#:(happy_var_1,0)
	)
happyReduction_32 _ _  = notHappyAtAll 

happyReduce_33 = happyReduce 4 13 happyReduction_33
happyReduction_33 (_ `HappyStk`
	(HappyAbsSyn19  happy_var_3) `HappyStk`
	(HappyAbsSyn14  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn13
		 (BlocoP happy_var_2 happy_var_3
	) `HappyStk` happyRest

happyReduce_34 = happySpecReduce_3  13 happyReduction_34
happyReduction_34 _
	(HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (BlocoP [] happy_var_2
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_2  14 happyReduction_35
happyReduction_35 (HappyAbsSyn15  happy_var_2)
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1 ++ happy_var_2
	)
happyReduction_35 _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  14 happyReduction_36
happyReduction_36 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  15 happyReduction_37
happyReduction_37 _
	(HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn15
		 (map (\s -> s:#:(happy_var_1,0)) happy_var_2
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  16 happyReduction_38
happyReduction_38 _
	 =  HappyAbsSyn16
		 (TInt
	)

happyReduce_39 = happySpecReduce_1  16 happyReduction_39
happyReduction_39 _
	 =  HappyAbsSyn16
		 (TString
	)

happyReduce_40 = happySpecReduce_1  16 happyReduction_40
happyReduction_40 _
	 =  HappyAbsSyn16
		 (TDouble
	)

happyReduce_41 = happySpecReduce_3  17 happyReduction_41
happyReduction_41 (HappyTerminal (ID happy_var_3))
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 ++ [happy_var_3]
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1  17 happyReduction_42
happyReduction_42 (HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn17
		 ([happy_var_1]
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_3  18 happyReduction_43
happyReduction_43 _
	(HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (happy_var_2
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_2  19 happyReduction_44
happyReduction_44 (HappyAbsSyn20  happy_var_2)
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1 ++ [happy_var_2]
	)
happyReduction_44 _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  19 happyReduction_45
happyReduction_45 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 ([happy_var_1]
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_1  20 happyReduction_46
happyReduction_46 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_46 _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_1  20 happyReduction_47
happyReduction_47 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_47 _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  20 happyReduction_48
happyReduction_48 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_1  20 happyReduction_49
happyReduction_49 (HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_49 _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  20 happyReduction_50
happyReduction_50 (HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_1  20 happyReduction_51
happyReduction_51 (HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_51 _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_1  20 happyReduction_52
happyReduction_52 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_52 _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_3  21 happyReduction_53
happyReduction_53 _
	(HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn21
		 (Ret (Just happy_var_2)
	)
happyReduction_53 _ _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_3  21 happyReduction_54
happyReduction_54 _
	(HappyTerminal (LITERAL happy_var_2))
	_
	 =  HappyAbsSyn21
		 (Ret (Just (Lit happy_var_2))
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_2  21 happyReduction_55
happyReduction_55 _
	_
	 =  HappyAbsSyn21
		 (Ret (Nothing)
	)

happyReduce_56 = happyReduce 5 22 happyReduction_56
happyReduction_56 ((HappyAbsSyn18  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (If happy_var_3 happy_var_5 []
	) `HappyStk` happyRest

happyReduce_57 = happyReduce 7 22 happyReduction_57
happyReduction_57 ((HappyAbsSyn18  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (If happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_58 = happyReduce 5 23 happyReduction_58
happyReduction_58 ((HappyAbsSyn18  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (While happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_59 = happyReduce 4 24 happyReduction_59
happyReduction_59 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (Atrib happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_60 = happyReduce 4 24 happyReduction_60
happyReduction_60 (_ `HappyStk`
	(HappyTerminal (LITERAL happy_var_3)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (Atrib happy_var_1 (Lit happy_var_3)
	) `HappyStk` happyRest

happyReduce_61 = happyReduce 5 25 happyReduction_61
happyReduction_61 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 (Imp happy_var_3
	) `HappyStk` happyRest

happyReduce_62 = happyReduce 5 25 happyReduction_62
happyReduction_62 (_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (LITERAL happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn25
		 (Imp (Lit happy_var_3)
	) `HappyStk` happyRest

happyReduce_63 = happyReduce 5 26 happyReduction_63
happyReduction_63 (_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (Leitura happy_var_3
	) `HappyStk` happyRest

happyReduce_64 = happySpecReduce_2  27 happyReduction_64
happyReduction_64 _
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn27
		 (case happy_var_1 of
                                    Chamada id args -> Proc id args
                                    _               -> error("Call incorrect")
	)
happyReduction_64 _ _  = notHappyAtAll 

happyReduce_65 = happyReduce 4 28 happyReduction_65
happyReduction_65 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (ID happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Chamada happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_66 = happySpecReduce_3  28 happyReduction_66
happyReduction_66 _
	_
	(HappyTerminal (ID happy_var_1))
	 =  HappyAbsSyn28
		 (Chamada happy_var_1 []
	)
happyReduction_66 _ _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_3  29 happyReduction_67
happyReduction_67 (HappyAbsSyn6  happy_var_3)
	_
	(HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn29
		 (happy_var_1 ++ [happy_var_3]
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_3  29 happyReduction_68
happyReduction_68 (HappyTerminal (LITERAL happy_var_3))
	_
	(HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn29
		 (happy_var_1 ++ [Lit happy_var_3]
	)
happyReduction_68 _ _ _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_1  29 happyReduction_69
happyReduction_69 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn29
		 ([happy_var_1]
	)
happyReduction_69 _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_1  29 happyReduction_70
happyReduction_70 (HappyTerminal (LITERAL happy_var_1))
	 =  HappyAbsSyn29
		 ([Lit happy_var_1]
	)
happyReduction_70 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 66 66 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	CINT happy_dollar_dollar -> cont 30;
	CDOUBLE happy_dollar_dollar -> cont 31;
	LITERAL happy_dollar_dollar -> cont 32;
	ADD -> cont 33;
	SUB -> cont 34;
	MUL -> cont 35;
	DIV -> cont 36;
	LPAR -> cont 37;
	RPAR -> cont 38;
	LBRACK -> cont 39;
	RBRACK -> cont 40;
	LCBRAK -> cont 41;
	RCBRAK -> cont 42;
	COMMA -> cont 43;
	SEMICOLON -> cont 44;
	MAJEQ -> cont 45;
	MINEQ -> cont 46;
	MINOR -> cont 47;
	MAJOR -> cont 48;
	EQUAL -> cont 49;
	NEQUAL -> cont 50;
	AND -> cont 51;
	OR -> cont 52;
	NOT -> cont 53;
	ID happy_dollar_dollar -> cont 54;
	TINT -> cont 55;
	TSTRING -> cont 56;
	TDOUBLE -> cont 57;
	TVOID -> cont 58;
	TRETURN -> cont 59;
	TREAD -> cont 60;
	ATRIB -> cont 61;
	TPRINT -> cont 62;
	TWHILE -> cont 63;
	TIF -> cont 64;
	TELSE -> cont 65;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 66 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Tokens)], [String]) -> HappyIdentity a
happyError' = HappyIdentity . (\(tokens, _) -> parseError tokens)
calc tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn7 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Tokens] -> a
parseError s = error ("Parse error:" ++ show s)

funcaoDeFundef :: FuncD -> Funcao
funcaoDeFundef (FunDef f c) = f

defDeFundef :: FuncD -> (Id, [Var], Bloco)
defDeFundef (FunDef (i:->:(v,t)) (BlocoP d c)) = (i,v++d,c)

main = do putStr "Digite o nome do arquivo que deseja ler"
          arquivo <- getLine
          s <- readFile arquivo
          print (calc (L.alexScanTokens s))
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
