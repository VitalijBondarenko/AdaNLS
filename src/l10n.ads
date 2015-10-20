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

--  The functions to setup locale.

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

end L10n;
