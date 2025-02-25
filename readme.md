


# lib_fill_odt_pdf

ODFToolkit and PDF library


For more technical informations : [documentation](./project.md)

- [Installation](#installation)
- [Sequences](#sequences)
    - [clean_outputs](#clean_outputs)
    - [demo_u_fill_odt](#demo_u_fill_odt)
    - [demo_u_fill_pdf](#demo_u_fill_pdf)
    - [fill_odt](#fill_odt)
    - [fill_pdf](#fill_pdf)
    - [u_create_odt](#u_create_odt)
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

### clean_outputs

Clean the generated files from the 'outputs' or 'read' directories. Can be used in a Convertigo scheduled job to automate the process. Variables : 'max_time' => delete only files older than x ms. 'all' => Delete all files in folder even in a max_time is defined. 'target' => if value is 'fill' searches for files in 'outputs' folder else in 'read' folder.

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

### demo_u_fill_odt

Demo sequence to fill an ODT template file.

### demo_u_fill_pdf

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

### u_create_odt

Create a new Text document with a table.

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

### u_fill_odt

Fills an ODT template file (Universal).
Place your template files in .//templates/odf folder.
It will output an attachment structure and if you call it with .bin requester it will trigger a download in the client Browser.

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
<td>output_filename</td><td>ODT output file path. 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
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
]></td>
</tr>
<tr>
<td>output_filename</td><td>PDF output file path. 
Can be an absolute path or a relative Convertigo path: 
".//" is relative to the project's path. 
"./" is relative to the workspace path.</td>
</tr>
</table>

### u_read_odt

Dev sequence to read a table from a Text Document.

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



