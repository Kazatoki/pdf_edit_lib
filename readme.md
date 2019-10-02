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
You can use ```~/setup/installer.vbs```. Please double click that vbs file.

By executing this batch file, you can use the following commands from anywhere.

- ```pdf_split.ps1``` : Disassemble specified PDF page by page.
- ```pdf_join.ps1``` : Combine specified PDFs into one file.
- ```pdf_unlock.ps1``` : Unlock PDF's Password.(Need to input password)

This setting applies only when used with powershell.
If you want to remove Environment Path, You need to use ```~/setup/uninstaller.vbs```.

# How to use

There are "command line" and "drag and drop" (recommended).

## Using the command line

### pdf_split.ps1

By specifying a PDF file, it can be broken apart page by page.

```powershell
pdf_split.ps1 -filePath input.pdf [ -destPath destinationFolder ]
```

#### Example

```powershell
pdf_split.ps1 .\test.pdf 
```

You can also set the output destination.

```powershell
pdf_split.ps1 .\test.pdf $home\Documents
```

### pdf_join.ps1

Combine specified PDFs into one file.
The created file is saved in the same folder as the referenced file with a symbol (```"_combine"```) at the end of the file name.
The page order of the output PDF will be ascending order of the specified file names.

```powershell
pdf_join.ps1 input1.pdf input2.pdf [ input3.pdf ... ]
```

#### Example

```powershell
pdf_split.ps1 .\test1.pdf .\test2.pdf .\test3.pdf
```

This command can't set the output destination.

### pdf_unlock.ps1

By specifying a PDF file and password, it can be unlocked password.

```powershell
pdf_unlock.ps1 -filePath input.pdf [ -destPath destinationFolder ]
```

#### Example

```powershell
pdf_split.ps1 .\test.pdf 
```

You can also set the output destination.

```powershell
pdf_split.ps1 .\test.pdf $home\Documents
```

## Drag and drop PDF File and Split (Combine)


Use the shortcuts created during installation( ```~/pdf_split.ps1```, ```~/pdf_join.ps1```, ```~/pdf_unlock.ps1```).

You can split, join, and unlock passwords by dragging and dropping PDF files on each shortcut icon.

The output destination of the file is created in the same location as the dragged and dropped file.
