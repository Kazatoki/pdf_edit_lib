# pdf_edit

# Environment

- Windows 10
- Powershell 5.0 or higher

# Setup

## Install PDFtk

Please download PDFtk and use Installer.
https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/

## setting Path(environment variable)

Please add ```~/pdf_edit/bin``` and ```~/plugins/qpdf-9.0.1/bin``` to the Environment Path.

```powershell
cd setup
.\settingPath.ps1
```

By executing this batch file, you can use the following commands from anywhere.

- ```pdf_split.ps1``` : Disassemble specified PDF page by page.
- ```pdf_join.ps1``` : Combine specified PDFs into one file.
- ```pdf_unlock.ps1``` : Unlock PDF's Password.

This setting applies only when used with powershell.
If you want to remove Environment Path, You need to use ```~/pdf_edit/setup/removePath.ps1```.

# How to use

## pdf_split.ps1

By specifying a PDF file, it can be broken apart page by page.

```powershell
pdf_split.ps1 -filePath input.pdf [ -destPath destinationFolder ]
```

### Example

```powershell
pdf_split.ps1 .\test.pdf 
```

You can also set the output destination.

```powershell
pdf_split.ps1 .\test.pdf $home\Documents
```

## pdf_join.ps1

Combine specified PDFs into one file.
The created file is saved in the same folder as the referenced file with a symbol (```"_combine"```) at the end of the file name.

```powershell
pdf_join.ps1 input1.pdf input2.pdf [ input3.pdf ... ]
```

### Example

```powershell
pdf_split.ps1 .\test1.pdf .\test2.pdf .\test3.pdf
```

This command can't set the output destination.

## pdf_unlock.ps1

By specifying a PDF file and password, it can be unlocked password.

```powershell
pdf_unlock.ps1 -filePath input.pdf [ -destPath destinationFolder ]
```

### Example

```powershell
pdf_split.ps1 .\test.pdf 
```

You can also set the output destination.

```powershell
pdf_split.ps1 .\test.pdf $home\Documents
```

# Convenient usage

## Drag and drop PDF File and Split (Combine)

Create a shortcut for the ```pdf_split.ps1``` and set the following as the shortcut link destination.
If you drag and drop a file on this shortcut, the file is split.

```
powershell -NoProfile -ExecutionPolicy Unrestricted -File pdf_split.ps1
```

```pdf_join.ps1``` and ```pdf_unlock.ps1``` can be set in the same way.

```
powershell -NoProfile -ExecutionPolicy Unrestricted -File pdf_join.ps1
```

