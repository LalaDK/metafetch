# metafetch

Fetches SAML2 metadata URL, parses the XML and outputs SHA1 fingerprint, notBefore and notAfter attributes.

![Screenshot](https://github.com/LalaDK/metafetch/blob/c1ab893149f5d54d8e3f661a3a78a2990279b473/screenshot.png)

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
