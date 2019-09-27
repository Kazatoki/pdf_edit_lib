# pdf_edit

# Setup

## Install PDFtk

https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/

## setting Path(environment variable)

Please add ```~/pdf_edit/lib``` to the Path.

You can use ```~/pdf_edit/setup/settingPath.ps1```.

```powershell
.\settingPath.ps1
```
By executing this batch file, you can use the following commands from anywhere.
But this setting applies only when used with powershell.

If you want to remove path, You should use ```~/pdf_edit/setup/removePath.ps1```.

# How to use

## pdf_split

By specifying a PDF file, it can be broken apart page by page.

```powershell
pdf_split.ps1 -filePath inputFile [ -destPath destinationFolder ]
```

Example

```powershell
pdf_split.ps1 -filePath .\test.pdf 
```

### drag and drop PDF File and Split

Create a shortcut for the ```pdf_split.ps1``` file and set the following as the shortcut link destination.

```
powershell -NoProfile -ExecutionPolicy RemoteSigned -File pdf_split.ps1
```

You can also set the output destination.

```powershell
pdf_split.ps1 -filePath .\test.pdf $home\Documents
```

## pdf_join

Scheduled to create
