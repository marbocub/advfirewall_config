What is this?
=============

Windows7標準「セキュリティが強化されたWindowsファイアウォール」の
outbound通信ルールを一括設定するバッチファイルです。
outbound通信の送信接続をブロックして、
許可されたアプリケーションのみ通信ができるようにします。
いくつかのアプリケーションルールがプリセットされています。

Requirements and Limitations
============================

「セキュリティが強化されたWindowsファイアウォール」が搭載されている
Windowsで動きます。Windows Vista以降なら大丈夫らしいです。

Usage
=====

「管理者として実行」します。
または「管理者として実行」しているコマンドプロンプトで下記を実行してください。

    advfirewall_config.bat

オプションはありません。
新しいアプリケーションルールはファイルを編集して追加します。

Uninstall
=========

「管理者として実行」しているコマンドロンプトで、下記を実行してください。
Windowsファイアウォールの設定が初期化されます。

	netsh advfirewall reset

Preset Application Rules
========================

inbound
-------

	Remote Desktop
	ftp(client)
	Xming

outbound
--------

	ICMP echo
	NetBIOS/SMB (private network only)
	Windows Update Service
	Windows Time Service
	Windows Spooler Service
	system32\telnet.exe
	system32\nslookup.exe
	system32\ftp.exe
	system32\mstsc.exe
	Internet Explorer
	Google Chrome
	Google Chrome canary
	Mozilla ThunderBird
	Pogoplug Backup
	VideoLan Client
	Janetter
	Pochitter
	WinSCP
	RealVNC
	Microsoft Security Essentials
	avast! Antivirus
	ESET SmartSecurity
	VirtualBox
	Xming XDMCP
	cygwin wget.exe
	cygwin ssh.exe
	cygwin scp.exe
	cygwin slogin.exe
	cygwin mosh.exe
	cygwin svn.exe
	cygwin git.exe
	Afxw Updater
	IDManager ftp (local subnet only)
	Secure Download Manager (Microsoft DreamSpark)
	auWifiConnectSvc / au_Wifi_Connect

License
=======

This tool is licensed under the GNU GPL v2.