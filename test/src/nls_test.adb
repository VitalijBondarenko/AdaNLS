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

with Ada.Text_IO;                   use Ada.Text_IO;
with Ada.Strings;                   use Ada.Strings;
with Ada.Strings.Fixed;             use Ada.Strings.Fixed;
with Ada.Strings.Unbounded;         use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Interfaces.C;                  use Interfaces.C;
with Interfaces.C.Strings;          use Interfaces.C.Strings;

with L10n;                          use L10n;
with L10n.Langinfo;                 use L10n.Langinfo;
with L10n.Localeinfo;               use L10n.Localeinfo;
with I18n;                          use I18n;

procedure NLS_Test is

   package Enum_IO is new Ada.Text_IO.Enumeration_IO (Locale_Item);

   -----------------
   -- Print_Lconv --
   -----------------

   procedure Print_Lconv is
      Lconv : Lconv_Access;
   begin
      Lconv := Localeconv;
      Put_Line ("Localeconv Result");
      Put_Line ("-----------------");
      Put_Line (-"Decimal Point : '" & Lconv.Decimal_Point & "'");
      Put_Line (-"Thousands Separator : '" & Lconv.Thousands_Sep & "'");
      Put_Line (-"Grouping Format : '" & Lconv.Grouping & "'");
      Put_Line (-"Int'l Currency Symbol : '" & Lconv.Int_Curr_Symbol & "'");
      Put_Line (-"Local Currency Symbol : '" & Lconv.Currency_Symbol & "'");
      Put_Line (-"Monetary Decimal Point : '" & Lconv.Mon_Decimal_Point & "'");
      Put_Line (-"Monetary Thousands Separator : '" & Lconv.Mon_Thousands_Sep & "'");
      Put_Line (-"Monetary Grouping Format : '" & Lconv.Mon_Grouping & "'");
      Put_Line (-"Positive Sign : '" & Lconv.Positive_Sign & "'");
      Put_Line (-"Negative Sign : '" & Lconv.Negative_Sign & "'");
      Put_Line (-"Int'l Fraction Digits : '" & Lconv.Int_Frac_Digits'Img & "'");
      Put_Line (-"Local Fraction Digits : '" & Lconv.Frac_Digits'Img & "'");
      Put_Line (-"P_Cs_Precedes : '" & Lconv.P_Cs_Precedes'Img & "'");
      Put_Line (-"P_Sep_By_Space : '" & Lconv.P_Sep_By_Space'Img & "'");
      Put_Line (-"N_Cs_Precedes : '" & Lconv.N_Cs_Precedes'Img & "'");
      Put_Line (-"N_Sep_By_Space : '" & Lconv.N_Sep_By_Space'Img & "'");
      Put_Line (-"Positive sign positions : '" & Lconv.P_Sign_Posn'Img & "'");
      Put_Line (-"Negative sign positions : '" & Lconv.N_Sign_Posn'Img & "'");
      Put_Line (-"Int_P_Cs_Precedes : '" & Lconv.Int_P_Cs_Precedes'Img & "'");
      Put_Line (-"Int_P_Sep_By_Space : '" & Lconv.Int_P_Sep_By_Space'Img & "'");
      Put_Line (-"Int_N_Cs_Precedes : '" & Lconv.Int_N_Cs_Precedes'Img & "'");
      Put_Line (-"Int_N_Sep_By_Space : '" & Lconv.Int_N_Sep_By_Space'Img & "'");
      Put_Line (-"Int'l Positive sign positions : '" & Lconv.Int_P_Sign_Posn'Img & "'");
      Put_Line (-"Int'l Negative sign positions : '" & Lconv.Int_N_Sign_Posn'Img & "'");
   end Print_Lconv;

   -----------------------
   -- Print_Nl_Langinfo --
   -----------------------

   procedure Print_Nl_Langinfo is
   begin
      Put_Line ("Nl_Langinfo Result");
      Put_Line ("------------------");

      for Item in Locale_Item'Range loop
         Enum_IO.Put (Item);
         Put (" : ");
         Put_Line ("'" & Nl_Langinfo (Item) & "'");
      end loop;
   end Print_Nl_Langinfo;

begin
   Set_Locale;
   Text_Domain ("nls_test");
   Bind_Text_Domain ("nls_test", "");

   --  POSIX format locale name string
   --  Set_Locale (Locale => "C");
   --  Set_Locale (Locale => "uk_UA.UTF-8");

   --  Windows format locale name string
   --  Set_Locale (Locale => "Ukrainian_Ukraine.1251");

   Put_Line (-"Current locale : " & Get_Locale);
   New_Line;
   Print_Lconv;
   New_Line;
   Print_Nl_Langinfo;
end NLS_Test;
