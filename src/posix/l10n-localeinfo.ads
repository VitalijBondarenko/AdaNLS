------------------------------------------------------------------------------
--                                                                          --
-- Copyright (c) 2014-2017 Vitalij Bondarenko <vibondare@gmail.com>         --
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

--  The functions to access the information for the locale.

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Interfaces.C;          use Interfaces.C;
with Interfaces.C.Strings;  use Interfaces.C.Strings;

package L10n.Localeinfo is

   --  The record whose components contain information about how numeric and
   --  monetary values should be formatted in the current locale.
   type Lconv_Record is record

      --  Numeric (non-monetary) information.
      ---------------------------------------

      Decimal_Point      : Unbounded_String;
      -- The radix character used to format non-monetary quantities.

      Thousands_Sep      : Unbounded_String;
      --  The character used to separate groups of digits before the
      --  decimal-point character in formatted non-monetary quantities.

      Grouping           : Unbounded_String;
      --  A string whose elements taken as one-byte integer values indicate the
      --  size of each group of digits in formatted non-monetary quantities.
      --  Use either Thousands_Sep to separate the digit groups.
      --  Each element is the number of digits in each group;
      --  elements with higher indices are farther left.
      --  An element with value Interfaces.C.UCHAR_MAX means that no further
      --  grouping is done.
      --  An element with value 0 means that the previous element is used
      --  for all groups farther left.

      --  Monetary information.
      -------------------------

      Int_Curr_Symbol    : Unbounded_String;
      --  The international currency symbol applicable to the current locale.
      --  The first three characters contain the alphabetic international
      --  currency symbol in accordance with those specified in the
      --  ISO 4217:1995 standard. The fourth character (immediately preceding
      --  the null byte) is the character used to separate the international
      --  currency symbol from the monetary quantity.

      Currency_Symbol    : Unbounded_String;
      --  The local currency symbol applicable to the current locale.

      Mon_Decimal_Point  : Unbounded_String;
      --  The radix character used to format monetary quantities.

      Mon_Thousands_Sep  : Unbounded_String;
      --  The separator for groups of digits before the decimal-point in
      --  formatted monetary quantities.

      Mon_Grouping       : Unbounded_String;
      --  A string whose elements taken as one-byte integer values indicate the
      --  size of each group of digits in formatted monetary quantities.
      --  Use either Mon_Thousands_Sep to separate the digit groups.
      --  Each element is the number of digits in each group;
      --  elements with higher indices are farther left.
      --  An element with value Interfaces.C.UCHAR_MAX means that no further
      --  grouping is done.
      --  An element with value 0 means that the previous element is used
      --  for all groups farther left.

      Positive_Sign      : Unbounded_String;
      --  The string used to indicate a non-negative valued formatted monetary
      --  quantity.

      Negative_Sign      : Unbounded_String;
      --  The string used to indicate a negative valued formatted monetary
      --  quantity.

      Int_Frac_Digits    : Natural;
      --  The number of fractional digits (those after the decimal-point) to be
      --  displayed in an internationally formatted monetary quantity.

      Frac_Digits        : Natural;
      --  The number of fractional digits (those after the decimal-point) to be
      --  displayed in a formatted monetary quantity.

      P_Cs_Precedes      : Natural;
      --  Set to 1 if the Currency_Symbol precedes the value for a non-negative
      --  formatted monetary quantity.
      --  Set to 0 if the symbol succeeds the value.

      P_Sep_By_Space     : Natural;
      --  Set to a value indicating the separation of the Currency_Symbol, the
      --  sign string, and the value for a non-negative formatted monetary
      --  quantity.
      --  0 No space separates the currency symbol and value.
      --  1 If the currency symbol and sign string are adjacent, a space
      --    separates them from the value; otherwise, a space separates the
      --    currency symbol from the value.
      --  2 If the currency symbol and sign string are adjacent, a space
      --    separates them; otherwise, a space separates the sign string from
      --    the value.

      N_Cs_Precedes      : Natural;
      --  Set to 1 if the Currency_Symbol precedes the value for a negative
      --  formatted monetary quantity. Set to 0 if the symbol succeeds the
      --  value.

      N_Sep_By_Space     : Natural;
      --  Set to a value indicating the separation of the Currency_Symbol, the
      --  sign string, and the value for a negative formatted monetary quantity.
      --  0 No space separates the currency symbol and value.
      --  1 If the currency symbol and sign string are adjacent, a space
      --    separates them from the value; otherwise, a space separates the
      --    currency symbol from the value.
      --  2 If the currency symbol and sign string are adjacent, a space
      --    separates them; otherwise, a space separates the sign string from
      --    the value.

      P_Sign_Posn        : Natural;
      --  Set to a value indicating the positioning of the Positive_Sign for a
      --  non-negative formatted monetary quantity.
      --  0 Parentheses surround the quantity and Currency_Symbol.
      --  1 The sign string precedes the quantity and Currency_Symbol.
      --  2 The sign string follows the quantity and Currency_Symbol.
      --  3 The sign string immediately precedes the Currency_Symbol.
      --  4 The sign string immediately follows the Currency_Symbol.

      N_Sign_Posn        : Natural;
      --  Set to a value indicating the positioning of the negative_sign for a
      --  negative formatted monetary quantity.
      --  0 Parentheses surround the quantity and Currency_Symbol.
      --  1 The sign string precedes the quantity and Currency_Symbol.
      --  2 The sign string follows the quantity and Currency_Symbol.
      --  3 The sign string immediately precedes the Currency_Symbol.
      --  4 The sign string immediately follows the Currency_Symbol.
--
      Int_P_Cs_Precedes  : Natural;
      --  Set to 1 or 0 if the Int_Curr_Symbol respectively precedes or
      --  succeeds the value for a non-negative internationally formatted
      --  monetary quantity.

      Int_P_Sep_By_Space : Natural;
      --  Set to a value indicating the separation of the Int_Curr_Symbol, the
      --  sign string, and the value for a negative internationally formatted
      --  monetary quantity.
      --  0 No space separates the currency symbol and value.
      --  1 If the currency symbol and sign string are adjacent, a space
      --    separates them from the value; otherwise, a space separates the
      --    currency symbol from the value.
      --  2 If the currency symbol and sign string are adjacent, a space
      --    separates them; otherwise, a space separates the sign string from
      --    the value.

      Int_N_Cs_Precedes  : Natural;
      --  Set to 1 or 0 if the Int_Curr_Symbol respectively precedes or
      --  succeeds the value for a negative internationally formatted monetary
      --  quantity.

      Int_N_Sep_By_Space : Natural;
      --  Set to a value indicating the separation of the Int_Curr_Symbol, the
      --  sign string, and the value for a negative internationally formatted
      --  monetary quantity.
      --  0 No space separates the currency symbol and value.
      --  1 If the currency symbol and sign string are adjacent, a space
      --    separates them from the value; otherwise, a space separates the
      --    currency symbol from the value.
      --  2 If the currency symbol and sign string are adjacent, a space
      --    separates them; otherwise, a space separates the sign string from
      --    the value.

      Int_P_Sign_Posn    : Natural;
      --  Set to a value indicating the positioning of the Positive_Sign for a
      --  non-negative internationally formatted monetary quantity.
      --  0 Parentheses surround the quantity and Int_Curr_Symbol.
      --  1 The sign string precedes the quantity and Int_Curr_Symbol.
      --  2 The sign string follows the quantity and Int_Curr_Symbol.
      --  3 The sign string immediately precedes the Int_Curr_Symbol.
      --  4 The sign string immediately follows the Int_Curr_Symbol.

      Int_N_Sign_Posn    : Natural;
      --  Set to a value indicating the positioning of the Negative_Sign for a
      --  negative internationally formatted monetary quantity.
      --  0 Parentheses surround the quantity and Int_Curr_Symbol.
      --  1 The sign string precedes the quantity and Int_Curr_Symbol.
      --  2 The sign string follows the quantity and Int_Curr_Symbol.
      --  3 The sign string immediately precedes the Int_Curr_Symbol.
      --  4 The sign string immediately follows the Int_Curr_Symbol.
   end record;

   type Lconv_Access is access all Lconv_Record;

   function Localeconv return Lconv_Access;
   --  Returns a record whose components contain information about how numeric
   --  and monetary values should be formatted in the current locale.

   --  Localeinfo in C-types
   --
   --  The record whose components contain information about how numeric and
   --  monetary values should be formatted in the current locale.
   type C_Lconv_Record is record
      Decimal_Point      : chars_ptr;
      Thousands_Sep      : chars_ptr;
      Grouping           : chars_ptr;
      Int_Curr_Symbol    : chars_ptr;
      Currency_Symbol    : chars_ptr;
      Mon_Decimal_Point  : chars_ptr;
      Mon_Thousands_Sep  : chars_ptr;
      Mon_Grouping       : chars_ptr;
      Positive_Sign      : chars_ptr;
      Negative_Sign      : chars_ptr;
      Int_Frac_Digits    : unsigned_char;
      Frac_Digits        : unsigned_char;
      P_Cs_Precedes      : unsigned_char;
      P_Sep_By_Space     : unsigned_char;
      N_Cs_Precedes      : unsigned_char;
      N_Sep_By_Space     : unsigned_char;
      P_Sign_Posn        : unsigned_char;
      N_Sign_Posn        : unsigned_char;
      Int_P_Cs_Precedes  : unsigned_char;
      Int_P_Sep_By_Space : unsigned_char;
      Int_N_Cs_Precedes  : unsigned_char;
      Int_N_Sep_By_Space : unsigned_char;
      Int_P_Sign_Posn    : unsigned_char;
      Int_N_Sign_Posn    : unsigned_char;
   end record;
   pragma Convention (C, C_Lconv_Record);

   type C_Lconv_Access is access all C_Lconv_Record;

   function C_Localeconv return C_Lconv_Access;
   pragma Import (C, C_Localeconv, "localeconv");

end L10n.Localeinfo;
