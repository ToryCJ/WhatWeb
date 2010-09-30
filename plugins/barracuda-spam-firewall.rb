##
# This file is part of WhatWeb and may be subject to
# redistribution and commercial restrictions. Please see the WhatWeb
# web site for more information on licensing and terms of use.
# http://www.morningstarsecurity.com/research/whatweb
##
Plugin.define "Barracuda-Spam-Firewall" do
author "Brendan Coles <bcoles@gmail.com>" # 2010-07-22
version "0.1"
description "The Barracuda Spam & Virus Firewall is an integrated hardware and software solution designed to protect your email server from spam, virus, spoofing, phishing and spyware attacks. - homepage: http://www.barracudanetworks.com/ns/products/spam_overview.php"

# 11 results for intitle:"Spam Firewall" inurl:"8000/cgi-bin/index.cgi" @ 2010-07-24
# http://www.hackersforcharity.org/ghdb/?function=detail&id=900
# About 1,002 Shodan results for Server:BarracudaHTTP @ 2010-07-24
examples %w|
spam4.barracuda.com/cgi-mod/index.cgi
12.185.109.35/cgi-bin/index.cgi
24.97.26.221/cgi-bin/index.cgi
66.102.48.16:8000/cgi-bin/index.cgi
67.137.191.69/cgi-bin/index.cgi
68.191.235.157/cgi-bin/index.cgi
71.42.144.35/cgi-bin/index.cgi
72.165.183.132/cgi-bin/index.cgi
170.158.98.20:8000/cgi-bin/index.cgi
200.43.15.234/cgi-bin/index.cgi
202.201.0.214:8000/cgi-bin/index.cgi
barracuda.pds.org:8000/cgi-bin/index.cgi
cuda.netpluscom.com:8000/cgi-bin/index.cgi
ehealthscreen.com/cgi-bin/index.cgi
mail.asiserve.net:8000/cgi-bin/index.cgi
spampolice.nijinet.ad.jp:8000/cgi-bin/index.cgi
|

matches [

{ :text=>'<title>Barracuda Spam & Virus Firewall: Welcome</title>' },
{ :text=>'<title>Barracuda Spam Firewall: Welcome</title><link rel="stylesheet" type="text/css" href="/barracuda.css">' },
{ :text=>'<tr><td valign=top width=680 bgcolor="#ffffff" nowrap><table summary ="Logo Row" cellspacing=0 cellpadding=0 border=0><tr><td><a href="http://www.barracudanetworks.com?track=asg" class=transbutton><img src="' },
{ :text=>'<a href="http://www.barracudanetworks.com?track=asg"><img src="/images/powered_by.gif" border=0' },

]

def passive
        m=[]

	# Barracuda Spam & Virus Firewall
        if @body =~ /<link rel="stylesheet" type="text\/css" href="\/barracuda.css\?v=[\d\.]+">/
                version=@body.scan(/<link rel="stylesheet" type="text\/css" href="\/barracuda.css\?v=([\d\.]+)">/)[0][0]
                m << {:version=>version }
        end

	# Barracuda Spam Firewall
        if @body =~ /<script language=javascript src="\/js_functions.[\d\.]+.js" type="text\/javascript"><\/script>/
                version=@body.scan(/<script language=javascript src="\/js_functions.([\d\.]+).js" type="text\/javascript"><\/script>/)[0][0]
                m << {:version=>version }
        end

	# <td align=left class=config_module valign=top><font size=-2 color=#aaaaaa>Serial #BAR-SF-56510<br>Firmware v3.3.03.053 <font color=#ffffff>
	# It seems only cuda.netpluscom.com:8000/cgi-bin/index.cgi uses this HTML
        if @body =~ /<td align=left class=config_module valign=top><font size=-2 color=#aaaaaa>Serial #[A-Z]+-[A-Z]+-[\d]+<br>Firmware v[\d\.]+ <font color=#ffffff>/
                version=@body.scan(/<td align=left class=config_module valign=top><font size=-2 color=#aaaaaa>Serial #[A-Z]+-[A-Z]+-[\d]+<br>Firmware v([\d\.]+) <font color=#ffffff>/)[0][0]
                m << {:version=>version }
	end

        m

end


end

