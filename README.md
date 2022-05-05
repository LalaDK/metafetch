# metafetch

Fetches SAML2 metadata URL, parses the XML and outputs SHA1 fingerprint, notBefore and notAfter attributes.

![Screenshot](https://github.com/LalaDK/metafetch/blob/16de0ddc5c06565215d39e43d05297d08f1a4a32/screenshot.png)

__Install__
```
git clone git@github.com:LalaDK/metafetch.git
cd metafetch
bundle install
./install.sh # So it can run anywhere
```

__Uninstall__
```
cd metafetch
./uninstall.sh
```
__Requirements__
The script requires Ruby >= 2.7 and OpenSSL. 
And of cause the gems listed in Gemfile, which gets installed by running 'bundle install'.
