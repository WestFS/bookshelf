Script started on 2025-04-06 21:39:24-03:00 [TERM="xterm-256color" TTY="/dev/pts/0" COLUMNS="237" LINES="60"]
[?2004h]0;aluno@atacante: ~[;32m┌──([1;34maluno㉿atacante[;32m)-[[0;1m~[;32m]
[;32m└─[1;34m$[0m nmap -sv[K[K[K[K[K[K[K[K[7mnmap -sV --version-intensity 5 vendetudo.com[27m
[A[C[C[C[Cnmap -sV --version-intensity 5 vendetudo.com
[A
[?2004lStarting Nmap 7.94SVN ( https://nmap.org ) at 2025-04-06 21:39 -03
Nmap scan report for vendetudo.com (192.168.98.10)
Host is up (0.00033s latency).
rDNS record for 192.168.98.10: vulneravel.com
Not shown: 994 closed tcp ports (conn-refused)
PORT     STATE SERVICE        VERSION
21/tcp   open  ftp            vsftpd 3.0.3
22/tcp   open  ssh            OpenSSH 9.2p1 Debian 2+deb12u3 (protocol 2.0)
80/tcp   open  http           Apache httpd 2.4.61 ((Debian))
3389/tcp open  ms-wbt-server  xrdp
5001/tcp open  commplex-link?
5002/tcp open  rfe?
2 services unrecognized despite returning data. If you know the service/version, please submit the following fingerprints at https://nmap.org/cgi-bin/submit.cgi?new-service :
==============NEXT SERVICE FINGERPRINT (SUBMIT INDIVIDUALLY)==============
SF-Port5001-TCP:V=7.94SVN%I=5%D=4/6%Time=67F31EE3%P=x86_64-pc-linux-gnu%r(
SF:GetRequest,1B5,"HTTP/1\.1\x20200\x20OK\r\nServer:\x20Werkzeug/2\.2\.3\x
SF:20Python/3\.7\.16\r\nDate:\x20Mon,\x2007\x20Apr\x202025\x2000:40:03\x20
SF:GMT\r\nContent-Type:\x20application/json\r\nContent-Length:\x20271\r\nC
SF:onnection:\x20close\r\n\r\n{\x20\"message\":\x20\"VAmPI\x20the\x20Vulne
SF:rable\x20API\",\x20\"help\":\x20\"VAmPI\x20is\x20a\x20vulnerable\x20on\
SF:x20purpose\x20API\.\x20It\x20was\x20created\x20in\x20order\x20to\x20eva
SF:luate\x20the\x20efficiency\x20of\x20third\x20party\x20tools\x20in\x20id
SF:entifying\x20vulnerabilities\x20in\x20APIs\x20but\x20it\x20can\x20also\
SF:x20be\x20used\x20in\x20learning/teaching\x20purposes\.\",\x20\"vulnerab
SF:le\":0}")%r(HTTPOptions,C7,"HTTP/1\.1\x20200\x20OK\r\nServer:\x20Werkze
SF:ug/2\.2\.3\x20Python/3\.7\.16\r\nDate:\x20Mon,\x2007\x20Apr\x202025\x20
SF:00:40:03\x20GMT\r\nContent-Type:\x20text/html;\x20charset=utf-8\r\nAllo
SF:w:\x20OPTIONS,\x20GET,\x20HEAD\r\nContent-Length:\x200\r\nConnection:\x
SF:20close\r\n\r\n")%r(RTSPRequest,1F4,"<!DOCTYPE\x20HTML\x20PUBLIC\x20\"-
SF://W3C//DTD\x20HTML\x204\.01//EN\"\n\x20\x20\x20\x20\x20\x20\x20\x20\"ht
SF:tp://www\.w3\.org/TR/html4/strict\.dtd\">\n<html>\n\x20\x20\x20\x20<hea
SF:d>\n\x20\x20\x20\x20\x20\x20\x20\x20<meta\x20http-equiv=\"Content-Type\
SF:"\x20content=\"text/html;charset=utf-8\">\n\x20\x20\x20\x20\x20\x20\x20
SF:\x20<title>Error\x20response</title>\n\x20\x20\x20\x20</head>\n\x20\x20
SF:\x20\x20<body>\n\x20\x20\x20\x20\x20\x20\x20\x20<h1>Error\x20response</
SF:h1>\n\x20\x20\x20\x20\x20\x20\x20\x20<p>Error\x20code:\x20400</p>\n\x20
SF:\x20\x20\x20\x20\x20\x20\x20<p>Message:\x20Bad\x20request\x20version\x2
SF:0\('RTSP/1\.0'\)\.</p>\n\x20\x20\x20\x20\x20\x20\x20\x20<p>Error\x20cod
SF:e\x20explanation:\x20HTTPStatus\.BAD_REQUEST\x20-\x20Bad\x20request\x20
SF:syntax\x20or\x20unsupported\x20method\.</p>\n\x20\x20\x20\x20</body>\n<
SF:/html>\n")%r(Help,1EF,"<!DOCTYPE\x20HTML\x20PUBLIC\x20\"-//W3C//DTD\x20
SF:HTML\x204\.01//EN\"\n\x20\x20\x20\x20\x20\x20\x20\x20\"http://www\.w3\.
SF:org/TR/html4/strict\.dtd\">\n<html>\n\x20\x20\x20\x20<head>\n\x20\x20\x
SF:20\x20\x20\x20\x20\x20<meta\x20http-equiv=\"Content-Type\"\x20content=\
SF:"text/html;charset=utf-8\">\n\x20\x20\x20\x20\x20\x20\x20\x20<title>Err
SF:or\x20response</title>\n\x20\x20\x20\x20</head>\n\x20\x20\x20\x20<body>
SF:\n\x20\x20\x20\x20\x20\x20\x20\x20<h1>Error\x20response</h1>\n\x20\x20\
SF:x20\x20\x20\x20\x20\x20<p>Error\x20code:\x20400</p>\n\x20\x20\x20\x20\x
SF:20\x20\x20\x20<p>Message:\x20Bad\x20request\x20syntax\x20\('HELP'\)\.</
SF:p>\n\x20\x20\x20\x20\x20\x20\x20\x20<p>Error\x20code\x20explanation:\x2
SF:0HTTPStatus\.BAD_REQUEST\x20-\x20Bad\x20request\x20syntax\x20or\x20unsu
SF:pported\x20method\.</p>\n\x20\x20\x20\x20</body>\n</html>\n");
==============NEXT SERVICE FINGERPRINT (SUBMIT INDIVIDUALLY)==============
SF-Port5002-TCP:V=7.94SVN%I=5%D=4/6%Time=67F31EDE%P=x86_64-pc-linux-gnu%r(
SF:GetRequest,1B5,"HTTP/1\.1\x20200\x20OK\r\nServer:\x20Werkzeug/2\.2\.3\x
SF:20Python/3\.7\.16\r\nDate:\x20Mon,\x2007\x20Apr\x202025\x2000:39:58\x20
SF:GMT\r\nContent-Type:\x20application/json\r\nContent-Length:\x20271\r\nC
SF:onnection:\x20close\r\n\r\n{\x20\"message\":\x20\"VAmPI\x20the\x20Vulne
SF:rable\x20API\",\x20\"help\":\x20\"VAmPI\x20is\x20a\x20vulnerable\x20on\
SF:x20purpose\x20API\.\x20It\x20was\x20created\x20in\x20order\x20to\x20eva
SF:luate\x20the\x20efficiency\x20of\x20third\x20party\x20tools\x20in\x20id
SF:entifying\x20vulnerabilities\x20in\x20APIs\x20but\x20it\x20can\x20also\
SF:x20be\x20used\x20in\x20learning/teaching\x20purposes\.\",\x20\"vulnerab
SF:le\":1}")%r(HTTPOptions,C7,"HTTP/1\.1\x20200\x20OK\r\nServer:\x20Werkze
SF:ug/2\.2\.3\x20Python/3\.7\.16\r\nDate:\x20Mon,\x2007\x20Apr\x202025\x20
SF:00:39:58\x20GMT\r\nContent-Type:\x20text/html;\x20charset=utf-8\r\nAllo
SF:w:\x20OPTIONS,\x20HEAD,\x20GET\r\nContent-Length:\x200\r\nConnection:\x
SF:20close\r\n\r\n")%r(RTSPRequest,1F4,"<!DOCTYPE\x20HTML\x20PUBLIC\x20\"-
SF://W3C//DTD\x20HTML\x204\.01//EN\"\n\x20\x20\x20\x20\x20\x20\x20\x20\"ht
SF:tp://www\.w3\.org/TR/html4/strict\.dtd\">\n<html>\n\x20\x20\x20\x20<hea
SF:d>\n\x20\x20\x20\x20\x20\x20\x20\x20<meta\x20http-equiv=\"Content-Type\
SF:"\x20content=\"text/html;charset=utf-8\">\n\x20\x20\x20\x20\x20\x20\x20
SF:\x20<title>Error\x20response</title>\n\x20\x20\x20\x20</head>\n\x20\x20
SF:\x20\x20<body>\n\x20\x20\x20\x20\x20\x20\x20\x20<h1>Error\x20response</
SF:h1>\n\x20\x20\x20\x20\x20\x20\x20\x20<p>Error\x20code:\x20400</p>\n\x20
SF:\x20\x20\x20\x20\x20\x20\x20<p>Message:\x20Bad\x20request\x20version\x2
SF:0\('RTSP/1\.0'\)\.</p>\n\x20\x20\x20\x20\x20\x20\x20\x20<p>Error\x20cod
SF:e\x20explanation:\x20HTTPStatus\.BAD_REQUEST\x20-\x20Bad\x20request\x20
SF:syntax\x20or\x20unsupported\x20method\.</p>\n\x20\x20\x20\x20</body>\n<
SF:/html>\n")%r(Help,1EF,"<!DOCTYPE\x20HTML\x20PUBLIC\x20\"-//W3C//DTD\x20
SF:HTML\x204\.01//EN\"\n\x20\x20\x20\x20\x20\x20\x20\x20\"http://www\.w3\.
SF:org/TR/html4/strict\.dtd\">\n<html>\n\x20\x20\x20\x20<head>\n\x20\x20\x
SF:20\x20\x20\x20\x20\x20<meta\x20http-equiv=\"Content-Type\"\x20content=\
SF:"text/html;charset=utf-8\">\n\x20\x20\x20\x20\x20\x20\x20\x20<title>Err
SF:or\x20response</title>\n\x20\x20\x20\x20</head>\n\x20\x20\x20\x20<body>
SF:\n\x20\x20\x20\x20\x20\x20\x20\x20<h1>Error\x20response</h1>\n\x20\x20\
SF:x20\x20\x20\x20\x20\x20<p>Error\x20code:\x20400</p>\n\x20\x20\x20\x20\x
SF:20\x20\x20\x20<p>Message:\x20Bad\x20request\x20syntax\x20\('HELP'\)\.</
SF:p>\n\x20\x20\x20\x20\x20\x20\x20\x20<p>Error\x20code\x20explanation:\x2
SF:0HTTPStatus\.BAD_REQUEST\x20-\x20Bad\x20request\x20syntax\x20or\x20unsu
SF:pported\x20method\.</p>\n\x20\x20\x20\x20</body>\n</html>\n");
Service Info: OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 36.55 seconds

[?2004h]0;aluno@atacante: ~[;32m┌──([1;34maluno㉿atacante[;32m)-[[0;1m~[;32m]
[;32m└─[1;34m$[0m telnet vendetudo.com 21
[?2004lComando 'telnet' não encontrado, você quis dizer:
  comando 'ztelnet' do deb zssh
  comando 'telnetd' do deb inetutils-telnetd
Experimente: sudo apt install <deb name>

[?2004h]0;aluno@atacante: ~[;32m┌──([1;34maluno㉿atacante[;32m)-[[0;1m~[;32m]
[;32m└─[1;34m$[0m nc vendetudo.com 21
[?2004l220 (vsFTPd 3.0.3)
421 Timeout.

[?2004h]0;aluno@atacante: ~[;32m┌──([1;34maluno㉿atacante[;32m)-[[0;1m~[;32m]
[;32m└─[1;34m$[0m [K[;32m└─[1;34m$[0m [K[;32m└─[1;34m$[0m ss[K[Kftp 1[Kvendetudo.com
[?2004lConnected to vendetudo.com.
220 (vsFTPd 3.0.3)
Name (vendetudo.com:aluno): s ls
331 Please specify the password.
Password: 
530 Login incorrect.
ftp: Login failed
ftp> l