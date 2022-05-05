#! /usr/bin/env ruby
require 'open-uri'
require 'nokogiri'
require 'open3'
require 'date'
require 'colorize'

URL = "https://adfs.billund.dk/FederationMetadata/2007-06/FederationMetadata.xml"

def format_to_pem(cert)
  cert.gsub!("\n", '')
 %{-----BEGIN CERTIFICATE-----
#{ cert.scan(/(?:.{64}|.+)/).join("\n") }
-----END CERTIFICATE-----}
end

namespaces = {
  'xmlns': 'urn:oasis:names:tc:SAML:2.0:metadata',
  'xsi': 'http://www.w3.org/2001/XMLSchema-instance',
  'fed': 'http://docs.oasis-open.org/wsfed/federation/200706'
}
doc= Nokogiri::XML URI.parse(URL).read

certs = {}
keydescriptors = doc.xpath("//ns:KeyDescriptor", 'ns' => 'urn:oasis:names:tc:SAML:2.0:metadata')

keydescriptors.each_with_index do |keydescriptor|
  cert = keydescriptor.xpath("ns:KeyInfo/ns:X509Data/ns:X509Certificate", 'ns'=>"http://www.w3.org/2000/09/xmldsig#").text
  pem = format_to_pem(cert)
  dates = Open3.capture2("openssl x509 -dates -noout", stdin_data: pem)[0]
  notBefore = dates.match(/(notBefore=)(.*)/)[2]
  notAfter = dates.match(/(notAfter=)(.*)/)[2]
  certs[cert] = {
    usage: keydescriptor['use'].to_s,
    pem: pem,
    short: "#{cert[0..32]}...#{cert[-32..-1]}",
    fingerprint: Open3.capture2("openssl x509 -fingerprint -noout", stdin_data: pem)[0].gsub('SHA1 Fingerprint=', ''),
    notBefore: DateTime.parse(notBefore),
    notAfter: DateTime.parse(notAfter)
  }
end

certs.each_with_index do |(full_cert, cert), index|
  valid = DateTime.now > cert[:notBefore] && DateTime.now < cert[:notAfter]
  puts "##{index + 1} #{ cert[:short] }".bold
  puts "\tFingerprint (SHA1): #{cert[:fingerprint]}"
  puts "\tnotBefore:          " + "#{cert[:notBefore].strftime('%d/%m-%Y %H:%M:%S')}".colorize(DateTime.now > cert[:notBefore] ? :green : :red)
  puts "\tnotAfter:           " + "#{cert[:notAfter].strftime('%d/%m-%Y %H:%M:%S')}".colorize(DateTime.now < cert[:notAfter] ? :green : :red)
  puts "\tUsage:              #{cert[:usage]}"
  puts "\tValid:              " + (valid ? "YES".colorize(:green) : "NO".colorize(:red))
  puts unless index + 1 == certs.length
end
