# metafetch

Fetches SAML2 metadata URL, parses the XML and outputs SHA1 fingerprint, notBefore and notAfter attributes.

** Install **
> git clone git@github.com:LalaDK/metafetch.git
> cd metafetch
> bundle install
> ./install.sh # So it can run anywhere

** Uninstall **
> cd metafetch
> ./uninstall.sh

** Requirements **
The script requires Ruby >= 2.7 and OpenSSL. And of cause the gems listed in Gemfile. 
