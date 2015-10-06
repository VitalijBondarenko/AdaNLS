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

--  The set of functions to support message translation.

with Interfaces.C; use Interfaces.C;

with L10n; use L10n;

package I18n is
   pragma Preelaborate;

   function Gettext (Msg : String) return String;
   --  Searches the currently selected message catalogs for a string which is
   --  equal to Msg. If there is such a string available it is returned.
   --  Otherwise the argument string Msg is returned.

   function "-" (Msg : String) return String renames Gettext;
   --  Shortcut for Gettext (Msg)

   function Dgettext
     (Domain : String; Msg : String) return String;
   --  The Dgettext functions acts just like the Gettext function. It only
   --  takes an additional first argument Domain which guides the selection of
   --  the message catalogs which are searched for the translation. If the
   --  Domain parameter is the empty string the Dgettext function is exactly
   --  equivalent to Gettext since the default value for the domain name is
   --  used.

   function Dcgettext
     (Domain : String; Msg : String; Category : Locale_Category) return String;
   --  The Dcgettext adds another argument to those which Dgettext takes. This
   --  argument Category specifies the last piece of information needed to
   --  localize the message catalog. I.e., the domain name and the locale
   --  category exactly specify which message catalog has to be used.
   --  Look up Msg in the Domain message catalog for the Category locale.

   function Ngettext
     (Msg1 : String; Msg2 : String; N : unsigned_long) return String;
   --  The Ngettext function is similar to the Gettext function as it finds the
   --  message catalogs in the same way. But it takes two extra arguments.
   --  The Msg1 parameter must contain the singular form of the string to be
   --  converted. It is also used as the key for the search in the catalog.
   --  The Msg2 parameter is the plural form. The parameter N is used to
   --  determine the plural form. If no message catalog is found Msg1 is
   --  returned if N = 1, otherwise Msg2.

   function Dngettext
     (Domain : String;
      Msg1   : String;
      Msg2   : String;
      N      : unsigned_long) return String;
   --  The Dngettext is similar to the Dgettext function in the way the message
   --  catalog is selected. The difference is that it takes two extra parameter
   --  to provide the correct plural form. These two parameters are handled in
   --  the same way Ngettext handles them.

   function Dcngettext
     (Domain   : String;
      Msg1     : String;
      Msg2     : String;
      N        : unsigned_long;
      Category : Locale_Category) return String;
   --  The Dcngettext is similar to the Dcgettext function in the way the
   --  message catalog is selected. The difference is that it takes two extra
   --  parameter to provide the correct plural form. These two parameters are
   --  handled in the same way Ngettext handles them.

   procedure Text_Domain (Domain_Name : String);
   --  Sets the default domain, which is used in all future Gettext calls,
   --  to Domain_Name.
   --
   --  If the Domain_Name parameter is the empty string the default domain is
   --  reset to its initial value, the domain with the name messages. This
   --  possibility is questionable to use since the domain messages really
   --  never should be used.

   function Default_Text_Domain return String;
   --  Return the currently selected default domain.

   procedure Bind_Text_Domain (Domain_Name : String; Dirname : String);
   --  The Bind_Text_Domain function can be used to specify the directory which
   --  contains the message catalogs for domain Domain_Name for the different
   --  languages. To be correct, this is the directory where the hierarchy of
   --  directories is expected.
   --  The Dirname string ought to be an absolute pathname.

   function Text_Domain_Directory (Domain_Name : String) return String;
   --  Returns the currently selected directory for the domain with the name
   --  Domain_Name.

   procedure Bind_Text_Domain_Codeset (Domain_Name : String; Codeset : String);
   --  The Bind_Text_Domain_Codeset function can be used to specify the output
   --  character set for message catalogs for domain Domain_Name. The Codeset
   --  argument must be a valid codeset name which can be used for the
   --  'iconv_open' function from 'libc' library.

   function Text_Domain_Codeset (Domain_Name : String) return String;
   --  Returns the currently selected codeset for the domain with the name
   --  Domain_Name. It returns empty string if no codeset has yet been selected.

end I18n;
