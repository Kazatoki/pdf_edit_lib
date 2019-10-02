# pdf_edit

# 環境

- Windows 10
- Powershell 5.0 以上

# Setup

## Install PDFtk

PDFtkをダウンロードし、インストールします。
https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/

## 環境変数を設定します。

```~/pdf_edit/bin``` と ```~/plugins/qpdf-9.0.1/bin``` を環境変数に追加します。
インストーラー ```~/setup/installer.vbs``` を起動することで設定が完了します。

上記のバッチファイルを実行することで、どこでも以下のコマンドが使用できるようになります。

- ```pdf_split.ps1``` : 指定したPDFファイルをページごとに、バラバラに分解します。
- ```pdf_join.ps1``` : 指定した複数のPDFファイルを、一つのファイルに結合します。
- ```pdf_unlock.ps1``` : 指定したPDFのパスワードを解除します。（要：パスワード入力）

上記手順による設定は、Powershellを使用しているときしか反映されません。
もし設定した環境変数を削除したい場合は、```~/setup/uninstaller.vbs``` を実行してください。

# 使い方

「コマンドラインを使う方法」と「ドラッグ&ドロップで実行する方法」（推奨）があります。

## コマンドラインを使う方法

### pdf_split.ps1

PDFファイルを引数に指定することで、そのファイルを1ページごとにバラバラに分解できます。

```powershell
pdf_split.ps1 -filePath input.pdf [ -destPath destinationFolder ]
```

#### Example

```powershell
pdf_split.ps1 .\test.pdf 
```

以下のように、保存先の指定もできます。

```powershell
pdf_split.ps1 .\test.pdf $home\Documents
```

### pdf_join.ps1

選択した複数のPDFファイルを、一つのファイルに結合することができます。
結合したファイルは、参照先のファイルとおなじフォルダに保存されます。ファイル名の末尾には```"_combine"```が追記されます。
また、出力されるPDFのページ順は、指定したファイル名の昇順となります。

```powershell
pdf_join.ps1 input1.pdf input2.pdf [ input3.pdf ... ]
```

#### Example

```powershell
pdf_split.ps1 .\test1.pdf .\test2.pdf .\test3.pdf
```

※このコマンドは保存先を指定することができません。

### pdf_unlock.ps1

PDFファイルを指定し、パスワードを入力することで、パスワードを解除することができます。

```powershell
pdf_unlock.ps1 -filePath input.pdf [ -destPath destinationFolder ]
```

#### Example

```powershell
pdf_split.ps1 .\test.pdf 
```

以下のように、保存先の指定もできます。

```powershell
pdf_split.ps1 .\test.pdf $home\Documents
```


## ドラッグ & ドロップでPDFファイルを分割（結合）

インストール時に作成されたショートカット（ ```~/pdf_split.ps1```, ```~/pdf_join.ps1```, ```~/pdf_unlock.ps1```）を使用します。

各ショートカットアイコンの上に、PDFファイルをドラッグ＆ドロップすることで、ファイルの分割（split）、結合(join)、パスワード解除(unlock)を実行できます。

ファイルの出力先は、ドラッグ&ドロップしたファイルと同じ場所に作成されます。

以上
