import argparse
import struct

parser = argparse.ArgumentParser(
                    prog='newschecksum',
                    description='checksums and trims news files')

parser.add_argument('filename')           # positional argument

args = parser.parse_args()

with open(args.filename, 'rb') as issue:
	chk = 0
	issue.seek(4)
	newslen = struct.unpack('<H', issue.read(2))[0]
	issue.seek(0)
	newsdata = bytearray(issue.read(newslen+6))
	#last_nonzero_byte = 1
	#curbyte = 0
	for data in newsdata[6:]:
		#print(struct.unpack('B', data[0:1])[0])
		chk += data#struct.unpack('B', data[0:1])[0]#data[0]
		#if data != b'\x00':
		#	last_nonzero_byte = curbyte
		#data = issue.read(1)
		#curbyte += 1
		
	issue.seek(0x2000)
	newsdesc = issue.read(1)
	newsdescstr = b""
	while newsdesc != b'\x00':
		newsdescstr += newsdesc
		newsdesc = issue.read(1)

#chk %= 0x10000
#newsdata[2] = (chk % 0x100).to_bytes(1)
#newsdata[3] = (chk >> 8).to_bytes(1)

#with open(args.filename, 'r+b') as issue:
#	issue.seek(2)
#	issue.write(chk.to_bytes(2, 'little'))

#with open(args.filename, 'a') as issue:
#	issue.truncate(last_nonzero_byte+6)

struct.pack_into("<H", newsdata, 2, chk % 0x10000)
#struct.pack_into("<H", data, 4, len(news_data) % 65536)
	
with open(args.filename, 'wb') as issue:
	issue.write(newsdata)
	
with open("%s.message" % args.filename, 'wb') as issuemessage:
	issuemessage.write(newsdescstr)
	