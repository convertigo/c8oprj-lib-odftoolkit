


# lib_fill_odt_pdf

ODFToolkit library


For more technical informations : [documentation](./project.md)

- [Installation](#installation)
- [Sequences](#sequences)
    - [fill_odt](#fill_odt)
    - [fill_pdf](#fill_pdf)


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

### fill_odt

Fills an ODT template file.
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
<td>input_filename</td><td>Input DOC template file name to fill (without extension, '.doc' is assumed). 
Put your templates in <project_folder>/templates/odf</td>
</tr>
<tr>
<td>objet</td><td>Subject</td>
</tr>
<tr>
<td>output_filename</td><td>Output DOC file name (without extension). 
'.doc' is automatically added to filename.</td>
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

Fills a PDF template file. 
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



