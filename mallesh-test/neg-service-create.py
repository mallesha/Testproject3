import  json

device = "T02-ntsm-ci-ios38"
hostname = "localhost"
banner = "test123-banner"
x = {
  "hname-banner-rfs:hname-banner-rfs": [
    {
      "device": device,
      "hostname": hostname,
      "login-banner": banner
    }
  ]
}

#print(json.dumps(x))
#print(x['hname-banner-rfs:hname-banner-rfs'][0]['device'])

x['hname-banner-rfs:hname-banner-rfs'][0]['device'] = hostname

data=x['hname-banner-rfs:hname-banner-rfs'][0]['device']

''' The below if block check the invalid entry under the hostname parameter
Examples:
hostname emty
hostname too long more than 32 char length
hostname startes with -
hostname ends with -
hostname is localhost
hostname char range
'''
if not data:
  print("hostname format not supported")

elif ((data[0] == "-")
        or (data[-1] == "-")
        or (data == "localhost")
        or (len(data) > 32)
        ):
  print("hostname format not supported")

#print(x['hname-banner-rfs:hname-banner-rfs'][0]['device'])
#print (json.dumps(x))
