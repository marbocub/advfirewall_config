What is this?
=============

Windows7�W���u�Z�L�����e�B���������ꂽWindows�t�@�C�A�E�H�[���v��
outbound�ʐM���[�����ꊇ�ݒ肷��o�b�`�t�@�C���ł��B
outbound�ʐM�̑��M�ڑ����u���b�N���āA
�����ꂽ�A�v���P�[�V�����̂ݒʐM���ł���悤�ɂ��܂��B
�������̃A�v���P�[�V�������[�����v���Z�b�g����Ă��܂��B

Requirements and Limitations
============================

�u�Z�L�����e�B���������ꂽWindows�t�@�C�A�E�H�[���v�����ڂ���Ă���
Windows�œ����܂��BWindows Vista�ȍ~�Ȃ���v�炵���ł��B

Usage
=====

�u�Ǘ��҂Ƃ��Ď��s�v���܂��B
�܂��́u�Ǘ��҂Ƃ��Ď��s�v���Ă���R�}���h�v�����v�g�ŉ��L�����s���Ă��������B

    advfirewall_config.bat

�I�v�V�����͂���܂���B
�V�����A�v���P�[�V�������[���̓t�@�C����ҏW���Ēǉ����܂��B

Uninstall
=========

�u�Ǘ��҂Ƃ��Ď��s�v���Ă���R�}���h�����v�g�ŁA���L�����s���Ă��������B
Windows�t�@�C�A�E�H�[���̐ݒ肪����������܂��B

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