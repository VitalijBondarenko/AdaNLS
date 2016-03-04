------------------------------------------------------------------------------
--                                                                          --
-- Copyright (c) 2014-2015 Vitalij Bondarenko <vibondare@gmail.com>         --
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
     (CODESET,
      --  String with the name of the coded character set used in the selected
      --  locale.

      RADIXCHAR,
      --  Radix character (decimal point).
      --  The same as the value returned by Localeconv in the Decimal_Point
      --  element of the Lconv_Record.

      THOUSEP,
      --  Separator for thousands.
      --  The same as the value returned by Localeconv in the Thousands_Sep
      --  element of the Lconv_Record.

      ABDAY_1,
      ABDAY_2,
      ABDAY_3,
      ABDAY_4,
      ABDAY_5,
      ABDAY_6,
      ABDAY_7,
      --  ABDAY_{1-7} is abbreviated weekday names.
      --  ABDAY_1 corresponds to Sunday.

      DAY_1,
      DAY_2,
      DAY_3,
      DAY_4,
      DAY_5,
      DAY_6,
      DAY_7,
      --  DAY_{1-7} is full weekday names.
      --  DAY_1 corresponds to Sunday.

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

      AM_STR,
      PM_STR,
      --  Strings with appropriate ante-meridiem/post-meridiem affix.
      --  NOTE that in locales which do not use this time representation these
      --  strings might be empty, in which case the am/pm format cannot be
      --  used at all.

      D_T_FMT,
      --  Value can be used as a format string for represent time and date in
      --  a locale-specific way.

      D_FMT,
      --  Value can be used as a format string for represent date in a
      --  locale-specific way.

      T_FMT,
      --  Value can be used as a format string for represent time in a
      --  locale-specific way.

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

      CRNCYSTR,
      --  Local currency symbol, preceded by '-' if the symbol should appear
      --  before the value, '+' if the symbol should appear after the value,
      --  or '.' if the symbol should replace the radix character. If the local
      --  currency symbol is the empty string, implementations may return the
      --  empty string.

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

   for Locale_Item use
     (CODESET            => 16#0000E#,

      RADIXCHAR          => 16#10000#,
      THOUSEP            => 16#10001#,

      ABDAY_1            => 16#20000#,
      ABDAY_2            => 16#20001#,
      ABDAY_3            => 16#20002#,
      ABDAY_4            => 16#20003#,
      ABDAY_5            => 16#20004#,
      ABDAY_6            => 16#20005#,
      ABDAY_7            => 16#20006#,

      DAY_1              => 16#20007#,
      DAY_2              => 16#20008#,
      DAY_3              => 16#20009#,
      DAY_4              => 16#2000A#,
      DAY_5              => 16#2000B#,
      DAY_6              => 16#2000C#,
      DAY_7              => 16#2000D#,

      ABMON_1            => 16#2000E#,
      ABMON_2            => 16#2000F#,
      ABMON_3            => 16#20010#,
      ABMON_4            => 16#20011#,
      ABMON_5            => 16#20012#,
      ABMON_6            => 16#20013#,
      ABMON_7            => 16#20014#,
      ABMON_8            => 16#20015#,
      ABMON_9            => 16#20016#,
      ABMON_10           => 16#20017#,
      ABMON_11           => 16#20018#,
      ABMON_12           => 16#20019#,

      MON_1              => 16#2001A#,
      MON_2              => 16#2001B#,
      MON_3              => 16#2001C#,
      MON_4              => 16#2001D#,
      MON_5              => 16#2001E#,
      MON_6              => 16#2001F#,
      MON_7              => 16#20020#,
      MON_8              => 16#20021#,
      MON_9              => 16#20022#,
      MON_10             => 16#20023#,
      MON_11             => 16#20024#,
      MON_12             => 16#20025#,

      AM_STR             => 16#20026#,
      PM_STR             => 16#20027#,

      D_T_FMT            => 16#20028#,
      D_FMT              => 16#20029#,
      T_FMT              => 16#2002A#,
      T_FMT_AMPM         => 16#2002B#,

      ERA                => 16#2002C#,
      ERA_D_FMT          => 16#2002E#,
      ALT_DIGITS         => 16#2002F#,
      ERA_D_T_FMT        => 16#20030#,
      ERA_T_FMT          => 16#20031#,

      CRNCYSTR           => 16#4000F#,

      YESEXPR            => 16#50000#,
      NOEXPR             => 16#50001#);

end L10n.Langinfo;
