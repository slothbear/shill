{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

Code template generated with SynGen.
The original code is: lsl.pas, released 2006-05-06.
Description: Syntax Parser/Highlighter
The initial author of this file is Nightwalker.
Copyright (c) 2006, all rights reserved.

Contributors to the SynEdit and mwEdit projects are listed in the
Contributors.txt file.

Alternatively, the contents of this file may be used under the terms of the
GNU General Public License Version 2 or later (the "GPL"), in which case
the provisions of the GPL are applicable instead of those above.
If you wish to allow use of your version of this file only under the terms
of the GPL and not to allow others to use your version of this file
under the MPL, indicate your decision by deleting the provisions above and
replace them with the notice and other provisions required by the GPL.
If you do not delete the provisions above, a recipient may use your version
of this file under either the MPL or the GPL.

$Id: $

You may retrieve the latest version of this file at the SynEdit home page,
located at http://SynEdit.SourceForge.net

-------------------------------------------------------------------------------}

unit SynHighlighterLSL;

{$I SynEdit.inc}

interface

uses
{$IFDEF SYN_CLX}
  QGraphics,
  QSynEditTypes,
  QSynEditHighlighter,
{$ELSE}
  Graphics,
  SynEditTypes,
  SynEditHighlighter,
{$ENDIF}
  SysUtils,
  Classes;

type
  TtkTokenKind = (
    tkComment,
    tkIdentifier,
    tkKey,
    tkNull,
    tkSpace,
    tkString,
    tkFunctions,
    tkUnknown);

  TRangeState = (rsUnKnown, rsComment, rsString, rsFunction);

  TProcTableProc = procedure of object;

  PIdentFuncTableFunc = ^TIdentFuncTableFunc;
  TIdentFuncTableFunc = function: TtkTokenKind of object;

const
  MaxKey = 455;

type
  TSynHighlighterLSL = class(TSynCustomHighlighter)
  private
    fLineRef: string;
    fLine: PChar;
    fLineNumber: Integer;
    fProcTable: array[#0..#255] of TProcTableProc;
    fRange: TRangeState;
    Run: LongInt;
    fStringLen: Integer;
    fToIdent: PChar;
    fTokenPos: Integer;
    fTokenID: TtkTokenKind;
    fIdentFuncTable: array[0 .. MaxKey] of TIdentFuncTableFunc;
    fCommentAttri: TSynHighlighterAttributes;
    fIdentifierAttri: TSynHighlighterAttributes;
    fKeyAttri: TSynHighlighterAttributes;
    fFunctionAttri: TSynHighlighterAttributes;
    fSpaceAttri: TSynHighlighterAttributes;
    fStringAttri: TSynHighlighterAttributes;
    function KeyHash(ToHash: PChar): Integer;
    function KeyComp(const aKey: string): Boolean;
    function Func17: TtkTokenKind;
    function Func21: TtkTokenKind;
    function Func40: TtkTokenKind;
    function Func42: TtkTokenKind;
    function Func43: TtkTokenKind;
    function Func44: TtkTokenKind;
    function Func45: TtkTokenKind;
    function Func46: TtkTokenKind;
    function Func47: TtkTokenKind;
    function Func49: TtkTokenKind;
    function Func50: TtkTokenKind;
    function Func57: TtkTokenKind;
    function Func58: TtkTokenKind;
    function Func59: TtkTokenKind;
    function Func60: TtkTokenKind;
    function Func62: TtkTokenKind;
    function Func63: TtkTokenKind;
    function Func64: TtkTokenKind;
    function Func65: TtkTokenKind;
    function Func66: TtkTokenKind;
    function Func67: TtkTokenKind;
    function Func70: TtkTokenKind;
    function Func71: TtkTokenKind;
    function Func72: TtkTokenKind;
    function Func73: TtkTokenKind;
    function Func74: TtkTokenKind;
    function Func75: TtkTokenKind;
    function Func76: TtkTokenKind;
    function Func77: TtkTokenKind;
    function Func79: TtkTokenKind;
    function Func81: TtkTokenKind;
    function Func82: TtkTokenKind;
    function Func83: TtkTokenKind;
    function Func85: TtkTokenKind;
    function Func87: TtkTokenKind;
    function Func88: TtkTokenKind;
    function Func89: TtkTokenKind;
    function Func90: TtkTokenKind;
    function Func91: TtkTokenKind;
    function Func92: TtkTokenKind;
    function Func93: TtkTokenKind;
    function Func94: TtkTokenKind;
    function Func95: TtkTokenKind;
    function Func96: TtkTokenKind;
    function Func97: TtkTokenKind;
    function Func98: TtkTokenKind;
    function Func100: TtkTokenKind;
    function Func101: TtkTokenKind;
    function Func102: TtkTokenKind;
    function Func103: TtkTokenKind;
    function Func104: TtkTokenKind;
    function Func105: TtkTokenKind;
    function Func106: TtkTokenKind;
    function Func107: TtkTokenKind;
    function Func108: TtkTokenKind;
    function Func109: TtkTokenKind;
    function Func110: TtkTokenKind;
    function Func111: TtkTokenKind;
    function Func112: TtkTokenKind;
    function Func113: TtkTokenKind;
    function Func114: TtkTokenKind;
    function Func115: TtkTokenKind;
    function Func116: TtkTokenKind;
    function Func117: TtkTokenKind;
    function Func118: TtkTokenKind;
    function Func119: TtkTokenKind;
    function Func120: TtkTokenKind;
    function Func121: TtkTokenKind;
    function Func122: TtkTokenKind;
    function Func123: TtkTokenKind;
    function Func124: TtkTokenKind;
    function Func126: TtkTokenKind;
    function Func127: TtkTokenKind;
    function Func129: TtkTokenKind;
    function Func130: TtkTokenKind;
    function Func131: TtkTokenKind;
    function Func132: TtkTokenKind;
    function Func133: TtkTokenKind;
    function Func134: TtkTokenKind;
    function Func135: TtkTokenKind;
    function Func136: TtkTokenKind;
    function Func137: TtkTokenKind;
    function Func138: TtkTokenKind;
    function Func139: TtkTokenKind;
    function Func140: TtkTokenKind;
    function Func141: TtkTokenKind;
    function Func142: TtkTokenKind;
    function Func143: TtkTokenKind;
    function Func144: TtkTokenKind;
    function Func145: TtkTokenKind;
    function Func146: TtkTokenKind;
    function Func147: TtkTokenKind;
    function Func148: TtkTokenKind;
    function Func149: TtkTokenKind;
    function Func151: TtkTokenKind;
    function Func152: TtkTokenKind;
    function Func153: TtkTokenKind;
    function Func154: TtkTokenKind;
    function Func155: TtkTokenKind;
    function Func156: TtkTokenKind;
    function Func157: TtkTokenKind;
    function Func158: TtkTokenKind;
    function Func159: TtkTokenKind;
    function Func160: TtkTokenKind;
    function Func161: TtkTokenKind;
    function Func162: TtkTokenKind;
    function Func163: TtkTokenKind;
    function Func164: TtkTokenKind;
    function Func165: TtkTokenKind;
    function Func166: TtkTokenKind;
    function Func167: TtkTokenKind;
    function Func168: TtkTokenKind;
    function Func169: TtkTokenKind;
    function Func170: TtkTokenKind;
    function Func171: TtkTokenKind;
    function Func172: TtkTokenKind;
    function Func173: TtkTokenKind;
    function Func174: TtkTokenKind;
    function Func175: TtkTokenKind;
    function Func176: TtkTokenKind;
    function Func177: TtkTokenKind;
    function Func178: TtkTokenKind;
    function Func179: TtkTokenKind;
    function Func180: TtkTokenKind;
    function Func181: TtkTokenKind;
    function Func182: TtkTokenKind;
    function Func183: TtkTokenKind;
    function Func184: TtkTokenKind;
    function Func185: TtkTokenKind;
    function Func186: TtkTokenKind;
    function Func187: TtkTokenKind;
    function Func188: TtkTokenKind;
    function Func189: TtkTokenKind;
    function Func190: TtkTokenKind;
    function Func191: TtkTokenKind;
    function Func192: TtkTokenKind;
    function Func193: TtkTokenKind;
    function Func194: TtkTokenKind;
    function Func195: TtkTokenKind;
    function Func196: TtkTokenKind;
    function Func197: TtkTokenKind;
    function Func199: TtkTokenKind;
    function Func200: TtkTokenKind;
    function Func201: TtkTokenKind;
    function Func202: TtkTokenKind;
    function Func203: TtkTokenKind;
    function Func204: TtkTokenKind;
    function Func205: TtkTokenKind;
    function Func206: TtkTokenKind;
    function Func207: TtkTokenKind;
    function Func208: TtkTokenKind;
    function Func209: TtkTokenKind;
    function Func210: TtkTokenKind;
    function Func211: TtkTokenKind;
    function Func212: TtkTokenKind;
    function Func213: TtkTokenKind;
    function Func214: TtkTokenKind;
    function Func215: TtkTokenKind;
    function Func216: TtkTokenKind;
    function Func217: TtkTokenKind;
    function Func218: TtkTokenKind;
    function Func219: TtkTokenKind;
    function Func220: TtkTokenKind;
    function Func221: TtkTokenKind;
    function Func222: TtkTokenKind;
    function Func223: TtkTokenKind;
    function Func226: TtkTokenKind;
    function Func227: TtkTokenKind;
    function Func228: TtkTokenKind;
    function Func229: TtkTokenKind;
    function Func230: TtkTokenKind;
    function Func231: TtkTokenKind;
    function Func232: TtkTokenKind;
    function Func233: TtkTokenKind;
    function Func234: TtkTokenKind;
    function Func235: TtkTokenKind;
    function Func237: TtkTokenKind;
    function Func238: TtkTokenKind;
    function Func239: TtkTokenKind;
    function Func240: TtkTokenKind;
    function Func242: TtkTokenKind;
    function Func243: TtkTokenKind;
    function Func244: TtkTokenKind;
    function Func245: TtkTokenKind;
    function Func246: TtkTokenKind;
    function Func247: TtkTokenKind;
    function Func249: TtkTokenKind;
    function Func250: TtkTokenKind;
    function Func252: TtkTokenKind;
    function Func253: TtkTokenKind;
    function Func254: TtkTokenKind;
    function Func255: TtkTokenKind;
    function Func257: TtkTokenKind;
    function Func259: TtkTokenKind;
    function Func261: TtkTokenKind;
    function Func262: TtkTokenKind;
    function Func263: TtkTokenKind;
    function Func264: TtkTokenKind;
    function Func266: TtkTokenKind;
    function Func267: TtkTokenKind;
    function Func269: TtkTokenKind;
    function Func271: TtkTokenKind;
    function Func273: TtkTokenKind;
    function Func274: TtkTokenKind;
    function Func275: TtkTokenKind;
    function Func276: TtkTokenKind;
    function Func278: TtkTokenKind;
    function Func279: TtkTokenKind;
    function Func282: TtkTokenKind;
    function Func283: TtkTokenKind;
    function Func284: TtkTokenKind;
    function Func285: TtkTokenKind;
    function Func286: TtkTokenKind;
    function Func288: TtkTokenKind;
    function Func289: TtkTokenKind;
    function Func290: TtkTokenKind;
    function Func291: TtkTokenKind;
    function Func294: TtkTokenKind;
    function Func296: TtkTokenKind;
    function Func298: TtkTokenKind;
    function Func299: TtkTokenKind;
    function Func300: TtkTokenKind;
    function Func301: TtkTokenKind;
    function Func302: TtkTokenKind;
    function Func303: TtkTokenKind;
    function Func304: TtkTokenKind;
    function Func306: TtkTokenKind;
    function Func309: TtkTokenKind;
    function Func310: TtkTokenKind;
    function Func312: TtkTokenKind;
    function Func314: TtkTokenKind;
    function Func316: TtkTokenKind;
    function Func317: TtkTokenKind;
    function Func318: TtkTokenKind;
    function Func319: TtkTokenKind;
    function Func323: TtkTokenKind;
    function Func327: TtkTokenKind;
    function Func329: TtkTokenKind;
    function Func331: TtkTokenKind;
    function Func335: TtkTokenKind;
    function Func339: TtkTokenKind;
    function Func344: TtkTokenKind;
    function Func360: TtkTokenKind;
    function Func362: TtkTokenKind;
    function Func372: TtkTokenKind;
    function Func455: TtkTokenKind;
    procedure IdentProc;
    procedure UnknownProc;
    function AltFunc: TtkTokenKind;
    procedure InitIdent;
    function IdentKind(MayBe: PChar): TtkTokenKind;
    procedure MakeMethodTables;
    procedure AnsiCProc;
    procedure NullProc;
    procedure SpaceProc;
    procedure CRProc;
    procedure LFProc;
    procedure SlashProc;    
    procedure StringOpenProc;
    procedure StringProc;
    procedure Proc;
  protected
    function GetIdentChars: TSynIdentChars; override;
    function GetSampleSource: string; override;
    function IsFilterStored: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    {$IFNDEF SYN_CPPB_1} class {$ENDIF}
    function GetLanguageName: string; override;
    function GetRange: Pointer; override;
    procedure ResetRange; override;
    procedure SetRange(Value: Pointer); override;
    function GetDefaultAttribute(Index: integer): TSynHighlighterAttributes; override;
    function GetEol: Boolean; override;
    function GetKeyWords: string;
    function GetTokenID: TtkTokenKind;
    procedure SetLine(NewValue: String; LineNumber: Integer); override;
    function GetToken: String; override;
    function GetTokenAttribute: TSynHighlighterAttributes; override;
    function GetTokenKind: integer; override;
    function GetTokenPos: Integer; override;
    procedure Next; override;

  published
    property CommentAttri: TSynHighlighterAttributes read fCommentAttri write fCommentAttri;
    property IdentifierAttri: TSynHighlighterAttributes read fIdentifierAttri write fIdentifierAttri;
    property KeyAttri: TSynHighlighterAttributes read fKeyAttri write fKeyAttri;
    property FunctionAttri: TSynHighlighterAttributes read fFunctionAttri write fFunctionAttri;
    property SpaceAttri: TSynHighlighterAttributes read fSpaceAttri write fSpaceAttri;
    property StringAttri: TSynHighlighterAttributes read fStringAttri write fStringAttri;
  end;

implementation

uses
{$IFDEF SYN_CLX}
  QSynEditStrConst;
{$ELSE}
  SynEditStrConst;
{$ENDIF}

{$IFDEF SYN_COMPILER_3_UP}
resourcestring
{$ELSE}
const
{$ENDIF}
  SYNS_FilterLindenScriptingLanguage = 'Linden Script (*.lsl)|*.lsl';
  SYNS_LangLindenScriptingLanguage = 'Linden Scripting Language';

var
  Identifiers: array[#0..#255] of ByteBool;
  mHashTable : array[#0..#255] of Integer;

procedure MakeIdentTable;
var
  I: Char;
begin
  for I := #0 to #255 do
  begin
    case I of
      '_', 'a'..'z', 'A'..'Z': Identifiers[I] := True;
    else
      Identifiers[I] := False;
    end;
    case I in ['_', 'A'..'Z', 'a'..'z'] of
      True:
        begin
          if (I > #64) and (I < #91) then
            mHashTable[I] := Ord(I) - 64
          else if (I > #96) then
            mHashTable[I] := Ord(I) - 95;
        end;
    else
      mHashTable[I] := 0;
    end;
  end;
end;

procedure TSynHighlighterLSL.InitIdent;
var
  I: Integer;
  pF: PIdentFuncTableFunc;
begin
  pF := PIdentFuncTableFunc(@fIdentFuncTable);
  for I := Low(fIdentFuncTable) to High(fIdentFuncTable) do
  begin
    pF^ := AltFunc;
    Inc(pF);
  end;
  fIdentFuncTable[17] := Func17;
  fIdentFuncTable[21] := Func21;
  fIdentFuncTable[40] := Func40;
  fIdentFuncTable[42] := Func42;
  fIdentFuncTable[43] := Func43;
  fIdentFuncTable[44] := Func44;
  fIdentFuncTable[45] := Func45;
  fIdentFuncTable[46] := Func46;
  fIdentFuncTable[47] := Func47;
  fIdentFuncTable[49] := Func49;
  fIdentFuncTable[50] := Func50;
  fIdentFuncTable[57] := Func57;
  fIdentFuncTable[58] := Func58;
  fIdentFuncTable[59] := Func59;
  fIdentFuncTable[60] := Func60;
  fIdentFuncTable[62] := Func62;
  fIdentFuncTable[63] := Func63;
  fIdentFuncTable[64] := Func64;
  fIdentFuncTable[65] := Func65;
  fIdentFuncTable[66] := Func66;
  fIdentFuncTable[67] := Func67;
  fIdentFuncTable[70] := Func70;
  fIdentFuncTable[71] := Func71;
  fIdentFuncTable[72] := Func72;
  fIdentFuncTable[73] := Func73;
  fIdentFuncTable[74] := Func74;
  fIdentFuncTable[75] := Func75;
  fIdentFuncTable[76] := Func76;
  fIdentFuncTable[77] := Func77;
  fIdentFuncTable[79] := Func79;
  fIdentFuncTable[81] := Func81;
  fIdentFuncTable[82] := Func82;
  fIdentFuncTable[83] := Func83;
  fIdentFuncTable[85] := Func85;
  fIdentFuncTable[87] := Func87;
  fIdentFuncTable[88] := Func88;
  fIdentFuncTable[89] := Func89;
  fIdentFuncTable[90] := Func90;
  fIdentFuncTable[91] := Func91;
  fIdentFuncTable[92] := Func92;
  fIdentFuncTable[93] := Func93;
  fIdentFuncTable[94] := Func94;
  fIdentFuncTable[95] := Func95;
  fIdentFuncTable[96] := Func96;
  fIdentFuncTable[97] := Func97;
  fIdentFuncTable[98] := Func98;
  fIdentFuncTable[100] := Func100;
  fIdentFuncTable[101] := Func101;
  fIdentFuncTable[102] := Func102;
  fIdentFuncTable[103] := Func103;
  fIdentFuncTable[104] := Func104;
  fIdentFuncTable[105] := Func105;
  fIdentFuncTable[106] := Func106;
  fIdentFuncTable[107] := Func107;
  fIdentFuncTable[108] := Func108;
  fIdentFuncTable[109] := Func109;
  fIdentFuncTable[110] := Func110;
  fIdentFuncTable[111] := Func111;
  fIdentFuncTable[112] := Func112;
  fIdentFuncTable[113] := Func113;
  fIdentFuncTable[114] := Func114;
  fIdentFuncTable[115] := Func115;
  fIdentFuncTable[116] := Func116;
  fIdentFuncTable[117] := Func117;
  fIdentFuncTable[118] := Func118;
  fIdentFuncTable[119] := Func119;
  fIdentFuncTable[120] := Func120;
  fIdentFuncTable[121] := Func121;
  fIdentFuncTable[122] := Func122;
  fIdentFuncTable[123] := Func123;
  fIdentFuncTable[124] := Func124;
  fIdentFuncTable[126] := Func126;
  fIdentFuncTable[127] := Func127;
  fIdentFuncTable[129] := Func129;
  fIdentFuncTable[130] := Func130;
  fIdentFuncTable[131] := Func131;
  fIdentFuncTable[132] := Func132;
  fIdentFuncTable[133] := Func133;
  fIdentFuncTable[134] := Func134;
  fIdentFuncTable[135] := Func135;
  fIdentFuncTable[136] := Func136;
  fIdentFuncTable[137] := Func137;
  fIdentFuncTable[138] := Func138;
  fIdentFuncTable[139] := Func139;
  fIdentFuncTable[140] := Func140;
  fIdentFuncTable[141] := Func141;
  fIdentFuncTable[142] := Func142;
  fIdentFuncTable[143] := Func143;
  fIdentFuncTable[144] := Func144;
  fIdentFuncTable[145] := Func145;
  fIdentFuncTable[146] := Func146;
  fIdentFuncTable[147] := Func147;
  fIdentFuncTable[148] := Func148;
  fIdentFuncTable[149] := Func149;
  fIdentFuncTable[151] := Func151;
  fIdentFuncTable[152] := Func152;
  fIdentFuncTable[153] := Func153;
  fIdentFuncTable[154] := Func154;
  fIdentFuncTable[155] := Func155;
  fIdentFuncTable[156] := Func156;
  fIdentFuncTable[157] := Func157;
  fIdentFuncTable[158] := Func158;
  fIdentFuncTable[159] := Func159;
  fIdentFuncTable[160] := Func160;
  fIdentFuncTable[161] := Func161;
  fIdentFuncTable[162] := Func162;
  fIdentFuncTable[163] := Func163;
  fIdentFuncTable[164] := Func164;
  fIdentFuncTable[165] := Func165;
  fIdentFuncTable[166] := Func166;
  fIdentFuncTable[167] := Func167;
  fIdentFuncTable[168] := Func168;
  fIdentFuncTable[169] := Func169;
  fIdentFuncTable[170] := Func170;
  fIdentFuncTable[171] := Func171;
  fIdentFuncTable[172] := Func172;
  fIdentFuncTable[173] := Func173;
  fIdentFuncTable[174] := Func174;
  fIdentFuncTable[175] := Func175;
  fIdentFuncTable[176] := Func176;
  fIdentFuncTable[177] := Func177;
  fIdentFuncTable[178] := Func178;
  fIdentFuncTable[179] := Func179;
  fIdentFuncTable[180] := Func180;
  fIdentFuncTable[181] := Func181;
  fIdentFuncTable[182] := Func182;
  fIdentFuncTable[183] := Func183;
  fIdentFuncTable[184] := Func184;
  fIdentFuncTable[185] := Func185;
  fIdentFuncTable[186] := Func186;
  fIdentFuncTable[187] := Func187;
  fIdentFuncTable[188] := Func188;
  fIdentFuncTable[189] := Func189;
  fIdentFuncTable[190] := Func190;
  fIdentFuncTable[191] := Func191;
  fIdentFuncTable[192] := Func192;
  fIdentFuncTable[193] := Func193;
  fIdentFuncTable[194] := Func194;
  fIdentFuncTable[195] := Func195;
  fIdentFuncTable[196] := Func196;
  fIdentFuncTable[197] := Func197;
  fIdentFuncTable[199] := Func199;
  fIdentFuncTable[200] := Func200;
  fIdentFuncTable[201] := Func201;
  fIdentFuncTable[202] := Func202;
  fIdentFuncTable[203] := Func203;
  fIdentFuncTable[204] := Func204;
  fIdentFuncTable[205] := Func205;
  fIdentFuncTable[206] := Func206;
  fIdentFuncTable[207] := Func207;
  fIdentFuncTable[208] := Func208;
  fIdentFuncTable[209] := Func209;
  fIdentFuncTable[210] := Func210;
  fIdentFuncTable[211] := Func211;
  fIdentFuncTable[212] := Func212;
  fIdentFuncTable[213] := Func213;
  fIdentFuncTable[214] := Func214;
  fIdentFuncTable[215] := Func215;
  fIdentFuncTable[216] := Func216;
  fIdentFuncTable[217] := Func217;
  fIdentFuncTable[218] := Func218;
  fIdentFuncTable[219] := Func219;
  fIdentFuncTable[220] := Func220;
  fIdentFuncTable[221] := Func221;
  fIdentFuncTable[222] := Func222;
  fIdentFuncTable[223] := Func223;
  fIdentFuncTable[226] := Func226;
  fIdentFuncTable[227] := Func227;
  fIdentFuncTable[228] := Func228;
  fIdentFuncTable[229] := Func229;
  fIdentFuncTable[230] := Func230;
  fIdentFuncTable[231] := Func231;
  fIdentFuncTable[232] := Func232;
  fIdentFuncTable[233] := Func233;
  fIdentFuncTable[234] := Func234;
  fIdentFuncTable[235] := Func235;
  fIdentFuncTable[237] := Func237;
  fIdentFuncTable[238] := Func238;
  fIdentFuncTable[239] := Func239;
  fIdentFuncTable[240] := Func240;
  fIdentFuncTable[242] := Func242;
  fIdentFuncTable[243] := Func243;
  fIdentFuncTable[244] := Func244;
  fIdentFuncTable[245] := Func245;
  fIdentFuncTable[246] := Func246;
  fIdentFuncTable[247] := Func247;
  fIdentFuncTable[249] := Func249;
  fIdentFuncTable[250] := Func250;
  fIdentFuncTable[252] := Func252;
  fIdentFuncTable[253] := Func253;
  fIdentFuncTable[254] := Func254;
  fIdentFuncTable[255] := Func255;
  fIdentFuncTable[257] := Func257;
  fIdentFuncTable[259] := Func259;
  fIdentFuncTable[261] := Func261;
  fIdentFuncTable[262] := Func262;
  fIdentFuncTable[263] := Func263;
  fIdentFuncTable[264] := Func264;
  fIdentFuncTable[266] := Func266;
  fIdentFuncTable[267] := Func267;
  fIdentFuncTable[269] := Func269;
  fIdentFuncTable[271] := Func271;
  fIdentFuncTable[273] := Func273;
  fIdentFuncTable[274] := Func274;
  fIdentFuncTable[275] := Func275;
  fIdentFuncTable[276] := Func276;
  fIdentFuncTable[278] := Func278;
  fIdentFuncTable[279] := Func279;
  fIdentFuncTable[282] := Func282;
  fIdentFuncTable[283] := Func283;
  fIdentFuncTable[284] := Func284;
  fIdentFuncTable[285] := Func285;
  fIdentFuncTable[286] := Func286;
  fIdentFuncTable[288] := Func288;
  fIdentFuncTable[289] := Func289;
  fIdentFuncTable[290] := Func290;
  fIdentFuncTable[291] := Func291;
  fIdentFuncTable[294] := Func294;
  fIdentFuncTable[296] := Func296;
  fIdentFuncTable[298] := Func298;
  fIdentFuncTable[299] := Func299;
  fIdentFuncTable[300] := Func300;
  fIdentFuncTable[301] := Func301;
  fIdentFuncTable[302] := Func302;
  fIdentFuncTable[303] := Func303;
  fIdentFuncTable[304] := Func304;
  fIdentFuncTable[306] := Func306;
  fIdentFuncTable[309] := Func309;
  fIdentFuncTable[310] := Func310;
  fIdentFuncTable[312] := Func312;
  fIdentFuncTable[314] := Func314;
  fIdentFuncTable[316] := Func316;
  fIdentFuncTable[317] := Func317;
  fIdentFuncTable[318] := Func318;
  fIdentFuncTable[319] := Func319;
  fIdentFuncTable[323] := Func323;
  fIdentFuncTable[327] := Func327;
  fIdentFuncTable[329] := Func329;
  fIdentFuncTable[331] := Func331;
  fIdentFuncTable[335] := Func335;
  fIdentFuncTable[339] := Func339;
  fIdentFuncTable[344] := Func344;
  fIdentFuncTable[360] := Func360;
  fIdentFuncTable[362] := Func362;
  fIdentFuncTable[372] := Func372;
  fIdentFuncTable[455] := Func455;
end;

function TSynHighlighterLSL.KeyHash(ToHash: PChar): Integer;
begin
  Result := 0;
  while ToHash^ in ['_', 'a'..'z', 'A'..'Z'] do
  begin
    inc(Result, mHashTable[ToHash^]);
    inc(ToHash);
  end;
  fStringLen := ToHash - fToIdent;
end;

function TSynHighlighterLSL.KeyComp(const aKey: String): Boolean;
var
  I: Integer;
  Temp: PChar;
begin
  Temp := fToIdent;
  if Length(aKey) = fStringLen then
  begin
    Result := True;
    for i := 1 to fStringLen do
    begin
      if Temp^ <> aKey[i] then
      begin
        Result := False;
        break;
      end;
      inc(Temp);
    end;
  end else Result := False;
end;

function TSynHighlighterLSL.Func17: TtkTokenKind;
begin
  if KeyComp('if') then Result := tkKey else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func21: TtkTokenKind;
begin
  if KeyComp('do') then Result := tkKey else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func40: TtkTokenKind;
begin
  if KeyComp('SCALE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func42: TtkTokenKind;
begin
  if KeyComp('for') then Result := tkKey else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func43: TtkTokenKind;
begin
  if KeyComp('FALSE') then Result := tkKey else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func44: TtkTokenKind;
begin
  if KeyComp('key') then Result := tkKey else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func45: TtkTokenKind;
begin
  if KeyComp('email') then Result := tkFunctions else
    if KeyComp('else') then Result := tkKey else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func46: TtkTokenKind;
begin
  if KeyComp('llDie') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func47: TtkTokenKind;
begin
  if KeyComp('AGENT') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func49: TtkTokenKind;
begin
  if KeyComp('changed') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func50: TtkTokenKind;
begin
  if KeyComp('llAbs') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func57: TtkTokenKind;
begin
  if KeyComp('llFabs') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func58: TtkTokenKind;
begin
  if KeyComp('llCeil') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func59: TtkTokenKind;
begin
  if KeyComp('attach') then Result := tkFunctions else
    if KeyComp('float') then Result := tkKey else
      if KeyComp('DATA_NAME') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func60: TtkTokenKind;
begin
  if KeyComp('ACTIVE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func62: TtkTokenKind;
begin
  if KeyComp('while') then Result := tkKey else
    if KeyComp('llLog10') then Result := tkFunctions else
      if KeyComp('llLog') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func63: TtkTokenKind;
begin
  if KeyComp('llTan') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func64: TtkTokenKind;
begin
  if KeyComp('list') then Result := tkKey else
    if KeyComp('jump') then Result := tkKey else
      if KeyComp('TRUE') then Result := tkKey else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func65: TtkTokenKind;
begin
  if KeyComp('llCos') then Result := tkFunctions else
    if KeyComp('llAtan2') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func66: TtkTokenKind;
begin
  if KeyComp('ANIM_ON') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func67: TtkTokenKind;
begin
  if KeyComp('llAcos') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func70: TtkTokenKind;
begin
  if KeyComp('state') then Result := tkKey else
    if KeyComp('llEmail') then Result := tkFunctions else
      if KeyComp('llSin') then Result := tkFunctions else
        if KeyComp('timer') then Result := tkFunctions else
          if KeyComp('ATTACH_BACK') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func71: TtkTokenKind;
begin
  if KeyComp('ATTACH_HEAD') then Result := tkFunctions else
    if KeyComp('MASK_BASE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func72: TtkTokenKind;
begin
  if KeyComp('touch') then Result := tkFunctions else
    if KeyComp('llAsin') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func73: TtkTokenKind;
begin
  if KeyComp('llSay') then Result := tkFunctions else
    if KeyComp('llFrand') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func74: TtkTokenKind;
begin
  if KeyComp('RAD_TO_DEG') then Result := tkFunctions else
    if KeyComp('DEG_TO_RAD') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func75: TtkTokenKind;
begin
  if KeyComp('DATA_BORN') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func76: TtkTokenKind;
begin
  if KeyComp('default') then Result := tkKey else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func77: TtkTokenKind;
begin
  if KeyComp('PERM_ALL') then Result := tkFunctions else
    if KeyComp('money') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func79: TtkTokenKind;
begin
  if KeyComp('llDialog') then Result := tkFunctions else
    if KeyComp('ROTATE') then Result := tkFunctions else
      if KeyComp('llWind') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func81: TtkTokenKind;
begin
  if KeyComp('ALL_SIDES') then Result := tkFunctions else
    if KeyComp('llVecMag') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func82: TtkTokenKind;
begin
  if KeyComp('llPow') then Result := tkFunctions else
    if KeyComp('CHANGED_SCALE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func83: TtkTokenKind;
begin
  if KeyComp('LAND_RAISE') then Result := tkFunctions else
    if KeyComp('TWO_PI') then Result := tkFunctions else
      if KeyComp('on_rez') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func85: TtkTokenKind;
begin
  if KeyComp('llCloud') then Result := tkFunctions else
    if KeyComp('listen') then Result := tkFunctions else
      if KeyComp('integer') then Result := tkKey else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func87: TtkTokenKind;
begin
  if KeyComp('ATTACH_CHIN') then Result := tkFunctions else
    if KeyComp('LAND_LEVEL') then Result := tkFunctions else
      if KeyComp('llSleep') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func88: TtkTokenKind;
begin
  if KeyComp('llGetAccel') then Result := tkFunctions else
    if KeyComp('CHANGED_LINK') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func89: TtkTokenKind;
begin
  if KeyComp('ATTACH_LPEC') then Result := tkFunctions else
    if KeyComp('vector') then Result := tkKey else
      if KeyComp('ATTACH_LEAR') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func90: TtkTokenKind;
begin
  if KeyComp('SMOOTH') then Result := tkFunctions else
    if KeyComp('LINK_SET') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func91: TtkTokenKind;
begin
  if KeyComp('CHANGED_SHAPE') then Result := tkFunctions else
    if KeyComp('PASSIVE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func92: TtkTokenKind;
begin
  if KeyComp('ATTACH_LHAND') then Result := tkFunctions else
    if KeyComp('REVERSE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func93: TtkTokenKind;
begin
  if KeyComp('llGetDate') then Result := tkFunctions else
    if KeyComp('LAND_NOISE') then Result := tkFunctions else
      if KeyComp('string') then Result := tkKey else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func94: TtkTokenKind;
begin
  if KeyComp('SCRIPTED') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func95: TtkTokenKind;
begin
  if KeyComp('ATTACH_RPEC') then Result := tkFunctions else
    if KeyComp('ATTACH_REAR') then Result := tkFunctions else
      if KeyComp('DATA_RATING') then Result := tkFunctions else
        if KeyComp('DATA_ONLINE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func96: TtkTokenKind;
begin
  if KeyComp('sensor') then Result := tkFunctions else
    if KeyComp('llFloor') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func97: TtkTokenKind;
begin
  if KeyComp('AGENT_AWAY') then Result := tkFunctions else
    if KeyComp('llWater') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func98: TtkTokenKind;
begin
  if KeyComp('touch_end') then Result := tkFunctions else
    if KeyComp('PING_PONG') then Result := tkFunctions else
      if KeyComp('ATTACH_RHAND') then Result := tkFunctions else
        if KeyComp('AGENT_IN_AIR') then Result := tkFunctions else
          if KeyComp('ATTACH_LHIP') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func100: TtkTokenKind;
begin
  if KeyComp('at_target') then Result := tkFunctions else
    if KeyComp('llMakeFire') then Result := tkFunctions else
      if KeyComp('NULL_KEY') then Result := tkFunctions else
        if KeyComp('ATTACH_LEYE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func101: TtkTokenKind;
begin
  if KeyComp('llGetVel') then Result := tkFunctions else
    if KeyComp('ATTACH_LLLEG') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func102: TtkTokenKind;
begin
  if KeyComp('llRound') then Result := tkFunctions else
    if KeyComp('llTarget') then Result := tkFunctions else
      if KeyComp('LINK_THIS') then Result := tkFunctions else
        if KeyComp('llGetAlpha') then Result := tkFunctions else
          if KeyComp('return') then Result := tkKey else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func103: TtkTokenKind;
begin
  if KeyComp('llGetKey') then Result := tkFunctions else
    if KeyComp('llSqrt') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func104: TtkTokenKind;
begin
  if KeyComp('control') then Result := tkFunctions else
    if KeyComp('ATTACH_RHIP') then Result := tkFunctions else
      if KeyComp('llGetScale') then Result := tkFunctions else
        if KeyComp('llLookAt') then Result := tkFunctions else
          if KeyComp('LAND_LOWER') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func105: TtkTokenKind;
begin
  if KeyComp('llGetOmega') then Result := tkFunctions else
    if KeyComp('llKey2Name') then Result := tkFunctions else
      if KeyComp('CHANGED_COLOR') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func106: TtkTokenKind;
begin
  if KeyComp('ATTACH_NOSE') then Result := tkFunctions else
    if KeyComp('ATTACH_REYE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func107: TtkTokenKind;
begin
  if KeyComp('TYPE_KEY') then Result := tkFunctions else
    if KeyComp('PERM_MOVE') then Result := tkFunctions else
      if KeyComp('ATTACH_RLLEG') then Result := tkFunctions else
        if KeyComp('TRUEFALSE') then Result := tkFunctions else
          if KeyComp('MASK_NEXT') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func108: TtkTokenKind;
begin
  if KeyComp('ATTACH_CHEST') then Result := tkFunctions else
    if KeyComp('llSetDamage') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func109: TtkTokenKind;
begin
  if KeyComp('ATTACH_BELLY') then Result := tkFunctions else
    if KeyComp('ATTACH_LLARM') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func110: TtkTokenKind;
begin
  if KeyComp('llGround') then Result := tkFunctions else
    if KeyComp('PI_BY_TWO') then Result := tkFunctions else
      if KeyComp('llGetTime') then Result := tkFunctions else
        if KeyComp('llListen') then Result := tkFunctions else
          if KeyComp('ATTACH_LULEG') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func111: TtkTokenKind;
begin
  if KeyComp('PERM_COPY') then Result := tkFunctions else
    if KeyComp('llGetForce') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func112: TtkTokenKind;
begin
  if KeyComp('moving_end') then Result := tkFunctions else
    if KeyComp('remote_data') then Result := tkFunctions else
      if KeyComp('llLoadURL') then Result := tkFunctions else
        if KeyComp('llGetPos') then Result := tkFunctions else
          if KeyComp('llUnSit') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func113: TtkTokenKind;
begin
  if KeyComp('llShout') then Result := tkFunctions else
    if KeyComp('llVecDist') then Result := tkFunctions else
      if KeyComp('object_rez') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func114: TtkTokenKind;
begin
  if KeyComp('LINK_ROOT') then Result := tkFunctions else
    if KeyComp('CONTROL_BACK') then Result := tkFunctions else
      if KeyComp('llSetAlpha') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func115: TtkTokenKind;
begin
  if KeyComp('llGetMass') then Result := tkFunctions else
    if KeyComp('PRIM_SIZE') then Result := tkFunctions else
      if KeyComp('ATTACH_RLARM') then Result := tkFunctions else
        if KeyComp('llGetRot') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func116: TtkTokenKind;
begin
  if KeyComp('llRot2Fwd') then Result := tkFunctions else
    if KeyComp('ATTACH_RULEG') then Result := tkFunctions else
      if KeyComp('llSetScale') then Result := tkFunctions else
        if KeyComp('llBreakLink') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func117: TtkTokenKind;
begin
  if KeyComp('collision') then Result := tkFunctions else
    if KeyComp('DATA_SIM_POS') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func118: TtkTokenKind;
begin
  if KeyComp('ATTACH_LUARM') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func119: TtkTokenKind;
begin
  if KeyComp('LAND_REVERT') then Result := tkFunctions else
    if KeyComp('PRIM_COLOR') then Result := tkFunctions else
      if KeyComp('MASK_OWNER') then Result := tkFunctions else
        if KeyComp('llRot2Up') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func120: TtkTokenKind;
begin
  if KeyComp('TYPE_FLOAT') then Result := tkFunctions else
    if KeyComp('rotation') then Result := tkKey else
      if KeyComp('AGENT_FLYING') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func121: TtkTokenKind;
begin
  if KeyComp('llSensor') then Result := tkFunctions else
    if KeyComp('MASK_GROUP') then Result := tkFunctions else
      if KeyComp('LAND_SMOOTH') then Result := tkFunctions else
        if KeyComp('llVecNorm') then Result := tkFunctions else
          if KeyComp('ATTACH_LFOOT') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func122: TtkTokenKind;
begin
  if KeyComp('PRIM_TYPE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func123: TtkTokenKind;
begin
  if KeyComp('dataserver') then Result := tkFunctions else
    if KeyComp('llSetForce') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func124: TtkTokenKind;
begin
  if KeyComp('ATTACH_RUARM') then Result := tkFunctions else
    if KeyComp('llRot2Angle') then Result := tkFunctions else
      if KeyComp('PERM_MODIFY') then Result := tkFunctions else
        if KeyComp('AGENT_WALKING') then Result := tkFunctions else
          if KeyComp('llSetPos') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func126: TtkTokenKind;
begin
  if KeyComp('llMakeSmoke') then Result := tkFunctions else
    if KeyComp('link_message') then Result := tkFunctions else
      if KeyComp('llPointAt') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func127: TtkTokenKind;
begin
  if KeyComp('llGetColor') then Result := tkFunctions else
    if KeyComp('llRot2Left') then Result := tkFunctions else
      if KeyComp('no_sensor') then Result := tkFunctions else
        if KeyComp('llSetRot') then Result := tkFunctions else
          if KeyComp('ATTACH_RFOOT') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func129: TtkTokenKind;
begin
  if KeyComp('llGetAttached') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func130: TtkTokenKind;
begin
  if KeyComp('llDetectedGrab') then Result := tkFunctions else
    if KeyComp('CONTROL_FWD') then Result := tkFunctions else
      if KeyComp('llWhisper') then Result := tkFunctions else
        if KeyComp('ATTACH_MOUTH') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func131: TtkTokenKind;
begin
  if KeyComp('AGENT_ON_OBJECT') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func132: TtkTokenKind;
begin
  if KeyComp('state_exit') then Result := tkFunctions else
    if KeyComp('llList2Key') then Result := tkFunctions else
      if KeyComp('llCreateLink') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func133: TtkTokenKind;
begin
  if KeyComp('llList2CSV') then Result := tkFunctions else
    if KeyComp('llCSV2List') then Result := tkFunctions else
      if KeyComp('llAxes2Rot') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func134: TtkTokenKind;
begin
  if KeyComp('CONTROL_UP') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func135: TtkTokenKind;
begin
  if KeyComp('PRIM_MATERIAL') then Result := tkFunctions else
    if KeyComp('llDetectedName') then Result := tkFunctions else
      if KeyComp('llMD5String') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func136: TtkTokenKind;
begin
  if KeyComp('ATTACH_PELVIS') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func137: TtkTokenKind;
begin
  if KeyComp('TYPE_INVALID') then Result := tkFunctions else
    if KeyComp('llRezObject') then Result := tkFunctions else
      if KeyComp('llRot2Axis') then Result := tkFunctions else
        if KeyComp('llModifyLand') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func138: TtkTokenKind;
begin
  if KeyComp('AGENT_TYPING') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func139: TtkTokenKind;
begin
  if KeyComp('llSetColor') then Result := tkFunctions else
    if KeyComp('llGetEnergy') then Result := tkFunctions else
      if KeyComp('llGetOwner') then Result := tkFunctions else
        if KeyComp('llToLower') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func140: TtkTokenKind;
begin
  if KeyComp('llDetectedVel') then Result := tkFunctions else
    if KeyComp('CONTROL_LEFT') then Result := tkFunctions else
      if KeyComp('PRIM_BUMP_BARK') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func141: TtkTokenKind;
begin
  if KeyComp('AGENT_SCRIPTED') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func142: TtkTokenKind;
begin
  if KeyComp('PRIM_BUMP_DARK') then Result := tkFunctions else
    if KeyComp('LAND_LARGE_BRUSH') then Result := tkFunctions else
      if KeyComp('llDetectedKey') then Result := tkFunctions else
        if KeyComp('llToUpper') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func143: TtkTokenKind;
begin
  if KeyComp('PRIM_PHANTOM') then Result := tkFunctions else
    if KeyComp('collision_end') then Result := tkFunctions else
      if KeyComp('PSYS_SRC_ACCEL') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func144: TtkTokenKind;
begin
  if KeyComp('llSetText') then Result := tkFunctions else
    if KeyComp('TYPE_INTEGER') then Result := tkFunctions else
      if KeyComp('llList2Rot') then Result := tkFunctions else
        if KeyComp('LINK_ALL_CHILDREN') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func145: TtkTokenKind;
begin
  if KeyComp('llGetLinkName') then Result := tkFunctions else
    if KeyComp('AGENT_CROUCHING') then Result := tkFunctions else
      if KeyComp('AGENT_SITTING') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func146: TtkTokenKind;
begin
  if KeyComp('PRIM_HOLE_CIRCLE') then Result := tkFunctions else
    if KeyComp('llRot2Euler') then Result := tkFunctions else
      if KeyComp('llGetCreator') then Result := tkFunctions else
        if KeyComp('llEuler2Rot') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func147: TtkTokenKind;
begin
  if KeyComp('llTargetOmega') then Result := tkFunctions else
    if KeyComp('ZERO_VECTOR') then Result := tkFunctions else
      if KeyComp('llResetTime') then Result := tkFunctions else
        if KeyComp('llList2Float') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func148: TtkTokenKind;
begin
  if KeyComp('llSameGroup') then Result := tkFunctions else
    if KeyComp('llEdgeOfWorld') then Result := tkFunctions else
      if KeyComp('llGiveMoney') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func149: TtkTokenKind;
begin
  if KeyComp('llGetGMTclock') then Result := tkFunctions else
    if KeyComp('TYPE_VECTOR') then Result := tkFunctions else
      if KeyComp('llAngleBetween') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func151: TtkTokenKind;
begin
  if KeyComp('llDetectedPos') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func152: TtkTokenKind;
begin
  if KeyComp('llGetLinkKey') then Result := tkFunctions else
    if KeyComp('VEHICLE_TYPE_CAR') then Result := tkFunctions else
      if KeyComp('llList2List') then Result := tkFunctions else
        if KeyComp('llSitTarget') then Result := tkFunctions else
          if KeyComp('llOwnerSay') then Result := tkFunctions else
            if KeyComp('land_collision') then Result := tkFunctions else
              if KeyComp('not_at_target') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func153: TtkTokenKind;
begin
  if KeyComp('TYPE_STRING') then Result := tkFunctions else
    if KeyComp('CONTROL_DOWN') then Result := tkFunctions else
      if KeyComp('MASK_EVERYONE') then Result := tkFunctions else
        if KeyComp('PERM_TRANSFER') then Result := tkFunctions else
          if KeyComp('llPushObject') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func154: TtkTokenKind;
begin
  if KeyComp('PRIM_BUMP_TILE') then Result := tkFunctions else
    if KeyComp('llGetObjectDesc') then Result := tkFunctions else
      if KeyComp('llDetectedRot') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func155: TtkTokenKind;
begin
  if KeyComp('touch_start') then Result := tkFunctions else
    if KeyComp('PRIM_PHYSICS') then Result := tkFunctions else
      if KeyComp('CHANGED_TEXTURE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func156: TtkTokenKind;
begin
  if KeyComp('PRIM_BUMP_NONE') then Result := tkFunctions else
    if KeyComp('at_rot_target') then Result := tkFunctions else
      if KeyComp('LAND_SMALL_BRUSH') then Result := tkFunctions else
        if KeyComp('llGetObjectName') then Result := tkFunctions else
          if KeyComp('LINK_ALL_OTHERS') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func157: TtkTokenKind;
begin
  if KeyComp('state_entry') then Result := tkFunctions else
    if KeyComp('llRotTarget') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func158: TtkTokenKind;
begin
  if KeyComp('PRIM_BUMP_BLOBS') then Result := tkFunctions else
    if KeyComp('llGetAgentInfo') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func159: TtkTokenKind;
begin
  if KeyComp('REMOTE_DATA_CHANNEL') then Result := tkFunctions else
    if KeyComp('llRotLookAt') then Result := tkFunctions else
      if KeyComp('CONTROL_RIGHT') then Result := tkFunctions else
        if KeyComp('llGetLocalPos') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func160: TtkTokenKind;
begin
  if KeyComp('STATUS_DIE_AT_EDGE') then Result := tkFunctions else
    if KeyComp('llGetWallclock') then Result := tkFunctions else
      if KeyComp('llPlaySound') then Result := tkFunctions else
        if KeyComp('PSYS_SRC_OMEGA') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func161: TtkTokenKind;
begin
  if KeyComp('llMessageLinked') then Result := tkFunctions else
    if KeyComp('llGetTorque') then Result := tkFunctions else
      if KeyComp('llRotBetween') then Result := tkFunctions else
        if KeyComp('PRIM_BUMP_CHECKER') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func162: TtkTokenKind;
begin
  if KeyComp('llEjectFromLand') then Result := tkFunctions else
    if KeyComp('llOverMyLand') then Result := tkFunctions else
      if KeyComp('llGetLocalRot') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func163: TtkTokenKind;
begin
  if KeyComp('llSetLinkAlpha') then Result := tkFunctions else
    if KeyComp('PRIM_TYPE_BOX') then Result := tkFunctions else
      if KeyComp('llBreakAllLinks') then Result := tkFunctions else
        if KeyComp('PRIM_SHINY_HIGH') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func164: TtkTokenKind;
begin
  if KeyComp('PRIM_BUMP_WEAVE') then Result := tkFunctions else
    if KeyComp('llGetAnimation') then Result := tkFunctions else
      if KeyComp('llListSort') then Result := tkFunctions else
        if KeyComp('LAND_MEDIUM_BRUSH') then Result := tkFunctions else
          if KeyComp('llGetTimeOfDay') then Result := tkFunctions else
            if KeyComp('llLoopSound') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func165: TtkTokenKind;
begin
  if KeyComp('PRIM_HOLE_DEFAULT') then Result := tkFunctions else
    if KeyComp('llGetStatus') then Result := tkFunctions else
      if KeyComp('PRIM_BUMP_WOOD') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func166: TtkTokenKind;
begin
  if KeyComp('llMakeFountain') then Result := tkFunctions else
    if KeyComp('llSetObjectDesc') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func167: TtkTokenKind;
begin
  if KeyComp('DATA_SIM_STATUS') then Result := tkFunctions else
    if KeyComp('CHANGED_ALLOWED_DROP') then Result := tkFunctions else
      if KeyComp('INVENTORY_ALL') then Result := tkFunctions else
        if KeyComp('ATTACH_LSHOULDER') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func168: TtkTokenKind;
begin
  if KeyComp('VEHICLE_BANKING_MIX') then Result := tkFunctions else
    if KeyComp('PRIM_ROTATION') then Result := tkFunctions else
      if KeyComp('llSetObjectName') then Result := tkFunctions else
        if KeyComp('llDetectedType') then Result := tkFunctions else
          if KeyComp('VEHICLE_TYPE_BOAT') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func169: TtkTokenKind;
begin
  if KeyComp('moving_start') then Result := tkFunctions else
    if KeyComp('llGetRegionName') then Result := tkFunctions else
      if KeyComp('PRIM_TEXTURE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func170: TtkTokenKind;
begin
  if KeyComp('PRIM_BUMP_BRICKS') then Result := tkFunctions else
    if KeyComp('llGroundRepel') then Result := tkFunctions else
      if KeyComp('VEHICLE_BUOYANCY') then Result := tkFunctions else
        if KeyComp('PRIM_BUMP_DISKS') then Result := tkFunctions else
          if KeyComp('PRIM_TYPE_TUBE') then Result := tkFunctions else
            if KeyComp('llRezAtRoot') then Result := tkFunctions else
              if KeyComp('llScriptDanger') then Result := tkFunctions else
                if KeyComp('PRIM_TYPE_RING') then Result := tkFunctions else
                  if KeyComp('llGetNextEmail') then Result := tkFunctions else
                    if KeyComp('VEHICLE_TYPE_SLED') then Result := tkFunctions else
                      if KeyComp('PRIM_BUMP_SIDING') then Result := tkFunctions else
                        if KeyComp('PSYS_SRC_MAX_AGE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func171: TtkTokenKind;
begin
  if KeyComp('llStopHover') then Result := tkFunctions else
    if KeyComp('AGENT_ATTACHMENTS') then Result := tkFunctions else
      if KeyComp('STATUS_BLOCK_GRAB') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func172: TtkTokenKind;
begin
  if KeyComp('PRIM_BUMP_BRIGHT') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func173: TtkTokenKind;
begin
  if KeyComp('PRIM_BUMP_GRAVEL') then Result := tkFunctions else
    if KeyComp('ATTACH_RSHOULDER') then Result := tkFunctions else
      if KeyComp('llList2Integer') then Result := tkFunctions else
        if KeyComp('SRC_PATTERN_ANGLE') then Result := tkFunctions else
          if KeyComp('llGetAgentSize') then Result := tkFunctions else
            if KeyComp('llSetTorque') then Result := tkFunctions else
              if KeyComp('AGENT_MOUSELOOK') then Result := tkFunctions else
                if KeyComp('PRIM_POSITION') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func174: TtkTokenKind;
begin
  if KeyComp('llGetRegionFPS') then Result := tkFunctions else
    if KeyComp('llSetLocalRot') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func175: TtkTokenKind;
begin
  if KeyComp('llGetObjectMass') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func176: TtkTokenKind;
begin
  if KeyComp('ZERO_ROTATION') then Result := tkFunctions else
    if KeyComp('llStopSound') then Result := tkFunctions else
      if KeyComp('llBase64ToInteger') then Result := tkFunctions else
        if KeyComp('llIntegerToBase64') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func177: TtkTokenKind;
begin
  if KeyComp('PRIM_HOLE_SQUARE') then Result := tkFunctions else
    if KeyComp('llSetStatus') then Result := tkFunctions else
      if KeyComp('llStopLookAt') then Result := tkFunctions else
        if KeyComp('PERMISSION_DEBIT') then Result := tkFunctions else
          if KeyComp('llList2Vector') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func178: TtkTokenKind;
begin
  if KeyComp('REMOTE_DATA_REPLY') then Result := tkFunctions else
    if KeyComp('TYPE_ROTATION') then Result := tkFunctions else
      if KeyComp('llDetectedOwner') then Result := tkFunctions else
        if KeyComp('land_collision_end') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func179: TtkTokenKind;
begin
  if KeyComp('PSYS_PART_FLAGS') then Result := tkFunctions else
    if KeyComp('PRIM_SHINY_NONE') then Result := tkFunctions else
      if KeyComp('STATUS_SANDBOX') then Result := tkFunctions else
        if KeyComp('llGetTexture') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func180: TtkTokenKind;
begin
  if KeyComp('llPreloadSound') then Result := tkFunctions else
    if KeyComp('llAxisAngle2Rot') then Result := tkFunctions else
      if KeyComp('llDetectedGroup') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func181: TtkTokenKind;
begin
  if KeyComp('PRIM_BUMP_STONE') then Result := tkFunctions else
    if KeyComp('llGroundSlope') then Result := tkFunctions else
      if KeyComp('llPassTouches') then Result := tkFunctions else
        if KeyComp('PRIM_SHINY_LOW') then Result := tkFunctions else
          if KeyComp('llVolumeDetect') then Result := tkFunctions else
            if KeyComp('llList2String') then Result := tkFunctions else
              if KeyComp('llSendRemoteData') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func182: TtkTokenKind;
begin
  if KeyComp('llGetOwnerKey') then Result := tkFunctions else
    if KeyComp('PRIM_HOLE_TRIANGLE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func183: TtkTokenKind;
begin
  if KeyComp('PRIM_BUMP_SHINY') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func184: TtkTokenKind;
begin
  if KeyComp('llStringToBase64') then Result := tkFunctions else
    if KeyComp('llGetTimestamp') then Result := tkFunctions else
      if KeyComp('CHANGED_INVENTORY') then Result := tkFunctions else
        if KeyComp('llBase64ToString') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func185: TtkTokenKind;
begin
  if KeyComp('llMinEventDelay') then Result := tkFunctions else
    if KeyComp('llSetBuoyancy') then Result := tkFunctions else
      if KeyComp('PSYS_PART_MAX_AGE') then Result := tkFunctions else
        if KeyComp('PRIM_MATERIAL_FLESH') then Result := tkFunctions else
          if KeyComp('llTargetRemove') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func186: TtkTokenKind;
begin
  if KeyComp('PRIM_MATERIAL_METAL') then Result := tkFunctions else
    if KeyComp('VEHICLE_REFERENCE_FRAME') then Result := tkFunctions else
      if KeyComp('llGetScriptName') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func187: TtkTokenKind;
begin
  if KeyComp('STATUS_PHANTOM') then Result := tkFunctions else
    if KeyComp('llResetScript') then Result := tkFunctions else
      if KeyComp('llGetLinkNumber') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func188: TtkTokenKind;
begin
  if KeyComp('llListFindList') then Result := tkFunctions else
    if KeyComp('llGroundNormal') then Result := tkFunctions else
      if KeyComp('llSetLinkColor') then Result := tkFunctions else
        if KeyComp('PRIM_TEMP_ON_REZ') then Result := tkFunctions else
          if KeyComp('llAttachToAvatar') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func189: TtkTokenKind;
begin
  if KeyComp('PRIM_BUMP_STUCCO') then Result := tkFunctions else
    if KeyComp('llScaleTexture') then Result := tkFunctions else
      if KeyComp('llDeleteSubList') then Result := tkFunctions else
        if KeyComp('llTakeControls') then Result := tkFunctions else
          if KeyComp('VEHICLE_HOVER_HEIGHT') then Result := tkFunctions else
            if KeyComp('llStringLength') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func190: TtkTokenKind;
begin
  if KeyComp('llGetNotecardLine') then Result := tkFunctions else
    if KeyComp('PERMISSION_ATTACH') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func191: TtkTokenKind;
begin
  if KeyComp('llSensorRepeat') then Result := tkFunctions else
    if KeyComp('llGetFreeMemory') then Result := tkFunctions else
      if KeyComp('llSetTexture') then Result := tkFunctions else
        if KeyComp('PRIM_BUMP_CONCRETE') then Result := tkFunctions else
          if KeyComp('PRIM_MATERIAL_LIGHT') then Result := tkFunctions else
            if KeyComp('llSetVehicleFlags') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func192: TtkTokenKind;
begin
  if KeyComp('PRIM_MATERIAL_WOOD') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func193: TtkTokenKind;
begin
  if KeyComp('llListenRemove') then Result := tkFunctions else
    if KeyComp('llTriggerSound') then Result := tkFunctions else
      if KeyComp('PRIM_MATERIAL_GLASS') then Result := tkFunctions else
        if KeyComp('PRIM_TYPE_SPHERE') then Result := tkFunctions else
          if KeyComp('CONTROL_ROT_LEFT') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func194: TtkTokenKind;
begin
  if KeyComp('llGetListLength') then Result := tkFunctions else
    if KeyComp('llSetSitText') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func195: TtkTokenKind;
begin
  if KeyComp('PSYS_PART_END_ALPHA') then Result := tkFunctions else
    if KeyComp('llGetLandOwnerAt') then Result := tkFunctions else
      if KeyComp('llDetachFromAvatar') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func196: TtkTokenKind;
begin
  if KeyComp('llMoveToTarget') then Result := tkFunctions else
    if KeyComp('llGetSubString') then Result := tkFunctions else
      if KeyComp('llGetBoundingBox') then Result := tkFunctions else
        if KeyComp('llMakeExplosion') then Result := tkFunctions else
          if KeyComp('PRIM_SHINY_MEDIUM') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func197: TtkTokenKind;
begin
  if KeyComp('PSYS_PART_END_SCALE') then Result := tkFunctions else
    if KeyComp('PRIM_TYPE_PRISM') then Result := tkFunctions else
      if KeyComp('PRIM_BUMP_LARGETILE') then Result := tkFunctions else
        if KeyComp('PARCEL_MEDIA_COMMAND_TIME') then Result := tkFunctions else
          if KeyComp('INVENTORY_OBJECT') then Result := tkFunctions else
            if KeyComp('PARCEL_MEDIA_COMMAND_AGENT') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func199: TtkTokenKind;
begin
  if KeyComp('STATUS_PHYSICS') then Result := tkFunctions else
    if KeyComp('llStopPointAt') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func200: TtkTokenKind;
begin
  if KeyComp('collision_start') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func201: TtkTokenKind;
begin
  if KeyComp('PARCEL_MEDIA_COMMAND_URL') then Result := tkFunctions else
    if KeyComp('CONTROL_LBUTTON') then Result := tkFunctions else
      if KeyComp('llApplyImpulse') then Result := tkFunctions else
        if KeyComp('VEHICLE_TYPE_BALLOON') then Result := tkFunctions else
          if KeyComp('PRIM_MATERIAL_RUBBER') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func202: TtkTokenKind;
begin
  if KeyComp('llGetAndResetTime') then Result := tkFunctions else
    if KeyComp('llListRandomize') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func203: TtkTokenKind;
begin
  if KeyComp('STATUS_ROTATE_X') then Result := tkFunctions else
    if KeyComp('llStopAnimation') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func204: TtkTokenKind;
begin
  if KeyComp('STATUS_ROTATE_Y') then Result := tkFunctions else
    if KeyComp('llSensorRemove') then Result := tkFunctions else
      if KeyComp('PARCEL_MEDIA_COMMAND_PLAY') then Result := tkFunctions else
        if KeyComp('llInstantMessage') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func205: TtkTokenKind;
begin
  if KeyComp('STATUS_ROTATE_Z') then Result := tkFunctions else
    if KeyComp('llGodLikeRezObject') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func206: TtkTokenKind;
begin
  if KeyComp('llSetHoverHeight') then Result := tkFunctions else
    if KeyComp('VEHICLE_TYPE_AIRPLANE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func207: TtkTokenKind;
begin
  if KeyComp('VEHICLE_BANKING_EFFICIENCY') then Result := tkFunctions else
    if KeyComp('llGetCenterOfMass') then Result := tkFunctions else
      if KeyComp('REMOTE_DATA_REQUEST') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func208: TtkTokenKind;
begin
  if KeyComp('not_at_rot_target') then Result := tkFunctions else
    if KeyComp('PARCEL_MEDIA_COMMAND_LOOP') then Result := tkFunctions else
      if KeyComp('PRIM_MATERIAL_STONE') then Result := tkFunctions else
        if KeyComp('llInsertString') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func209: TtkTokenKind;
begin
  if KeyComp('PRIM_BUMP_SUCTION') then Result := tkFunctions else
    if KeyComp('VEHICLE_BANKING_TIMESCALE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func210: TtkTokenKind;
begin
  if KeyComp('SRC_PATTERN_ANGLE_CONE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func211: TtkTokenKind;
begin
  if KeyComp('llSetVehicleType') then Result := tkFunctions else
    if KeyComp('llGetRegionCorner') then Result := tkFunctions else
      if KeyComp('llForceMouselook') then Result := tkFunctions else
        if KeyComp('llSetTimerEvent') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func212: TtkTokenKind;
begin
  if KeyComp('llStartAnimation') then Result := tkFunctions else
    if KeyComp('CONTROL_ROT_RIGHT') then Result := tkFunctions else
      if KeyComp('PRIM_TYPE_CYLINDER') then Result := tkFunctions else
        if KeyComp('PARCEL_MEDIA_COMMAND_PAUSE') then Result := tkFunctions else
          if KeyComp('llParcelMediaQuery') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func213: TtkTokenKind;
begin
  if KeyComp('llListenControl') then Result := tkFunctions else
    if KeyComp('PSYS_SRC_PATTERN') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func214: TtkTokenKind;
begin
  if KeyComp('CONTROL_ML_BUTTON') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func215: TtkTokenKind;
begin
  if KeyComp('INVENTORY_SOUND') then Result := tkFunctions else
    if KeyComp('llSetTouchText') then Result := tkFunctions else
      if KeyComp('PRIM_TYPE_TORUS') then Result := tkFunctions else
        if KeyComp('PRIM_MATERIAL_PLASTIC') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func216: TtkTokenKind;
begin
  if KeyComp('llSetCameraAtOffset') then Result := tkFunctions else
    if KeyComp('llRemoteDataReply') then Result := tkFunctions else
      if KeyComp('INVENTORY_LANDMARK') then Result := tkFunctions else
        if KeyComp('VEHICLE_FLAG_CAMERA_DECOUPLED') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func217: TtkTokenKind;
begin
  if KeyComp('llCollisionFilter') then Result := tkFunctions else
    if KeyComp('llRequestAgentData') then Result := tkFunctions else
      if KeyComp('VEHICLE_HOVER_EFFICIENCY') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func218: TtkTokenKind;
begin
  if KeyComp('llDeleteSubString') then Result := tkFunctions else
    if KeyComp('PSYS_SRC_INNERANGLE') then Result := tkFunctions else
      if KeyComp('llListReplaceList') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func219: TtkTokenKind;
begin
  if KeyComp('VEHICLE_HOVER_TIMESCALE') then Result := tkFunctions else
    if KeyComp('llGetScriptState') then Result := tkFunctions else
      if KeyComp('llCollisionSound') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func220: TtkTokenKind;
begin
  if KeyComp('llReleaseControls') then Result := tkFunctions else
    if KeyComp('llGetNumberOfSides') then Result := tkFunctions else
      if KeyComp('llPassCollisions') then Result := tkFunctions else
        if KeyComp('PARCEL_MEDIA_COMMAND_STOP') then Result := tkFunctions else
          if KeyComp('PSYS_PART_END_COLOR') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func221: TtkTokenKind;
begin
  if KeyComp('llOffsetTexture') then Result := tkFunctions else
    if KeyComp('llGetSunDirection') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func222: TtkTokenKind;
begin
  if KeyComp('llGiveInventory') then Result := tkFunctions else
    if KeyComp('llGroundContour') then Result := tkFunctions else
      if KeyComp('llSubStringIndex') then Result := tkFunctions else
        if KeyComp('INVENTORY_NOTECARD') then Result := tkFunctions else
          if KeyComp('llGetObjectPermMask') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func223: TtkTokenKind;
begin
  if KeyComp('llParticleSystem') then Result := tkFunctions else
    if KeyComp('llPlaySoundSlave') then Result := tkFunctions else
      if KeyComp('llGetTextureScale') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func226: TtkTokenKind;
begin
  if KeyComp('llSetSoundRadius') then Result := tkFunctions else
    if KeyComp('llDetectedLinkNumber') then Result := tkFunctions else
      if KeyComp('llGetPermissions') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func227: TtkTokenKind;
begin
  if KeyComp('INVENTORY_SCRIPT') then Result := tkFunctions else
    if KeyComp('llXorBase64Strings') then Result := tkFunctions else
      if KeyComp('llGetAnimationList') then Result := tkFunctions else
        if KeyComp('llLoopSoundSlave') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func228: TtkTokenKind;
begin
  if KeyComp('llRemoveVehicleFlags') then Result := tkFunctions else
    if KeyComp('llAddToLandPassList') then Result := tkFunctions else
      if KeyComp('PSYS_PART_WIND_MASK') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func229: TtkTokenKind;
begin
  if KeyComp('llRotateTexture') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func230: TtkTokenKind;
begin
  if KeyComp('INVENTORY_CLOTHING') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func231: TtkTokenKind;
begin
  if KeyComp('llSetCameraEyeOffset') then Result := tkFunctions else
    if KeyComp('llSetScriptState') then Result := tkFunctions else
      if KeyComp('PSYS_SRC_TARGET_KEY') then Result := tkFunctions else
        if KeyComp('llSetTextureAnim') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func232: TtkTokenKind;
begin
  if KeyComp('PSYS_SRC_TEXTURE') then Result := tkFunctions else
    if KeyComp('llRemoteLoadScript') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func233: TtkTokenKind;
begin
  if KeyComp('llGetGeometricCenter') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func234: TtkTokenKind;
begin
  if KeyComp('llCollisionSprite') then Result := tkFunctions else
    if KeyComp('llGetTextureRot') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func235: TtkTokenKind;
begin
  if KeyComp('land_collision_start') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func237: TtkTokenKind;
begin
  if KeyComp('PSYS_SRC_OUTERANGLE') then Result := tkFunctions else
    if KeyComp('llList2ListStrided') then Result := tkFunctions else
      if KeyComp('INVENTORY_GESTURE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func238: TtkTokenKind;
begin
  if KeyComp('llDumpList2String') then Result := tkFunctions else
    if KeyComp('PSYS_PART_TRAIL_MASK') then Result := tkFunctions else
      if KeyComp('INVENTORY_ANIMATION') then Result := tkFunctions else
        if KeyComp('PSYS_PART_BOUNCE_MASK') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func239: TtkTokenKind;
begin
  if KeyComp('llTeleportAgentHome') then Result := tkFunctions else
    if KeyComp('llGetNumberOfPrims') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func240: TtkTokenKind;
begin
  if KeyComp('llRotTargetRemove') then Result := tkFunctions else
    if KeyComp('PERMISSION_CHANGE_LINKS') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func242: TtkTokenKind;
begin
  if KeyComp('llListInsertList') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func243: TtkTokenKind;
begin
  if KeyComp('INVENTORY_BODYPART') then Result := tkFunctions else
    if KeyComp('PSYS_SRC_BURST_RATE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func244: TtkTokenKind;
begin
  if KeyComp('llParseString2List') then Result := tkFunctions else
    if KeyComp('VEHICLE_FLAG_MOUSELOOK_BANK') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func245: TtkTokenKind;
begin
  if KeyComp('llSetForceAndTorque') then Result := tkFunctions else
    if KeyComp('llLoopSoundMaster') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func246: TtkTokenKind;
begin
  if KeyComp('llGetInventoryName') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func247: TtkTokenKind;
begin
  if KeyComp('llGetStartParameter') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func249: TtkTokenKind;
begin
  if KeyComp('VEHICLE_FLAG_NO_DEFLECTION_UP') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func250: TtkTokenKind;
begin
  if KeyComp('llGetRootRotation') then Result := tkFunctions else
    if KeyComp('llAvatarOnSitTarget') then Result := tkFunctions else
      if KeyComp('PSYS_PART_START_ALPHA') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func252: TtkTokenKind;
begin
  if KeyComp('llSetParcelMusicURL') then Result := tkFunctions else
    if KeyComp('llOpenRemoteDataChannel') then Result := tkFunctions else
      if KeyComp('PSYS_PART_START_SCALE') then Result := tkFunctions else
        if KeyComp('PSYS_SRC_PATTERN_ANGLE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func253: TtkTokenKind;
begin
  if KeyComp('llSetVehicleFloatParam') then Result := tkFunctions else
    if KeyComp('llGetInventoryKey') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func254: TtkTokenKind;
begin
  if KeyComp('llParcelMediaCommandList') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func255: TtkTokenKind;
begin
  if KeyComp('llGetRootPosition') then Result := tkFunctions else
    if KeyComp('llGetTextureOffset') then Result := tkFunctions else
      if KeyComp('llRemoteDataSetRegion') then Result := tkFunctions else
        if KeyComp('INVENTORY_TEXTURE') then Result := tkFunctions else
          if KeyComp('llSetSoundQueueing') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func257: TtkTokenKind;
begin
  if KeyComp('llResetOtherScript') then Result := tkFunctions else
    if KeyComp('llCloseRemoteDataChannel') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func259: TtkTokenKind;
begin
  if KeyComp('llRemoveInventory') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func261: TtkTokenKind;
begin
  if KeyComp('VEHICLE_FLAG_HOVER_UP_ONLY') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func262: TtkTokenKind;
begin
  if KeyComp('PERMISSION_CHANGE_JOINTS') then Result := tkFunctions else
    if KeyComp('llGetPrimitiveParams') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func263: TtkTokenKind;
begin
  if KeyComp('PARCEL_MEDIA_COMMAND_TEXTURE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func264: TtkTokenKind;
begin
  if KeyComp('VEHICLE_FLAG_HOVER_GLOBAL_HEIGHT') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func266: TtkTokenKind;
begin
  if KeyComp('PSYS_SRC_PATTERN_DROP') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func267: TtkTokenKind;
begin
  if KeyComp('PSYS_PART_RANDOM_ACCEL_MASK') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func269: TtkTokenKind;
begin
  if KeyComp('llStopMoveToTarget') then Result := tkFunctions else
    if KeyComp('llGetPermissionsKey') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func271: TtkTokenKind;
begin
  if KeyComp('PSYS_SRC_BURST_RADIUS') then Result := tkFunctions else
    if KeyComp('VEHICLE_FLAG_LIMIT_MOTOR_UP') then Result := tkFunctions else
      if KeyComp('llTriggerSoundLimited') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func273: TtkTokenKind;
begin
  if KeyComp('llRemoteLoadScriptPin') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func274: TtkTokenKind;
begin
  if KeyComp('llGetRegionTimeDilation') then Result := tkFunctions else
    if KeyComp('llSetPrimitiveParams') then Result := tkFunctions else
      if KeyComp('run_time_permissions') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func275: TtkTokenKind;
begin
  if KeyComp('PSYS_PART_START_COLOR') then Result := tkFunctions else
    if KeyComp('VEHICLE_LINEAR_MOTOR_OFFSET') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func276: TtkTokenKind;
begin
  if KeyComp('VEHICLE_FLAG_LIMIT_ROLL_ONLY') then Result := tkFunctions else
    if KeyComp('llAdjustSoundVolume') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func278: TtkTokenKind;
begin
  if KeyComp('llGetListEntryType') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func279: TtkTokenKind;
begin
  if KeyComp('PSYS_PART_EMISSIVE_MASK') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func282: TtkTokenKind;
begin
  if KeyComp('PSYS_PART_RANDOM_VEL_MASK') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func283: TtkTokenKind;
begin
  if KeyComp('llSetVehicleVectorParam') then Result := tkFunctions else
    if KeyComp('VEHICLE_FLAG_MOUSELOOK_STEER') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func284: TtkTokenKind;
begin
  if KeyComp('PSYS_SRC_BURST_SPEED_MIN') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func285: TtkTokenKind;
begin
  if KeyComp('llGiveInventoryList') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func286: TtkTokenKind;
begin
  if KeyComp('PSYS_SRC_BURST_SPEED_MAX') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func288: TtkTokenKind;
begin
  if KeyComp('llGetInventoryNumber') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func289: TtkTokenKind;
begin
  if KeyComp('PSYS_SRC_PATTERN_ANGLE_CONE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func290: TtkTokenKind;
begin
  if KeyComp('PERMISSION_TAKE_CONTROLS') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func291: TtkTokenKind;
begin
  if KeyComp('VEHICLE_LINEAR_MOTOR_TIMESCALE') then Result := tkFunctions else
    if KeyComp('VEHICLE_FLAG_HOVER_WATER_ONLY') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func294: TtkTokenKind;
begin
  if KeyComp('PSYS_SRC_PATTERN_EXPLODE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func296: TtkTokenKind;
begin
  if KeyComp('llGetInventoryCreator') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func298: TtkTokenKind;
begin
  if KeyComp('llGetSimulatorHostname') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func299: TtkTokenKind;
begin
  if KeyComp('llAllowInventoryDrop') then Result := tkFunctions else
    if KeyComp('PSYS_PART_TARGET_POS_MASK') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func300: TtkTokenKind;
begin
  if KeyComp('PSYS_PART_INTERP_SCALE_MASK') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func301: TtkTokenKind;
begin
  if KeyComp('PSYS_PART_FOLLOW_SRC_MASK') then Result := tkFunctions else
    if KeyComp('VEHICLE_LINEAR_MOTOR_DIRECTION') then Result := tkFunctions else
      if KeyComp('VEHICLE_LINEAR_DEFLECTION_EFFICIENCY') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func302: TtkTokenKind;
begin
  if KeyComp('llRequestSimulatorData') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func303: TtkTokenKind;
begin
  if KeyComp('llParseStringKeepNulls') then Result := tkFunctions else
    if KeyComp('VEHICLE_LINEAR_DEFLECTION_TIMESCALE') then Result := tkFunctions else
      if KeyComp('llRequestPermissions') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func304: TtkTokenKind;
begin
  if KeyComp('VEHICLE_LINEAR_FRICTION_TIMESCALE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func306: TtkTokenKind;
begin
  if KeyComp('VEHICLE_ANGULAR_MOTOR_TIMESCALE') then Result := tkFunctions else
    if KeyComp('PERMISSION_REMAP_CONTROLS') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func309: TtkTokenKind;
begin
  if KeyComp('VEHICLE_FLAG_HOVER_TERRAIN_ONLY') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func310: TtkTokenKind;
begin
  if KeyComp('llGetNumberOfNotecardLines') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func312: TtkTokenKind;
begin
  if KeyComp('llGetInventoryPermMask') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func314: TtkTokenKind;
begin
  if KeyComp('llSetVehicleRotationParam') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func316: TtkTokenKind;
begin
  if KeyComp('VEHICLE_ANGULAR_DEFLECTION_EFFICIENCY') then Result := tkFunctions else
    if KeyComp('llRequestInventoryData') then Result := tkFunctions else
      if KeyComp('VEHICLE_ANGULAR_MOTOR_DIRECTION') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func317: TtkTokenKind;
begin
  if KeyComp('PERMISSION_TRIGGER_ANIMATION') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func318: TtkTokenKind;
begin
  if KeyComp('VEHICLE_ANGULAR_DEFLECTION_TIMESCALE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func319: TtkTokenKind;
begin
  if KeyComp('VEHICLE_ANGULAR_FRICTION_TIMESCALE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func323: TtkTokenKind;
begin
  if KeyComp('PSYS_PART_INTERP_COLOR_MASK') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func327: TtkTokenKind;
begin
  if KeyComp('PSYS_SRC_BURST_PART_COUNT') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func329: TtkTokenKind;
begin
  if KeyComp('VEHICLE_LINEAR_MOTOR_DECAY_TIMESCALE') then Result := tkFunctions else
    if KeyComp('PERMISSION_RELEASE_OWNERSHIP') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func331: TtkTokenKind;
begin
  if KeyComp('PERMISSION_CHANGE_PERMISSIONS') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func335: TtkTokenKind;
begin
  if KeyComp('llApplyRotationalImpulse') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func339: TtkTokenKind;
begin
  if KeyComp('llSetRemoteScriptAccessPin') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func344: TtkTokenKind;
begin
  if KeyComp('VEHICLE_ANGULAR_MOTOR_DECAY_TIMESCALE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func360: TtkTokenKind;
begin
  if KeyComp('VEHICLE_VERTICAL_ATTRACTION_EFFICIENCY') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func362: TtkTokenKind;
begin
  if KeyComp('VEHICLE_VERTICAL_ATTRACTION_TIMESCALE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func372: TtkTokenKind;
begin
  if KeyComp('PSYS_PART_FOLLOW_VELOCITY_MASK') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.Func455: TtkTokenKind;
begin
  if KeyComp('PSYS_SRC_OUTERANGLEPSYS_SRC_INNERANGLE') then Result := tkFunctions else Result := tkIdentifier;
end;

function TSynHighlighterLSL.AltFunc: TtkTokenKind;
begin
  Result := tkIdentifier;
end;

function TSynHighlighterLSL.IdentKind(MayBe: PChar): TtkTokenKind;
var
  HashKey: Integer;
begin
  fToIdent := MayBe;
  HashKey := KeyHash(MayBe);
  if HashKey <= MaxKey then
    Result := fIdentFuncTable[HashKey]
  else
    Result := tkIdentifier;
end;

procedure TSynHighlighterLSL.MakeMethodTables;
var
  I: Char;
begin
  for I := #0 to #255 do
    case I of
      #0: fProcTable[I] := NullProc;
      #10: fProcTable[I] := LFProc;
      #13: fProcTable[I] := CRProc;
      '/': fProcTable[I] := AnsiCProc;
      '"': fProcTable[I] := StringOpenProc;
      '''': fProcTable[I] := StringOpenProc;
      #1..#9,
      #11,
      #12,
      #14..#32 : fProcTable[I] := SpaceProc;
      'A'..'Z', 'a'..'z', '_': fProcTable[I] := IdentProc;
    else
      fProcTable[I] := UnknownProc;
    end;
end;

procedure TSynHighlighterLSL.SpaceProc;
begin
  fTokenID := tkSpace;
  repeat
    inc(Run);
  until not (fLine[Run] in [#1..#32]);
end;

procedure TSynHighlighterLSL.NullProc;
begin
  fTokenID := tkNull;
end;

procedure TSynHighlighterLSL.CRProc;
begin
  fTokenID := tkSpace;
  inc(Run);
  if fLine[Run] = #10 then
    inc(Run);
end;

procedure TSynHighlighterLSL.LFProc;
begin
  fTokenID := tkSpace;
  inc(Run);
end;

procedure TSynHighlighterLSL.StringOpenProc;
begin
  Inc(Run);
  fRange := rsString;
  StringProc;
  fTokenID := tkString;
end;

procedure TSynHighlighterLSL.StringProc;
begin
  fTokenID := tkString;
  repeat
    if (fLine[Run] = '"') then
    begin
      Inc(Run, 1);
      fRange := rsUnKnown;
      Break;
    end;
    if not (fLine[Run] in [#0, #10, #13]) then
      Inc(Run);
  until fLine[Run] in [#0, #10, #13];
end;

procedure TSynHighlighterLSL.Proc;
begin
  fTokenID := tkFunctions;
  repeat
    if (fLine[Run] = '>') and
       (fLine[Run + 1] = '<') and
       (fLine[Run + 2] = '|') then
    begin
      Inc(Run, 3);
      fRange := rsUnKnown;
      Break;
    end;
    if not (fLine[Run] in [#0, #10, #13]) then
      Inc(Run);
  until fLine[Run] in [#0, #10, #13];
end;

constructor TSynHighlighterLSL.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fCommentAttri := TSynHighLighterAttributes.Create(SYNS_AttrComment);
  fCommentAttri.Style := [fsItalic];
  fCommentAttri.Foreground := clNavy;
  AddAttribute(fCommentAttri);

  fIdentifierAttri := TSynHighLighterAttributes.Create(SYNS_AttrIdentifier);
  AddAttribute(fIdentifierAttri);

  fKeyAttri := TSynHighLighterAttributes.Create(SYNS_AttrReservedWord);
  AddAttribute(fKeyAttri);

  fSpaceAttri := TSynHighLighterAttributes.Create(SYNS_AttrSpace);
  AddAttribute(fSpaceAttri);

  fStringAttri := TSynHighLighterAttributes.Create(SYNS_AttrString);
  AddAttribute(fStringAttri);

  fFunctionAttri := TSynHighlighterAttributes.Create(SYNS_AttrFunction);
  AddAttribute(fFunctionAttri);

  SetAttributesOnChange(DefHighlightChange);
  InitIdent;
  MakeMethodTables;
  fDefaultFilter := SYNS_FilterLindenScriptingLanguage;
  fRange := rsUnknown;
end;

procedure TSynHighlighterLSL.SetLine(NewValue: String; LineNumber: Integer);
begin
  fLineRef := NewValue;
  fLine := PChar(fLineRef);
  Run := 0;
  fLineNumber := LineNumber;
  Next;
end;

procedure TSynHighlighterLSL.IdentProc;
begin
  fTokenID := IdentKind((fLine + Run));

inc(Run, fStringLen);

while Identifiers[fLine[Run]] do

Inc(Run);

end;

procedure TSynHighlighterLSL.UnknownProc;
begin
{$IFDEF SYN_MBCSSUPPORT}
  if FLine[Run] in LeadBytes then
    Inc(Run,2)
  else
{$ENDIF}
  inc(Run);
  fTokenID := tkUnknown;
end;

procedure TSynHighlighterLSL.Next;
begin
  fTokenPos := Run;
  case fRange of
    rsComment: AnsiCProc;
{$IFDEF SYN_HEREDOC}
    rsHeredoc : HeredocProc;
{$ENDIF}
    else begin
      fRange := rsUnknown;
      fProcTable[fLine[Run]];
    end;
  end;
end;

procedure TSynHighlighterLSL.AnsiCProc;
begin
  fTokenID := tkComment;
  case FLine[Run] of
    #0:
      begin
        NullProc;
        exit;
      end;
    #10:
      begin
        LFProc;
        exit;
      end;
    #13:
      begin
        CRProc;
        exit;
      end;
  end;

  while FLine[Run] <> #0 do
    case FLine[Run] of
      '*':
        if fLine[Run + 1] = '/' then
        begin
          inc(Run, 2);
          fRange := rsUnKnown;
          break;
        end
        else inc(Run);
      #10: break;
      #13: break;
    else inc(Run);
    end;
end;

function TSynHighlighterLSL.GetDefaultAttribute(Index: integer): TSynHighLighterAttributes;
begin
  case Index of
    SYN_ATTR_COMMENT    : Result := fCommentAttri;
    SYN_ATTR_IDENTIFIER : Result := fIdentifierAttri;
    SYN_ATTR_KEYWORD    : Result := fKeyAttri;
    SYN_ATTR_STRING     : Result := fStringAttri;
    SYN_ATTR_WHITESPACE : Result := fSpaceAttri;
  else
    Result := nil;
  end;
end;

function TSynHighlighterLSL.GetEol: Boolean;
begin
  Result := fTokenID = tkNull;
end;

function TSynHighlighterLSL.GetKeyWords: string;
begin
  Result := 
    'ACTIVE,AGENT,AGENT_ATTACHMENTS,AGENT_AWAY,AGENT_CROUCHING,AGENT_FLYIN' +
    'G,AGENT_IN_AIR,AGENT_MOUSELOOK,AGENT_ON_OBJECT,AGENT_SCRIPTED,AGENT_SI' +
    'TTING,AGENT_TYPING,AGENT_WALKING,ALL_SIDES,ANIM_ON,at_rot_target,at_ta' +
    'rget,attach,ATTACH_BACK,ATTACH_BELLY,ATTACH_CHEST,ATTACH_CHIN,ATTACH_H' +
    'EAD,ATTACH_LEAR,ATTACH_LEYE,ATTACH_LFOOT,ATTACH_LHAND,ATTACH_LHIP,ATTA' +
    'CH_LLARM,ATTACH_LLLEG,ATTACH_LPEC,ATTACH_LSHOULDER,ATTACH_LUARM,ATTACH' +
    '_LULEG,ATTACH_MOUTH,ATTACH_NOSE,ATTACH_PELVIS,ATTACH_REAR,ATTACH_REYE,' +
    'ATTACH_RFOOT,ATTACH_RHAND,ATTACH_RHIP,ATTACH_RLARM,ATTACH_RLLEG,ATTACH' +
    '_RPEC,ATTACH_RSHOULDER,ATTACH_RUARM,ATTACH_RULEG,changed,CHANGED_ALLOW' +
    'ED_DROP,CHANGED_COLOR,CHANGED_INVENTORY,CHANGED_LINK,CHANGED_SCALE,CHA' +
    'NGED_SHAPE,CHANGED_TEXTURE,collision,collision_end,collision_start,con' +
    'trol,CONTROL_BACK,CONTROL_DOWN,CONTROL_FWD,CONTROL_LBUTTON,CONTROL_LEF' +
    'T,CONTROL_ML_BUTTON,CONTROL_RIGHT,CONTROL_ROT_LEFT,CONTROL_ROT_RIGHT,C' +
    'ONTROL_UP,DATA_BORN,DATA_NAME,DATA_ONLINE,DATA_RATING,DATA_SIM_POS,DAT' +
    'A_SIM_STATUS,dataserver,default,DEG_TO_RAD,do,else,email,FALSE,float,f' +
    'or,if,integer,INVENTORY_ALL,INVENTORY_ANIMATION,INVENTORY_BODYPART,INV' +
    'ENTORY_CLOTHING,INVENTORY_GESTURE,INVENTORY_LANDMARK,INVENTORY_NOTECAR' +
    'D,INVENTORY_OBJECT,INVENTORY_SCRIPT,INVENTORY_SOUND,INVENTORY_TEXTURE,' +
    'jump,key,land_collision,land_collision_end,land_collision_start,LAND_L' +
    'ARGE_BRUSH,LAND_LEVEL,LAND_LOWER,LAND_MEDIUM_BRUSH,LAND_NOISE,LAND_RAI' +
    'SE,LAND_REVERT,LAND_SMALL_BRUSH,LAND_SMOOTH,LINK_ALL_CHILDREN,LINK_ALL' +
    '_OTHERS,link_message,LINK_ROOT,LINK_SET,LINK_THIS,list,listen,llAbs,ll' +
    'Acos,llAddToLandPassList,llAdjustSoundVolume,llAllowInventoryDrop,llAn' +
    'gleBetween,llApplyImpulse,llApplyRotationalImpulse,llAsin,llAtan2,llAt' +
    'tachToAvatar,llAvatarOnSitTarget,llAxes2Rot,llAxisAngle2Rot,llBase64To' +
    'Integer,llBase64ToString,llBreakAllLinks,llBreakLink,llCeil,llCloseRem' +
    'oteDataChannel,llCloud,llCollisionFilter,llCollisionSound,llCollisionS' +
    'prite,llCos,llCreateLink,llCSV2List,llDeleteSubList,llDeleteSubString,' +
    'llDetachFromAvatar,llDetectedGrab,llDetectedGroup,llDetectedKey,llDete' +
    'ctedLinkNumber,llDetectedName,llDetectedOwner,llDetectedPos,llDetected' +
    'Rot,llDetectedType,llDetectedVel,llDialog,llDie,llDumpList2String,llEd' +
    'geOfWorld,llEjectFromLand,llEmail,llEuler2Rot,llFabs,llFloor,llForceMo' +
    'uselook,llFrand,llGetAccel,llGetAgentInfo,llGetAgentSize,llGetAlpha,ll' +
    'GetAndResetTime,llGetAnimation,llGetAnimationList,llGetAttached,llGetB' +
    'oundingBox,llGetCenterOfMass,llGetColor,llGetCreator,llGetDate,llGetEn' +
    'ergy,llGetForce,llGetFreeMemory,llGetGeometricCenter,llGetGMTclock,llG' +
    'etInventoryCreator,llGetInventoryKey,llGetInventoryName,llGetInventory' +
    'Number,llGetInventoryPermMask,llGetKey,llGetLandOwnerAt,llGetLinkKey,l' +
    'lGetLinkName,llGetLinkNumber,llGetListEntryType,llGetListLength,llGetL' +
    'ocalPos,llGetLocalRot,llGetMass,llGetNextEmail,llGetNotecardLine,llGet' +
    'NumberOfNotecardLines,llGetNumberOfPrims,llGetNumberOfSides,llGetObjec' +
    'tDesc,llGetObjectMass,llGetObjectName,llGetObjectPermMask,llGetOmega,l' +
    'lGetOwner,llGetOwnerKey,llGetPermissions,llGetPermissionsKey,llGetPos,' +
    'llGetPrimitiveParams,llGetRegionCorner,llGetRegionFPS,llGetRegionName,' +
    'llGetRegionTimeDilation,llGetRootPosition,llGetRootRotation,llGetRot,l' +
    'lGetScale,llGetScriptName,llGetScriptState,llGetSimulatorHostname,llGe' +
    'tStartParameter,llGetStatus,llGetSubString,llGetSunDirection,llGetText' +
    'ure,llGetTextureOffset,llGetTextureRot,llGetTextureScale,llGetTime,llG' +
    'etTimeOfDay,llGetTimestamp,llGetTorque,llGetVel,llGetWallclock,llGiveI' +
    'nventory,llGiveInventoryList,llGiveMoney,llGodLikeRezObject,llGround,l' +
    'lGroundContour,llGroundNormal,llGroundRepel,llGroundSlope,llInsertStri' +
    'ng,llInstantMessage,llIntegerToBase64,llKey2Name,llList2CSV,llList2Flo' +
    'at,llList2Integer,llList2Key,llList2List,llList2ListStrided,llList2Rot' +
    ',llList2String,llList2Vector,llListen,llListenControl,llListenRemove,l' +
    'lListFindList,llListInsertList,llListRandomize,llListReplaceList,llLis' +
    'tSort,llLoadURL,llLog,llLog10,llLookAt,llLoopSound,llLoopSoundMaster,l' +
    'lLoopSoundSlave,llMakeExplosion,llMakeFire,llMakeFountain,llMakeSmoke,' +
    'llMD5String,llMessageLinked,llMinEventDelay,llModifyLand,llMoveToTarge' +
    't,llOffsetTexture,llOpenRemoteDataChannel,llOverMyLand,llOwnerSay,llPa' +
    'rcelMediaCommandList,llParcelMediaQuery,llParseString2List,llParseStri' +
    'ngKeepNulls,llParticleSystem,llPassCollisions,llPassTouches,llPlaySoun' +
    'd,llPlaySoundSlave,llPointAt,llPow,llPreloadSound,llPushObject,llRelea' +
    'seControls,llRemoteDataReply,llRemoteDataSetRegion,llRemoteLoadScript,' +
    'llRemoteLoadScriptPin,llRemoveInventory,llRemoveVehicleFlags,llRequest' +
    'AgentData,llRequestInventoryData,llRequestPermissions,llRequestSimulat' +
    'orData,llResetOtherScript,llResetScript,llResetTime,llRezAtRoot,llRezO' +
    'bject,llRot2Angle,llRot2Axis,llRot2Euler,llRot2Fwd,llRot2Left,llRot2Up' +
    ',llRotateTexture,llRotBetween,llRotLookAt,llRotTarget,llRotTargetRemov' +
    'e,llRound,llSameGroup,llSay,llScaleTexture,llScriptDanger,llSendRemote' +
    'Data,llSensor,llSensorRemove,llSensorRepeat,llSetAlpha,llSetBuoyancy,l' +
    'lSetCameraAtOffset,llSetCameraEyeOffset,llSetColor,llSetDamage,llSetFo' +
    'rce,llSetForceAndTorque,llSetHoverHeight,llSetLinkAlpha,llSetLinkColor' +
    ',llSetLocalRot,llSetObjectDesc,llSetObjectName,llSetParcelMusicURL,llS' +
    'etPos,llSetPrimitiveParams,llSetRemoteScriptAccessPin,llSetRot,llSetSc' +
    'ale,llSetScriptState,llSetSitText,llSetSoundQueueing,llSetSoundRadius,' +
    'llSetStatus,llSetText,llSetTexture,llSetTextureAnim,llSetTimerEvent,ll' +
    'SetTorque,llSetTouchText,llSetVehicleFlags,llSetVehicleFloatParam,llSe' +
    'tVehicleRotationParam,llSetVehicleType,llSetVehicleVectorParam,llShout' +
    ',llSin,llSitTarget,llSleep,llSqrt,llStartAnimation,llStopAnimation,llS' +
    'topHover,llStopLookAt,llStopMoveToTarget,llStopPointAt,llStopSound,llS' +
    'tringLength,llStringToBase64,llSubStringIndex,llTakeControls,llTan,llT' +
    'arget,llTargetOmega,llTargetRemove,llTeleportAgentHome,llToLower,llToU' +
    'pper,llTriggerSound,llTriggerSoundLimited,llUnSit,llVecDist,llVecMag,l' +
    'lVecNorm,llVolumeDetect,llWater,llWhisper,llWind,llXorBase64Strings,MA' +
    'SK_BASE,MASK_EVERYONE,MASK_GROUP,MASK_NEXT,MASK_OWNER,money,moving_end' +
    ',moving_start,no_sensor,not_at_rot_target,not_at_target,NULL_KEY,objec' +
    't_rez,on_rez,PARCEL_MEDIA_COMMAND_AGENT,PARCEL_MEDIA_COMMAND_LOOP,PARC' +
    'EL_MEDIA_COMMAND_PAUSE,PARCEL_MEDIA_COMMAND_PLAY,PARCEL_MEDIA_COMMAND_' +
    'STOP,PARCEL_MEDIA_COMMAND_TEXTURE,PARCEL_MEDIA_COMMAND_TIME,PARCEL_MED' +
    'IA_COMMAND_URL,PASSIVE,PERM_ALL,PERM_COPY,PERM_MODIFY,PERM_MOVE,PERM_T' +
    'RANSFER,PERMISSION_ATTACH,PERMISSION_CHANGE_JOINTS,PERMISSION_CHANGE_L' +
    'INKS,PERMISSION_CHANGE_PERMISSIONS,PERMISSION_DEBIT,PERMISSION_RELEASE' +
    '_OWNERSHIP,PERMISSION_REMAP_CONTROLS,PERMISSION_TAKE_CONTROLS,PERMISSI' +
    'ON_TRIGGER_ANIMATION,PI_BY_TWO,PING_PONG,PRIM_BUMP_BARK,PRIM_BUMP_BLOB' +
    'S,PRIM_BUMP_BRICKS,PRIM_BUMP_BRIGHT,PRIM_BUMP_CHECKER,PRIM_BUMP_CONCRE' +
    'TE,PRIM_BUMP_DARK,PRIM_BUMP_DISKS,PRIM_BUMP_GRAVEL,PRIM_BUMP_LARGETILE' +
    ',PRIM_BUMP_NONE,PRIM_BUMP_SHINY,PRIM_BUMP_SIDING,PRIM_BUMP_STONE,PRIM_' +
    'BUMP_STUCCO,PRIM_BUMP_SUCTION,PRIM_BUMP_TILE,PRIM_BUMP_WEAVE,PRIM_BUMP' +
    '_WOOD,PRIM_COLOR,PRIM_HOLE_CIRCLE,PRIM_HOLE_DEFAULT,PRIM_HOLE_SQUARE,P' +
    'RIM_HOLE_TRIANGLE,PRIM_MATERIAL,PRIM_MATERIAL_FLESH,PRIM_MATERIAL_GLAS' +
    'S,PRIM_MATERIAL_LIGHT,PRIM_MATERIAL_METAL,PRIM_MATERIAL_PLASTIC,PRIM_M' +
    'ATERIAL_RUBBER,PRIM_MATERIAL_STONE,PRIM_MATERIAL_WOOD,PRIM_PHANTOM,PRI' +
    'M_PHYSICS,PRIM_POSITION,PRIM_ROTATION,PRIM_SHINY_HIGH,PRIM_SHINY_LOW,P' +
    'RIM_SHINY_MEDIUM,PRIM_SHINY_NONE,PRIM_SIZE,PRIM_TEMP_ON_REZ,PRIM_TEXTU' +
    'RE,PRIM_TYPE,PRIM_TYPE_BOX,PRIM_TYPE_CYLINDER,PRIM_TYPE_PRISM,PRIM_TYP' +
    'E_RING,PRIM_TYPE_SPHERE,PRIM_TYPE_TORUS,PRIM_TYPE_TUBE,PSYS_PART_BOUNC' +
    'E_MASK,PSYS_PART_EMISSIVE_MASK,PSYS_PART_END_ALPHA,PSYS_PART_END_COLOR' +
    ',PSYS_PART_END_SCALE,PSYS_PART_FLAGS,PSYS_PART_FOLLOW_SRC_MASK,PSYS_PA' +
    'RT_FOLLOW_VELOCITY_MASK,PSYS_PART_INTERP_COLOR_MASK,PSYS_PART_INTERP_S' +
    'CALE_MASK,PSYS_PART_MAX_AGE,PSYS_PART_RANDOM_ACCEL_MASK,PSYS_PART_RAND' +
    'OM_VEL_MASK,PSYS_PART_START_ALPHA,PSYS_PART_START_COLOR,PSYS_PART_STAR' +
    'T_SCALE,PSYS_PART_TARGET_POS_MASK,PSYS_PART_TRAIL_MASK,PSYS_PART_WIND_' +
    'MASK,PSYS_SRC_ACCEL,PSYS_SRC_BURST_PART_COUNT,PSYS_SRC_BURST_RADIUS,PS' +
    'YS_SRC_BURST_RATE,PSYS_SRC_BURST_SPEED_MAX,PSYS_SRC_BURST_SPEED_MIN,PS' +
    'YS_SRC_INNERANGLE,PSYS_SRC_MAX_AGE,PSYS_SRC_OMEGA,PSYS_SRC_OUTERANGLE,' +
    'PSYS_SRC_OUTERANGLEPSYS_SRC_INNERANGLE,PSYS_SRC_PATTERN,PSYS_SRC_PATTE' +
    'RN_ANGLE,PSYS_SRC_PATTERN_ANGLE_CONE,PSYS_SRC_PATTERN_DROP,PSYS_SRC_PA' +
    'TTERN_EXPLODE,PSYS_SRC_TARGET_KEY,PSYS_SRC_TEXTURE,RAD_TO_DEG,remote_d' +
    'ata,REMOTE_DATA_CHANNEL,REMOTE_DATA_REPLY,REMOTE_DATA_REQUEST,return,R' +
    'EVERSE,ROTATE,rotation,run_time_permissions,SCALE,SCRIPTED,sensor,SMOO' +
    'TH,SRC_PATTERN_ANGLE,SRC_PATTERN_ANGLE_CONE,state,state_entry,state_ex' +
    'it,STATUS_BLOCK_GRAB,STATUS_DIE_AT_EDGE,STATUS_PHANTOM,STATUS_PHYSICS,' +
    'STATUS_ROTATE_X,STATUS_ROTATE_Y,STATUS_ROTATE_Z,STATUS_SANDBOX,string,' +
    'timer,touch,touch_end,touch_start,TRUE,TRUEFALSE,TWO_PI,TYPE_FLOAT,TYP' +
    'E_INTEGER,TYPE_INVALID,TYPE_KEY,TYPE_ROTATION,TYPE_STRING,TYPE_VECTOR,' +
    'vector,VEHICLE_ANGULAR_DEFLECTION_EFFICIENCY,VEHICLE_ANGULAR_DEFLECTIO' +
    'N_TIMESCALE,VEHICLE_ANGULAR_FRICTION_TIMESCALE,VEHICLE_ANGULAR_MOTOR_D' +
    'ECAY_TIMESCALE,VEHICLE_ANGULAR_MOTOR_DIRECTION,VEHICLE_ANGULAR_MOTOR_T' +
    'IMESCALE,VEHICLE_BANKING_EFFICIENCY,VEHICLE_BANKING_MIX,VEHICLE_BANKIN' +
    'G_TIMESCALE,VEHICLE_BUOYANCY,VEHICLE_FLAG_CAMERA_DECOUPLED,VEHICLE_FLA' +
    'G_HOVER_GLOBAL_HEIGHT,VEHICLE_FLAG_HOVER_TERRAIN_ONLY,VEHICLE_FLAG_HOV' +
    'ER_UP_ONLY,VEHICLE_FLAG_HOVER_WATER_ONLY,VEHICLE_FLAG_LIMIT_MOTOR_UP,V' +
    'EHICLE_FLAG_LIMIT_ROLL_ONLY,VEHICLE_FLAG_MOUSELOOK_BANK,VEHICLE_FLAG_M' +
    'OUSELOOK_STEER,VEHICLE_FLAG_NO_DEFLECTION_UP,VEHICLE_HOVER_EFFICIENCY,' +
    'VEHICLE_HOVER_HEIGHT,VEHICLE_HOVER_TIMESCALE,VEHICLE_LINEAR_DEFLECTION' +
    '_EFFICIENCY,VEHICLE_LINEAR_DEFLECTION_TIMESCALE,VEHICLE_LINEAR_FRICTIO' +
    'N_TIMESCALE,VEHICLE_LINEAR_MOTOR_DECAY_TIMESCALE,VEHICLE_LINEAR_MOTOR_' +
    'DIRECTION,VEHICLE_LINEAR_MOTOR_OFFSET,VEHICLE_LINEAR_MOTOR_TIMESCALE,V' +
    'EHICLE_REFERENCE_FRAME,VEHICLE_TYPE_AIRPLANE,VEHICLE_TYPE_BALLOON,VEHI' +
    'CLE_TYPE_BOAT,VEHICLE_TYPE_CAR,VEHICLE_TYPE_SLED,VEHICLE_VERTICAL_ATTR' +
    'ACTION_EFFICIENCY,VEHICLE_VERTICAL_ATTRACTION_TIMESCALE,while,ZERO_ROT' +
    'ATION,ZERO_VECTOR';
end;

function TSynHighlighterLSL.GetToken: String;
var
  Len: LongInt;
begin
  Len := Run - fTokenPos;
  SetString(Result, (FLine + fTokenPos), Len);
end;

function TSynHighlighterLSL.GetTokenID: TtkTokenKind;
begin
  Result := fTokenId;
end;

function TSynHighlighterLSL.GetTokenAttribute: TSynHighLighterAttributes;
begin
  case GetTokenID of
    tkComment: Result := fCommentAttri;
    tkIdentifier: Result := fIdentifierAttri;
    tkKey: Result := fKeyAttri;
    tkSpace: Result := fSpaceAttri;
    tkString: Result := fStringAttri;
    tkUnknown: Result := fIdentifierAttri;
    tkFunctions: Result := fFunctionAttri;
  else
    Result := nil;
  end;
end;

function TSynHighlighterLSL.GetTokenKind: integer;
begin
  Result := Ord(fTokenId);
end;

function TSynHighlighterLSL.GetTokenPos: Integer;
begin
  Result := fTokenPos;
end;

function TSynHighlighterLSL.GetIdentChars: TSynIdentChars;
begin
  Result := ['_', 'a'..'z', 'A'..'Z'];
end;

function TSynHighlighterLSL.GetSampleSource: string;
begin
  Result := 'Sample source for: '#13#10 +
            'Syntax Parser/Highlighter';
end;

function TSynHighlighterLSL.IsFilterStored: Boolean;
begin
  Result := fDefaultFilter <> SYNS_FilterLindenScriptingLanguage;
end;

{$IFNDEF SYN_CPPB_1} class {$ENDIF}
function TSynHighlighterLSL.GetLanguageName: string;
begin
  Result := SYNS_LangLindenScriptingLanguage;
end;

procedure TSynHighlighterLSL.ResetRange;
begin
  fRange := rsUnknown;
end;

procedure TSynHighlighterLSL.SetRange(Value: Pointer);
begin
  fRange := TRangeState(Value);
end;

function TSynHighlighterLSL.GetRange: Pointer;
begin
  Result := Pointer(fRange);
end;

procedure TSynHighlighterLSL.SlashProc;
begin
  case FLine[Run + 1] of
    '/':                               {c++ style comments}
      begin
        inc(Run, 2);
        fTokenID := tkComment;
        while FLine[Run] <> #0 do
        begin
          case FLine[Run] of
            #10, #13: break;
          end;
          inc(Run);
        end;
      end;
  end;
end;

initialization
  MakeIdentTable;
{$IFNDEF SYN_CPPB_1}
  RegisterPlaceableHighlighter(TSynHighlighterLSL);
{$ENDIF}
end.
