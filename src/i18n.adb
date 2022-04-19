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

with Interfaces.C.Strings; use Interfaces.C.Strings;

package body I18n is

   pragma Warnings (Off);

   -------------
   -- Gettext --
   -------------

   function Gettext (Msg : String) return String is
      function Internal (Msg : String) return chars_ptr;
      pragma Import (C, Internal, "gettext");

      P : chars_ptr := Internal (Msg & ASCII.NUL);

   begin
      if P = Null_Ptr then
         return "";
      else
         return Value (P);
      end if;
   end Gettext;

   --------------
   -- Dgettext --
   --------------

   function Dgettext (Domain : String; Msg : String) return String is
      function Internal
        (Domain : String; Msg : String) return chars_ptr;
      pragma Import (C, Internal, "dgettext");

      P : chars_ptr := Internal (Domain & ASCII.NUL, Msg & ASCII.NUL);

   begin
      if P = Null_Ptr then
         return "";
      else
         return Value (P);
      end if;
   end Dgettext;

   ---------------
   -- Dcgettext --
   ---------------

   function Dcgettext
     (Domain : String; Msg : String; Category : Locale_Category) return String
   is
      function Internal
        (Domain : String; Msg : String; Category : Locale_Category)
         return chars_ptr;
      pragma Import (C, Internal, "dcgettext");

      P : chars_ptr :=
        Internal (Domain & ASCII.NUL, Msg & ASCII.NUL, Category);

   begin
      if P = Null_Ptr then
         return "";
      else
         return Value (P);
      end if;
   end Dcgettext;

   --------------
   -- Ngettext --
   --------------

   function Ngettext
     (Msg1 : String; Msg2 : String; N : unsigned_long) return String
   is
      function Internal
        (Msg1 : String; Msg2 : String; N : unsigned_long) return chars_ptr;
      pragma Import (C, Internal, "ngettext");

      P : chars_ptr :=
        Internal (Msg1 & ASCII.NUL, Msg2 & ASCII.NUL, N);

   begin
      if P = Null_Ptr then
         return "";
      else
         return Value (P);
      end if;
   end Ngettext;

   ---------------
   -- Dngettext --
   ---------------

   function Dngettext
     (Domain : String;
      Msg1   : String;
      Msg2   : String;
      N      : unsigned_long) return String
   is
      function Internal
        (Domain : String;
         Msg1   : String;
         Msg2   : String;
         N      : unsigned_long) return chars_ptr;
      pragma Import (C, Internal, "dngettext");

      P : chars_ptr :=
        Internal (Domain & ASCII.NUL, Msg1 & ASCII.NUL, Msg2 & ASCII.NUL, N);

   begin
      if P = Null_Ptr then
         return "";
      else
         return Value (P);
      end if;
   end Dngettext;

   ----------------
   -- Dcngettext --
   ----------------

   function Dcngettext
     (Domain   : String;
      Msg1     : String;
      Msg2     : String;
      N        : unsigned_long;
      Category : Locale_Category) return String
   is
      function Internal
        (Domain   : String;
         Msg1     : String;
         Msg2     : String;
         N        : unsigned_long;
         Category : Locale_Category) return chars_ptr;
      pragma Import (C, Internal, "dcngettext");

      P : chars_ptr :=
        Internal
          (Domain & ASCII.NUL,
           Msg1 & ASCII.NUL,
           Msg2 & ASCII.NUL,
           N,
           Category);

   begin
      if P = Null_Ptr then
         return "";
      else
         return Value (P);
      end if;
   end Dcngettext;

   -----------------
   -- Text_Domain --
   -----------------

   procedure Text_Domain (Domain_Name : String) is
      procedure Internal (Domain_Name : String);
      pragma Import (C, Internal, "textdomain");

   begin
      Internal (Domain_Name & ASCII.NUL);
   end Text_Domain;

   -------------------------
   -- Default_Text_Domain --
   -------------------------

   function Default_Text_Domain return String is
      function Internal (Domain : chars_ptr) return chars_ptr;
      pragma Import (C, Internal, "textdomain");

      P : chars_ptr := Internal (Null_Ptr);

   begin
      if P = Null_Ptr then
         return "";
      else
         return Value (P);
      end if;
   end Default_Text_Domain;

   ----------------------
   -- Bind_Text_Domain --
   ----------------------

   procedure Bind_Text_Domain (Domain_Name : String; Dirname : String) is
      procedure Internal (Domain_Name, Dirname : String);
      pragma Import (C, Internal, "bindtextdomain");

   begin
      Internal (Domain_Name & ASCII.NUL, Dirname & ASCII.NUL);
   end Bind_Text_Domain;

   ---------------------------
   -- Text_Domain_Directory --
   ---------------------------

   function Text_Domain_Directory (Domain_Name : String) return String is
      function Internal
        (Domain_Name : String; Dirname : chars_ptr) return chars_ptr;
      pragma Import (C, Internal, "bindtextdomain");

      P : chars_ptr := Internal (Domain_Name & ASCII.NUL, Null_Ptr);

   begin
      if P = Null_Ptr then
         return "";
      else
         return Value (P);
      end if;
   end Text_Domain_Directory;

   ------------------------------
   -- Bind_Text_Domain_Codeset --
   ------------------------------

   procedure Bind_Text_Domain_Codeset
     (Domain_Name : String; Codeset : String)
   is
      procedure Internal (Domain_Name : String; Codeset : String);
      pragma Import (C, Internal, "bind_textdomain_codeset");

   begin
      Internal (Domain_Name & ASCII.NUL, Codeset & ASCII.NUL);
   end Bind_Text_Domain_Codeset;

   -------------------------
   -- Text_Domain_Codeset --
   -------------------------

   function Text_Domain_Codeset (Domain_Name : String) return String is
      function Internal
        (Domain_Name : String; Codeset : chars_ptr) return chars_ptr;
      pragma Import (C, Internal, "bind_textdomain_codeset");

      P : chars_ptr := Internal (Domain_Name & ASCII.NUL, Null_Ptr);

   begin
      if P = Null_Ptr then
         return "";
      else
         return Value (P);
      end if;
   end Text_Domain_Codeset;

end I18n;
