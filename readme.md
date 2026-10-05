


# lib_fill_odt_pdf

ODFToolkit and PDF library


For more technical informations : [documentation](./project.md)

- [Installation](#installation)
- [Sequences](#sequences)
    - [autoRemoveFolder](#autoremovefolder)
    - [clean_outputs](#clean_outputs)
    - [ctx_server_set](#ctx_server_set)
    - [demo_export_data_to_sheet](#demo_export_data_to_sheet)
    - [demo_u_fill_odp](#demo_u_fill_odp)
    - [demo_u_fill_odt](#demo_u_fill_odt)
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
     lib_fill_odt_pdf=https://github.com/convertigo/c8oprj-lib-odftoolkit.git:branch=master
     ```
     </td></tr>
     <tr><td>To simply use</td><td>

     ```
     lib_fill_odt_pdf=https://github.com/convertigo/c8oprj-lib-odftoolkit/archive/master.zip
     ```
     </td></tr>
    </table>
3. Click the `Finish` button. This will automatically import the __lib_fill_odt_pdf__ project


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

Auto start sequence to install some required fonts for Docker Linux Platform.

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

Convert an ODT file to a PDF file with LibreOffice (u_convert). Fonts from fonts_folder or font_paths are embedded for the conversion.

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

Fills an ODT, ODS or ODP template (Universal): body, headers and footers, master pages, notes and tables.
Place your template files in .//templates/odf (or .//templates/odp) folder.
Built on odfdom-java 0.13 (no Simple API). See the markers variable for the marker types.
It outputs an attachment structure, the tags not found and the marker errors. If you call it with .bin requester it will trigger a download in the client Browser.

**variables**

<table>
<tr>
<th>name</th><th>comment</th>
</tr>
<tr>
<td>break_before</td><td>Define the BreakBefore table style property. Can be 'auto', 'column' or 'page'. Default is set to 'page'.</td>
</tr>
<tr>
<td>delete_at_end_of_session</td><td>Set to 'false' to keep the generated file when the HTTP session ends. Default is 'true'.</td>
</tr>
<tr>
<td>input_filename</td><td>ODT input template file name to fill. 
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
- image: value = image path or data URI. Tag = frame name, text frame holding only the tag, or text tag (inline picture). Options: fit (contain, stretch), width, height. 
- table / tableh (first row is a header) / tablet (styles from table_template_file): value = 2D array, style { header, defaults, cells: { "row-col": {...} } } with fontName, fontStyle, fontSize, fontColor, cellHAlign, cellVAlign, cellBGColor, merges [ { row, col, rowspan, colspan } ]. 
- array: value = array of markers without tag, inserted one after the other. 
- list: value = array of strings, the paragraph or list item holding the tag is repeated. 
- rows: value = 2D array, the table row holding the tag is repeated. 
- slides: value = array of items (array of markers, or object with a markers array), the slide holding the tag is repeated. 
Look at demo_u_fill_odt, demo_u_fill_table_odt and demo_u_fill_odp for examples.</td>
</tr>
<tr>
<td>meta_creation_date</td><td>Defines the Creation Date metadata in the ODT Document. ISO 8601 date format: yyy-MM-dd'T'HH:mm:ss. If null or empty, does not change it.</td>
</tr>
<tr>
<td>meta_description</td><td>Defines the Description metadata in the ODT Document. If null, does not change it. If empty, removes it.</td>
</tr>
<tr>
<td>meta_initial_creator</td><td>Defines the Creator metadata in the ODT Document. If null, does not change it. If empty, removes it.</td>
</tr>
<tr>
<td>meta_keywords</td><td>Defines the Keywords metadata in the ODT Document. Multi-valued variable. Each entry is a keyword. If null, does not change it. If empty, removes it.</td>
</tr>
<tr>
<td>meta_subject</td><td>Defines the Subject metadata in the ODT Document. If null, does not change it. If empty, removes it.</td>
</tr>
<tr>
<td>meta_title</td><td>Defines the Title metadata in the ODT Document. If null, does not change it. If empty, removes it.</td>
</tr>
<tr>
<td>output_filename</td><td>ODT output file path. 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
</tr>
<tr>
<td>table_template_file</td><td>Path of the ODT file containing a table to use as a template.</td>
</tr>
<tr>
<td>table_template_name</td><td>Name of the template table.</td>
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



