with Interfaces.C.Strings; use Interfaces.C.Strings;

package body L10n.Langinfo is

   -----------------
   -- Nl_Langinfo --
   -----------------

   function Nl_Langinfo (Item : Locale_Item) return String is
      function Internal (Item : Locale_Item) return chars_ptr;
      pragma Import (C, Internal,  "nl_langinfo");

      R : chars_ptr := Internal (Item);

   begin
      if R = Null_Ptr then
         return "";
      else
         return Value (R);
      end if;

   exception
         when others => return "";
   end Nl_Langinfo;

end L10n.Langinfo;
