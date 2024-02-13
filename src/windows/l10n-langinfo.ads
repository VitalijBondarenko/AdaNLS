------------------------------------------------------------------------------
--                                                                          --
-- Copyright (c) 2014-2022 Vitalii Bondarenko <vibondare@gmail.com>         --
--                                                                          --
------------------------------------------------------------------------------
--                                                                          --
-- The MIT License (MIT)                                                    --
--                                                                          --
-- Permission is hereby granted, free of charge, to any person obtaining a  --
-- copy of this software and associated documentation files (the            --
-- "Software"), to deal in the Software without restriction, including      --
-- without limitation the rights to use, copy, modify, merge, publish,      --
-- distribute, sublicense, and/or sell copies of the Software, and to       --
-- permit persons to whom the Software is furnished to do so, subject to    --
-- the following conditions:                                                --
--                                                                          --
-- The above copyright notice and this permission notice shall be included  --
-- in all copies or substantial portions of the Software.                   --
--                                                                          --
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS  --
-- OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF               --
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.   --
-- IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY     --
-- CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,     --
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE        --
-- SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                   --
------------------------------------------------------------------------------

--  X/Open’s nl_langinfo.

with Interfaces; use Interfaces;

package L10n.Langinfo is

   type Locale_Item is
     (RADIXCHAR,
      --  Radix character (decimal point).
      --  The same as the value returned by Localeconv in the Decimal_Point
      --  element of the Lconv_Record.

      THOUSEP,
      --  Separator for thousands.
      --  The same as the value returned by Localeconv in the Thousands_Sep
      --  element of the Lconv_Record.

      CRNCYSTR,
      --  Local currency symbol, preceded by '-' if the symbol should appear
      --  before the value, '+' if the symbol should appear after the value,
      --  or '.' if the symbol should replace the radix character. If the local
      --  currency symbol is the empty string, implementations may return the
      --  empty string.

      D_FMT,
      --  Value can be used as a format string for represent date in a
      --  locale-specific way.

      AM_STR,
      PM_STR,
      --  Strings with appropriate ante-meridiem/post-meridiem affix.
      --  NOTE that in locales which do not use this time representation these
      --  strings might be empty, in which case the am/pm format cannot be
      --  used at all.

      DAY_1,
      DAY_2,
      DAY_3,
      DAY_4,
      DAY_5,
      DAY_6,
      DAY_7,
      --  DAY_{1-7} is full weekday names.
      --  DAY_1 corresponds to Sunday.

      ABDAY_1,
      ABDAY_2,
      ABDAY_3,
      ABDAY_4,
      ABDAY_5,
      ABDAY_6,
      ABDAY_7,
      --  ABDAY_{1-7} is abbreviated weekday names.
      --  ABDAY_1 corresponds to Sunday.

      MON_1,
      MON_2,
      MON_3,
      MON_4,
      MON_5,
      MON_6,
      MON_7,
      MON_8,
      MON_9,
      MON_10,
      MON_11,
      MON_12,
      --  MON_{1-12} is full month names.
      --  MON_1 corresponds to January.

      ABMON_1,
      ABMON_2,
      ABMON_3,
      ABMON_4,
      ABMON_5,
      ABMON_6,
      ABMON_7,
      ABMON_8,
      ABMON_9,
      ABMON_10,
      ABMON_11,
      ABMON_12,
      --  ABMON_{1-12} is abbreviated month names.
      --  ABMON_1 corresponds to January.

      T_FMT,
      --  Value can be used as a format string for represent time in a
      --  locale-specific way.

      CODESET,
      --  String with the name of the coded character set used in the selected
      --  locale.

      D_T_FMT,
      --  Value can be used as a format string for represent time and date in
      --  a locale-specific way.

      T_FMT_AMPM,
      --  Value can be used as a format string for represent time in the
      --  12-hour clock format with AM_STR and PM_STR.
      --  NOTE that if the am/pm format does not make any sense for the
      --  selected locale, the return value might be the same as the one for
      --  T_FMT.

      ERA,
      --  Value represents the era used in the current locale. Most locales do
      --  not define this value. Normally it should not be necessary to use
      --  this value directly.

      ERA_YEAR,
      --  The return value gives the year in the relevant era of the locale.
      --   As for ERA it should not be necessary to use this value directly.

      ERA_D_FMT,
      --  Value can be used as a format string for represent a date in a
      --  locale-specific era-based way.

      ALT_DIGITS,
      --  Value is a representation of up to 100 values used to represent the
      --  values 0 to 99. As for ERA this value is not intended to be used
      --  directly.

      ERA_D_T_FMT,
      --  Value can be used as a format string for represent dates and times in
      --  a locale-specific era-based way.

      ERA_T_FMT,
      --  Value can be used as a format string for represent time in a
      --  locale-specific era-based way.

      ALTMON_1,
      ALTMON_2,
      ALTMON_3,
      ALTMON_4,
      ALTMON_5,
      ALTMON_6,
      ALTMON_7,
      ALTMON_8,
      ALTMON_9,
      ALTMON_10,
      ALTMON_11,
      ALTMON_12,
      --  Long month names, in the grammatical form used when the month
      --  is named by itself. ALTMON_1 corresponds to January.

      YESEXPR,
      --  Regular expression which can be used to recognize a positive response
      --  to a yes/no question.

      NOEXPR
      --  Regular expression which can be used to recognize a negative response
      --  to a yes/no question.
     );
   pragma Convention (C, Locale_Item);
   --   Enumeration of locale items that can be queried with 'Nl_Langinfo'.

   function Nl_Langinfo (Item : Locale_Item) return String;
   --  The function shall return a string containing information relevant to
   --  the particular language or cultural area defined in the current locale.

private
   LOCALE_SDECIMAL             : constant := 16#000e#;
   LOCALE_STHOUSAND            : constant := 16#000f#;
   LOCALE_SGROUPING            : constant := 16#0010#;
   LOCALE_SCURRENCY            : constant := 16#0014#;
   LOCALE_SMONDECIMALSEP       : constant := 16#0016#;
   LOCALE_SMONTHOUSANDSEP      : constant := 16#0017#;
   LOCALE_SMONGROUPING         : constant := 16#0018#;
   LOCALE_SDATE                : constant := 16#001d#;
   LOCALE_STIME                : constant := 16#001e#;
   LOCALE_SSHORTDATE           : constant := 16#001f#;
   LOCALE_SLONGDATE            : constant := 16#0020#;
   LOCALE_S1159                : constant := 16#0028#;
   LOCALE_S2359                : constant := 16#0029#;
   LOCALE_SDAYNAME1            : constant := 16#002a#;
   LOCALE_SDAYNAME2            : constant := 16#002b#;
   LOCALE_SDAYNAME3            : constant := 16#002c#;
   LOCALE_SDAYNAME4            : constant := 16#002d#;
   LOCALE_SDAYNAME5            : constant := 16#002e#;
   LOCALE_SDAYNAME6            : constant := 16#002f#;
   LOCALE_SDAYNAME7            : constant := 16#0030#;
   LOCALE_SABBREVDAYNAME1      : constant := 16#0031#;
   LOCALE_SABBREVDAYNAME2      : constant := 16#0032#;
   LOCALE_SABBREVDAYNAME3      : constant := 16#0033#;
   LOCALE_SABBREVDAYNAME4      : constant := 16#0034#;
   LOCALE_SABBREVDAYNAME5      : constant := 16#0035#;
   LOCALE_SABBREVDAYNAME6      : constant := 16#0036#;
   LOCALE_SABBREVDAYNAME7      : constant := 16#0037#;
   LOCALE_SMONTHNAME1          : constant := 16#0038#;
   LOCALE_SMONTHNAME2          : constant := 16#0039#;
   LOCALE_SMONTHNAME3          : constant := 16#003a#;
   LOCALE_SMONTHNAME4          : constant := 16#003b#;
   LOCALE_SMONTHNAME5          : constant := 16#003c#;
   LOCALE_SMONTHNAME6          : constant := 16#003d#;
   LOCALE_SMONTHNAME7          : constant := 16#003e#;
   LOCALE_SMONTHNAME8          : constant := 16#003f#;
   LOCALE_SMONTHNAME9          : constant := 16#0040#;
   LOCALE_SMONTHNAME10         : constant := 16#0041#;
   LOCALE_SMONTHNAME11         : constant := 16#0042#;
   LOCALE_SMONTHNAME12         : constant := 16#0043#;
   LOCALE_SABBREVMONTHNAME1    : constant := 16#0044#;
   LOCALE_SABBREVMONTHNAME2    : constant := 16#0045#;
   LOCALE_SABBREVMONTHNAME3    : constant := 16#0046#;
   LOCALE_SABBREVMONTHNAME4    : constant := 16#0047#;
   LOCALE_SABBREVMONTHNAME5    : constant := 16#0048#;
   LOCALE_SABBREVMONTHNAME6    : constant := 16#0049#;
   LOCALE_SABBREVMONTHNAME7    : constant := 16#004a#;
   LOCALE_SABBREVMONTHNAME8    : constant := 16#004b#;
   LOCALE_SABBREVMONTHNAME9    : constant := 16#004c#;
   LOCALE_SABBREVMONTHNAME10   : constant := 16#004d#;
   LOCALE_SABBREVMONTHNAME11   : constant := 16#004e#;
   LOCALE_SABBREVMONTHNAME12   : constant := 16#004f#;
   LOCALE_STIMEFORMAT          : constant := 16#1003#;
   LOCALE_IDEFAULTANSICODEPAGE : constant := 16#1004#;

   for Locale_Item use
     (RADIXCHAR   => LOCALE_SDECIMAL,
      THOUSEP     => LOCALE_STHOUSAND,
      CRNCYSTR    => LOCALE_SCURRENCY,

      D_FMT       => LOCALE_SSHORTDATE,
      AM_STR      => LOCALE_S1159,
      PM_STR      => LOCALE_S2359,

      DAY_1       => LOCALE_SDAYNAME1,
      DAY_2       => LOCALE_SDAYNAME2,
      DAY_3       => LOCALE_SDAYNAME3,
      DAY_4       => LOCALE_SDAYNAME4,
      DAY_5       => LOCALE_SDAYNAME5,
      DAY_6       => LOCALE_SDAYNAME6,
      DAY_7       => LOCALE_SDAYNAME7,

      ABDAY_1     => LOCALE_SABBREVDAYNAME1,
      ABDAY_2     => LOCALE_SABBREVDAYNAME2,
      ABDAY_3     => LOCALE_SABBREVDAYNAME3,
      ABDAY_4     => LOCALE_SABBREVDAYNAME4,
      ABDAY_5     => LOCALE_SABBREVDAYNAME5,
      ABDAY_6     => LOCALE_SABBREVDAYNAME6,
      ABDAY_7     => LOCALE_SABBREVDAYNAME7,

      MON_1       => LOCALE_SMONTHNAME1,
      MON_2       => LOCALE_SMONTHNAME2,
      MON_3       => LOCALE_SMONTHNAME3,
      MON_4       => LOCALE_SMONTHNAME4,
      MON_5       => LOCALE_SMONTHNAME5,
      MON_6       => LOCALE_SMONTHNAME6,
      MON_7       => LOCALE_SMONTHNAME7,
      MON_8       => LOCALE_SMONTHNAME8,
      MON_9       => LOCALE_SMONTHNAME9,
      MON_10      => LOCALE_SMONTHNAME10,
      MON_11      => LOCALE_SMONTHNAME11,
      MON_12      => LOCALE_SMONTHNAME12,

      ABMON_1     => LOCALE_SABBREVMONTHNAME1,
      ABMON_2     => LOCALE_SABBREVMONTHNAME2,
      ABMON_3     => LOCALE_SABBREVMONTHNAME3,
      ABMON_4     => LOCALE_SABBREVMONTHNAME4,
      ABMON_5     => LOCALE_SABBREVMONTHNAME5,
      ABMON_6     => LOCALE_SABBREVMONTHNAME6,
      ABMON_7     => LOCALE_SABBREVMONTHNAME7,
      ABMON_8     => LOCALE_SABBREVMONTHNAME8,
      ABMON_9     => LOCALE_SABBREVMONTHNAME9,
      ABMON_10    => LOCALE_SABBREVMONTHNAME10,
      ABMON_11    => LOCALE_SABBREVMONTHNAME11,
      ABMON_12    => LOCALE_SABBREVMONTHNAME12,

      T_FMT       => LOCALE_STIMEFORMAT,
      CODESET     => LOCALE_IDEFAULTANSICODEPAGE,
      D_T_FMT     => 16#20028#,
      T_FMT_AMPM  => 16#2002B#,

      ERA         => 16#2002C#,
      ERA_YEAR    => 16#2002D#,
      ERA_D_FMT   => 16#2002E#,
      ALT_DIGITS  => 16#2002F#,
      ERA_D_T_FMT => 16#20030#,
      ERA_T_FMT   => 16#20031#,

      ALTMON_1    => 16#2006F#,
      ALTMON_2    => 16#20070#,
      ALTMON_3    => 16#20071#,
      ALTMON_4    => 16#20072#,
      ALTMON_5    => 16#20073#,
      ALTMON_6    => 16#20074#,
      ALTMON_7    => 16#20075#,
      ALTMON_8    => 16#20076#,
      ALTMON_9    => 16#20077#,
      ALTMON_10   => 16#20078#,
      ALTMON_11   => 16#20079#,
      ALTMON_12   => 16#2007A#,

      YESEXPR     => 16#50000#,
      NOEXPR      => 16#50001#);

end L10n.Langinfo;
