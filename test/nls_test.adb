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

with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Strings;           use Ada.Strings;
with Ada.Strings.Fixed;     use Ada.Strings.Fixed;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Interfaces.C;          use Interfaces.C;
with Interfaces.C.Strings;  use Interfaces.C.Strings;

with L10n;                  use L10n;
with I18n;                  use I18n;

procedure NLS_Test is
   Lconv : Lconv_Access;

   function Print_Grouping (Grouping : chars_ptr) return String is
      S : String := Value (Grouping);
      U : Unbounded_String := Null_Unbounded_String;
      P : Integer;

   begin
      for I in S'Range loop
         P := Character'Pos (S (I));
         U := U & P'Img;
      end loop;

      return To_String (U);
   end Print_Grouping;

begin
   Set_Locale;
--     Bind_Text_Domain ("nls_test", "");
   Text_Domain ("nls_test");
   Set_Locale (Locale => "uk_UA.UTF-8");
   Put_Line (-"Current locale : " & Get_Locale);
   Lconv := Localeconv;
   Put_Line (-"Int'l currency symbol : " & Value (Lconv.Int_Curr_Symbol));
   Put_Line (-"Local currency symbol : " & Value (Lconv.Currency_Symbol));
   Put_Line (-"Int'l fraction digits : " & Lconv.Int_Frac_Digits'Img);
   Put_Line (-"Local fraction digits : " & Lconv.Frac_Digits'Img);
   Put_Line (-"Decimal Point : '" & Value (Lconv.Decimal_Point) & "'");
   Put_Line (-"Thousands separator : '" & Value (Lconv.Thousands_Sep) & "'");
   Put_Line (-"Grouping format : " & Print_Grouping (Lconv.Grouping));
end NLS_Test;
