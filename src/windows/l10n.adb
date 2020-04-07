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

with Interfaces.C.Strings; use Interfaces.C.Strings;

package body L10n is

   pragma Warnings (Off);

   ----------------
   -- Set_Locale --
   ----------------

   procedure Set_Locale
     (Category : Locale_Category := LC_ALL; Locale : String := "")
   is
      procedure Internal (Category : Locale_Category; Locale : String);
      pragma Import (C, Internal, "setlocale");
   begin
      Internal (Category, Locale & ASCII.NUL);
   end Set_Locale;

   ----------------
   -- Get_Locale --
   ----------------

   function Get_Locale (Category : Locale_Category := LC_ALL) return String is
      function Internal
        (Category : Locale_Category; Locale : chars_ptr) return chars_ptr;
      pragma Import (C, Internal, "setlocale");

      L : chars_ptr := Internal (Category, Null_Ptr);
   begin
      if L = Null_Ptr then
         return "";
      else
         return Value (L);
      end if;
   end Get_Locale;

end L10n;
