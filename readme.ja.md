# pdf_edit

# 環境

- Windows 10
- Powershell 5.0 以上

# Setup

## Install PDFtk

PDFtkをダウンロードし、インストールします。
https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/

## 環境変数を設定します。

```~/pdf_edit/lib``` を環境変数に追加します。

```powershell
cd setup
.\settingPath.ps1
```

上記のバッチファイルを実行することで、どこでも以下のコマンドが使用できるようになります。

- ```pdf_split.ps1``` : Disassemble specified PDF page by page.
- ```pdf_join.ps1``` : Combine specified PDFs into one file.

上記手順による設定は、Powershellを使用しているときしか反映されません。
もし設定した環境変数を削除したい場合は、```~/pdf_edit/setup/removePath.ps1``` を実行してください。

# 使い方

## pdf_split.ps1

PDFファイルを引数に指定することで、そのファイルを1ページごとにバラバラに分解できます。

```powershell
pdf_split.ps1 -filePath input.pdf [ -destPath destinationFolder ]
```

### Example

```powershell
pdf_split.ps1 .\test.pdf 
```

以下のように、保存先の指定もできます。

```powershell
pdf_split.ps1 .\test.pdf $home\Documents
```

## pdf_join.ps1

選択した複数のPDFファイルを、一つのファイルに結合することができます。
結合したファイルは、参照先のファイルとおなじフォルダに保存されます。ファイル名の末尾には```"_combine"```が追記されます。

```powershell
pdf_join.ps1 input1.pdf input2.pdf [ input3.pdf ... ]
```

### Example

```powershell
pdf_split.ps1 .\test1.pdf .\test2.pdf .\test3.pdf
```

※このコマンドは保存先を指定することができません。

# より便利な使い方

## ドラッグ & ドロップでPDFファイルを分割（結合）

```/lib/pdf_split.ps1``` を右クリックしてショートカットを作成し、```「リンク先」```を以下の内容に書き換えてください。
このショートカットにPDFファイルをドラッグ & ドロップすることで、簡単にファイルを分割して保存することができます。

```
powershell -NoProfile -ExecutionPolicy RemoteSigned -File pdf_split.ps1
```

```/lib/pdf_join.ps1``` も同様の方法で設定ができます。
このショートカットにPDFファイルを複数選択してドロップ & ドロップすることで、簡単にファイルを結合することができます。

```
powershell -NoProfile -ExecutionPolicy RemoteSigned -File pdf_join.ps1
```

