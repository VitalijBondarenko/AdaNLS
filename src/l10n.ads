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

--  The functions to setup locale and access the information for the locale.

with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package L10n is
   pragma Preelaborate;

   type Locale_Category is new Integer;

   --  The table of locale categories.
   --  The categories after LC_ALL in the table are GNU extensions.
   LC_CTYPE          : constant Locale_Category := 0;
   LC_NUMERIC        : constant Locale_Category := 1;
   LC_TIME           : constant Locale_Category := 2;
   LC_COLLATE        : constant Locale_Category := 3;
   LC_MONETARY       : constant Locale_Category := 4;
   LC_MESSAGES       : constant Locale_Category := 5;
   LC_ALL            : constant Locale_Category := 6;
   LC_PAPER          : constant Locale_Category := 7;
   LC_NAME           : constant Locale_Category := 8;
   LC_ADDRESS        : constant Locale_Category := 9;
   LC_TELEPHONE      : constant Locale_Category := 10;
   LC_MEASUREMENT    : constant Locale_Category := 11;
   LC_IDENTIFICATION : constant Locale_Category := 12;

   --  The record whose components contain information about how numeric and
   --  monetary values should be formatted in the current locale.
   type Lconv_Record is record
      --  Numeric (non-monetary) information.
      ---------------------------------------

      -- Decimal point character.
      Decimal_Point      : chars_ptr;

      --  Thousands separator.
      Thousands_Sep      : chars_ptr;

      --  Each element is the number of digits in each group;
      --  elements with higher indices are farther left.
      --  An element with value CHAR_MAX means that no further grouping is done.
      --  An element with value 0 means that the previous element is used
      --  for all groups farther left.
      Grouping           : chars_ptr;

      --  Monetary information.
      -------------------------

      --  The international currency symbol for the selected locale.
      --  First three chars are a currency symbol from ISO 4217.
      --  Fourth char is the separator.  Fifth char is '\0'.
      Int_Curr_Symbol    : chars_ptr;

      --  Local currency symbol.
      Currency_Symbol    : chars_ptr;

      --  Decimal point character.
      Mon_Decimal_Point  : chars_ptr;

      --  Thousands separator.
      Mon_Thousands_Sep  : chars_ptr;

      --  Each element is the number of digits in each group;
      --  elements with higher indices are farther left.
      --  An element with value CHAR_MAX means that no further grouping is done.
      --  An element with value 0 means that the previous element is used
      --  for all groups farther left.
      Mon_Grouping       : chars_ptr;

      --  Sign for positive values.
      Positive_Sign      : chars_ptr;

      --  Sign for negative values.
      Negative_Sign      : chars_ptr;

      --  Int'l fractional digits.
      Int_Frac_Digits    : unsigned_char;

      --  Local fractional digits.
      Frac_Digits        : unsigned_char;

      --  1 if currency_symbol precedes a positive value, 0 if succeeds.
      P_Cs_Precedes      : unsigned_char;

      --  1 if a space separates currency_symbol from a positive value.
      P_Sep_By_Space     : unsigned_char;

      --  1 if currency_symbol precedes a negative value, 0 if succeeds.
      N_Cs_Precedes      : unsigned_char;

      --  1 if a space separates currency_symbol from a negative value.
      N_Sep_By_Space     : unsigned_char;

      --  Positive and negative sign positions:
      --  0 Parentheses surround the quantity and currency_symbol.
      --  1 The sign string precedes the quantity and currency_symbol.
      --  2 The sign string follows the quantity and currency_symbol.
      --  3 The sign string immediately precedes the currency_symbol.
      --  4 The sign string immediately follows the currency_symbol.
      P_Sign_Posn        : unsigned_char;
      N_Sign_Posn        : unsigned_char;

      --  1 if int_curr_symbol precedes a positive value, 0 if succeeds.
      Int_P_Cs_Precedes  : unsigned_char;

      --  1 if a space separates int_curr_symbol from a positive value.
      Int_P_Sep_By_Space : unsigned_char;

      --  1 if int_curr_symbol precedes a negative value, 0 if succeeds.
      Int_N_Cs_Precedes  : unsigned_char;

      --  1 if a space separates int_curr_symbol from a negative value.
      Int_N_Sep_By_Space : unsigned_char;

      --  Positive and negative sign positions:
      --  0 Parentheses surround the quantity and int_curr_symbol.
      --  1 The sign string precedes the quantity and int_curr_symbol.
      --  2 The sign string follows the quantity and int_curr_symbol.
      --  3 The sign string immediately precedes the int_curr_symbol.
      --  4 The sign string immediately follows the int_curr_symbol.
      Int_P_Sign_Posn    : unsigned_char;
      Int_N_Sign_Posn    : unsigned_char;
   end record;
   pragma Convention (C, Lconv_Record);
   type Lconv_Access is access all Lconv_Record;

   procedure Set_Locale
     (Category : Locale_Category := LC_ALL; Locale : String := "");
   --  Sets the current locale for category Category to Locale.
   --  If you specify an empty string for Locale, this means to read the
   --  appropriate environment variable and use its value to select the locale
   --  for Category.
   --  If you specify an invalid locale name, Set_Locale leaves the current
   --  locale unchanged.
   --
   --  This procedure without parameters must be called before any other
   --  subprogram in this package. It will initialize internal variables based
   --  on the environment variables.

   function Get_Locale (Category : Locale_Category := LC_ALL) return String;
   --  Returns the name of the current locale.

   function Localeconv return Lconv_Access;
   --  Returns a record whose components contain information about how numeric
   --  and monetary values should be formatted in the current locale.

private

   pragma Import (C, Localeconv, "localeconv");

end L10n;
