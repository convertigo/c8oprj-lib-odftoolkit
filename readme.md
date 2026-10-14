


# lib_fill_odt_pdf

Document generation library: fills OpenDocument (ODT, ODS, ODP) and Office (Word, PowerPoint, Excel) templates, converts documents with LibreOffice and handles PDF files.


For more technical informations : [documentation](./project.md)

- [Installation](#installation)
- [Overview](#overview)
- [Quick start](#quick-start)
- [Configuration](#configuration)
- [Upgrading from version 1](#upgrading-from-version-1)
- [Sequences](#sequences)
    - [autoRemoveFolder](#autoremovefolder)
    - [clean_outputs](#clean_outputs)
    - [ctx_server_set](#ctx_server_set)
    - [demo_export_data_to_sheet](#demo_export_data_to_sheet)
    - [demo_u_fill_odp](#demo_u_fill_odp)
    - [demo_u_fill_odt](#demo_u_fill_odt)
    - [demo_u_fill_office](#demo_u_fill_office)
    - [demo_u_fill_pdf](#demo_u_fill_pdf)
    - [demo_u_fill_table_odt](#demo_u_fill_table_odt)
    - [demo_u_fill_table_template_odt](#demo_u_fill_table_template_odt)
    - [fill_odt](#fill_odt)
    - [fill_pdf](#fill_pdf)
    - [getInstalledFonts](#getinstalledfonts)
    - [init_config](#init_config)
    - [init_config_loop](#init_config_loop)
    - [launch_pexec](#launch_pexec)
    - [metadata_pdf](#metadata_pdf)
    - [odt2pdf](#odt2pdf)
    - [soffice_odt2pdf](#soffice_odt2pdf)
    - [u_convert](#u_convert)
    - [u_create_ods](#u_create_ods)
    - [u_create_odt](#u_create_odt)
    - [u_export_data_to_sheet](#u_export_data_to_sheet)
    - [u_fill_odt](#u_fill_odt)
    - [u_fill_ooxml](#u_fill_ooxml)
    - [u_fill_pdf](#u_fill_pdf)
    - [u_read_odt](#u_read_odt)
    - [u_read_pdf](#u_read_pdf)


## Installation

1. In your Convertigo Studio use `File->Import->Convertigo->Convertigo Project` and hit the `Next` button
2. In the dialog `Project remote URL` field, paste the text below:
   <table>
     <tr><td>Usage</td><td>Click the copy button</td></tr>
     <tr><td>To contribute</td><td>

     ```
     lib_fill_odt_pdf=https://github.com/convertigo/c8oprj-lib-odftoolkit.git:branch=8.0.0
     ```
     </td></tr>
     <tr><td>To simply use</td><td>

     ```
     lib_fill_odt_pdf=https://github.com/convertigo/c8oprj-lib-odftoolkit/archive/8.0.0.zip
     ```
     </td></tr>
    </table>
3. Click the `Finish` button. This will automatically import the __lib_fill_odt_pdf__ project


## Overview

| Need | Sequence | LibreOffice |
|------|----------|-------------|
| Fill an OpenDocument template: text (odt), spreadsheet (ods), presentation (odp) | `u_fill_odt` | not needed |
| Fill a template designed with Word, PowerPoint or Excel (docx, pptx, xlsx and the dotx, potx, xltx, docm, pptm, xlsm variants) | `u_fill_odt` (delegates to `u_fill_ooxml`) | not needed |
| Create a text document or a spreadsheet from data | `u_create_odt`, `u_create_ods` | not needed |
| Convert a document to another format (pdf, docx, xlsx, pptx, odt, html...) | `u_convert` (Private: call it from a sequence) | required |
| Convert an ODT file to PDF | `odt2pdf` | used when installed, otherwise the converter of the previous versions |
| Convert an ODT file to PDF with LibreOffice | `soffice_odt2pdf` | required |
| Read or change PDF metadata and protection, fill or read PDF forms | `metadata_pdf`, `u_fill_pdf`, `u_read_pdf` | not needed |
| Delete the generated files of `.//outputs` | `clean_outputs` (Private), `autoRemoveFolder` (auto start) | not needed |

Office templates are filled by editing their XML in place: the formatting of the template is kept, and the tags that Word, PowerPoint or Excel split in several pieces (spell check, revisions) are found. Sample templates are in `templates/odf`, `templates/odp` and `templates/office`.

## Quick start

1. Put a tag in your template, for example `{customer}` in a Word document, then save it in the project, for example as `.//templates/office/letter.docx`.
2. From your sequence, add a **Call Sequence** step on `lib_fill_odt_pdf.u_fill_odt` with these variables:
   - `input_filename`: `.//templates/office/letter.docx`
   - `output_filename`: `.//outputs/letter.docx` (same format as the template)
   - `markers`: a JSON array, or a structured variable built with JSON steps:
     ```json
     [
       { "tag": "{customer}", "value": "ACME" },
       { "tag": "{date}", "type": "span", "value": "14/10/2026", "style": { "fontStyle": "BOLD", "fontColor": "RED" } },
       { "tag": "{lines}", "type": "rows", "value": [["Low Code", "12"], ["Forms", "30"]] },
       { "tag": "logo", "type": "image", "value": ".//templates/odp/sample_logo.png" }
     ]
     ```
3. The sequence returns an `attachment` element (the generated file), `not_found` (tags absent from the template) and `marker_errors`. Called with the `.bin` requester, it downloads the file.
4. To get a PDF, call `lib_fill_odt_pdf.u_convert` with `input_filename` = the generated file and `output_filename` = `.//outputs/letter.pdf`.

Marker types: `string` (default), `paragraph`, `newline`, `span`, `image`, `table`, `tableh`, `tablet`, `array`, `list`, `rows` and `slides`. Their options and the differences between formats are described with the `markers` variable of `u_fill_odt` below. The demo sequences `demo_u_fill_odt`, `demo_u_fill_table_odt`, `demo_u_fill_odp` and `demo_u_fill_office` show the marker types at work.

## Configuration

The library is configured with global symbols (administration console > Global symbols). Each one can also come from an environment variable, handy with Docker.

| Global symbol | Environment variable | Default | Use |
|---------------|----------------------|---------|-----|
| `lib_fill_odt_pdf.soffice_path` | `SOFFICE_PATH` | default install paths, then `soffice` in the PATH | Path of the LibreOffice executable |
| `lib_fill_odt_pdf.office_pool_size` | `LIB_FILL_ODT_PDF_OFFICE_POOL_SIZE` | `0` | Number of LibreOffice processes kept running between conversions (about 50 ms per conversion instead of 2 s). `0` starts one process per conversion |
| `lib_fill_odt_pdf.office_pool_port` | `LIB_FILL_ODT_PDF_OFFICE_POOL_PORT` | `2002` | First port used by the pool |
| `lib_fill_odt_pdf.odt2pdf_converter` | `LIB_FILL_ODT_PDF_ODT2PDF_CONVERTER` | `auto` | Converter of `odt2pdf`: `auto` (LibreOffice when installed), `libreoffice` or `legacy` (converter of the previous versions) |
| `auto_start.init_config` | | `false` | Docker only: installs LibreOffice and the fonts when the server starts |
| `auto_start.init_config_loop` | | `true` | Docker only: same installation, one command after the other |

The default install paths are `C:/Program Files/LibreOffice/program/soffice.exe` on Windows, `/Applications/LibreOffice.app/Contents/MacOS/soffice` on macOS and `/usr/bin/soffice`, `/usr/lib/libreoffice/program/soffice`, `/opt/libreoffice/program/soffice` on Linux.

On Docker, `docker/Dockerfile` builds a Convertigo image with LibreOffice and the fonts of the project already installed: set `auto_start.init_config` and `auto_start.init_config_loop` to `false` with this image.

```
docker build -f docker/Dockerfile --build-arg CONVERTIGO_TAG=8.4.1 -t convertigo-odf:8.4.1 .
docker run -d -p 28080:28080 convertigo-odf:8.4.1
```

Error codes: `-1` generation or conversion error, `-2` LibreOffice can not be started, `-3` conversion timeout, `-4` the fonts and LibreOffice are being installed by `init_config` (retry later).

## Upgrading from version 1

From version 8.0.0.0, the library is built on odfdom-java 0.13 instead of simple-odf 0.9. The existing sequences and their variables are unchanged, so the projects that use the library keep working. Only optional variables were added (`delete_at_end_of_session` in `u_fill_odt`, `table_name` in `u_read_odt`). Points to check:

- **Jars**: simple-odf 0.9, iText 2.1.7 and XDocReport are no longer in `libs` (the copy kept in `libs/legacy_pdf` is only loaded by `odt2pdf`). A project that references this library sees its jars: if its own code uses `com.lowagie` (iText) classes, add iText 2.1.7 to its `libs`. Code using `org.odftoolkit.simple` or the odfdom 0.9 API must be ported to odfdom 0.13 or replaced by calls to the sequences of the library: odfdom 0.9 can not be loaded next to odfdom 0.13.
- **`odt2pdf`**: converts with LibreOffice when it is installed, otherwise with the converter of the previous versions. Its result is unchanged.
- **`soffice_odt2pdf`**: the `soffice_path` variable is ignored for security reasons. When LibreOffice is not in a default install path, set the `lib_fill_odt_pdf.soffice_path` global symbol or the `SOFFICE_PATH` environment variable.
- **`u_fill_odt`, `u_create_odt`, `fill_odt`**: the result also contains `not_found` and `marker_errors`. The items of an `array` marker no longer take the formatting of the previous `span` item.
- **`u_create_ods`**: returns an `attachment` element and prints all the sheets.
- **`clean_outputs`**: can only be called from a sequence (Private) and only deletes the generated file types of `.//outputs`. Files older than `max_time` are deleted (24 h by default). At startup, `autoRemoveFolder` deletes the files older than 10 minutes.

## Sequences

### autoRemoveFolder

### clean_outputs

Clean the generated files. Can be used in a Convertigo scheduled job to automate the process. Variables : 'max_time' => delete only files older than x ms. 'all' => Delete all files in folder even in a max_time is defined. 'target' => Folder path containing the files to delete. Can use "./",  ".//" or absolute path syntax.

**variables**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>all</td><td>Set value to 'true' to directly delete all files whatever last modified date they have. Default is 'false', it only deletes files older than 'max_time'</td>
</tr>
<tr>
<td>max_time</td><td>Define the maximum time in millisecond before deleting the file. Default is 86400000ms (24h). Only works if 'all' is 'false'</td>
</tr>
<tr>
<td>target</td><td></td>
</tr>
</table>

### ctx_server_set

Set Name/Value in server

**variables**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>set_name</td><td></td>
</tr>
<tr>
<td>set_value</td><td></td>
</tr>
</table>

### demo_export_data_to_sheet

Demo sequence to create a spreadhseet filled with data.

### demo_u_fill_odp

Demo sequence: fills .//templates/odp/template.odp with u_fill_odt, then converts the result to PPTX and PDF with u_convert.

### demo_u_fill_odt

Demo sequence to fill an ODT template file.

### demo_u_fill_office

Demo sequence: fills the Word, PowerPoint and Excel templates of .//templates/office with u_fill_odt, then converts the results to PDF with u_convert.

### demo_u_fill_pdf

Demo sequence to fill an ODT template file.

### demo_u_fill_table_odt

Demo sequence to fill an ODT template file.

### demo_u_fill_table_template_odt

Demo sequence to fill an ODT template file.

### fill_odt

Fills an ODT template file (Deprecated).
Place your template files in .//templates/odf folder.

**variables**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>date</td><td>Date</td>
</tr>
<tr>
<td>input_filename</td><td>Input ODT template file name to fill (without extension, '.doc' is automatically added but format is ODT and can be opened as a Ms Word file or OpenOffice). 
Put your templates in <project_folder>/templates/odf</td>
</tr>
<tr>
<td>objet</td><td>Subject</td>
</tr>
<tr>
<td>output_filename</td><td>Output ODT file name (without extension). 
'.doc' is automatically added to filename to be opened by Ms Word or OpenOffice.</td>
</tr>
<tr>
<td>signature</td><td>Signature. 
Absolute Image file path.</td>
</tr>
<tr>
<td>texte</td><td>Main Body Text</td>
</tr>
</table>

### fill_pdf

Fills a PDF template file (deprecated). 
Place your template file in .//templates/pdf folder.

**variables**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>date</td><td>Date</td>
</tr>
<tr>
<td>input_filename</td><td>Input PDF template file name to fill (without extension, '.pdf' is assumed). 
Put your templates in <project_folder>/templates/pdf</td>
</tr>
<tr>
<td>objet</td><td>Subject</td>
</tr>
<tr>
<td>output_filename</td><td>Output PDF file name (without extension). 
'.pdf' is automatically added to filename.</td>
</tr>
<tr>
<td>signature</td><td>Signature. 
_ Image file. Can be an aboslute path file or relative to project (.//) or workspace (./). 
_ B64 string.</td>
</tr>
<tr>
<td>texte</td><td>Main Body Text</td>
</tr>
</table>

### getInstalledFonts

Get installed Fonts

### init_config

Auto start sequence to install LibreOffice and the fonts on the Docker Linux Platform. Not needed with an image built from docker/Dockerfile. While it runs, u_fill_odt and u_create_odt answer the -4 error.

### init_config_loop

Auto start sequence to install some required fonts for Docker Linux Platform using launch_pexec loop.

### launch_pexec

Launch Process Exec

**variables**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>cmd_line</td><td></td>
</tr>
</table>

### metadata_pdf

Get the metadata of the PDF file.

**variables**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>input_filename</td><td>ODT input template file name to fill. 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
</tr>
<tr>
<td>mode</td><td>Read or Write PDF metadata. To write to PDF file, use 'w' or 'write'. output_filename must not be left blank or empty.</td>
</tr>
<tr>
<td>new_ap_canAssembleDocument</td><td>Permission to assemble the document</td>
</tr>
<tr>
<td>new_ap_canExtractContent</td><td>Permission to extract content from the document</td>
</tr>
<tr>
<td>new_ap_canExtractForAccessibility</td><td>Permission to extract content for accessibility purposes</td>
</tr>
<tr>
<td>new_ap_canFillInForm</td><td>Permission to fill in forms in the document</td>
</tr>
<tr>
<td>new_ap_canModify</td><td>Permission to modify the document</td>
</tr>
<tr>
<td>new_ap_canModifyAnnotations</td><td>Permission to modify annotations</td>
</tr>
<tr>
<td>new_ap_canPrint</td><td>Permission to print the document</td>
</tr>
<tr>
<td>new_ap_canPrintHighQuality</td><td>Permission to print the document faithfully</td>
</tr>
<tr>
<td>new_ap_ForcePolicy</td><td>Force a new protection policy according to password, new_user_password and new_owner_password.</td>
</tr>
<tr>
<td>new_author</td><td>Set the AUTHOR metadata</td>
</tr>
<tr>
<td>new_creation_date</td><td>Set the CREATION DATE metadata</td>
</tr>
<tr>
<td>new_creator</td><td>Set the CREATOR metadata</td>
</tr>
<tr>
<td>new_keywords</td><td>Set the KEYWORDS metadata</td>
</tr>
<tr>
<td>new_modification_date</td><td>Set the MODIFICATION DATE metadata</td>
</tr>
<tr>
<td>new_owner_password</td><td>Owner password of the protected PDF file.</td>
</tr>
<tr>
<td>new_producer</td><td>Set the PRODUCER metadata</td>
</tr>
<tr>
<td>new_setProtection</td><td>If "true", it will protect the PDF file with the given 'new_user_password' and 'new_owner_password', defaulting to 'password' variable if one is missing.</td>
</tr>
<tr>
<td>new_subject</td><td>Set the SUBJECT metadata</td>
</tr>
<tr>
<td>new_title</td><td>Set the TITLE metadata</td>
</tr>
<tr>
<td>new_trapped</td><td>Set the TRAPPED metadata</td>
</tr>
<tr>
<td>new_user_password</td><td>User password of the protected PDF file.</td>
</tr>
<tr>
<td>new_version</td><td>Set the VERSION metadata</td>
</tr>
<tr>
<td>output_filename</td><td>ODT output file path. 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
</tr>
<tr>
<td>password</td><td>Password of the protected PDF file.</td>
</tr>
</table>

### odt2pdf

Convert an ODT file to a PDF file: with LibreOffice (u_convert) when it is installed, the fonts from fonts_folder or font_paths being embedded for the conversion, otherwise with the converter of the previous versions (XDocReport + iText 2.1.7, jars in libs/legacy_pdf). The global symbol lib_fill_odt_pdf.odt2pdf_converter forces the converter: auto (default), libreoffice or legacy.

**variables**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>font_aliases</td><td>Font aliases according to font_paths values.</td>
</tr>
<tr>
<td>font_paths</td><td>Font absolute paths to register.</td>
</tr>
<tr>
<td>fonts_folder</td><td>Folder absolute path containing the Fonts to register. Font name alias computed from file name. Use font_paths and font_aliases to manually declare fonts instead.</td>
</tr>
<tr>
<td>input_filename</td><td>ODT input file name to convert. 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
</tr>
<tr>
<td>output_filename</td><td>PDF output file path. 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
</tr>
</table>

### soffice_odt2pdf

Convert an ODT file to a PDF file using LibreOffice (u_convert). The soffice_path variable is ignored, set the global symbol lib_fill_odt_pdf.soffice_path instead.

**variables**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>input_filename</td><td>ODT input file name to convert. 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
</tr>
<tr>
<td>output_filename</td><td>PDF output file path. 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
</tr>
<tr>
<td>soffice_path</td><td>Ignored (security): the LibreOffice executable comes from the global symbol lib_fill_odt_pdf.soffice_path, the SOFFICE_PATH environment variable or the default install paths.</td>
</tr>
</table>

### u_convert

Converts a document with LibreOffice (headless) to another format: pdf, docx, xlsx, pptx, odt, ods, odp, doc, xls, ppt, rtf, txt, csv, html, epub, png, svg...
The input can be any document LibreOffice opens (odt, ods, odp, docx, xlsx, pptx...).
LibreOffice is resolved from the global symbol 'lib_fill_odt_pdf.soffice_path', then the SOFFICE_PATH environment variable, then the default install paths, then 'soffice' from the PATH.
Fonts from fonts_folder / font_paths are embedded in a copy of an ODF input for the conversion (TrueType fonts).
Optional LibreOffice pool (JODConverter, about 50 ms per conversion instead of 2 s): set the global symbol 'lib_fill_odt_pdf.office_pool_size' to the number of LibreOffice processes to keep running (ports from 'lib_fill_odt_pdf.office_pool_port', default 2002). 0 or empty = one LibreOffice process per conversion.
It outputs an attachment structure: call it with the .bin requester from a wrapper sequence to trigger a download in the client browser.

**variables**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>delete_at_end_of_session</td><td>Set to 'false' to keep the generated file when the HTTP session ends. Default is 'true'.</td>
</tr>
<tr>
<td>font_aliases</td><td>Font names used in the document for each font_paths entry. Defaults to the font family name of the file.</td>
</tr>
<tr>
<td>font_paths</td><td>Font files to embed for the conversion (ODF inputs). Each entry is a path, or a JSON array of paths.</td>
</tr>
<tr>
<td>fonts_folder</td><td>Folder containing TrueType fonts to embed for the conversion (ODF inputs). Only the fonts used by the document are embedded. 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
</tr>
<tr>
<td>input_filename</td><td>Input document path (odt, ods, odp, docx, xlsx, pptx...). 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
</tr>
<tr>
<td>output_filename</td><td>Output document path. Its extension defines the target format when 'target_format' is empty. 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
</tr>
<tr>
<td>target_format</td><td>Optional target format, for example 'pdf', 'docx', 'xlsx', 'pptx', 'odt'. Defaults to the output file extension. A LibreOffice filter can be forced, for example pdf:writer_pdf_Export:{"SelectPdfVersion":{"type":"long","value":"2"}} for PDF/A-2.</td>
</tr>
<tr>
<td>timeout</td><td>Maximum conversion time in seconds. Default is 120.</td>
</tr>
</table>

### u_create_ods

Create a new Calc document from a structured JSON (odfdom 0.13 table API). It outputs an attachment structure.

**variables**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>output_filename</td><td>ODS output file path. 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
</tr>
<tr>
<td>rows</td><td>Structured object as follow : 

{
	"sheets":
	[
		"name": "&lt;Sheet name&gt;",
		"header": 
		{
			"style": //Optional
			{
				"bgColor": "&lt;Background color&gt;",
				"HAlign": "&lt;Horizontal alignment&gt;",
				"VAlign": "&lt;Vertical alignment&gt;",
				"fontName": "&lt;Font name&gt;",
				"fontStyle": "&lt;Font style&gt;",
				"fontColor": "&lt;Font color&gt;",
				"fontSize": "&lt;Font size&gt;"
			},
			"value": [&lt;Array of strings&gt;]
		},
		"data":
		[
			[
				{
					"value" : "&lt;Cell content&gt;",
					"type": "&lt;Cell type&gt;"
				}
			]
		]
	]
}</td>
</tr>
</table>

### u_create_odt

Create a new Text document from the markers (one block per marker, in order) with u_fill_odt. Same marker types as u_fill_odt.

**variables**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>markers</td><td>Structured array as follow : 

[
	{
		"tag": "&lt;tag name in template file to replace with 'value' key&gt;",
		"type": "&lt;tag type. 'image' or 'string' supported&gt;",
		"value": "&lt;replacement string or image absolute path&gt;"
	}
]></td>
</tr>
<tr>
<td>output_filename</td><td>Output ODT file name (without extension). 
'.odt' is automatically added to filename to be opened by Ms Word or LibreOffice.</td>
</tr>
</table>

### u_export_data_to_sheet

Use to export data to various file format (txt, csv, xlsx, ods...). Uses the SheetJS CE framework.

**Output**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>file</td><td>local_path -> Server local file path.<br> url_path -> Server file path url.</td>
</tr>
<tr>
<td>attachment</td><td>@local-url -> Server local file path.<br>@name -> File name.</td>
</tr>
<tr>
<td>success</td><td>true/false</td>
</tr>
<tr>
<td>error</td><td>Error message.</td>
</tr>
</table>

**variables**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>book_type</td><td>Type of workbook to export to. Default is XLSX.</td>
</tr>
<tr>
<td>output_filename</td><td>Output file path. 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace pat</td>
</tr>
<tr>
<td>rows</td><td>Structured object as follow: 

{
	"sheets":
	[
		"name": "&lt;Sheet name&gt;",
		"header": 
		{
			"style": //Optional
			{
				"bgColor": "&lt;Background color&gt;",
				"HAlign": "&lt;Horizontal alignment&gt;",
				"VAlign": "&lt;Vertical alignment&gt;",
				"fontName": "&lt;Font name&gt;",
				"fontStyle": "&lt;Font style&gt;",
				"fontColor": "&lt;Font color&gt;",
				"fontSize": "&lt;Font size&gt;"
			},
			"value": [&lt;Array of strings&gt;]
		},
		"data":
		[
			[
				{
					"value" : "&lt;Cell content&gt;",
					"type": "&lt;Cell type&gt;"
				}
			]
		]
	]
}</td>
</tr>
</table>

### u_fill_odt

Fills a document template (Universal): OpenDocument (ODT, ODS, ODP) or designed with Word, PowerPoint or Excel (docx, pptx, xlsx and their dotx, potx, xltx, docm, pptm, xlsm variants).
Body, headers and footers, master pages, notes and tables are filled. Place your template files in .//templates/odf, .//templates/odp or .//templates/office folder.
OpenDocument templates are filled with odfdom-java 0.13 (no Simple API), Office templates by u_fill_ooxml (direct edit of the Office XML, the formatting of the template is kept). See the markers variable for the marker types.
It outputs an attachment structure, the tags not found and the marker errors. If you call it with .bin requester it will trigger a download in the client Browser.

**variables**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>break_before</td><td>Define the BreakBefore table style property of the table, tableh and tablet markers. Can be 'auto', 'column' or 'page'. Default is set to 'page'.</td>
</tr>
<tr>
<td>delete_at_end_of_session</td><td>Set to 'false' to keep the generated file when the HTTP session ends. Default is 'true'.</td>
</tr>
<tr>
<td>input_filename</td><td>Template file to fill: OpenDocument (odt, ods, odp) or designed with Word, PowerPoint or Excel (docx, pptx, xlsx, and the dotx, potx, xltx, docm, pptm, xlsm variants). 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
</tr>
<tr>
<td>markers</td><td>Array of markers, as a JSON string or a structured variable: 
[ { "tag": "{name}", "type": "string", "value": "...", "style": {...} }, ... ] 
Types: 
- string / paragraph (default): text, \n = line break, \t = tab. 
- newline: line break. 
- span: text with style { fontName, fontStyle (REGULAR, BOLD, ITALIC, BOLDITALIC), fontSize, fontColor }. 
- image: value = image path or data URI. Tag = frame or picture name (Office: Alt text title or name), text frame holding only the tag, or text tag (inline picture; Excel: picture anchored on the cell). Options: fit (contain, stretch), width, height. 
- table / tableh (first row is a header) / tablet (styles from table_template_file): value = 2D array, style { header, defaults, cells: { "row-col": {...} } } with fontName, fontStyle, fontSize, fontColor, cellHAlign, cellVAlign, cellBGColor, merges [ { row, col, rowspan, colspan } ]. Excel: same as rows. PowerPoint: use rows. 
- array: value = array of markers without tag, inserted one after the other. 
- list: value = array of strings, the paragraph or list item holding the tag is repeated (Excel: one row per value). 
- rows: value = 2D array, the table row holding the tag is repeated. Excel: the sheet row holding the tag is repeated, the rows below are shifted and formulas, merged cells, tables and charts are updated. 
- slides: value = array of items (array of markers, or object with a markers array), the slide holding the tag is repeated (ODP, PPTX). 
Look at demo_u_fill_odt, demo_u_fill_table_odt, demo_u_fill_odp and demo_u_fill_office for examples.</td>
</tr>
<tr>
<td>meta_creation_date</td><td>Defines the Creation Date metadata of the document. ISO 8601 date format: yyyy-MM-dd'T'HH:mm:ss, or 'now'. If null or empty, does not change it.</td>
</tr>
<tr>
<td>meta_description</td><td>Defines the Description metadata of the document. If null, does not change it. If empty, removes it.</td>
</tr>
<tr>
<td>meta_initial_creator</td><td>Defines the Creator metadata of the document. If null, does not change it. If empty, removes it.</td>
</tr>
<tr>
<td>meta_keywords</td><td>Defines the Keywords metadata of the document. Multi-valued variable. Each entry is a keyword. If null, does not change it. If empty, removes it.</td>
</tr>
<tr>
<td>meta_subject</td><td>Defines the Subject metadata of the document. If null, does not change it. If empty, removes it.</td>
</tr>
<tr>
<td>meta_title</td><td>Defines the Title metadata of the document. If null, does not change it. If empty, removes it.</td>
</tr>
<tr>
<td>output_filename</td><td>Output file path, in the format of the template (a dotx, potx or xltx template can be saved as docx, pptx or xlsx). 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
</tr>
<tr>
<td>table_template_file</td><td>Path of the file containing a table to use as a template for the tablet markers: an ODT file for an OpenDocument template, a DOCX file for a Word template.</td>
</tr>
<tr>
<td>table_template_name</td><td>Name of the template table (Word: Alt text title of the table). Defaults to the only table of the file.</td>
</tr>
</table>

### u_fill_ooxml

Fills a template designed with Microsoft Office: Word (docx, dotx, docm), PowerPoint (pptx, potx, pptm) or Excel (xlsx, xltx, xlsm).
Called by u_fill_odt for these templates, with the same variables and markers: call u_fill_odt.
The package is edited in place (direct edit of the Office XML): only the parts holding tags are rewritten, the formatting of the template is kept and LibreOffice is not needed. Tags split by Office across runs (spell check, revisions) are found.
It outputs an attachment structure, the tags not found and the marker errors.

**variables**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>break_before</td><td>Break before the tables of the table, tableh and tablet markers (Word): 'auto', 'column' or 'page'. Default is 'page'.</td>
</tr>
<tr>
<td>delete_at_end_of_session</td><td>Set to 'false' to keep the generated file when the HTTP session ends. Default is 'true'.</td>
</tr>
<tr>
<td>input_filename</td><td>Template file to fill, designed with Word, PowerPoint or Excel: docx, pptx, xlsx, or the dotx, potx, xltx, docm, pptm, xlsm variants. 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
</tr>
<tr>
<td>markers</td><td>Array of markers, as a JSON string or a structured variable: 
[ { "tag": "{name}", "type": "string", "value": "...", "style": {...} }, ... ] 
Types: 
- string / paragraph (default): text, \n = line break, \t = tab. 
- newline: line break. 
- span: text with style { fontName, fontStyle (REGULAR, BOLD, ITALIC, BOLDITALIC), fontSize, fontColor }. 
- image: value = image path or data URI. Tag = frame or picture name (Office: Alt text title or name), text frame holding only the tag, or text tag (inline picture; Excel: picture anchored on the cell). Options: fit (contain, stretch), width, height. 
- table / tableh (first row is a header) / tablet (styles from table_template_file): value = 2D array, style { header, defaults, cells: { "row-col": {...} } } with fontName, fontStyle, fontSize, fontColor, cellHAlign, cellVAlign, cellBGColor, merges [ { row, col, rowspan, colspan } ]. Excel: same as rows. PowerPoint: use rows. 
- array: value = array of markers without tag, inserted one after the other. 
- list: value = array of strings, the paragraph or list item holding the tag is repeated (Excel: one row per value). 
- rows: value = 2D array, the table row holding the tag is repeated. Excel: the sheet row holding the tag is repeated, the rows below are shifted and formulas, merged cells, tables and charts are updated. 
- slides: value = array of items (array of markers, or object with a markers array), the slide holding the tag is repeated (ODP, PPTX). 
Look at demo_u_fill_odt, demo_u_fill_table_odt, demo_u_fill_odp and demo_u_fill_office for examples.</td>
</tr>
<tr>
<td>meta_creation_date</td><td>Defines the Creation Date metadata of the document. ISO 8601 date format: yyyy-MM-dd'T'HH:mm:ss, or 'now'. If null or empty, does not change it.</td>
</tr>
<tr>
<td>meta_description</td><td>Defines the Description metadata of the document. If null, does not change it. If empty, removes it.</td>
</tr>
<tr>
<td>meta_initial_creator</td><td>Defines the Creator metadata of the document. If null, does not change it. If empty, removes it.</td>
</tr>
<tr>
<td>meta_keywords</td><td>Defines the Keywords metadata of the document. Multi-valued variable. Each entry is a keyword. If null, does not change it. If empty, removes it.</td>
</tr>
<tr>
<td>meta_subject</td><td>Defines the Subject metadata of the document. If null, does not change it. If empty, removes it.</td>
</tr>
<tr>
<td>meta_title</td><td>Defines the Title metadata of the document. If null, does not change it. If empty, removes it.</td>
</tr>
<tr>
<td>output_filename</td><td>Output file path, in the format of the template (a dotx, potx or xltx template can be saved as docx, pptx or xlsx). 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
</tr>
<tr>
<td>table_template_file</td><td>Path of the file containing a table to use as a template for the tablet markers: an ODT file for an OpenDocument template, a DOCX file for a Word template.</td>
</tr>
<tr>
<td>table_template_name</td><td>Name of the template table (Word: Alt text title of the table). Defaults to the only table of the file.</td>
</tr>
</table>

### u_fill_pdf

Fills a PDF template file (Universal). 
Place your template file in .//templates/pdf folder.
It will output an attachment structure and if you call it with .bin requester it will trigger a download in the client Browser.

**variables**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>input_filename</td><td>PDF input file path. 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
</tr>
<tr>
<td>markers</td><td>Structured array as follow : 

[
	{
		"tag": "&lt;tag name in template file to replace with 'value' key&gt;",
		"type": "&lt;tag type. 'image' or 'string' supported&gt;",
		"value": "&lt;replacement string or image absolute path&gt;"
	}
]</td>
</tr>
<tr>
<td>output_filename</td><td>PDF output file path. 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
</tr>
</table>

### u_read_odt

Dev sequence to read the first cell of a table from a Text Document (odfdom 0.13 table API).

**variables**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>markers</td><td>Structured array as follow : 

[
	{
		"tag": "&lt;tag name in template file to replace with 'value' key&gt;",
		"type": "&lt;tag type. 'image' or 'string' supported&gt;",
		"value": "&lt;replacement string or image absolute path&gt;"
	}
]></td>
</tr>
<tr>
<td>output_filename</td><td>Output ODT file name (without extension). 
'.odt' is automatically added to filename to be opened by Ms Word or LibreOffice.</td>
</tr>
<tr>
<td>table_name</td><td>Name of the table to read. Defaults to table1, then to the first table of the document.</td>
</tr>
</table>

### u_read_pdf

Reads a PDF file (Universal). 
Place your template file in .//read folder.
It will output the following structure : { "array": [ { "name": "<technical PDF Form name>", "value": "<PDF Form value>", "type": "PDF Form type" }, ...]

**variables**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>input_filename</td><td>PDF input file name to read the technical fields name and value.
Can be an absolute path or a relative Convertigo path.
".//" is relative to the project's path.
"./" is relative to the workspace path.</td>
</tr>
</table>



