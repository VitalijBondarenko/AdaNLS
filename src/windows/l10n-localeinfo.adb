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

--  The functions to access the information for the locale.

with Ada.Strings;          use Ada.Strings;
with Ada.Strings.Fixed;    use Ada.Strings.Fixed;

package body L10n.Localeinfo is

   function From_Chars_Ptr (C : chars_ptr) return Unbounded_String;
   function Print_Grouping (Grouping : chars_ptr) return Unbounded_String;

   --------------------
   -- From_Chars_Ptr --
   --------------------

   function From_Chars_Ptr (C : chars_ptr) return Unbounded_String is
   begin
      if C = Null_Ptr then
         return Null_Unbounded_String;
      else
         return To_Unbounded_String (Value (C));
      end if;
   end From_Chars_Ptr;

   --------------------
   -- Print_Grouping --
   --------------------

   function Print_Grouping (Grouping : chars_ptr) return Unbounded_String is
      S : String := Value (Grouping);
      U : Unbounded_String := Null_Unbounded_String;
      P : Integer;
   begin
      for I in S'Range loop
         P := Character'Pos (S (I));
         U := U & Trim (P'Img, Both);
      end loop;

      return U;
   end Print_Grouping;

   ----------------
   -- Localeconv --
   ----------------

   function Localeconv return Lconv_Access is
      C_L : C_Lconv_Access := C_Localeconv;
      L   : Lconv_Access := new Lconv_Record;
   begin
      L.Decimal_Point := From_Chars_Ptr (C_L.Decimal_Point);
      L.Thousands_Sep := From_Chars_Ptr (C_L.Thousands_Sep);
      L.Grouping := Print_Grouping (C_L.Grouping);
      L.Int_Curr_Symbol := From_Chars_Ptr (C_L.Int_Curr_Symbol);
      L.Currency_Symbol := From_Chars_Ptr (C_L.Currency_Symbol);
      L.Mon_Decimal_Point := From_Chars_Ptr (C_L.Mon_Decimal_Point);
      L.Mon_Thousands_Sep := From_Chars_Ptr (C_L.Mon_Thousands_Sep);
      L.Mon_Grouping := Print_Grouping (C_L.Mon_Grouping);
      L.Positive_Sign := From_Chars_Ptr (C_L.Positive_Sign);
      L.Negative_Sign := From_Chars_Ptr (C_L.Negative_Sign);
      L.Int_Frac_Digits := Natural (C_L.Int_Frac_Digits);
      L.Frac_Digits := Natural (C_L.Frac_Digits);
      L.P_Cs_Precedes := Natural (C_L.P_Cs_Precedes);
      L.P_Sep_By_Space := Natural (C_L.P_Sep_By_Space);
      L.N_Cs_Precedes := Natural (C_L.N_Cs_Precedes);
      L.N_Sep_By_Space := Natural (C_L.N_Sep_By_Space);
      L.P_Sign_Posn := Natural (C_L.P_Sign_Posn);
      L.N_Sign_Posn := Natural (C_L.N_Sign_Posn);
      L.Int_P_Cs_Precedes := Natural (C_L.Int_P_Cs_Precedes);
      L.Int_P_Sep_By_Space := Natural (C_L.Int_P_Sep_By_Space);
      L.Int_N_Cs_Precedes := Natural (C_L.Int_N_Cs_Precedes);
      L.Int_N_Sep_By_Space := Natural (C_L.Int_N_Sep_By_Space);
      L.Int_P_Sign_Posn := Natural (C_L.Int_P_Sign_Posn);
      L.Int_N_Sign_Posn := Natural (C_L.Int_N_Sign_Posn);

      return L;
   end Localeconv;

end L10n.Localeinfo;
