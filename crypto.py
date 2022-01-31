def hex2base64(hex_string):
    from base64 import b64encode
    return b64encode(bytes.fromhex(hex_string)).decode()

def xor(string_to_xor, string_to_xor_against):
    s1=string_to_xor
    s2=string_to_xor_against
    print(s1)
    print(s2)
    xord_list = "".join([chr(ord(a) ^ ord(b)) for a,b in zip(s1,s2)])
    print(xord_list)

def main():
    import sys
    command=sys.argv[1]
    if command == "hexdecode":
        result=hex2base64(sys.argv[2])
    if command == "xor":
        result=xor(sys.argv[2],sys.argv[3])

    print(result)
main()