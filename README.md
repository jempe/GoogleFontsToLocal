# Google Fonts to Local
This is a command-line tool that allows you to download a Google Fonts CSS file and font files to your local machine. By giving the URL of a Google Fonts import URL, you can create a copy of the CSS and the font files that you can use locally. This is useful if you want to use Google Fonts on a website, but you don't want to rely on Google's servers.

# Usage

To process the Google Fonts, run the **GoogleFontsToLocal/main.swift** copy and paste the code from a Google Fonts import URL like (https://fonts.googleapis.com/css2?family=Asap:ital,wght@0,400;0,500;0,700;1,400;1,500;1,700&display=swap) and save it as a text file on your local machine, then run the command

```
swift GoogleFontsToLocal/main.swift ~/google_font_css.txt
```

It will display the Latin fonts only and will show the curl commands to download the css files locally at the end

## Output Example
```
/* Asap-400-italic */

@font-face {
  font-family: 'Asap';
  font-style: italic;
  font-weight: 400;
  font-stretch: 100%;
  font-display: swap;
  src: url(Asap-400-italic.woff2) format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}

/* Asap-500-italic */

@font-face {
  font-family: 'Asap';
  font-style: italic;
  font-weight: 500;
  font-stretch: 100%;
  font-display: swap;
  src: url(Asap-500-italic.woff2) format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}

/* Asap-700-italic */

@font-face {
  font-family: 'Asap';
  font-style: italic;
  font-weight: 700;
  font-stretch: 100%;
  font-display: swap;
  src: url(Asap-700-italic.woff2) format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}

/* Asap-400-normal */

@font-face {
  font-family: 'Asap';
  font-style: normal;
  font-weight: 400;
  font-stretch: 100%;
  font-display: swap;
  src: url(Asap-400-normal.woff2) format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}

/* Asap-500-normal */

@font-face {
  font-family: 'Asap';
  font-style: normal;
  font-weight: 500;
  font-stretch: 100%;
  font-display: swap;
  src: url(Asap-500-normal.woff2) format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}

/* Asap-700-normal */

@font-face {
  font-family: 'Asap';
  font-style: normal;
  font-weight: 700;
  font-stretch: 100%;
  font-display: swap;
  src: url(Asap-700-normal.woff2) format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}


/* Curl command to download fonts
curl Asap-400-italic.woff2 -o Asap-400-italic.woff2
curl Asap-500-italic.woff2 -o Asap-500-italic.woff2
curl Asap-700-italic.woff2 -o Asap-700-italic.woff2
curl Asap-400-normal.woff2 -o Asap-400-normal.woff2
curl Asap-500-normal.woff2 -o Asap-500-normal.woff2
curl Asap-700-normal.woff2 -o Asap-700-normal.woff2
*/
```


Then simply add the css code to your stylesheet file and download the font files using the curl command

# License

This tool is released under the Apache license. See LICENSE for details.
