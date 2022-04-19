/*--------------------------------------------------------------------------*/
/*                                                                          */
/* Copyright (c) 2014-2022 Vitalii Bondarenko <vibondare@gmail.com>         */
/*                                                                          */
/*--------------------------------------------------------------------------*/
/*                                                                          */
/* The MIT License (MIT)                                                    */
/*                                                                          */
/* Permission is hereby granted, free of charge, to any person obtaining a  */
/* copy of this software and associated documentation files (the            */
/* "Software"), to deal in the Software without restriction, including      */
/* without limitation the rights to use, copy, modify, merge, publish,      */
/* distribute, sublicense, and/or sell copies of the Software, and to       */
/* permit persons to whom the Software is furnished to do so, subject to    */
/* the following conditions:                                                */
/*                                                                          */
/* The above copyright notice and this permission notice shall be included  */
/* in all copies or substantial portions of the Software.                   */
/*                                                                          */
/* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS  */
/* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF               */
/* MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.   */
/* IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY     */
/* CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,     */
/* TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE        */
/* SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                   */
/*--------------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <locale.h>
#include <windows.h>
#include <winnls.h>

#define BUFFER_SIZE 512

#define UNICODE 1

LPWSTR To_UTF16 (UINT CodePage, LPCSTR text);
LPSTR To_UTF8 (LPCWSTR wtext);
struct lconv *wrap_localeconv (void);
LPSTR Get_Locale_Info (LCID lcid, LCTYPE item);
LPSTR Get_Locale_Info_Ex (LPSTR locale, LCTYPE item);
LPSTR Get_CP_Info ();
BOOL CALLBACK MyLocaleEnumProc(LPTSTR szLocaleString);
LCID Get_Locale_LCID (LPSTR localename);
LPSTR Get_Locale ();

/*
 * To_UTF16
 */

LPWSTR To_UTF16 (UINT CodePage, LPCSTR text)
{
  int len;
  LPWSTR wtext;
  len = MultiByteToWideChar(CodePage,
                            0,              // must be 0 for UTF conversions
                            text,  // string to be converted
                            -1,             // NUL-terminated
                            NULL,           // no place to put it
                            0);

  if (len == 0)
    return NULL;

  wtext = (LPWSTR)malloc(len * sizeof(WCHAR));
  len = MultiByteToWideChar(CodePage,
                            0,              // must be 0 for UTF conversion
                            text,  // string to be converted
                            -1,             // NUL-terminated
                            wtext,    // place to put it
                            len);          // must be NULL for UTF conversions
  return wtext;
}

/*
 * To_UTF8
 */

LPSTR To_UTF8 (LPCWSTR wtext)
{
  int len;
  LPSTR text;
  len = WideCharToMultiByte(CP_UTF8,
                            0,              // must be 0 for UTF conversions
                            wtext,  // string to be converted
                            -1,             // NUL-terminated
                            NULL,           // no place to put it
                            0,              // ask to return size
                            NULL,           // must be NULL for UTF conversions
                            NULL);

  if (len == 0)
    return NULL;

  text = (LPSTR)malloc(len * sizeof(CHAR));
  len = WideCharToMultiByte(CP_UTF8,
                            0,              // must be 0 for UTF conversion
                            wtext,  // string to be converted
                            -1,             // NUL-terminated
                            text,    // place to put it
                            len,            // length of buffer
                            NULL,           // must be NULL for UTF conversions
                            NULL);          // must be NULL for UTF conversions
  return text;
}

/*
 * wrap_localeconv
 */
struct lconv *wrap_localeconv (void)
{
  struct lconv *loc = localeconv();

  loc->decimal_point = To_UTF8 (To_UTF16 (CP_THREAD_ACP, loc->decimal_point));
  loc->thousands_sep = To_UTF8 (To_UTF16 (CP_THREAD_ACP, loc->thousands_sep));
/*   loc->grouping = To_UTF8 (To_UTF16 (CP_THREAD_ACP, loc->grouping)); */
  loc->int_curr_symbol = To_UTF8 (To_UTF16 (CP_THREAD_ACP, loc->int_curr_symbol));
  loc->currency_symbol = To_UTF8 (To_UTF16 (CP_THREAD_ACP, loc->currency_symbol));
  loc->mon_decimal_point = To_UTF8 (To_UTF16 (CP_THREAD_ACP, loc->mon_decimal_point));
  loc->mon_thousands_sep = To_UTF8 (To_UTF16 (CP_THREAD_ACP, loc->mon_thousands_sep));
/*   loc->mon_grouping = To_UTF8 (To_UTF16 (CP_THREAD_ACP, loc->mon_grouping)); */
  loc->positive_sign = To_UTF8 (To_UTF16 (CP_THREAD_ACP, loc->positive_sign));
  loc->negative_sign = To_UTF8 (To_UTF16 (CP_THREAD_ACP, loc->negative_sign));

  return loc;
}

/*
 * Get_Locale_Info
 */

LPSTR Get_Locale_Info (LCID lcid, LCTYPE item)
{
  LPWSTR w_data = NULL;
  LPSTR data = NULL;
  {
    int length = GetLocaleInfoW(lcid, item, NULL, 0);
    if(length > 0)
      {
        w_data = (LPWSTR)malloc(length * sizeof(WCHAR));
        if (w_data != NULL)
          {
            if (!GetLocaleInfoW(lcid, item, w_data, length))
              {
                free(w_data);
                w_data = NULL;
              }
            else
              {
                data = To_UTF8 (w_data);
              }
          }
      }
  }

  if(w_data != NULL)
    {
      free(w_data);
    }

return data;
}

/*
 * Get_Locale_Info_Ex
 */

LPSTR Get_Locale_Info_Ex (LPSTR locale, LCTYPE item)
{
  LPWSTR w_data = NULL;
  LPSTR data = NULL;
  LPWSTR w_locale = To_UTF16 (CP_THREAD_ACP, locale);
  LCID LocID = Get_Locale_LCID (locale);

  {
    int length = GetLocaleInfoW(LocID, item, NULL, 0);
    if(length > 0)
      {
        w_data = (LPWSTR)malloc(length * sizeof(WCHAR));
        if(w_data != NULL)
          {
            if(!GetLocaleInfoW(LocID, item, w_data, length))
              {
                free(w_data);
                w_data = NULL;
              }
            else
              {
                data = To_UTF8 (w_data);
              }
          }
      }
  }

  if(w_data != NULL)
    {
      free(w_data);
    }

  if(w_locale != NULL)
    {
      free(w_locale);
    }

return data;
}

/*
 * Get_CP_Info
 */

LPSTR Get_CP_Info ()
{
  CPINFOEX info;
  LPSTR cp_name = NULL;

  if(GetCPInfoEx(CP_THREAD_ACP, 0, &info))
    {
      cp_name = To_UTF8 (To_UTF16 (CP_THREAD_ACP, info.CodePageName));
    }

  return cp_name;
}

/*
 * Get_Locale_LCID
 */

LCID lcid_buf = 0;
char ISO_localename_buf[LOCALE_NAME_MAX_LENGTH];
char localename_buf[LOCALE_NAME_MAX_LENGTH];

BOOL CALLBACK MyLocaleEnumProc(LPTSTR szLocaleString)
{
  LCID lcid = strtoul (szLocaleString, NULL, 16);

  LPSTR ISO_lang = Get_Locale_Info (lcid, LOCALE_SISO639LANGNAME);
  LPSTR ISO_country = Get_Locale_Info (lcid, LOCALE_SISO3166CTRYNAME);
  LPSTR lang = Get_Locale_Info (lcid, LOCALE_SENGLANGUAGE);
  LPSTR country = Get_Locale_Info (lcid, LOCALE_SENGCOUNTRY);

  char ISO_lname [LOCALE_NAME_MAX_LENGTH];
  sprintf (ISO_lname, "%s-%s", ISO_lang, ISO_country);
  char lname [LOCALE_NAME_MAX_LENGTH];
  sprintf (lname, "%s_%s", lang, country);

  if (strcmp (ISO_localename_buf, ISO_lname) == 0 ||
      strcmp (localename_buf, lname) == 0)
    {
      lcid_buf = lcid;
      return FALSE;
    }
  else
    {
      return TRUE;
    }
}

LCID Get_Locale_LCID (LPSTR localename)
{
  char *lname = strtok (localename, ".");
  memset (ISO_localename_buf, '\0', sizeof(ISO_localename_buf));
  strcpy (ISO_localename_buf, lname);
  memset (localename_buf, '\0', sizeof(localename_buf));
  strcpy (localename_buf, lname);
  EnumSystemLocales(&MyLocaleEnumProc, LCID_INSTALLED);
  return lcid_buf;
}

/*
 * Get_Locale
 */

LPSTR Get_Locale ()
{
  LCID lcid = GetThreadLocale();
  LPSTR ISO_lang = Get_Locale_Info (lcid, LOCALE_SISO639LANGNAME);
  LPSTR ISO_country = Get_Locale_Info (lcid, LOCALE_SISO3166CTRYNAME);

  LPSTR ISO_lname = NULL;
  ISO_lname = (LPSTR)malloc(10 * sizeof(CHAR));
  memset (ISO_lname, '\0', sizeof(ISO_lname));
  sprintf (ISO_lname, "%s-%s", ISO_lang, ISO_country);

  return ISO_lname;
}

