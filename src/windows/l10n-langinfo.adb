------------------------------------------------------------------------------
--                                                                          --
-- Copyright (c) 2014-2016 Vitalij Bondarenko <vibondare@gmail.com>         --
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

package body L10n.Langinfo is

   -----------------
   -- Nl_Langinfo --
   -----------------

   function Nl_Langinfo (Item : Locale_Item) return String is
      function Get_Locale_Info
        (Locale : String; Item : Locale_Item) return chars_ptr;
      pragma Import (C, Get_Locale_Info, "Get_Locale_Info_Ex");

      function Get_CP_Info return chars_ptr;
      pragma Import (C, Get_CP_Info, "Get_CP_Info");

      R : chars_ptr := Null_Ptr;

   begin
      case Item is
         when RADIXCHAR .. CODESET =>
            R := Get_Locale_Info (Get_Locale, Item);
         when others =>
            null;
      end case;

      if R = Null_Ptr then
         return "";
      else
         return Value (R);
      end if;

   exception
         when others => return "";
   end Nl_Langinfo;

end L10n.Langinfo;
