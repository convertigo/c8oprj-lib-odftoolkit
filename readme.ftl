<#-- This FTL template helps generating the readme.md file of your project -->
<#-- see FTL language documentation : https://freemarker.apache.org/docs/index.html -->

<#-- GLOBALS -->
<#global lineBreak = settings.lineBreak />
<#global locale = "US" />
<#global dictionnary = {
		"installation":	{"US": "Installation"			, "FR": "Installation"},
		"more.info": 	{"US": "For more technical informations"	, "FR": "Pour plus d'informations techniques"},
		"connectors": 	{"US": "Connectors"				, "FR": "Connecteurs"},
		"transactions": {"US": "Transactions"			, "FR": "Transactions"},
		"sequences": 	{"US": "Sequences"				, "FR": "Séquences"},
		"references": 	{"US": "References"				, "FR": "Références"},
		"urlmapper": 	{"US": "Rest Web Service"		, "FR": "Service Web REST"},
		"mappings": 	{"US": "Mappings"				, "FR": "Mappages"},
		"operations": 	{"US": "Operations"				, "FR": "Operations"},
		"parameters": 	{"US": "Parameters"				, "FR": "Paramètres"},
		"mobileapp": 	{"US": "Mobile Application"		, "FR": "Application Mobile"},
		"mobilelib": 	{"US": "Mobile Library"			, "FR": "Librairie Mobile"},
		"pages": 		{"US": "Pages"					, "FR": "Pages"},
		"actions": 		{"US": "Shared Actions"			, "FR": "Actions partagées"},
		"components": 	{"US": "Shared Components"		, "FR": "Composants partagés"},
		"variables": 	{"US": "variables"				, "FR": "variables"},
		"events": 		{"US": "events"					, "FR": "évènements"}
	}
/>
<#-- please modify the global show values as needed -->
<#global show = {
	"toc"			: true,
	"installation"	: true,
	
	"connectors"	: false,
	"transactions"	: true,
	"sequences"		: !has(project, "urlmapper") && !has(project, "mobileapp"),
	
	"references"	: false,
	
	"urlmapper"		: true,
	"mappings"		: true,
	"operations"	: true,
	"parameters"	: true,
	
	"mobileapp"		: true,
	"pages"			: !project.name?starts_with("lib_"),
	"actions"		: true,
	"components"	: true,
	
	"variables"		: true,
	"events"		: true
	} 
/>

<#-- FUNCTIONS -->
<#-- on: returns the show flag for the given key -->
<#function on key>
  <#return show[key]?? && show[key]>
</#function>

<#-- on: test if given dbo has the given key with non empty size -->
<#function has dbo key>
  <#return dbo[key]?? && (dbo[key]?size > 0) >
</#function>

<#-- anchor: generates an anchor link for the given text -->
<#function anchor anchors text>
  <#assign a = ""+ text?lower_case?replace(" ", "-")?replace("/", "")>
  <#if anchors?seq_contains(a)>
  	<#assign f = anchors?filter(s -> s?matches(""+ a + "-(\\d+)"))>
  	<#assign a = ""+ a + "-" + (f?size+1)>
  </#if>
  <#assign anchors += [""+a]>
  <#return a>
</#function>

<#-- on: returns the dictionnary value for the given key -->
<#function help key>
  <#if has(dictionnary, key)>
    <#return dictionnary[key][locale]!key>
  </#if>
  <#return key>
</#function>

<#-- MACROS -->
<#-- header: generates a header with given text as heading and add it to TOC with its anchor link -->
<#macro header toc anchors heading text>
${heading} ${text}${lineBreak}
<#assign a = anchor(anchors, text)>
<#if (heading?keep_before_last("#")?length > 0)>
<#assign toc += "" + heading?keep_before_last("##")?replace("#","    ") + "-" + " ["+text+"](#"+ a +")" + lineBreak>
</#if>
</#macro>

<#-- comment: add given text -->
<#macro comment text>
<#if (text?length > 0) >
${text}${lineBreak}
</#if>
</#macro>

<#-- table: generates a table with given headers and rows -->
<#macro table title headers rows>
<#if (rows?size > 0)>
${title}${lineBreak}
<table>
<tr>
<#list headers as header><th>${header}</th></#list>
</tr>
<#list rows as i>
<tr>
<#list headers as header><td>${i[header]}</td></#list>
</tr>
</#list>
</table>${lineBreak}
</#if>
</#macro>

<#-- installation : add project installation instructions if any -->
<#macro installation>
<#if locale == "US">
1. In your Convertigo Studio use `File->Import->Convertigo->Convertigo Project` and hit the `Next` button
2. In the dialog `Project remote URL` field, paste the text below:
   <table>
     <tr><td>Usage</td><td>Click the copy button</td></tr>
     <tr><td>To contribute</td><td>${lineBreak}
     ```
     ${project.contributeUrl}
     ```
     </td></tr>
     <tr><td>To simply use</td><td>${lineBreak}
     ```
     ${project.usageUrl}
     ```
     </td></tr>
    </table>
3. Click the `Finish` button. This will automatically import the __${project.name}__ project
</#if>
<#if locale == "FR">
1. Dans votre Studio Convertigo, utilisez `File->Import->Convertigo->Convertigo Project` et appuyez sur le bouton `Next`
2. Dans le champ `Project remote URL` de la boîte de dialogue, collez le texte ci-dessous:
   <table>
     <tr><td>Usage</td><td>Cliquez sur le bouton de copie</td></tr>
     <tr><td>Pour contribuer</td><td>${lineBreak}
     ```
     ${lineBreak}${project.contributeUrl}
     ```
     </td></tr>
     <tr><td>Pour simplement utiliser</td><td>${lineBreak}
     ```
     ${lineBreak}${project.usageUrl}
     ```
     </td></tr>
    </table>
3. Cliquez sur le bouton `Finish`. Cela importera automatiquement le projet __${project.name}__
</#if>
${lineBreak}
</#macro>

<#-- DEFAULT PROJECT TEMPLATE -->

<#-- anchors variable for TOC : do not modify -->
<#assign anchors = [""]>
<#-- toc variable : do not modify -->
<#assign toc = "">

<#-- Please modify below templates as needed -->

<#-- intro variable : add project header and comment -->
<#assign intro>
	<@header toc=toc anchors=anchors heading="#" text=project.label />
	<@comment text=project.comment />
	<#-- you can add your text or own macro call here to add something -->
	<#--
	This is text i want to add after the project comment
	<@my_own_macro my_var='xxxx xxxxx xxxxx'>
	-->
</#assign>

<#-- content variable : add project sub-beans header and comment -->
<#-- you can add your text or own macro call anywhere -->
<#assign content>
<#if on("installation") && (project.url?length > 0) && (project.url != project.name)>
	<@header toc=toc anchors=anchors heading="##" text=help("installation") />
	<@installation />
</#if>
<#-- lib_fill_odt_pdf: sections written by hand, the sequences below are generated from their comments -->
<@header toc=toc anchors=anchors heading="##" text="Overview" />
<#noparse>
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

</#noparse>
<@header toc=toc anchors=anchors heading="##" text="Quick start" />
<#noparse>
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

</#noparse>
<@header toc=toc anchors=anchors heading="##" text="Configuration" />
<#noparse>
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

</#noparse>
<@header toc=toc anchors=anchors heading="##" text="Upgrading from version 1" />
<#noparse>
Version 2.0 is built on odfdom-java 0.13 instead of simple-odf 0.9. The existing sequences and their variables are unchanged, so the projects that use the library keep working. Only optional variables were added (`delete_at_end_of_session` in `u_fill_odt`, `table_name` in `u_read_odt`). Points to check:

- **Jars**: simple-odf 0.9, iText 2.1.7 and XDocReport are no longer in `libs` (the copy kept in `libs/legacy_pdf` is only loaded by `odt2pdf`). A project that references this library sees its jars: if its own code uses `com.lowagie` (iText) classes, add iText 2.1.7 to its `libs`. Code using `org.odftoolkit.simple` or the odfdom 0.9 API must be ported to odfdom 0.13 or replaced by calls to the sequences of the library: odfdom 0.9 can not be loaded next to odfdom 0.13.
- **`odt2pdf`**: converts with LibreOffice when it is installed, otherwise with the converter of the previous versions. Its result is unchanged.
- **`soffice_odt2pdf`**: the `soffice_path` variable is ignored for security reasons. When LibreOffice is not in a default install path, set the `lib_fill_odt_pdf.soffice_path` global symbol or the `SOFFICE_PATH` environment variable.
- **`u_fill_odt`, `u_create_odt`, `fill_odt`**: the result also contains `not_found` and `marker_errors`. The items of an `array` marker no longer take the formatting of the previous `span` item.
- **`u_create_ods`**: returns an `attachment` element and prints all the sheets.
- **`clean_outputs`**: can only be called from a sequence (Private) and only deletes the generated file types of `.//outputs`. Files older than `max_time` are deleted (24 h by default). At startup, `autoRemoveFolder` deletes the files older than 10 minutes.

</#noparse>
<#if on("references") && has(project,"references")>
  	<@header toc=toc anchors=anchors heading="##" text=help("references") />
  	<#list project.references as reference>
    	<@header toc=toc anchors=anchors heading="###" text=reference.label />
    	<@comment text=reference.comment />
  	</#list>
</#if>
<#if on("sequences") && has(project,"sequences")>
  	<@header toc=toc anchors=anchors heading="##" text=help("sequences") />
  	<#list project.sequences as sequence>
    	<@header toc=toc anchors=anchors heading="###" text=sequence.label />
    	<@comment text=sequence.comment />
    	<#if on("variables") && has(sequence,"variables")>
      		<@table title="**"+help("variables")+"**" headers=["name","comment"] rows=sequence.variables />
    	</#if>
  </#list>
</#if>
<#if on("connectors") && has(project,"connectors")>
  	<@header toc=toc anchors=anchors heading="##" text=help("connectors") />
  	<#list project.connectors as connector>
    	<@header toc=toc anchors=anchors heading="###" text=connector.label />
    	<@comment text=connector.comment />
    	<#if on("transactions") && has(connector,"transactions")>
      		<@header toc=toc anchors=anchors heading="####" text=help("transactions") />
      		<#list connector.transactions as transaction>
        		<@header toc=toc anchors=anchors heading="#####" text=transaction.label />
        		<@comment text=transaction.comment />
        		<#if on("variables") && has(transaction,"variables")>
          			<@table title="**"+help("variables")+"**" headers=["name","comment"] rows=transaction.variables />
        		</#if>
      		</#list>
    	</#if>
  	</#list>
</#if>
<#if on("urlmapper") && has(project,"urlmapper")>
  	<@header toc=toc anchors=anchors heading="##" text=help("urlmapper") />
  	<@comment text=project.urlmapper.comment />
  	<#if on("mappings") && has(project.urlmapper,"mappings")>
	  	<@header toc=toc anchors=anchors heading="###" text=help("mappings") />
	  	<#list project.urlmapper.mappings as mapping>
	    	<@header toc=toc anchors=anchors heading="####" text=mapping.label />
	    	<@comment text=mapping.comment />
	    	<#if on("operations") && has(mapping,"operations")>
	      		<@header toc=toc anchors=anchors heading="#####" text=help("operations") />
	      		<#list mapping.operations as operation>
	        		<@header toc=toc anchors=anchors heading="######" text=operation.label />
	        		<@comment text=operation.comment />
	        		<#if on("parameters") && has(operation,"parameters")>
	          			<@table title="**"+help("parameters")+"**" headers=["name","comment"] rows=operation.parameters />
	        		</#if>
	      		</#list>
	    	</#if>
	  </#list>
	</#if>
</#if>
<#if on("mobileapp") && has(project,"mobileapp")>
	<#assign appname = (project.mobileapp.applicationName?length > 0)
			?string(project.mobileapp.applicationName, (project.name?starts_with("lib_"))?string(help("mobilelib"),help("mobileapp"))) />
  	<@header toc=toc anchors=anchors heading="##" text=appname />
  	<@comment text=project.mobileapp.comment />
  	<#if on("pages") && has(project.mobileapp,"pages")>
	  	<@header toc=toc anchors=anchors heading="###" text=help("pages") />
	  	<#list project.mobileapp.pages as page>
	    	<@header toc=toc anchors=anchors heading="####" text=page.label />
	    	<@comment text=page.comment />
 	  </#list>
	</#if>
  	<#if on("actions") && has(project.mobileapp,"actions")>
	  	<@header toc=toc anchors=anchors heading="###" text=help("actions") />
	  	<#list project.mobileapp.actions as action>
	    	<@header toc=toc anchors=anchors heading="####" text=action.label />
	    	<@comment text=action.comment />
    		<#if on("variables") && has(action,"variables")>
      			<@table title="**"+help("variables")+"**" headers=["name","comment"] rows=action.variables />
    		</#if>
	  </#list>
	</#if>
  	<#if on("components") && has(project.mobileapp,"components")>
	  	<@header toc=toc anchors=anchors heading="###" text=help("components") />
	  	<#list project.mobileapp.components as component>
	    	<@header toc=toc anchors=anchors heading="####" text=component.label />
	    	<@comment text=component.comment />
    		<#if on("variables") && has(component,"variables")>
      			<@table title="**"+help("variables")+"**" headers=["name","comment"] rows=component.variables />
    		</#if>
    		<#if on("events") && has(component,"events")>
      			<@table title="**"+help("events")+"**" headers=["name","comment"] rows=component.events />
    		</#if>
	  </#list>
	</#if>
</#if>
</#assign>


<#-- output project name and comment -->
${intro}
<#-- output project.md link -->
${help("more.info")} : [documentation](./project.md)

<#-- output table of content -->
<#if on("toc")>${toc}</#if>

<#-- output project content -->
${content}

